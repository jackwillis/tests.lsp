;; @module tests.lsp
;; @description unit testing macros in newLISP
      
(define-macro (assert assertion)
  (let (result (eval assertion))
    (println (if result "PASS" "FAIL")
             " " assertion " ;=> " result " ")
    (not (not result)))) ; Force boolean return value to avoid collision during
                         ; analysis with FEATURE, which returns a list, and
                         ; any assertion which would return a list.
        
(define-macro (feature name)
  (println "## Feature: " name)
  (let (result (remove-empty (map eval (args))))  
    (println "Feature `" name "'"
             (if (passed? result) " passed." " did not pass."))
    result))

(define-macro (run-tests name)
  (println "Running tests for " (eval name) "\n")
  (letn (result (remove-empty (map eval (args)))
         tests (flat result)
         features (filter list? result))
    (println
      "\nResults:\n\t"
      (length (filter passed? features)) " out of "
      (length features) " top-level features passed.\n\t"
      (length (filter passed? tests)) " out of "
      (length tests) " total tests passed.\n\t"
      (if (passed? result)
        "Complete!"
        "Incomplete.")) 
    result))

; print and evaluate arguments
(define-macro (verbosely)
  (map (fn (L) (println L " ;=> " (eval L)))
       (args)))

;;; supporting functions

; anything that returns '() within RUN-TESTS is not considered during analysis.
; NON-TEST is syntactic sugar for containing non-test functions.
(define (non-test) '())

(define (passed? result) ; takes atom or list
  (if (list? result)
    (empty? (clean passed? result))
    result))
    
; remove instances of '() from a list.
(define (remove-empty result)
  (clean (curry = '()) (cons '() result)))
  
; eof
