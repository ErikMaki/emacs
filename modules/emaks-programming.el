;; font-lock annotations like TODO in source code
(require 'hl-todo)
(global-hl-todo-mode 1)
(setq hl-todo-keyword-faces
      '(("TODO" . (:foreground "#ff39a3" :weight bold))))

;; smart curly braces
(sp-pair "{" nil :post-handlers
         '(((lambda (&rest _ignored)
              (crux-smart-open-line-above)) "RET")))

(smartparens-mode +1)

(add-to-list 'exec-path "/usr/local/bin/")

(provide 'emaks-programming)
