(setq c-default-style "k&r"
      c-indent-tabs-mode t
      c-indent-level 4
      c-basic-offset 4)

(add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state 1)))
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

(defun my-indent-setup ()
  (c-set-offset 'arglist-intro '+))
(add-hook 'c-mode-common-hook 'my-indent-setup)
