(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dracula-theme graphviz-dot-mode markdown-mode exec-path-from-shell auctex helm))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set theme to dracula-theme
;; source https://github.com/dracula/emacs/blob/master/INSTALL.md
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

(helm-mode 1)
(global-set-key (kbd "C-x C-f")                      'helm-find-files)
(global-set-key (kbd "C-q")                          'helm-mini)


(when (memq window-system '(mac ns))
  (setenv "SHELL" "/bin/zsh")
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("PATH")))


(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

;;https://shengdie.github.io/2017/05/29/Mac-Emacs-Skim/
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -r -b -g %n %o %b"))) ;; setup skim params

(eval-after-load 'tex
  '(progn
     (assq-delete-all 'output-pdf TeX-view-program-selection)
     (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Viewer")))) ;; change viewer 

(add-hook 'LaTeX-mode-hook
          #'(lambda ()
	      (add-to-list 'TeX-command-list '("LaTeX" "%`xelatex -synctex=1%(mode)%' %t" TeX-run-TeX nil t))
              (setq TeX-command-extra-options "-file-line-error -shell-escape")
              (setq TeX-save-query  nil ) ;; 不需要保存即可编译
              ))

(custom-set-variables
 '(TeX-source-correlate-method 'synctex)
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t))

(setq backup-directory-alist '(("." . "~/.emacs.d/backup-files")))

