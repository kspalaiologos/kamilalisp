package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Executor;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class LetBindings {
    @Test
    void testLet() {
        assertTrue(Evaluation.evalString("(let ((x 1)) x)").get(0).getNumber().get().equals(BigDecimal.ONE));
        assertTrue(Evaluation.evalString("(let ((x 1) (y 2)) (+ x y))").get(0).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(let ((x 1) (y 2)) (let ((z (+ x y))) z))").get(0).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(let ((x 1) (y 2)) (let ((z (+ x y))) (+ z x)))").get(0).getNumber().get().equals(BigDecimal.valueOf(4)));
    }
}
