
;; set up org mode
(setq org-startup-indented t)
(setq org-startup-folded "showall")

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

;; set org-capture
;; http://www.zmonster.me/2018/02/28/org-mode-capture.html#org8af60bf
;; (global-set-key (kbd "C-c c") 'org-capture)
;; (setq org-default-notes-file "~/my-emacs/my-org-mode/random.org")
;; (setq org-capture-templates
;;       '(("u" "1" entry (file+headline "~/my-emacs/my-org-mode/english.org" "1")
;;          "* %^{2} \n- Previous: %^{3}\n- New: %^{4}\n- Example:\n %^{2}")
;;         ("c" "3" entry (file+headline "~/my-emacs/my-org-mode/english.org" "3")
;;          "* %^{4} \n- Synonym: %^{4}\n- Antonym: %^{2}\n- Confusing words: %^{3}\n- Example:\n %^{4}")))

(provide 'org-mode-basic)

