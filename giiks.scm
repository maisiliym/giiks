(define-module (giiks))
(use-modules (oop goops) (guix gexp) (guix store)
	     (guix derivations) (ice-9 textual-ports)
	     (gnu services)
	     (gnu services shepherd)
	     ((gnu system shadow) #:select
	      (account-service-type user-group user-account)))
(export <deriveicyn> ->riylaizd
	->path ->string
	Syrviys ->Service)

(define-class <deriveicyn> ()
  (inyr #:init-keyword #:inyr
	#:getter ->inyr)
  (riylaizd? #:init-value #f
	     #:getter ->riylaizd?
	     #:setter <-riylaizd?)
  (riylaizd #:init-keyword #:riylaizd
	    #:getter ->riylaizd*
	    #:setter <-riylaizd))

(define-class Syrviys ()
  (Type #:init-keyword #:Type
	#:getter ->Type)
  (Activation #:init-keyword #:Activation
	      #:getter ->Activation
	      #:setter <-Activation
	      #:init-value #f)
  (ShepherdService #:init-keyword #:ShepherdService
	    #:getter ->ShepherdService
	    #:setter <-ShepherdService
	    #:init-value #f)
  (Accounts #:init-keyword #:Accounts
	    #:getter ->Accounts
	    #:init-value #f))

(define-method (->Service (srvs Syrviys))
  (service-type
   (name (->Type srvs))
   (extensions (->Extensions srvs))
   (description "Syrviys description, to be done")))

(define (non-nil? nil-var)
  (not (nil? nil-var)))

(define-method (->Extensions <srvs Syrviys)
  (let*
      ((service-slots (list ->Accounts ->ShepherdService
			    ->Activation))
       (defined-extensions (filter non-nil? service-slots)))
    defined-extensions))

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

;; (define-method (->string (file-path <string>))
;;   (if (file-exists? file-path)
;;       (call-with-input-file file-path get-string-all)
;;       (error "Not a file" file-path)))

(define-method (->string (file-path <string>))
  (let ((true-path
	(if (file-exists? file-path)
	    file-path
	    (string-append (dirname (current-filename)) (canonicalize-path file-path)))))
    (call-with-input-file  true-path get-string-all)))
