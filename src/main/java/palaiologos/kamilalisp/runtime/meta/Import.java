package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Import extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        try {
            assertArity(args, 1);
            Atom arg = args.get(0);
            arg.assertTypes(Type.STRING);
            String fileName = arg.getString();
            String code = Files.readString(Path.of(fileName));
            Environment childEnv = Environment.defaultEnvironment();
            List<Atom> data = Parser.parse(code);
            for (int i = 0; i < data.size() - 1; i++) {
                Evaluation.evaluate(childEnv, data.get(i));
            }
            Atom result = Evaluation.evaluate(childEnv, data.get(data.size() - 1));
            for (String key : childEnv.keys())
                if (!env.has(key) && key.startsWith("public:"))
                    env.set(key.substring(7), childEnv.get(key));
            return result;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "import";
    }
}
