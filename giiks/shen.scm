(define-module (giiks shen))
(use-modules 
 (guix packages) (guix gexp) (guix download)
 (guix git-download) (guix build-system gnu)
 (gnu packages) (gnu packages lisp)
 (srfi srfi-1) (ice-9 match))

(define-public shen-sources
  (let ((commit "e18789684218ca036a4e3e7360b952b642d6a144")
	(version "22.4"))
    (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/Shen-Language/shen-sources")
            (commit commit)))
      (file-name (git-file-name "shen-sources" version))
      (sha256
       (base32
        "1dzizvf14c6mkxyvpbhs2qkyg0lfm7liaqhs9sg6s734syiqrq7i")))))

(define-public shen-sbcl
  (package
    (name "shen-sbcl")
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