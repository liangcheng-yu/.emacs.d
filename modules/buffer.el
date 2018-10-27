;; kill current buffer without prompting
(defun hrs/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

(provide 'buffer)
