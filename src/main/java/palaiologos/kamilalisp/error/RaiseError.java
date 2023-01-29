package palaiologos.kamilalisp.error;

import palaiologos.kamilalisp.atom.Identifier;

public class RaiseError extends Error {
    public Identifier id;

    public RaiseError() {
        super();
    }

    public RaiseError(String message) {
        super(message);
    }

    public RaiseError(Identifier id, String message) {
        super(message);
        this.id = id;
    }
}
