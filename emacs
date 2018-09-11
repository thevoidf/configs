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

;; setup melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
										(not (gnutls-available-p))))
			 (proto (if no-ssl "http" "https")))
	;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
	(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
	;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
	(when (< emacs-major-version 24)
		;; For important compatibility libraries like cl-lib
		(add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; set theme
(load-theme 'paganini t)
;; set background color
(set-background-color "#000")
;; set linum colors
(set-face-background 'linum "#000")
(set-face-foreground 'linum "white")
;; set font
(set-default-font "Liberation Mono")
;; set font size
(set-face-attribute 'default (selected-frame) :height 117)
;; no italic
(set-face-italic-p 'italic nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set window size
(add-to-list 'default-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(width . 79))

;; auto complete
(ac-config-default)

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

;; vim % thing
(defun goto-match-paren (arg)
	"Go to the matching parenthesis if on parenthesis, otherwise insert %.
	 vi style of % jumping to matching brace."
	(interactive "p")
	(cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
				((looking-at "\\s\)") (forward-char 1) (backward-list 1))
				(t (self-insert-command (or arg 1)))))

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
(setq initial-frame-alist '((left . 560) (top . 40)))

;; reload config with f5
(global-set-key (kbd "<f5>")
								(lambda()
									(interactive)
									(load-file "~/.emacs")))

;; NOTE
;; C-u C-x =
;; to show face details

;; toggle term-mode easily
(require 'term)

(defun term-toggle-mode ()
	"Toggles term between line mode and char mode"
	(interactive)
	(if (term-in-line-mode)
			(term-char-mode)
		(term-line-mode)))

(define-key term-mode-map (kbd "C-j") 'term-toggle-mode)
(define-key term-mode-map (kbd "C-j") 'term-toggle-mode)
(define-key term-raw-map (kbd "C-j") 'term-toggle-mode)
(define-key term-raw-map (kbd "C-j") 'term-toggle-mode)
