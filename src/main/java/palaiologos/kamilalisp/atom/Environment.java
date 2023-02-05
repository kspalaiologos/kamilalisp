package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.runtime.FunctionRegistry;

import java.math.MathContext;
import java.util.HashMap;
import java.util.Set;

public class Environment {
    private final HashMap<String, Atom> data;
    private final Environment parent;

    public Environment() {
        data = new HashMap<>();
        parent = null;
    }

    public Environment(Environment parent) {
        data = new HashMap<>();
        this.parent = parent;
    }

    public static Environment defaultEnvironment() {
        Environment env = new Environment();
        FunctionRegistry.registerDefault(env);
        return env;
    }

    public void set(String key, Atom value) {
        data.put(key, value);
    }

    public void setp(String key, Atom value) {
        if (data.containsKey(key)) {
            throw new RuntimeException("Redefinition of built-in function " + key + ".");
        }
        data.put(key, value);
    }

    public void setp(String key, String altkey, Atom value) {
        if (data.containsKey(key)) {
            throw new RuntimeException("Redefinition of built-in function " + key + ".");
        }
        if (data.containsKey(altkey)) {
            throw new RuntimeException("Redefinition of built-in function " + altkey + ".");
        }
        data.put(key, value);
        data.put(altkey, value);
    }

    public Atom get(String key) {
        if (data.containsKey(key)) {
            return data.get(key);
        } else if (parent != null) {
            return parent.get(key);
        } else {
            return Atom.NULL;
        }
    }

    public Set<String> keys() {
        return data.keySet();
    }

    public boolean has(String key) {
        return data.containsKey(key) || (parent != null && parent.has(key));
    }

    public boolean isToplevel() {
        return parent == null;
    }

    public MathContext getMathContext() {
        int precision = get("fr").getReal().intValue();
        return new MathContext(precision);
    }
}
