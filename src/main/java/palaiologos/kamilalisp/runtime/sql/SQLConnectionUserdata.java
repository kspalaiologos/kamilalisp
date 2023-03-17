package palaiologos.kamilalisp.runtime.sql;

import palaiologos.kamilalisp.atom.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class SQLConnectionUserdata implements Userdata {
    private final Connection conn;

    public SQLConnectionUserdata(Connection conn) {
        this.conn = conn;
    }

    @Override
    public int hashCode() {
        return conn.hashCode();
    }

    @Override
    public Atom field(Object key) {
        if(!(key instanceof String keyStr))
            throw new RuntimeException("sql:connection - field name must be a string");
        switch (keyStr) {
            case "statement":
                return new Atom(new SQLStatement());
            case "prepare-statement":
                return new Atom(new SQLPrepareStatement());
            case "close":
                return new Atom(new SQLClose());
            case "commit":
                return new Atom(new SQLCommit());
            default:
                throw new RuntimeException("sql:connection - no such field: " + keyStr);
        }
    }

    @Override
    public String toDisplayString() {
        return "sql:connection";
    }

    @Override
    public String typeName() {
        return "sql:connection";
    }

    private class SQLStatement extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            Callable callback = args.get(0).getCallable();
            Atom result;
            try(var stmt = conn.createStatement()) {
                result = callback.apply(env, List.of(new Atom(new SQLStatementUserdata(stmt))));
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            return result;
        }

        @Override
        protected String name() {
            return "sql:statement";
        }
    }

    private class SQLCommit extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            try {
                conn.commit();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "sql:commit";
        }
    }

    private class SQLPrepareStatement extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 2);
            Callable callback = args.get(1).getCallable();
            Atom result;
            try(var stmt = conn.prepareStatement(args.get(0).getString())) {
                result = callback.apply(env, List.of(new Atom(new SQLPreparedStatementUserdata(stmt))));
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            return result;
        }

        @Override
        protected String name() {
            return "sql:prepare-statement";
        }
    }

    private class SQLClose extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            try {
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "sql:close";
        }
    }
}
