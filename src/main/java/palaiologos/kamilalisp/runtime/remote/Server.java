package palaiologos.kamilalisp.runtime.remote;

import org.antlr.v4.runtime.misc.ParseCancellationException;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.atom.Parser;
import palaiologos.kamilalisp.error.InterruptionError;
import palaiologos.kamilalisp.repl.Main;
import palaiologos.kamilalisp.runtime.remote.packet.*;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;

public class Server {
    public static void run(int port) throws Exception {
        ServerSocket server = new ServerSocket(port);
        System.out.println(server.getLocalPort());
        Socket clientSocket = server.accept();
        ObjectInputStream in = new ObjectInputStream(clientSocket.getInputStream());
        ObjectOutputStream out = new ObjectOutputStream(clientSocket.getOutputStream());
        int lineNumberOffset = 0;
        Environment env = new Environment(Main.defaultRegistry);
        RemotePacketRegistry.register(env, in, out, clientSocket);
        boolean skipPrompt = false;
        while (true) {
            if (!skipPrompt) {
                out.writeObject(new PromptPacket());
                out.flush();
            } else {
                skipPrompt = false;
            }
            Packet p = (Packet) in.readObject();
            if (p instanceof StringPacket) {
                String code = ((StringPacket) p).data;
                if (code == null)
                    break;
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
                        out.writeObject(new StringPacket("Syntax error: " + e.getMessage() + "\n"));
                        out.flush();
                        continue;
                    }
                    for (Atom atom : data) {
                        Atom a = Evaluation.safeEvaluate(env, atom, (s, thr) -> {
                            try {
                                out.writeObject(new StringPacket(s + "\n"));
                                out.flush();
                            } catch (IOException e) {
                            }
                            throw new InterruptionError();
                        });
                        try {
                            if (a.equals(Atom.NULL))
                                continue;
                            out.writeObject(new StringPacket(a.toDisplayString() + "\n"));
                            out.flush();
                        } catch (Throwable e) {
                            StringWriter o = new StringWriter();
                            PrintWriter pw = new PrintWriter(o);
                            e.printStackTrace(pw);
                            out.writeObject(new StringPacket(o.toString()));
                        }
                    }
                } catch (InterruptionError e) {
                    // Ignore, we just wanted to unwind the stack.
                }
                // count newlines in code
                lineNumberOffset += code.chars().filter(c -> c == '\n').count();
            } else if (p instanceof FixPacket fix) {
                Throwable err = null;
                try {
                    Atom ast = Parser.parse(0, fix.content).get(0);
                    env.set(fix.name, Evaluation.evaluate(env, ast));
                } catch (Throwable t) {
                    err = t;
                }
                if (err == null) {
                    out.writeObject(new IDEPacket("fix:ok", List.of()));
                    out.flush();
                } else {
                    out.writeObject(new IDEPacket("fix:err", List.of(err)));
                    out.flush();
                }
                skipPrompt = true;
            }
        }
    }
}
