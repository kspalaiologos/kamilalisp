import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

class TestSKI {
    @Test
    void testSki() {
        String code = """
                (defun SKI x
                   (match x
                      ((((S 'x) 'y) 'z) (tie (tie x z) (tie y z)))
                      (((K 'x) 'y) x)
                      ((I 'x) x)
                      (('x 'y) (tie (SKI x) (SKI y)))
                      ('x x)))

                (converge SKI '(((S I) I) K))""";
        assertEquals(Common.runCode(code), Common.runCode("#0 '(K K)"));
    }
}
