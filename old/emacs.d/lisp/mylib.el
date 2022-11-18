;;;;;; -*- coding:utf-8-unix -*-

;;; 環境
(setq my/linuxp   (eq system-type 'gnu/linux))
(setq my/windowsp (eq system-type 'windows-nt))
(setq my/macp     (eq system-type 'darwin))
(setq my/nwp      (eq window-system nil))

;;; other-window を便利に
(defun my/other-window()
  "If other-window-p is non-nil, call `split-window'.
If nil, call `other-window'."
  (interactive)
  (if (one-window-p)
      (split-window)
    (other-window 1)))

;;; フレームを移動 (オフセット指定)
(defun my/move-frame-by-offset(offset-t offset-l)
  "Move current frame by offset."
  (let ((curr-t (cdr (assq 'top (frame-parameters))))
        (curr-l (cdr (assq 'left (frame-parameters)))))
    (modify-frame-parameters nil
                             (list (cons 'top (+ offset-t curr-t))
                                   (cons 'left (+ offset-l curr-l))))))

;;; フレームサイズを変更 (オフセット指定)
(defun my/resize-frame-by-offset(offset-h offset-w)
  "Resize current frame by offset."
  (let ((curr-h (cdr (assq 'height (frame-parameters))))
        (curr-w (cdr (assq 'width (frame-parameters)))))
    (modify-frame-parameters nil
                             (list (cons 'height (+ offset-h curr-h))
                                   (cons 'width (+ offset-w curr-w))))))

;;; 対話的にフレーム位置とサイズを変更
(defun my/move-or-resize-frame()
  "Move or resize frame interactively."
  (interactive)
  (message "Move|Resize frame. To quit, type 'q'")
  (let (key (continue t))
    (while continue
      (condition-case err
          (setq key (read-char))
        (error (message "An error has occured. Quit function.")
               (setq key ?q)))
      (cond
       ((= key ?\C-f) (my/move-frame-by-offset 0 20))
       ((= key ?\C-b) (my/move-frame-by-offset 0 -20))
       ((= key ?\C-n) (my/move-frame-by-offset 20 0))
       ((= key ?\C-p) (my/move-frame-by-offset -20 0))
       ((= key ?\M-f) (my/resize-frame-by-offset 0 5))
       ((= key ?\M-b) (my/resize-frame-by-offset 0 -5))
       ((= key ?\M-n) (my/resize-frame-by-offset 5 0))
       ((= key ?\M-p) (my/resize-frame-by-offset -5 0))
       ((= key ?q) (setq continue nil))
       (t)))))

;;; dired でファイルを other-window にコピー
;;; (http://www49.atwiki.jp/ntemacs/pages/19.html から)
(defun my/dired-copy-to-other-window (arg)
    "In dired, copy selected file(s) to the other window."
    (interactive "P")
    (let ((dired-dwim-target t))
        (dired-do-copy arg)))

;;; dired でファイルを other-window に移動
;;; (http://www49.atwiki.jp/ntemacs/pages/19.html から)
(defun my/dired-move-to-other-window (arg)
    "In dired, rename selected file(s) to the other window."
    (interactive "P")
    (let ((dired-dwim-target t))
        (dired-do-rename arg)))

;;; リージョン内の各行の先頭に文字列を挿入。デフォルトは "> "。
(defun my/insert-string-to-head-of-row()
  "Insert string to the head of each row which is in the region.
String is inputted in mini buffer, and the default value is '> '."
  (interactive)
  (save-excursion
    (if (use-region-p)
        (progn
          (setq s (read-from-minibuffer
                   "String to insert to the head of each row (default is '> '):"))
          (if (string= s "")
            (setq s "> "))
          (replace-regexp "^" s nil (region-beginning) (region-end)))
      (message "Region is not active."))))

(provide 'mylib)
