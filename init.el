;;; package --- Summary: my python-mode config file
;;; Requisites: Emacs >= 24

;; be able to download packages and install them.
(require 'package)

;; 
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/plugins")

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
		    find-file-in-repository flycheck realgud))

(mapc 'install-if-needed to-install)

;; ensure environment variables inside Emacs look the same as in the user's shell.
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; hide toolbar and scrollbar
(tool-bar-mode 0)
(scroll-bar-mode 0)

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
(global-flycheck-mode t)

;;
(global-set-key [f7] 'find-file-in-repository)

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
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))
(add-hook 'python-mode-hook 'auto-complete-mode)	  

(setq inhibit-startup-screen t)
(setq jedi:complete-on-dot t)
(package-install 'realgud)
(load-library "realgud")
(ido-mode t)
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

;; 
 '(completion-styles (quote (substring)))

;; 
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))

 ;; When the region is active and you type text into the buffer, Emacs will delete the selected text first
 '(delete-selection-mode t)


 ;; Minor mode that treats CamelCase/snake-case as distinct words
 '(global-subword-mode t)
 '(global-superword-mode t)


 ;;  toggle minibuffer input completion and cycling. 
 '(icicle-mode t))

;; Apply a list of face specs for user customizations.
 '(Custom-set-faces)

;; Rebind "M-o" to move between windows duplicating "C-o" since its
;; a very common thing to do
(global-set-key (kbd "M-o") 'other-window)

;; Apply a list of face specs for user customizations.
(custom-set-faces)
