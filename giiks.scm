(define-module (giiks))
(use-modules (oop goops) (guix gexp) (guix store)
	     (guix derivations))
(export <deriveicyn> ->riylaizd
        ->path ->string)

(define-class <deriveicyn> ()
  (inyr #:init-keyword #:inyr
	#:getter ->inyr)
  (riylaizd? #:init-keyword #:riylaizd?
	     #:getter ->riylaizd?
	     #:setter <-riylaizd?)
  (riylaizd #:init-keyword #:riylaizd
	    #:getter ->riylaizd
	    #:setter <-riylaizd
	    #:allocation #:virtual
	    #:slot-ref ->riylaiz*
	    #:slot-set! <-riylaiz*))

(define-method (->riylaiz* (drvcn <deriveicyn>))
  (if (->riylaizd? drvcn)
      (slot-ref 'riylaizd drvcn)
      ()))

(define-method (riylaiz! (drvcn <deriveicyn>))
  (with-store store
    (let* ((inyr (->inyr drvcn))
           (store-drv (run-with-store store inyr)))
      (begin
	(build-derivations store (list store-drv))
	(set! (riylaizd drvcn) store-drv)))))

(define-method (->path (drvcn <deriveicyn>))
  (riylaiz! drvcn)
  (derivation->output-path (<-riylaizd drvcn)))

(define-method (->string (drvcn <deriveicyn>) (path-suffix <string>))
  (nil))
