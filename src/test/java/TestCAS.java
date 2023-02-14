import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

class TestCAS {
    @Test
    void testBasicIntegral() {
        assertEquals(Common.runCode("""
            (cas:integral x dx)
        """).toString(), "(* (* (/ 1 2) x) x)");

        assertEquals(Common.runCode("""
            (cas:integral (+ x (** x 2)) dx)
        """).toString(), "(+ (* (/ 1 3) (** x 3)) (* (* (/ 1 2) x) x))");
    }

    @Test
    void testBasicIntegralTrig() {
        assertEquals(Common.runCode("""
            (cas:integral (sin x) dx)
        """).toString(), "(- (cos x))");

        assertEquals(Common.runCode("""
            (cas:integral (cot x) dx)
        """).toString(), "(/ (log (/ (- (+ (cos (* 2 x)) 1)) 2)) 2)");
    }

    @Test
    void testIntegralTrig() {
        assertEquals(Common.runCode("""
            (cas:integral (/ (+ (sin x) (cos x))) dx)
        """).toString(), "(/ (* (sqrt 2) (log (/ (- (* (- (+ (* 2 (cos x)) (* 2 (sqrt 2)))) (sin x)) (+ (* (* 2 (sqrt 2)) (cos x)) 3)) (+ (* (* 2 (cos x)) (sin x)) 1)))) 4)");

        assertEquals(Common.runCode("""
            (cas:integral (* (sin x) (cos x) (tan x)) dx)
        """).toString(), "(/ (- (+ (* (cos x) (sin x)) x)) 2)");
        assertEquals(Common.runCode("""
            (cas:integral (/ (cos x)) dx)
        """).toString(), "(/ (- (log (+ (sin x) 1)) (log (- (+ (sin x) 1)))) 2)");
    }

    @Test
    void testIntegralExpLog() {
        assertEquals(Common.runCode("""
            (cas:integral (exp (+ 1 (ln x))) dx)
        """).toString(), "(/ (* (* x x) e) 2)");
    }
}