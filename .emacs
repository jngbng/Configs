;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package manager
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize) 
  )

;; (normal-top-level-add-subdirs-to-load-path)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Node-js mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/.emacs.d/site-lisp/nodejs-mode/")
;(require 'nodejs-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2 mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clojure mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.paren$" . lisp-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; slime mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path "~/.emacs.d/site-lisp/slime/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/slime/contrib")
;(require 'slime)
;(slime-setup)
;
;
;
;(require 'slime-js)
;(add-hook 'js2-mode-hook
;  (lambda ()
;    (slime-js-minor-mode 1)))
;
;(add-hook 'css-mode-hook
;  (lambda ()
;    (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;    (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))
;
;;(eval-after-load 'auto-complete
;;  '(progn
;;     (add-to-list 'ac-modes 'slime-repl-mode)
;;     (add-to-list 'ac-modes 'js2-mode)
;;     (add-to-list 'ac-modes 'js-mode)
;;     (add-hook 'slime-mode-hook 'set-up-slime-ac)
;;     (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)))
;
;(eval-after-load 'slime
;  '(progn
;;    (require 'slime-fuzzy)
;;    (require 'auto-complete)
;;    (require 'ac-slime)
;;    (slime-fuzzy-init)
;    (setq slime-protocol-version 'ignore
;;          slime-net-coding-system 'utf-8-unix
;;          slime-complete-symbol*-fancy t
;;          slime-complete-symbol-function 'slime-fuzzy-complete-symbol
;          )
;    (slime-setup '(slime-repl slime-js slime-asdf))))

;;========================================
;; start the emacsserver that listens to emacsclient
(server-start)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functional options
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sentence-end "[^.].[.?!]+\\([]\"')}]*\\|<[^>]+>\\)\\($\\| $\\|\t\\| \\)[ \t\n]*")

(setq default-tab-width 4)  ; default tab space

(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-M-S-k") 'delete-pair)
(global-set-key (kbd "C-x C-{") 'insert-pair)
(global-set-key (kbd "C-x C-(") 'insert-pair)

; expend all tab to spaces
;; no tabs by default. modes that really need tabs should enable 
;; indent-tabs-mode explicitly. makefile-mode already does that, for 
;; example. 
(setq-default indent-tabs-mode nil) 
;; if indent-tabs-mode is off, untabify before saving 

;; but in emacs 24?!
;(add-hook 'write-file-hooks 
;  (lambda ()
;    (if (not indent-tabs-mode) 
;     (untabify (point-min) (point-max)
;      nil)))) 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp / Clojure mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;; (defun my-paredit-key () 
;;    "My binding for paredit-mode." 
;;      (define-key paredit-mode-map (kbd "C-c C-<") 'paredit-add-to-previous-list)
;;      (define-key paredit-mode-map (kbd "C-c C->") 'paredit-add-to-next-list))
;; (eval-after-load "paredit" 'my-paredit-key)

(eval-after-load "paredit" 
 '(progn
    (define-key paredit-mode-map (kbd "C-c C->") 'paredit-add-to-next-list)
    (define-key paredit-mode-map (kbd "C-c C-<") 'paredit-add-to-previous-list)
    (define-key paredit-mode-map (kbd "C-c C-j C-n") 'paredit-join-with-next-list)
    (define-key paredit-mode-map (kbd "C-c C-j C-p") 'paredit-join-with-previous-list)))


;; (add-event-receiver! 
;;  (ref-variable clojure-mode-hook) 
;;  (lambda (buffer) (enable-buffer-minor-mode! buffer (ref-mode-object paredit))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gdb
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gdb-many-windows t)
(global-set-key (kbd "C-x C-a <C-return>") '(lambda ()
                               (interactive)
                               (call-interactively 'gud-tbreak)
                               (call-interactively 'gud-cont)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; proof general
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (proofgeneral)
;(put 'set-goal-column 'disabled nil)
;; (setq proof-electric-terminator-enable 1)
;; ;; To split horizontally
;; ;(setq split-height-threshold nil)
;; ;(setq split-width-threshold 0)
;; (setq proof-three-window-enable t)
;; (eval-after-load "coq" '(define-key coq-mode-map (kbd "C-c c") 'coq-Compile))
;; (eval-after-load "coq" '(remove-hook 'proof-shell-handle-delayed-output-hook 'optim-resp-windows))
;; (eval-after-load "coq" '(remove-hook 'proof-shell-handle-error-or-interrupt-hook 'optim-resp-windows))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mercurial
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path (cons "~/.emacs.d/site-lisp/ahg/" load-path))
(require 'ahg)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C++ mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq c++-mode-hook 'my-key) 
(defun my-key () 
   "My binding for c++-mode." 
     (define-key c++-mode-map (kbd "C-c C-c") 'compile)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; Tuareg mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

(setq tuareg-use-smie t)

;;; Tuareg quick installation: Append this file to .emacs.
(add-to-list 'load-path "~/.emacs.d/site-lisp/tuareg-2.0.4/")

(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.eliom" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
(autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
(autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)
(dolist (ext '(".cmo" ".cmx" ".cma" ".cmxa" ".cmi"))
  (add-to-list 'completion-ignored-extensions ext))

;;; Sample customization

;; Indent `=' like a standard keyword.
(setq tuareg-lazy-= t)
;; Indent [({ like standard keywords.
(setq tuareg-lazy-paren t)
;; No indentation after `in' keywords.
(setq tuareg-in-indent 0)

(add-hook 'tuareg-mode-hook
  (lambda ()
    ;; turn on auto-fill minor mode
    (auto-fill-mode 1)))



(setq tuareg-default-indent 2
      tuareg-sig-struct-indent 2
      tuareg-function-indent 0
      tuareg-in-indent 0
      tuareg-let-always-indent 0
      tuareg-match-indent 0
      tuareg-pipe-extra-unindent 0
      tuareg-type-indent 0
      tuareg-let-indent 2
      tuareg-val-indent 2
      tuareg-with-indent 0
      tuareg-if-then-else-indent 2)

;;(autoload 'utop "utop" "Toplevel for OCaml" t)
;(autoload 'utop-eval-region "utop" "Toplevel for OCaml" t)
;(autoload 'utop-eval-phrase "utop" "Toplevel for OCaml" t)
;(autoload 'utop-eval-buffer "utop" "Toplevel for OCaml" t)

;(defun tuareg-utop-hook ()
;  (local-set-key "\M-\C-x" 'utop-eval-phrase)
;  (local-set-key "\C-x\C-e" 'utop-eval-phrase)
;  (local-set-key "\C-c\C-e" 'utop-eval-phrase)
;  (local-set-key "\C-c\C-r" 'utop-eval-region)
;  (local-set-key "\C-c\C-b" 'utop-eval-buffer))

;(add-hook 'tuareg-mode-hook 'tuareg-utop-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ocp-indent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-file "~/.opam/4.00.1/share/typerex/ocp-indent/ocp-indent.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell pop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
  ; the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
  (shell-pop-set-window-height 30) 
  ; shell-pop-up position. You can choose "top" or "bottom". 
  (shell-pop-set-window-position "bottom") 
 
(global-set-key [(control :)] 'shell-pop)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Load CEDET.
;; ;; See cedet/common/cedet.info for configuration details.
;; (load-file "~/.emacs.d/site-lisp/cedet-1.0pre7/common/cedet.el")


;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)

;; ;; Enable EDE for a pre-existing C++ project
;; ;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; ;; Enabling Semantic (code-parsing, smart completion) features
;; ;; Select one of the following:

;; ;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)

;; ;; * This enables some tools useful for coding, such as summary mode
;; ;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; ;; * This enables even more coding tools such as intellisense mode
;; ;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; ;; (semantic-load-enable-gaudy-code-helpers)

;; ;; * This enables the use of Exuberent ctags if you have it installed.
;; ;;   If you use C++ templates or boost, you should NOT enable it.
;; ;; (semantic-load-enable-all-exuberent-ctags-support)
;; ;;   Or, use one of these two types of support.
;; ;;   Add support for new languges only via ctags.
;; ;; (semantic-load-enable-primary-exuberent-ctags-support)
;; ;;   Add support for using ctags as a backup parser.
;; ;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; ;; Enable SRecode (Template management) minor-mode.
;; ;; (global-srecode-minor-mode 1)

;; ;; 캐쉬 파일 만들어 두는 곳
;; ;; 시스템 라이브러리는 같은 경우 거의 변경될 일이 없기 때문에
;; ;; 한 번 캐쉬되면 다음 번 자동완성에서는 빠르게 사용 가능합니다.
;; ;; 폴더 "~/.emacs.d/#semanticdb.cache#" 는 적당히 원하는 것으로 꼭 만들어 주어야 합니다.
;; (setq semanticdb-default-save-directory "~/.emacs.d/semanticdb.cache")

;; ;; 자동완성에 쓸 헤더 파일 경로 적는 예
;; ;; 이것이 있어야 #include 한 헤더파일의 내용도 자동완성에 나타납니다.
;; (semantic-add-system-include "/usr/include/GL/" 'c++-mode)       ;; opengl
;; (semantic-add-system-include "/usr/include/c++/4.6/" 'c++-mode)  ;; stl

;; ;; cedet semantic 인텔리센스 키바인딩 예제
;; (global-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
;; (global-set-key [(control shift return)] 'semantic-ia-complete-tip)
;; (global-set-key [(control c)(control return)] 'semantic-complete-analyze-inline)
;; (global-set-key [(shift return)] 'semantic-analyze-possible-completions)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; ECB 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/ecb")
;; (load-file "~/.emacs.d/site-lisp/ecb/ecb.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; webjump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'webjump)
(global-set-key (kbd "ESC ESC bm") 'webjump) ; bm 은 bookmark 의미
(global-set-key (kbd "ESC ESC wj") 'webjump)
(setq webjump-sites
      '(("emacs"           . "http://www.gnu.org/software/emacs/manual/emacs.html")
        ("elisp-intro"     . "http://www.gnu.org/software/emacs/emacs-lisp-intro/html_mono/emacs-lisp-intro.html")
        ("elisp-reference" . "http://www.gnu.org/software/emacs/elisp-manual/html_mono/elisp.html")
        ("msdn"            . "http://msdn.microsoft.com/library/default.asp")
        ("msdn-forum"      . "http://forums.microsoft.com/msdn/")    
        ("iostream"        . "http://www.cplusplus.com/ref/")
        ("stl"             . "http://www.sgi.com/tech/stl/table_of_contents.html")
        ("sgi"             . "http://www.sgi.com/tech/stl/")
        ("tr1"             . "http://www.aristeia.com/EC3E/TR1_info.html")
        ("man"             . "http://www.freebsd.org/cgi/man.cgi")
        ("wikipedia"       . "http://en.wikipedia.org/wiki/Main_Page")
        ("koders"          . "http://www.koders.com")
        ("c++faq"          . "http://www.parashift.com/c++-faq-lite/index.html")
        ("python"          . "http://www.python.org/doc/")
        ("erlang"          . "http://www.erlang.org/doc.html")
        ("sbcl"            . "http://www.sbcl.org/manual/")
        ("java"            . "http://java.sun.com/javase/6/docs/api/")
        ("haskell"         . "http://haskell.org/ghc/docs/latest/html/libraries/")))


; 현재 소스파일명으로 컴파일을 합니다. (ex. source.cpp -> source)
(defun compile-filename()
  "Compile buffer filename"
  (interactive)
  (let (compileString fileName))
  (setq fileName (file-name-nondirectory buffer-file-name))
  (setq fileName (file-name-sans-extension fileName))
  (setq compileString (format "g++ %s -o %s" buffer-file-name fileName))
  (compile compileString)
)

; 창을 두개로 나눠 쉘을 띄운 후 컴파일된 파일을 실행합니다.
(defun execute-filename ()
  "Run ./filename"
  (interactive)
  (let ((fileName (file-name-nondirectory buffer-file-name)))
    (setq fileName (format "./%s" (file-name-sans-extension fileName)))
    (setq windowHeight (- (window-height) 10))
    (split-window-vertically windowHeight)
    (other-window 1)
    (shell)
    (sit-for 0.1)
    (insert fileName)
    (comint-send-input) 
    )  
  )
;; M-x compile-filename 로 입력하니 불편하니 Ctrl+c c 로 컴파일 할수있게합니다.
(global-set-key [(control c) ?c] 'compile-filename)
;; 역시 실행시도 Ctrl+c x 로 실행할 수 있게 합니다.
(global-set-key [(control c) ?x] 'execute-filename)

(defun save-all-and-compile ()
  (save-some-buffers 1)
  (compile compile-command))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rectangle Mark
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x r C-SPC") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w") 'rm-kill-region)
(global-set-key (kbd "C-x r M-w") 'rm-kill-ring-save)
(autoload 'rm-set-mark "rect-mark"
          "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
          "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
          "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
          "Copy a rectangular region to the kill ring." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Buffer windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ido-mode 1)
(global-set-key "\C-x\C-b" 'buffer-menu)

(require 'buffer-move) 

(global-set-key (kbd "C-M-{")   'buf-move-up)
(global-set-key (kbd "C-M-?")   'buf-move-down)
(global-set-key (kbd "C-M-:")   'buf-move-left)
(global-set-key (kbd "C-M-\"")  'buf-move-right)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Speedbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sr-speedbar)
(global-set-key [f4] 'sr-speedbar-toggle)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-auto-refresh t)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell toggle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'shell-toggle "shell-toggle" 
 "Toggles between the *shell* buffer and whatever buffer you are editing."
 t)
(autoload 'shell-toggle-cd "shell-toggle" 
 "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(global-set-key [C-f1] 'shell-toggle)
;(global-set-key [C-f1] 'shell-toggle-cd)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(tool-bar-mode -1)
(show-paren-mode t)

 (require 'color-theme)
 (load-file "~/.emacs.d/themes/color-theme-blackboard.el")
 (color-theme-blackboard)
;(load-file "~/.emacs.d/themes/color-theme-tangotango.el")
;(color-theme-tangotango)

(require 'highline)
(global-highline-mode 1)
;(highline-mode 1)
   
;; To customize the background color
(set-face-background 'highline-face "#444")

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil  :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "xos4" :family "Terminus")))))


;; http://seorenn.blogspot.kr/2011/04/emacs_24.html
;; http://wiki.kldp.org/wiki.php/EmacsChangeFonts
(add-to-list 'default-frame-alist '(font . "Monospace"))
(if (eq system-type 'gnu/linux)
 (progn
  (set-fontset-font 
    "fontset-default" 
    'korean-ksc5601 
    '("Naver Dictionary" . "unicode-bmp")
   )
;;;; 유니코드 한글영역
;(set-fontset-font
;        "fontset-default"
;        '(#x1100 . #xffdc)
;        '("Naver Dictionary" . "unicode-bmp"))
;;;;유니코드 사용자 영역
;(set-fontset-font
;        "fontset-default"
;        '(#xe0bc . #xf66e)
;        '("Naver Dictionary" . "unicode-bmp"))
;(set-fontset-font
;        "fontset-default"
;        'kana
;        '("Dejavu Sans" . "unicode-bmp"))
;(set-fontset-font
;        "fontset-default"
;        'han
;        '("Dejavu Sans" . "unicode-bmp"))
) (message (symbol-name system-type)))

;; (setq face-font-rescale-alist '((".*Naver.*" . 1.0)))

; set nu -> linum-mode
; (load-library "setnu.el")
; (add-hook 'c-mode-hook 'turn-on-setnu-mode)
; (add-hook 'text-mode-hook 'turn-on-setnu-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; C-`. case change
(global-set-key [(control ?`)] 'up-down-case-char)
(defun up-down-case-char ()
  ;; mark & get cursor-char
  (interactive)
  (set-mark-command ())
  (forward-char 1)
  (setq myStr (buffer-substring (region-beginning) (region-end)))
  ;; make upper-case selected region
  (if (string-equal myStr (upcase myStr))
   (downcase-region (region-beginning) (region-end))
   (upcase-region (region-beginning) (region-end)))) 


(defun other-window-reverse ()
   (interactive)
     (other-window -1))

(global-set-key (kbd "C->") 'other-window)
(global-set-key (kbd "C-<") 'other-window-reverse)
;; windmove-left / right / up / down. S + arrow key
(windmove-default-keybindings 'meta)

;; reload setting while emacs is running
(defun reload-default-setting ()
   "Reload default.el"
     (interactive)
       (load-file "~/.emacs"))


;; show buffer-file-name in *message*
(defun show-file-name ()
   "Show the full path file name in the minibuffer."
     (interactive)
       (message (buffer-file-name)))

(defun copy-full-path-to-kill-ring ()
   "copy buffer's full path to kill ring"
     (interactive)
       (when buffer-file-name
            (kill-new (file-truename buffer-file-name))))

(defun my-copy-full-path-linum ()
   "copy buffer's full path to kill ring"
     (interactive)
       (when buffer-file-name
            (kill-new (concat (file-truename buffer-file-name) " +" (number-to-string (line-number-at-pos))))))

(global-set-key (kbd "C-c C-k") 'my-copy-full-path-linum)

;; tags

(fset 'find-next-tag "\C-u\256") ; macro for C-u M-. 
(fset 'find-prev-tag "\C-u-\256") ; macro for C-u - M-. 
(global-set-key "\M-]" 'find-next-tag) 
(global-set-key "\M-[" 'find-prev-tag)


(require 'xcscope)

(global-set-key (kbd "C-c TAB") 'ff-find-other-file) 


;; Revert buffer
(defun revert-buffer-no-confirm ()
   "Revert buffer without confirmation."
   (interactive) (revert-buffer t t))

;; (global-set-key (kbd "C-c C-r") 'revert-buffer-no-confirm)


;; Korean environment

(set-language-environment "Korean")
(setq default-input-method "korean-hangul")

;현재 버퍼를 다른 encoding으로 변환하여 저장하고자 할 때는 
;C-x C-m f 키(또는 M-x set-buffer-file-coding-system)를 누른 뒤 
;원하는 encoding(예, utf-8, cp949, euc-kr 등등)을 입력하고 엔터를 입력한다.

;현재 버퍼의 encoding이 적절하지 않아서 특정 encoding으로 다시 읽어오고자 한다면 
;C-x C-m r 키를 누른 뒤 
;원하는 encoding(예, utf-8, cp949, euc-kr 등등)을 입력하고 엔터를 친다.

(setq-default file-name-coding-system 'utf-8) 
(setq-default buffer-coding-system 'utf-8) 
(prefer-coding-system 'utf-8) 
(set-default-coding-systems 'utf-8) 



(require 'smart-compile)

(require 'cl)  ; for lexical-let

(defun do-execute (exe)
  ;; (with-current-buffer "*eshell*"
  ;;   (goto-char (point-max))
  ;;   (insert exe)
  ;;   (eshell-send-input))
  ;; (switch-to-buffer-other-window "*eshell*")
  ;; (with-selected-window (get-buffer-window "*eshell*" t)
  ;;   (goto-char (point-max)))
  (with-selected-window (next-window)
    (pop-to-buffer "*eshell*")
    (goto-char (point-max))
    (insert exe)
    (eshell-send-input))
  )

(defun save-compile-execute ()
  (interactive)
  (lexical-let ((exe (smart-compile-string "./%n"))
                finish-callback)
    ;; when compilation is done, execute the program
    ;; and remove the callback from
    ;; compilation-finish-functions
    (setq finish-callback
          (lambda (buf msg)
            (do-execute exe)
            (setq compilation-finish-functions
                  (delq finish-callback compilation-finish-functions))))
    (push finish-callback compilation-finish-functions))
  (smart-compile 1))



(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "C-c C-c") 'smart-compile)
(define-key my-keys-minor-mode-map (kbd "C-c C-r") 'save-compile-execute)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Confluence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/site-lisp/confluence-1.6/")

;; assuming confluence.el and xml-rpc.el are in your load path
(require 'confluence)

;; note, all customization must be in *one* custom-set-variables block

(custom-set-variables
 '(confluence-url "http://slp-info.sec.samsung.net/confluence/rpc/xmlrpc")
 '(confluence-default-space-alist (list (cons confluence-url "BROWSER")))
 '(confluence-save-credentials t)
 '(confluence-xml-convert-to-wiki-on-load t)
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; confluence editing support (with longlines mode)

(autoload 'confluence-get-page "confluence" nil t)

(eval-after-load "confluence"
  '(progn
       (add-hook 'confluence-mode-hook '(lambda () (local-set-key "\C-j" 'confluence-newline-and-indent)))))

;; keybindings (change to suit)

;; open confluence page
(global-set-key "\C-xwf" 'confluence-get-page)

;; setup confluence mode
(add-hook 'confluence-mode-hook
          '(lambda ()
             (local-set-key "\C-xw" confluence-prefix-map)))


(add-hook 'python-mode-hook
     '(lambda () 
         (local-set-key (kbd "C-c C-e") 'my-python-next-statement)))

(defun chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

;; https://groups.google.com/forum/#!topic/gnu.emacs.help/3s98uTafg6E
(defun my-python-next-statement (&optional _beg _end)
  (interactive)
  (let ((beg (cond (_beg beg)
                    ((region-active-p) (region-beginning))
                    (t  ;; (point-at-bol)
                        (line-beginning-position)
                        )))
        (end (cond (_end end)
                   ((region-active-p) (copy-marker (region-end)))
                   (t ;; (point-at-eol);; 
                      (line-end-position)
                      )))
        (working-buffer (current-buffer))
        (pythonWin (get-buffer-window "*Python*" t)))
    (let ((exe (if (or _beg _end (region-active-p))
                   (buffer-substring beg end)
                 (chomp (buffer-substring beg end)))))
    (if pythonWin
        ;; when python shell is visible
        (with-selected-window pythonWin
          (goto-char (point-max))
          (insert exe)
          (comint-send-input))
        ;; if not
        (progn
          (run-python)
          (goto-char (point-max))
          (insert exe)
          (comint-send-input)
          (select-window (get-buffer-window working-buffer)))))))
