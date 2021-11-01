package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ListBasic {
    @Test
    void testCons() {
        assertTrue(Evaluation.evalString("(cons 2 (cons 3 'nil))").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(2)),
                new Atom(BigDecimal.valueOf(3))
        ))));

        assertTrue(Evaluation.evalString("(size (~ '(1 2 3) 3))").get(0).equals(new Atom(BigDecimal.valueOf(2))));
        assertTrue(Evaluation.evalString("(= 2 (size (~ '(1 2 3) 3)))").get(0).equals(new Atom(BigDecimal.valueOf(1))));
        assertTrue(Evaluation.evalString("(= 2 (size (~ '(1 2 3) 3)))").get(0).coerceBool());
    }

    @Test
    void testCdr() {
        assertTrue(Evaluation.evalString("(cdr (cons 2 (cons 3 'nil)))").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(3))
        ))));

        assertTrue(Evaluation.evalString("(cdr 'nil)").get(0).equals(Atom.NULL));
    }

    @Test
    void testUnion() {
        assertTrue(Evaluation.evalString("(| '(1 2 3) '(2 3 4))").get(0).equals(new Atom(List.of(
                new Atom(BigDecimal.valueOf(1)),
                new Atom(BigDecimal.valueOf(2)),
                new Atom(BigDecimal.valueOf(3)),
                new Atom(BigDecimal.valueOf(4))
        ))));

        assertTrue(Evaluation.evalString("(| \"hi\" \"hello\")").get(0).getStringConstant().get().get().equals("hielo"));
        assertTrue(Evaluation.evalString("(| 1 0)").get(0).getNumber().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(| 0 1)").get(0).getNumber().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(| 0 0)").get(0).getNumber().get().equals(BigDecimal.valueOf(0)));
        assertTrue(Evaluation.evalString("(| 1 1)").get(0).getNumber().get().equals(BigDecimal.valueOf(1)));
        assertTrue(Evaluation.evalString("(| 5 20)").get(0).getNumber().get().equals(BigDecimal.valueOf(21)));
    }
}
