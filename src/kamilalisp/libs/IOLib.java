package kamilalisp.libs;

import kamilalisp.api.Evaluation;
import kamilalisp.data.*;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Scanner;

public class IOLib {
    public static void install(Environment env) {
        env.push("println", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'println' expects exactly one argument");
                if(arguments.get(0).getType() == Type.STRING_CONSTANT)
                    System.out.println(arguments.get(0).getStringConstant().get().get());
                else
                    System.out.println(arguments.get(0).toString());
                return arguments.get(0);
            }
        }));

        env.push("prompt", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'prompt' expects exactly one argument");
                arguments.get(0).guardType("First argument to 'prompt'", Type.STRING_CONSTANT);
                System.out.print(arguments.get(0).getStringConstant().get().get());
                Scanner s = new Scanner(System.in);
                return Evaluation.evalAtom(env.env, s.nextLine());
            }
        }));

        env.push("prompt-str", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'prompt-str' expects exactly one argument");
                arguments.get(0).guardType("First argument to 'prompt-str'", Type.STRING_CONSTANT);
                System.out.print(arguments.get(0).getStringConstant().get().get());
                Scanner s = new Scanner(System.in);
                return new Atom(new StringConstant(s.nextLine()));
            }
        }));

        env.push("read-eval", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                Scanner s = new Scanner(System.in);
                return Evaluation.evalAtom(env.env, s.nextLine());
            }
        }));

        env.push("read-str", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                Scanner s = new Scanner(System.in);
                return new Atom(new StringConstant(s.nextLine()));
            }
        }));

        env.push("file-get", new Atom(new Closure() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1)
                    throw new Error("'file-get' expects exactly one argument");
                arguments.get(0).guardType("First argument to 'file-get'", Type.STRING_CONSTANT);

                try {
                    return new Atom(new StringConstant(Files.readString(Path.of(arguments.get(0).getStringConstant().get().get()))));
                } catch (IOException e) {
                    return Atom.NULL;
                }
            }
        }));
    }
}
