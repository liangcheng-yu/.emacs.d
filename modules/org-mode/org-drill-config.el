(require 'org-drill)

;; How to use? https://bitbucket.org/eeeickythump/org-drill/src

(setq org-drill-maximum-items-per-session 10) ;; nil if want no termination
(setq org-drill-maximum-duration 100)   ; 100 minutes

;; (setq org-drill-save-buffers-after-drill-sessions-p nil)

;; (setq org-drill-spaced-repetition-algorithm 'sm2)

(provide 'org-drill-config)
