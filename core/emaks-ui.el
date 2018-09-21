;; Tool bar only adds clutter
(tool-bar-mode -1)

;; Don't blink cursor
(blink-cursor-mode -1)

;; Disable bell ring
(setq ring-bell-function 'ignore)

;; disable startup screen
(setq inhibit-startup-screen t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Use Zenburn theme
(load-theme 'zenburn t)

;; Show cursor when scrolling dramatically
(require 'beacon)
(beacon-mode +1)

;; Show available keybindings while typing
(require 'which-key)
(which-key-mode +1)

(provide 'emaks-ui)
