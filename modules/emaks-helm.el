(require 'emaks-projectile)
(require 'helm)
(require 'helm-config)
(require 'helm-projectile)
(require 'helm-ag)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-buffer-max-length                40
      helm-buffers-truncate-lines           t
      helm-display-header-line              nil
      helm-ff-search-library-in-sexp        t
      helm-ff-skip-boring-files             t
      helm-imenu-fuzzy-match                t
      helm-move-to-line-cycle-in-source     t
      helm-M-x-fuzzy-match                  t
      helm-recentf-fuzzy-match              t
      helm-scroll-amount                    8
      helm-semantic-fuzzy-match             t
      helm-boring-buffer-regexp-list        '("^diary$" "\\*Minibuf.+\\*$"
                                              "\\*helm.+\\*$" "\\*Echo Area.+\\*$"
                                              "\\*code-conversion.+\\*$"
                                              "\\*which-key\\*$")
      helm-white-buffer-regexp-list         '("*magit")
      helm-boring-file-regexp-list          '("\\.git$" "~$" "^#.*#$"
                                              "\\.$" "\\.\\.$"))

(setq projectile-completion-system     'helm
      projectile-switch-project-action 'helm-projectile)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "s-V")     'helm-show-kill-ring)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-c C-f") 'helm-projectile-find-file)
(global-set-key (kbd "s-f")     'helm-projectile-ag)

(helm-mode 1)
(helm-projectile-on)

(provide 'emaks-helm)
