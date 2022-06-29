(setq
 evil-insert-state-cursor '(bar "#00FF00")
 evil-visual-state-cursor '(box "#FF00FF")
 evil-normal-state-cursor '(box "#E2E8EF")
 org-use-tag-inheritance nil
 display-line-numbers-type 'relative
 x-select-enable-clipboard nil
 org-agenda-custom-commands (quote (
                                    ("h" "Habits" tags-todo "STYLE=\"habit\""
                                     ((org-agenda-overriding-header "Habits")
                                      (org-agenda-sorting-strategy
                                       '(todo-state-down effort-up category-keep))))
                                    (" " "Agenda"
                                     ((agenda "" nil)
                                      (tags "drill" ((org-agenda-overriding-header "Drills")))
                                      ))
                                    nil))
 org-capture-templates '(
                         ("j" "Journal" entry (file+olp+datetree "~/org/journal.org") "* %?")
                         ("s" "Spanish" entry (file+headline "~/org-extra/spanish.org" "CapturedFlashcards") "** Word :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n*** Example\n")
                         ("l" "Piano lesson" entry (file+olp+datetree "~/org-extra/piano.org" "Lekcje") "* %?")
                         ("m" "Meeting" entry (file+headline "~/org/refile.org" "Meeintgs") "* %U %?")
                         ("p" "Protocol" entry (file+headline "~/org/refile.org" "Selections") "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                         ("L" "Protocol Link" entry (file+headline "~/org/refile.org"  "Links") "* %? [[%:link][%:description]] \nCaptured On: %U")
                         )
 org-static-blog-publish-title "Blog - Artur Tagisow"
 org-static-blog-publish-url "https://tagisow.dev"
 org-static-blog-publish-directory "~/Nextcloud/Documents/devblog/dist/"
 org-static-blog-posts-directory "~/Nextcloud/Documents/devblog/posts/"
 org-static-blog-drafts-directory "~/Nextcloud/Documents/devblog/drafts/"
 org-static-blog-enable-tags t
 org-static-blog-use-preview t
 org-static-blog-preview-link-p t
 org-export-with-toc nil
 org-export-with-section-numbers nil
 org-static-blog-page-header "<meta name=\"author\" content=\"Artur Tagisow\">
<meta name=\"referrer\" content=\"no-referrer\">
<link rel=\"preload\" href=\"static/style.css\" as=\"style\"/>
<link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />"
 org-static-blog-page-preamble
 "
<header>
  <a href=\"https://tagisow.dev\">
    Blog - Artur Tagisow
  </a>
</header>"
mu4e-headers-include-related nil
mu4e-get-mail-command "mbsync mailbox"
mu4e-update-interval 60
mu4e-maildir-shortcuts
'((:maildir "/mailbox/INBOX"   :key ?i)
  (:maildir "/mailbox/Trash" :key ?t)
  (:maildir "/mailbox/Archives" :key ?a)
  (:maildir "/mailbox/Sent" :key ?s)
  )
sendmail-program (executable-find "msmtp")
send-mail-function #'smtpmail-send-it
message-sendmail-f-is-evil t
message-sendmail-extra-arguments '("--read-envelope-from")
message-send-mail-function #'message-send-mail-with-sendmail
 )

(evil-define-key 'motion org-agenda-mode-map "ZH" 'org-habit-toggle-habits)
(map! :leader :desc "Evil write shortcut" "w" #'evil-write)
(set-face-foreground 'line-number "#ffffff")
(set-face-foreground 'line-number-current-line "#ff0000")
(defalias '+org--restart-mode-h #'ignore) ;; https://github.com/hlissner/doom-emacs/issues/5714

(set-email-account! "artur@tagisow.dev"
                    '((mu4e-sent-folder       . "/mailbox/Sent")
                      (mu4e-drafts-folder     . "/mailbox/Drafts")
                      (mu4e-trash-folder      . "/mailbox/Trash")
                      (mu4e-refile-folder     . "/mailbox/Archives")
                      (smtpmail-smtp-user     . "artur@tagisow.dev")
                      (user-mail-address      . "artur@tagisow.dev")
                      (user-full-name         . "Artur Tagisow"))
                    t)


(defun org-insert-clipboard-image (&optional file)
  (interactive "F")
  (shell-command (concat "pngpaste " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))

(org-agenda-list)
