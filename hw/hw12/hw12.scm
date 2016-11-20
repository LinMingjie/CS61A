(define (find s predicate)
  (cond ((null? s) #f)
        ((pair? s) (if (predicate (car s))
                       (car s)
                       (find (cdr-stream s) predicate)))
        (else (if (predicate s)
                  s
                  #f)))
)

(define (scale-stream s k)
  (cons-stream (* k (car s))
               (scale-stream (cdr-stream s) k))
)

(define (has-cycle s)
  (define first (car s))
  (define (cycle? rest)
    (cond ((null? rest) #f)
          ((number? rest) #f)
          (else (if (and (= (car rest) first) (eq? rest s))
                    #t
                    (cycle? (cdr-stream rest))))))
  (cycle? (cdr-stream s))
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)
