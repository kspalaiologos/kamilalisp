import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import palaiologos.kamilalisp.error.RaiseError;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestPartial {
    @Test
    void testBasic() {
        assertEquals(Common.runCode("""
                (defun make-adder (x) (lambda y (+ x y)))
                (def add-5 (make-adder 5))
                (add-5 10)
        """).getReal(), new BigDecimal("15"));
    }

    @Test
    void testWithCommute() {
        assertEquals(Common.runCode("""
                (def mod-2 $(^mod 2))
                (same '(0 1) (tie (mod-2 6) (mod-2 5)))
        """).getReal(), new BigDecimal("1"));
    }

    @Test
    void testWithPlaceholder() {
        assertEquals(Common.runCode("""
                (def mod-2 $(mod _ 2))
                (same '(0 1) (tie (mod-2 6) (mod-2 5)))
        """).getReal(), new BigDecimal("1"));
    }

    @Test
    void testCollatz() {
        assertEquals(Common.runCode("""
                (defun collatz (n) (if (= (mod n 2) 0) (/ n 2) (+ (* 3 n) 1)))
                (defun collatz-rec (n) (if (= n 1) 1 (collatz-rec (collatz n))))
                (defun collatz-tail (n) (if (= n 1) 1 (&0 (collatz n))))
                (defun collatz-whl (n) (while n $(/= 1) collatz))
                (car@unique (tie (collatz-rec 9) (collatz-tail 9) (collatz-whl 9)))
        """).getReal(), new BigDecimal("1"));

        assertEquals(Common.runCode("""
                (defun collatz (n) (if (= (mod n 2) 0) (/ n 2) (+ (* 3 n) 1)))
                (defun collatz-list (n) (partial-while n $(/= 1) collatz))
                (same '(46 23 70 35 106 53 160 80 40 20 10 5 16 8 4 2 1) (collatz-list 15))
        """).getReal(), new BigDecimal("1"));
    }

    @Test
    void testFib() {
        assertEquals(Common.runCode("""
                (defun fibr (n) (if (< n 2) n (+ (fibr (- n 1)) (fibr (- n 2)))))
                (defun fibt (n) ((lambda (n a b) (if (= n 0) a (&0 (- n 1) b (+ a b)))) n 0 1))
                (def fibr (memo fibr))
                (same '(55 6765 832040 12586269025) (:fibr '(10 20 30 50)))
        """).getReal(), new BigDecimal("1"));
    }

    @Test
    void testMutualBinding() {
        assertEquals(Common.runCode("""
                (defun f (x) (+ x a))
                (def a 5)
                (f 10)
        """).getReal(), new BigDecimal("15"));
    }

    @Test
    void testRaise() {
        assertThrows(RaiseError.class, () -> Common.runCode("""
                (defun avg (l) (if (same l 'nil) (raise "empty list") (/ (sum l) (tally l))))
                (avg '())
        """));
    }
}