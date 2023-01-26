import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestDef {
    @Test
    void testBasic() {
        assertEquals(Common.runCode(
                "(def x 5)"
                + "(#0 x)"
        ).getReal(), new BigDecimal("5"));

        assertEquals(Common.runCode(
                "(def x 5)"
        ).getReal(), new BigDecimal("5"));
    }

    @Test
    void testShadow() {
        assertEquals(Common.runCode(
                "(def x 5)"
                + "(def x 6)"
                + "(#0 x)"
        ).getReal(), new BigDecimal("6"));
    }
}