(define-module (giiks shen))
(use-modules 
 (guix packages) (guix gexp) (guix download)
 (guix git-download) (guix build-system gnu)
 (gnu packages) (gnu packages lisp)
 ((gnu packages bootstrap) #:select (glibc-dynamic-linker))
 ((gnu packages elf) #:select (patchelf))
 ((gnu packages chez) #:select (chez-scheme))
 ((gnu packages linux) #:select (util-linux))
 (srfi srfi-1) (ice-9 match))

(define-public shen-sbcl-bootstrap
  (package
    (name "shen-sbcl-bootstrap")
    (version "3.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/Shen-Language/shen-cl/releases/download/v"
	     version "/shen-cl-v" version "-sources.tar.gz"))
       (sha256
        (base32
         "0mc10jlrxqi337m6ngwbr547zi4qgk69g1flz5dsddjy5x41j0yz"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f ;tests are run in build phase
       #:phases
       (modify-phases %standard-phases
	 (add-after 'unpack 'link-shen-sources
	   (let* ((kernel (assoc-ref %build-inputs "shen-sources")))
	     (lambda _ (symlink kernel "kernel"))))
	 (replace 'configure (lambda _ #t))
	 (replace 'build (lambda _ (invoke "make" "sbcl")))
	 (replace 'install
	   (let* ((out (assoc-ref %outputs "out"))
		  (install-path (string-append out "/bin")))
	     (lambda _
	       (install-file "bin/sbcl/shen" install-path)))))))
    (inputs
     `(("shen-sources" ,shen-sources)
       ("sbcl" ,sbcl)))
    (home-page "https://github.com/Shen-Language/shen-cl")
    (synopsis "TBC")
    (description "TBC")
    (license #f)))

(define-public shen-chez-bootstrap
  (let ((version "0.24"))
    (package
      (name "shen-chez-bootstrap")
      (version version)
      (source
       (origin
	 (method url-fetch)
	 (uri (string-append
               "https://github.com/tizoc/shen-scheme/releases/download/v"
	       version "/shen-scheme-v" version "-linux-bin.tar.gz"))
	 (sha256
          (base32
           "0s3mrkmqz8f0df3djl5k0dvkhw00i6fc2r21mg4661s0rxgxa6dg"))))
      (build-system gnu-build-system)
      (arguments
       `(#:tests? #f
	 #:phases
	 (modify-phases %standard-phases
	   (replace 'configure (lambda _ #t))
	   (replace 'build
	     (let*
		 ((out (assoc-ref %outputs "out"))
		  (bin (string-append out "/bin"))
		  (sbcl-lib (assoc-ref %build-inputs "sbcl-lib"))
		  (libc (assoc-ref %build-inputs "libc"))
		  (ld-so (string-append libc ,(glibc-dynamic-linker)))
		  (rpath (string-append sbcl-lib "/lib" ":"
					libc "/lib")))
	       (lambda _
		 (invoke "patchelf" "--set-interpreter" ld-so
			 "--set-rpath" rpath "bin/shen-scheme"))))
	   (replace 'install
	     (let* ((out (assoc-ref %outputs "out"))
		    (bin-path (string-append out "/bin"))
		    (boot-file-path (string-append out "/lib/shen-scheme/")))
	       (lambda _
		 (rename-file "bin/shen-scheme" "bin/shen")
		 (install-file "bin/shen" bin-path)
		 (install-file "lib/shen-scheme/shen.boot"
			       boot-file-path)))))))
      (inputs
       `(("patchelf" ,patchelf)
	 ("sbcl-lib" ,util-linux "lib")))
      (home-page "https://github.com/tizoc/shen-scheme")
      (synopsis "TBC")
      (description "TBC")
      (license #f))))

(define-public shen shen-chez-bootstrap)

(define shen-sources-commit "e18789684218ca036a4e3e7360b952b642d6a144")
(define shen-sources-version "22.4")

(define shen-sources
  (origin
    (method git-fetch)
    (uri (git-reference
          (url "https://github.com/Shen-Language/shen-sources")
          (commit shen-sources-commit)))
    (file-name (git-file-name "shen-sources" shen-sources-version))
    (sha256
     (base32
      "1dzizvf14c6mkxyvpbhs2qkyg0lfm7liaqhs9sg6s734syiqrq7i"))))

(define-public shen-klambda
  (package
    (name "shen-klambda")
    (version shen-sources-version)
    (source shen-sources)
    (build-system gnu-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
	 (replace 'configure (lambda _ #t))
	 (replace 'build
	   (let* ((out (assoc-ref %outputs "out")))
	     (lambda _
	       (mkdir-p "klambda")
	       (invoke "shen" "eval" "-l"
		       "make.shen" "-e" "(make)"))))
	 (replace 'install
	   (let* ((out (assoc-ref %outputs "out"))
		  (install-path (string-append out "/lib/klambda")))
	     (lambda _
	       (copy-recursively "klambda" install-path)))))
       #:tests? #f))
    (inputs
     `(("shen" ,shen)))
    (home-page "https://github.com/Shen-Language/shen-sources")
    (synopsis "TBC")
    (description "TBC")
    (license #f)))

(define-public shen-chez
  (let ((version "0.24")
	(commit "908ec69c8e45d90eef6dca6c709cdaa30dcb760f")
        (revision "1"))
    (package
      (name "shen-chez")
      (version (git-version version revision commit))
      (source
       (origin
	 (method git-fetch)
	 (uri (git-reference
               (url "https://github.com/tizoc/shen-scheme")
               (commit commit)))
	 (sha256
          (base32
           "1041s8sb1yscyp8b5y79cxv2maja27lcdbq9g0116y2ji2qdmm5l"))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
	 (modify-phases %standard-phases
	   (replace 'configure
	     (let* ((klambda (string-append
			      (assoc-ref %build-inputs "shen-klambda")
			      "/lib/klambda")))
	       (lambda _
		 (delete-file-recursively "kl")
		 (copy-recursively klambda "kl"))))
	   (replace 'build
	     (let* ((out (assoc-ref %outputs "out")))
	       (lambda _
		 (invoke "shen" "script"
			 "scripts/do-build.shen"))))
	   (replace 'check
	     (let* ((out (assoc-ref %outputs "out"))
		    (install-path (string-append out "/bin")))
	       (lambda _
		 (invoke "./shen-scheme" "script"
			 "scripts/run-shen-tests.shen"))))
	   (replace 'install
	     (let* ((out (assoc-ref %outputs "out"))
		    (install-path (string-append out "/bin")))
	       (lambda _
		 (install-file "shen-scheme" install-path))))
	   )))
      (inputs
       `(("shen-klambda" ,shen-klambda)
	 ("shen-chez-bootstrap" ,shen-chez-bootstrap)
	 ("chez-scheme" ,chez-scheme)))
      (home-page "https://github.com/tizoc/shen-scheme")
      (synopsis "TBC")
      (description "TBC")
      (license #f))))
