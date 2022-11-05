package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.runtime.FunctionRegistry;

import java.util.HashMap;

public class Environment {
    private HashMap<String, Atom> data;
    private Environment parent;

    public Environment() {
        data = new HashMap<>();
        parent = null;
    }

    public Environment(Environment parent) {
        data = new HashMap<>();
        this.parent = parent;
    }

    public void set(String key, Atom value) {
        data.put(key, value);
    }

    public Atom get(String key) {
        if(data.containsKey(key)) {
            return data.get(key);
        } else if(parent != null) {
            return parent.get(key);
        } else {
            return Atom.NULL;
        }
    }

    public boolean has(String key) {
        return data.containsKey(key) || (parent != null && parent.has(key));
    }

    public static Environment defaultEnvironment() {
        Environment env = new Environment();
        FunctionRegistry.registerDefault(env);
        return env;
    }

    public boolean isToplevel() {
        return parent == null;
    }
}
