(map! :after evil
      :map evil-motion-state-map
      (:prefix ("] g" . "Go to")
       :desc "Next source block end" "e" #'dps/write-goto-src-end)
      (:prefix ("[ g" . "Go to")
       :desc "Prev source block begin" "b" #'dps/write-goto-src-begin))

(map! :map org-mode-map
  "C-c h" #'hs-toggle-hiding
  "C-c H" #'dps/write-toggle-all-src)

(map! :leader
      (:prefix ("r" . "roam")
       :desc "Find node"           "f" #'org-roam-node-find
       :desc "Insert link"         "i" #'org-roam-node-insert
       :desc "Toggle buffer"       "r" #'org-roam-buffer-toggle
       :desc "Capture note"        "c" #'org-roam-capture
       :desc "Today's daily"       "t" #'org-roam-dailies-goto-today
       :desc "Find daily"          "d" #'org-roam-dailies-goto-date
       :desc "Capture to daily"    "j" #'org-roam-dailies-capture-today))

(map! :leader
      :desc "Sync org files" "o s" #'dps/org-sync)
