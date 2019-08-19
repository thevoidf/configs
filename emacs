;; indentaion
(setq tab-size 2)

;; language spesific tabs
(setq-default c-basic-offset tab-size)
(setq-default js-indent-level tab-size)
(setq-default css-indent-offset tab-size)

;; python 4 space tabs
(add-hook 'python-mode-hook
					(lambda ()
						(setq indent-tabs-mode t)
						(setq python-indent 4)
						(setq tab-width 4)))

;; fix c indentation
(setq c-default-style "bsd"
			c-basic-offset 'tab-size)

;; god help us
(defun use-spaces ()
	(interactive)
	(setq-default indent-tabs-mode nil))

(defun use-tabs ()
	(interactive)
	(setq-default indent-tabs-mode t) 
	(setq-default tab-width 2))

;; use tabs by default
(add-hook 'text-mode-hook 'use-tabs)
(add-hook 'js-mode-hook 'use-spaces)
(add-hook 'js2-mode-hook 'use-spaces)
(add-hook 'python-mode-hook 'use-tabs)
(add-hook 'c-mode-hook 'use-tabs)
(add-hook 'c++-mode-hook 'use-tabs)
(add-hook 'html-mode-hook 'use-tabs)
(add-hook 'web-mode-hook 'use-tabs)
(add-hook 'shell-mode-hook 'use-tabs)
(add-hook 'lisp-mode-hook 'use-tabs)
(add-hook 'emacs-lisp-mode-hook 'use-tabs)

;; line numbers
(global-linum-mode t)
;; remove frigne (line number right border thing)
(set-fringe-mode 0)
;; line number padding
(custom-set-variables
 '(linum-format (quote " %2d ")))
;; hide toolbar
(tool-bar-mode -1)
;; no menu bar
(menu-bar-mode -1)
;; no scoll bar
(toggle-scroll-bar -1)
;; no wrap
(set-default 'truncate-lines t)

;; dont create stupid backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; proper scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; stop!
(setq custom-file "~/.emacs.d/custom.el")
(write-region "" nil custom-file)
(load custom-file)

;; y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; setup melpa
(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
(use-package doom-themes
  :ensure t)

;; set theme
(doom-themes-org-config)
(load-theme 'doom-one t)
;; set background color
(set-background-color "#000")
;; set linum colors
(set-face-background 'linum "#000")
(set-face-foreground 'linum "white")
;; set font
(set-face-attribute 'default nil
										:family "Roboto Mono Medium"
										:height 150)
;; no italic
(set-face-italic-p 'italic nil)

;; set window size
(add-to-list 'default-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(width . 79))

;; which-key
(use-package which-key
 :ensure t
 :init
 (which-key-mode))

(use-package undo-tree
 :ensure t)

;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t))

;; js2 mode
(use-package js2-mode
	:ensure t
	:config
	(setq js2-basic-offset tab-width)
	(setq js2-include-node-externs t)
	(setq js2-strict-missing-semi-warning nil))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(set-face-italic 'js2-function-param nil)

(use-package doom-modeline
	:ensure t
	:hook (after-init . doom-modeline-mode))

;; web mode
(use-package web-mode
 :ensure t)
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)

;; evil CTRL-u fix for some reason (has to be befoe evil require)
(setq evil-want-C-u-scroll t)

;; evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(setq backward-delete-char-untabify-method nil)
(setq-default evil-shift-width tab-size)

(use-package evil-collection
						 :after evil
						 :ensure t
						 :config
						 :custom (evil-collection-setup-minibuffer t)
						 :init (evil-collection-init))

;; all the icons
(use-package all-the-icons)

;; neotree
(use-package neotree
	:ensure t
	:bind
	("C-c t" . 'neotree-toggle)
	:init
	(setq neo-window-fixed-size nil)
	(setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; evil commentary
(use-package evil-commentary
	:ensure t)
(evil-commentary-mode)

;; projectile
(use-package projectile
	:ensure t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/Projects"))
(add-to-list 'projectile-globally-ignored-directories "node_modules")

;; helm
(use-package helm
	:ensure t
	:bind
	("C-c f" . 'helm-find-files)
	("C-c b" . 'helm-mini)
	("M-x" . 'helm-M-x))

;; helm projectile
(use-package helm-projectile
	:ensure t)
(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
(define-key evil-normal-state-map (kbd "C-o") 'helm-buffers-list)

;; company
(use-package company
						 :ensure t)
(setq company-minimum-prefix-length 1)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)

;; magit
(use-package magit
  :ensure t
  :config)

;; magit evil
(use-package evil-magit
  :ensure t)

;; esc to C-c madness
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-motion-state-map (kbd "C-c") 'evil-normal-state)
(evil-define-key 'insert magit-file-mode-map (kbd "C-c") 'evil-normal-state)
(evil-define-key 'insert magit-file-mode-map (kbd "C-c") 'evil-normal-state)
(evil-define-key 'insert magit-file-mode-map (kbd "C-c") 'evil-normal-state)
(eval-after-load "term"
								 '(progn (term-set-escape-char ?\C-c)
												 (evil-define-key 'insert term-raw-map (kbd "C-c") 'evil-normal-state)))

;; format entire file
(defun indent-buffer ()
	(interactive)
	(save-excursion
		(tabify (point-min) (point-max) nil)
		(indent-region (point-min) (point-max) nil)))

(global-set-key (kbd "C-S-f") 'indent-buffer)
(global-set-key (kbd "C-S-m") 'goto-match-paren)

;; open .h with c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; nice resize
(global-set-key (kbd "C-h") 'shrink-window-horizontally)
(global-set-key (kbd "C-l") 'enlarge-window-horizontally)
(global-set-key (kbd "C-j") 'enlarge-window)
(global-set-key (kbd "C-k") 'shrink-window)

;; default window position and size
(setq initial-frame-alist
			'(
				(width . 70)
				(height . 35)
				(left . 940)
				(top . 80)))
