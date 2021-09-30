(define-module (giiks nix))
(use-modules
 (guix git-download) (guix packages)
 (guix derivations)
 (gnu packages autotools)
 ((gnu packages package-management) #:select (nix))
 (gnu packages pkg-config))

; Doesnt build, missing deps
(define-public nixUnstable
  (let ((commit "bcd73ebf60bb9ba6cb09f8df4366d5474c16e4a4"))
    (package
      (inherit nix)
      (name "nixUnstable")
      (version "2.4pre20210922_bcd73eb")
      (source
       (origin
	 (method git-fetch)
	 (uri (git-reference
               (url "https://github.com/NixOS/nix")
               (commit commit)))
	 (sha256
	  (base32 "0h0hv8krdl9k8j5rl97yk5sa761cm0izznpvvdkm9dmnrpqz65n1"))))
      (arguments
       `(#:configure-flags '("--sysconfdir=/etc" "--enable-gc")
       #:phases
       (modify-phases %standard-phases
         (replace 'install
           (lambda* (#:key (make-flags '()) outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (etc (string-append out "/etc")))
               (apply invoke "make" "install"
                      (string-append "sysconfdir=" etc)
                      (string-append "profiledir=" etc "/profile.d")
                      make-flags)))))))
      (native-inputs
       (append `(("autoconf" ,autoconf)
		 ("automake" ,automake)
		 ("autoconf-archive" ,autoconf-archive))
	       (package-native-inputs nix))))))

