import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestIfCond {
    @Test
    void testIfTrue() {
        assertEquals(Common.runCode(
                "(if true 5 6)"
        ).getReal(), new BigDecimal("5"));
    }

    @Test
    void testIfFalse() {
        assertEquals(Common.runCode(
                "(if false 5 6)"
        ).getReal(), new BigDecimal("6"));
    }

    @Test
    void testIfNested() {
        assertEquals(Common.runCode(
                "(if true (if true 5 6) 7)"
        ).getReal(), new BigDecimal("5"));
    }

    @Test
    void testCond() {
        assertEquals(Common.runCode(
                "(defun twc x (" +
                        "cond ((> x 0) 1) ((< x 0) -1) (0)" +
                        "))" +
                        "(tie (twc 5) (twc 0) (twc -5))"
        ), Common.runCode("(tie 1 0 -1)"));
    }

    @Test
    void testCondOneCase() {
        assertEquals(Common.runCode(
                "(defun twc x (" +
                        "cond ((> x 0) 1)" +
                        "))" +
                        "(twc 5)"
        ).getReal(), new BigDecimal("1"));
    }
}