package kamilalisp.data;

import java.util.List;

public interface Polynomial extends Closure {
    List<Atom> getCoefficients();
}
