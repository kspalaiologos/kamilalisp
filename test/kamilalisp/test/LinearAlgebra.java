package kamilalisp.test;

import ch.obermuhlner.math.big.BigComplex;
import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import kamilalisp.data.Executor;
import kamilalisp.matrix.Matrix;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class LinearAlgebra {
    @Test
    void testAddition() {
        Matrix a = Matrix.from(List.of(
                List.of(new Atom(new BigDecimal("1.5")), new Atom(new BigDecimal("3.5"))),
                List.of(new Atom(new BigDecimal("0.5")), new Atom(new BigDecimal("5.5")))
        ));

        Matrix b = Matrix.from(List.of(
                List.of(new Atom(new BigDecimal("6.0")), new Atom(new BigDecimal("9.0"))),
                List.of(new Atom(new BigDecimal("3.5")), new Atom(new BigDecimal("2.0")))
        ));

        Environment env = Evaluation.createDefaultEnv();
        env.push("a", new Atom(a));
        env.push("b", new Atom(b));

        assertEquals(Evaluation.evalString(env, "(+ a b)").get(0).getMatrix().get(), Matrix.from(List.of(
                List.of(new Atom(new BigDecimal("7.5")), new Atom(new BigDecimal("12.5"))),
                List.of(new Atom(new BigDecimal("4.0")), new Atom(new BigDecimal("7.5")))
        )));

        assertEquals(Evaluation.evalString(env, "(+ a 0.5)").get(0).getMatrix().get(), Matrix.from(List.of(
                List.of(new Atom(new BigDecimal("2.0")), new Atom(new BigDecimal("4.0"))),
                List.of(new Atom(new BigDecimal("1.0")), new Atom(new BigDecimal("6.0")))
        )));
    }

    @Test
    void testConjugate() {
        assertTrue(Evaluation.evalString("(= (+ (mat-mix '((1J2 2J-3) (1J8.5 -3.5J6)))) (mat-mix '((1J-2 2J3) (1J-8.5 -3.5J-6))))").get(0).coerceBool());
    }

    @Test
    void testFrobeniusProd() {
        assertEquals(Evaluation.evalString("(frobenius-prod (mat-mix '((2 0 6) (1 -1 2))) (mat-mix '((8 -3 2) (4 1 -5))))").get(0).getNumber().get(), new BigDecimal("21"));
        assertEquals(Evaluation.evalString("(frobenius-prod (mat-mix '((1J1 0J-2) (3 -5))) (mat-mix '((-2 0J3) (4J-3 6))))").get(0).getComplex().get(), BigComplex.valueOf(new BigDecimal("-26"), new BigDecimal("-7")));
    }
}
