(define-minor-mode presentation-mode
  "Minor mode for the simple-mpc-query screen.
\\{simple-mpc-query-mode-map}."
  :lighter " presentation"
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map "<f1>" 'presentation-mode-previous-slide)
	    (define-key map "<f2>" 'presentation-mode-next-slide)
            map))

(defun presentation-mode-next-slide ()
  (interactive)
  (message "next"))

(defun presentation-mode-previous-slide ()
  (interactive)
  (message "previous"))

(provide 'presentation-mode)
