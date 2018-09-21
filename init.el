(setq load-prefer-newer t)

(defvar emaks-dir (file-name-directory load-file-name)
  "Root directory of Erik Maki's Emacs configuration.")
(defvar emaks-core-dir (expand-file-name "core" emaks-dir)
  "Core functionality.")
(defvar emaks-modules-dir (expand-file-name "modules" emaks-dir)
  "Contains installed modules.")
(defvar emaks-savefile-dir (expand-file-name "savefile" emaks-dir)
  "Holds the automatically save and history files.")
(defvar emaks-modules-file (expand-file-name "emaks-modules.el" emaks-dir)
  "Contains a list of modules that will be loaded.")


(unless (file-exists-p emaks-savefile-dir)
  make-directory emaks-savefile-dir)

;; Add directories to `load-path'
(add-to-list 'load-path emaks-core-dir)
(add-to-list 'load-path emaks-modules-dir)

;; Reduce garbage collection frequency by starting at 50MB of
;; allocated data (the default is at 0.76MB)
(setq gc-cons-threshold 50000000)

;; Warn when opening files larger than 100MB
(setq large-file-warning-threshold 100000000)

;; Configuration changes made through the UI are stored here
(setq custom-file (expand-file-name "emaks-custom.el" emaks-core-dir))

(message "Loading Emaks' core...")

(require 'emaks-packages)
(require 'emaks-custom)
(require 'emaks-ui)
(require 'emaks-core)
(require 'emaks-editor)
(require 'emaks-global-keybindings)

;; ;; macOS specific settings
;; (when (eq system-type 'darwin)
;;   (require 'emaks-macos))

(when (file-exists-p emaks-modules-file)
  (message "Loading modules in %s..." emaks-modules-dir)
  (load emaks-modules-file))

;; (emaks-eval-after-init
;;  ;; greet the use with some useful tip
;;  (run-at-time 5 nil 'tip-of-the-day))

(menu-bar-mode 1)
