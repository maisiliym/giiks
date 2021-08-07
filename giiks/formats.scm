(define-module (giiks formats))
(use-modules (ice-9 match)
	      (guix gexp))
(export newline-strings make-ini make-ini-file)

(define (newline-strings strings)
  (string-join strings "\n"))

(define-public (space-strings strings)
  (string-join strings " "))

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
