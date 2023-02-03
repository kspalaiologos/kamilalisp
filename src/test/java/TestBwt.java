import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestBwt {
    @Test
    void testBasic() {
        assertEquals(Common.runCode(
                "(def mystr \"SIX.MIXED.PIXIES.SIFT.SIXTY.PIXIE.DUST.BOXES\")\n" +
                        "(same mystr (saca:unbwt 31 (car@saca:bwt mystr)))\n"
        ).getReal(), new BigDecimal("1"));
    }
}