import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestFr {
    @Test
    void testFr20() {
        assertEquals(Common.runCode("(let-seq (def fr 20) (+ (/ 3) (/ 4)))").getReal(), new BigDecimal("0.58333333333333333333"));
    }

    @Test
    void testFr50() {
        assertEquals(Common.runCode("(let-seq (def fr 50) (+ (/ 3) (/ 4)))").getReal(), new BigDecimal("0.58333333333333333333333333333333333333333333333333"));
    }
}