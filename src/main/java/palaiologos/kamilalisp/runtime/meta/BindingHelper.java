package palaiologos.kamilalisp.runtime.meta;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Identifier;
import palaiologos.kamilalisp.atom.Type;
import palaiologos.kamilalisp.repl.Main;

import java.util.List;

class BindingHelper {
    public static void bindingPatternMatch(Environment destEnv, Atom name, Atom value, boolean noBuiltinShadow) {
        if (name.getType() == Type.IDENTIFIER) {
            if (noBuiltinShadow && Main.isBuiltin(Identifier.of(name.getIdentifier()))) {
                throw new RuntimeException("Cannot shadow builtin function " + name.toDisplayString() + ".");
            }
            destEnv.set(Identifier.of(name.getIdentifier()), value);
        } else if (name.getType() == Type.LIST) {
            List<Atom> nameList = name.getList();
            List<Atom> valueList = value.getList();
            if (nameList.size() != valueList.size()) {
                throw new RuntimeException("Binding pattern match failed: list sizes do not match.");
            }

            for (int i = 0; i < nameList.size(); i++) {
                bindingPatternMatch(destEnv, nameList.get(i), valueList.get(i), noBuiltinShadow);
            }
        } else {
            if (!name.equals(value)) {
                throw new RuntimeException("Binding pattern match failed: atoms " + name.toDisplayString() + " and " + value.toDisplayString() + " do not match.");
            }
        }
    }
}
