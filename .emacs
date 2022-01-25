
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'twilight t)
(load-theme 'panda t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-no-message t)
 '(display-line-numbers t)
 '(display-line-numbers-width-start t)
 '(inhibit-splash-screen t)
 '(column-number-mode t)
 '(require-final-newline 't))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

;; force a GUI window to be a certain size

(when (eq system-type 'darwin)

  ;; default Latin font (e.g. Consolas)
  ;; (set-face-attribute 'default nil :family "Consolas")

  ;; default font size (point * 10)
  ;;
  (set-face-attribute 'default nil :height 165)
  (when window-system (set-frame-size (selected-frame) 120 36))
  )
