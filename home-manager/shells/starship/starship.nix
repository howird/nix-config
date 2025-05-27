{lib, ...}: {
  programs.starship.settings = let
    icon-fmt = c: s: "[](fg:${c})[${s}](fg:black bg:${c})"; # [](fg:${c} bg:black)
    txt-fmt = txt: "[${txt}](fg:white bg:black)[](fg:black)";
    icon-txt-fmt = c: s: txt: "${icon-fmt c s}${txt-fmt txt}";

    lang-fmt = c: s: {
      symbol = s;
      format = icon-txt-fmt c "$symbol" " $version";
    };
    lang-env-fmt = c: s: env: {
      symbol = s;
      format = icon-txt-fmt c "$symbol" env;
    };
  in {
    format = "$directory[─](fg:bright-black)$git_branch$git_status ";
    right_format = "$status$cmd_duration$battery$time[─](fg:bright-black)$all$os$username$hostname";
    add_newline = false;
    line_break.disabled = true;
    profiles.transient = "$character";

    character = {
      format = "[╰─$symbol](fg:bright-black) ";
      success_symbol = "[](fg:bold white)";
      error_symbol = "[×](fg:bold red)";
      disabled = true;
    };

    fill = {
      symbol = "─";
      style = "fg:bright-black";
    };

    status = {
      symbol = " ";
      format = icon-txt-fmt "#E23140" "$symbol" " $status";
      pipestatus = true;
      pipestatus_separator = "-";
      pipestatus_segment_format = "$status";
      pipestatus_format = icon-txt-fmt "#E23140" "$symbol" " $pipestatus";
      disabled = false;
    };

    directory = {
      format = icon-txt-fmt "brown" "󰷏 " " $read_only$truncation_symbol$path";
      home_symbol = " ~/";
      truncation_symbol = " ../";
      truncation_length = 3;
      read_only = "󱧵 ";
      read_only_style = "";
      substitutions = {
        "Desktop" = " ";
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Pictures" = " ";
        "Videos" = " ";
        "dev" = "󰲋 ";
        "robo" = " ";
        "config" = " ";
      };
    };

    git_branch.symbol = " ";
    git_branch.format = ''${icon-fmt "green" "$symbol"}[ $branch](fg:white bg:black)'';
    git_commit.tag_symbol = "  ";
    git_status = {
      format = txt-fmt " $all_status";
      conflicted = " =";
      up_to_date = "";
      untracked = "  $count";
      stashed = "  $count";
      modified = "  $count";
      staged = "  $count";
      renamed = "  $count";
      deleted = " ✘ $count";
      ahead = "  $count";
      diverged = " 󰹹⇡$ahead_count⇣$behind_count";
      behind = "  $count";
    };

    battery = {
      format = icon-txt-fmt "yellow" "$symbol" " $percentage";
      display = [
        {
          threshold = 25;
          style = "bold yellow";
        }
        {
          threshold = 10;
          style = "bold red";
        }
      ];
    };

    cmd_duration = {
      min_time = 500;
      format = icon-txt-fmt "orange" " " " $duration";
    };

    time = {
      format = icon-txt-fmt "magenta" "󰦖 " " $time";
      time_format = "%I:%M %p";
      disabled = true;
    };

    os = {
      format = icon-fmt "red" "$symbol";
      disabled = false;
      symbols = {
        Linux = " ";
        Macos = " ";
        NixOS = " ";
        Ubuntu = " ";
        Windows = "󰍲 ";
        Unknown = " ";
      };
    };

    username = {
      format = "[ $user](fg:white bg:black)";
      show_always = true;
    };

    hostname = {
      format = txt-fmt "@$hostname$ssh_symbol";
      ssh_symbol = "  ";
      ssh_only = false;
    };

    aws = lang-fmt "orange" "  ";
    buf = lang-fmt "blue" " ";
    bun = lang-fmt "cyan" " ";
    c = lang-fmt "blue" " ";
    cmake = lang-fmt "red" " ";
    conda = lang-fmt "green" " ";
    cpp = lang-fmt "blue" " ";
    crystal = lang-fmt "cyan" " ";
    dart = lang-fmt "blue" " ";
    deno = lang-fmt "green" " ";
    docker_context = lang-fmt "blue" " ";
    elixir = lang-fmt "magenta" " ";
    elm = lang-fmt "blue" " ";
    fennel = lang-fmt "brown" " ";
    fossil_branch = lang-fmt "green" " ";
    gcloud = lang-fmt "blue" "  ";
    golang = lang-fmt "blue" " ";
    gradle = lang-fmt "green" " ";
    guix_shell = lang-fmt "blue" " ";
    haskell = lang-fmt "blue" " ";
    haxe = lang-fmt "orange" " ";
    hg_branch = lang-fmt "green" " ";
    java = lang-fmt "brown" " ";
    julia = lang-fmt "purple" " ";
    kotlin = lang-fmt "orange" " ";
    lua = lang-fmt "blue" " ";
    memory_usage = lang-fmt "blue" "󰍛 ";
    meson = lang-fmt "green" "󰔷 ";
    nim = lang-fmt "yellow" "󰆥 ";
    nix_shell = lang-env-fmt "blue" " " " $state (\\($name\\))";
    nodejs = lang-fmt "green" " ";
    ocaml = lang-fmt "orange" " ";
    package = lang-fmt "green" "󰏗 ";
    perl = lang-fmt "blue" " ";
    php = lang-fmt "blue" " ";
    pijul_channel = lang-fmt "green" " ";
    pixi = lang-fmt "yellow" "󰏗 ";
    python = lang-env-fmt "yellow" " " " $version (\\($virtualenv\\))";
    rlang = lang-fmt "blue" "󰟔 ";
    ruby = lang-fmt "red" " ";
    rust = lang-fmt "orange" "󱘗 ";
    scala = lang-fmt "red" " ";
    swift = lang-fmt "orange" " ";
    zig = lang-fmt "orange" " ";

    palette = lib.mkDefault "catppuccin_mocha";
    palettes.catppuccin_mocha = {
      white = "#D9E0EE"; # text
      black = "#2E2E3E"; # mantle
      bright-black = "#585B70"; # surface2
      red = "#F38BA8"; # red
      orange = "#F9AF74"; # orange
      yellow = "#F9E2AF"; # yellow
      green = "#A6E3A1"; # green
      blue = "#8AADF4"; # blue
      magenta = "#CBA6F7"; # purple
      brown = "#F5BDE6"; # pink
    };
  };
}
