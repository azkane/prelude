(add-to-list 'load-path "~/.emacs.d/personal/newlisp-mode/")
(autoload 'newlisp "newlisp" "Major mode for newlisp files" t)
(add-to-list 'auto-mode-alist '("\\.lsp$" . newlisp-mode))

(eval-after-load "newlisp"
  '(progn
     (define-key newlisp-mode-map [(control x) (control e)] 'newlisp-evaluate-prev-sexp)
     (defun start-newlisp ()
       "Starts newlisp interpreter/or shows if already running."
       (interactive)
       (newlisp-show-interpreter))))
