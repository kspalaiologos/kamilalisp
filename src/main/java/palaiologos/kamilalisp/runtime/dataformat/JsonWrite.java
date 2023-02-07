package palaiologos.kamilalisp.runtime.dataformat;

import org.apache.commons.text.StringEscapeUtils;
import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.util.List;
import java.util.stream.Collectors;

public class JsonWrite extends PrimitiveFunction implements Lambda {
    private String makeJson(Atom a) {
        switch (a.getType()) {
            case LIST:
                return a.getList().stream().map(this::makeJson).collect(Collectors.joining(",", "[", "]"));
            case STRING:
                return "\"" + StringEscapeUtils.escapeJson(a.getString()) + "\"";
            case INTEGER:
                return a.getInteger().toString();
            case REAL:
                return a.getReal().toString();
            case IDENTIFIER: {
                String data = Identifier.of(a.getIdentifier());
                if (data.equalsIgnoreCase("true") || data.equalsIgnoreCase("false") || data.equalsIgnoreCase("null"))
                    return data;
                else
                    throw new RuntimeException("json:write not defined for literal: " + data);
            }
            case USERDATA: {
                HashMapUserData data = a.getUserdata(HashMapUserData.class);
                return data.value().entrySet().stream().map(entry -> {
                    return "\"" + StringEscapeUtils.escapeJson(entry.getKey().getString()) + "\":" + makeJson(entry.getValue());
                }).collect(Collectors.joining(",", "{", "}"));
            }
            default:
                throw new RuntimeException("json:write not defined for: " + a.getType());
        }
    }

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        return new Atom(makeJson(args.get(0)));
    }

    @Override
    protected String name() {
        return "json:write";
    }
}
