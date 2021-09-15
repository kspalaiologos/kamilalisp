package kamilalisp.data;

import java.util.HashMap;

public class Environment {
    public HashMap<String, Atom> data = new HashMap<>();
    public Environment ancestor;
    public String name;
    public Atom owner;

    public Environment(String name) {
        this.name = name;
        this.ancestor = null;
    }

    public void push(String key, Atom value) {
        if(data.containsKey(key))
            data.replace(key, value);
        else
            data.put(key, value);
    }

    public Atom get(String key) {
        Environment currentEnv = this;

        while(currentEnv != null) {
            if(currentEnv.data.containsKey(key))
                return currentEnv.data.get(key);

            currentEnv = currentEnv.ancestor;
        }

        return Atom.NULL;
    }

    public boolean has(String key) {
        Environment currentEnv = this;

        while(currentEnv != null) {
            if(currentEnv.data.containsKey(key))
                return true;

            currentEnv = currentEnv.ancestor;
        }

        return false;
    }

    public Environment descendant(String name) {
        Environment env = new Environment(name);
        env.ancestor = this;
        return env;
    }

    public Environment getTopmostAncestor() {
        Environment cur = this;
        while(cur.ancestor != null)
            cur = cur.ancestor;
        return cur;
    }
}
