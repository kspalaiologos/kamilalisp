package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;

import java.util.List;

public class Match extends PrimitiveFunction implements SpecialForm {
    @Override
    protected String name() {
        return "match";
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        /*
         * Some usage examples:
         *
         * Use match to compute length using LITERAL match.
         * (defun length (list)
         *   (match list
         *     (('x 'xs...) (+ 1 \length xs))
         *     (nil 0)))
         *
         * Use match to evaluate SKI combinator calculus.
         * (defun ski (x)
         *   (match x
         *     ((S 'x 'y 'z) (tie (tie x z) (tie y z)))
         *     ((K 'x 'y) x)
         *     ((I 'x) x)
         *     (('x 'y) (tie (ski x) (ski y)))
         *     ('x x)))
         *
         * Use match with guards:
         * (defun is-even (x)
         *   (match x
         *     ('x (= 0 (% x 2)) true)
         *     ('_ false)))
         *
         * More examples pending...
         */
        Atom matchedAtom = Evaluation.evaluate(env, args.get(0));
        List<Atom> clauses = args.subList(1, args.size());
        return null;
    }
}
