package palaiologos.kamilalisp.runtime.cas;

public class EvaluationResult {
    private boolean wasSuccessful;
    private String result;
    private String type;

    public EvaluationResult(boolean successful, String text, String type) {
        this.wasSuccessful = successful;
        this.result = text;
        this.type = type;
    }

    public boolean isSuccessful() {
        return wasSuccessful;
    }

    public String getResult() {
        return result;
    }

    public String getType() {
        return type;
    }
}
