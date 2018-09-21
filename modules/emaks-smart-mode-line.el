(sml/setup)
;; Abbreviations for paths displayed
(add-to-list 'sml/replacer-regexp-list
             '("~/workspace/" ":Work:") t)
(add-to-list 'sml/replacer-regexp-list
             '("^:Work:wam/exception-retry-service" ":ERTS:") t)
(add-to-list 'sml/replacer-regexp-list
             '("^:Work:drx/broker-activity-parsing-service" ":BAPS:") t)

(provide 'emaks-smart-mode-line)
