(defvar dps/sys-literate-dir (expand-file-name "literate/" "~/.config/doom/")
  "Directory containing literate Org configuration files to auto-tangle.")

(defun dps/sys-org-in-literate-dir-p (file)
  "Return non-nil if FILE resides under dps/sys-literate-dir."
  (when (and file dps/sys-literate-dir)
    (string-prefix-p (file-truename dps/sys-literate-dir)
      (file-truename (file-name-directory file)))))

(defun dps/sys-auto-tangle-on-save ()
  "Auto-tangle this Org file if it is inside dps/sys-literate-dir."
  (when (and (eq major-mode 'org-mode)
          buffer-file-name
          (dps/sys-org-in-literate-dir-p buffer-file-name))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'after-save-hook #'dps/sys-auto-tangle-on-save)

(setq doom-theme 'doom-snazzy
  doom-font (font-spec :family "Iosevka Extended" :size 18)
  doom-variable-pitch-font (font-spec :family "Iosevka Extended")
  doom-symbol-font (font-spec :family "Symbola")
  doom-big-font (font-spec :family "Iosevka Extended" :size 40))

(custom-theme-set-faces! 'doom-snazzy
  '(org-level-1 :inherit outline-1 :height 1.35)
  '(org-level-2 :inherit outline-2 :height 1.25)
  '(org-level-3 :inherit outline-3 :height 1.18)
  '(org-level-4 :inherit outline-4 :height 1.12)
  '(org-document-title :height 1.45 :bold t))

(setq display-line-numbers-type 'relative
  fill-column 80
  display-fill-column-indicator-column 80
  undo-limit 80000000
  evil-want-fine-undo t
  auto-save-default t
  confirm-kill-emacs nil)

(global-visual-line-mode 1)
(global-subword-mode 1)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'text-mode-hook #'display-fill-column-indicator-mode)
(display-time-mode 1)

(setq evil-split-window-below t
  evil-vsplit-window-right t)
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 90))

(defadvice! dps/sys-consult-after-split (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(defconst org-path (file-truename "~/ssd/documents/org/"))
(defconst org-zett (file-truename "~/ssd/documents/org/zettelkasten"))
(defconst org-dail (file-truename "~/ssd/documents/org/zettelkasten/daily/"))

(setq org-directory org-path
      org-roam-directory org-zett
      org-roam-dailies-directory org-dail
  password-cache-expiry 10)

(after! org-roam
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t)))

(setq deft-directory org-path
  deft-extensions (list "org")
  deft-recursive t)

(setq gc-cons-threshold 100000000) ; 100MB
(setq read-process-output-max (* 1024 1024)) ; 1MB
(setq lsp-idle-delay 0.5)
(setq lsp-log-io nil) ; Disable LSP logging for speed

(setq-default window-combination-resize t
  x-stretch-cursor t)

(after! org-roam
    (setq org-roam-buffer-position 'right)
    (setq org-roam-buffer-width 0.3))

(setq org-roam-node-display-template
    (concat "${title:*} "
        (propertize "${tags:20}" 'face 'org-tag)))

(defun dps/write-goto-src-begin ()
  "Jump to the beginning of the source block at point."
  (interactive)
  (let ((el (org-element-at-point)))
    (when (eq (org-element-type el) 'src-block)
      (goto-char (org-element-property :begin el)))))

(defun dps/write-goto-src-end ()
  "Jump to the end of the source block at point."
  (interactive)
  (let ((el (org-element-at-point)))
    (when (eq (org-element-type el) 'src-block)
      (goto-char (org-element-property :end el))
      (forward-line -1))))

(after! doom-modeline
  (setq doom-modeline-height 40
    doom-modeline-bar-width 10
    doom-modeline-buffer-file-name-style 'file-name-with-project
    doom-modeline-major-mode-icon t
    doom-modeline-vcs-max-length 50
    ))

(defun dps/org-sync ()
    "Quick sync: stage all, commit with timestamp, push."
    (interactive)
    (let ((default-directory org-directory))
        (shell-command "git add -A")
        (shell-command (format "git commit -m 'sync: %s'" (format-time-string "%Y-%m-%d %H:%M")))
        (shell-command "git push"))
    (message "Org files synced!"))
