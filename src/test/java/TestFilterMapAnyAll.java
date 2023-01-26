import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestFilterMapAnyAll {
    @Test
    void testFilter() {
        assertEquals(Common.runCode("(filter (lambda _ \\mod _ 2) \\range 0 10)"), Common.runCode("#0 '(1 3 5 7 9)"));
        assertEquals(Common.runCode("(filter $(mod _ 2) \\range 0 10)"), Common.runCode("#0 '(1 3 5 7 9)"));
        assertEquals(Common.runCode("(filter $(not@mod _ 2) \\range 0 10)"), Common.runCode("#0 '(0 2 4 6 8)"));
    }

    @Test
    void testFilterEmpty() {
        assertEquals(Common.runCode("(filter (lambda _ \\mod _ 2) \\range 0 0)"), Common.runCode("#0 '()"));
        assertEquals(Common.runCode("(filter $(mod _ 2) \\range 0 0)"), Common.runCode("#0 '()"));
        assertEquals(Common.runCode("(filter $(not@mod _ 2) \\range 0 0)"), Common.runCode("#0 '()"));
    }

    @Test
    void testFilterAllMap() {
        assertEquals(Common.runCode(
                "(def evens \\filter $(not@mod _ 2) \\range 0 1000)" +
                        "(all $(= _ 0) \\:$(mod _ 2) evens)"
        ).getInteger().intValueExact(), 1);
    }

    @Test
    void testFilterAllMapParallel() {
        assertEquals(Common.runCode(
                "(def evens \\parallel-filter $(not@mod _ 2) \\range 0 10000)" +
                        "(all $(= _ 0) \\$:$(mod _ 2) evens)"
        ).getInteger().intValueExact(), 1);
    }

    @Test
    void testMapAsZipWith() {
        assertEquals(Common.runCode("(= 1 \\⍴@⊙@[:+ #0 ⌽@#0] \\⍳ 1 100)").getInteger().intValueExact(), 1);
        assertEquals(Common.runCode("(= 1 \\⍴∘⊙∘[:+ #0 ⌽∘#0] \\⍳ 1 10000)").getInteger().intValueExact(), 1);
    }

    @Test
    void testAny() {
        assertEquals(Common.runCode("(any $(= _ 0) \\range 0 10)").getInteger().intValueExact(), 1);
        assertEquals(Common.runCode("(any $(= _ 10) \\range 0 10)").getInteger().intValueExact(), 0);
    }
}