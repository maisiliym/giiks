(define-module (giiks formats))
(use-modules (oop goops) (ice-9 match) (guix gexp))
(export newline-strings make-ini make-ini-file
        ->String ->NewlinedString ->SpacedString ->DottedString)

(define (newline-strings strings)
  (string-join strings "\n"))

(define-public (space-strings strings)
  (string-join strings " "))

(define-method (->String (int <integer>)) (number->string int))
(define-method (->String (str <string>)) str)

;; (idea [multipleArgs macro?])
(define-method (->NewlinedString (list <list>))
  (newline-strings (map ->String list)))

(define-method (->SpacedString (lst <list>))
  (space-strings (map ->String lst)))

(define-method (->DottedString (lst <list>))
  (string-join lst "."))

(define (make-ini-value conf)
  (match conf
    ((key value)
     (string-append
      key "="
      (match value
        ((? string? val) val)
        ((? number? val) (number->string val))
        (#t "true")
        (#f "false"))))))

(define (make-ini-section section)
  (match section
    ((name content)
     (match content
       ((value ...)
	(string-append
	 "[" name "]\n"
	 (newline-strings
	  (map make-ini-value content))))
       (string
	(make-ini-value section))))))

(define (make-ini config)
  (newline-strings (map make-ini-section config)))

(define (make-ini-file name config)
  (plain-file name (make-ini config)))
