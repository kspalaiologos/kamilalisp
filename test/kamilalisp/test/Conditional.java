package kamilalisp.test;

import kamilalisp.api.Evaluation;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class Conditional {
    @Test
    void basicIf() {
        assertTrue(Evaluation.evalString("(if (= 2 2) \"ok\" \"fail\")").get(0).getStringConstant().get().get().equals("ok"));
    }
}
