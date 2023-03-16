package palaiologos.kamilalisp.runtime.lib;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Evaluation;
import palaiologos.kamilalisp.runtime.IO.*;
import palaiologos.kamilalisp.runtime.IO.streams.*;
import palaiologos.kamilalisp.runtime.dataformat.archive.*;
import palaiologos.kamilalisp.runtime.image.LoadImage;
import palaiologos.kamilalisp.runtime.image.WriteImage;
import palaiologos.kamilalisp.runtime.meta.Cmpx;
import palaiologos.kamilalisp.runtime.meta.Exit;
import palaiologos.kamilalisp.runtime.meta.Import;
import palaiologos.kamilalisp.runtime.net.*;
import palaiologos.kamilalisp.runtime.net.httpserver.*;
import palaiologos.kamilalisp.runtime.sh.*;
import palaiologos.kamilalisp.runtime.sh.Process;

import java.util.List;

public class SystemLib {
    public static void register(Environment env) {
        env.setPrimitive("img:write", "≣⊣", new Atom(new WriteImage()));
        env.setPrimitive("img:read", "≣⊢", new Atom(new LoadImage()));

        env.setPrimitive("io:get-file", "⍫⊢", new Atom(new GetFile()));
        env.setPrimitive("io:put-file", "⍫⊣", new Atom(new PutFile()));
        env.setPrimitive("io:append-file", "⍫⊣+", new Atom(new AppendFile()));
        env.setPrimitive("io:get-file-buffer", "⍫⎕⊢", new Atom(new GetFileBuffer()));
        env.setPrimitive("io:file-istream", new Atom(new FileInputStreamWrapper()));
        env.setPrimitive("io:file-ostream", new Atom(new FileOutputStreamWrapper()));
        env.setPrimitive("io:audio-ostream", new Atom(new AudioOutputStream()));

        env.setPrimitive("archive:zip:create", new Atom(new ZipCreate()));
        env.setPrimitive("archive:zip:load", new Atom(new ZipLoad()));
        env.setPrimitive("archive:zip:save", new Atom(new ZipSave()));
        env.setPrimitive("archive:tar:create", new Atom(new TarCreate()));
        env.setPrimitive("archive:tar:load", new Atom(new TarLoad()));
        env.setPrimitive("archive:tar:save", new Atom(new TarSave()));

        env.setPrimitive("sh:mkdir", new Atom(new Mkdir()));
        env.setPrimitive("sh:cwd", new Atom(new Cwd()));
        env.setPrimitive("sh:cd", new Atom(new Cd()));
        env.setPrimitive("sh:rm", new Atom(new Rm()));
        env.setPrimitive("sh:glob", new Atom(new Glob()));
        env.setPrimitive("sh:cp", new Atom(new Cp()));
        env.setPrimitive("sh:ls", new Atom(new Ls()));
        env.setPrimitive("sh:basename", new Atom(new Basename()));
        env.setPrimitive("sh:mv", new Atom(new Mv()));
        env.setPrimitive("sh:access", new Atom(new Access()));
        env.setPrimitive("sh:absolute", new Atom(new Absolute()));
        env.setPrimitive("sh:process", new Atom(new Process()));
        SysArch.registerProperties(env);

        env.setPrimitive("net:wget", new Atom(new Wget()));
        env.setPrimitive("net:fetch", new Atom(new Fetch()));
        env.setPrimitive("net:client", new Atom(new NetClient()));
        env.setPrimitive("net:client-ssl", new Atom(new NetClientSSL()));
        env.setPrimitive("net:server", new Atom(new NetServer()));
        env.setPrimitive("net:server-ssl", new Atom(new NetServerSSL()));
        env.setPrimitive("net:http-server-builder", new Atom(new HTTPServer()));
        env.setPrimitive("net:http-path-handler", new Atom(new PathHandler()));
        env.setPrimitive("net:http-literal-handler", new Atom(new LiteralHandler()));
        env.setPrimitive("net:http-routing-handler", new Atom(new RoutingHandler()));
        env.setPrimitive("net:http-redirect-handler", new Atom(new RedirectHandler()));
        env.setPrimitive("net:http-resource-handler", new Atom(new ResourceHandler()));

        env.setPrimitive("cmpx", new Atom(new Cmpx()));
        env.setPrimitive("import", "○←⍫", new Atom(new Import()));
        env.setPrimitive("exit", "→⋄", new Atom(new Exit()));
    }
}
