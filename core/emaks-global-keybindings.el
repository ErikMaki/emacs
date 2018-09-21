(global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
(global-set-key (kbd "C-c t") 'crux-visit-term-buffer)
(global-set-key (kbd "C-x C-u") 'crux-upcase-region)
(global-set-key (kbd "C-x C-l") 'crux-upcase-region)
(global-set-key (kbd "C-x M-c") 'crux-upcase-region)
(global-set-key (kbd "<C-tab>") 'other-window)

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'emaks-global-keybindings)
