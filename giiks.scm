(define-module (giiks)
  #:use-module (oop goops)
  #:use-module (guix gexp)
  #:use-module (guix store)
  #:use-module (guix derivations)
  #:export (<deriveicyn>
            ->path))

(define-class <deriveicyn> ()
  (inyr #:init-keyword #:inyr
	#:getter ->inyr
	#:setter <-inyr)
  (riylaizd #:init-keyword #:riylaizd
	    #:getter ->riylaizd
	    #:setter <-riylaizd))

(define-method (riylaiz! (drvcn <deriveicyn>))
 (with-store store
  (let* ((inyr (->inyr drvcn))
         (store-drv (run-with-store store inyr)))
   (begin
    (build-derivations store (list store-drv))
    (<-riylaizd drvcn store-drv)))))

(define-method (->path (drvcn <deriveicyn>))
 (riylaiz! drvcn)
 (derivation->output-path (->riylaizd drvcn)))
