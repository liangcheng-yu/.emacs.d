;; upon starting
;; enable debugging
(setq debug-on-error t)
;; version check
(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; Measure startup time
(require 'init-benchmarking)

;; personal information
(setq user-full-name "Liangcheng Yu"
      user-mail-address "liangcheng.yu46@gmail.com"
      calendar-location-name "somewhere")

;; prefer material theme
(load-theme 'material t)

;; warn when opening files > 500MB
(setq large-file-warning-threshold 500000000)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; set a default font
;; hack
;; (add-to-list 'default-frame-alist '(font . "Hack"))
;; (set-face-attribute 'default nil
;;		    :family "Hack")
;; source code pro
;; (set-face-attribute 'default nil
;                     :family "Source Code Pro"
;;                     :height 110
;;                     :weight 'normal
;;                     :width 'normal)
;; mono font
;;(add-to-list 'default-frame-alist
;;             '(font . "DejaVu Sans Mono-10"))

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

;; F2 for hooking init.el file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

;; for convenience
;; auto-copy when selecting via mouse dragging
(setq mouse-drag-copy-region t)
;; full screen by default
(setq initial-frame-alist (quote ((fullscreen . maximized))))
;; create no backup files
(setq make-backup-files nil)
;; show line number, not recommended for large emacs file
;; (global-linum-mode 1)
;; highlight current line
(global-hl-line-mode 1)
;; do not truncate lines
(setq-default truncate-partial-width-windows nil)
(setq-default truncate-lines nil)
;; set org image
(setq org-image-actual-width (/ (display-pixel-width) 3))
;; set kill subtree protection with a query
(setq org-ctrl-k-protect-subtree 1)

;; Functions for inserting timestamps, Author: Perry E. Metzger
(defun insert-timestamp ()
  "Insert the date and time into the current buffer."
  (interactive)
  (insert (format-time-string "%a %b %e %Y, %R")))
(global-set-key "\C-ct" 'insert-timestamp)

;; babel
;; to simplify init.el, it will look over the doc and evaluate all code blocks that are emacs lisp sequentially
;; (org-babel-load-file "~/.emacs.d/config.org")

;; UI perferences
;; remove tool bar, menu bar, scroll bar for useful spaces
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
;; set line number and column number at mode line
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
;; highlight the current line
(global-hl-line-mode)
;; remove startup screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
;; set customized scratch msg
(setq initial-scratch-message "The Editor of a Lifetime: I dont care about the OS i use, it is just a boot loader for Emacs anyway.")
;; the blinking cursor is nothing but an annoyance
(blink-cursor-mode -1)
;; delete the selection with a keypress
(delete-selection-mode t)
;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; set only one buffer for dired mode
(put 'dired-find-alternate-file 'disabled nil)
;; set recursive as default
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; ask before recursively deleting a directory, though
(setq dired-recursive-deletes 'top)
;; display dir first
;; (setq dired-listing-switches "-aBhl --group-directories-first")

;; kill current buffer without prompting
(defun hrs/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

;; add packet archive melpa
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; set agenda related
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/my-emacs/my-org-mode/"))
;; (setq org-agenda-files '("~/my-emacs/my-org-mode/root.org"
;;			 "~/my-emacs/my-org-mode/machinelearning.org"
;;			 ))
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.
PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))
(setq org-agenda-custom-commands
      '(("d" "Daily agenda and all TODOs"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "" ((org-agenda-ndays 1)))
          (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled deadline))))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         ((org-agenda-compact-blocks t)))))
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (air-org-skip-subtree-if-priority ?A)
                          (org-agenda-skip-if nil '(scheduled deadline))))))))))

;; link
;; keybinging for org-store-link
(global-set-key "\C-cl" 'org-store-link)

;; set org-capture
;; http://www.zmonster.me/2018/02/28/org-mode-capture.html#org8af60bf
;; (global-set-key (kbd "C-c c") 'org-capture)
;; (setq org-default-notes-file "~/my-emacs/my-org-mode/random.org")
;; (setq org-capture-templates
;;       '(("u" "1" entry (file+headline "~/my-emacs/my-org-mode/english.org" "1")
;;          "* %^{2} \n- Previous: %^{3}\n- New: %^{4}\n- Example:\n %^{2}")
;;         ("c" "3" entry (file+headline "~/my-emacs/my-org-mode/english.org" "3")
;;          "* %^{4} \n- Synonym: %^{4}\n- Antonym: %^{2}\n- Confusing words: %^{3}\n- Example:\n %^{4}")))

;; org bullets settings
;; customize org-bullet symbol set https://github.com/sabof/org-bullets
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; use org-bullets-mode for utf8 symbols as org bullets
(require 'org-bullets)
;; make available "org-bullet-face" such that I can control the font size individually
(setq org-bullets-face-name (quote org-bullet-face))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("✙" "♱" "♰" "☥" "✞" "✟" "✝" "†" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"))
;; hexagrams
;; “✡” “⎈” “✽” “✲” “✱” “✻” “✼” “✽” “✾” “✿” “❀” “❁” “❂” “❃” “❄” “❅” “❆” “❇”
;; yinyang
;; “☯” “☰” “☱” “☲” “☳” “☴” “☵” “☶” “☷”
;; poker sybmols
;; “♠” “♣” “♥” “♦” “♤” “♧” “♡” “♢”
;; crosses
;; "✙" "♱" "♰" "☥" "✞" "✟" "✝" "†" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"
;; special symbols
;; “☀” “♼” “☼” “☾” “☽” “☣” “§” “¶” “‡” “※” “✕” “△” “◇” “▶” “◀” “◈”
;; notice "" symbol

;; backup strategy
;; set 0 for make-backup-files if one dont generte ~ file 
(setq make-backup-files t)
;; keep oldest 2 versions
(setq kept-old-versions 2)
;; keep latest 2 verstions
(setq kept-new-versions 2)
;; remove other versions
(setq delete-old-versions t)
;; where to store backup files
(setq backup-directory-alist '(("" . "~/.emacsbackup")))

;; C++ mode configuration
;; copy from somewhere
(defvar xgp-cfsi-left-PAREN-old nil
  "Command used to input \"(\"")
(make-variable-buffer-local 'xgp-cfsi-left-PAREN-old)
(defun xgp-cfsi-modify-alist (alist term new)
  (let ((tl (assq term (symbol-value alist))))
    (if tl
        (setcdr tl new)
      (add-to-list alist (cons term new)))))
(defun xgp-cfsi (style)
  "Deciding whether using CFSI."
  (interactive "Style: ")
  (c-set-style style)
  (setq indent-tabs-mode
        nil
        c-hanging-semi&comma-criteria
        (quote (c-semi&comma-inside-parenlist)))
  (xgp-cfsi-modify-alist 'c-hanging-braces-alist 'class-open nil)
  (xgp-cfsi-modify-alist 'c-hanging-braces-alist 'class-close nil)
  (local-set-key " " 'self-insert-command))
(defun xgp-cfsi-erase-blanks ()
  "Erase all trivial blanks for CFSI."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "[ \t]+$" nil t)
      (replace-match "" nil nil))))
(defun linux-c-mode()
  (define-key c-mode-map [return] 'newline-and-indent)
  (setq imenu-sort-function 'imenu--sort-by-name)
  (interactive)
  (imenu-add-menubar-index)
  (which-function-mode)
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq indent-tabs-mode nil)
  (xgp-cfsi "linux"))
(add-hook 'c-mode-common-hook 'linux-c-mode)
;; company mode for auto completion <TODO> http://company-mode.github.io
