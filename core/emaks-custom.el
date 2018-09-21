(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(json-reformat:indent-width 2)
 '(json-reformat:pretty-string\? t)
 '(package-selected-packages
   (quote
    (markdown-mode ace-window ack helm-ag-r helm-ack ag rbenv hl-todo zenburn-theme yaml-mode which-key smartparens smart-tab smart-mode-line rspec-mode projectile-rails magit json-mode helm-rails helm-projectile helm-ag gitignore-mode gitconfig-mode exec-path-from-shell dockerfile-mode csv-mode crux browse-kill-ring better-defaults beacon))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "grey40"))))
 '(region ((t (:background "selectedTextBackgroundColor" :foreground "selectedTextColor"))))
 '(show-paren-match ((t (:background "forest green" :foreground "white"))))
 '(show-paren-mismatch ((t (:background "red" :foreground "white" :weight bold)))))


(defcustom emaks-indent-sensitive-modes
  '(conf-mode coffee-mode haml-mode python-mode slim-mode yaml-mode)
  "Modes for which auto-indenting is suppressed."
  :type 'list
  :group 'emaks)

(defcustom emaks-yank-indent-modes '(LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped).
Only modes that don't derive from `prog-mode' should be listed here."
  :type 'list
  :group 'emaks)

(defcustom emaks-yank-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur."
  :type 'number
  :group 'emaks)

(provide 'emaks-custom)
