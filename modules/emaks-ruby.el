(require 'emaks-programming)
(require 'ruby-mode)
(require 'rspec-mode)
(require 'inf-ruby)

(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-hook 'ruby-mode 'imenu-add-menubar-index)


(inf-ruby-minor-mode +1)

(add-hook 'dired-mode-hook 'rspec-dired-mode)
;; Allows use of byebug. Hit C-x C-q to enable inf-ruby
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
;; (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)
;; (add-hook 'compilation-finish-functions
;;           (lambda (buf strg)
;;             (switch-to-buffer "*rspec-compilation*")
;;             (goto-char (point-max))
;;             (local-set-key (kbd "q")
;;                            (lambda () (interactive) (quit-restore-window)))))

;;------------------------------------------------------------------------------
;; Jump to Definition in Ruby
;;------------------------------------------------------------------------------
;;(require 'robe nil t)
;;(require 'smart-jump)

;;(defun smart-jump-ruby-robe-available-p ()
;;  "Return whether or not `robe' is available."
;;  (bound-and-true-p robe-mode))

;;(defun smart-jump-ruby-mode-register ()
;;  "Register `smart-jump' for `ruby-mode'."
;;  (smart-jump-register :modes 'robe-mode
;;                       :jump-fn 'robe-jump
;;                       :refs-fn 'smart-jump-simple-find-references
;;                       :should-jump #'smart-jump-ruby-robe-available-p))


(provide 'emaks-ruby)
