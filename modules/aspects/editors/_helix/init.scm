(require "helix/keymaps.scm")

(require "oil/oil.scm")
(require "helix-file-watcher/file-watcher.scm")
(require "math-hx/math.scm")

;; show dotfiles, hide git-ignored
(oil-configure! #true #false)

;; reload open buffers when they change on disk
(spawn-watcher)

;; oil.nvim-style navigation inside the oil buffer; `-`/`_` open it (see binds.nix)
(keymap (buffer OIL-BUFFER-NAME (inherit-from (deep-copy-global-keybindings)))
        (normal (ret ":oil-enter")
                (- ":oil-up")
                (_ ":oil-root")
                (C-s ":oil-save")
                (C-l ":oil-refresh")
                (q ":oil-close")
                (g ("." ":oil-toggle-hidden")
                   (i ":oil-toggle-git-ignored"))))
