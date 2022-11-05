import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Parser;

import java.util.List;

public class Common {
    public static Atom runCode(String s) {
        List<Atom> data = Parser.parse(s);
        Environment env = Environment.defaultEnvironment();
        for(int i = 0; i < data.size() - 1; i++)
            Evaluation.evaluate(env, data.get(i));
        return Evaluation.evaluate(env, data.get(data.size() - 1));
    }
}
