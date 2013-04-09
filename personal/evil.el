(require 'surround)
(require 'cl)

(evil-mode 1)

(defmacro evil-enclose-ace-jump (&rest body)
  `(let ((old-mark (mark)))
     (remove-hook 'pre-command-hook #'evil-visual-pre-command t)
     (remove-hook 'post-command-hook #'evil-visual-post-command t)
     (unwind-protect
         (progn
           ,@body
           (recursive-edit))
       (if (evil-visual-state-p)
           (progn
             (add-hook 'pre-command-hook #'evil-visual-pre-command nil t)
             (add-hook 'post-command-hook #'evil-visual-post-command nil t)
             (set-mark old-mark))
         (push-mark old-mark)))))

(evil-define-motion evil-ace-jump-char-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)))

(evil-define-motion evil-ace-jump-line-mode (count)
  :type line
  (evil-enclose-ace-jump
   (ace-jump-mode 9)))

(evil-define-motion evil-ace-jump-word-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 1)))


(evil-define-motion evil-ace-jump-char-to-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)
   (forward-char -1)))

(defun def-assoc (key alst default)
  "Returns the given key in alst, if it doesnt exist return default"
  (let ((val (assq key alst)))
    (if val
        (cdr val)
      default)))

(defun set-evil-cursors ()
  (setq evil-default-cursor '("#268bd2" box))
  (setq evil-normal-state-cursor '("#268bd2" box))
  (setq evil-insert-state-cursor '("#d33682" bar))
  (setq evil-visual-state-cursor '("#6c71c4" box))
  (setq evil-motion-state-cursor '("blue" box))
  (setq evil-replace-state-cursor '("#6c71c4" hbar))
  (setq evil-emacs-state-cursor '("orange" box)))

(set-evil-cursors)

(setq evil-normal-state-tag (propertize "N" 'face '((:background "green" :foreground "black")))
      evil-emacs-state-tag (propertize "E" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag (propertize "I" 'face '((:background "red")))
      evil-motion-state-tag (propertize "M" 'face '((:background "blue")))
      evil-visual-state-tag (propertize "V" 'face '((:background "grey80" :foreground "black")))
      evil-operator-state-tag (propertize "O" 'face '((:background "purple"))))

(global-surround-mode 1)

(defun clear-empty-lines ()
  (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
    (when (string-match "^ +$" line)
      (delete-region (point-at-bol) (point-at-eol)))))
(add-hook 'evil-insert-state-exit-hook #'clear-empty-lines) 

(evil-define-command evil-maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p))
        (entry-key ?j)
        (exit-key ?k))
    (insert entry-key)
    (let ((evt (read-event (format "Insert %c to exit insert state" exit-key) nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt exit-key))
          (delete-char -1)
          (set-buffer-modified-p modified)
          (evil-force-normal-state)
          (push 'escape unread-command-events))
       (t (push evt unread-command-events))))))
