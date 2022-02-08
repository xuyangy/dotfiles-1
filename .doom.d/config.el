;; Takes a feature symbol or a library name (string)
(evil-mode 1)
(after! evil
  (setq evil-magic nil))

(map! :leader
      :desc "Evil write shortcut"
      "w" #'evil-write
      )

(use-package! lsp-volar)
(use-package! tree-sitter)
(use-package! tree-sitter-langs)

;; Takes a major-mode, a quoted hook function or a list of either
(add-hook! python-mode
  (setq python-shell-interpreter "bpython"))

;; These are equivalent
(setq-hook! 'python-mode-hook python-indent-offset 2)
(setq-hook! python-mode python-indent-offset 2)

(setq evil-insert-state-cursor '(bar "#00FF00")
      evil-visual-state-cursor '(box "#FF00FF")
      evil-normal-state-cursor '(box "#E2E8EF"))

(evil-collection-init 'vterm)

;;(global-tree-sitter-mode)

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
           "* %?")
           ("s" "Spanish" entry
           (file+headline "~/Nextcloud/Notes/org/spanish.org" "CapturedFlashcards")
           "** Word :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n*** Example\n")
          ("l" "Piano lesson" entry
           (file+olp+datetree "~/Nextcloud/Notes/org/piano.org" "Lekcje")
           "* %?")
          ("p" "Protocol" entry (file+headline "~/Nextcloud/Notes/org/refile.org" "Selections") "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
          ("L" "Protocol Link" entry (file+headline "~/Nextcloud/Notes/org/refile.org"  "Links") "* %? [[%:link][%:description]] \nCaptured On: %U")
          )))

(custom-set-variables
 '(org-directory "~/Nextcloud/Notes/org")
 '(org-agenda-files (list org-directory)
 '(org-refile-targets (list org-directory))))

;; https://github.com/hlissner/doom-emacs/issues/5714
(defalias '+org--restart-mode-h #'ignore)

 (setq org-agenda-custom-commands
       (quote (
               ("h" "Habits" tags-todo "STYLE=\"habit\""
                ((org-agenda-overriding-header "Habits")
                 (org-agenda-sorting-strategy
                  '(todo-state-down effort-up category-keep))))
               (" " "Agenda"
                ((agenda "" nil)
                 (tags "drill" ((org-agenda-overriding-header "Drills")))
                ))
                nil)))

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c b") #'org-switchb)
(setq org-use-tag-inheritance nil)


(setq display-line-numbers-type 'relative)
(setq x-select-enable-clipboard nil)

(set-email-account! "artur@tagisow.dev"
  '((mu4e-sent-folder       . "/mailbox/Sent")
    (mu4e-drafts-folder     . "/mailbox/Drafts")
    (mu4e-trash-folder      . "/mailbox/Trash")
    (mu4e-refile-folder     . "/mailbox/Archives")
    (smtpmail-smtp-user     . "artur@tagisow.dev")
    (user-mail-address      . "artur@tagisow.dev")
    (user-full-name         . "Artur Tagisow"))
  t)

;instead of the mu4e thread collapsing plugin
(setq mu4e-headers-include-related nil
      mu4e-get-mail-command "mbsync mailbox"
      mu4e-update-interval 60
      mu4e-maildir-shortcuts
      '((:maildir "/mailbox/INBOX"   :key ?i)
        (:maildir "/mailbox/Trash" :key ?t)
        (:maildir "/mailbox/Archives" :key ?a)
        (:maildir "/mailbox/Sent" :key ?s)
        )
      )

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

(setq org-static-blog-publish-title "Blog - Artur Tagisow"
      org-static-blog-publish-url "https://blog.tagisow.dev"
      org-static-blog-publish-directory "~/dev/blog/dist/"
      org-static-blog-posts-directory "~/dev/blog/posts/"
      org-static-blog-drafts-directory "~/dev/blog/drafts/"
      org-static-blog-enable-tags t
      org-static-blog-use-preview t
      org-static-blog-preview-link-p t
      org-export-with-toc nil
      org-export-with-section-numbers nil
      org-static-blog-page-header "<meta name=\"author\" content=\"Artur Tagisow\">
<meta name=\"referrer\" content=\"no-referrer\">
<link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />"
      org-static-blog-page-preamble
      "
<header>
  <a href=\"https://blog.tagisow.dev\">
    Blog - Artur Tagisow
  </a>
</header>")
