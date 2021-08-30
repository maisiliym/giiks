(define-module (giiks strongswan))
(use-modules
  (guix packages)
  (guix download)
  (guix git-download)
  (guix build-system gnu)
  (guix build-system linux-module)
  (guix utils)
  (gnu packages)
  ((gnu packages vpn) #:select ((strongswan . guix/strongswan)))
  (gnu packages base)
  (gnu packages bash)
  (gnu packages dns)
  (gnu packages curl)
  (gnu packages golang)
  (gnu packages linux)
  (gnu packages pkg-config)
  (gnu packages tls))

(define-public strongswan-neks
  (package
    (inherit guix/strongswan)
    (name "strongswan-neks")
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'build 'patch-command-file-names
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "src/ipsec/_ipsec.in"
               (("cat|kill|sleep|rm|uname" command)
                (string-append (assoc-ref inputs "coreutils")
                               "/bin/" command)))
             (substitute* "src/libstrongswan/utils/process.c"
               (("/bin/sh")
                (string-append (assoc-ref inputs "bash") "/bin/sh")))

             (substitute* "src/libstrongswan/tests/suites/test_process.c"
               (("/bin/sh") (which "sh"))
               (("/bin/echo") (which "echo"))
               (("cat") (which "cat")))
             #t))
         (add-before 'check 'set-up-test-environment
           (lambda* (#:key inputs #:allow-other-keys)
             (setenv "TZDIR" (string-append (assoc-ref inputs "tzdata")
                                            "/share/zoneinfo"))
             #t)))
       #:configure-flags
       (list
        ; (todo uncommentWhenRebuilding)
        ;; "--disable-rc2"
        "--disable-des"
        "--disable-attr"
        "--disable-gmp"
        "--disable-ikev1"
        "--disable-md5"
        "--disable-sha1"
        "--disable-xcbc"
        "--disable-sshkey"
        "--disable-resolve"
        "--disable-scepclient"
        "--disable-stroke"
        "--disable-xauth-generic"
        "--enable-aesni"
        "--enable-chapoly"
        "--enable-openssl"
        "--with-capabilities=libcap")))
    (inputs
     `(("coreutils" ,coreutils)
       ("libcap" ,libcap)
       ("openssl" ,openssl)))
    (native-inputs
     `(("coreutils" ,coreutils)
       ("pkg-config" ,pkg-config)
       ("tzdata" ,tzdata-for-tests)))
    (synopsis "IKEv1/v2 keying daemon")
    (description "StrongSwan is an IPsec implementation originally based upon
the FreeS/WAN project.  It contains support for IKEv1, IKEv2, MOBIKE, IPv6,
NAT-T and more.")
    (home-page "https://strongswan.org/")
    (license #f)))
