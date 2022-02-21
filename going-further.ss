;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; syntactic extension
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; It is necessary for a Scheme implementation to distinguish between core forms and syntactic extensions.
;; A Scheme implementation expands syntactic extensions into core forms as the first step of compilation or interpretation, allowing the rest of the compiler or interpreter to focus only on the core forms.
;; The set of core forms remaining after expansion to be handled directly by the compiler or interpreter is implementation-dependent, however, and may be different from the set of forms described as core here.


;; Basic examples for Scheme macros
;; REFERENCE: http://www.shido.info/lisp/scheme_syntax_e.html
(define-syntax nil!
  (syntax-rules ()
    ((_ x)
     (set! x '()))))

(define-syntax when
  (syntax-rules ()
    ((_ pred expr ...)
    (if pred (begin (expr) ...)))))

(define-syntax for
  (syntax-rules ()
    ((_ (i from to) expr ...)
     (let loop ([i from])
       (if (< from to)
	   (begin (expr) ...
		  (loop (1+ i))))))))

(define-syntax let
  (syntax-rules ()
    ((_ ((x e) ...) expr ...)
     ((lambda (x ...) expr ...) e ...))))

(define-syntax and
  (syntax-rules ()
    [(_) #t]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (if e1 (and e2 e3 ...) #f)]))

(define-syntax and ; incorrect!
  (syntax-rules ()
    [(_) #t]
    [(_ e1 e2 ...)
     (if e1 (and e2 ...) #f)]))

(define-syntax or
  (syntax-rules ()
    [(_) #f]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (let ([t e1])
       (if t t (or e2 e3 ...)))]))

(define-syntax or
  (syntax-rules ()
    [(_) #f]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (let ([t e1])
       (if t t (or e2 e3 ...)))]))

(define-syntax or ; incorrect!
  (syntax-rules ()
    [(_) #f]
    [(_ e1 e2 ...)
     (let ([t e1])
       (if t t (or e2 ...)))]))


;; Exercise 3.1.1
