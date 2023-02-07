package palaiologos.kamilalisp.repl;

import org.jline.reader.Candidate;
import org.jline.reader.Completer;
import org.jline.reader.LineReader;
import org.jline.reader.ParsedLine;
import palaiologos.kamilalisp.atom.Environment;

import java.util.List;
import java.util.Set;

class LispCompletion implements Completer {
    private Environment refGlobEnv;

    public LispCompletion(Environment env) {
        refGlobEnv = env;
    }

    private Set<String> getKeywords() {
        return refGlobEnv.keys();
    }

    @Override
    public void complete(LineReader reader, ParsedLine commandLine, List<Candidate> candidates) {
        candidates.addAll(getKeywords().stream().map(Candidate::new).toList());
    }
}
