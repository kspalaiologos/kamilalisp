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
            (cas:integral (cas:fn x x) dx)
        """).toString(), "ƒ(x)=(* (* (/ 1 2) x) x)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\+ x (** x 2)) dx)
        """).toString(), "ƒ(x)=(+ (* (/ 1 3) (** x 3)) (* (* (/ 1 2) x) x))");
    }

    @Test
    void testBasicIntegralTrig() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\sin x) dx)
        """).toString(), "ƒ(x)=(- (cos x))");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\cot x) dx)
        """).toString(), "ƒ(x)=(/ (ln (/ (- (+ (cos (* 2 x)) 1)) 2)) 2)");
    }

    @Test
    void testIntegralTrig() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (+ (sin x) (cos x))) dx)
        """).toString(), "ƒ(x)=(/ (* (sqrt 2) (ln (/ (- (* (- (+ (* 2 (cos x)) (* 2 (sqrt 2)))) (sin x)) (+ (* (* 2 (sqrt 2)) (cos x)) 3)) (+ (* (* 2 (cos x)) (sin x)) 1)))) 4)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\* (sin x) (cos x) (tan x)) dx)
        """).toString(), "ƒ(x)=(/ (- (+ (* (cos x) (sin x)) x)) 2)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (cos x)) dx)
        """).toString(), "ƒ(x)=(/ (- (ln (+ (sin x) 1)) (ln (- (+ (sin x) 1)))) 2)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\sqrt (tan x)) dx)
        """).toString(), "ƒ(x)=(/ (- (- (- (* (* 4 (sqrt 2)) (atan (/ 1 (- (+ (sqrt (/ (- (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x)))) (cos x))) (* (sqrt 2) (sqrt (/ (sin x) (cos x))))) 1)))) (* (* 4 (sqrt 2)) (atan (/ 1 (+ (+ (sqrt (/ (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x))) (cos x))) (* (sqrt 2) (sqrt (/ (sin x) (cos x))))) 1))))) (+ (* (sqrt 2) (ln (/ (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x))) (cos x)))) (* (sqrt 2) (ln (/ (- (+ (+ (* (* (* 2 (sqrt 2)) (cos x)) (sqrt (/ (sin x) (cos x)))) (* 2 (sin x))) (* 2 (cos x)))) (cos x))))))) 4)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (exp (asec x)) (** x 2)) dx)
        """).toString(), "ƒ(x)=(/ (* (- (sqrt (- (* x x) 1)) 1) (exp (asec x))) (* 2 x))");
    }

    @Test
    void testIntegralExpLog() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\exp (+ 1 (ln x))) dx)
        """).toString(), "ƒ(x)=(/ (* (* x x) (e)) 2)");
    }

    @Test
    void testRationalIntegral() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (sqrt (+ 1 (** x 2))) (+ 1 (** x 3))) dx)
        """).toString(), "ƒ(x)=(/ (- (* (sqrt 2) (ln (/ (- (- (- (+ (* (+ (+ (sqrt 2) x) 1) (sqrt (+ (* x x) 1))) (* (- (- x 1)) (sqrt 2))) (* x x)) x) 2) (- (- (* (+ x 1) (sqrt (+ (* x x) 1))) (* x x)) x)))) (* 2 (atan (/ (- (- (* (- (* 2 x) 1) (sqrt (+ (* x x) 1))) (+ (* (* 2 x) x) x)) 1) (- (- (sqrt (+ (* x x) 1)) x) 1))))) 3)");

        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (** x 6) (sqrt (* (+ (** x 7) 1) (+ (** x 7) 2)))) dx)
        """).toString(), "ƒ(x)=(- (/ (ln (- (- (* 2 (sqrt (+ (+ (** x 14) (* 3 (** x 7))) 2))) (* 2 (** x 7))) 3)) 7))");
    }

    @Test
    void testIntegralSpecialFunction() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn (x n) \\* (** x n) (exp (/ (- (* x x)) 2))) dx)
        """).toString(), "ƒ(x,n)=(- (* (exp (/ (* (- n 1) (ln 2)) 2)) (gamma (/ (+ n 1) 2) (/ (* x x) 2))))");
    }

    @Test
    void testDefiniteKuratowski() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn x \\/ (* x (sin x)) (+ 1 (** (cos x) 2))) dx)
        """).toString(), "ƒ(x)=(/ (- (- (+ (- (- (- (- (+ (+ (- (- (+ (* (* x 0J1) (ln (/ (- (- (+ (* (- (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (- (+ (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1)) 1) (- (+ (* (- (sqrt 2) 1) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1))))) (* (* x 0J1) (ln (/ (- (+ (+ (* (- (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) (+ 0J1 1)) (cos x))) (* 0J1 (sqrt 2))) (+ 0J1 1)) (- (+ (+ (* (- (sqrt 2) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (- (- (- (+ (* (+ (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (- (- (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (- (- (+ (* (+ (sqrt 2) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1)) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (+ (+ (+ (+ (* (+ (+ (sqrt 2) 0J1) 1) (sin x)) (* (+ (+ (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (+ (+ (+ (* (+ (sqrt 2) 1) (sin x)) (* (+ (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (- (+ (+ (+ (* (- (sqrt 2) (+ 0J1 1)) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (+ (+ (+ (* (+ (sqrt 2) 1) (sin x)) (* (+ (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (- (- (+ (* (- (sqrt 2) (+ 0J1 1)) (sin x)) (* (- (- (* 0J1 (sqrt 2)) (+ 0J1 1))) (cos x))) (* 0J1 (sqrt 2))) (+ 0J1 1)) (- (- (+ (* (+ (sqrt 2) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1)) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (- (- (+ (+ (* (- (- (sqrt 2) 0J1) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (- (+ (+ (* (- (sqrt 2) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (* (* x 0J1) (ln (/ (- (+ (* (- (- (sqrt 2) 0J1) 1) (sin x)) (* (- (+ (+ (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (+ (+ (* 0J1 (sqrt 2)) 0J1) 1)) (- (+ (* (- (sqrt 2) 1) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1)))))) (+ (+ (dilog (/ (- (- (+ (* (- (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (- (+ (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1)) 1) (- (+ (* (- (sqrt 2) 1) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1)))) (dilog (/ (- (+ (+ (* (- (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) (+ 0J1 1)) (cos x))) (* 0J1 (sqrt 2))) (+ 0J1 1)) (- (+ (+ (* (- (sqrt 2) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1)))) (dilog (/ (- (- (- (+ (* (+ (+ (sqrt 2) 0J1) 1) (sin x)) (* (- (- (- (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (- (- (+ (* (+ (sqrt 2) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1)) (cos x))) (* 0J1 (sqrt 2))) 0J1))))) (dilog (/ (+ (+ (+ (+ (* (+ (+ (sqrt 2) 0J1) 1) (sin x)) (* (+ (+ (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (+ (+ (+ (* (+ (sqrt 2) 1) (sin x)) (* (+ (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1)))) (dilog (/ (- (+ (+ (+ (* (- (sqrt 2) (+ 0J1 1)) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (+ (+ (+ (* (+ (sqrt 2) 1) (sin x)) (* (+ (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1)))) (dilog (/ (- (- (+ (* (- (sqrt 2) (+ 0J1 1)) (sin x)) (* (- (- (* 0J1 (sqrt 2)) (+ 0J1 1))) (cos x))) (* 0J1 (sqrt 2))) (+ 0J1 1)) (- (- (+ (* (+ (sqrt 2) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1)) (cos x))) (* 0J1 (sqrt 2))) 0J1)))) (+ (dilog (/ (- (- (+ (+ (* (- (- (sqrt 2) 0J1) 1) (sin x)) (* (- (- (* 0J1 (sqrt 2)) 0J1) 1) (cos x))) (* 0J1 (sqrt 2))) 0J1) 1) (- (+ (+ (* (- (sqrt 2) 1) (sin x)) (* (- (* 0J1 (sqrt 2)) 0J1) (cos x))) (* 0J1 (sqrt 2))) 0J1))) (dilog (/ (- (+ (* (- (- (sqrt 2) 0J1) 1) (sin x)) (* (- (+ (+ (* 0J1 (sqrt 2)) 0J1) 1)) (cos x))) (+ (+ (* 0J1 (sqrt 2)) 0J1) 1)) (- (+ (* (- (sqrt 2) 1) (sin x)) (* (- (+ (* 0J1 (sqrt 2)) 0J1)) (cos x))) (+ (* 0J1 (sqrt 2)) 0J1)))))) 4)");
    }

    @Test
    void testMultipleValues() {
        assertEquals(Common.runCode("""
            (cas:integral (cas:fn (a x) \\/ (+ a (** x 2))) dx)
        """).toString(), "(ƒ(a,x)=(/ (ln (/ (+ (* (- (* x x) a) (sqrt (- a))) (* (* 2 a) x)) (+ (* x x) a))) (* 2 (sqrt (- a)))) ƒ(a,x)=(/ (atan (/ (* x (sqrt a)) a)) (sqrt a)))");
    }
}