package palaiologos.kamilalisp.repl;

import org.jline.reader.Candidate;
import org.jline.reader.Completer;
import org.jline.reader.LineReader;
import org.jline.reader.ParsedLine;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;
import java.util.Set;

public class LispCompletion implements Completer {
    private Environment refGlobEnv = null;

    public LispCompletion(Environment env) {
        refGlobEnv = env;
    }

    public Set<String> getKeywords() {
        return refGlobEnv.keys();
    }

    @Override
    public void complete(LineReader reader, final ParsedLine commandLine, final List<Candidate> candidates) {
        candidates.addAll(getKeywords().stream().map(Candidate::new).toList());
    }
}
