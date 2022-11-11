package palaiologos.kamilalisp.runtime.string;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.util.List;

public class Format extends PrimitiveFunction implements SpecialForm {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if (args.size() != 1) {
            throw new TypeError("Expected 1 argument to `str-format'.");
        }

        Atom a = args.get(0);

        if (a.getType() != Type.STRING) {
            throw new TypeError("Expected string constant as argument to `str-format'.");
        }

        String format = a.getString();

        // Evaluate the code between { and } in the format string.
        // Skip {{ and }}, output them verbatim.
        StringBuilder sb = new StringBuilder();
        int i = 0;
        while (i < format.length()) {
            if (format.charAt(i) == '{') {
                if (i + 1 < format.length() && format.charAt(i + 1) == '{') {
                    sb.append('{');
                    i += 2;
                } else {
                    int j = i + 1;
                    while (j < format.length() && format.charAt(j) != '}') {
                        j++;
                    }
                    if (j == format.length()) {
                        throw new TypeError("Expected `}' in format string.");
                    }
                    String code = format.substring(i + 1, j);
                    List<Atom> parsed = Parser.parse(code.startsWith("?") ? code.substring(1) : ("(" + code + "\n)"));
                    Atom expression = parsed.get(0);
                    Atom result = Evaluation.evaluate(env, expression);
                    sb.append(result);
                    i = j + 1;
                }
            } else if (format.charAt(i) == '}') {
                if (i + 1 < format.length() && format.charAt(i + 1) == '}') {
                    sb.append('}');
                    i += 2;
                } else {
                    throw new TypeError("Unexpected `}' in format string.");
                }
            } else {
                sb.append(format.charAt(i));
                i++;
            }
        }

        return new Atom(sb.toString());
    }

    @Override
    protected String name() {
        return "str-format";
    }
}
