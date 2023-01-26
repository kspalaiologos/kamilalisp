import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestFormat {
    @Test
    void testFormatVarString() {
        assertEquals(Common.runCode("(defun greet x \\str:format \"Hello, {?x}!\") (greet \"Kamila\")").getString(), "Hello, Kamila!");
    }

    @Test
    void testFormatVarNumber() {
        assertEquals(Common.runCode("(defun greet x \\str:format \"Hello, {?x}!\") (greet 5)").getString(), "Hello, 5!");
    }

    @Test
    void testFormatVarNumber2() {
        assertEquals(Common.runCode("(defun greet x \\str:format \"Hello, {?x}!\") (greet 5.5)").getString(), "Hello, 5.5!");
    }

    @Test
    void testFormatExpression() {
        assertEquals(Common.runCode("(defun successor x \\str:format \"The successor of {?x} is {+ x 1}!\") (successor (+ 2 3))").getString(), "The successor of 5 is 6!");
    }

    @Test
    void testFormatLiteralBraces() {
        assertEquals(Common.runCode("(str:format \"{{}}\")").getString(), "{}");
    }

    @Test
    void testFormatLiteralBracesUnmatched() {
        assertEquals(Common.runCode("(str:format \"{{\")").getString(), "{");
        assertEquals(Common.runCode("(str:format \"}}\")").getString(), "}");
        assertEquals(Common.runCode("(str:format \"}}{{\")").getString(), "}{");
    }
}