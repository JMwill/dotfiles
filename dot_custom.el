;; =============================================================================
;; JMwill's Complete & Lightweight Custom Configuration for Emacs 29+
;; Fully compatible with redguardtoo/emacs.d
;; =============================================================================

;; 1. 界面与警告静音
(setq my-enable-startup-color-theme-p t)
;; 抑制 Emacs 29+ 异步原生编译产生的恼人弹窗警告 (纠正拼写错误)
(setq native-comp-async-report-warnings-errors 'silent)
(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)

;; 2. 国内 ELPA 镜像源加速 (防止网络超时)
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("nongnu". "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")))

;; 3. 临时与自动备份文件隔离 (彻底杜绝在代码仓库中生成 filename~ 垃圾文件)
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(unless (file-exists-p emacs-tmp-dir)
  (ignore-errors (make-directory emacs-tmp-dir t)))
(setq backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix emacs-tmp-dir)

;; 4. pyim 中文输入法弹窗配置 (实机已验证的高质量输入体验)
(with-eval-after-load 'pyim
  (require 'popup)
  (setq pyim-page-tooltip '(posframe popup minibuffer)))

;; 5. 启用按键频率统计与自动保存
(with-eval-after-load 'keyfreq
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

;; 6. 全局搜索/Grep 智能过滤 (排除大型依赖与打包产物)
(with-eval-after-load 'grep
  (dolist (dir '("node_modules" "bower_components" ".sass-cache" ".cache" ".npm" ".git"))
    (add-to-list 'grep-find-ignored-directories dir))
  (dolist (file '("*.min.js" "*.bundle.js" "*.min.css" "*.log"))
    (add-to-list 'grep-find-ignored-files file)))

;; 7. 加载本地私有特异配置 (若存在，例如各机器专属的笔记目录等)
(let ((local-custom (expand-file-name "~/.custom.local.el")))
  (when (file-exists-p local-custom)
    (load local-custom t nil)))
