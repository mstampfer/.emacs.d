(defun org-insert-scaled-screenshot ()
  "Insert a scaled screenshot 
for inline display 
into your org-mode buffer."
  (interactive)
  (let ((filename 
         (concat "screenshot-" 
                 (substring 
                  (shell-command-to-string 
                   "date +%Y%m%d%H%M%S")
                  0 -1 )
                 ".png")))
    (let ((scaledname 
           (concat filename "-width300.png")))

      (shell-command 
       (concat "import -window root " 
               filename))
      (shell-command 
       (concat "convert -adaptive-resize 300 " 
               filename " " scaledname))
      (insert (concat "[[./" scaledname "]]")))))
