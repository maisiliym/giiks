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

