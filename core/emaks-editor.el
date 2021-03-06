;;------------------------------------------------------------------------------
;; Default frame size
;;------------------------------------------------------------------------------
(add-to-list 'default-frame-alist '(height . 53))
(add-to-list 'default-frame-alist '(width . 98))

;;------------------------------------------------------------------------------
;; Open files in the same frame
;;------------------------------------------------------------------------------
(setq ns-pop-up-frames nil)

;;------------------------------------------------------------------------------
;; Use line numbers
;;------------------------------------------------------------------------------
(global-linum-mode)

;;------------------------------------------------------------------------------
;; Better Emacs defaults
;;------------------------------------------------------------------------------
(require 'better-defaults)

;;------------------------------------------------------------------------------
;; Don't use tabs, but keep everything neat
;;------------------------------------------------------------------------------
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;;------------------------------------------------------------------------------
;; Delete the selection with a keypress
;;------------------------------------------------------------------------------
(delete-selection-mode t)

;;------------------------------------------------------------------------------
;; Make backup to a designated directory, mirroring the full path
;;------------------------------------------------------------------------------
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir "~/.emacs.d/emacs-backup/")
         ;; remove Windows driver letter in path, for example, “C:”
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath ))
         (backupFilePath
          (replace-regexp-in-string "//" "/"
                                    (concat backupRootDir filePath "~"))))
    (make-directory (file-name-directory backupFilePath)
                    (file-name-directory backupFilePath))
    backupFilePath))

(setq make-backup-file-name-function 'my-backup-file-name)

;;------------------------------------------------------------------------------
;; Autosave the undo-tree history
;;------------------------------------------------------------------------------
(setq undo-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq undo-tree-auto-save-history t)

;;------------------------------------------------------------------------------
;; Revert buffers when underlying files are changed externally
;;------------------------------------------------------------------------------
(global-auto-revert-mode t)

;;------------------------------------------------------------------------------
;; Smart Tab behavior - indent or complete
;;------------------------------------------------------------------------------
(setq tab-always-indent 'complete)

;;------------------------------------------------------------------------------
;; Smart pairing for all
;;------------------------------------------------------------------------------
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)

;;------------------------------------------------------------------------------
;; Minibuffer
;;------------------------------------------------------------------------------
(setq
 enable-recursive-minibuffers nil      ;;  don't allow mb cmds in the mb
 max-mini-window-height 4              ;;  max 4 lines
 minibuffer-scroll-window t            ;;  C-M-v scrolls....
 resize-mini-windows t)

(icomplete-mode t)                     ;; completion in minibuffer
(setq
 icomplete-prospects-height 2          ;; don't spam my minibuffer
 icomplete-compute-delay 0)            ;; don't wait

;;------------------------------------------------------------------------------
;; toggle-window-split
;;------------------------------------------------------------------------------
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x t") 'toggle-window-split)

;;------------------------------------------------------------------------------
;; display-buffer
;;------------------------------------------------------------------------------
;; The default behaviour of `display-buffer' is to always create a new
;; window. As I normally use a large display sporting a number of
;; side-by-side windows, this is a bit obnoxious.
;;
;; The code below will make Emacs reuse existing windows, with the
;; exception that if have a single window open in a large display, it
;; will be split horisontally.

;; (setq pop-up-windows nil)

;; (defun my-display-buffer-function (buf not-this-window)
;;   (if (and (not pop-up-frames)
;;            (one-window-p)
;;            (or not-this-window
;;                (not (eq (window-buffer (selected-window)) buf)))
;;            (> (frame-width) 162))
;;       (split-window-horizontally))
;;   ;; Note: Some modules sets `pop-up-windows' to t before calling
;;   ;; `display-buffer' -- Why, oh, why!
;;   (let ((display-buffer-function nil)
;;         (pop-up-windows nil))
;;     (display-buffer buf not-this-window)))

;; (setq display-buffer-function 'my-display-buffer-function)

;;------------------------------------------------------------------------------
;; Show parenthesis
;;------------------------------------------------------------------------------
(require 'paren)
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;------------------------------------------------------------------------------
;; Folding keybindings
;;------------------------------------------------------------------------------
(defvar yafolding-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-S-return>") 'yafolding-hide-parent-element)
    (define-key map (kbd "<C-M-return>") 'yafolding-toggle-all)
    (define-key map (kbd "<C-return>")   'yafolding-toggle-element)
    map))

;;------------------------------------------------------------------------------
;; Sort directories first
;;------------------------------------------------------------------------------
(setq
 insert-directory-program "/usr/local/Cellar/coreutils/8.30/bin/gls"
 dired-listing-switches "-aBhl --group-directories-first")

;;------------------------------------------------------------------------------
;; Save recent files
;;------------------------------------------------------------------------------
(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" emaks-savefile-dir)
      recentf-max-saved-items 500
      recentf-max-menu-items 15
      ;; disable recentf-cleanup on Emacs start, because it can cause
      ;; problems with remote files
      recentf-auto-cleanup 'never)

(defun emaks-recentf-exclude-p (file)
  "A predicate to decide whether to exclude FILE from recentf."
  (let ((file-dir (file-truename (file-name-directory file))))
    (cl-some (lambda (dir)
               (string-prefix-p dir file-dir))
             (mapcar 'file-truename (list emaks-savefile-dir package-user-dir)))))

(add-to-list 'recentf-exclude 'emaks-recentf-exclude-p)

(recentf-mode +1)

;;------------------------------------------------------------------------------
;; Automatically save buffers with files when switching focus
;;------------------------------------------------------------------------------
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))

;;------------------------------------------------------------------------------
;; Set buffer major mode
;;------------------------------------------------------------------------------
(defadvice set-buffer-major-mode (after set-major-mode activate compile)
  "Set buffer major mode according to `auto-mode-alist'."
  (let* ((name (buffer-name buffer))
         (mode (assoc-default name auto-mode-alist 'string-match)))
    (when (and mode (consp mode))
      (setq mode (car mode)))
    (with-current-buffer buffer (if mode (funcall mode)))))

;;------------------------------------------------------------------------------
;; Highlight the current line
;;------------------------------------------------------------------------------
(global-hl-line-mode +1)

;;------------------------------------------------------------------------------
;; Clean up whitespace on save
;;------------------------------------------------------------------------------
(add-hook 'before-save-hook 'whitespace-cleanup)

;;------------------------------------------------------------------------------
;; Always delete and copy recursively
;;------------------------------------------------------------------------------
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;;------------------------------------------------------------------------------
;; Clean up obsolete buffers automatically
;;------------------------------------------------------------------------------
(require 'midnight)

;;------------------------------------------------------------------------------
;; Exchange point and mark
;;------------------------------------------------------------------------------
(defadvice exchange-point-and-mark (before deactivate-mark activate compile)
  "When called with no active region, do not activate mark."
  (interactive
   (list (not (region-active-p)))))

;;------------------------------------------------------------------------------
;; Clean up obsolete buffers automatically
;;------------------------------------------------------------------------------
(defmacro with-region-or-buffer (func)
  "When called with no active region, call FUNC on current buffer."
  `(defadvice ,func (before with-region-or-buffer activate compile)
     (interactive
      (if mark-active
          (list (region-beginning) (region-end))
        (list (point-min) (point-max))))))

(with-region-or-buffer indent-region)
(with-region-or-buffer untabify)

;;------------------------------------------------------------------------------
;; Automatically indenting yanked text if in programming-modes
;;------------------------------------------------------------------------------
(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) emaks-yank-indent-threshold)
      (indent-region beg end nil)))

(defmacro advise-commands (advice-name commands class &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.

The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

(advise-commands "indent" (yank yank-pop) after
  "If current mode is one of `emaks-yank-indent-modes',
indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (not (member major-mode emaks-indent-sensitive-modes))
           (or (derived-mode-p 'prog-mode)
               (member major-mode emaks-yank-indent-modes)))
      (let ((transient-mark-mode nil))
        (yank-advised-indent-function (region-beginning) (region-end)))))

;;------------------------------------------------------------------------------
;; Make a shell script executable automatically on save
;;------------------------------------------------------------------------------
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;------------------------------------------------------------------------------
;; Compilation from Emacs
;;------------------------------------------------------------------------------
(defun emaks-colorize-compilation-buffer ()
  "Colorize a compilation mode buffer."
  (interactive)
  ;; don't mess with child modes such as grep-mode, ack, ag, etc
  (when (eq major-mode 'compilation-mode)
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max)))))

(require 'compile)
(setq compilation-ask-about-save nil  ; Save before compiling
      compilation-always-kill t       ; Kill old compile processes before new
      compilation-scroll-output 'first-error) ; Scroll to first error
;;------------------------------------------------------------------------------
;; Colorize output of Compilation Mode
;;------------------------------------------------------------------------------
(require 'ansi-color)
(add-hook 'compilation-filter-hook #'emaks-colorize-compilation-buffer)

;;------------------------------------------------------------------------------
;; Sensible undo
;;------------------------------------------------------------------------------
(global-undo-tree-mode)

(provide 'emaks-editor)
