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
(org-babel-load-file (concat root-path "config.org"))



