package palaiologos.kamilalisp.runtime;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.runtime.array.hof.*;
import palaiologos.kamilalisp.runtime.array.sais.SacaBwt;
import palaiologos.kamilalisp.runtime.array.sais.SacaSais;
import palaiologos.kamilalisp.runtime.array.sais.SacaUnbwt;
import palaiologos.kamilalisp.runtime.cas.*;
import palaiologos.kamilalisp.runtime.dataformat.*;
import palaiologos.kamilalisp.runtime.dataformat.digest.*;
import palaiologos.kamilalisp.runtime.datetime.*;
import palaiologos.kamilalisp.runtime.graph.*;
import palaiologos.kamilalisp.runtime.hashmap.*;
import palaiologos.kamilalisp.runtime.lib.*;
import palaiologos.kamilalisp.runtime.math.*;
import palaiologos.kamilalisp.runtime.math.bit.*;
import palaiologos.kamilalisp.runtime.math.cmp.*;
import palaiologos.kamilalisp.runtime.math.hyperbolic.*;
import palaiologos.kamilalisp.runtime.math.num.*;
import palaiologos.kamilalisp.runtime.math.trig.*;
import palaiologos.kamilalisp.runtime.meta.*;
import palaiologos.kamilalisp.runtime.net.*;
import palaiologos.kamilalisp.runtime.parallel.Daemon;
import palaiologos.kamilalisp.runtime.parallel.Task;
import palaiologos.kamilalisp.runtime.parallel.actor.ActorCreate;
import palaiologos.kamilalisp.runtime.regex.RegexMatches;
import palaiologos.kamilalisp.runtime.regex.RegexReplace;
import palaiologos.kamilalisp.runtime.regex.RegexSplit;
import palaiologos.kamilalisp.runtime.string.*;

public class FunctionRegistry {
    public static void registerDefault(Environment env, boolean sandboxed) {
        BaseLib.register(env);
        Flt64Lib.register(env);
        if(!sandboxed)
            SystemLib.register(env);
        AbstractStreamLib.register(env);
        AlgorithmLib.register(env);
        MathLib.register(env);
    }
}
