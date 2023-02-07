import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

class TestReplicateProduct {
    @Test
    void testReplicate() {
        assertEquals(Common.runCode("(replicate 3 1)"), Common.runCode("(tie 1 1 1)"));
        assertEquals(Common.runCode("(replicate 3 1.0)"), Common.runCode("(tie 1.0 1.0 1.0)"));
        assertEquals(Common.runCode("(replicate 3 '())"), Common.runCode("(tie)"));
        assertEquals(Common.runCode("(replicate 3 '(1 2 3))"), Common.runCode("(tie 1 2 3 1 2 3 1 2 3)"));
        assertEquals(Common.runCode("(replicate 1 '(1 2 3))"), Common.runCode("(tie 1 2 3)"));
        assertEquals(Common.runCode("(replicate 0 '(1 2 3))"), Common.runCode("(tie)"));

        // Try it on strings too.
        assertEquals(Common.runCode("(replicate 3 \"abc\")").getString(), "abcabcabc");
    }

    @Test
    void testOuterProduct() {
        assertEquals(Common.runCode("(outer-product 1 2)"), Common.runCode("(tie 1 2)"));
        assertEquals(Common.runCode("(outer-product 1.0 2.0)"), Common.runCode("(tie 1.0 2.0)"));
        assertEquals(Common.runCode("(outer-product '() '())"), Common.runCode("(tie)"));
        assertEquals(Common.runCode("(outer-product '(1 2 3) '(4 5 6))"), Common.runCode("#0 '(((1 4) (1 5) (1 6)) ((2 4) (2 5) (2 6)) ((3 4) (3 5) (3 6)))"));
    }

    @Test
    void testInnerProduct() {
        // Many cases to test: inner product returning a functor, multiple lists, different lengths, etc...
        assertEquals(Common.runCode("(inner-product + * '(1 2 3) '(4 5 6))").getReal(), BigDecimal.valueOf(32));
        assertEquals(Common.runCode("(inner-product + * '(1 2 3) '(4 5 6) '(7 8 9))").getReal(), BigDecimal.valueOf(270));
        assertEquals(Common.runCode("((inner-product + *) '(1 2 3) '(4 5 6) '(7 8 9))").getReal(), BigDecimal.valueOf(270));
    }
}
