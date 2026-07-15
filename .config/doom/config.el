;;; $DOOMDIR/config.el -*- lexical-binding: t; -*

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;
(add-to-list 'exec-path (expand-file-name "~/.ghcup/bin"))
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq c-ts-mode-indent-offset 4)

(after! evil
  (setq evil-auto-indent t))

(after! compile
  (add-to-list
   'compilation-error-regexp-alist-alist
   '(zig-reference
     "^[[:space:]]*[^:\n]+: \\([^:\n]+\\):\\([0-9]+\\):\\([0-9]+\\)"
     1 2 3))

  (add-to-list
   'compilation-error-regexp-alist
   'zig-reference))

(after! compile

  (defun my/zig-clean-compilation ()
    (let ((inhibit-read-only t))
      (save-excursion
        (goto-char compilation-filter-start)

        ;; OSC
        (while (re-search-forward
                "\x1b\\][^\a\x1b]*\\(?:\a\\|\x1b\\\\\\)"
                nil t)
          (replace-match ""))

        ;; CSI
        (goto-char compilation-filter-start)
        (while (re-search-forward
                "\x1b\\[[0-9;?]*[@-~]"
                nil t)
          (replace-match ""))

        ;; Reverse Index -> CR
        (goto-char compilation-filter-start)
        (while (search-forward "\eM" nil t)
          (replace-match "\r"))

        ;; DEC graphics
        (dolist (pair '(("mq" . "└─")
                        ("tq" . "├─")
                        ("lq" . "┌─")
                        ("kq" . "┐─")
                        ("x"  . "│")))
          (goto-char compilation-filter-start)
          (while (re-search-forward
                  (concat "\e(0"
                          (regexp-quote (car pair))
                          "\e(B")
                  nil t)
            (replace-match (cdr pair) t t)))

        ;; Hilangkan sisa ESC(0 / ESC(B
        (goto-char compilation-filter-start)
        (while (re-search-forward "\e([0B]" nil t)
          (replace-match ""))

        ;; Emulasi carriage return
        (goto-char compilation-filter-start)
        (while (search-forward "\r" nil t)
          (let ((start (line-beginning-position)))
            (delete-region start (point))
            (replace-match ""))))))

  (add-hook 'compilation-filter-hook #'my/zig-clean-compilation))

(add-hook 'vterm-mode-hook #'compilation-shell-minor-mode)

(evil-define-key 'normal vterm-mode-map
  (kbd "RET") #'compile-goto-error
  (kbd "gj")  #'next-error
  (kbd "gk")  #'previous-error)

(add-hook 'doom-load-theme-hook
          (lambda ()
            (dolist (face (face-list))
              (set-face-attribute face nil :slant 'normal))))

(add-hook 'c-ts-mode-hook
          (lambda ()
            (setq-local c-basic-offset 4)))

(add-hook 'zig-mode-hook #'eglot-ensure)

(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (python-mode . python-ts-mode)
        (javascript-mode . js-ts-mode)
        (css-mode . css-ts-mode)
        (json-mode . json-ts-mode)
        (bash-mode . bash-ts-mode)))

(setenv "PATH"
        (concat
         (expand-file-name "~/.ghcup/bin")
         path-separator
         (getenv "PATH")))

(require 'pulse)

(defface my/yank-highlight-face
  '((t (:background "#fabd3f"
                    )))
  "Face untuk highlight yank.")

(defun my/highlight-yank (beg end &rest _)
  (pulse-momentary-highlight-region
   beg end
   'my/yank-highlight-face))

(advice-add 'evil-yank :after #'my/highlight-yank)

(after! faces
  (custom-theme-set-faces!
    'user
    '(region :background"#504945"
      )))

(after! dape
  (repeat-mode 1))

(after! smartparens
  (require 'smartparens-config)
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1))

(use-package! grip-mode
  :after markdown-mode
  :config
  (setq grip-update-after-change nil))

(setq doom-font
      (font-spec
       :family "Iosevka"
       :size 22
       :weight 'bold
       :slant 'normal))

(after! evil
  (setq evil-normal-state-cursor '(box "#e73722"))
  (setq evil-insert-state-cursor '(box "#2ecc71"))
  (setq evil-visual-state-cursor '(hollow "#fabd3f"))
  (define-key doom-leader-map (kbd "w m") nil)
  (define-key doom-leader-map (kbd "w m") #'doom/window-maximize-buffer)

  (map! :n "C-a"
        (lambda()
          (interactive)
          (evil-goto-line 0)
          (evil-visual-line nil)
          (end-of-buffer)
          ))

  (map! :n "C-u"
        (lambda()
          (interactive)
          (evil-previous-line 3)
          (evil-scroll-line-to-center nil)
          ))

  (map! :n "C-d"
        (lambda()
          (interactive)
          (evil-next-line 3)
          (evil-scroll-line-to-center nil)
          ))

  (map! :leader
        :desc "Hydra resize"
        "w SPC"
        #'doom-window-resize-hydra/body)

  (map! :n
        "" #'projectile-compile-project)

  (map! :g
        "M-!" #'projectile-compile-project)
  )


(after! compile
  (setq compilation-scroll-output t)
  (setq split-width-threshold nil
        split-height-threshold 80))

(after! eldoc
  (setq lsp-eldoc-enable-hover nil)
  (global-eldoc-mode -1))


(after! eglot
  (add-hook 'tuareg-mode-hook #'eglot-ensure)
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (eglot-inlay-hints-mode -1)
              (eldoc-mode -1)
              )))

(add-hook 'tuareg-mode-hook #'eglot-ensure)
(add-hook 'prog-mode-hook #'apheleia-mode)


(set-popup-rule! "^\\*sly-mrepl"
  :side 'right
  :size 0.35
  :select t
  :quit nil)

;; (set-popup-rule! "^\\*sly-mrepl"
;;   :side 'right
;;   :size 0.4
;;   :ignore t
;;   :select t
;;   )


;; (add-to-list 'display-buffer-alist
;;              '("^\\*sly-mrepl "
;;                (display-buffer-in-side-window)
;;                (side . right)
;;                (window-width . 0.4)))

(flycheck-popup-tip-mode -1)

;; (after! rg
;;   (setq rg-group-result nil
;;         rg-command-line-flags
;;         '("-n"
;;           "--no-heading"
;;           )))


;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq compile-command "")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; define a hydra to simplify window resizing
(defhydra doom-window-resize-hydra (:hint nil)
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)
  ("q" nil))


(set-popup-rule! "^\\*compilation\\*"
  :side 'bottom
  :size 0.5
  :ttl nil
  :quit nil)

(after! evil
  (defun my/evil-scroll-down-and-center ()
    (interactive)
    (evil-scroll-down nil)
    (recenter))

  (defun my/evil-scroll-up-and-center ()
    (interactive)
    (evil-scroll-up nil)
    (recenter))

  ;; (map! :n "C-d" #'my/evil-scroll-down-and-center
  ;;       :n "C-u" #'my/evil-scroll-up-and-center)
  )

(defalias '+default/search-project #'projectile-ripgrep)
