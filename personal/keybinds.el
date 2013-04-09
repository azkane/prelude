(require 'evil-leader)

(evil-leader/set-leader "SPC")

(evil-leader/set-key
  "e" 'helm-prelude
  "x" 'helm-M-x
  "o" 'other-window
  "b" 'ido-switch-buffer
  "," 'evil-buffer
  "k" 'kill-buffer
  "m" 'eshell
  "SPC" 'evil-ace-jump-word-mode
  "t" 'evil-ace-jump-char-mode
  "l" 'evil-ace-jump-line-mode
  "g" 'magit-status)

(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map "-" 'delete-other-windows)
     (define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
     (define-key evil-normal-state-map "H" 'evil-first-non-blank)
     (define-key evil-normal-state-map "Y" 'copy-to-end-of-line)
     (define-key evil-normal-state-map "L" 'evil-last-non-blank)
     (define-key evil-normal-state-map "gf" 'helm-find-files)
     (define-key evil-insert-state-map "ESC" nil)
     (define-key evil-insert-state-map (kbd "C-d") 'delete-forward-char)
     (define-key evil-insert-state-map (kbd "C-h") 'backward-delete-char)
     (define-key evil-insert-state-map "j" 'evil-maybe-exit)))


(global-set-key "\C-x\C-f" 'nil)
