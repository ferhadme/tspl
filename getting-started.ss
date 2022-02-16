;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; interacting with scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

"hello" ;; => "hello"
42 ;; => 42
22/7 ;; => 22/7
3.141592653 ;; => 3.141592653
+ ;; => #<procedure>
(+ 76 31) ;; => 107
(* -12 10) ;; => -120
'(a b c d) ;; => (a b c d)

(car '(a b c)) ;; => a
(cdr '(a b c)) ;; => (b c)
(cons 'a '(b c)) ;; => (a b c)
(cons (car '(a b c))
      (cdr '(d e f))) ;; => (a e f)

(define square
  (lambda (n)
    (* n n)))
(square 5) ;; => 25
(square -200) ;; => 40000
(square 0.5) ;; => 0.25
(square -1/2) ;; => 1/4

(define reciprocal
  (lambda (n)
    (if (= n 0)
        "Oops!"
        (/ 1 n))))
(reciprocal 10) ;; => 1/10
(reciprocal 1/10) ;; => 10
(reciprocal 0) ;; => "Oops!"
(reciprocal (reciprocal 1/10)) ;; => 1/10


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; simple expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The simplest Scheme expressions are constant data objects, such as strings, numbers, symbols, and lists
123456789987654321 ;; => 123456789987654321
3/4 ;; => 3/4
2.718281828 ;; => 2.718281828
2.2+1.1i ;; => 2.2+1.1i

;; Prefix notation for even common arithmetic operations. That's why there are no rules regarding to precedence
(+ 1/2 1/2) ;; => 1
(- 1.5 1/2) ;; => 1.0
(* 3 1/2) ;; => 3/2
(/ 1.5 3/4) ;; => 2.0
(+ (+ 2 2) (+ 2 2)) ;; => 8
(- 2 (* 4 1/3)) ;; => 2/3
(* 2 (* 2 (* 2 (* 2 2)))) ;; => 32
(/ (* 6/7 7/2) (- 4.5 1.5)) ;; => 1.0

;; In many languages, the basic aggregate data structure is the array. In Scheme, it is the list
(1 2 3 4)
("Hello" "world")
(1 "hi")
;; As can be seen, procedure and list have the same definition. Because, everything is a list in LISP (even functions)
;; list as data -> (obj1 obj2 ...)
;; list as procedure -> (procedure arg ...)
;; Deciding to treat list as procedure or data depends on first item of list
;; Scheme explicitly to treat a list as data rather than as a procedure application
;; In order to explicitly treat a list as data (in case of, first element of list is procedure e.g +, -), quote should be used
(1 2 3 4 5) ;; => (1 2 3 4 5)
(quote (1 2 3 4 5)) ;; => (1 2 3 4 5)
'(1 2 3 4 5) ;; => (1 2 3 4 5)
(+ 3 4) ;; => 7
(quote (+ 3 4)) ;; => (+ 3 4)
;; quote can be simply rewritten with '
'(+ 3 4) ;; => (+ 3 4)
;; Not all quote expressions involve lists
hello ;; => hello. Scheme tries to evaluate hello variable
'hello ;; => hello. Scheme doesn't evaluate hello for its quote. These atoms called symbols
'2 ;; => 2
'2/3 ;; => 2/3
;; Numbers and strings are treated as constants in any case, however, so quoting them is unnecessary

;; Manipulating Lists
;; car -> head of the list
;; cdr -> tail of the list
;; Each requires nonempty lists
(car '(a b c)) ;; => a
(cdr '(a b c)) ;; => (b c)
(cdr '(a)) ;; => ()
(car (cdr '(a b c))) ;; => b
(cdr (cdr '(a b c))) ;; => (c)
(car '((a b) (c d))) ;; => (a b)
(cdr '((a b) (c d))) ;; => ((c d))

;; Constructing lists. Takes two arguments, the second one is usually is list. Called as linked list also, which itself can be thought as pair of items, where item can be constant, symbol or pair. This continues recursively. That's why list processing is in recursive nature
(cons 'a '()) ;; => (a)
(cons 'a '(b c)) ;; => (a b c)
(cons 'a (cons 'b (cons 'c '()))) ;; => (a b c)
(cons '(a b) '(c d)) ;; => ((a b) c d)
(car (cons 'a '(b c))) ;; => a
(cdr (cons 'a '(b c))) ;; => (b c)
(cons (car '(a b c))
      (cdr '(d e f))) ;; => (a e f)
(cons (car '(a b c))
      (cdr '(a b c))) ;; => (a b c)

;; The empty list is a proper list, and any pair whose cdr is a proper list is a proper list.
(cons 'a 'b) ;; => (a . b) -> improper list, because:
(cdr '(a . b)) ;; => b
(cons 'a '(b . c)) ;; => (a b . c) -> improper list
(cons 'a '(b c)) ;; => (a b c) -> proper list

;; The procedure list is similar to cons, except that it takes an arbitrary number of arguments and always builds a proper list.
(list 'a 'b 'c) ;; => (a b c)
(list 'a) ;; => (a)
(list) ;; => ()



;; Exercise 2.2.1
(+ (* 1.2 (- 2 1/3)) -8.7)
(/ (+ 2/3 4/9) (- 5/11 4/3))
(+ 1 (/ 1 (+ 2 (/ 1 (+ 1 1/2)))))
(* 1 -2 3 -4 5 -6 7)


;; Exercise 2.2.2
;; +
(+ 1 1) ;; => 2
(+ 1/2 1) ;; => 3/2
(+ 1/2 1/2) ;; => 2
(+ 0.5 1) ;; => 1.5
(/ 1 2) ;; => 1/2
(/ 1.0 2) ;; => 0.5
(* 2 2) ;; => 4
(* 2 0.2) ;; => 0.4
(* 2 1/5) ;; => 2/5
(- 1 0.5) ;; => 0.5
(- 1 1/2) ;; => 1/2
;; General rule can be defined as:
;; If procedure is one of +, -, *:
;;   If one of arguments is written as x/y where x and y are integers:
;;     If result of expression can be written as another integer:
;;       Result will be integer
;;     Else (result of expression can not be written as another integer):
;;       Result will be x/y where x and y are integers
;;   Else (none of arguments is written as x/y where x and y are integers):
;;       Result will be written as x, where x is real number
;; Else (procedure is /):
;;   If arguments are integers or x/y (where x and y are integers):
;;     Result will be written as x/y (where x and y are integers)
;;   Else (all arguments are not integers, e.g float number:
;;     Result will be float number


;; Exercise 2.2.3
(cons 'car 'cdr) ;; => (car . cdr)
(list 'this '(is silly)) ;; => (this (is silly))
(cons 'is '(this silly?)) ;; => (is this silly?)
(quote (+ 2 3)) ;; => (+ 2 3)
(cons '+ '(2 3)) ;; => (+ 2 3)
(car '(+ 2 3)) ;; => +
(cdr '(+ 2 3)) ;; => (2 3)
cons ;; => #<procedure cons>
(quote cons) ;; => cons
(quote (quote cons)) ;; => 'cons
(car (quote (quote cons))) ;; => quote
(+ 2 3) ;; => 5
(+ '2 '3) ;; => 5
(+ (car '(2 3)) (car (cdr '(2 3)))) ;; => 5
((car (list + - * /)) 2 3) ;; => 5


;; Exercise 2.2.4
'((a b) (c d)) ;; b c d
(car (cdr (car '((a b) (c d))))) ;; => b
(car (car (cdr '((a b) (c d))))) ;; => c
(car (cdr (car (cdr '((a b) (c d)))))) ;; => d


;; Exercise 2.2.5
(cons
 (cons 'a 'b)
 (cons
  (cons
   (cons 'c '())
   (cons 'd '()))
  (cons '() '())))


;; Exercise 2.2.6
(cons 1
      (cons '(2 . ((3) . ()))
            (cons '(())
                  (cons 4 5)))) ;; => (1 (2 (3)) (()) 4 . 5)
#|
1    |
 |       |
2 |    () |
 | '     4 5
3 '

(1 (2 (3)) (()) 4 . 5)
|#


;; Exercise 2.2.7
'((a b) (c d))
(car '((a b) (c d))) ;; => (a b)
(car '(a b)) ;; => a
(cdr '(a b)) ;; => (b)
(car '(b)) ;; => b
(cdr '(b)) ;; => ()
(cdr '((a b) (c d))) ;; => ((c d))
(car '(c d)) ;; => c
(cdr '(c d)) ;; => (d)
(car '(d)) ;; => d
(cdr '(d)) ;; => ()


;; Exercise 2.2.8
;; (procedure arg1 ... argn)
;; Find the value of procedure
;; Find the value of arg1
;; Find the value of argn
;; Apply the value of procedure to values of arg1 ... argn
;; This steps go recursively
((car (list + - * /)) 2 3)
(+ 2 3) ;; => 5


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evaluating scheme expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The evaluation of a quote expression is more similar to the evaluation of constant objects. The value of a quote expression of the form (quote object) is simply object.
;; Procedures are also variables



;; Exercise 2.3.1
((car (cdr (list + - * /))) 17 5)
((car (- * /)) 17 5)
(- 17 5) ;; => 12


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; variables and let expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; General form of let expression
(let ((var expr) ...) body1 body2 ...)
;; () == [], so:
(let ([var expr] ...) body1 body2 ...)

;; The variables bound by let are visible only within the body of the let.
(let ([+ *])
  (+ 2 3)) ;; => 6
(+ 2 3) ;; => 5

;; It is possible to nest let expressions.
(let ([a 4] [b -3])
  (let ([a-squared (* a a)]
        [b-squared (* b b)])
    (+ a-squared b-squared))) ;; => 25

;; The inner binding for x is said to shadow the outer binding.
;; A let-bound variable is visible everywhere within the body of its let expression except where it is shadowed.
;; The region where a variable binding is visible is called its scope.
;; The scope of the first x in the example above is the body of the outer let expression minus the body of the inner let expression, where it is shadowed by the second x.
;; This form of scoping is referred to as lexical scoping, since the scope of each binding can be determined by a straightforward textual analysis of the program.
(let ([x 1])
  (let ([x (+ x 1)])
    (+ x x))) ;; => 4


;; Exercise 2.4.1
(+ (- (* 3 a) b) (+ (* 3 a) b))
(let ([mul3a (* 3 a)])
  (+ (- mul3a b) (+ mul3a b)))

(cons (car (list a b c)) (cdr (list a b c)))
p(let ([q (list a b c)])
  (cons (car q) (cdr q)))


;; Exercise 2.4.2
(let ([x 9])
  (* x
     (let ([x (/ x 3)])
       (+ x x)))) ;; => 54
(* 9 (+ 3 3)) ;; => 54


;; Exercise 2.4.3
(let ([x 'a] [y 'b])
  (list (let ([x 'c]) (cons x y))
        (let ([y 'd]) (cons x y))))
(let ([x 'a] [y 'b])
  (list (let ([inner-x 'c]) (cons inner-x y))
        (let ([inner-y 'd]) (cons x inner-y))))

(let ([x '((a b) c)])
  (cons (let ([x (cdr x)])
          (car x))
        (let ([x (car x)])
          (cons (let ([x (cdr x)])
                  (car x))
                (cons (let ([x (car x)])
                        x)
                      (cdr x))))))
(let ([x '((a b) c)])
  (cons (let ([x1 (cdr x)])
          (car x1))
        (let ([x2 (car x)])
          (cons (let ([x3 (cdr x2)])
                  (car x3))
                (cons (let ([x4 (car x2)])
                        x4)
                      (cdr x2))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lambda expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The general form of a lambda expression
(lambda (var ...) body1 body2 ...) ;; => #<procedure>
((lambda (x) (+ x x)) (* 3 4)) ;; => 24

;; Incidentally, a let expression is nothing more than the direct application of a lambda expression to a set of argument expressions
(let ([x 'a]) (cons x x)) ;; => (a . a)
((lambda (x) (cons x x)) 'a) ;; => (a . a)



;; Exercise 2.5.1
(let ([f (lambda (x) x)])
  (f 'a)) ;; => a

(let ([f (lambda x x)])
  (f 'a)) ;; => (a)

(let ([f (lambda (x . y) x)])
  (f 'a)) ;; => a

(let ([f (lambda (x . y) y)])
  (f 'a)) ;; => ()


;; Exercise 2.5.2
(define list
  (lambda x
    (if (null? x) '()
        (cons (car x)
              (cdr x)))))
;; or
(define list (lambda x x))


;; Exercise 2.5.3
(lambda (f x) (f x)) ;; there is not
(lambda (x) (+ x x)) ;; + procedure
(lambda (x y) (f x y)) ;; f procedure

(lambda (x)
  (cons x (f x y))) ;; cons f procedures, y variable

(lambda (x)
  (let ([z (cons x y)])
    (x y z))) ;; cons procedure, y variable

(lambda (x)
  (let ([y (cons x y)])
    (x y z))) ;; cons procedure, y z variable


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; top-level definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define double-any
  (lambda (f x)
    (f x x)))

(define doubler
  (lambda (f)
    (lambda (x) (f x x))))

(define double/+ (doubler +))
(double/+ 2 2) ;; => 4



;; Exercise 2.6.1
(double-any double-any double-any)
;; Causes infinite loop


;; Exercise 2.6.2
(define compose
  (lambda (f1 f2)
    (lambda (x) (f1 (f2 x)))))

(define cadr (compose car cdr))
(cadr '(1 2 3 4)) ;; => 2
(define cddr (compose cdr cdr))
(cddr '(1 2 3 4)) ;; => '(3 4)


;; Exercise 2.6.3
(define caar (compose car car))
(define cdar (compose cdr car))
(define caaar (compose caar car))
(define caadr (compose caar cdr))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; conditional expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define abs
  (lambda (n)
    (if (< n 0) (- 0 n)
        n)))

;; Why is if a syntactic form and not a procedure?
(define reciprocal
  (lambda (n)
    (if (= n 0)
        "Oops!"
        (/ 1 n))))
;; IF if were a procedure, then scheme would be evaluate all of its arguments in order to apply them to the procedure
;; In this case there would be no way to write reciprocal procedure for values where n = 0
;; That's why if a syntactic form, not a procedure
;; or, and, if, cond all belongs to syntactic form class

;; every scheme object has truth value
;; 1, #t, '(), '(1 2 3) -> true
;; #f -> false

(define reciprocal
  (lambda (n)
    (and (not (= n 0))
         (/ 1 n))))

;; type predicates
(pair? '(1 2 3)) ;; => #t
(pair? '(1 . 3)) ;; => #t
(pair? '()) ;; => #f

(define reciprocal
  (lambda (n)
    (if (and (number? n) (not (= n 0)))
        (/ 1 n)
        (assertion-violation 'reciprocal "improper argument" n))))



;; Exercise 2.7.1
(define atom?
  (lambda (x)
    (if (pair? x) #f
        #t)))


;; Exercise 2.7.2
(define shorter
  (lambda (q1 q2)
    (let ([len1 (length q1)]
          [len2 (length q2)])
      (if (<= len1 len2) q1 q2))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; simple recursion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define goodbye
  (lambda ()
    (goodbye)))
;; Most recursive procedures should have at least two basic elements, a base case and a recursion step

(define length
  (lambda (q)
    (if (null? q)
        0
        (+ 1
           (length (cdr q))))))

(define copy-list
  (lambda (q)
    (if (null? q)
        '()
        (cons (car q)
              (copy-list (cdr q))))))

(define memv
  (lambda (obj q)
    (cond
     [(null? q) #f]
     [(equal? obj (car q)) #t]
     [else (memv obj (cdr q))])))

(define remv
  (lambda (obj q)
    (cond
     [(null? q) '()]
     [(equal? obj (car q))
      (remv obj (cdr q))]
     [else (cons (car q) (remv obj (cdr q)))])))

(define tree-copy
  (lambda (tr)
    (if (not (pair? tr))
        tr
        (cons
         (tree-copy (car tr))
         (tree-copy (cdr tr))))))

;; restricted version of map function for one procedure and one list
(define map1
  (lambda (p q)
    (if (null? q)
        '()
        (cons (p (car q))
              (map1 p (cdr q))))))



;; Exercise 2.8.1
(define tree-copy
  (lambda (tr)
    (if (not (pair? tr))
        tr
        (cons
         (tree-copy (cdr tr))
         (tree-copy (car tr))))))
(tree-copy '((1 2) (3 4))) ;; => ((() (() . 4) . 3) (() . 2) . 1)


;; Exercise 2.8.2
(define append1
  (lambda (q1 q2)
    (if (null? q1) q2
        (cons (car q1)
              (append1 (cdr q1) q2)))))


;; Exercise 2.8.3
(define make-list
  (lambda (n obj)
    (if (= n 0)
        '()
        (cons obj
              (make-list (- n 1) obj)))))


;; Exercise 2.8.4
(define list-ref
  (lambda (q nth)
    (if (= nth 0)
        (car q)
        (list-ref (cdr q) (- nth 1)))))

(define list-tail
  (lambda (q nth)
    (if (= nth 0)
        q
        (list-tail (cdr q) (- nth 1)))))


;; Exercise 2.8.5
(define shorter?
  (lambda (shorter longer)
    (cond [(null? shorter) #t]
          [(null? longer) #f]
          [else
           (shorter? (cdr shorter) (cdr longer))])))


;; Exercise 2.8.6
(define even?
  (lambda (x)
    (if (= x 0)
        #t
        (odd? (- x 1)))))
(define odd?
  (lambda (x)
    (if (= x 0)
        #f
        (even? (- x 1)))))


;; Exercise 2.8.7
(define transpose
  (lambda (q)
    (cons
     (map car q)
     (map cdr q))))

(transpose '((a . 1) (b . 2) (c . 3))) ;; => ((a b c) 1 2 3)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; assignment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; assignments done with set!
(define kons-count 0)
(define kons
  (lambda (x y)
    (set! kons-count (+ kons-count 1))
    (cons x y)))

;; first way of writing count function using global variable
(define counter 0)
(define count
  (lambda ()
    (let ([val counter])
      (set! counter (+ counter 1))
      val)))

;; second way of writing count function using closure
;; closure = returned function and its lexical environment
(define count
  (let ([counter 0])
    (lambda ()
      (let ([val counter])
	(set! counter (+ counter 1))
	val))))

(define make-counter
  (lambda (init)
    (let ([counter init])
      (lambda ()
	(let ([val counter])
	  (set! counter (+ counter 1))
	  val)))))

(let ([secret 0])
  (set! shhh
	(lambda (message)
	  (set! secret message)))
  (set! tell
	(lambda ()
	  secret)))

(define lazy
  (lambda (t)
    (let ([val #f] [flag #f])
      (lambda ()
	(if (not flag)
	    (begin (set! val (t))
		   (set! flag #t)))
	    val))))

(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (message . args)
	(cond [(eqv? message 'empty?) (null? ls)]
	      [(eqv? message 'push!) (set! ls (cons (car args) ls))]
	      [(eqv? message 'top) (car ls)]
	      [(eqv? message 'pop!) (set! ls (cdr ls))]
	      [else "oops"])))))

#|

|#
(define make-queue
  (lambda ()
    (let ([end (cons 'ignored '())])
      (cons end end))))

(define putq!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (cdr q) v)
      (set-cdr! (cdr q) end)
      (set-cdr! q end))))

(define putq-v2!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (car q) v)
      (set-cdr! (car q) end)
      (set-cdr! q end))))

(define getq
  (lambda (q)
    (car (car q))))

(define delq!
  (lambda (q)
    (set-car! q (cdr (car q)))))

(define q1 (make-queue))
(define q2 (make-queue))
(putq! q1 2)
(putq! q2 2)
;;
(putq! q1 1)
(putq! q2 1)
;;
(putq! q1 4)
(putq! q2 4)
;;
(delq! q1)
(delq! q2)
;;
(putq! q1 10)
(putq! q2 10)

(assert (equal? q1 q2))
(assert (eqv? (getq q1) (getq q2)))


;; Exercise 2.9.1
(define make-counter
  (lambda (init)
    (let ([counter init])
      (lambda ()
	(let ([val counter])
	  (set! counter (+ counter 1))
	  val)))))


;; Exercise 2.9.2
(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (message . args)
	(case message
	  [(empty? mt?) (null? ls)]
	  [(ref) (list-ref ls (car args))]
	  [(push!) (set! ls (cons (car args) ls))]
	  [(top) (car ls)]
	  [(pop!) (set! ls (cdr ls))]
	  [(set!) (set-car! (list-tail ls (car args))
			    (cadr args))]
	  [else 'oops])))))


;; Exercise 2.9.3
(define make-stack
  (lambda (n)
    (let ([vc (make-vector n)]
	  [top 0])
      (lambda (message . args)
	(case message
	  [(debug) vc]
	  [(empty? mt?) (= 0 top)]
	  [(ref) (vector-ref vc (car args))]
	  [(push!) (begin
		     (vector-set! vc top (car args))
		     (set! top (+ top 1)))]
	  [(top) (vector-ref vc top)]
	  [(pop!) (begin
		    (vector-set! vc top '())
		    (set! top (- top 1)))]
	  [(set!) (vector-set! vc (car args) (cadr args))]
	  [else 'oops])))))


;; Exercise 2.9.4/5
(define make-queue
  (lambda ()
    (let ([end (cons 'ignored '())])
      (cons end end))))

(define putq!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (cdr q) v)
      (set-cdr! (cdr q) end)
      (set-cdr! q end))))

(define putq-v2!
  (lambda (q v)
    (let ([end (cons 'ignored '())])
      (set-car! (car q) v)
      (set-cdr! (car q) end)
      (set-cdr! q end))))

(define emptyq?
  (lambda (q)
    (eqv? (caar q) 'ignored)))

(define getq
  (lambda (q)
    (if (emptyq? q) (assertion-violation 'getq "empty queue" q))
    (car (car q))))

(define delq!
  (lambda (q)
    (if (emptyq? q) (assertion-violation 'delq! "empty queue" q))
    (set-car! q (cdr (car q)))))


;; Exercise 2.9.6
(define make-queue
  (lambda ()
    (cons 'ignored '())))

(define putq!
  (lambda (q v)
    (cond
     [(null? q) (cons v '())]
     [(mt? q) (set-car! q v)]
     [else
      (let ([tail (putq! (cdr q) v)])
	(set-cdr! q tail)
	(cons (car q) tail))])))

(define mt?
  (lambda (q)
    (eqv? 'ignored (car q))))

(define deleteq!
  (lambda (q)
    (cond [(mt? q) (assertion-violation 'deleteq! "empty queue" q)]
	  [(null? (cdr q)) (set-car! q 'ignored)]
	  [else (begin ;; '(1 2) -> '(2)
		  (set-car! q (cadr q))
		  (set-cdr! q (cddr q)))])))

(define getq
  (lambda (q)
    (if (mt? q) (assertion-violation 'getq "empty queue" q)
	(car q))))


;; Exercise 2.9.7
(define cyclic-list
  (lambda ()
    (let ([ls (cons 'a '())])
      (set-cdr! ls ls)
      ls))) ;; => Warning in pretty-print: cycle detected; proceeding with (print-graph #t)
;; => #0=(a . #0#)

(define my-length
  (lambda (q)
    (if (null? q)
        0
        (+ 1
           (my-length (cdr q))))))
(my-length (cyclic-list)) ;; => infinite recursion
(length (cyclic-list)) ;; => can detect cycle


;; Exercise 2.9.8

