package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Cwd extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(Wd.get().getAbsolutePath());
    }

    @Override
    protected String name() {
        return "sh:cwd";
    }
}
