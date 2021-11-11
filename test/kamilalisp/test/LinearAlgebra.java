package kamilalisp.test;

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
    }
}
