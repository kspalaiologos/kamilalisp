import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import palaiologos.kamilalisp.error.RaiseError;

import java.math.BigDecimal;
import java.math.BigInteger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestRegex {
    @Test
    void testMatches() {
        assertEquals(Common.runCode("""
                (and
                    (regex:matches? "[A-Za-z]+" "Kamila")
                    (regex:matches? "[A-Za-z]+" "LazyFox")
                    (not \\regex:matches? "[0-9]+" "0.23"))
        """).getInteger(), BigInteger.valueOf(1));
    }

    @Test
    void testReplace() {
        assertEquals(Common.runCode("""
                (and
                    (= (regex:replace "[A-Z]+" "quickBROWNfox." " ") "quick fox.")
                    (= (regex:replace "[0-9]+" "pi=3.14" "") "pi=."))
        """).getInteger(), BigInteger.valueOf(1));
    }

    @Test
    void testSplit() {
        assertEquals(Common.runCode("""
                (and
                    (same (regex:split "::" "std::istream_iterator<char>") '("std" "istream_iterator<char>"))
                    (same (regex:split "[0-9]+" "split192me286on368every381digit") '("split" "me" "on" "every" "digit"))
                    (same (regex:split "[0-9]+" "33split192me286on368every381digit333") '("" "split" "me" "on" "every" "digit")))
        """).getInteger(), BigInteger.valueOf(1));
    }
}