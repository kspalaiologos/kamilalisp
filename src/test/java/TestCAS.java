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

        assertEquals(Common.runCode("""
            (cas:integral (sqrt (tan x)) dx)
        """).toString(), "(/ (- (- (- (* (* 4 (sqrt 2)) (atan (/ 1 (- (+ (sqrt (/ (- (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x)))) (cos x))) (* (sqrt 2) (sqrt (/ (sin x) (cos x))))) 1)))) (* (* 4 (sqrt 2)) (atan (/ 1 (+ (+ (sqrt (/ (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x))) (cos x))) (* (sqrt 2) (sqrt (/ (sin x) (cos x))))) 1))))) (+ (* (sqrt 2) (log (/ (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x))) (cos x)))) (* (sqrt 2) (log (/ (- (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x)))) (cos x))))))) 4)");
    }

    @Test
    void testIntegralExpLog() {
        assertEquals(Common.runCode("""
            (cas:integral (exp (+ 1 (ln x))) dx)
        """).toString(), "(/ (* (* x x) (e)) 2)");
    }

    @Test
    void testRationalIntegral() {
        assertEquals(Common.runCode("""
            (cas:integral (/ (sqrt (+ 1 (** x 2))) (+ 1 (** x 3))) dx)
        """).toString(), "(/ (- (* (sqrt 2) (log (/ (- (- (- (+ (* (+ (+ (sqrt 2) x) 1) (sqrt (+ (* x x) 1))) (* (- (- x 1)) (sqrt 2))) (* x x)) x) 2) (- (- (* (+ x 1) (sqrt (+ (* x x) 1))) (* x x)) x)))) (* 2 (atan (/ (- (- (* (- (* 2 x) 1) (sqrt (+ (* x x) 1))) (+ (* (* 2 x) x) x)) 1) (- (- (sqrt (+ (* x x) 1)) x) 1))))) 3)");
    }

    @Test
    void testDefiniteIntegral() {
        assertEquals(Common.runCode("""
            (cas:integral -oo oo (exp (- (** x 2))) dx)
        """).toString(), "(sqrt (pi))");
    }
}