package palaiologos.kamilalisp.runtime.sql;

import palaiologos.kamilalisp.atom.*;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.datetime.DateTime;

import java.lang.reflect.Parameter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URL;
import java.sql.*;
import java.time.Duration;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SQLPreparedStatementUserdata implements Userdata {
    private final PreparedStatement stmt;
    private final ParameterMetaData parameterMetaData;

    public SQLPreparedStatementUserdata(PreparedStatement stmt) {
        this.stmt = stmt;
        try {
            this.parameterMetaData = stmt.getParameterMetaData();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int hashCode() {
        return stmt.hashCode();
    }

    @Override
    public Atom field(Object key) {
        if(key instanceof String keyStr) {
            switch (keyStr) {
                case "set-timeout":
                    return new Atom(new SetTimeout());
                case "set-max-rows":
                    return new Atom(new SetMaxRows());
                case "execute":
                    return new Atom(new Execute());
                case "execute-query":
                    return new Atom(new ExecuteQuery());
                case "execute-update":
                    return new Atom(new ExecuteUpdate());
                default:
                    throw new TypeError("sql:statement - unknown key: " + keyStr);
            }
        } else if(key instanceof Integer keyInt) {
            // Set n-th parameter.
            return new Atom(new SetParameter(keyInt));
        } else {
            throw new TypeError("sql:statement - key must be a string or an integer");
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

    private class SetParameter extends PrimitiveFunction implements Lambda {
        private final int index;

        public SetParameter(int index) {
            this.index = index;
        }

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            try {
                int type = parameterMetaData.getParameterType(index);
                switch(type) {
                    case Types.BIT -> {
                        boolean value = args.get(0).coerceBool();
                        synchronized (stmt.getConnection()) {
                            stmt.setBoolean(index, value);
                        }
                    }
                    case Types.TINYINT -> {
                        byte value = args.get(0).getInteger().byteValueExact();
                        synchronized (stmt.getConnection()) {
                            stmt.setByte(index, value);
                        }
                    }
                    case Types.SMALLINT -> {
                        short value = args.get(0).getInteger().shortValueExact();
                        synchronized (stmt.getConnection()) {
                            stmt.setShort(index, value);
                        }
                    }
                    case Types.INTEGER -> {
                        int value = args.get(0).getInteger().intValueExact();
                        synchronized (stmt.getConnection()) {
                            stmt.setInt(index, value);
                        }
                    }
                    case Types.BIGINT -> {
                        long value = args.get(0).getInteger().longValueExact();
                        synchronized (stmt.getConnection()) {
                            stmt.setLong(index, value);
                        }
                    }
                    case Types.FLOAT, Types.REAL -> {
                        float value = args.get(0).getReal().floatValue();
                        synchronized (stmt.getConnection()) {
                            stmt.setFloat(index, value);
                        }
                    }
                    case Types.DOUBLE -> {
                        double value = args.get(0).getReal().doubleValue();
                        synchronized (stmt.getConnection()) {
                            stmt.setDouble(index, value);
                        }
                    }
                    case Types.NUMERIC, Types.DECIMAL -> {
                        BigDecimal value = args.get(0).getReal();
                        synchronized (stmt.getConnection()) {
                            stmt.setBigDecimal(index, value);
                        }
                    }
                    case Types.CHAR, Types.VARCHAR, Types.LONGVARCHAR -> {
                        String value = args.get(0).getString();
                        synchronized (stmt.getConnection()) {
                            stmt.setString(index, value);
                        }
                    }
                    case Types.DATE -> {
                        Date value = Date.valueOf(args.get(0).getUserdata(DateTime.class).value().toLocalDate());
                        synchronized (stmt.getConnection()) {
                            stmt.setDate(index, value);
                        }
                    }
                    case Types.TIME -> {
                        if(args.get(0).isUserdata(DateTime.class)) {
                            Time value = Time.valueOf(args.get(0).getUserdata(DateTime.class).value().toLocalTime());
                            synchronized (stmt.getConnection()) {
                                stmt.setTime(index, value);
                            }
                        } else if(args.get(0).isUserdata(palaiologos.kamilalisp.runtime.datetime.Time.class)) {
                            Time value = Time.valueOf(LocalTime.of(0, 0, 0).plus(args.get(0).getUserdata(palaiologos.kamilalisp.runtime.datetime.Time.class).value()));
                            synchronized (stmt.getConnection()) {
                                stmt.setTime(index, value);
                            }
                        } else {
                            throw new TypeError("sql:statement.set-parameter - expected datetime or duration");
                        }
                    }
                    default -> throw new RuntimeException("sql:statement.set-parameter - unsupported type: " + parameterMetaData.getParameterTypeName(index));
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return Atom.NULL;
        }

        @Override
        protected String name() {
            return "sql:statement.set-parameter";
        }
    }

    private class SetTimeout extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 1);
            int timeout = args.get(0).getInteger().intValueExact();
            try {
                synchronized (stmt.getConnection()) {
                    stmt.setQueryTimeout(timeout);
                }
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
                synchronized (stmt.getConnection()) {
                    stmt.setMaxRows(maxRows);
                }
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

    private class Execute extends PrimitiveFunction implements Lambda {

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            boolean result;
            try {
                synchronized (stmt.getConnection()) {
                    result = stmt.execute();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return result ? Atom.TRUE : Atom.FALSE;
        }

        @Override
        protected String name() {
            return "sql:statement.execute";
        }
    }

    private class ExecuteUpdate extends PrimitiveFunction implements Lambda {

        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            int result;
            try {
                synchronized (stmt.getConnection()) {
                    result = stmt.executeUpdate();
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            return new Atom(BigInteger.valueOf(result));
        }

        @Override
        protected String name() {
            return "sql:statement.execute-update";
        }
    }

    private class ExecuteQuery extends PrimitiveFunction implements Lambda {
        @Override
        public Atom apply(Environment env, List<Atom> args) {
            assertArity(args, 0);
            ResultSet result;
            try {
                synchronized (stmt.getConnection()) {
                    result = stmt.executeQuery();
                }
                ResultSetMetaData metaData = result.getMetaData();
                int columnCount = metaData.getColumnCount();
                Atom[] headers = new Atom[columnCount];
                for (int i = 0; i < columnCount; i++) {
                    headers[i] = new Atom(metaData.getColumnName(i + 1));
                }
                List<Atom[]> table = new ArrayList<>();
                table.add(headers);
                while (result.next()) {
                    Atom[] row = new Atom[columnCount];
                    for (int i = 0; i < columnCount; i++) {
                        Object data = result.getObject(i + 1);
                        if (data instanceof BigInteger) {
                            row[i] = new Atom((BigInteger) data);
                        } else if (data instanceof String) {
                            row[i] = new Atom((String) data);
                        } else if (data instanceof BigDecimal) {
                            row[i] = new Atom((BigDecimal) data);
                        } else if (data instanceof Boolean) {
                            row[i] = (Boolean) data ? Atom.TRUE : Atom.FALSE;
                        } else if(data instanceof URL) {
                            row[i] = new Atom(data.toString());
                        } else if(data instanceof Date) {
                            row[i] = new Atom(new DateTime(((Date) data).toLocalDate().atTime(0, 0)));
                        } else if(data instanceof Time) {
                            row[i] = new Atom(new palaiologos.kamilalisp.runtime.datetime.Time(Duration.ofMillis(((Time) data).getTime())));
                        } else if(data instanceof Timestamp) {
                            row[i] = new Atom(new DateTime(((Timestamp) data).toLocalDateTime()));
                        } else if(data instanceof Double) {
                            row[i] = new Atom(BigDecimal.valueOf((Double) data));
                        } else if(data instanceof Float) {
                            row[i] = new Atom(BigDecimal.valueOf((Float) data));
                        } else if(data instanceof Integer) {
                            row[i] = new Atom(BigInteger.valueOf((Integer) data));
                        } else if(data instanceof Long) {
                            row[i] = new Atom(BigInteger.valueOf((Long) data));
                        } else if(data instanceof Byte) {
                            row[i] = new Atom(BigInteger.valueOf((Byte) data));
                        } else if (data == null) {
                            row[i] = Atom.NULL;
                        } else {
                            throw new RuntimeException("Unknown data type: " + data.getClass());
                        }
                    }
                    table.add(row);
                }
                return new Atom(table.stream().map(x -> new Atom(Arrays.asList(x))).toList());
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        protected String name() {
            return "sql:statement.execute-query";
        }
    }
}
