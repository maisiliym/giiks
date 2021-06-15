(define-module (giiks emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define-public emacs-base16-theme-alt
  (package
    (name "emacs-base16-theme")
    (version "b35d21a")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/belak/base16-emacs")
             (commit "b35d21ae0d46856416b64851ccbb5e44ee9498d0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "04vs50a5wh0ziq34hh9li5d84nv39p3akaync1i9sbmr4kxkhr1l"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/belak/base16-emacs")
    (synopsis "Base16 color themes for Emacs")
    (description
     "Base16 provides carefully chosen syntax highlighting and a default set
of sixteen colors suitable for a wide range of applications.  Base16 is not a
single theme but a set of guidelines with numerous implementations.")
    (license license:expat)))

(define-public emacs-git-undo
  (package
    (name "emacs-git-undo")
    (version "main")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jwiegley/git-undo-el")
             (commit "cf31e38e7889e6ade7d2d2b9f8719fd44f52feb5")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "10f9h8dby3ygkjqwizrif7v1wpwc8iqam5bvayahrabs87s0lnbi"))))
    (build-system emacs-build-system)
    (inputs `())
    (native-inputs `())
    (home-page "")
    (synopsis "")
    (description "")
    (license license:gpl3+)))

(define-public emacs-xah-fly-keys
  (package
    (name "emacs-xah-fly-keys")
    (version "0nhgi1h")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/xahlee/xah-fly-keys")
             (commit "f35ef2e8cb8208c30a7ba02df52f32d915073fe6")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "13xf12ci1anm6r8j90i6mj8pfmb8ffvhyzinz42046achhpymwnl"))))
    (build-system emacs-build-system)
    (inputs `())
    (native-inputs `())
    (home-page "")
    (synopsis "")
    (description "")
    (license license:gpl3+)))

(define-public emacs-multiple-cursors-dev
  (package
    (name "emacs-multiple-cursors-dev")
    (version "dev")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/magnars/multiple-cursors.el")
             (commit "616fbdd3696f99d85660ad57ebbb0c44d6c7f426")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "10raq8p881zzz7si3wfpcgdnwyl8y7y9rgw28akyigjyq8knl6kf"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/magnars/multiple-cursors.el")
    (synopsis "Multiple cursors for Emacs")
    (description
     "This package adds support to Emacs for editing text with multiple
simultaneous cursors.")
    (license license:gpl3+)))

(define-public emacs-shen-mode
  (package
    (name "emacs-shen-mode")
    (version "head")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/NHALX/shen-mode")
             (commit "43726db15c2a75dc6fe02eb215561f0a80f0f61c")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "00i11z8pswwlcsdpnv0kwp3m1hk6grcz71ay01khx958n4x76fw7"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/NHALX/shen-mode")
    (synopsis "An Emacs major mode for editing Shen source code")
    (description
     "")
    (license license:gpl3)))

(define-public emacs-shen-elisp
  (package
   (name "emacs-shen-elisp")
   (version "dev")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/maisiliym/shen-elisp")
           (commit "71985e0a8c1b7642ba92efea6041586963fe741f")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1h7v3bbljkw7lsxz4ijvw47c6fj070j0p268v4il2xh2mzw1nhjm"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/deech/shen-elisp")
    (synopsis "An implemenatation of the shen programming language in Elisp")
    (description "")
    (license license:bsd-3)))

(define-public emacs-sway
  (package
    (name "emacs-sway")
    (version "0.2.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/thblt/sway.el")
             (commit "8a4d9cc1a469efa707cf67b57b752f28547e331e")))
       (file-name (git-file-name name version))
       (sha256
	(base32 "0x5w3f07dsgbl7qlcqpmpm3831lrv5jx59g7xnv25giwc3w21d2d"))))
    (build-system emacs-build-system)
    (propagated-inputs
     `(("emacs-dash" ,emacs-dash)))
    (home-page "https://github.com/thblt/sway.el")
    (synopsis "")
    (description "")
    (license license:gpl3)))
