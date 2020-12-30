;; ========= Custom settings =========
(load-theme 'badwolf t)
;; (set-face-attribute 'default nil :height 140)

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)
;; ========= Custom settings =========


;; ========= Org mode settings =========
;; Add agenda files
(setq JMwill/org-agenda-directory "~/Orgroom/gtd/")
(setq JMwill/org-blog-directory "~/projects/blog/")
(setq org-agenda-files (list
                        (concat JMwill/org-agenda-directory "inbox.org")
                        (concat JMwill/org-agenda-directory "gtd.org")
                        (concat JMwill/org-agenda-directory "tickler.org")))

;; Set up org capture template
;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post. See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
     (fname (org-hugo-slug title)))
      (mapconcat #'identity
     `(
       ,(concat "* TODO " title)
       ":PROPERTIES:"
       ,(concat ":EXPORT_FILE_NAME: " (format-time-string "%Y-%m-%d-") fname)
       ":END:"
       "%?\n")          ;Place the cursor here finally
     "\n"))))

(setq org-capture-templates `(("i" "inbox" entry
                               (file ,(concat JMwill/org-agenda-directory "inbox.org"))
                               "* TODO %i%?")
                              ;; org-cliplink-capture not available in wsl
                              ;; ("l" "link" entry
                              ;;  (file ,(concat JMwill/org-agenda-directory "inbox.org"))
                              ;;  "* TODO %(org-cliplink-capture)" :immediate-finish t)
                              ;; need config org protocol, read website: https://blog.jethro.dev/posts/capturing_inbox/
                              ;; ("c" "org-protocol-capture" entry
                              ;;  (file ,(concat JMwill/org-agenda-directory "inbox.org"))
                              ;;  "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)
                              ("t" "Tickler" entry
                               (file+headline (lambda () (concat JMwill/org-agenda-directory "tickler.org"))  "备忘录")
                               "* %i%? \n %U")
                              ("h" "Hugo post" entry
                                ;; It is assumed that below file is present in `org-directory'
                                ;; and that it has a "Blog Ideas" heading. It can even be a
                                ;; symlink pointing to the actual location of all-posts.org!
                               (file+olp (lambda () (concat JMwill/org-blog-directory "content-org/2020.org")) "Posts")
                               (function org-hugo-new-subtree-post-capture-template))))

;; Set up org refile targets
(setq org-refile-targets '(((concat JMwill/org-agenda-directory "gtd.org") :maxlevel . 3)
                           ((concat JMwill/org-agenda-directory "tickler.org") :maxlevel . 2)))

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
;; (require-package 'pyenv-mode)
;; (elpy-enable)
;; (pyenv-mode)
;; ========= Python settings =========


;; ========= Code completion and navigation settings =========
(local-require 'counsel-etags)
(defun my-setup-develop-environment ()
  "Set up my develop environment."
  (interactive)
  (unless (is-buffer-file-temp)
    (add-hook 'after-save-hook 'counsel-etags-virtual-update-tags 'append 'local)))
(add-hook 'prog-mode-hook 'my-setup-develop-environment)

(with-eval-after-load 'grep
  (dolist (v '("node_modules"
               "bower_components"
               ".sass_cache"
               ".cache"
               ".npm"))
    (add-to-list 'grep-find-ignored-directories v))
  (dolist (v '("*.min.js"
               "*.bundle.js"
               "*.min.css"
               "*.json"
               "*.log"))
    (add-to-list 'grep-find-ignored-files v)))
;; ========= Code completion and navigation settings =========


;; ========= HUGO settings =========
(require-package 'ox-hugo)
(require-package 'org-download)
(with-eval-after-load 'ox
  (require 'org-download)
  (require 'ox-hugo))

(setq org-download-screenshot-method "screencapture -i %s")

;; (defun will//insert-org-or-md-img-link (prefix imagename)
;;   (if (equal (file-name-extension (buffer-file-name)) "org")
;;       (insert (format "[[%s%s]]" prefix imagename))
;;     (insert (format "![%s](%s%s)" imagename prefix imagename))))

;; (defun will/capture-screenshot (basename)
;;   "Take a screenshot into a time stamped unique-named file
;;   in the same directory as the org-buffer/markdown-buffer and insert a link to this file."
;;   (interactive "sScreenshot name: ")
;;   (if (equal basename "")
;;       (setq basename (format-time-string "%Y%m%dT%H%M%S")))
;;   (progn
;;     (setq final-image-full-path (concat basename ".png"))
;;     (call-process "screencapture" nil nil nil "-s" final-image-full-path)
;;     (if (executable-find "convert")
;;         (progn
;;           (setq resize-command-str (format "convert %s -resize 800x600 %s" final-image-full-path final-image-full-path))
;;           (shell-command-to-string resize-command-str)))
;;     (will//insert-org-or-md-img-link "./" (concat basename ".png")))
;;   (insert "\n"))
;; ========= HUGO settings =========


;; ========= sdcv dictionary settings =========
;; Dictionary resource: http://download.huzheng.org/bigdict/
(setq sdcv-dictionary-complete-list
      '(
        "Longman Dictionary of Contemporary English 5th Ed. (En-En)"
        "Longman Dictionary of Contemporary English Extras 5th Ed. (En-En)"
        ))

(general-create-definer custom-semicolon-leader-def
  :prefix ";"
  :states '(normal visual))

(custom-semicolon-leader-def
  "dp" 'sdcv-search-pointer) ; details
;; ========= sdcv dictionary settings =========


;; ========= org-roam settings =========
;; org-roam needs latest org, install step:
;; use "C-M-:" to exec this line: (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; after that M-x to run: package-refresh-contents & package-install org-roam
;; plaese ensure that sqlite3 installed, use (executable-find "sqlite3") to check it
;; if sqlite3 installed and still cannot find it, use (add-to-list 'exec-path "path/to/sqlite3")
(require-package 'org-roam)
(setq JMwill/org-zettelkasten-directory "~/Orgroom/zettelkasten")
(if (not (file-directory-p JMwill/org-zettelkasten-directory))
    (make-directory JMwill/org-zettelkasten-directory))
(setq org-roam-directory JMwill/org-zettelkasten-directory)
(add-hook 'after-init-hook 'org-roam-mode)
;; ========= org-roam settings =========
