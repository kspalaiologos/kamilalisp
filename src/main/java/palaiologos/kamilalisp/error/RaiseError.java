package palaiologos.kamilalisp.error;

public class RaiseError extends Error {
    public String id;

    public RaiseError() {
    }

    public RaiseError(String message) {
        super(message);
    }

    public RaiseError(String id, String message) {
        super(message);
        this.id = id;
    }
}
