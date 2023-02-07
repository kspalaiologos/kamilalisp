package palaiologos.kamilalisp.runtime.dataformat;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import java.io.StringWriter;
import java.util.List;

public class CsvWrite extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        StringWriter sw = new StringWriter();
        try {
            CSVPrinter printer = new CSVPrinter(sw, CSVFormat.DEFAULT);
            for (Atom row : args.get(0).getList()) {
                List<Atom> rowList = row.getList();
                String[] rowArray = new String[rowList.size()];
                for (int i = 0; i < rowList.size(); i++) {
                    rowArray[i] = rowList.get(i).getString();
                }
                printer.printRecord((Object[]) rowArray);
            }
            printer.flush();
            printer.close();
            return new Atom(sw.toString(), false);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected String name() {
        return "csv:write";
    }
}
