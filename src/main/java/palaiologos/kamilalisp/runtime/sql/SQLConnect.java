package palaiologos.kamilalisp.runtime.sql;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.hashmap.HashMapUserData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class SQLConnect extends PrimitiveFunction implements Lambda {
    @Override
    public Atom apply(Environment env, List<Atom> args) {
        if(args.size() == 1) {
            String url = args.get(0).getString();
            try {
                Connection conn = DriverManager.getConnection(url);
                return new Atom(new SQLConnectionUserdata(conn));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else if(args.size() == 2) {
            String url = args.get(0).getString();
            Map<Atom, Atom> options = args.get(1).getUserdata(HashMapUserData.class).value();
            Properties connectionProps = new Properties();
            for(Map.Entry<Atom, Atom> entry : options.entrySet()) {
                connectionProps.put(entry.getKey().getString(), entry.getValue().getString());
            }
            try {
                Connection conn = DriverManager.getConnection(url, connectionProps);
                return new Atom(new SQLConnectionUserdata(conn));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            throw new RuntimeException("sql:connect - wrong number of arguments");
        }
    }

    @Override
    protected String name() {
        return "sql:connect";
    }
}
