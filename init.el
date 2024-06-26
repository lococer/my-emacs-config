;;;
;;; This is lococ's emacs configuration
;;;

;;;
;;; package part
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(global-company-mode 1)
(define-key company-active-map (kbd "C-j" ) 'company-select-next)
(define-key company-active-map (kbd "C-k" ) 'company-select-previous)

(use-package evil
    :ensure t
    :init
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (evil-mode)

    (with-eval-after-load 'evil-maps
	(define-key evil-motion-state-map (kbd "RET") nil))
)

(package-install 'vertico)
(vertico-mode t)


(package-install 'orderless)
(setq completion-styles '(orderless))

(package-install 'key-chord)
(key-chord-mode 1)
;;; package part ends here
;;;

;;;
;;; basic configuration
(electric-pair-mode t)
(global-auto-revert-mode t)
;;; basic configuration ends here
;;; 

;;;
;;; key-bindings
(global-set-key (kbd "<f2>") 'open-init-file)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
;;; key-bindings ends here
;;;

;;;
;;; self-define function
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;;; self-define function ends here
;;;
