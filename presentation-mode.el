;;; presentation-mode.el
;;
;; Copyright (C) 2018 Joren Van Onder <joren.vanonder@gmail.com>

;; Author: Joren Van Onder <joren.vanonder@gmail.com>
;; Maintainer: Joren Van Onder <joren.vanonder@gmail.com>
;; Version: 1.0

;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
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
  (let* ((slides (directory-files default-directory nil "^.*\\.org"))
         (slides (seq-filter (lambda (s) (not (string-prefix-p "." s))) slides))
         (slide-nr (-elem-index (file-relative-name buffer-file-name) slides))
         (new-slide-nr (+ slide-nr n)))
    (cond ((< new-slide-nr 0) (message "First slide reached."))
          ((>= new-slide-nr (length slides)) (message "Last slide reached."))
          (t (find-file (nth new-slide-nr slides))))))

(provide 'presentation-mode)
