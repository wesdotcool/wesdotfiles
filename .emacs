(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(package-initialize)

(tool-bar-mode -1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wheatgrass))
 '(exec-path
   '("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "~/go" "~/go/bin" "/usr/local/bin"))
 '(lsp-ruby-lsp-use-bundler t)
 '(midnight-mode t)
 '(package-selected-packages
   '(rubocopfmt rvm tree-sitter-langs ob-go counsel json-mode terraform-mode docker-compose-mode dockerfile-mode ivy-mode ivy-rich-mode go-mode lsp-mode csv-mode company-go popup-kill-ring dash-at-point fill-column-indicator company flycheck ag))
 '(text-quoting-style 'grave)
 '(treesit-extra-load-path
   '("/Users/whunt/.emacs.d/elpa/tree-sitter-langs-20230705.525/bin") t))

;; Add brew packages to the emacs path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))

(use-package go-mode
  :mode "\\.go\\'"
  :config
  (setq gofmt-command "goimports")
  (defun my/go-mode-setup ()
    "Basic Go mode setup."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)
  (add-hook 'before-save-hook #'gofmt-before-save))
  (add-hook 'go-mode-hook #'my/go-mode-setup)
)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-mode lsp-deferred)
  :hook ((rust-mode python-mode go-mode) . lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-rust-server 'rust-analyzer)
  ;; for filling args placeholders upon function completion candidate selection
  ;; lsp-enable-snippet and company-lsp-enable-snippet should be nil with
  ;; yas-minor-mode is enabled: https://emacs.stackexchange.com/q/53104
  (lsp-modeline-code-actions-mode)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (add-to-list 'lsp-file-watch-ignored "\\.vscode\\'"))

(setq-default indent-tabs-mode nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq auto-mode-alist
  (append
   ;; .env file
   '(("\\.env" . sh-mode))
   auto-mode-alist))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(column-number-mode 1)
(global-display-line-numbers-mode 1)

(global-set-key (kbd "C-;") 'magit-blame)
(global-set-key (kbd "M-5") 'replace-string)
(global-set-key (kbd "s-t") nil)

(set-face-attribute 'default nil :height 140)
(setq inhibit-splash-screen t)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  (ivy-use-selectable-prompt t)
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
)

(use-package ag)
(use-package company)
(use-package company-go)
(use-package csv-mode)
(use-package dash-at-point)
(use-package flycheck)
(use-package json-mode)
(use-package popup-kill-ring)
(use-package terraform-mode)
(use-package which-key)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
