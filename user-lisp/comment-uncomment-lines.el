(defun toggle-comment () 
  (interactive) 
  (let ((start (line-beginning-position)) 
	(end (line-end-position))) 
    (when (region-active-p) 
      (setq start 
	    (save-excursion 
	      (goto-char (region-beginning)) 
	      (beginning-of-line) 
	      (point))
	    end 
	    (save-excursion 
	      (goto-char (region-end)) 
	      (end-of-line) 
	      (point)))) 
    (comment-or-uncomment-region start end)))
