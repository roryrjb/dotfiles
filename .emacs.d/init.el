(setq custom-file "~/.emacs.d/custom.el")

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
;; (global-display-line-numbers-mode)
(global-hl-line-mode)

(setq project-switch-commands 'project-dired)
(setq compile-command "")
(setq ring-bell-function 'ignore)
(setq default-directory-tracking nil)
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)
(setq magit-no-confirm '(discard delete stage-all-changes))
(setq case-fold-search nil)
(setq-default tab-width 2)
;; (setq-default electric-indent-inhibit t) ; Don't actually know what this does

(savehist-mode 1)
(save-place-mode 1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)
(setq avy-timeout-seconds 0.3)
(package-initialize)

(ido-ubiquitous-mode 1)
(ido-mode 1)
(ido-everywhere 1)

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

(add-hook 'find-file-hook
          (lambda ()
            (when-let ((project (project-current)))
              (setq default-directory (project-root project)))))

(global-set-key (kbd "C-+") 'global-display-line-numbers-mode)
(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-o") 'goto-last-change)
(global-set-key (kbd "C-<return>") 'compile)
(global-set-key (kbd "C-<end>") 'kill-compilation-hard)
(global-unset-key (kbd "C-z")) ; suspend
(global-set-key (kbd "C-S-d") 'duplicate-line)
(global-set-key (kbd "C-p") 'dabbrev-expand) ; overrides C-p (previous-line), this might be a bad thing but it's in my muscle memory because of vim
(global-set-key (kbd "C-x f") 'find-file)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)
(global-set-key (kbd "C-c t") 'multi-vterm)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-x C-k") 'kill-buffer)
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C->") 'next-error)
(global-set-key (kbd "C-<") 'previous-error)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(add-to-list 'default-frame-alist '(width . 185))
(add-to-list 'default-frame-alist '(height . 50))

(eval-after-load "dired" '(progn
  (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file) ))

(load custom-file)

(defun kill-compilation-hard ()
  "Kill compilation process with SIGKILL from any buffer."
  (interactive)
  (let ((comp-buf (get-buffer "*compilation*")))
    (if comp-buf
        (with-current-buffer comp-buf
          (when (get-buffer-process comp-buf)
            (let ((proc (get-buffer-process comp-buf)))
              (signal-process proc 'SIGKILL)
              (message "Compilation process killed with SIGKILL"))))
      (message "No compilation buffer found"))))
