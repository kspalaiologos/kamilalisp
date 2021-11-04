package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

class ArithmeticTest {
    @Test
    void addition() {
        assertTrue(Evaluation.evalString("(+ 13 43)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(13 + 43)) == 0);
    }

    @Test
    void subtraction() {
        assertTrue(Evaluation.evalString("(- 13 43)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(13 - 43)) == 0);
    }

    @Test
    void multiplication() {
        assertTrue(Evaluation.evalString("(* 13 43)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(13 * 43)) == 0);
    }

    @Test
    void gcdLcm() {
        assertTrue(Evaluation.evalString("(gcd 13 43)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(1)) == 0);
        assertTrue(Evaluation.evalString("(lcm 13 43)").get(0).getNumber().get().compareTo(BigDecimal.valueOf(559)) == 0);
    }

    @Test
    void equality() {
        assertTrue(Evaluation.evalString("(= 2 2)").get(0).coerceBool());
        assertFalse(Evaluation.evalString("(= 2 3)").get(0).coerceBool());
    }

    @Test
    void stringConcat() {
        assertTrue(Evaluation.evalString("(+ \"hello, \" \"world\")").get(0).getStringConstant().get().get().equals("hello, world"));
    }

    @Test
    void stringConcatNumbers() {
        assertTrue(Evaluation.evalString("(+ 2 \"world\")").get(0).getStringConstant().get().get().equals("2world"));
        assertTrue(Evaluation.evalString("(+ \"world\" 2)").get(0).getStringConstant().get().get().equals("world2"));
    }

    @Test
    void stringSubtract() {
        assertTrue(Evaluation.evalString("(- 2 \"world\")").get(0).getStringConstant().get().get().equals("rld"));
        assertTrue(Evaluation.evalString("(- \"world\" 2)").get(0).getStringConstant().get().get().equals("wor"));
    }

    @Test
    void stringMultiply() {
        assertTrue(Evaluation.evalString("(* 2 \"world\")").get(0).getStringConstant().get().get().equals("worldworld"));
        assertTrue(Evaluation.evalString("(* \"world\" 2)").get(0).getStringConstant().get().get().equals("worldworld"));
    }

    @Test
    void negation() {
        assertTrue(Evaluation.evalString("(= (~ 1) 0)").get(0).coerceBool());
        assertTrue(Evaluation.evalString("(= (~ 0) 1)").get(0).coerceBool());
    }

    @Test
    void division() {
        assertTrue(Evaluation.evalString("(= 1 (- (/ 5 3) (/ 2 3)))").get(0).getNumber().get().equals(BigDecimal.ONE));
        assertTrue(Evaluation.evalString("(= 1 (- (/ 4 3) (/ 1 3)))").get(0).getNumber().get().equals(BigDecimal.ONE));
    }

    @Test
    void lessThan() {
        assertTrue(Evaluation.evalString("(< 2 3)").get(0).coerceBool());
        assertFalse(Evaluation.evalString("(< 3 2)").get(0).coerceBool());
        assertTrue(Evaluation.evalString("(< \"hi\" 3)").get(0).coerceBool());
        assertFalse(Evaluation.evalString("(< \"hello\" 2)").get(0).coerceBool());
    }

    @Test
    void greaterThan() {
        assertTrue(Evaluation.evalString("(> 3 2)").get(0).coerceBool());
        assertFalse(Evaluation.evalString("(> 2 3)").get(0).coerceBool());
        assertTrue(Evaluation.evalString("(> \"hello\" 2)").get(0).coerceBool());
        assertFalse(Evaluation.evalString("(> \"hi\" 3)").get(0).coerceBool());
    }

    @Test
    void testMin() {
        assertTrue(Evaluation.evalString("(min 2 3)").get(0).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(min 3 2)").get(0).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(min \"hi\" \"hello\")").get(0).getStringConstant().get().get().equals("hello"));
        assertTrue(Evaluation.evalString("(min \"hello\" \"hi\")").get(0).getStringConstant().get().get().equals("hello"));
        assertTrue(Evaluation.evalString("(size (min '(1 2 3 4) '(1 2)))").get(0).getNumber().get().equals(BigDecimal.valueOf(2)));
    }

    @Test
    void testMax() {
        assertTrue(Evaluation.evalString("(max 2 3)").get(0).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(max 3 2)").get(0).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(max \"hi\" \"hello\")").get(0).getStringConstant().get().get().equals("hi"));
        assertTrue(Evaluation.evalString("(max \"hello\" \"hi\")").get(0).getStringConstant().get().get().equals("hi"));
        assertTrue(Evaluation.evalString("(size (max '(1 2 3 4) '(1 2)))").get(0).getNumber().get().equals(BigDecimal.valueOf(4)));
    }

    @Test
    void testId() {
        assertTrue(Evaluation.evalString("(id 5)").get(0).getNumber().get().equals(BigDecimal.valueOf(5)));
    }

    @Test
    void testDiscard() {
        assertTrue(Evaluation.evalString("(discard (+ 2 2))").get(0).equals(Atom.NULL));
    }

    @Test
    void testSort() {
        // Copilot generated these. Don't complain to me.
        assertTrue(Evaluation.evalString("(sort '(3 2 1))").get(0).getList().get().get(0).getNumber().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(sort '(3 2 1))").get(0).getList().get().get(1).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(sort '(3 2 1))").get(0).getList().get().get(2).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(sort '(3 2 1))").get(0).getList().get().size() == 3);
    }

    @Test
    void testSortStrings() {
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().get(0).getStringConstant().get().get().equals("a test"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().get(1).getStringConstant().get().get().equals("example"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().get(2).getStringConstant().get().get().equals("hello"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().get(3).getStringConstant().get().get().equals("hi"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().get(4).getStringConstant().get().get().equals("world"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" \"hi\" \"example\" \"a test\"))").get(0).getList().get().size() == 5);
    }

    @Test
    void testSortMixed() {
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" 2 3))").get(0).getList().get().get(0).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" 2 3))").get(0).getList().get().get(1).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" 2 3))").get(0).getList().get().get(2).getStringConstant().get().get().equals("hello"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" 2 3))").get(0).getList().get().get(3).getStringConstant().get().get().equals("world"));
        assertTrue(Evaluation.evalString("(sort '(\"hello\" \"world\" 2 3))").get(0).getList().get().size() == 4);
    }

    @Test
    void testSortList() {
        assertTrue(Evaluation.evalString("(sort '((1 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(0).getNumber().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(sort '((1 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(1).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(sort '((1 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(2).getNumber().get().equals(BigDecimal.valueOf(3)));
        assertTrue(Evaluation.evalString("(sort '((1 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().size() == 3);
        assertTrue(Evaluation.evalString("(sort '((2 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(0).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(sort '((2 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(1).getNumber().get().equals(BigDecimal.valueOf(2)));
        assertTrue(Evaluation.evalString("(sort '((2 2 3) (1 2 3 4)))").get(0).getList().get().get(0).getList().get().get(2).getNumber().get().equals(BigDecimal.valueOf(3)));
    }

    @Test
    void testSinCos() {
        assertTrue(Evaluation.evalString("(sin 0)").get(0).getNumber().get().equals(BigDecimal.valueOf(0)));
        assertEquals(Evaluation.evalString("[(- (sin (rad 90)) 1) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(cos (rad 90)) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(sin (rad 180)) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }

    @Test
    void testTanSec() {
        assertEquals(Evaluation.evalString("[(- (tan (rad 45)) 1.61) < 0.1]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(tan (rad 90)) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(tan (rad 135)) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(tan (rad 180)) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(- (tan (rad 45)) 1) < 0.00000001]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(- (sec (rad 45)) 1.41) < 0.1]").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }

    @Test
    void testDeg() {
        assertEquals(Evaluation.evalString("[[(deg (rad 180)) - 180] < 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[[(deg (rad 90)) - 90] < 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[[(deg (rad 123)) - 123] < 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }

    @Test
    void testApproxEq() {
        assertEquals(Evaluation.evalString("(approx-eq 0.1 0.11 0.1)").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }

    @Test
    void testFactorial() {
        assertEquals(Evaluation.evalString("(! 5)").get(0).getNumber().get(), BigDecimal.valueOf(120));
        assertEquals(Evaluation.evalString("(! 0)").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("(! 1)").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }

    @Test
    void testBinomial() {
        assertEquals(Evaluation.evalString("(binomial 5 2)").get(0).getNumber().get(), BigDecimal.valueOf(10));
        assertEquals(Evaluation.evalString("(binomial 5 3)").get(0).getNumber().get(), BigDecimal.valueOf(10));
        assertEquals(Evaluation.evalString("(binomial 5 4)").get(0).getNumber().get(), BigDecimal.valueOf(5));
    }
}
