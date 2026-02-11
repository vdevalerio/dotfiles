(after! yasnippet
  (setq yas-triggers-in-field t
        yas-also-indent-empty-lines t
        yas-also-auto-indent-first-line t)
  (map! :map yas-minor-mode-map
        "<C-tab>" #'yas-next-field))

(setq org-roam-capture-templates
    '(("d" "default" plain "%?"
        :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
            "#+TITLE: ${title}\n#+DATE: %U\n#+FILETAGS: \n\n")
        :unnarrowed t)))

(after! org
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file+headline "~/ssd/documents/org/inbox.org" "Inbox")
           "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
           :empty-lines 1)

          ("t" "Task" entry
           (file+headline "~/ssd/documents/org/inbox.org" "Tasks")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n"
           :empty-lines 1))))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+TITLE: %<%Y-%m-%d %A>\n\n"))))
