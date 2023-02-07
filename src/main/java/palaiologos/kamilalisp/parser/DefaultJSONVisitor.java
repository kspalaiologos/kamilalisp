package palaiologos.kamilalisp.parser;

import org.apache.commons.text.StringEscapeUtils;
import org.pcollections.HashPMap;
import org.pcollections.HashTreePMap;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Identifier;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;

public class DefaultJSONVisitor extends JSONBaseVisitor<Atom> {
    @Override public Atom visitJson(JSONParser.JsonContext ctx) { return visitChildren(ctx); }
    @Override public Atom visitObj(JSONParser.ObjContext ctx) {
        HashMap<Atom, Atom> map = new HashMap<>();
        for (JSONParser.PairContext pair : ctx.pair()) {
            String msg = pair.STRING().getText().substring(1, pair.STRING().getText().length() - 1);
            Atom key = new Atom(StringEscapeUtils.unescapeJson(msg));
            Atom value = visit(pair.value());
            map.put(key, value);
        }
        return new Atom(new HashMapUserData(HashTreePMap.from(map)));
    }
    @Override public Atom visitArr(JSONParser.ArrContext ctx) {
        return new Atom(ctx.value().stream().map(this::visit).toList());
    }
    @Override public Atom visitValue(JSONParser.ValueContext ctx) {
        if(ctx.arr() != null) return visit(ctx.arr());
        if(ctx.obj() != null) return visit(ctx.obj());
        if(ctx.STRING() != null) {
            String msg = ctx.STRING().getText().substring(1, ctx.STRING().getText().length() - 1);
            return new Atom(StringEscapeUtils.unescapeJson(msg));
        }
        if(ctx.NUMBER() != null) {
            String msg = ctx.NUMBER().getText();
            if(!msg.contains(".")) {
                return new Atom(new BigInteger(msg));
            } else {
                return new Atom(new BigDecimal(msg));
            }
        }
        if(ctx.TRUE() != null) return new Atom(Identifier.of("true"));
        if(ctx.FALSE() != null) return new Atom(Identifier.of("false"));
        if(ctx.NULL() != null) return new Atom(Identifier.of("null"));

        throw new RuntimeException("Unknown value: " + ctx.getText());
    }
}
