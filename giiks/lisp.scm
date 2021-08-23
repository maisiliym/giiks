(define-module (giiks lisp)
  #:use-module (gnu packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix utils)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages base)
  #:use-module (gnu packages c)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages enchant)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages video)
  #:use-module (gnu packages web)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:use-module (gnu packages readline))

(define-public sbcl-clache
  (let ((commit "112976729565e1035532389ca25090ae99badd07")
        (revision "1"))
    (package
      (name "sbcl-clache")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/html/clache.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0wxg004bsay58vr6xr6mlk7wj415qmvisqxvpnjsg6glfwca86ys"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("alexandria" ,sbcl-alexandria)
	 ("babel" ,sbcl-babel)
	 ("cl-annot" ,sbcl-cl-annot)
	 ("cl-fad" ,sbcl-cl-fad)
	 ("cl-store" ,sbcl-cl-store)
	 ("cl-syntax" ,sbcl-cl-syntax)
	 ("cl-syntax-annot" ,sbcl-cl-syntax)
	 ("ironclad" ,sbcl-ironclad)
	 ("trivial-garbage" ,sbcl-trivial-garbage)))
      (home-page "https://github.com/html/clache.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-cl-readline
  (let ((commit "8438c9ebd92ccc95ebab9cc9cbe6c72d44fccc58")
        (revision "1"))
    (package
      (name "sbcl-cl-readline")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/vindarel/cl-readline.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "14iskvqfw71ssaav483vmqw62lrpznysjs800gjjppxs785p1fa0"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("alexandria" ,sbcl-alexandria)
	 ("cffi" ,sbcl-cffi)
	 ("readline" ,readline)))
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'fix-paths
             (lambda* (#:key inputs #:allow-other-keys)
               (substitute* "cl-readline.lisp"
                 (("libreadline.so" all)
                  (string-append (assoc-ref inputs "readline")
                                 "/lib/" all))))))))
      (home-page "https://github.com/vindarel/cl-readline.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-cl-transmission
  (let ((commit "4bbf1d2761bfa5dfa79b7bc12c3238089b994d95")
        (revision "1"))
    (package
      (name "sbcl-cl-transmission")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/libre-man/cl-transmission.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0sg3f2jqs2z3mvscjhc43hkd34vlcc4c8hq8rhh5w1gjg19z57hb"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("cl-ppcre" ,sbcl-cl-ppcre)
	 ("drakma" ,sbcl-drakma)
	 ("jonathan" ,sbcl-jonathan)
	 ("named-readtables" ,sbcl-named-readtables)
	 ("prove" ,sbcl-prove)
	 ("rutils" ,sbcl-rutils)
	 ("uiop" ,cl-asdf)))
      (arguments '(#:tests? #f))
      (home-page "https://github.com/libre-man/cl-transmission.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-mockingbird
  (let ((commit "bf56e15faf8684fb96bd8094bd76c2d1b966c0ae")
        (revision "1"))
    (package
      (name "sbcl-mockingbird")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Chream/mockingbird.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1n1mxl2qk7g63z92d943ysn12axw0bx5dvw0cmm3cs1hjpx5rdly"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("prove" ,sbcl-prove)
	 ("closer-mop" ,sbcl-closer-mop)
	 ("fare-utils" ,sbcl-fare-utils)
	 ("trivial-arguments" ,sbcl-trivial-arguments)
	 ))
      (arguments
       '(#:asd-files '("mockingbird-test.asd" "mockingbird.asd")
	 #:tests? #f))
      (home-page "https://github.com/Chream/mockingbird.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-replic
  (let ((commit "57c73236b2d307c074ddfe677130ef6928061c74")
        (revision "1"))
    (package
      (name "sbcl-replic")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/vindarel/replic.git")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0i21hrfhvkqggibbivlcsnk5mlk5x3bim50g9bwz1glqn7cm6mfi"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("cl-ansi-text" ,sbcl-cl-ansi-text)
	 ("cl-readline" ,sbcl-cl-readline)
	 ("prove" ,sbcl-prove)
	 ("py-configparser" ,sbcl-py-configparser)
	 ("shlex" ,sbcl-shlex)
	 ("str" ,sbcl-cl-str)
	 ("unix-opts" ,sbcl-unix-opts)))
      (arguments '(#:tests? #f))
      (home-page "https://github.com/vindarel/replic.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-torrents
  (let ((commit "57bc8b9e8350d18f0aa55a46e1fec3af25d63883")
        (revision "1"))
    (package
      (name "sbcl-torrents")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://gitlab.com/vindarel/cl-torrents/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1c47makx98f8c811j91xhd0v7d740n5j831ykirm1zji7ndvq8d3"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("access" ,sbcl-access)
	 ("clache" ,sbcl-clache)
	 ("cl-ansi-text" ,sbcl-cl-ansi-text)
	 ("cl-readline" ,sbcl-cl-readline)
	 ("cl-transmission" ,sbcl-cl-transmission)
	 ("dexador" ,sbcl-dexador)
	 ("jonathan" ,sbcl-jonathan)
	 ("log4cl" ,sbcl-log4cl)
	 ("lparallel" ,sbcl-lparallel)
	 ("lquery" ,sbcl-lquery)
	 ("mockingbird" ,sbcl-mockingbird)
	 ("nodgui" ,sbcl-nodgui)
	 ("parse-float" ,sbcl-parse-float)
	 ("plump" ,sbcl-plump)
	 ("prove" ,sbcl-prove)
	 ("py-configparser" ,sbcl-py-configparser)
	 ("replic" ,sbcl-replic)
	 ("str" ,sbcl-cl-str)
	 ("unix-opts" ,sbcl-unix-opts)))
      (arguments
       '(#:asd-systems '("torrents")
         #:tests? #f))
      (home-page "https://gitlab.com/vindarel/cl-torrents/")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))

(define-public sbcl-rutils
  (let ((commit "b0deae523641a1de8ffff86c41404c92c2399f8f")
        (revision "head"))
    (package
      (name "sbcl-rutils")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Hellseher/rutils")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "1y4n25qamyyr6sza06418vjkw1yhhg5bsz9zs1rfzirm91s1xjnp"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       `(("closer-mop" ,sbcl-closer-mop)
	 ("named-readtables" ,sbcl-named-readtables)))
      (arguments
      `(#:tests? #f))
      (home-page "https://github.com/vseloved/rutils.git")
      (synopsis "TBC")
      (description
       "TBC")
      (license #f))))
