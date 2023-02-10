package palaiologos.kamilalisp.runtime.parallel.actor;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class ActorCreate extends PrimitiveFunction implements SpecialForm, ReactiveFunction {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        return new Atom(new ActorUserData());
    }

    @Override
    protected String name() {
        return "parallel:actor";
    }
}
