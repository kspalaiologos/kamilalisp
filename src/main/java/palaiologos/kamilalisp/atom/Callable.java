package palaiologos.kamilalisp.atom;

import java.util.List;

public interface Callable {
    String stringify();
    String frameString();

    Atom apply(Environment env, List<Atom> args);
    int line();
    int column();
}
