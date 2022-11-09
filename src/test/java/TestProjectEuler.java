import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

class TestProjectEuler {
    @Test
    void testProblem1() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem1.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void testProblem2() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem2.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void testProblem3() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem3.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void testProblem4() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem4.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void testProblem5() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem5.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    void testProblem6() {
        try {
            assertTrue(Common.runCode(Files.readString(Path.of("project-euler/problem6.lisp"))).coerceBool());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}