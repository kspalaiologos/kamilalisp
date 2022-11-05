package palaiologos.kamilalisp.repl;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Parser;

import java.util.List;

public class Test {
    public static void main(String[] args) {
        Environment env = Environment.defaultEnvironment();
        List<Atom> a = Parser.parse("(+ 2 2)");
        System.out.println(a.get(0).getType());
        System.out.println(a.get(0).getList());
    }
}
