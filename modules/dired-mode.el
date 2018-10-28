;; set only one buffer for dired mode
(put 'dired-find-alternate-file 'disabled nil)
;; set recursive as default
;; (setq dired-recursive-deletes 'always)
;; (setq dired-recursive-copies 'always)
;; ask before recursively deleting a directory, though
;; (setq dired-recursive-deletes 'top)
;; display dir first
;; (setq dired-listing-switches "-aBhl --group-directories-first")

;; set up ido mode
(require `ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(provide 'dired-mode)
