(map! :leader :desc "Evil write shortcut" "w" #'evil-write)

(setq evil-insert-state-cursor '(bar "#00FF00")
      evil-visual-state-cursor '(box "#FF00FF")
      evil-normal-state-cursor '(box "#E2E8EF"))

(setq
 org-capture-templates
 '(
   ("r" "Refile TODO" entry (file+headline "~/org/refile.org" "TODOs") "** TODO %?")
   ("m" "Meeting" entry (file+headline "~/org/refile.org" "Meetings") "* %U %?")
   ("p" "Protocol" entry (file+headline "~/org/refile.org" "Selections") "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
   ("L" "Protocol Link" entry (file+headline "~/org/refile.org"  "Links") "* %? [[%:link][%:description]] \nCaptured On: %U")
   ))

;; https://github.com/hlissner/doom-emacs/issues/5714
(defalias '+org--restart-mode-h #'ignore)

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c b") #'org-switchb)

(defun org-insert-clipboard-image (&optional file)
  (interactive "F")
  (shell-command (concat "pngpaste " file))
  (insert (concat "[[" file "]]"))
  (org-display-inline-images))


(setq display-line-numbers-type 'relative)
(setq select-enable-clipboard nil)

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

(custom-theme-set-faces! 'doom-one
  '(line-number :foreground "dim gray")
  '(line-number-current-line :foreground "white"))

(after! lsp-ui
  (setq lsp-ui-doc-show-with-cursor t))

(setq ranger-override-dired 'ranger)

(defun file-notify-rm-all-watches ()
  "Remove all existing file notification watches from Emacs."
  (interactive)
  (maphash
   (lambda (key _value)
     (file-notify-rm-watch key))
   file-notify-descriptors))

(remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)
