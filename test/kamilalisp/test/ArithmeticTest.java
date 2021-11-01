package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

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
}