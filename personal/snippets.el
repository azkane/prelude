(setq yas-prompt-functions '(yas-ido-prompt))

;;; TODO: redefine as maybe-yas-expan
;; (defun yas-expand-or-spc (count)
;;   (interactive "p")
;;   (let ((yas-fallback-behavior 'return-nil))
;;     (unless (yas-expand)
;;       (insert (make-string count ? )))))
