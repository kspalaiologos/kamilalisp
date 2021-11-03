package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

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
        assertTrue(Evaluation.evalString("(nth 2 (flat-map (lambda (x) (cons x 'nil)) '(1 2 3)))").get(0).get().get().equals(BigDecimal.valueOf(3)));
    }

    @Test
    public void testNth() {
        assertTrue(Evaluation.evalString("(nth 0 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(nth 1 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(nth 2 '(1 2 3))").get(0).get().get().equals(BigDecimal.valueOf(3)));
    }

    @Test
    public void testTie() {
        assertTrue(Evaluation.evalString("(tie 4 5 6)").get(0).getList().get().size() == 3);
        assertTrue(Evaluation.evalString("(tie 4 5 6)").get(0).getList().get().get(0).get().get().equals(BigDecimal.valueOf(4)));
    }

    @Test
    public void testCommute() {
        assertTrue(Evaluation.evalString("(commute tie 1 2 3)").get(0).getList().get().equals(List.of(new Atom(new BigDecimal(3)), new Atom(new BigDecimal(2)), new Atom(new BigDecimal(1)))));
    }

    @Test
    public void testScanl() {
        assertTrue(Evaluation.evalString("(scanl + 0 '(1 2 3))").get(0).getList().get().equals(List.of(new Atom(BigDecimal.ZERO), new Atom(BigDecimal.ONE), new Atom(BigDecimal.valueOf(3)), new Atom(BigDecimal.valueOf(6)))));
    }

    @Test
    public void testScanlOrdered() {
        assertTrue(Evaluation.evalString("(scanl - 0 '(1 2 3))").get(0).getList().get().equals(List.of(new Atom(BigDecimal.ZERO), new Atom(BigDecimal.valueOf(-1)), new Atom(BigDecimal.valueOf(-3)), new Atom(BigDecimal.valueOf(-6)))));
    }

    @Test
    public void testScanr() {
        assertTrue(Evaluation.evalString("(scanr + 0 '(1 2 3))").get(0).getList().get().equals(List.of(new Atom(BigDecimal.valueOf(6)), new Atom(BigDecimal.valueOf(5)), new Atom(BigDecimal.valueOf(3)), new Atom(BigDecimal.valueOf(0)))));
    }

    @Test
    public void testScanrOrdered() {
        assertTrue(Evaluation.evalString("(scanr - 0 '(1 2 3))").get(0).getList().get().equals(List.of(new Atom(BigDecimal.valueOf(2)), new Atom(BigDecimal.valueOf(-1)), new Atom(BigDecimal.valueOf(3)), new Atom(BigDecimal.valueOf(0)))));
    }

    @Test
    public void testBindBasic() {
        assertTrue(Evaluation.evalString("([+ bind 2] 5)").get(0).getNumber().get().equals(BigDecimal.valueOf(7)));
    }

    @Test
    public void testBindBasicPlaceholder() {
        assertTrue(Evaluation.evalString("([+ bind _] 5 2)").get(0).getNumber().get().equals(BigDecimal.valueOf(7)));
    }

    @Test
    public void testMultibind() {
        assertTrue(Evaluation.evalString("([[if bind [0 /= 0]] bind 1] 12)").get(0).getNumber().get().equals(BigDecimal.valueOf(12)));
    }
}
