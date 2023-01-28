package palaiologos.kamilalisp.error;

public class RaiseError extends Error {
    public RaiseError() {
        super();
    }

    public RaiseError(String message) {
        super(message);
    }
}
