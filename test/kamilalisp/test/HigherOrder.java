package kamilalisp.test;

import kamilalisp.api.Evaluation;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class HigherOrder {
    @Test
    public void map() {
        assertTrue(Evaluation.evalString("(size (map - '(1 2 3)))").get(0).get().get().equals(BigDecimal.valueOf(3)));
    }
}
