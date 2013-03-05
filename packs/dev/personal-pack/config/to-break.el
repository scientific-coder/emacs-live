(require 'org-crypt)
(require 'org-export)
(require 'org-e-beamer)
(require 'org-e-html)
(require 'org-e-latex)
(require 'org-protocol)

(require 'ob-clojure)
(require 'ob-ditaa)
(require 'ob-dot)
(require 'ob-plantuml)
(require 'ob-python)
(require 'ob-sh)

(setq org-babel-load-languages '((emacs-lisp . t) (C . t) (sh . t) (R . t) (sql . t) (clojure . t) (plantuml . t) (python . t) (ditaa . t) (dot . t)))
(defun my-org-confirm-babel-evaluate (lang body)
            (not (string= lang "ditaa")))  ; don't ask for ditaa
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
(setq org-plantuml-jar-path "/usr/local/lib/plantuml/plantuml.jar")
(setq org-link-abbrev-alist
       '(("bugzilla" . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
         ("google"   . "http://www.google.com/search?q=")
         ("ggdef"   . "http://www.google.com/search?q=define:")
         ("gmap"     . "http://maps.google.com/maps?q=%s")
         ("wksearch"     . "https://en.wikipedia.org/w/index.php?search=")
         ("omap"     . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1")
         ("ads"      . "http://adsabs.harvard.edu/cgi-bin/nph-abs_connect?author=%s&db_key=AST")))

(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(setq org-export-latex-packages-alist nil)
(add-to-list 'org-export-latex-packages-alist '("" "microtype"))
(add-to-list 'org-export-latex-packages-alist '("" "amssymb"))
(add-to-list 'org-export-latex-packages-alist '("" "textcomp"))
(add-to-list 'org-export-latex-packages-alist '("" "multicol"))
(add-to-list 'org-export-latex-packages-alist '("" "eurosym"))
(add-to-list 'org-export-latex-packages-alist '("" "ulem"))
(add-to-list 'org-export-latex-packages-alist '("" "color"))
(add-to-list 'org-export-latex-packages-alist '("" "graphicx"))
(add-to-list 'org-export-latex-packages-alist '("" "ragged2e"))
(add-to-list 'org-export-latex-packages-alist '("" "booktabs"))
(add-to-list 'org-export-latex-packages-alist '("" "hyperref"))
(add-to-list 'org-export-latex-packages-alist '("" "tabularx"))
(add-to-list 'org-export-latex-packages-alist '("" "colortbl"))
(add-to-list 'org-export-latex-packages-alist '("" "wasysym"))
(add-to-list 'org-export-latex-packages-alist '("" "minted"))
(add-to-list 'org-export-latex-packages-alist '("" "paralist"))
(add-to-list 'org-export-latex-packages-alist '("T1" "fontenc"))
(add-to-list 'org-export-latex-packages-alist '("AUTO" "inputenc"))
(setq org-entities-user nil)
(add-to-list 'org-entities-user '("space" "\\ " nil " " " " " " " "))
(add-to-list 'org-entities-user '("amacron" "\\={a}" nil "&#0257" "a" "a" "ā"))
(add-to-list 'org-entities-user '("emacron" "\\={e}" nil "&#0275" "e" "e" "ē"))
(add-to-list 'org-entities-user '("imacron" "\\={i}" nil "&#0299" "i" "i" "ī"))
(add-to-list 'org-entities-user '("omacron" "\\={o}" nil "&#0333" "o" "o" "ō"))
(add-to-list 'org-entities-user '("umacron" "\\={u}" nil "&#0363" "u" "u" "ū"))
(add-to-list 'org-entities-user '("Amacron" "\\={A}" nil "&#0256" "A" "A" "Ā"))
(add-to-list 'org-entities-user '("Emacron" "\\={E}" nil "&#0274" "E" "E" "Ē"))
(add-to-list 'org-entities-user '("Imacron" "\\={I}" nil "&#0298" "I" "I" "Ī"))
(add-to-list 'org-entities-user '("Omacron" "\\={O}" nil "&#0332" "O" "O" "Ō"))
(add-to-list 'org-entities-user '("Umacron" "\\={U}" nil "&#0362" "U" "U" "Ū"))
;; -shell-escape needed for pygment
;; (setq org-e-latex-pdf-process '("texi2dvi  --pdf --clean --verbose --batch %f"))
(setq org-e-latex-pdf-process '("pdflatex -shell-escape --verbose --batch %f"))

;; (setq org-e-latex-pdf-process		; for experimental org-export
;;         '("xelatex -interaction nonstopmode -output-directory %o %f"
;;      "xelatex -interaction nonstopmode -output-directory %o %f"
;;      "xelatex -interaction nonstopmode -output-directory %o %f"))
(define-key org-mode-map (kbd "C-c e") 'org-export-dispatch)
(setq org-e-latex-tables-booktabs t)
    (setq org-e-latex-remove-logfiles nil)
    (setq org-e-latex-toc-command "\\tableofcontents\n\n")
;; which Koma ?
;; (add-to-list 'org-e-latex-classes
;;           '("koma-article"
;;              "\\documentclass{scrartcl}
;; \\usepackage{hyperref} "
;;              ("\\section{%s}" . "\\section*{%s}")
;;              ("\\subsection{%s}" . "\\subsection*{%s}")
;;              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;              ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;              ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))



(add-to-list 'org-e-latex-classes
                 '("koma-article"
                   "\\documentclass{scrartcl}
      \\let\\itemize\\compactitem
      \\let\\description\\compactdesc
      \\let\\enumerate\\compactenum
      \\bibliography{local}
      \\newcolumntype{Y}{>{\\RaggedRight\\arraybackslash}X}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;; https://lists.gnu.org/archive/html/emacs-orgmode/2012-07/msg00122.html
(add-to-list 'org-e-latex-classes
               '("my-letter"
                 "\\documentclass\[%
  DIV=14,
  fontsize=12pt,
  parskip=half,
  subject=titled,
  backaddress=false,
  fromalign=left,
  fromemail=true,
  fromphone=true\]\{scrlttr2\}
  \[DEFAULT-PACKAGES]
  \[PACKAGES]
  \[EXTRA]"
                 ("\\section\{%s\}" . "\\section*\{%s\}")
                 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
                 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))
;;(setq org-export-latex-listings 'minted)
(setq org-e-latex-listings 'minted)
;;http://article.gmane.org/gmane.emacs.orgmode/60830
(add-to-list 'org-e-latex-classes
'("beamer"
     "\\documentclass[presentation]{beamer}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{minted}
      \\usepackage{minted}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))



;; (unless (package-installed-p 'cyberpunk-theme)
;;         (package-install 'cyberpunk-theme))
;; (load-theme 'cyberpunk t)
;; (set-cursor-color "yellow")


;; CEDET http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; http://stackoverflow.com/questions/10625328/setting-up-emacs-23-4-cedet-1-1-and-semanticdb-to-use-gnu-global-on-windows

;; (global-ede-mode t)
;; (semantic-load-enable-excessive-code-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)
;; (when (cedet-gnu-global-version-check t)
;;   (require 'semanticdb-global)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))
;; (when (cedet-ectag-version-check)
;;   (semantic-load-enable-primary-exuberent-ctags-support))
;; (defun my-cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
;; (add-hook 'c-mode-common-hook 'my-cedet-hook)
;; (defun my-c-mode-cedet-hook ()
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert))
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)
;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check)
;;   (semantic-load-enable-primary-exuberent-ctags-support))

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; (global-ede-mode t)
;; (ede-java-root-project "TestProject"
;;          :file "~/work/TestProject/build.xml"
;;          :srcroot '("src" "test")
;;          :localclasspath '("/relative/path.jar")
;;          :classpath '("/absolute/path.jar"))
;;(semantic-mode 1)


;; https://github.com/pallet/ritz/tree/develop/nrepl
;; in .lein/profiles.clj
;; {:user
;;  {:plugins [[lein-ritz "0.7.0"]]
;;   :dependencies [[ritz/ritz-nrepl-middleware "0.7.0"]]
;;   :repl-options {:nrepl-middleware
;;                  [ritz.nrepl.middleware.javadoc/wrap-javadoc
;;                   ritz.nrepl.middleware.simple-complete/wrap-simple-complete]}}}

;; from https://github.com/pallet/ritz/tree/develop/nrepl
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
              '("marmalade" . "http://marmalade-repo.org/packages/"))

;; should go in libs or own package
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar my-packages '(clojure-mode
                      nrepl
                      nrepl-ritz))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))
