(require 'uniquify)

;; Disable GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(set-scroll-bar-mode nil)

;; Cute cats 
(nyan-mode 1)

;; load tomorrow-bright
(disable-theme 'zenburn)
(load-theme 'sanityinc-tomorrow-bright) 

;; line-numbers
(global-linum-mode 1)

(setq prelude-whitespace nil)

;; Uniquify settings 
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
