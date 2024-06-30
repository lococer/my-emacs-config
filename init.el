;;;
;;; This is lococ's emacs configuration
;;;

;;;
;;; package part


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

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :custom (undo-tree-auto-save-history nil)
  :bind(
	)
  )

(use-package org
  :ensure t
  )


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
		 ("C-c n u" . org-roam-ui-mode)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol )
  (require 'org-roam-dailies)
  )

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  )

(use-package vertico
  :ensure t
  :config
  (vertico-mode)
  (use-package orderless
	:ensure t
	:custom
	(completion-styles '(orderless basic))
	(completion-category-defaults nil)
	(completion-category-overrides '((file (styles partial-completion))))
	)
  )

(package-install 'orderless)
(setq completion-styles '(orderless))

(package-install 'key-chord)
(key-chord-mode 1)

(use-package pyim
  :ensure t
  :config
  (setq default-input-method "pyim")
  (setq pyim-page-tooltip 'popup)
  (setq pyim-page-tooltip 'popon)
  (setq pyim-cloudim 'baidu)
  (define-key pyim-mode-map "=" 'pyim-page-next-page)
  (define-key pyim-mode-map "-" 'pyim-page-previous-page)
  )
(use-package pyim-basedict
:ensure t
:config (pyim-basedict-enable)
 )

(use-package popup
  :ensure t
  )
(use-package popon
  :ensure t
  )

(use-package all-the-icons
  :ensure t
  :if(display-graphic-p)
 )

(use-package powerline
  :ensure t
 )

(use-package realgud
  :ensure t
  )

(use-package which-key
  :ensure t
  :custom
  (which-key-popup-type 'side-window)
  :config
  (which-key-mode)
  )

(use-package posframe
  :ensure t
  )

(use-package dap-mode
  :ensure t
  :config
  (dap-mode t)
  )

(use-package lsp-mode
  :ensure t
 )
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; (setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
;;     projectile hydra flycheck company avy which-key helm-xref dap-mode))

;; (when (cl-find-if-not #'package-installed-p package-selected-packages)
;;   (package-refresh-contents)
;;   (mapc #'package-install package-selected-packages))

;; (helm-mode)
;; (require 'helm-xref)
;; (define-key global-map [remap find-file] #'helm-find-files)
;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
;; (define-key global-map [remap switch-to-buffer] #'helm-mini)

;; (which-key-mode)
;; (add-hook 'c-mode-hook 'lsp)
;; (add-hook 'c++-mode-hook 'lsp)

;; (setq gc-cons-threshold (* 100 1024 1024)
;;       read-process-output-max (* 1024 1024)
;;       treemacs-space-between-root-nodes nil
;;       company-idle-delay 0.0
;;       company-minimum-prefix-length 1
;;       lsp-idle-delay 0.1)  ;; clangd is fast

;; (with-eval-after-load 'lsp-mode
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;   (require 'dap-cpptools)
;;   (yas-global-mode))

;;; package part ends here
;;;

;;;
;;; basic configuration

(load-theme 'modus-vivendi)

(electric-pair-mode t)
(global-auto-revert-mode t)

(setq scroll-step 1)
(setq scroll-conservatively 10000)

(setq tab-width 4)


;; org-todo-keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

(show-paren-mode t)

;;(set-frame-parameter nil 'alpha '(80 . 80))
(set-cursor-color "DarkOrchid3")

(require 'dap-cpptools)

;;; basic configuration ends here
;;; 

;;;
;;; key-bindings
(global-set-key (kbd "<f2>") 'open-init-file)
(global-set-key (kbd "C-<f2>") 'reload-init-file)
(global-set-key (kbd "C-SPC") 'toggle-input-method)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(define-key undo-tree-visualizer-mode-map (kbd "RET") 'undo-tree-visualizer-quit)
(global-set-key (kbd "C-s") 'save-buffer)
;;; key-bindings ends here
;;;

;;;
;;; self-define function
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun reload-init-file()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; don't work
(defun toggle-roam-ui()
	(interactive)
	(let ((ui-mode (symbol-value 'org-roam-ui-mode)))
	  (if (eq ui-mode 'nil)
		  (progn
			(setq org-roam-ui-mode 't)
			(message "roam-ui on"))
		(progn
		  (setq org-roam-ui-mode 'nil)
		  (message "roam-ui off"))
	  )
	)
)
;;; self-define function ends here
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet which-key vertico undo-tree realgud pyim-basedict pyim projectile powerline popup popon org-roam-ui orderless key-chord helm-xref helm-lsp flycheck evil dape dap-mode counsel company all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
