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

(provide 'cpp)
