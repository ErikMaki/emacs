(require 'projectile)
(require 'projectile-rails)
(setq projectile-cache-file (expand-file-name  "projectile.cache" emaks-savefile-dir))

(setq projectile-project-search-path '("~/workspace/" "~/.emacs.d/")   ;; Workspace repos
      projectile-switch-project-action 'projectile-dired) ;; Open on select

(projectile-rails-global-mode)
(projectile-mode)

(provide 'emaks-projectile)
