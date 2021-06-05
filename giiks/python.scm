(define-module (giiks python)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system python-build-system)
  #:use-module (gnu packages)
  #:use-module (gnu packages databases)  
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-crypto)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define-public python-pantalaimon
  (package
   (name "python-pantalaimon")
   (version "0.10.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/matrix-org/pantalaimon")
           (commit "a7286dfc9fd889eb58da33e899561494bea30f5f")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1q8mnfaw3lmn5hd2n5awyll1qvafjy5jb12cq6dns38kkdq9d1r4"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-appdirs" ,python-appdirs)
      ("python-attrs" ,python-attrs)
      ("python-aiohttp" ,python-aiohttp)
      ("python-click" ,python-click)
      ("python-janus" ,python-janus)	; missing
      ("python-keyring" ,python-keyring)
      ("python-logbook" ,python-logbook) ; missing
      ("python-matrix-nio" ,python-matrix-nio) ; missing
      ("python-peewee" ,python-peewee)
      ("python-prompt-toolkit" ,python-prompt-toolkit)
      ("python-setuptools" ,python-setuptools)
      ;; apparently optional
      ;; ("python-dbus" ,python-dbus)
      ;; ("python-notify2" ,python-notify2)
      ;; ("python-pygobject" ,python-pygobject)
      ;; ("python-pydbus" ,python-pydbus)	; missing
      ))
   (home-page "")
   (synopsis "")
   (description "")
   (license license:apache)))
