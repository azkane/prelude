;; Some parts of this file are part of the original
;; prelude distribution licensed under the GPL

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; set package-user-dir to be relative to Prelude install path
(setq package-user-dir (expand-file-name "elpa" prelude-dir)) 
(package-initialize)


(defvar target-packages
  '(ace-jump-mode ack-and-a-half diminish elisp-slime-nav
    evil evil-leader nyan-mode color-theme-sanityinc-tomorrow
    expand-region flycheck gist git-commit-mode gitconfig-mode
    gitignore-mode guru-mode helm helm-projectile magit melpa
    rainbow-mode solarized-theme undo-tree
    volatile-highlights yasnippet zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (-all? #'package-installed-p prelude-packages))

(defun prelude-install-packages ()
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (-each
     (-reject #'package-installed-p prelude-packages)
     #'package-install)))

(prelude-install-packages)

(defmacro prelude-auto-install (extension package mode)
  `(add-to-list 'auto-mode-alist
                `(,extension . (lambda ()
                                 (unless (package-installed-p ',package)
                                   (package-install ',package))
                                 (,mode)))))

(defvar prelude-auto-install-alist
  '(("\\.clj\\'" clojure-mode clojure-mode)
    ("\\.coffee\\'" coffee-mode coffee-mode)
    ("\\.css\\'" css-mode css-mode)
    ("\\.erl\\'" erlang erlang-mode)
    ("\\.feature\\'" feature-mode feature-mode)
    ("\\.groovy\\'" groovy-mode groovy-mode)
    ("\\.haml\\'" haml-mode haml-mode)
    ("\\.hs\\'" haskell-mode haskell-mode)
    ("\\.latex\\'" auctex LaTeX-mode)
    ("\\.less\\'" less-css-mode less-css-mode)
    ("\\.lua\\'" lua-mode lua-mode)
    ("\\.markdown\\'" markdown-mode markdown-mode)
    ("\\.md\\'" markdown-mode markdown-mode)
    ("\\.php\\'" php-mode php-mode)
    ("\\.py\\'" python python-mode)
    ("\\.sass\\'" sass-mode sass-mode)
    ("\\.scala\\'" scala-mode2 scala-mode)
    ("\\.scss\\'" scss-mode scss-mode)
    ("\\.slim\\'" slim-mode slim-mode)
    ("\\.yml\\'" yaml-mode yaml-mode)))

;; markdown-mode doesn't have autoloads for the auto-mode-alist
;; so we add them manually if it's already installed
(when (package-installed-p 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

(-each prelude-auto-install-alist
  (lambda (entry)
    (let ((extension (car entry))
          (package (cadr entry))
          (mode (cadr (cdr entry))))
      (unless (package-installed-p package)
        (prelude-auto-install extension package mode)))))

(defun prelude-ensure-module-deps (packages)
  (-each (-remove #'package-installed-p packages) #'package-install))

(provide 'pred-packages)
;;; prelude-packages.el ends here
