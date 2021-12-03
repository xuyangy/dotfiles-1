;; Takes a feature symbol or a library name (string)
(evil-mode 1)
(after! evil
  (setq evil-magic nil))

;; Takes a major-mode, a quoted hook function or a list of either
(add-hook! python-mode
  (setq python-shell-interpreter "bpython"))

;; These are equivalent
(setq-hook! 'python-mode-hook python-indent-offset 2)
(setq-hook! python-mode python-indent-offset 2)

(use-package! hl-todo
  ;; if you omit :defer, :hook, :commands, or :after, then the package is loaded
  ;; immediately. By using :hook here, the `hl-todo` package won't be loaded
  ;; until prog-mode-hook is triggered (by activating a major mode derived from
  ;; it, e.g. python-mode)
  :hook (prog-mode . hl-todo-mode)
  :init
  ;; code here will run immediately
  :config
  ;; code here will run after the package is loaded
  (setq hl-todo-highlight-punctuation ":"))

; (after! org
;   (add-to-list 'org-capture-templates
;         '()))

(use-package org
  :defer t
  :config
  (defalias '+org--restart-mode-h #'ignore))

(after! org
  (setq
        org-capture-templates
        '(
          ; other entries here
          ("t" "tasks" entry
           (file+olp+datetree "journal.org")
           "* TODO %?\n%U")
           ("s" "Spanish" entry 
           (file+headline "~/Nextcloud/Notes/org/spanish.org" "CapturedFlashcards")
           "** Word\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n***Example\n")
          )))

