(after! org
  (setq org-startup-folded 'content
        org-hide-emphasis-markers t
        org-return-follows-link t
        org-startup-with-inline-images t
        org-image-actual-width '(600)
        org-display-remote-inline-images t))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROGRESS(p)" "WAITING(w)" "|"
           "DONE(d)" "CANCELLED(c)")))
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#FF7470" :weight bold))
          ("PROGRESS" . (:foreground "#57C7FF" :weight bold))
          ("WAITING" . (:foreground "#FFA657" :weight bold))
          ("DONE" . (:foreground "#72F89E" :weight bold))
          ("CANCELLED" . (:foreground "#8B8B8B" :weight bold)))))

(defvar dps/write--all-src-hidden nil
  "Track whether all source blocks are hidden.")
(add-hook 'org-src-mode-hook #'hs-minor-mode)

(defun dps/write-toggle-all-src ()
  "Toggle visibility of all source blocks in the buffer."
  (interactive)
  (if dps/write--all-src-hidden (hs-show-all) (hs-hide-all))
  (setq dps/write--all-src-hidden (not dps/write--all-src-hidden)))

(setq-default tab-width 4
    indent-tabs-mode nil
    tab-always-indent nil
    evil-shift-width 4)

(add-hook 'after-change-major-mode-hook
    (lambda ()
        (setq tab-width 4)))
