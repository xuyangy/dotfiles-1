(map! :leader :desc "Evil write shortcut" "w" #'evil-write)

(use-package! tree-sitter)
(use-package! tree-sitter-langs)

(setq evil-insert-state-cursor '(bar "#00FF00")
      evil-visual-state-cursor '(box "#FF00FF")
      evil-normal-state-cursor '(box "#E2E8EF"))

(after! org
  (setq
   org-capture-templates
   '(
     ("j" "Journal" entry
      (file+olp+datetree "~/org/journal.org")
      "* %?")
     ("s" "Spanish" entry
      (file+headline "~/org-extra/spanish.org" "CapturedFlashcards")
      "** Word :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n*** Example\n")
     ("l" "Piano lesson" entry
      (file+olp+datetree "~/org-extra/piano.org" "Lekcje")
      "* %?")
     ("m" "Meeting" entry (file+headline "~/org/refile.org" "Meeintgs") "* %U %?")
     ("p" "Protocol" entry (file+headline "~/org/refile.org" "Selections") "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
     ("L" "Protocol Link" entry (file+headline "~/org/refile.org"  "Links") "* %? [[%:link][%:description]] \nCaptured On: %U")
     )))

;; https://github.com/hlissner/doom-emacs/issues/5714
(defalias '+org--restart-mode-h #'ignore)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c b") #'org-switchb)

(setq org-use-tag-inheritance nil)

(defun org-insert-clipboard-image (&optional file)
  (interactive "F")
  (shell-command (concat "pngpaste " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))


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
</header>")


(use-package calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Nextcloud/CALIBRE")
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  (setq calibredb-library-alist '(("~/Nextcloud/Calibre"))))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq typescript-indent-level 2)
(setq js2-basic-offset 2)
(setq js-indent-level 2)
(setq web-mode-markup-indent-offset 2)

(setq web-mode-css-indent-offset 2)
(setq web-mode-style-indent-offset 2)
(setq web-mode-style-padding 0)

(setq web-mode-script-padding 0)

(custom-set-variables
  '(markdown-command "/opt/homebrew/bin/pandoc"))

(custom-theme-set-faces! 'doom-one
  '(line-number :foreground "dim gray")
  '(line-number-current-line :foreground "white"))

(after! lsp-ui
  (setq lsp-ui-doc-show-with-cursor t))


(setq lsp-eslint-auto-fix-on-save t)

(setq ranger-override-dired 'ranger)

(org-agenda-list)

(defun file-notify-rm-all-watches ()
  "Remove all existing file notification watches from Emacs."
  (interactive)
  (maphash
   (lambda (key _value)
     (file-notify-rm-watch key))
   file-notify-descriptors))

(remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)

;; (lsp-register-custom-settings '(("documentFeatures.documentFormatting.defaultPrintWidth" nil)))
;; (lsp-register-custom-settings '(("documentFeatures.documentFormatting" nil)))
;; (setf (lsp--client-initialization-options (gethash 'volar lsp-clients))  (( "documentFeatures.documentFormatting" nil )))
;; (lsp--set-configuration `(:pyls , (:configurationSources . ("pycodestyle", "pyflakes")))
;; (lsp--server-unregister-capability (
;;                                     lsp-make-unregistration
;;                                     :id "volar"
;;                                     :method "textDocument/formatting"))

