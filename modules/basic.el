;; personal information
(setq user-full-name "Liangcheng Yu"
      user-mail-address "liangcheng.yu46@gmail.com"
      calendar-location-name "somewhere")

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; warn when opening files > 500MB
(setq large-file-warning-threshold 500000000)

;; enable debugging
(setq debug-on-error t)

;; set kill subtree protection with a query
(setq org-ctrl-k-protect-subtree 1)

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

;; set up ido mode
(require `ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(provide 'basic)
