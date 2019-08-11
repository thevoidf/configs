;; indent with tabs
(setq-default indent-tabs-mode t)
(setq-default tab-width 2)
(setq c-basic-offset 'tab-width)
(setq js-indent-level 2)
(setq css-indent-offset 2)

;; python 4 space tabs
(add-hook 'python-mode-hook
					(lambda ()
						(setq indent-tabs-mode t)
						(setq python-indent 4)
						(setq tab-width 4)))

;; fix c indentation
(setq c-default-style "bsd"
			c-basic-offset 2)

;; line numbers
(global-linum-mode t)
;; remove frigne (line number right border thing)
(set-fringe-mode 0)
;; line number padding
(setq linum-format " %d ")

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

;; y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; fix packages
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; setup melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defun install-packages (&rest packages) ;
	(mapcar
		(lambda (package)
			(if (package-installed-p package)
				nil
				(package-install package)
				package))
		packages))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; package list
(install-packages
 'powerline
 'paganini-theme
 'gruvbox-theme
 'elcord
 'auto-complete
 'web-mode
 'js2-mode
 'undo-tree
 'helm)

;; set theme
(load-theme 'gruvbox-dark-hard t)
;; set background color
(set-background-color "#000")
;; set linum colors
(set-face-background 'linum "#000")
(set-face-foreground 'linum "white")
;; set font
(set-default-font "Liberation Mono")
;; set font size
(set-face-attribute 'default (selected-frame) :height 150)
;; no italic
(set-face-italic-p 'italic nil)

;; set window size
(add-to-list 'default-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(width . 79))

;; auto complete
(ac-config-default)

;; discord rpc
;; (require 'elcord)
;; (elcord-mode)

;; js2 mode
(require 'js2-mode)
(setq js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(set-face-italic 'js2-function-param nil)

;; powerline
(require 'powerline)
(powerline-default-theme)

;; web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)

;; helm
(require 'helm-config)
(global-set-key (kbd "C-x p") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;; evil CTRL-C
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)

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

;; frame resize keys
(global-set-key (kbd "S-C-r") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-l") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-n") 'shrink-window)
(global-set-key (kbd "S-C-p") 'enlarge-window)

;; eshell clear
(defun eshell/clear ()
	"Clear the eshell buffer."
	(let ((inhibit-read-only t))
		(erase-buffer)
		(eshell-send-input)))

;; starting window position
(setq initial-frame-alist '((left . 660) (top . 100)))

(defun use-tabs (yes)
  "use tabs or spaces"
  (setq-default indent-tabs-mode yes))
