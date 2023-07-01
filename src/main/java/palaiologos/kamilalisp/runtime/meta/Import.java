package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.ide.project.ProjectDataRegistry;
import palaiologos.kamilalisp.runtime.sh.Wd;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

public class Import extends PrimitiveFunction implements Lambda {
    private boolean isProjectFile(String fileName) {
        try {
            FileInputStream fis = new FileInputStream(Wd.relativeTo(fileName));
            byte[] magic = new byte[8];
            fis.read(magic);
            fis.close();
            return new String(magic).equals("@KLP-BIN");
        } catch (IOException e) {
            return false;
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        try {
            assertArity(args, 1);
            Atom arg = args.get(0);
            arg.assertTypes(Type.STRING);
            String fileName = arg.getString();
            String code;
            if (!isProjectFile(fileName)) {
                code = Files.readString(Wd.relativeTo(fileName).toPath());
            } else {
                ProjectDataRegistry registry = new ProjectDataRegistry(null);
                registry.readFrom(new FileInputStream(fileName));
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                registry.serialiseTo(baos);
                code = baos.toString();
            }
            Environment childEnv = new Environment(Main.defaultRegistry);
            List<Atom> data = Parser.parse(code);
            for (int i = 0; i < data.size() - 1; i++) {
                Evaluation.evaluate(childEnv, data.get(i));
            }
            Atom result = Evaluation.evaluate(childEnv, data.get(data.size() - 1));
            for (String key : childEnv.keys())
                if (key.startsWith("public:"))
                    env.set(key.substring(7), childEnv.get(key));
            return result;
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "import";
    }
}
