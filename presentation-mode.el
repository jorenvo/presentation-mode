(require 'dash)

(define-minor-mode presentation-mode
  "Minor mode for doing presentations.
\\{presentation-mode-map}."
  :lighter " presentation"
  :global t
  :keymap (let ((map (make-sparse-keymap)))
	    (define-key map (kbd "<f11>") 'presentation-mode-previous-slide)
	    (define-key map (kbd "<f12>") 'presentation-mode-next-slide)
            map))

(defun presentation-mode-previous-slide ()
  "Changes to the previous slide."
  (interactive)
  (presentation-mode-change-slide -1))

(defun presentation-mode-next-slide ()
  "Changes to the next slide."
  (interactive)
  (presentation-mode-change-slide 1))

(defun presentation-mode-change-slide (n)
  "Changes to a slide N positions from the current slide using `find-file'."
  (let* ((slides (directory-files default-directory))
         (slides (seq-filter (lambda (s) (not (string-prefix-p "." s))) slides))
         (slide-nr (-elem-index (file-relative-name buffer-file-name) slides))
         (new-slide-nr (+ slide-nr n)))
    (cond ((< new-slide-nr 0) (message "First slide reached."))
          ((>= new-slide-nr (length slides)) (message "Last slide reached."))
          (t (find-file (nth new-slide-nr slides))))))

(provide 'presentation-mode)
