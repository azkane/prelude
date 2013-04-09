(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(package-initialize)
(elpy-enable)

(setq python-shell-interpreter "python2")
(when (require 'elpy nil t)
  (setq python-check-command "~/bin/python-check.sh")
  (elpy-enable)
  (elpy-clean-modeline))


(setq
 python-shell-interpreter "ipython2"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(require 'python)
(require 'python-django)
