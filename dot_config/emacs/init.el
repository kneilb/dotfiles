(require 'package)
;; NB. Need melpa for doom-modeline today (2025-02-25)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(setq package-archive-priorities
      '((gnu . 10)
        (nongnu . 5)
        (melpa . 1)))
(unless (bound-and-true-p package--initialized)
  (package-initialize)
  (setq package-enable-at-startup nil))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Always install things we try to configure
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

;; (use-package all-the-icons)

(use-package doom-modeline
  :pin melpa
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 30)))

;; Vertico (vertical interactive completion).
(use-package vertico
  :pin gnu
  :init
  (vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :pin gnu
  :init
  (savehist-mode))

;; Use the `orderless' completion style.
(use-package orderless
  :pin gnu
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia (rich annotations in the minibuffer)
(use-package marginalia
  :pin gnu
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;; Consult (Improved search and navigation commands)
(use-package consult
  :pin gnu
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-fd)                    ;; Alternative: consult-find
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<"))

;; Embark (Minibuffer actions)
(use-package embark
  :pin gnu
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-. (was C-;)
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :pin gnu
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; TODO: I'm not sure I like the buffer reordering in consult-buffer!
;; Get over it - use narrowing keys (<r) to move to org-roam buffers!
;; Maybe just disable -buffer-after-buffers??
(use-package consult-org-roam
  :pin melpa
  ;; :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key "M-.")
  :bind
  ;; Define some convenient key bindings as an addition
  ("C-c n e" . consult-org-roam-file-find)
  ("C-c n b" . consult-org-roam-backlinks)
  ("C-c n B" . consult-org-roam-backlinks-recursive)
  ("C-c n l" . consult-org-roam-forward-links)
  ("C-c n r" . consult-org-roam-search))

;; Which-key
(use-package which-key
  :pin gnu
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Rainbow delimiters in programming modes
(use-package rainbow-delimiters
  :pin nongnu
  :hook (prog-mode . rainbow-delimiters-mode))

;; Magit for git interactions
(use-package magit
  :pin nongnu
  :commands magit-status
  :custom
  (magit-diff-refine-hunk t)
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-define-global-key-bindings nil)
  (magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18)) ;; Show dates, not vagueness
  :bind
  ("C-x g" . magit-status)
  ("C-c g" . magit-dispatch)
  ("C-c f" . magit-file-dispatch))

;; Support diminishing minor modes
(use-package diminish
  :pin melpa)

;; Editorconfig, for sanity
(use-package editorconfig
  :pin nongnu
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

;; Formatting - used by go & python
(use-package reformatter
  :pin nongnu)

;; NON TREE SITTER LANGUAGES
(use-package jinja2-mode
  :pin nongnu)

;; For YAML files with Jinja2 templating
(use-package poly-ansible
  :pin melpa
  :mode ("\\.yaml.j2\\'" . poly-ansible-mode))

(use-package robot-mode
  :pin melpa)

(use-package terraform-mode
  :pin melpa)

;; TREE SITTER LANGUAGES
;; to build the grammars:
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

;; This is really shell-ts-mode, and works for fish too.
(use-package bash-ts-mode
  :ensure nil
  :after treesit
  :defer 't
  :mode ("\\.sh\\'" "\\.env\\'" "\\.fish\\'")
  :init
  (add-to-list 'treesit-language-source-alist '(bash "https://github.com/tree-sitter/tree-sitter-bash" "master" "src")))

(use-package dockerfile-ts-mode
  :after treesit
  :defer 't
  :mode "\\Dockerfile.*\\'"
  :init
  (add-to-list 'treesit-language-source-alist '(dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "main" "src")))

(use-package go-ts-mode
  :after (treesit reformatter)
  :defer 't
  :hook
  (go-ts-mode . go-format-on-save-mode)
  :mode
  ("\\.go\\'" . go-ts-mode)
  ("/go\\.mod\\'" . go-mod-ts-mode)
  :init
  (add-to-list 'treesit-language-source-alist '(go "https://github.com/tree-sitter/tree-sitter-go" "master" "src"))
  (add-to-list 'treesit-language-source-alist '(gomod "https://github.com/camdencheek/tree-sitter-go-mod" "main" "src"))
  :config
  (reformatter-define go-format
    :program "goimports"
    :args '("/dev/stdin")))

(use-package json-ts-mode
  :after treesit
  :mode "\\(?:\\(?:\\.\\(?:b\\(?:\\(?:abel\\|ower\\)rc\\)\\|json\\(?:ld\\)?\\)\\|composer\\.lock\\)\\'\\)"
  :defer 't
  :init
  (add-to-list 'treesit-language-source-alist '(json "https://github.com/tree-sitter/tree-sitter-json" "master" "src")))

;; TODO not getting activated...
;; (use-package markdown-ts-mode
;;   :ensure nil
;;   :after treesit
;;   :mode "\\.md\\'"
;;   :defer 't
;;   :init
;;   (add-to-list 'treesit-language-source-alist '(markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
;;   (add-to-list 'treesit-language-source-alist '(markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))
;;   :config
;;   (add-to-list 'major-mode-remap-alist '(markdown-mode . markdown-ts-mode)))

(use-package python-ts-mode
  :ensure nil
  :after (treesit reformatter)
  :mode "\\.py\\'"
  :init
  (add-to-list 'treesit-language-source-alist '(python "https://github.com/tree-sitter/tree-sitter-python" "master" "src"))
  (setq python-shell-prompt-detect-failure-warning nil)
  :config
  (reformatter-define ruff-format
    :program "ruff"
    :args `("format" "--stdin-filename" ,buffer-file-name "-")))

(use-package rust-ts-mode
  :after treesit
  :mode "\\.rs\\'"
  :defer 't
  :init
  (add-to-list 'treesit-language-source-alist '(rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.20.3" "src"))
  :custom
  (rust-indent-level 2))

(use-package yaml-ts-mode
  :after treesit
  :mode "\\.ya?ml\\'"
  :defer 't
  :init
  (add-to-list 'treesit-language-source-alist '(yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml" "master" "src")))

;; Use ruff to provide linting / errors via flymake
(use-package flymake-ruff
  :pin melpa
  :hook (python-base-mode . (lambda ()
                              (flymake-mode 1)
                              (flymake-ruff-load))))

;; eglot (LSP integration)
(use-package eglot
  :pin gnu
  :hook ((rust-ts-mode go-ts-mode) . eglot-ensure)
  :bind (:map
         eglot-mode-map
         ("C-c e a" . eglot-code-actions)
         ("C-c e o" . eglot-code-actions-organize-imports)
         ("C-c e r" . eglot-rename)
         ("C-c e f" . eglot-format)))

;; TODO: worth keeping?
(use-package kubernetes
  :pin melpa
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))

;; clean up whitespace on edited lines only
(use-package ws-butler
  :pin nongnu
  :init
  (setq ws-butler-keep-whitespace-before-point nil)
  :config
  (ws-butler-global-mode)
  :diminish)

;; spell checking (better than flyspell!)
(use-package jinx
  :pin gnu
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages))
  :config
  (setq jinx-languages "en_GB"))

;; org mode & org-roam
(use-package org
  :pin gnu
  :after verb
  :mode
  ("\\.org\\'" . org-mode)
  :bind (("C-c a" . org-agenda)
	 ("C-c b" . org-switchb)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-store-link)
	 ("C-c t" . org-todo-list))
  :init
  (setq org-confirm-babel-evaluate nil)
  :config
  ;; Enable other languages in org-babel (C-c C-c to run)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(;; (go . t) needs ob-go, CBA right now
     (python . t)
     (shell . t)
     (verb . t)))
  ;; This can't be done with bind/map
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map)
  (setq
   org-agenda-files '("~/org" "~/org/daily") ;; Directories containing agenda files
   org-attach-use-inheritance t ;; Search up hierarchy for attachment dirs
   org-edit-src-content-indentation 0 ;; Don't indent source files
   org-M-RET-may-split-line '((default . nil)) ;; Don't split a line when pressing M-RET
   org-startup-folded "nofold")) ;; Start up with drawers folded, everything else shown

(use-package org-roam
  :pin gnu
  :custom
  (org-roam-directory (file-truename "~/org"))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
	 ("C-c n d" . org-roam-dailies-goto-date)
	 ("C-c n t" . org-roam-dailies-goto-today)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :pin melpa
  :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; REST client stuff (verb is an extension of org)
(use-package verb
  :pin melpa)

;; More useful configuration...
(use-package emacs
  :ensure nil
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  (setq read-extended-command-predicate
        #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t)

  ;; Disable splash screen and startup message
  (setq inhibit-startup-message t)

  ;; Try to flash the frame to represent a bell.
  (setq visible-bell t)

  ;; Enable column numbers in modeline
  (column-number-mode)
  ;; (global-display-line-numbers-mode t)

  ;; (setq fill-column 120)
  ;; (global-display-fill-column-indicator-mode nil)

  ;; I didn't even know this was possible - just use the region instead!
  (setq shift-select-mode nil)

  ;; There's no need to be quite so paranoid...!
  (defalias 'yes-or-no-p 'y-or-n-p)

  ;; ediff
  (setq ediff-keep-variants nil)
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)

  ;; Revert Dired & other buffers
  (setq global-auto-revert-non-file-buffers t)
  ;; (global-auto-revert-mode 1)

  ;; Save & restore open buffers, but not frames & position
  (setq desktop-restore-frames nil)
  (desktop-save-mode t)

  ;; Weeks start on Monday.
  (setq calendar-week-start-day 1)

  ;; Don't require a double space to end a sentence.
  (setq sentence-end-double-space nil)

  ;; spell checking - use jinx instead
  (setq ispell-dictionary "en_GB")
  ;; (add-hook 'text-mode-hook 'flyspell-mode)
  ;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

  ;; Make URL links open when using WSL / Windows
  (when (string-match "-[Mm]icrosoft" operating-system-release)
    (setq
     cmdExeBin"/mnt/c/Windows/System32/cmd.exe"
     cmdExeArgs '("/c" "start" ""))
    (setq
     browse-url-generic-program  cmdExeBin
     browse-url-generic-args     cmdExeArgs
     browse-url-browser-function 'browse-url-generic))

  ;; Fix pasting into Windows from emacs kill buffer
  (setq select-active-regions nil)

  ;; Use theme
  (setq modus-themes-mode-line '(accented borderless padded))

  ;; (setq modus-themes-region '(accented))
  (setq modus-themes-region '(bg-only))
  ;; (setq modus-themes-region '(bg-only no-extend))

  ;; (setq modus-themes-completions 'minimal)
  ;; (setq modus-themes-completions 'opinionated)
  ;; (setq modus-themes-completions
  ;; 	(quote ((matches . (extrabold background intense underline))
  ;; 		(selection . (extrabold accented intense background))
  ;; 		(popup . (accented)))))

  (setq modus-themes-bold-constructs t)
  (setq modus-themes-italic-constructs t)
  (setq modus-themes-paren-match '(bold intense))

  (load-theme 'modus-vivendi t)

  ;; Font stuff (N/A for -nw)
  (set-face-attribute 'default nil :family "MesloLGS Nerd Font" :height 120)

  (add-to-list 'load-path (expand-file-name "machines" user-emacs-directory))
  (require (intern (system-name)) nil 'noerror))
