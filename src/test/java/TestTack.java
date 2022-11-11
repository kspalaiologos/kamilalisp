import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;
import java.util.List;

@Execution(CONCURRENT)
class TestTack {
    @Test
    void testTack0() {
        assertTrue(Common.runCode("(#0 1 2 3)").getReal().equals(new BigDecimal(1)));
    }

    @Test
    void testTack1() {
        assertTrue(Common.runCode("(#1 1 2 3)").getReal().equals(new BigDecimal(2)));
    }

    @Test
    void testTack2() {
        assertTrue(Common.runCode("(#2 1 2 3)").getReal().equals(new BigDecimal(3)));
    }

    @Test
    void testTackLists() {
        assertEquals(Common.runCode("(#1 '(1 2) '(2 3) '(3 4))"), Common.runCode("(tie 2 3)"));
    }
}