;;-----------------------------------------
;; utils
;;-----------------------------------------
(require 'cl)

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name
	       (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;-----------------------------------------
;; tmp directory
;;-----------------------------------------
(defun mkdir (path)
  (if (file-directory-p path) nil (make-directory path)))

(defun tmp-directory (&optional file-name)
  (let ((dir (file-truename "~/.tmp")))
    (if file-name (format "%s/%s" dir file-name) dir)))

;;-----------------------------------------
;; 障害対応 ( ls does not support --dired; see dired-use-ls-dired for more details )
;;-----------------------------------------
(let ((gls "/usr/local/bin/gls"))
    (if (file-exists-p gls) (setq insert-directory-program gls)))
