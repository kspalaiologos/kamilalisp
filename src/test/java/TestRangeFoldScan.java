import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestRangeFoldScan {
    @Test
    void testBasic() {
        // Range from 1 to 5:
        assertEquals(Common.runCode(
                "(range 1 5)"
        ), Common.runCode("(tie 1 2 3 4)"));

        // Range from 0 to 5:
        assertEquals(Common.runCode(
                "(range 5)"
        ), Common.runCode("(tie 0 1 2 3 4)"));

        // Fold with + from 0 to 5:
        assertEquals(Common.runCode(
                "(foldl + 0 (range 5))"
        ), Common.runCode("10"));

        // Scan with + from 0 to 5:
        assertEquals(Common.runCode(
                "(scanl + 0 (range 5))"
        ), Common.runCode("(tie 0 0 1 3 6 10)"));

        // Fold with * from 1 to 5:
        assertEquals(Common.runCode(
                "(foldl * 1 (range 1 5))"
        ), Common.runCode("24"));

        // Scan with * from 1 to 5:
        assertEquals(Common.runCode(
                "(scanl * 1 (range 1 5))"
        ), Common.runCode("(tie 1 1 2 6 24)"));

        // Fold with - from 0 to 5:
        assertEquals(Common.runCode(
                "(foldl - 0 (range 5))"
        ), Common.runCode("-10"));

        // Scan with - from 0 to 5:
        assertEquals(Common.runCode(
                "(scanl - 0 (range 5))"
        ), Common.runCode("(tie 0 0 -1 -3 -6 -10)"));
    }

    @Test
    void testRangeEmpty() {
        // Range from 1 to 1:
        assertEquals(Common.runCode(
                "(range 1 1)"
        ), Common.runCode("(tie)"));

        // Range from 0 to 0:
        assertEquals(Common.runCode(
                "(range 0)"
        ), Common.runCode("(tie)"));
    }

    @Test
    void testRangeBackwards() {
        // Range from 5 to 1:
        assertEquals(Common.runCode(
                "(range 5 1)"
        ), Common.runCode("(tie 5 4 3 2)"));

        // Range from 5 to 0:
        assertEquals(Common.runCode(
                "(range 5 0)"
        ), Common.runCode("(tie 5 4 3 2 1)"));
    }

    @Test
    void testRangeNegative() {
        // Range from -1 to 1:
        assertEquals(Common.runCode(
                "(range -1 1)"
        ), Common.runCode("(tie -1 0)"));

        // Range from -1 to 0:
        assertEquals(Common.runCode(
                "(range -1 0)"
        ), Common.runCode("(tie -1)"));

        // Range from -1 to -1:
        assertEquals(Common.runCode(
                "(range -1 -1)"
        ), Common.runCode("(tie)"));

        // Range from -1 to -2:
        assertEquals(Common.runCode(
                "(range -1 -2)"
        ), Common.runCode("(tie -1)"));

        // Range from -1 to -3:
        assertEquals(Common.runCode(
                "(range -1 -3)"
        ), Common.runCode("(tie -1 -2)"));
    }

    @Test
    void testFoldScanEmpty() {
        // Fold with + from 0 to 0:
        assertEquals(Common.runCode(
                "(foldl + 0 (range 0))"
        ), Common.runCode("0"));

        // Scan with + from 0 to 0:
        assertEquals(Common.runCode(
                "(scanl + 0 (range 0))"
        ), Common.runCode("(tie 0)"));

        // Fold with * from 1 to 1:
        assertEquals(Common.runCode(
                "(foldl * 1 (range 1 1))"
        ), Common.runCode("1"));

        // Scan with * from 1 to 1:
        assertEquals(Common.runCode(
                "(scanl * 1 (range 1 1))"
        ), Common.runCode("(tie 1)"));

        // Fold with - from 0 to 0:
        assertEquals(Common.runCode(
                "(foldl - 0 (range 0))"
        ), Common.runCode("0"));

        // Scan with - from 0 to 0:
        assertEquals(Common.runCode(
                "(scanl - 0 (range 0))"
        ), Common.runCode("(tie 0)"));
    }

    @Test
    void testScanrFoldr() {
        // Scanr with + from 0 to 5:
        assertEquals(Common.runCode(
                "(scanr + 0 (range 5))"
        ), Common.runCode("(tie 10 10 9 7 4 0)"));

        // Foldr with + from 0 to 5:
        assertEquals(Common.runCode(
                "(foldr + 0 (range 5))"
        ), Common.runCode("10"));

        // Scanr with * from 1 to 5:
        assertEquals(Common.runCode(
                "(scanr * 1 (range 1 5))"
        ), Common.runCode("(tie 24 24 12 4 1)"));

        // Foldr with * from 1 to 5:
        assertEquals(Common.runCode(
                "(foldr * 1 (range 1 5))"
        ), Common.runCode("24"));

        // Scanr with - from 0 to 5:
        assertEquals(Common.runCode(
                "(scanr - 0 (range 5))"
        ), Common.runCode("(tie -10 -10 -9 -7 -4 0)"));

        // Foldr with - from 0 to 5:
        assertEquals(Common.runCode(
                "(foldr - 0 (range 5))"
        ), Common.runCode("2"));
    }
}