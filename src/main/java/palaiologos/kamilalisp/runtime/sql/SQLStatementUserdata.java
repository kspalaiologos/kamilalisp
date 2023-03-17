package palaiologos.kamilalisp.runtime.sql;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

public class SQLStatementUserdata implements Userdata {
    private final Statement stmt;

    public SQLStatementUserdata(Statement stmt) {
        this.stmt = stmt;
    }

    @Override
    public int hashCode() {
        return stmt.hashCode();
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String keyStr))
            throw new TypeError("sql:statement - key must be a string");
        switch (keyStr) {
            case "set-timeout": return new Atom(new SetTimeout());
            case "set-max-rows": return new Atom(new SetMaxRows());
        }
    }

    @Override
    public String toDisplayString() {
        return "sql:statement";
    }

    @Override
    public String typeName() {
        return "sql:statement";
    }

    private class SetTimeout extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            int timeout = args.get(0).getInteger().intValueExact();
            try {
                stmt.setQueryTimeout(timeout);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "sql:statement.set-timeout";
        }
    }

    private class SetMaxRows extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            int maxRows = args.get(0).getInteger().intValueExact();
            try {
                stmt.setMaxRows(maxRows);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "sql:statement.set-max-rows";
        }
    }
}
