 ;;; package --- Summary: my python-mode config file
;;; Requisites: Emacs >= 24

(require 'package)


(add-to-list 'package-archives
	     '("melpa" . "https://http://melpa.milkbox.net/packages/"))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/plugins")

(package-initialize)

(package-refresh-contents)

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

;; make more packages available with the package installer
(setq to-install
      '(python-mode magit yasnippet jedi auto-complete autopair find-file-in-repository flycheck realgud))

(mapc 'install-if-needed to-install)

(require 'magit)
(global-set-key "\C-xg" 'magit-status)

(require 'auto-complete)
(require 'autopair)
(require 'yasnippet)
(require 'flycheck)
(global-flycheck-mode t)

(global-set-key [f7] 'find-file-in-repository)

; auto-complete mode extra settings
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
(setq jedi:server-command
      '("python2" "/Users/marcel/.emacs.d/elpa/jedi-core-20160709.722/jediepcserver.py"))
(jedi:install-server)


(add-hook 'python-mode-hook
	  (lambda ()
	    (jedi:setup)
	    (jedi:ac-setup)
            (local-set-key "\C-cd" 'jedi:show-doc)
            (local-set-key (kbd "M-SPC") 'jedi:complete)
            (local-set-key (kbd "M-.") 'jedi:goto-definition)))
            (setq jedi:complete-on-dot t) 
(add-hook 'python-mode-hook 'auto-complete-mode)

(ido-mode t)

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


(load-theme 'idea-darkula t)
(jedi:install-server)
