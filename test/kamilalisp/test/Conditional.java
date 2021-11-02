package kamilalisp.test;

import kamilalisp.api.Evaluation;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class Conditional {
    @Test
    void basicIf() {
        assertTrue(Evaluation.evalString("(if (= 2 2) \"ok\" \"fail\")").get(0).getStringConstant().get().get().equals("ok"));
    }

    @Test
    void basicCond() {
        assertTrue(Evaluation.evalString("(cond ((= 2 2) \"ok\") (\"fail\"))").get(0).getStringConstant().get().get().equals("ok"));
        assertTrue(Evaluation.evalString("(cond ((= 2 3) \"ok\") (\"fail\"))").get(0).getStringConstant().get().get().equals("fail"));
        assertTrue(Evaluation.evalString("(cond ((= 2 3) \"ok\") (1 \"fail\"))").get(0).getStringConstant().get().get().equals("fail"));
    }
}
