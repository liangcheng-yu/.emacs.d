;; version check
(let ((minver "25.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;; Measure startup time
(add-to-list 'load-path "~/.emacs.d/modules/")
(require 'benchmarking)

;; prefer material theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/modules/themes/")
(load-theme 'material t)

(require 'basic)
(require 'org-mode)
(require 'key-bindings)

;; babel
;; to simplify init.el, it will look over the doc and evaluate all code blocks that are emacs lisp sequentially
;; (org-babel-load-file "~/.emacs.d/config.org")

;; UI perferences
(require 'ui)

(require 'dired)
(require 'buffer)

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

;; set agenda related
(require 'agenda)

;; org bullets settings
;; customize org-bullet symbol set https://github.com/sabof/org-bullets
(add-to-list 'load-path "~/.emacs.d/modules/")
;; use org-bullets-mode for utf8 symbols as org bullets
(require 'org-bullets)

(add-to-list 'load-path "~/.emacs.d/modules/lang/")
(require 'cpp)

(add-to-list 'load-path "~/.emacs.d/modules/app/")
(require 'web-browsing)
