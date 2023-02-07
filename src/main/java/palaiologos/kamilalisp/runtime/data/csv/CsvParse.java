package palaiologos.kamilalisp.runtime.data.csv;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import palaiologos.kamilalisp.atom.*;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class CsvParse extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        Atom arg = args.get(0);
        String csvdata = null;

        if(arg.getType() == Type.LIST) {
            // Assume a buffer.
            byte[] data = new byte[arg.getList().size()];
            for (int i = 0; i < arg.getList().size(); i++)
                data[i] = arg.getList().get(i).getInteger().byteValueExact();
            csvdata = new String(data, StandardCharsets.UTF_8);
        } else if(arg.getType() == Type.STRING) {
            // Assume a string.
            csvdata = arg.getString();
        } else {
            throw new RuntimeException("csv:parse not defined for: " + arg.getType());
        }

        Reader in = new StringReader(csvdata);
        List<Atom> data = new ArrayList<>();
        try {
            for(CSVRecord record : CSVFormat.DEFAULT.parse(in)) {
                List<Atom> row = new ArrayList<>();
                for(String field : record) {
                    row.add(new Atom(field));
                }
                data.add(new Atom(row));
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return new Atom(data);
    }

    @Override
    protected String name() {
        return "csv:parse";
    }
}
