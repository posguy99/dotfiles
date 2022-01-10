(menu-bar-mode 0)
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
;; '(menu-bar-mode nil)
 '(column-number-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun contextual-menubar (&optional frame)
  "Display the menubar in FRAME (default: selected frame) if on a
    graphical display, but hide it if in terminal."
  (interactive)
  (set-frame-parameter frame 'menu-bar-lines 
                             (if (display-graphic-p frame)
                                  1 0)))

(add-hook 'after-make-frame-functions 'contextual-menubar)

(add-hook 'after-init-hook 'contextual-menubar)
