package palaiologos.kamilalisp.runtime.ide;

public class MultiLineTokenInfo {
    final int languageIndex;

    final int token;

    final String tokenStart;

    final String tokenEnd;

    public MultiLineTokenInfo(int languageIndex, int token, String tokenStart, String tokenEnd) {
        this.languageIndex = languageIndex;
        this.token = token;
        this.tokenStart = tokenStart;
        this.tokenEnd = tokenEnd;
    }
}
