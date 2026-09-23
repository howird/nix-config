-- Pomodoro bar widget backed by the `uair` daemon.
--
-- uair 0.6.3's `uairctl listen` only ever emits the format configured in
-- uair.toml (its documented `--override` flag is a no-op), so streaming it
-- would couple this widget to that file. `uairctl fetch <format>` takes the
-- format as an argument, so we poll it instead -- which is also what the
-- waybar modules this replaces did.

local FORMAT =
  '{"state":"{state}","name":"{name}","time":"{time}","percent":{percent}}'

local last = nil
local interval = nil

local function setting(key, fallback)
  local value = noctalia.getConfig(key)
  if value == nil or value == "" then
    return fallback
  end
  return value
end

local function uairctl()
  return setting("uairctl", "uairctl")
end

-- `uairctl` is a bare command name from settings, so single-quoting the format
-- is enough to keep the JSON braces away from the shell.
local function run(args, cb)
  return noctalia.runAsync(uairctl() .. " " .. args, cb)
end

-- uair renders {time} with time_format = "%M:%S" (modules/aspects/_life/uair.nix),
-- so a single-digit minute arrives zero-padded ("09:54"). The bar label reads as a
-- sentence, so the padding goes; the tooltip keeps uair's own string.
local function trimPad(time)
  return (time:gsub("^0(%d)", "%1"))
end

-- Seconds left, parsed from uair's {time}. HH:MM:SS is handled too in case a
-- session outgrows an hour.
local function secondsLeft(time)
  local hours, mins, secs = time:match("^(%d+):(%d+):(%d+)$")
  if hours == nil then
    hours = "0"
    mins, secs = time:match("^(%d+):(%d+)$")
  end
  if mins == nil then
    return nil
  end
  return tonumber(hours) * 3600 + tonumber(mins) * 60 + tonumber(secs)
end

-- The countdown for {minutes}/{min_unit}: minutes rounded to nearest rather
-- than truncated (9:45 is "10 more mins", 9:20 is "9"), dropping to seconds
-- for the last minute so it never reads "1 more min" at 0:05.
local function countdown(time)
  local total = secondsLeft(time)
  if total == nil then
    return nil, nil
  end
  if total < 60 then
    return total, total == 1 and "sec" or "secs"
  end
  local mins = math.floor((total + 30) / 60)
  return mins, mins == 1 and "min" or "mins"
end

local function render(template, data)
  local count, unit = countdown(data.time)

  -- `%w` alone would not match the underscore in {min_unit}. gsub with a table
  -- leaves an unknown {placeholder} untouched rather than silently blanking it,
  -- which makes a typo in the format visible on the bar.
  local text = template:gsub("{([%w_]+)}", {
    name = data.name,
    time = trimPad(data.time),
    -- Unparseable time leaves both minute fields alone rather than printing
    -- "nil more mins" -- the raw {time} is still there to fall back on.
    minutes = count ~= nil and tostring(count) or nil,
    min_unit = unit,
  })
  return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function paint(data)
  local running = data.state == "resumed"

  -- A render() tree rather than setText/setGlyph: the built-in row always puts
  -- the glyph first, and the label reads as the end of a sentence with the
  -- play/pause glyph trailing it.
  local container = barWidget.isVertical() and ui.column or ui.row
  barWidget.render(container({gap = 6, align = "center"}, {
    ui.label({text = render(setting("label_format", "{name} {time}"), data)}),
    ui.glyph({
      name = running and setting("glyph_running", "player-play")
        or setting("glyph_paused", "player-pause"),
      color = running and "primary" or "on_surface_variant",
    }),
  }))

  barWidget.setTooltip({
    {key = "Session", value = data.name},
    {key = "Remaining", value = data.time},
    {key = "Progress", value = tostring(data.percent) .. "%"},
    {key = "State", value = data.state},
  })
  barWidget.setVisible(true)
end

local function poll()
  run("fetch '" .. FORMAT .. "'", function(result)
    -- uair not running: hide rather than showing a stale countdown.
    if result.exitCode ~= 0 then
      last = nil
      barWidget.setVisible(false)
      return
    end

    local ok, data = pcall(noctalia.json.decode, result.stdout)
    if not ok or type(data) ~= "table" or data.time == nil then
      return
    end

    last = data
    paint(data)
  end)
end

function update()
  local wanted = setting("interval_ms", 1000)
  if wanted ~= interval then
    interval = wanted
    noctalia.setUpdateInterval(wanted)
  end
  poll()
end

-- Same three gestures the waybar modules bound.
function onClick()
  run("toggle")
end

function onMiddleClick()
  run("finish")
end

function onRightClick()
  if last == nil then
    noctalia.notify("uair", "Timer is not running")
    return
  end
  noctalia.notify(
    "🍅 " .. last.name,
    last.time .. " left, you got this!"
  )
end

-- Jump between sessions without opening a terminal.
function onScroll(_axis, steps, _startsGesture)
  run(steps < 0 and "prev" or "next")
end
