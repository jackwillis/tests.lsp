#!/usr/bin/newlisp

(load "tests.lsp")

(define (my-test)
  (assert (= (/ 6 2) 3)))
    
(define (my-feature)
  (feature "lists"
    (assert (= (first '(1 2 3)) 1))
    (assert (= (length '()) 0))
    (assert (= (cons 4 3) '(4 3)))))

(define (setup)
  (non-test ; non-test code to be run inside run-tests must be specified
    (verbosely ; print and evaluate arguments
      (set 'my-num 9)
      (set 'my-list '(1 2 3)))
    '()))

;;;;;;;;

(run-tests "My module"

  (setup)

  (assert (= (length my-list) 3))
  (assert (factor my-num)) ; an assertion passes as long as it's not nil or '()

  (feature "math"
    (feature "addition"
      (assert (!= (+ 3 2) 4))
      (assert (= (+ 5 3) 8)))
    (feature "subtraction"
      (assert (= (- 3 2) 1))
      (assert (= (- 2 8) -6))))

  (my-feature)
  (my-test)

)

(exit)

;; Below is the output of this example:

;; Running tests for My module
;;
;; (set 'my-num 9) ;=> 9
;; (set 'my-list '(1 2 3)) ;=> (1 2 3)
;; PASS (= (length my-list) 3) ;=> true 
;; PASS (factor my-num) ;=> (3 3) 
;; ## Feature: math
;; ## Feature: addition
;; PASS (!= (+ 3 2) 4) ;=> true
;; PASS (= (+ 5 3) 8) ;=> true
;; Feature `addition' passed.
;; ## Feature: subtraction
;; PASS (= (- 3 2) 1) ;=> true
;; PASS (= (- 2 8) -6) ;=> true
;; Feature `subtraction' passed.
;; Feature `math' passed.
;; ## Feature: lists
;; PASS (= (first '(1 2 3)) 1) ;=> true
;; PASS (= (length '()) 0) ;=> true
;; PASS (= (cons 4 3) '(4 3)) ;=> true
;; Feature `lists' passed.
;; PASS (= (/ 6 2) 3) ;=> true
;; 
;; Results:
;; 	2 out of 2 top-level features passed.
;; 	10 out of 10 total tests passed.
;; 	Complete!
