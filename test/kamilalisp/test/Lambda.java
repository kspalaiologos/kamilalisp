package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Atom;
import kamilalisp.data.Environment;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

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

    @Test
    void exampleFunction() {
        assertTrue(Evaluation.evalString(
                "(defun square1 (x) (* x x))" +
                     "(def square2 (monad (* x x)))" +
                     "(= (square1 5) (square2 5))").get(2).coerceBool());
    }

    @Test
    void optionalArgs() {
        Environment env = Evaluation.createDefaultEnv();
        Evaluation.evalString(env, "(defun tieid (x y ?z) (tie x y z))");
        Evaluation.evalString(env, "(defun tieid2 (x ?y ?z) (tie x y z))");
        assertEquals(Evaluation.evalString(env, "(tieid 1 2 3)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                new Atom(new BigDecimal("3"))
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1 2 3)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                new Atom(new BigDecimal("3"))
        ));
        assertEquals(Evaluation.evalString(env, "(tieid 1 2)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                Atom.NULL
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1 2)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                Atom.NULL
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                Atom.NULL,
                Atom.NULL
        ));
    }

    @Test
    void optionalArgsMacro() {
        Environment env = Evaluation.createDefaultEnv();
        Evaluation.evalString(env, "(defmacro tieid (x y ?z) (tie x y z))");
        Evaluation.evalString(env, "(defmacro tieid2 (x ?y ?z) (tie x y z))");
        assertEquals(Evaluation.evalString(env, "(tieid 1 2 3)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                new Atom(new BigDecimal("3"))
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1 2 3)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                new Atom(new BigDecimal("3"))
        ));
        assertEquals(Evaluation.evalString(env, "(tieid 1 2)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                Atom.NULL
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1 2)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                new Atom(new BigDecimal("2")),
                Atom.NULL
        ));
        assertEquals(Evaluation.evalString(env, "(tieid2 1)").get(0).getList().get(), List.of(
                new Atom(new BigDecimal("1")),
                Atom.NULL,
                Atom.NULL
        ));
    }

    @Test
    void functionAcrossEnvs() {
        Environment env = Evaluation.createDefaultEnv();
        Evaluation.evalString(env, "(defun caar (x) (car (car x)))");
        assertTrue(Evaluation.evalString(env, "(caar '((1 2) (3 4) 5 6))").get(0).getNumber().get().compareTo(BigDecimal.ONE) == 0);
    }

    @Test
    void testType() {
        assertTrue(Evaluation.evalString("(type (lambda (x y) (+ x y)))").get(0).getStringConstant().get().get().equals("CLOSURE"));
    }

    @Test
    void testLog() {
        assertEquals(Evaluation.evalString("[(log 10) approx-eq 1 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(log 2 8) approx-eq 3 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
        assertEquals(Evaluation.evalString("[(log2 8) approx-eq 3 0.01]").get(0).getNumber().get(), BigDecimal.valueOf(1));
    }
}
