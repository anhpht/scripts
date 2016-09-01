(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.5.5/emacs/" load-path))
(require 'sgml-mode)
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)

(custom-set-variables
 '(inhibit-startup-screen t))
(custom-set-faces)

;;User defines

(global-set-key [f2] 'save-buffer)
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-j" 'kill-whole-line)
(global-set-key "\C-f" 'findF)
(global-set-key "\C-r" 'delete-rectangle)
(global-set-key "\C-]" 'findTag)
(global-set-key "\C-v" 'copy-line)
(global-set-key "\C-t" 'kill-this-buffer)
(global-set-key "\C-d" 'switch-to-previous-buffer)
(defun kill-whole-line ()
  "Kill an entire line, including trailing newline"
  (interactive)
  (beginning-of-line)
  (kill-line 1))

(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))


(defun copy-line ()
  "Copy current line in the kill ring"
  (interactive)
  (kill-ring-save (line-beginning-position)
                  (line-end-position 1))
  (message "Line copied"))

(defun findF()
  "Find file"
  (interactive)
  (setq searchname (read-from-minibuffer "File name:"))
  (setq pwd (getenv "PWD"))
  (setq repeat_call 0)
  (setq cmd (format "tail -n 100 $HOME/.e_history | grep -E \"emacs|vim\" | awk '{ print $NF }' | grep %s |tail -n 1" searchname))
  (setq result (shell-command-to-string cmd))
  (if (string= result "") ()
    (setq filename (replace-regexp-in-string "\n" "" result))
    (setq question (format "Open: %s (y/n)?" filename))
    (setq answer (read-from-minibuffer question))
    (cond ((string= answer "y") (setq repeat_call 1))
          ((string= answer "")  (setq repeat_call 1))
          )
    )
  (if (> repeat_call 0)
    (find-file (concat pwd "/" filename))
;;Do something else
    (setq end 0)
    (setq cmd (format "cd %s; find . -name \*%s\* | grep -v .svn" pwd searchname))
    (setq result (shell-command-to-string cmd))
    (setq files (split-string result "\n"))
    (while (and (= 0 end) (not (null files)))
           (setq question (format "Open: %s (y/n)?" (car files)))
           (setq answer (read-from-minibuffer question))
           (cond ((string= answer "y") (setq end 1))
                 ((string= answer "")  (setq end 1))
                 (t (setq files (cdr files)))
                 )
           )
    (if (and (> end 0))
      (find-file (concat pwd (substring (car files) 1)))
      )
    )
)


(defun findTag()
  "Find tag, example module:function"
  (interactive)
  (setq pwd (getenv "PWD"))
  (setq line (thing-at-point 'line))
  (setq filter_line (replace-regexp-in-string "[^A-Za-z0-9 _ :]" " " line))
  (setq pos (- (point) (line-beginning-position)))
  (setq result (word-at-position filter_line pos))
  (if (numberp (string-match ":" result))
    (progn 
      (setq module (nth 0 (split-string result ":")))
      (setq func (nth 1 (split-string result ":")))

      (setq cmd (format "cd %s; find . -name %s.erl | grep -v .svn" pwd module))
      (setq result (shell-command-to-string cmd))
      (setq files (split-string result "\n"))
      (setq filename (concat pwd (substring (car files) 1)))
      (find-file filename)
      (search-forward-regexp (concat "^" func))
      )

    (goto-char 1)
    (search-forward-regexp (concat "^" result))
    )
  )
(defun word-at-position(str pos)
  (setq str1 (substring str 0 pos))
  (setq str2 (substring str pos))
  (setq start (string-match-right " " str1))
  (setq end (+ pos (string-match " " str2)))
  (setq result (substring str start end))
  result
  )

(defun string-match-right(substr str)
  "Search substring from right of a string"
  (interactive)
  (with-temp-buffer
    (insert str)
    (goto-char (point-max))
    (search-backward substr)
    (point)
    )
  )

