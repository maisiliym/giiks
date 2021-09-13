(define-module (giiks rust))
(use-modules
 (gnu packages rust) (guix build-system cargo)
 ((guix licenses) #:prefix license:)
 (guix download) (guix git-download)
 (guix packages) (gnu packages compression)
 (gnu packages crates-io) (gnu packages crates-graphics))

(define-public rust-serde-transcode-1
  (package
    (name "rust-serde-transcode")
    (version "1.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "serde-transcode" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1qlh34kw4knbs83xy6x0wwbb71pbiivcw6swpy2nxfx5q8jhw32r"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/sfackler/serde-transcode")
    (synopsis
      "Transcode from one Serde format to another")
    (description
      "Transcode from one Serde format to another")
    (license (list license:expat license:asl2.0))))

(define-public rust-babelfish-0.2
  (package
    (name "rust-babelfish")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "babelfish" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "02j2gr6d9nsy5v9i2r4canqyf2wdwngg81adr82fbxg10gcmvbi0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-serde-transcode" ,rust-serde-transcode-1)
         ("rust-serde-cbor" ,rust-serde-cbor-0.11)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-yaml" ,rust-serde-yaml-0.8)
         ("rust-toml" ,rust-toml-0.5))))
    (home-page
      "https://github.com/pickfire/babelfish")
    (synopsis "Universal translater for encodings")
    (description
      "Universal translater for encodings")
    (license (list license:expat license:asl2.0))))
