(setq multi-term-program (executable-find "zsh"))
(setq shell-file-name (executable-find "zsh"))

;; ========= Proxy settings =========
(setq url-proxy-services
      '(("https" . "localhost:7890")
        ("http" . "localhost:7890")
        ("no_proxy" . "^\\(localhost\\)")))
;; ========= Proxy settings =========


;; ========= Org mode settings =========
;; Set browser
(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program (cond
                                  ((string-equal system-type "darwin") "open")
                                  ((string-equal system-type "gun/linux") (executable-find "firefox"))
                                  ))
;; Use the default browser to open the website instead of w3m
;; (org-link-set-parameters "chrome" :follow (lambda (path) (browse-url-default-macosx-browser (concat "https:" path))))

;; Add agenda files
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))


;; Set up org capture template
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

;; Set up org refile targets
(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                           ("~/gtd/someday.org" :level . 1)
                           ("~/gtd/tickler.org" :maxlevel . 2)))

;; Set up todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))


;; Create custom agenda commands
(setq org-agenda-custom-commands
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry"
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))
;; ========= Org mode settings =========


;; ========= Python settings =========
(elpy-enable)
(pyenv-mode)
;; ========= Python settings =========