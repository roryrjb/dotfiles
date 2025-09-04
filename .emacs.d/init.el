(setq custom-file "~/.emacs.d/custom.el")

(setq default-frame-alist
      '((width . 140)
        (height . 50)))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(setq compile-command "")
(setq ring-bell-function 'ignore)
(setq default-directory-tracking nil)
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)
(setq magit-no-confirm '(discard delete stage-all-changes))
(setq case-fold-search nil)
(setq-default tab-width 2)

(save-place-mode 1)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)
(package-initialize)

(use-package magit
  :ensure t)

(use-package dtrt-indent
  :ensure t
  :init
  (dtrt-indent-global-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package vterm
  :ensure t)

(use-package multi-vterm
  :ensure t)

(use-package project
  :init
  (setq project-switch-commands 'project-dired)
  (add-hook 'find-file-hook
            (lambda ()
              (when-let ((project (project-current)))
                (setq default-directory (project-root project))))))

(use-package typescript-mode
  :ensure t)

(use-package goto-chg
  :ensure t
  :init
  (global-set-key (kbd "C-z") 'goto-last-change))

(use-package doric-themes
  :ensure t)

(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-+") 'global-display-line-numbers-mode)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-x <return>") 'compile)
(global-set-key (kbd "C-S-d") 'duplicate-line)
(global-set-key (kbd "C-p") 'dabbrev-expand)
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-c t") 'multi-vterm)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C->") 'next-error)
(global-set-key (kbd "C-<") 'previous-error)


(eval-after-load "dired" '(progn
  (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file) ))

(load custom-file)

(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)
