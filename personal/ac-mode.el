(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-auto-start 3)
(setq ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed
(setq ac-ignore-case t)
(ac-persist-help)
(ac-config-default)
(ac-fuzzy-complete)
(ac-set-trigger-key "TAB")
(define-key ac-completing-map (kbd "C-k") 'ac-next)
(define-key ac-completing-map (kbd "C-j") 'ac-previous)

;;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(global-set-key "\C-s" 'ac-isearch) ;; i know, super ugly, wont work otherwise

(setq tab-always-indent 'complete)  ;; use 't when auto-complete is disabled
(add-to-list 'completion-styles 'initials t)

(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

(set-default 'ac-sources
             '(ac-source-dictionary
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer))

(dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode
                js3-mode css-mode less-css-mode))
  (add-to-list 'ac-modes mode))
