package kamilalisp.test;

import kamilalisp.api.Evaluation;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.math.BigInteger;

import static org.junit.jupiter.api.Assertions.*;

public class Lambda {
    @Test
    void simpleLambda() {
        assertTrue(Evaluation.evalString("((lambda (x y) (+ x y)) 5 6)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(11)) == 0);
    }

    @Test
    void lambdaCurry() {
        assertTrue(Evaluation.evalString("(((lambda (x) (lambda (y) (+ x y))) 5) 6)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(11)) == 0);
    }

    @Test
    void dyadicLambda() {
        assertTrue(Evaluation.evalString("((dyad [x + y]) 5 5)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(10)) == 0);
    }

    @Test
    void monadicLambda() {
        assertTrue(Evaluation.evalString("((monad [x + x]) 5)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(10)) == 0);
    }
}
