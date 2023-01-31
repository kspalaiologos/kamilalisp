import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestRank {
    @Test
    void testBasicRank() {
        assertEquals(Common.runCode("""
                (def a (rank '(1 2 3)))
                (def b (rank 0))
                (def c (rank '((1 2) (3 4))))
                (def d (rank '((1 2) 3)))
                (same (tie a b c d) '(1 0 2 -2))
        """).getReal(), new BigDecimal("1"));
    }

    @Test
    void testDepth() {
        assertEquals(Common.runCode("""
                (def a (same '(("kamila" "lisp") ("hi" "hello")) (reverse '(("hi" "hello") ("kamila" "lisp"))) ))
                (def b (same '(("psiLalimaK" "si") "!nuf") (reverse%[0] '(("KamilaLisp" "is") "fun!")) ))
                (def c (same '((2 1) 3 4) (reverse%[1] '((1 2) 3 4)) ))
                (def d (same '(((3 4) (1 2)) ((7 8) (5 6))) (reverse%[2] '(((1 2) (3 4)) ((5 6) (7 8)))) ))
                
                (def mat '((4 3) (3 4)))
                (def g (same '(((4 5) (3 5)) ((3 5) (4 5))) (cons%[-2] mat 5) ))
                (def h (same '(((4 5) (3 5)) ((3 5) (4 5))) (::cons mat 5) ))
                
                (defun f (x y) (str:format "{?x}, {?y}"))
                (def i (same '("(1 2), 6" "(3 4), 5") (f%[1 -1] '((1 2) (3 4)) '(6 5 (4 3) 2 1)) ))
                (def j (same '(("1, 1" "2, 2") "3, 3") (f%[-2 0] '((1 2) 3) '((1 2) 3)) ))
                (def k (same '(("1, 1" "2, 2") "3, 3") (f%[-2 0] '((1 2) 3) '(1 2 3)) ))
                (def l (same '("(1 2), 6" "(3 4), 5") (f%[[tie + -] 1] '((1 2) (3 4)) '(6 5 (4 3) 2 1)) ))
                
                (and a b c d g h i j k l)
        """).getReal(), new BigDecimal("1"));
    }
}