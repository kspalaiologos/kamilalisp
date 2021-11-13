package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Environment;
import kamilalisp.start.Main;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class EulerTests {
    private final PrintStream standardOut = System.out;
    private final ByteArrayOutputStream output = new ByteArrayOutputStream();

    @BeforeEach
    private void setUp() {
        System.setOut(new PrintStream(output));
    }

    @AfterEach
    private void tearDown() {
        System.setOut(standardOut);
    }

    private String runProblem(String name) {
        try {
            Main.evalScript(Evaluation.createDefaultEnv(), "euler/" + name + ".lisp");
        } catch (IOException e) {
            fail(e);
        }

        return output.toString().trim();
    }

    @Test void problem1() { assertEquals(runProblem("p1"), "233168"); }
    @Test void problem2() { assertEquals(runProblem("p2"), "4613732"); }
    @Test void problem3() { assertEquals(runProblem("p3"), "6857"); }
    @Test void problem4() { assertEquals(runProblem("p4"), "906609"); }
    @Test void problem5() { assertEquals(runProblem("p5"), "232792560"); }
    @Test void problem6() { assertEquals(runProblem("p6"), "25164150"); }
    @Test void problem7() { assertEquals(runProblem("p7"), "104743"); }
    @Test void problem8() { assertEquals(runProblem("p8"), "23514624000"); }
    @Test void problem9() { assertEquals(runProblem("p9"), "31875000"); }
}
