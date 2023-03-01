package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Match extends PrimitiveFunction implements SpecialForm {
    private static boolean isIdInPattern(Atom a) {
        if (a.getType() != Type.LIST)
            return false;
        if (a.getList().size() != 1)
            return false;
        if (a.getList().get(0).getType() != Type.CALLABLE)
            return false;
        return a.getList().get(0).getCallable() instanceof Quote;
    }

    private static String getIdFromPattern(Atom a) {
        Callable c = a.getList().get(0).getCallable();
        return c.apply(null, null).getIdentifier();
    }

    private static boolean match(Atom a, Atom pat, Environment env) {
        // Check if pat is a quoted variable.
        if (isIdInPattern(pat)) {
            String id = getIdFromPattern(pat);
            env.set(id, a);
            return true;
        }

        // Check if pat is a list.
        if (pat.getType() == Type.LIST) {
            // Ok. Try to match the lists together.
            // Notice that the pattern list can end with an identifier
            // that starts with three dots "..." - this means that the identifier
            // will be bound to the rest of the list.
            if (a.getType() != Type.LIST)
                return false;

            List<Atom> patList = pat.getList();
            List<Atom> aList = a.getList();
            int len = Math.max(patList.size(), aList.size());
            for (int i = 0; i < len; i++) {
                if (patList.size() < i + 1)
                    return false;
                Atom patternAtom = patList.get(i);
                if (isIdInPattern(patternAtom)) {
                    String s = getIdFromPattern(patternAtom);
                    if (s.startsWith("...")) {
                        // This is the last element of the pattern list.
                        // Bind the identifier to the rest of the list.
                        env.set(s.substring(3), new Atom(aList.subList(i, aList.size())));
                        return true;
                    }
                }
                if (aList.size() < i + 1)
                    return false;
                if (!match(aList.get(i), patList.get(i), env))
                    return false;
            }
            return true;
        } else {
            // No idea. Match if a == pat.
            return a.equals(pat);
        }
    }

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
         *     (('x '...xs) (+ 1 \length xs))
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
        for (Atom clause : clauses) {
            if (clause.getType() != Type.LIST) {
                throw new TypeError("Clause must be a list.");
            }
            List<Atom> clauseList = clause.getList();
            Atom pattern = null, condition = null, result = null;

            if (clauseList.size() == 2) {
                pattern = clauseList.get(0);
                result = clauseList.get(1);
            } else if (clauseList.size() == 3) {
                pattern = clauseList.get(0);
                condition = clauseList.get(1);
                result = clauseList.get(2);
            } else {
                throw new TypeError("Clause must have 2 or 3 elements.");
            }

            // Check if matchedAtom is like pattern.
            Environment newEnv = new Environment(env);
            if (match(matchedAtom, pattern, newEnv)) {
                if (condition == null || Evaluation.evaluate(newEnv, condition).coerceBool()) {
                    return Evaluation.evaluate(newEnv, result);
                }
            }
        }

        throw new TypeError("Inexhaustive match. Object `" + matchedAtom + "` did not match any clause.");
    }
}
