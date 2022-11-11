import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestTack {
    @Test
    void testTack0() {
        assertEquals(Common.runCode("(#0 1 2 3)").getReal(), new BigDecimal(1));
    }

    @Test
    void testTack1() {
        assertEquals(Common.runCode("(#1 1 2 3)").getReal(), new BigDecimal(2));
    }

    @Test
    void testTack2() {
        assertEquals(Common.runCode("(#2 1 2 3)").getReal(), new BigDecimal(3));
    }

    @Test
    void testTackLists() {
        assertEquals(Common.runCode("(#1 '(1 2) '(2 3) '(3 4))"), Common.runCode("(tie 2 3)"));
    }
}