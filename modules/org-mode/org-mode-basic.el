;; set up org mode
(setq org-startup-indented t)

;; set org image
(setq org-image-actual-width (/ (display-pixel-width) 3))

;; Functions for inserting timestamps, Author: Perry E. Metzger
(defun insert-timestamp ()
  "Insert the date and time into the current buffer."
  (interactive)
  (insert (format-time-string "%a %b %e %Y, %R")))
(global-set-key "\C-ct" 'insert-timestamp)

;; keybinging for org-store-link
(global-set-key "\C-cl" 'org-store-link)
(provide 'org-mode-basic)

