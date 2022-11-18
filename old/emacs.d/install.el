(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(package-refresh-contents)

(package-install 'zenburn-theme)
(package-install 'markdown-mode)
(package-install 'csharp-mode)
(package-install 'twittering-mode)
(package-install 'dos)
(package-install 'geeknote)
;; (package-install 'evil)