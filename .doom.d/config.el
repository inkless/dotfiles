;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Guangda Zhang"
      user-mail-address "zhangxiaoyu9350@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~/Dropbox/org")

(after! org
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq! org-agenda-files '("~/Dropbox/org")
         org-ellipsis " ▼ "
         org-log-done 'time
         org-todo-keywords '((sequence
                              "TODO(t)"
                              "NEXT(n)"
                              "INPROG(i!)"
                              "|"
                              "DONE(d)")
                             (sequence
                              "WAIT(w@/!)"
                              "HOLD(h@/!)"
                              "|"
                              "CANCELLED(c@/!)"))
         org-todo-keyword-faces '(("TODO" . "gold")
                                  ("NEXT" . "limegreen")
                                  ("INPROG" . "deepskyblue")
                                  ("WAIT" . "darkorange")
                                  ("HOLD" . "darkorange")
                                  ("CANCELLED" . +org-todo-cancel))
         org-capture-templates '(("i" "Inbox" entry
                                  (file "inbox.org")
                                  "* TODO %?\n%i\n/Entered on/ %U" :prepend t)
                                 ("l" "Tasks with link" entry
                                  (file "inbox.org")
                                  "* TODO %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 ("n" "Notes" entry
                                  (file+headline "notes.org" "Notes")
                                  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 ("m" "Meetings" entry
                                  (file+headline "notes.org" "Meetings")
                                  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 ("e" "Emails" entry
                                  (file+headline "notes.org" "Emails")
                                  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 )
         org-refile-targets '((nil :maxlevel . 3)
                              (org-agenda-files :maxlevel . 3)
                              ("notes.org" :level . 2)
                              )
         org-archive-location "archive/%s_archive::datetree/* Archived Tasks"
         org-agenda-custom-commands '(("g" "Get Things Done (GTD)"
                                       ((agenda ""
                                                ((org-agenda-span 5)
                                                 (org-agenda-start-day "-1d")
                                                 (org-deadline-warning-days 7)))
                                        (todo "NEXT"
                                              ((org-agenda-prefix-format "  %i %-12:c [%e] ")
                                               (org-agenda-sorting-strategy '(priority-down))
                                               (org-agenda-overriding-header "\nReady to pick up\n")))
                                        (todo "INPROG"
                                              (
                                               ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
                                               (org-agenda-prefix-format "  %i %-12:c [%e] ")
                                               (org-agenda-sorting-strategy '(priority-down))
                                               (org-agenda-overriding-header "\nIn progress\n")))
                                        (tags-todo "inbox"
                                                   ((org-agenda-prefix-format "  %?-12t% s")
                                                    (org-agenda-overriding-header "\nInbox\n")))
                                        (tags "CLOSED>=\"<today>\""
                                              ((org-agenda-overriding-header "\nCompleted today\n")))
                                        (todo "WAIT|HOLD"
                                              ((org-agenda-prefix-format "  %?-12t% s")
                                               (org-agenda-overriding-header "\nBlocked\n")))))
                                      ))
  ;; Key bindings
  (define-key global-map            (kbd "C-c a") 'org-agenda)
  (define-key global-map            (kbd "C-c c") 'org-capture))

;; org roam
;; (use-package! org-roam
;;   :init
;;   (add-to-list 'display-buffer-alist
;;                '(("\\*org-roam\\*"
;;                   (display-buffer-in-direction)
;;                   (direction . right)
;;                   (window-width . 0.33)
;;                   (window-height . fit-window-to-buffer))))
;;   :config
;;   (setq org-roam-mode-sections
;;         (list #'org-roam-backlinks-insert-section
;;               #'org-roam-reflinks-insert-section
;;               ;; #'org-roam-unlinked-references-insert-section
;;               ))
;;   (org-roam-setup)
;;   (setq org-roam-capture-templates
;;         '(("d" "default" plain
;;            "%?"
;;            :if-new (file+head "${slug}.org"
;;                               "#+title: ${title}\n")
;;            :immediate-finish t
;;            :unnarrowed t)))
;;   (setq org-roam-capture-ref-templates
;;         '(("r" "ref" plain
;;            "%?"
;;            :if-new (file+head "${slug}.org"
;;                               "#+title: ${title}\n")
;;            :unnarrowed t)))

;;   (add-to-list 'org-capture-templates `("c" "org-protocol-capture" entry (file+olp ,(expand-file-name "reading_and_writing_inbox.org" org-roam-directory) "The List")
;;                                          "* TO-READ [[%:link][%:description]] %^g"
;;                                          :immediate-finish t))
;;   (add-to-list 'org-agenda-custom-commands `("r" "Reading"
;;                                              ((todo "WRITING"
;;                                                     ((org-agenda-overriding-header "Writing")
;;                                                      (org-agenda-files '(,(expand-file-name "reading_and_writing_inbox.org" org-roam-directory)))))
;;                                               (todo "READING"
;;                                                     ((org-agenda-overriding-header "Reading")
;;                                                      (org-agenda-files '(,(expand-file-name "reading_and_writing_inbox.org" org-roam-directory)))))
;;                                               (todo "TO-READ"
;;                                                     ((org-agenda-overriding-header "To Read")
;;                                                      (org-agenda-files '(,(expand-file-name "reading_and_writing_inbox.org" org-roam-directory))))))))
;;   (setq org-roam-dailies-directory "daily/")
;;   (setq org-roam-dailies-capture-templates
;;         '(("d" "default" entry
;;            "* %?"
;;            :if-new (file+head "daily/%<%Y-%m-%d>.org"
;;                               "#+title: %<%Y-%m-%d>\n"))))
;;   ;; (set-company-backend! 'org-mode '(company-capf))
;;   )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq projectile-project-search-path '("~/workspace/" "~/workspace/keevo/" "~/workspace/web-ux/"))

;; neotree
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-fixed-size nil)

(add-hook! 'lsp-after-initialize-hook
  (when (flycheck-may-enable-checker 'javascript-eslint)
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

;; (setq +form-with-lsp nil)
(setq-hook! '(typescript-mode-hook
              typescript-tsx-mode-hook
              js2-mode-hook
              python-mode-hook) +format-with-lsp nil)

(setq mac-right-option-modifier 'meta
      ns-right-option-modifier  'meta)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(define-key global-map (kbd "C-c t") '+vterm/toggle)

;; Zoom in/out a window
(defvar-local gz/window-zoom-saved-config nil)
(defun gz/window-toggle-zoom-in-and-out ()
  "Make the current window fill the frame.
If there is only one window try reverting to the most recently saved
window configuration."
  (interactive)
  (if (and gz/window-zoom-saved-config (not (window-parent)))
      (set-window-configuration gz/window-zoom-saved-config)
    (setq-local gz/window-zoom-saved-config (current-window-configuration))
    (delete-other-windows)))
(define-key global-map (kbd "C-c z") 'gz/window-toggle-zoom-in-and-out)

;; Disable evil mode for some major modes
(evil-set-initial-state 'pocket-reader-mode 'emacs)
(add-hook! 'vterm-mode-hook 'turn-off-evil-mode)

;; Language
(setq ispell-dictionary "en")
