import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestMath {
    @Test
    void testMath() {
        assertDoesNotThrow(() -> Common.runCode("""
                (let-seq
                    (def fr 8)
                    (def a (* 2 3))
                    (if (/= a 6) (raise "a is not 6") 'nil)
                    (def b (+ 2 3))
                    (if (/= b 5) (raise "b is not 5") 'nil)
                    (def c (- 2 3))
                    (if (/= c -1) (raise "c is not -1") 'nil)
                    (def d (/ 2 3))
                    (if (/= d 0.66666667) (raise \\str:format "d is not 0.66666667, got {?d}") 'nil)
                    (def ee (** 2 3))
                    (if (/= ee 8) (raise "ee is not 8") 'nil)
                    (def f (** 4 0.5))
                    (if (/= f 2) (raise "f is not 2") 'nil)
                    (def g (** 2 -1))
                    (if (/= g 0.5) (raise "g is not 0.5") 'nil)
                    (def h (** 2 0))
                    (if (/= h 1) (raise "h is not 1") 'nil)
                    (def i (** 2 1))
                    (if (/= i 2) (raise "i is not 2") 'nil)
                    (def j (pi 2))
                    (if (/= j 6.2831854) (raise \\str:format "j is not 6.2831854, got {?j}") 'nil)
                    (def k (e 2))
                    (if (/= k 5.4365636) (raise \\str:format "k is not 5.4365636, got {?k}") 'nil)
                    (def l (bit:and 151 37))
                    (if (/= l 5) (raise \\str:format "l is not 5, got {?l}") 'nil)
                    (def m (bit:or 132 67))
                    (if (/= m 199) (raise \\str:format "m is not 199, got {?m}") 'nil)
                    (def n (bit:xor 132 67))
                    (if (/= n 199) (raise \\str:format "n is not 199, got {?n}") 'nil)
                    (def o (bit:not 132))
                    (if (/= o -133) (raise \\str:format "o is not -133, got {?o}") 'nil)
                    (def p (bit:nand 132 2))
                    (if (/= p 0) (raise \\str:format "p is not 0, got {?p}") 'nil)
                    (def q (bit:popcount 132))
                    (if (/= q 2) (raise \\str:format "q is not 2, got {?q}") 'nil)
                    )
        """));
    }
}