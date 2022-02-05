;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic examples
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
(square -200) ;; => 25
(square 0.5) ;; => 25
(square -1/2) ;; => 25

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
