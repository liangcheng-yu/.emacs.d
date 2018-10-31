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

;; the blinking cursor is nothing but an annoyance
(blink-cursor-mode -1)

;; delete the selection with a keypress
(delete-selection-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

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

;; highlighting text is so painful in org-mode!
;; remove the annoying the markers
(setq org-hide-emphasis-markers t)
;; perfer using / to highlight the key concepts as building blocks
(add-to-list 'org-emphasis-alist
             '("/" (:foreground "red")
               ))

(provide 'ui)
