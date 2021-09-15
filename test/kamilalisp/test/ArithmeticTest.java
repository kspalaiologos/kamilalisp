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
    void arithMany() {
        assertTrue(Evaluation.evalString("(+ 5 '(13 43 34 67))").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(5 + 13)),
                new Atom(BigDecimal.valueOf(5 + 43)),
                new Atom(BigDecimal.valueOf(5 + 34)),
                new Atom(BigDecimal.valueOf(5 + 67))
        ))));

        assertTrue(Evaluation.evalString("(- 5 '(13 43 34 67))").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(5 - 13)),
                new Atom(BigDecimal.valueOf(5 - 43)),
                new Atom(BigDecimal.valueOf(5 - 34)),
                new Atom(BigDecimal.valueOf(5 - 67))
        ))));

        assertTrue(Evaluation.evalString("(+ '(13 43 34 67) 5)").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(13 + 5)),
                new Atom(BigDecimal.valueOf(43 + 5)),
                new Atom(BigDecimal.valueOf(34 + 5)),
                new Atom(BigDecimal.valueOf(67 + 5))
        ))));

        assertTrue(Evaluation.evalString("(- '(13 43 34 67) 5)").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(13 - 5)),
                new Atom(BigDecimal.valueOf(43 - 5)),
                new Atom(BigDecimal.valueOf(34 - 5)),
                new Atom(BigDecimal.valueOf(67 - 5))
        ))));
    }
}