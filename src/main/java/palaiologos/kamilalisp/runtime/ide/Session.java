package palaiologos.kamilalisp.runtime.ide;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.error.InterruptionError;

import java.util.List;

import static palaiologos.kamilalisp.repl.Main.defaultRegistry;

public class Session {
    Terminal t;

    public Session(Terminal t) {
        this.t = t;
        t.appendOutput("KamilaLisp v 0.2 - Copyright (C) Kamila Szewczyk, 2021 - 2023.\nInteractive mode.\n\n");
    }

    public void run() {
        Environment env = new Environment(defaultRegistry);
        int lineNumberOffset = 0;
        while(true) {
            String code = t.prompt().replace("\u00a0"," ");
            if (code.isEmpty() || code.trim().isEmpty() || code.trim().charAt(0) == ';')
                continue;
            try {
                List<Atom> data;
                try {
                    String cc;
                    if (code.charAt(0) == '?') {
                        cc = code.substring(1);
                    } else if (code.charAt(0) == '(' && code.charAt(code.length() - 1) == ')') {
                        cc = code;
                    } else {
                        cc = "(" + code + "\n)";
                    }
                    data = Parser.parse(lineNumberOffset, cc);
                } catch (ParseCancellationException e) {
                    t.appendOutput("Syntax error: " + e.getMessage());
                    continue;
                }
                for (Atom atom : data) {
                    Atom a = Evaluation.safeEvaluate(env, atom, (s, thr) -> {
                        t.appendOutput(s);
                        throw new InterruptionError();
                    });
                    if (a.equals(Atom.NULL))
                        continue;
                    t.appendOutput(a.toDisplayString());
                }
            } catch (InterruptionError e) {
                // Ignore, we just wanted to unwind the stack.
            }
            // count newlines in code
            lineNumberOffset += code.chars().filter(c -> c == '\n').count();
        }
    }
}
