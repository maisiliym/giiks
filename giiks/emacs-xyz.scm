(define-module (giiks emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
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

