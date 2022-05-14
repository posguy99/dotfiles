
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

; Add the NonGNU ELPA package archive
; https://emacs.amodernist.com/
(add-to-list 'package-archives  '("nongnu" . "https://elpa.nongnu.org/nongnu/"))

; JSON Support
; https://emacs.amodernist.com/
(unless (package-installed-p 'json-mode)
  (package-install 'json-mode))

; Markdown support
; https://emacs.amodernist.com/
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'twilight t)
(load-theme 'panda t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-no-message t)
 '(column-number-mode t)
 '(hl-line-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(markdown-mode json-mode))
 '(require-final-newline 't))

;; set up line numbering
;; from https://www.reddit.com/r/emacs/comments/ucw1wz/comment/i6i5x3v/?utm_source=share&utm_medium=web2x&context=3
(setq-default display-line-numbers-width-start t
              display-line-numbers-width 1
              display-line-numbers-grow-only t)
(global-display-line-numbers-mode +1)

;; set up backups to go into a particular folder vs sprinkled everywhere
;; from https://www.emacswiki.org/emacs/BackupDirectory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacsbackup/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; hide menu bar in a TUI window, show it in a GUI window
;; from https://stackoverflow.com/questions/24956521/how-can-i-hide-the-menu-bar-from-a-specific-frame-in-emacs
(defun contextual-menubar (&optional frame)
  "Display the menubar in FRAME (default: selected frame) if on a
    graphical display, but hide it if in terminal."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines 
                             (if (display-graphic-p frame)
                                  1 0)))

(add-hook 'after-make-frame-functions 'contextual-menubar)
(add-hook 'after-init-hook 'contextual-menubar)

;; support for recent files

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; kill other than the current buffer
;; stole from https://stackoverflow.com/a/42862075/13100156
(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(global-set-key (kbd "C-x C-b") 'kill-other-buffers)

;; more interesting things
(global-set-key "\C-c\C-a" 'mark-whole-buffer)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cG" 'goto-char)
(global-set-key "\C-cw" 'delete-region) ; ala C-w and M-C-w
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

(setq-default indent-tabs-mode nil)

;; calendar - weeks start on mondays
(setq calendar-week-start-day 1)

;; set frame title to include directory reference
(setq frame-title-format "%b <%f>")

;; force a GUI window to be a certain size

(when (eq system-type 'darwin)

  ;; default Latin font (e.g. Consolas)
  ;; (set-face-attribute 'default nil :family "Consolas")

  ;; default font size (point * 10)
  ;;
  (set-face-attribute 'default nil :height 140)
  (when window-system (set-frame-size (selected-frame) 120 36))
  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
