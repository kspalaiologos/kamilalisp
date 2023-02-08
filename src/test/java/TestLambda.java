import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestLambda {
    private final PrintStream standardOut = System.out;
    private final ByteArrayOutputStream outputStreamCaptor = new ByteArrayOutputStream();

    @BeforeEach
    public void setUp() {
        System.setOut(new PrintStream(outputStreamCaptor));
    }

    @Test
    void testBasic() {
        assertEquals(Common.runCode(
                "((lambda x \\+ x 1) 5)"
        ).getReal(), new BigDecimal("6"));
    }

    @Test
    void testCurry() {
        assertEquals(Common.runCode(
                "(((lambda x (lambda y (+ x y))) 5) 6)"
        ).getReal(), new BigDecimal("11"));
    }

    @Test
    void testCurryDef() {
        assertEquals(Common.runCode(
                "(defun adder x (lambda y (+ x y)))"
                        + "((adder 5) 6)"
        ).getReal(), new BigDecimal("11"));
    }

    @Test
    void testVarArg() {
        assertEquals(Common.runCode(
                "(def sum-all (lambda (x ...xs) (foldl + x ...xs)))"
                        + "(sum-all 1 2 3 4 5)"
        ).getReal(), new BigDecimal("15"));
    }

    @Test
    void testVarArgBare() {
        assertEquals(Common.runCode(
                "(def sum-all (lambda (...xs) (foldl + 0 ...xs)))"
                        + "(sum-all 1 2 3 4 5)"
        ).getReal(), new BigDecimal("15"));
    }

    @Test
    void testVarArgSingletonXs() {
        assertEquals(Common.runCode(
                "(def sum-all (lambda (x ...xs) (foldl + x ...xs)))"
                        + "(sum-all 1 2)"
        ).getReal(), new BigDecimal("3"));
    }

    @Test
    void testVarArgNullXs() {
        assertEquals(Common.runCode(
                "(def sum-all (lambda (x ...xs) (foldl + x ...xs)))"
                        + "(sum-all 1)"
        ).getReal(), new BigDecimal("1"));
    }

    @Test
    void testMultipleStmts() {
        Common.runCode("(defun thing (x y) (io:write x) (io:write y)) (thing 2 3)");
        assertEquals("23", outputStreamCaptor.toString().trim());
    }

    @AfterEach
    public void tearDown() {
        System.setOut(standardOut);
    }
}