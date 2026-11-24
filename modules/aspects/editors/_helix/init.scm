(require "dugtrio/dugtrio.scm")
(require "helix-file-watcher/file-watcher.scm")
(require "math-hx/math.scm")

;; reload open buffers when they change on disk
(spawn-watcher)
