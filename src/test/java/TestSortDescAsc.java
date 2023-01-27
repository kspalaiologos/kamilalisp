import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestSortDescAsc {
    @Test
    void testSortDesc() {
        assertEquals(Common.runCode("(sort-desc \\range 0 10)"), Common.runCode("#0 '(9 8 7 6 5 4 3 2 1 0)"));
        assertEquals(Common.runCode("(sort-desc \\range 0 0)"), Common.runCode("#0 '()"));

        // Test with a custom comparator
        assertEquals(Common.runCode("(sort-desc (lambda (x y) \\mod x 2) \\range 0 10)"), Common.runCode("#0 '(9 7 5 3 1 0 2 4 6 8)"));
    }

    @Test
    void testSortAsc() {
        assertEquals(Common.runCode("(sort-asc \\range 0 10)"), Common.runCode("#0 '(0 1 2 3 4 5 6 7 8 9)"));
        assertEquals(Common.runCode("(sort-asc \\range 0 0)"), Common.runCode("#0 '()"));

        // Test with a custom comparator
        assertEquals(Common.runCode("(sort-asc (lambda (x y) \\- y x) \\range 0 10)"), Common.runCode("#0 '(9 8 7 6 5 4 3 2 1 0)"));
    }

    @Test
    void testGradeUp() {
        // x$[grade-up x] = sort-asc x
        assertEquals(Common.runCode("(grade-up '(26 17 38 59 27 16 38 57 26 38 56))"), Common.runCode("#0 '(5 1 0 8 4 2 6 9 10 7 3)"));
        assertEquals(Common.runCode("(def ml '(26 17 38 59 27 16 38 57 26 38 56)) (#0 ml$[grade-up ml])"), Common.runCode("(sort-asc '(26 17 38 59 27 16 38 57 26 38 56))"));
        // try to undo sorting by applying grade-up to the permutation again.
        assertEquals(Common.runCode("(def ml '(26 17 38 59 27 16 38 57 26 38 56)) (def srt (#0 ml$[grade-up ml])) (#0 srt$[grade-up \\grade-up ml])"), Common.runCode("(#0 '(26 17 38 59 27 16 38 57 26 38 56))"));
    }

    @Test
    void testGradeDown() {
        // x$[grade-down x] = sort-desc x
        assertEquals(Common.runCode("(grade-down '(26 17 38 59 27 16 38 57 26 38 56))"), Common.runCode("#0 '(3 7 10 2 6 9 4 0 8 1 5)"));
        assertEquals(Common.runCode("(def ml '(26 17 38 59 27 16 38 57 26 38 56)) (#0 ml$[grade-down ml])"), Common.runCode("(sort-desc '(26 17 38 59 27 16 38 57 26 38 56))"));
        // try to undo sorting by applying grade-down to the permutation again.
        assertEquals(Common.runCode("(def ml '(26 17 38 59 27 16 38 57 26 38 56)) (def srt (#0 ml$[grade-down ml])) (#0 srt$[grade-down \\grade-down ml])"), Common.runCode("(reverse '(26 17 38 59 27 16 38 57 26 38 56))"));
    }
}