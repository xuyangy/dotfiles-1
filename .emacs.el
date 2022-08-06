(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)

(use-package general
  :straight t)

(use-package evil
  :straight t
  :init 
  (evil-mode 1)
  (evil-set-leader 'normal (kbd "SPC"))
  :bind (:map evil-normal-state-map ("<leader>w" . evil-write))
)

(use-package evil-collection
  :straight t
  :init 
  (evil-collection-init))
(use-package magit
  :straight t)

(use-package lsp-mode
  :straight t)

(use-package ivy
  :straight t)

(use-package counsel
  :straight t)

(use-package swiper
  :straight t
  :init
  (counsel-mode)
  )

(use-package projectile
  :straight t)

(use-package counsel-projectile
  :straight t)
