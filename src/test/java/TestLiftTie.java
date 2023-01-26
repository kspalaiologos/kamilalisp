import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;
import java.math.BigInteger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestLiftTie {
    @Test
    void testTie() {
        assertEquals(Common.runCode("(tie 1 2)"), Common.runCode("(#0 '(1 2))"));
    }

    @Test
    void testLift() {
        assertEquals(Common.runCode("(lift + '(1 2))").getInteger(), BigInteger.valueOf(3));
    }

    @Test
    void testLiftFunctor() {
        assertEquals(Common.runCode("(def liftplus \\lift +) (liftplus '(1 2))").getInteger(), BigInteger.valueOf(3));
    }

    @Test
    void testTieLiftRedundancy() {
        assertEquals(Common.runCode("(lift tie '(1 2))"), Common.runCode("(#0 '(1 2))"));
    }
}