# Interactively fetch web articles via percollate, let you edit the markdown,
# then build a clean multi-chapter epub via pandoc.

const default_css = r#'
body { font-family: Georgia, 'Times New Roman', serif; line-height: 1.5; }
h1, h2 { font-family: Helvetica, Arial, sans-serif; }
figure { display: block; margin: 1.5em auto; text-align: center; }
figure img { display: block; max-width: 100%; margin: 0 auto; }
figcaption {
  font-family: Helvetica, Arial, sans-serif;
  font-size: 0.85em;
  font-style: italic;
  color: #555;
  text-align: center;
  margin-top: 0.5em;
}
'#

# A linked image `[![alt](src)](href)` or a plain one `![alt](src)`.
const image_re = '\[!\[[^\]]*\]\([^)]*\)\]\([^)]*\)|!\[[^\]]*\]\([^)]*\)'

# Prompt until a blank line, returning the entries.
def ask-list [prompt: string] {
  mut items = []
  loop {
    let item = input $prompt
    if ($item | is-empty) { break }
    $items = $items | append $item
  }
  $items
}

# Force every image onto its own paragraph, so pandoc's implicit-figures
# extension turns it into a <figure>/<figcaption> instead of leaving it
# inline with whatever prose shared its paragraph in the source HTML. Any
# text trailing the image within that same paragraph becomes the caption
# (replacing its alt text) rather than a separate, duplicated paragraph.
#
# Splits on blank lines rather than working line-by-line: --inline embeds
# images as huge base64 data URIs, and the markdown serializer soft-wraps a
# line after those without a blank line, so "same line" is not a reliable
# signal for "same paragraph" once --inline is in play.
def figure-images []: string -> string {
  split row -r '\n(?:[ \t]*\n)+'
  | each { str replace -a "\n" " " | str trim }
  | where $it != ""
  | each {|para|
    let m = $para | parse -r ('^(?<pre>.*?)(?<img>' + $image_re + ')(?<post>.*)$')
    if ($m | is-empty) { return $para }
    let m = $m.0
    let img = $m.img | parse -r '^\[?!\[(?<alt>[^\]]*)\]\((?<src>[^)]*)\)' | first
    let post = $m.post | str trim
    let caption = if ($post | is-empty) { $img.alt } else { $post }
    [($m.pre | str trim) ("![" + $caption + "](" + $img.src + ")")] | where $it != "" | str join "\n\n"
  }
  | str join "\n\n"
  | $in + "\n"
}

# Heading level to make chapters of: a lone top-level heading is usually
# just the article title, not a chapter marker, so use the next level down.
def chapter-level [md: string] {
  let counts = open --raw $md | lines | parse -r '^(?<h>#+)' | get h | each { str length }
    | uniq --count | sort-by value
  print "Headings found in document:"
  if ($counts | is-empty) {
    print "  (none)"
    return 2
  }
  for c in $counts { print $"  ($c.count) level-($c.value) heading\(s)" }
  if ($counts | length) >= 2 and $counts.0.count == 1 { $counts.1.value } else { $counts.0.value }
}

def build [workdir: string, css: string] {
  let urls = ask-list "  url: "
  if ($urls | is-empty) { error make --unspanned {msg: "No URL given, aborting."} }

  let md = $workdir | path join article.md
  print "Fetching article(s)..."
  ^percollate md -o $md --no-toc --inline ...$urls
  open --raw $md | figure-images | save -f $md

  let editor = $env.VISUAL? | default $env.EDITOR? | default nano
  print $"Opening in ($editor). Edit the article, then save and quit to continue."
  ^$editor $md

  let default_shift = 1 - (chapter-level $md)
  let shift_by = input $"Shift heading levels by [($default_shift)]: "
  let shift_by = if ($shift_by | is-empty) { $default_shift } else { $shift_by }

  print ""
  let title = input "Title: "
  print "Author name(s). Enter one at a time, blank line to finish."
  let authors = ask-list "  author: " | each { $"author=($in)" }
  print "Add any other epub metadata as key=value (e.g. date=2026-07-12, language=en)."
  print "Leave blank and press enter to finish."
  let metadata = [$"title=($title)" ...$authors ...(ask-list "  metadata: ")]
    | each {|kv| [--metadata $kv] } | flatten

  let slug = $title | str lowercase | str replace -ar '[^a-z0-9]+' '-' | str trim -c '-'
  let default_out = $env.PWD | path join $"(if ($slug | is-empty) { 'article' } else { $slug }).epub"
  let out = input $"Save epub as [($default_out)]: "
  let out = if ($out | is-empty) { $default_out } else { $out | path expand }
  let out = if ($out | str ends-with ".epub") { $out } else { $"($out).epub" }

  let css = if ($css | is-empty) {
    let path = $workdir | path join style.css
    $default_css | save $path
    $path
  } else {
    $css
  }

  # Build in the workdir so a failed run doesn't leave a partial epub behind.
  let epub = $workdir | path join out.epub
  ^pandoc $md -o $epub --toc --split-level=1 $"--shift-heading-level-by=($shift_by)" $"--css=($css)" ...$metadata
  mkdir ($out | path dirname)
  cp $epub $out
  print $"Saved: ($out)"
}

# Build an epub from one or more web articles.
def main [
  css?: path # custom stylesheet; a built-in default is used otherwise
] {
  for cmd in [percollate pandoc] {
    if (which $cmd | is-empty) { error make --unspanned {msg: $"($cmd) not found in PATH"} }
  }
  let workdir = mktemp -d
  try {
    build $workdir ($css | default "")
  } catch {|err|
    rm -rf $workdir
    print -e $err.rendered
    exit 1
  }
  rm -rf $workdir
}
