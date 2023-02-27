package palaiologos.kamilalisp.runtime.remote.io;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.meta.Import;
import palaiologos.kamilalisp.runtime.remote.IDEPacket;
import palaiologos.kamilalisp.runtime.remote.StringPacket;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.util.List;

public class FixProject extends IDEFunction implements Lambda {
    public FixProject(ObjectInputStream in, ObjectOutputStream out, Socket socket) {
        super(in, out, socket);
    }

    @Override
    protected Atom fapply(Environment env, List<Atom> args) {
        sendPacket();
        StringPacket p = (StringPacket) receivePacket();
        String code = p.data;
        Environment childEnv = new Environment(Main.defaultRegistry);
        List<Atom> data = Parser.parse(code);
        for (int i = 0; i < data.size() - 1; i++) {
            Evaluation.evaluate(childEnv, data.get(i));
        }
        Atom result = Evaluation.evaluate(childEnv, data.get(data.size() - 1));
        for (String key : childEnv.keys())
            env.set(key, childEnv.get(key));
        return result;
    }

    @Override
    protected String name() {
        return "ide:fix-project";
    }
}
