package kamilalisp.test;

import kamilalisp.api.Evaluation;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class HigherOrder {
    @Test
    public void map() {
        assertTrue(Evaluation.evalString("(size (map - '(1 2 3)))").get(0).get().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(size (map - 'nil))").get(0).get().get().equals(BigDecimal.valueOf(0)));
    }

    @Test
    public void filter() {
        assertTrue(Evaluation.evalString("(size (filter ~ '(1 0 1)))").get(0).get().get().equals(BigDecimal.valueOf(1)));
    }

    @Test
    public void count() {
        assertTrue(Evaluation.evalString("(count ~ '(1 0 1))").get(0).get().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(count ~ 'nil)").get(0).get().get().equals(BigDecimal.valueOf(0)));
    }

    @Test
    public void testEval() {
        assertTrue(Evaluation.evalString("(eval '(+ 1 2))").get(0).get().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("((eval '(lambda (x) (* x x))) 5)").get(0).get().get().equals(BigDecimal.valueOf(25)));
    }

    @Test
    public void testEvery() {
        assertTrue(Evaluation.evalString("(every ~ '(1 0 1))").get(0).get().get().equals(BigDecimal.valueOf(0)));
        assertTrue(Evaluation.evalString("(every ~ '(1 1 1))").get(0).get().get().equals(BigDecimal.valueOf(0)));
        assertTrue(Evaluation.evalString("(every ~ '(0 0 0))").get(0).get().get().equals(BigDecimal.valueOf(1)));
    }

    @Test
    public void testFlatmap() {
        assertTrue(Evaluation.evalString("(nth 2 (flatmap (lambda (x) (cons x 'nil)) '(1 2 3)))").get(0).get().get().equals(BigDecimal.valueOf(3)));
    }

    @Test
    public void testNth() {
        assertTrue(Evaluation.evalString("(nth 0 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(nth 1 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(nth 2 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(3)));
    }
}
