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

(provide 'ui)
