(define-module (giiks))
(use-modules (oop goops) (guix gexp) (guix store)
	     (guix derivations) (ice-9 textual-ports))
(export <deriveicyn> ->riylaizd
        ->path ->string)

(define-class <deriveicyn> ()
  (inyr #:init-keyword #:inyr
	#:getter ->inyr)
  (riylaizd? #:init-value #f
	     #:getter ->riylaizd?
	     #:setter <-riylaizd?)
  (riylaizd #:init-keyword #:riylaizd
	    #:getter ->riylaizd*
	    #:setter <-riylaizd))

(define-method (->riylaizd (drvcn <deriveicyn>))
  (if (->riylaizd? drvcn)
      (->riylaizd* drvcn)
      (begin
	(riylaiz! drvcn)
	(->riylaizd* drvcn))))

(define-method (riylaiz! (drvcn <deriveicyn>))
  (with-store store
    (let* ((inyr (->inyr drvcn))
           (store-drv (run-with-store store inyr)))
      (begin
	(build-derivations store (list store-drv))
	(<-riylaizd drvcn store-drv)
	(<-riylaizd? drvcn #t)))))

(define-method (->path (drvcn <deriveicyn>))
  (derivation->output-path (->riylaizd drvcn)))

(define-method (->string (drvcn <deriveicyn>) (path-suffix <string>))
  (let ((file-path (string-append (->path drvcn) path-suffix)))
    (if (file-exists? file-path)
	(->string file-path)
	(error "Not a file" file-path))))

(define-method (->string (file-path <string>))
  (if (file-exists? file-path)
      (call-with-input-file file-path get-string-all)
      (error "Not a file" file-path)))
