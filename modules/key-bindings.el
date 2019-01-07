;; a subset of key-bindings related to general cursor, text operations

;; set hot key for mark, esp, for MAC, less convenient alternatives: C+@, or C-x C-x
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; Traversing Windows
;; Example Source: writing GNU Emacs Extensions, Bob Glickstein
;; C-x o is cumbersome with multiple windows
(global-set-key "\C-x\C-n" 'other-window)
;; there is no other-window-backward command existing
(defun other-window-backward ( )
  "Select the previous window."
  ;; by interactive, function could be invoked via M-x command-name
  ;; all commands are Lisp functions, not all Lisp functions are commands
  (interactive)
  ;; invoke function other-window with argument of -1
  (other-window -1))
;; more advanced version
;; make n optional parameter, note, even without optional setting, interactive command could receive no input as well
(defun other-window-backward-n (&optional n)
  "Select the Nth previous window."
  ;; for interactive function, we need to specify how it receives arguments
  ;; p means, if there is a prefix argument, interpret it as a number, otherwise, 1
  ;; e.g., C-u 7 C-x C-p
  (interactive "p")
  ;; invoke function other-window with argument of -1
  ;; notice the space between - and n
  (if n
      (other-window (- n)) ;if n is non-nil
    (other-window -1)) ; if n is nil
  ;; equivalent: (other-window (if n (- n) -1))
  ;; (if test (a b) (a c)) shortened to (a (if test b c))
  ;; (if a a b) can be replaced by (or a b)
  ;; or finds until non-nil, similarly, and finds until nil
  )
(defun other-window-backward-better (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (other-window (- (or n 1)))
  )
(defun other-window-backward-best (&optional n)
  "Select the Nth previous window."
  ;; P means when called interactively, leave the prefix argument in raw form and assign it to n
  (interactive "P")
  ;; prefix-numeric-value returnn n unchanged if it is a number and return 1 if it is nil
  ;; it is more emcas-lisp-like since it achieves better code reuse
  (other-window (- (prefix-numeric-value n)))
  )
(global-set-key "\C-x\C-p" 'other-window-backward-best)

;; Line-at-a-Time Scrolling
;; Example Source: writing GNU Emacs Extensions
;; C-v and M-v (scroll-up and scroll-down) scroll the text one windowful at a time, receiving optional n lines
;; C-u 1 C-v and C-u 1 M-v could scroll 1 line at a time but not satisfactory
;; avoid confusion, make alias for each Lisp function
(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)
(defun scroll-one-line-ahead ()
  "Scroll ahead one line."
  (interactive)
  (scroll-ahead 1)
  )
(defun scroll-one-line-behind ()
  "Scroll behind one line."
  (interactive)
  (scroll-behind 1)
  )
;; more general version
(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n))
  )
(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n))
  )
;; original bindings are used infrequently, dont mind losing
(global-set-key "\C-q" 'scroll-n-lines-behind)
(global-set-key "\C-z" 'scroll-n-lines-ahead)

;; useful Cursor and Text Motion Commands
;; Example Source: writing GNU Emacs Extensions
(defun point-to-top ()
  "Put point on top line of window."
  (interactive)
  (move-to-window-line O)
  )
;; replaces tags-loop-continue
(global-set-key "\M-," 'point-to-top)
(defun point-to-bottom ()
  "Put point at beginning of last visible line."
  (interactive)
  (move-to-window-line -1))
(global-set-key "\M-." 'point-to-bottom)
(defun line-to-top ()
  "Move current line to top of window."
  (interactive)
  (recenter O)
  )
(global-set-key "\M-!" 'line-to-top)

(global-set-key "\C-x\M-c" 'comment-region)
(global-set-key "\C-x\M-u" 'uncomment-region)

;; set hot key for mark, esp, for MAC, less convenient alternatives: C+@, or C-x C-x
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; F2 for hooking init.el file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") 'open-init-file)

(provide 'key-bindings)
