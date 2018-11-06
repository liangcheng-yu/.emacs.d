;; version check
(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;; add packet archive melpa
(when (>= emacs-major-version 24)
     (require 'package)
;;     (package-initialize)
;;     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;			      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
)
;; manually install packages via:
;; M-x package-install RET markdown-mode

(defconst root-path "~/emacs.d/")
(defconst contrib-path "~/emacs.d/tmp/org-mode/contrib/lisp/")
(org-babel-load-file (concat root-path "config.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-drill-optimal-factor-matrix (quote ((1 (2.6 . 4.14) (1.7000000000000002 . 3.44))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
