;;;;;; -*- coding:utf-8-unix -*-

;;; load-path に追加
(add-to-list 'load-path "~/.emacs.d/lisp")

;;; mylib.el をロード
(require 'mylib)

;;; exec-path
(when (or my/linuxp my/macp)
  (add-to-list 'exec-path "/usr/local/bin"))

;;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; 新規バッファのメジャーモード
(setq default-major-mode 'text-mode)

;;(load-theme 'misterioso t)
(load-theme 'zenburn t)

;;; デフォルトのフレーム
(add-to-list 'default-frame-alist '(alpha . (90 70)))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
;;; 最初のフレーム
(add-to-list 'initial-frame-alist '(alpha . (100)))

;;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;; c-mode 系
(add-hook 'c-mode-common-hook
          (lambda()
            (c-set-style "bsd")
            (setq c-basic-offset default-tab-width)
            (setq comment-start "//")
            (setq comment-end "")))
            ;; (smart-tabs-mode-enable)
            ;; (smart-tabs-advice c-indent-line c-basic-offset)
            ;; (smart-tabs-advice c-indent-region c-basic-offset)))

;;; markdown-mode
(require 'markdown-mode)
(setq my/md-css-template (concat
                          (file-name-as-directory (getenv "HOME"))
                          (file-name-as-directory ".emacs.d")
                          "md_template.css"))

(setq auto-mode-alist
      (cons '("\\.md" . gfm-mode) auto-mode-alist))

(add-hook 'markdown-mode-hook
          (lambda()
            (local-set-key "\C-i" 'markdown-cycle)
            (setq markdown-command "multimarkdown")))

;;; markdown-export したときに css のリンクを埋め込む。
(defadvice markdown-export (around my/md-copy-css activate)
  "Set a link of css file to markdown-xhtml-header-content,
and copy the css file to current directory."
  (let* (css-file
         css-link
         export-file
         (export-arg (ad-get-arg 0)))
    (if export-arg
        (setq export-file export-arg)
      (setq export-file (markdown-export-file-name ".html")))
    ;; set css link.
    (setq css-file (concat
                    (file-name-sans-extension export-file)
                   ".css"))
    (setq css-link (format "<link rel='stylesheet' href='%s' type='text/css' />"
                           (file-name-nondirectory css-file)))
    (setq markdown-xhtml-header-content css-link)
    ;; export.
    (ad-set-arg 0 export-file)
    ad-do-it
    ;; copy css file.
    (unless (file-exists-p css-file)
      (copy-file my/md-css-template css-file))))

;;; cperl-mode
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(add-hook 'cperl-mode-hook
          (lambda()
            (cperl-set-style "PerlStyle")
            (setq cperl-indent-level 4
                  cperl-close-paren-offset -4
                  cperl-continued-statement-offset 4
                  cperl-indent-parens-as-block t)))
            ;;       cperl-tab-always-indent t)
            ;; (smart-tabs-mode-enable)
            ;; (smart-tabs-advice cperl-indent-line cperl-indent-level)))

;;; org-mode
(add-hook 'org-mode-hook
          (lambda()
            (setq org-hide-leading-stars t)
            ;; C-tab が上書きされるので再度上書き。local-set-key とかだと効かない。
            (define-key org-mode-map [C-tab] 'my/other-window)))

;;; dired-mode
(load "dired-x")
(add-hook 'dired-mode-hook
          (lambda()
            (load "wdired")
            (setq ls-lisp-dirs-first t)
            (setq delete-by-moving-to-trash t)
            (setq dired-listing-switches "-alh")
            (setq dired-recursive-copies 'always)
            (setq dired-recursive-deletes 'always)
            (local-set-key "r"    'wdired-change-to-wdired-mode)
            (local-set-key "\M-c" 'my/dired-copy-to-other-window)
            (local-set-key "\M-r" 'my/dired-move-to-other-window)
            (local-set-key "b" 'dired-up-directory)
            (local-set-key "\C-t"  'my/other-window)))

;;; isearch-mode
;;(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
(define-key isearch-mode-map "\C-h" 'isearch-del-char)

;;; eshell-mode
(add-hook 'eshell-mode-hook
          (lambda()
            (add-to-list 'eshell-command-aliases-list (list "emacs" "find-file-other-window $1"))))

;;; dns-mode
(add-hook 'dns-mode-hook
          (lambda()
            (setq dns-mode-soa-auto-increment-serial "ask")))

;;; nxml-mode
(add-hook 'nxml-mode-hook
          (lambda()
            (setq nxml-slash-auto-complete-flag t)))

;;; twittering-mode
(require 'twittering-mode)
(setq twittering-use-master-password t) ; gpg コマンドが必要
(setq twittering-private-info-file "~/.emacs.d/twittering-mode.gpg")
(setq twittering-icon-mode t)
(setq twittering-timer-interval 600)
(setq twittering-number-of-tweets-on-retrieval 50)

;;; geeknote.el
(global-set-key (kbd "C-c g c") 'geeknote-create)
(global-set-key (kbd "C-c g e") 'geeknote-edit)
(global-set-key (kbd "C-c g f") 'geeknote-find)
(global-set-key (kbd "C-c g s") 'geeknote-show)
(global-set-key (kbd "C-c g r") 'geeknote-remove)
(global-set-key (kbd "C-c g m") 'geeknote-move)

;;; 一般
;; デフォルトのエンコード
(let (coding)
  (cond
   ((or my/linuxp my/macp)
    (setq coding 'utf-8-unix))
   (my/windowsp
    (setq coding 'shift_jis-dos)))
  (set-default-coding-systems coding))

;; GUI
(unless my/nwp
  ;; ツールバー類を消す
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  ;; スクロールバーを右に表示
  (set-scroll-bar-mode 'right))

;; C-h を BackSpace にする
(global-set-key "\C-h" 'delete-backward-char)

;; C-TAB と C-t を my/other-window にする
(global-set-key [C-tab] 'my/other-window)
(global-set-key "\C-t"  'my/other-window)

;; C-S-DEL と M-k を kill-whole-line にする
(global-set-key [\C-\S-\d] 'kill-whole_line)
(global-set-key "\M-k" 'kill-whole-line)

;; C-cmm を my/move-or-resize-frame にする
(global-set-key "\C-cmm" 'my/move-or-resize-frame)

;; M-kanji を無視
(global-set-key [M-kanji] 'ignore)

;; M-w を clipboard-kill-ring-save にする
(global-set-key "\M-w" 'clipboard-kill-ring-save)

;; C-cmr を my/insert-string-to-head-of-row にする
(global-set-key "\C-cmr" 'my/insert-string-to-head-of-row)

;; カッコをハイライト
(show-paren-mode t)
(setq show-paren-style 'expression)
;;(set-face-background 'show-paren-match-face "royal blue")

;; リージョンの色
;;(set-face-background 'region "sea green")

;; ミニバッファの色
;; (set-face-foreground 'minibuffer-prompt "gray40")
;; (face-spec-set 'minibuffer-prompt
;;                '((((class color) (background light))
;;                   (:foreground "cyan"))
;;                  (t (:foreground "white"
;;                                  :background "brown"))))

;; モードラインの色
;;(set-face-foreground 'mode-line-buffer-id "gray80")

;; モードラインに行と列を表示
(line-number-mode t)
(column-number-mode t)

;;; 左側に行数を表示
(require 'linum)
(global-linum-mode)
(if my/nwp
    (setq linum-format "%d "))

;; ビープ音をならなくするかわりに画面をフラッシュ
(setq visible-bell t)

;;; emacs終了時に自動保存ファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルのディレクトリ
(setq backup-directory-alist '(("." . "~/.emacs.d/_bk")))

;; C-x C-s で呼ばれる save-buffer 関数の引数を 16 にする。(デフォルトは 0)
;; 0  : セッション中、最初の保存時にしかバックアップファイルを作らない。
;;      (ファイルを開く前の状態のバックアップファイルが残る)
;; 16 : 保存時は常にバックアップファイルを作る。
(defun save-buffer-always-backup ()
  (interactive)
  (save-buffer 16))
(global-set-key "\C-x\C-s" 'save-buffer-always-backup)

;; 過去バージョンのバックアップファイルを残す
(setq version-control t)
(setq kept-new-versions 15)  ; 新しいものをいくつ残すか
(setq kept-old-versions 3)   ; 古いものをいくつ残すか
(setq delete-old-versions t) ; 古いバージョンを消すたびに許可を求めない

;; 終了時に確認する
(setq confirm-kill-emacs 'y-or-n-p);

;; whitespace
(require 'whitespace)
(setq whitespace-style
      '(face tabs
             spaces
             newline
             trailing
             ;; space-before-tab
             ;; space-after-tab
             space-mark
             tab-mark
             newline-mark))
;; (let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
;; (set-face-attribute 'whitespace-space nil
;;                     :foreground "yellow"
;;                     :background 'unspecified)
(set-face-attribute 'whitespace-trailing nil
                    :foreground "yellow"
                    :background 'unspecified
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground "grey50"
                    :background 'unspecified)
(set-face-attribute 'whitespace-newline nil
                    :foreground "darkcyan")
(setq whitespace-space-regexp "\\(　+\\)")
(setq whitespace-display-mappings
      '((space-mark   ?　    [?□]    [?＿]) ; full-width space - square
        (newline-mark ?\n    [?$ ?\n])       ; eol - dollar
        (tab-mark     ?\t    [?\xBB ?\t])    ; tab - left quote mark
        ;; (space-mark   ?\xA0  [?\xA4]  [?_]) ; hard space - currency
        ;; (space-mark   ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
        ;; (space-mark   ?\x920 [?\x924] [?_]) ; hard space - currency
        ;; (space-mark   ?\xE20 [?\xE24] [?_]) ; hard space - currency
        ;; (space-mark   ?\xF20 [?\xF24] [?_]) ; hard space - currency
        ))
(setq whitespace-global-modes '(not dired-mode tar-mode))
(global-whitespace-mode 1)

;; フォント
(unless my/nwp
  (if (file-exists-p "~/.emacs.d/lisp/myfont.el")
      (progn
        (load "~/.emacs.d/lisp/myfont.el")
        (let* ((ascii-family-name "Verdana")
               (japanese-family-name "VL Gothic")
               (height 135))
          (if (boundp 'my/font/ascii-family-name)
              (setq ascii-family-name my/font/ascii-family-name))
          (if (boundp 'my/font/japanese-family-name)
              (setq japanese-family-name my/font/japanese-family-name))
          (if (boundp 'my/font/height)
              (setq height my/font/height))

          ;; ascii
          (if (x-list-fonts ascii-family-name)
              (set-face-attribute 'default nil
                                  :family ascii-family-name
                                  :weight 'regular
                                  :height height))
          ;; japanese
          (if (x-list-fonts japanese-family-name)
              (set-fontset-font   nil
                                  'japanese-jisx0208
                                  (font-spec :family japanese-family-name)))))))

;; サーバー
(unless my/nwp
  (require 'server)
  (unless (server-running-p)
    (server-start)))

;;;;;; Emacs Wrotes...
(put 'erase-buffer 'disabled nil)
