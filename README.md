# tests.lsp

Unit test macros for newLISP.
Meant to be small.

    (run-tests "My module"
        (feature "My feature"
            (assert (= (+ 2 2) 4))
            (assert (= (* 2 3) 6))
        )
    )

See test-example.lsp for a longer example and its output!
