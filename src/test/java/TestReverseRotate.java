import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestReverseRotate {
    @Test
    void testBasic() {
        assertEquals(Common.runCode(
                "(reverse '(1 2 3))"
        ), Common.runCode("(tie 3 2 1)"));

        assertEquals(Common.runCode(
                "(rotate 1 '(1 2 3))"
        ), Common.runCode("(tie 2 3 1)"));

        assertEquals(Common.runCode(
                "(rotate 2 '(1 2 3))"
        ), Common.runCode("(tie 3 1 2)"));

        assertEquals(Common.runCode(
                "(rotate 3 '(1 2 3))"
        ), Common.runCode("(tie 1 2 3)"));

        assertEquals(Common.runCode(
                "(rotate 4 '(1 2 3))"
        ), Common.runCode("(tie 2 3 1)"));

        assertEquals(Common.runCode(
                "(rotate -1 '(1 2 3))"
        ), Common.runCode("(tie 3 1 2)"));

        assertEquals(Common.runCode(
                "(rotate -2 '(1 2 3))"
        ), Common.runCode("(tie 2 3 1)"));

        assertEquals(Common.runCode(
                "(rotate -3 '(1 2 3))"
        ), Common.runCode("(tie 1 2 3)"));

        assertEquals(Common.runCode(
                "(rotate -4 '(1 2 3))"
        ), Common.runCode("(tie 3 1 2)"));
    }

    @Test
    void testEmpty() {
        assertEquals(Common.runCode(
                "(reverse '())"
        ), Common.runCode("(tie)"));

        assertEquals(Common.runCode(
                "(rotate 1 '())"
        ), Common.runCode("(tie)"));

        assertEquals(Common.runCode(
                "(rotate -1 '())"
        ), Common.runCode("(tie)"));
    }
}