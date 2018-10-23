;; personal information
(setq user-full-name "Liangcheng Yu"
      user-mail-address "liangcheng.yu46@gmail.com"
      calendar-location-name "somewhere")

;; prefer material theme
(load-theme 'material t)

;; set a default font
;; hack
;; (add-to-list 'default-frame-alist '(font . "Hack"))
;; (set-face-attribute 'default nil
;;		    :family "Hack")
;; source code pro
;; (set-face-attribute 'default nil
;;                     :family "Source Code Pro"
;;                     :height 110
;;                     :weight 'normal
;;                     :width 'normal)
;; momo
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-10"))

;; set hot key for mark, esp, for MAC, less convenient alternatives: C+@, or C-x C-x
(global-set-key (kbd "M-SPC") 'set-mark-command) 

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
(set-default 'truncate-lines nil)
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
;; highlight the current line
(global-hl-line-mode)
;; remove startup screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
;; set customized scratch msg
(setq initial-scratch-message "The Editor of a Lifetime: I dont care about the OS i use, it is just a boot loader for Emacs anyway.")

;; set only one buffer for dired mode
(put 'dired-find-alternate-file 'disabled nil)
;; set recursive as default
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; ask before recursively deleting a directory, though
(setq dired-recursive-deletes 'top)

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
