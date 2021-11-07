package kamilalisp.test;

import kamilalisp.api.Evaluation;
import kamilalisp.data.Environment;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class EulerTests {
    // Note: IntelliJ + language version 12 should generally support raw strings.
    // Unfortunately, it doesn't.

    @Test
    void problem1() {
        Environment env = Evaluation.createDefaultEnv();
        assertEquals(Evaluation.evalString(env, "(def divides $(= 0)@%)\n" +
                "(sum@filter (lambda (x) (| (divides x 5) (divides x 3))) (iota 1000))").get(1).getNumber().get(), new BigDecimal("233168"));
    }
}
