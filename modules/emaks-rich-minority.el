(require 'rich-minority)
(rich-minority-mode 1)
(setq rm-blacklist
      (format "^ \\(%s\\)$"
              (mapconcat #'identity
                         '("Fly.*" "Projectile.*" "PgLn" "Rails"
                           "ElDoc" "WK" "EditorConfig" "(\\*)")
                         "\\|")))

(provide 'emaks-rich-minority)
