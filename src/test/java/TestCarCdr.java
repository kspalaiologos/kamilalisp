import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestCarCdr {
    @Test
    void testBasic() {
        assertEquals(Common.runCode(
                "(car '(1 2 3))"
        ).getReal(), new BigDecimal("1"));

        assertEquals(Common.runCode(
                "(cdr '(1 2 3))"
        ), Common.runCode("(tie 2 3)"));
    }

    @Test
    void testNil() {
        assertThrows(IndexOutOfBoundsException.class, () -> Common.runCode("(car '())"));

        assertEquals(Common.runCode(
                "(cdr '())"
        ), Common.runCode("(#0 'nil)"));
    }

    @Test
    void testString() {
        assertEquals(Common.runCode(
                "(car \"abc\")"
        ).getString(), "a");

        assertEquals(Common.runCode(
                "(cdr \"abc\")"
        ).getString(), "bc");
    }

    @Test
    void testEmptyString() {
        assertThrows(IndexOutOfBoundsException.class, () -> Common.runCode("(car \"\")"));

        assertEquals(Common.runCode(
                "(cdr \"\")"
        ).getString(), "");
    }
}