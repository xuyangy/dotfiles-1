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


(after! org
  (setq
        org-capture-templates
        '(
          ; other entries here
          ("j" "Journal" entry
           (file+olp+datetree "~/Nextcloud/Notes/org/journal.org")
           "* Journal %T %u\n%?")
          ("p" "Piano" entry
           (file+olp+datetree "~/Nextcloud/Notes/org/piano.org")
           "* Entry
%?
** I - Gamy
pamiętać żeby grać 𝆑𝆑
*** TODO I - Gamy dur-moll równol. - 10m 𝆑𝆑
*** TODO II - Gamy chromatyczne - 10m 𝆑𝆑
*** TODO III - Gamy rozbieżnie/zbieżnie - 10m 𝆑𝆑
** II - Estudio
pamiętać żeby grać 𝆑𝆑 i z akcentami (nie płasko)
*** TODO I - Granie znanych już estudio tylko przetransponowanych - 10m >𝆑
Estudio 3 w F#
*** TODO II - Szlifowanie Estudio [numer] 'na blache' - 10m >𝆑
** III - Akordy
*** TODO Grać akordy z 'utwortutaj' najpierw bez przewrotu, 10m >𝆑
potem w 1 przewr,
potem w 2gim podejsciu w II przewr,
*** TODO Przetransponować ręcznie 'utwortutaj' do innej tonacji i zagrać te akordy
w bazowej formie
")
           ("s" "Spanish" entry 
           (file+headline "~/Nextcloud/Notes/org/spanish.org" "CapturedFlashcards")
           "** Word :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n*** Example\n")
           ("d" "drill" entry
           ()
           "* Drill :drill:\n%?")
          )))
(custom-set-variables
 '(org-directory "~/Nextcloud/Notes/org")
 '(org-agenda-files (list org-directory)
 '(org-refile-targets (list org-directory))))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
