;;-----------------------------------------
;; Setting Emace
;;-----------------------------------------
(load (locate-user-emacs-file "emacs.el"))
(add-to-load-path "elisp" "package")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(mkdir (tmp-directory))

;;-----------------------------------------
;; Load package
;;-----------------------------------------
(require 'package)
(package-initialize)
(defvar url-configuration-directory (tmp-directory "url"))
(setq package-user-dir (locate-user-emacs-file "package"))
(setq package-archives
      '(("gnu"          . "https://elpa.gnu.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("marmalade"    . "https://marmalade-repo.org/packages/")))

;;-----------------------------------------
;; encode(デフォルトをUTF-8に変更する)
;;-----------------------------------------
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;;---------------------------------------
;; indent
;;---------------------------------------
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(defvar c-basic-offset 2)
(defvar js-indent-level 2)

;;-----------------------------------------
;; bookmark（bookmark機能）
;;-----------------------------------------
(defvar bookmark-default-file (tmp-directory "bookmark"))
(defvar bookmark-save-flag 1)
(defvar bookmark-sort-flag nil)
(global-set-key (kbd "\C-c r l") 'bookmark-bmenu-list)
(global-set-key (kbd "\C-c r b") 'bookmark-jump)
(global-set-key (kbd "\C-c r m") 'bookmark-set)

;;-----------------------------------------
;; recentf（開いたファイルの自動保存）
;;-----------------------------------------
(defvar recentf-save-file (tmp-directory "recentf"))
(defvar recentf-max-saved-items 500)
(defvar recentf-auto-save-timer
      (run-with-idle-timer 30 t 'recentf-save-list))
(require 'recentf-ext)

;;-----------------------------------------
;; helm
;;-----------------------------------------
(require 'helm-config)
(helm-mode t)
(setq helm-M-x-requires-pattern 0)
(global-set-key (kbd "M-x")      'helm-M-x)
(global-set-key (kbd "M-y")      'helm-show-kill-ring)
(global-set-key (kbd "C-c o")    'helm-occur)
(global-set-key (kbd "C-c C-o")  'helm-occur)
(global-set-key (kbd "C-x b")    'helm-for-files)
(global-set-key (kbd "C-x C-b")  'helm-for-files)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)

(require 'helm-ag)
(custom-set-variables
 '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case --hidden")
 '(helm-ag-command-option "--all-text")
 '(helm-ag-insert-at-point 'symbol))
(global-set-key (kbd "C-c C-d") 'helm-do-ag)

;;-----------------------------------------
;; company-mode
;;-----------------------------------------
(require 'company)
(global-company-mode)
(global-set-key (kbd "C-c y") 'company-complete)
(setq company-idle-delay nil)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
(setq company-dabbrev-downcase nil)
(setq company-backends '(company-files company-dabbrev company-jedi company-inf-ruby))

(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

(set-face-attribute 'company-tooltip nil :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil :background "orange")
(set-face-attribute 'company-scrollbar-bg nil :background "gray40")

;;-----------------------------------------
;; paren-mode
;;-----------------------------------------
(show-paren-mode 1)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;;-----------------------------------------
;; find-files,dired時の自動補完を行わない
;;-----------------------------------------
(remove-hook
 'helm-after-update-hook
 'helm-ff-update-when-only-one-matched)

;;-----------------------------------------
;; key-combo
;;-----------------------------------------
(require 'key-combo)
(global-key-combo-mode t)

(key-combo-define-global
 (kbd "C-a")
 '(back-to-indentation
   beginning-of-line
   beginning-of-buffer
   key-combo-return))

(key-combo-define-global
 (kbd "C-e")
 '(end-of-line
   end-of-buffer
   key-combo-return))

;;-----------------------------------------
;; global-set-keys
;;-----------------------------------------
(global-set-key (kbd "C-x ?") 'help-command)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-u") 'repeat)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-x g") 'rgrep)
(global-set-key (kbd "C-x ,") 'backward-word)
(global-set-key (kbd "C-x .") 'forward-word)
(define-key global-map [f1] 'start-kbd-macro)
(define-key global-map [f2] 'end-kbd-macro)
(define-key global-map [f3] 'call-last-kbd-macro)

;;-----------------------------------------
;; kill line
;;-----------------------------------------
(setq kill-whole-line t)

;;-----------------------------------------
;; undo redo
;;-----------------------------------------
(require 'undo-tree)
(setq undo-no-redo t)
(global-undo-tree-mode)
(global-set-key (kbd "M-,") 'undo)
(global-set-key (kbd "M-.") 'redo)

;;-----------------------------------------
;; scroll step
;;-----------------------------------------
(setq scroll-step 1)

;;-----------------------------------------
;; 行ハイライト
;;-----------------------------------------
(custom-set-faces '(hl-line ((t (:background "color-236")))))
(global-hl-line-mode)

;;-----------------------------------------
;; dired ( DirctoryEditor )の拡張。
;;-----------------------------------------
(require 'dired-x)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;-----------------------------------------
;; Setting auto save
;;-----------------------------------------
(setq backup-inhibited t)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix (tmp-directory "auto-save-list"))

;;-----------------------------------------
;; mmm-mode
;;-----------------------------------------
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)

;; pattern mmm-mode
(mmm-add-classes
 '((css-tag :submode css-mode :front "<style[^>]*>[ \n]?" :back  "[ \n]?</style>")
   (js-tag  :submode js-mode :front "<script[^>]*>[ \n]?" :back  "[ \n]?</script>")
   (erb-tag :submode ruby-mode :front "<%[ \n]?" :back "[ \n]?%>")
   (gsp-tag :submode text-mode :front "<%[ \n]?" :back "[ \n]?%>")))

;; apply mmm-mode
(mmm-add-mode-ext-class 'html-mode nil 'css-tag)
(mmm-add-mode-ext-class 'html-mode nil 'js-tag)
(mmm-add-mode-ext-class 'html-mode "\\.erb$" 'erb-tag)
(mmm-add-mode-ext-class 'html-mode "\\.gsp$" 'gsp-tag)

;;---------------------------------------
;; tempbuf
;;---------------------------------------
(require 'tempbuf)
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)

;;---------------------------------------
;; filecache
;;---------------------------------------
(require 'filecache)
;; reset filecache
(defun file-cache-reset ()
  (interactive)
  (file-cache-clear-cache))

(file-cache-reset)
(global-set-key (kbd "\C-c c d") 'file-cache-add-directory)
(global-set-key (kbd "\C-c c t") 'file-cache-add-directory-recursively)

;;---------------------------------------
;; flycheck
;;---------------------------------------
(require 'let-alist)
(require 'flycheck)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(add-hook 'after-init-hook #'global-flycheck-mode)

;;---------------------------------------
;; 自動バッファ読み込み
;;---------------------------------------
(global-auto-revert-mode 1)

;;---------------------------------------------------------
;; uniquify
;;---------------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;---------------------------------------------------------
;; linum+
;;---------------------------------------------------------
(require 'linum+)
(global-linum-mode t)

;;---------------------------------------------------------
;; load-theme
;;---------------------------------------------------------
(load-theme 'clarity t)
(enable-theme 'clarity)

;;---------------------------------------------------------
;; indent-guide
;;---------------------------------------------------------
(require 'indent-guide)
(indent-guide-global-mode)

;;---------------------------------------------------------
;; clojure-mode
;;---------------------------------------------------------
(require 'clojure-mode)
(require 'cider-mode)

;; ruby magic comment
(setq ruby-insert-encoding-magic-comment nil)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)
