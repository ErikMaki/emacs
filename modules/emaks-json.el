(require 'json-mode)
(eval-after-load "json-mode"
  '(progn
     ;; Add an alternative local binding for the command
     ;; bound to M-o
     (define-key json-mode-map (kbd "C-c C-a")
       (lookup-key json-mode-map (kbd "C-c C-f")))
     ;; Unbind M-o from the local keymap
     (define-key json-mode-map (kbd "C-c C-f") nil)))

(provide 'emaks-json)
