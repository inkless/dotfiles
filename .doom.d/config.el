;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Guangda Zhang"
      user-mail-address "g@guangda.me")

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
(if IS-LINUX
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        ;; 支持中文字体
                        charset (font-spec :family "Noto Sans CJK SC"))))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; Set light and dark theme choices here!
(defconst doom-light-theme 'doom-opera-light)
(defconst doom-dark-theme 'doom-one)

(setq doom-theme doom-dark-theme)

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
         org-todo-keyword-faces '(("TODO" . org-warning)
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
                                 ;; ("n" "Notes" entry
                                 ;;  (file+headline "notes.org" "Notes")
                                 ;;  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 ;; ("m" "Meetings" entry
                                 ;;  (file+headline "notes.org" "Meetings")
                                 ;;  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 ;; ("e" "Emails" entry
                                 ;;  (file+headline "notes.org" "Emails")
                                 ;;  "* %?\n%i\n%a\n/Entered on/ %U" :prepend t)
                                 )
         org-refile-targets '((nil :maxlevel . 3)
                              (org-agenda-files :maxlevel . 3)
                              ("work.org" :level . 2)
                              )
         org-archive-location "archive/%s_archive::datetree/* Archived Tasks"
         org-agenda-custom-commands '(("g" "Get Things Done (GTD)"
                                       ((agenda ""
                                                ((org-agenda-span 5)
                                                 (org-agenda-start-day "-1d")
                                                 (org-deadline-warning-days 7)))
                                        (todo "NEXT"
                                              ((org-agenda-prefix-format "  %i %-12:c ")
                                               (org-agenda-sorting-strategy '(priority-down))
                                               (org-agenda-overriding-header "\nReady to pick up\n")))
                                        (todo "INPROG"
                                              (
                                               ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
                                               (org-agenda-prefix-format "  %i %-12:c ")
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

;; (setq ob-mermaid-cli-path "/usr/local/bin/mmdc")
(org-babel-do-load-languages
    'org-babel-load-languages
    '((mermaid . t)
      (scheme . t)))

;; (after! deft
;;   (setq deft-directory org-directory))

;; org roam
;; (setq org-roam-directory "~/Dropbox/org-roam")
(setq org-roam-directory org-directory)
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

;; (add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq projectile-project-search-path '("~/workspace/" "~/workspace/keevo/" "~/workspace/web-ux/"))

;; neotree
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-fixed-size nil)

(add-hook! 'lsp-after-initialize-hook
  (when (flycheck-may-enable-checker 'javascript-eslint)
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode    ; elisp's mechanisms are good enough
                                          sql-mode           ; sqlformat is currently broken
                                          tex-mode           ; latexindent is broken
                                          latex-mode
                                          mu4e-view-mode
                                          web-mode
                                          org-msg-edit-mode) ; doesn't need a formatter
      )

;; (setq +form-with-lsp nil)
(setq-hook! '(typescript-mode-hook
              typescript-tsx-mode-hook
              js2-mode-hook
              python-mode-hook) +format-with-lsp nil)

;; use eslint_d instead of eslint: https://www.npmjs.com/package/eslint_d
(setq flycheck-javascript-eslint-executable "eslint_d")

(add-hook! '(typescript-mode-hook
             typescript-tsx-mode-hook
             js2-mode-hook) #'eslintd-fix-mode)


(set-company-backend! 'js-mode
  '(company-shell :with company-yasnippet))


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

;; org-msg
;; (use-package! org-msg
;;   :hook (mu4e-compose-pre . org-msg-mode)
;;   :config
;;   (setq org-msg-options "html-postamble:nil H:5 num:nil ^:{} toc:nil author:nil email:nil \\n:t"
;;         ;; org-msg-startup "hidestars indent inlineimages"
;;         ;; org-msg-greeting-fmt "\nHi *%s*,\n\n"
;;         org-msg-greeting-name-limit 3
;;         org-msg-default-alternatives '((new           . (text html))
;;                                        (reply-to-html . (text html))
;;                                        (reply-to-text . (text)))
;;         org-msg-convert-citation t
;;         org-msg-signature "

;; #+begin_signature
;; Best,
;; Guangda Zhang

;; /Sent from emacs mu4e/
;; #+end_signature")
;;   )

;; (defun my-org-msg-composition-parameters (orig-fun &rest args)
;;   "Tweak my greeting message and my signature when replying as
;;    plain/text only."
;;   (let ((res (apply orig-fun args)))
;;     (when (equal (cadr args) '(text))
;;       (setf (alist-get 'greeting-fmt res) "\n")
;;       (setf (alist-get 'signature res)
;;             (replace-regexp-in-string "\\([\*/]\\|\nBest,\n\n\\)" ""
;;                                       org-msg-signature)))
;;     res))
;; (advice-add 'org-msg-composition-parameters
;;             :around #'my-org-msg-composition-parameters)

;; mu4e
;; (setq gz/mu4e-bookmarks '((:name "Unified inbox in last week" :query "maildir:/INBOX/ AND date:7d..now" :key ?i)
;;                           (:name "Unread messages" :query "flag:unread AND NOT flag:trashed" :key ?u)
;;                           (:name "Today's messages" :query "date:today..now" :key ?t)
;;                           (:name "Last 7 days" :query "date:7d..now" :hide-unread t :key ?w)
;;                           (:name "Flagged messages" :query "flag:flagged" :key ?f)
;;                           (:name "Messages with images" :query "mime:image/*" :key ?p)))
;; (setq gz/mu4e-gmail-bookmarks (copy-sequence gz/mu4e-bookmarks))
;; ;; (add-to-list 'gz/mu4e-gmail-bookmarks '(:name "Label: Recruiter" :query "\\Recruiter" :key ?r) t)
;; ;; (add-to-list 'gz/mu4e-gmail-bookmarks '(:name "Label: Investment" :query "\\Investment" :key ?v) t)
;; ;; (add-to-list 'gz/mu4e-gmail-bookmarks '(:name "Label: Kids" :query "\\Kids" :key ?k) t)

;; (after! mu4e
;;   (setq mu4e-update-interval 180
;;         mu4e-attachment-dir "~/Downloads"
;;         mu4e-bookmarks gz/mu4e-bookmarks)
;;   ;; Seems mbsync cannot sync tags properly
;;   ;; (add-to-list 'mu4e-marks '(tag
;;   ;;                            :char       "t"
;;   ;;                            :prompt     "gtag"
;;   ;;                            :ask-target (lambda () (read-string "What tag do you want to add?"))
;;   ;;                            :action      (lambda (docid msg target)
;;   ;;                                           (mu4e-action-retag-message msg (concat "+" target)))))
;;   ;; (mu4e~headers-defun-mark-for tag)
;;   ;; (evil-define-key 'normal mu4e-headers-mode-map (kbd "t") 'mu4e-headers-mark-for-tag)
;;   )

;; (set-email-account! "zhangxiaoyu9350-gmail"
;;                     `((user-mail-address      . "zhangxiaoyu9350@gmail.com")
;;                       (mu4e-sent-folder       . "/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].Sent Mail")
;;                       (mu4e-drafts-folder     . "/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].drafts")
;;                       (mu4e-trash-folder      . "/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].Trash")
;;                       (mu4e-refile-folder     . "/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].All Mail")
;;                       ;; (mu4e-get-mail-command  . "mbsync zhangxiaoyu9350-gmail")
;;                       (mu4e-sent-messages-behavior . delete)
;;                       ;; (mu4e-compose-signature . (concat "Guangda Zhang\n" "Composed from emacs mu4e\n"))
;;                       (message-send-mail-function . smtpmail-send-it)
;;                       (smtpmail-queue-dir     . "~/.mail/zhangxiaoyu9350-gmail/queue/cur")
;;                       (smtpmail-stream-type   . starttls)
;;                       (smtpmail-smtp-user     . "zhangxiaoyu9350")
;;                       (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
;;                       (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
;;                       (smtpmail-default-smtp-server . "smtp.gmail.com")
;;                       (smtpmail-smtp-server   . "smtp.gmail.com")
;;                       (smtpmail-smtp-service  . 587)
;;                       (smtpmail-debug-info    . t)
;;                       (mu4e-bookmarks         . ,gz/mu4e-gmail-bookmarks)
;;                       (mu4e-maildir-shortcuts . ( ("/zhangxiaoyu9350-gmail/INBOX"                       . ?i)
;;                                                   ("/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].Sent Mail" . ?s)
;;                                                   ("/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].Trash"     . ?t)
;;                                                   ("/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].All Mail"  . ?a)
;;                                                   ;; ("/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].Starred"   . ?r)
;;                                                   ("/zhangxiaoyu9350-gmail/[zhangxiaoyu9350].drafts"    . ?d)
;;                                                   ))))

;; (set-email-account! "guangda.me"
;;                     `((user-mail-address      . "g@guangda.me")
;;                       (mu4e-sent-folder       . "/guangda.me/Sent")
;;                       (mu4e-drafts-folder     . "/guangda.me/Drafts")
;;                       (mu4e-trash-folder      . "/guangda.me/Trash")
;;                       (mu4e-refile-folder     . "/guangda.me/Archive")
;;                       ;; (mu4e-get-mail-command  . "mbsync guangda.me")
;;                       (mu4e-sent-messages-behavior . sent)
;;                       ;; (mu4e-compose-signature . (concat "Guangda Zhang\n" "Composed from emacs mu4e\n"))
;;                       (message-send-mail-function . smtpmail-send-it)
;;                       (smtpmail-queue-dir     . "~/.mail/guangda.me/queue/cur")
;;                       (smtpmail-stream-type   . ssl)
;;                       (smtpmail-smtp-user     . "g@guangda.me")
;;                       (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
;;                       (smtpmail-default-smtp-server . "mail.privateemail.com")
;;                       (smtpmail-smtp-server   . "mail.privateemail.com")
;;                       (smtpmail-smtp-service  . 465)
;;                       (smtpmail-debug-info    . t)
;;                       (mu4e-bookmarks         . ,gz/mu4e-bookmarks)
;;                       (mu4e-maildir-shortcuts . ( ("/guangda.me/INBOX"   . ?i)
;;                                                   ("/guangda.me/Sent"    . ?s)
;;                                                   ("/guangda.me/Trash"   . ?t)
;;                                                   ("/guangda.me/Archive" . ?a)
;;                                                   ("/guangda.me/Drafts"  . ?d)
;;                                                   ("/guangda.me/Spam"    . ?p)
;;                                                   ))
;;                       )
;;                     t)
