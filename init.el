;;; package --- Summary: my python-mode config file
;;; Requisites: Emacs >= 24
;;; Commentary --- init.el

;; be able to download packages and install them.
(require 'package)

;; 
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'load-path "/Users/marcel/.emacs.d/user-lisp/")

;; Load Emacs Lisp packages, and activate them.
(package-initialize)

;; Download the ELPA archive description if needed.
(package-refresh-contents)

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

;; make more packages available with the package installer
(setq to-install
      '(python-mode magit yasnippet jedi auto-complete autopair
		    find-file-in-repository flycheck realgud helm projectile helm-projectile
		    flx-ido))

(mapc 'install-if-needed to-install)

nd-key is also a helpful tool which gives you a cleaner syntax
;; The bind-key package shows you what bindings you've already used
;; and if you've shadowed some built-in bindings. It also has a
;; function for defining your own bindings,
(install-if-needed "bind-key")

;; key-bindings has a Function Of the same name that shows you all
;; your currently unused key-bindings.  bind-key is also a helpful
;; tool which gives you a cleaner syntax for defining your own
;; bindings. Bind it to "C-h C-k"
(install-if-needed "key-bindings")
(bind-key "C-h C-k" 'free-keys)
(bind-key "C-h C-K" 'describe-personal-keybindings)

;; bind comment toggle to "M-c" since "M-;" has the habit of putting
;; comments at the EOL instead of the front
(bind-key "M-C" 'toggle-comment)


;; ensure environment variables inside Emacs look the same as in the
;; user's shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; hide toolbar and scrollbar
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; async.el is a module for doing asynchronous processing in Emacs.
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;;A Git porcelain inside Emacs
(require 'magit)
(global-set-key "\C-xg" 'magit-status)

;; Auto Completion for GNU Emac
(require 'auto-complete)

;; Automagically pair braces and quotes like TextMate
(require 'autopair)

;; Yet another snippet extension for Emacs.
(require 'yasnippet)

;; On-the-fly syntax checking
(require 'flycheck)

;; Helm is an Emacs incremental and narrowing framework
(require 'helm-config)

(global-flycheck-mode t)

;; open browser with search pattern in Google01
(global-set-key [f5] 'helm-google-suggest)

;; Use Helm to match M-x occur patterns
(global-set-key [f6] 'helm-occur)

;;(global-set-key [f7] 'find-file-in-repository)

;;Recursively grep for REGEXP in FILES in directory tree rooted at DIR
(global-set-key [f8] 'rgrep)

;; Run projectile or helm-for-files depending if cwd is a project 
(global-set-key [f9] 'cwd-open-file)


;; auto-complete mode extra settings
(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20)

;; ;; Python mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(setq py-electric-colon-active t)
(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
;; 
;; ;; Jedi settings
(require 'jedi)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.
;; With the same interpreter you're using.
 
;; if you need to change your python intepreter, if you want to change it
;; (setq jedi:server-command
;;       '("python2" "/Users/marcel/.emacs.d/elpa/jedi-core-20160709.722/jediepcserver.py"))
(jedi:install-server)			


(add-hook 'python-mode-hook
	  (lambda ()
	    (jedi:setup)
	    (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)
            (local-set-key (kbd "C-SPC") 'jedi:complete)
	    ))
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'projectile-mode)

(setq inhibit-startup-screen t)
(setq jedi:complete-on-dot t)
(package-install 'realgud)
(load-library "realgud")
(load-library "cwd-projectile")
(load-library "view-debug-line-number")
(load-library "comment-uncomment-lines")

;; enable ido enable basic Ido support for files and buffers
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)


(setq apropos-sort-by-scores t)

;; ;; -------------------- extra nice things --------------------
;; ;; use shift to move around windows
;; (windmove-default-keybindings 'shift)
;; (show-paren-mode t)
;;  ; Turn beep off
;; (setq visible-bell nil)
; Add cmake listfile names to the mode list.
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t)

;; Turn on line numbers globally
(global-linum-mode t)

;;(load-theme 'idea-darkula t)
(load-theme 'tangotango t)

;;
(jedi:install-server)

;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-styles (quote (substring)))
 '(custom-safe-themes
   (quote
    ("cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(delete-selection-mode t)
 '(global-subword-mode t)
 '(global-superword-mode t)
 '(icicle-mode t)
 '(kill-whole-line t))

;; Rebind "M-o" to move between windows duplicating "C-o" since its
;; a very common thing to do
(global-set-key (kbd "M-o") 'other-window)

;; Apply a list of face specs for user customizations.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; modify the behavior of C-w – the command that kills the active
;; region – so it kills the current line the point is on if there
;; are no active regions.
;; Note: doesn't seem to work
;;(install-if-needed 'whole-line-or-region)



(provide 'init)
;;; init.el ends here
