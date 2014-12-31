;;ctrl-hでバックスペースが使える
(global-set-key "\C-h" 'delete-backward-char)

;; カーソル位置の行数をモードライン行に表示する
(line-number-mode 1)
(global-linum-mode t)

;;日本語環境下
(set-language-environment "Japanese")

;; 対応する括弧をハイライトする
(show-paren-mode 1)

;; 対応する括弧の色の設定
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; オープニングメッセージを表示しない
(setq inhibit-startup-message t)

;; バックアップファイルを作成しない
(setq make-backup-files nil)

;; カーソル位置の桁数をモードライン行に表示する
(column-number-mode 1)

;; auto-install設定
(add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
(require 'auto-install)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup) 

;; MELPA追加リポジトリの設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;{}を自動入力
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

;; flymake-ruby　静的解析
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
  (apply (cond ;; [2014-08-11 Mon]helm版のread-file-nameは重いからいらない
	  ((eq (nth 1 _) 'read-file-name-internal)
	   'completing-read-default)
	  (t
	   'helm--completing-read-default))
	 _))
