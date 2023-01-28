package palaiologos.kamilalisp.error;

import palaiologos.kamilalisp.atom.Identifier;

public class RaiseError extends Error {
    public RaiseError() {
        super();
    }

    public RaiseError(String message) {
        super(message);
    }

    public Identifier id;

    public RaiseError(Identifier id, String message) {
        super(message);
        this.id = id;
    }
}
