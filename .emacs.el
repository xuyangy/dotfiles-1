(package-initialize)
(setq vc-follow-symlinks t) ;don't complain about sourcing config.el on startup
(org-babel-load-file "~/.config.org")
