import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.parallel.ExecutionMode.CONCURRENT;

@Execution(CONCURRENT)
class TestLines {
    @Test
    void testLines() {
        assertEquals(Common.runCode("(tally \\str:lines \"" +
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\\n" +
                "Proin nec feugiat velit. Proin efficitur odio non tellus\\n" +
                "imperdiet ultricies. Ut venenatis sollicitudin eros, eu\\n" +
                "fermentum enim dapibus ut. Aliquam feugiat dapibus massa.\\n" +
                "Fusce tempus sit amet lorem non vehicula. Nam gravida mattis\\n" +
                "lacinia. Proin sit amet maximus odio." +
                "\")").getInteger().intValueExact(), 6);
    }
}