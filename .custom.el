;; ========= Custom package require =========
(require-package 'ox-hugo)
(require-package 'pyenv-mode)
(require-package 'org-download)
;; ========= Custom package require =========

;; ========= Custom font face =========
(load-theme 'badwolf t)
(when (member "MesloLGS NF" (font-family-list))
  (set-face-attribute 'default nil :height 140)
  (set-frame-font "MesloLGS NF" t t))
;; ========= Custom font face =========

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; ========= Proxy settings =========
(setq url-proxy-services
      '(("https" . "localhost:7890")
        ("http" . "localhost:7890")
        ("no_proxy" . "^\\(localhost\\)")))
;; ========= Proxy settings =========


;; ========= Org mode settings =========
;; Add agenda files
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))

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

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")
                              ("h" "Hugo post" entry
                                ;; It is assumed that below file is present in `org-directory'
                                ;; and that it has a "Blog Ideas" heading. It can even be a
                                ;; symlink pointing to the actual location of all-posts.org!
                               (file+olp "~/Personal/blog/content-org/2020.org" "Posts")
                               (function org-hugo-new-subtree-post-capture-template))))

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

;; ========= ox-hugo settings =========
(with-eval-after-load 'ox
  (require 'org-download)
  (require 'ox-hugo))

(defun will//insert-org-or-md-img-link (prefix imagename)
  (if (equal (file-name-extension (buffer-file-name)) "org")
      (insert (format "[[%s%s]]" prefix imagename))
    (insert (format "![%s](%s%s)" imagename prefix imagename))))

(defun will/capture-screenshot (basename)
  "Take a screenshot into a time stamped unique-named file
  in the same directory as the org-buffer/markdown-buffer and insert a link to this file."
  (interactive "sScreenshot name: ")
  (if (equal basename "")
      (setq basename (format-time-string "%Y%m%dT%H%M%S")))
  (progn
    (setq final-image-full-path (concat basename ".png"))
    (call-process "screencapture" nil nil nil "-s" final-image-full-path)
    (if (executable-find "convert")
        (progn
          (setq resize-command-str (format "convert %s -resize 800x600 %s" final-image-full-path final-image-full-path))
          (shell-command-to-string resize-command-str)))
    (will//insert-org-or-md-img-link "./" (concat basename ".png")))
  (insert "\n"))
;; ========= ox-hugo settings =========