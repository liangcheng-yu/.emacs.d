;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)
;; set kill subtree protection with a query
(setq org-ctrl-k-protect-subtree 1)
;; auto-copy when selecting via mouse dragging
(setq mouse-drag-copy-region t)
;; full screen by default
(setq initial-frame-alist (quote ((fullscreen . maximized))))
;; create no backup files
(setq make-backup-files nil)
;; highlight current line
(global-hl-line-mode 1)
;; remove startup screen
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
;; the blinking cursor is nothing but an annoyance
(blink-cursor-mode -1)
;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)
;; set line number and column number at mode line
(line-number-mode t)
(column-number-mode t)
;; remove tool bar, menu bar, scroll bar for useful spaces
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

(provide 'basic)
