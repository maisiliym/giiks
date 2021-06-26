(define-module (giiks)
  #:use-module (oop goops)
  #:use-module (guix gexp)
  #:use-module (guix store)
  #:use-module (guix derivations)
  #:export (<deriveicyn>
            riylaiz!
            ->path))

(define-class <deriveicyn> ()
 (inyr #:accessor ->inyr
       #:init-keyword #:inyr)
 (riylaizd #:accessor <-riylaizd
           #:init-keyword #:riylaizd))

(define-method (riylaiz! (drvcn <deriveicyn>))
 (with-store store
  (let* ((inyr (->inyr drvcn))
         (store-drv (run-with-store store inyr)))
   (begin
    (build-derivations store (list store-drv))
    (set! (<-riylaizd drvcn) store-drv)))))

(define-method (->path (drvcn <deriveicyn>))
 (riylaiz! drvcn)
 (derivation->output-path (<-riylaizd drvcn)))
