package kamilalisp.libs;

import com.microsoft.z3.*;
import kamilalisp.api.Evaluation;
import kamilalisp.data.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class SATLib {
    public static void install(Environment env) {
        env.push("solve", new Atom(new Macro() {
            @Override
            public Atom apply(Executor env, List<Atom> arguments) {
                if(arguments.size() != 1) {
                    throw new Error("Invalid invocation to 'solve'.");
                }
                return new Atom(new LbcSupplier<>(() -> {
                    Context ctx = new Context();
                    String str = arguments.get(0).getList().get().stream().map(x -> x.toString()).collect(Collectors.joining(" "));
                    BoolExpr[] e = ctx.parseSMTLIB2String(str, null, null, null, null);
                    Solver s = ctx.mkSolver();
                    for (BoolExpr boolExpr : e)
                        s.add(boolExpr);
                    Status result = s.check();
                    if(result == Status.SATISFIABLE) {
                        Model m = s.getModel();
                        FuncDecl[] dC = m.getConstDecls();
                        FuncDecl[] dF = m.getFuncDecls();
                        List<Atom> results = new LinkedList<>();
                        for (FuncDecl funcDecl : dC) {
                            Expr x = m.getConstInterp(funcDecl);
                            results.add(new Atom(List.of(
                                    new Atom(new StringConstant(funcDecl.getName().toString())),
                                    Evaluation.evalString(env.env, x.getSExpr()).get(0))));
                        }
                        if(dF.length > 0)
                            throw new Error("'solve': yielding functions not yet supported.");
                        return results;
                    }
                    else if(result == Status.UNSATISFIABLE)
                        return new BigDecimal(0);
                    else
                        return new BigDecimal(-1);
                }));
            }
        }));
    }
}
