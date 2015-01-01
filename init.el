;;ctrl-h�ǥХå����ڡ������Ȥ���
(global-set-key "\C-h" 'delete-backward-char)

;; ����������֤ιԿ���⡼�ɥ饤��Ԥ�ɽ������
(line-number-mode 1)
(global-linum-mode t)

;;���ܸ�Ķ���
(set-language-environment "Japanese")

;; �б������̤�ϥ��饤�Ȥ���
(show-paren-mode 1)

;; �б������̤ο�������
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; ���顼����ʤ�ʤ�����
(setq ring-bell-function 'ignore)

;; �����ץ˥󥰥�å�������ɽ�����ʤ�
(setq inhibit-startup-message t)

;; �Хå����åץե������������ʤ�
(setq make-backup-files nil)

;; ����������֤η����⡼�ɥ饤��Ԥ�ɽ������
(column-number-mode 1)

;; auto-install����
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup) 

;; MELPA�ɲå�ݥ��ȥ������
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;{}��ư����
(electric-pair-mode t)

;; ruby coding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;;ruby-mode indent
(setq ruby-deep-indent-paren-style nil)

;; ruby electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;; flymake-ruby����Ū����
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook 'flycheck-mode)

;; ruby end
(require 'ruby-end)
 
;;inf-ruby
(require 'inf-ruby)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

;; smart-compile
(require 'smart-compile)
(global-set-key (kbd "C-x c") 'smart-compile)
(global-set-key (kbd "C-x C-x") (kbd "C-x c C-m"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cl)

;; magit
(require 'magit)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)  
(global-auto-complete-mode t)

;;; helm
(require 'helm)
(require 'helm-mode)
(defadvice helm-mode (around avoid-read-file-name activate)
  (let ((read-file-name-function read-file-name-function)
	(completing-read-function completing-read-function))
    ad-do-it))
(setq completing-read-function 'my-helm-completing-read-default)
(defun my-helm-completing-read-default (&rest _)
  (apply (cond ;; [2014-08-11 Mon]helm�Ǥ�read-file-name�ϽŤ����餤��ʤ�
	  ((eq (nth 1 _) 'read-file-name-internal)
	   'completing-read-default)
	  (t
	   'helm--completing-read-default))
	 _))
