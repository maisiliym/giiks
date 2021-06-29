(define-module (giiks formats))
(use-modules ((ice-9 match)))
(export (newline-strings make-ini))

(define (newline-strings strings)
  (string-join strings "\n"))

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
     (string-append
      "[" name "]\n"
      (newline-strings
       (map make-ini-value content))))))


(define (make-ini config)
  (newline-strings (map make-ini-section config)))
