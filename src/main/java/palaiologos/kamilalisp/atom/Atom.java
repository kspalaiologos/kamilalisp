package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;
import com.google.common.base.Strings;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.Index;

import javax.annotation.Nonnull;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class Atom implements Comparable<Atom> {
    public static Atom NULL = new Atom();
    public static Atom TRUE = new Atom(true);
    public static Atom FALSE = new Atom(false);
    @Nonnull
    private Object data;
    private Type type;

    public Atom() {
        this.data = List.of();
        this.type = Type.LIST;
    }

    public Atom(String data) {
        this.data = data;
        this.type = Type.STRING;
    }

    public Atom(BigDecimal data) {
        if (data.scale() <= 0 || data.stripTrailingZeros().scale() <= 0) {
            this.data = data.toBigInteger();
            this.type = Type.INTEGER;
        } else {
            this.data = data;
            this.type = Type.REAL;
        }
    }

    public Atom(Userdata u) {
        this.data = u;
        this.type = Type.USERDATA;
    }

    public Atom(BigInteger data) {
        this.data = data;
        this.type = Type.INTEGER;
    }

    public Atom(BigComplex data) {
        if (!data.isReal()) {
            this.data = data;
            this.type = Type.COMPLEX;
        } else {
            if (data.re.scale() <= 0 || data.re.stripTrailingZeros().scale() <= 0) {
                this.data = data.re.toBigInteger();
                this.type = Type.INTEGER;
            } else {
                this.data = data.re;
                this.type = Type.REAL;
            }
        }
    }

    public Atom(List<Atom> data) {
        this.data = data;
        this.type = Type.LIST;
    }

    public Atom(boolean data) {
        this.data = data ? BigInteger.valueOf(1) : BigInteger.valueOf(0);
        this.type = Type.INTEGER;
    }

    public Atom(Callable data) {
        if (data instanceof ReactiveFunction) {
            this.type = Type.LIST;
            Atom contents = new Atom();
            contents.type = Type.CALLABLE;
            contents.data = data;
            this.data = List.of(contents);
        } else {
            this.data = data;
            this.type = Type.CALLABLE;
        }
    }

    public Atom(Identifier data) {
        this.data = data;
        this.type = Type.IDENTIFIER;
    }

    public Type getType() {
        return type;
    }

    private String typeString() {
        return switch (type) {
            case INTEGER -> "integer";
            case REAL -> "real";
            case COMPLEX -> "complex";
            case STRING -> "string";
            case LIST -> "list";
            case CALLABLE -> "callable";
            case IDENTIFIER -> "identifier";
            case USERDATA -> "userdata " + ((Userdata) data).typeName();
            default -> "unknown";
        };
    }

    public String getString() {
        if (getType() != Type.STRING) {
            throw new TypeError("Cannot get string from non-string atom " + typeString());
        }

        return (String) data;
    }

    public Userdata getUserdata() {
        if (getType() != Type.USERDATA) {
            throw new TypeError("Cannot get userdata from non-userdata atom " + typeString());
        }

        return (Userdata) data;
    }

    public <T extends Userdata> T getUserdata(Class<T> type) {
        if (getType() != Type.USERDATA)
            throw new TypeError("Cannot get userdata from non-userdata atom " + typeString());

        if (!type.isInstance(data))
            throw new TypeError("Cannot get desired userdata from atom of type " + ((Userdata) data).typeName());

        return type.cast(data);
    }

    public boolean isUserdata(Class<? extends Userdata> type) {
        if (getType() != Type.USERDATA)
            return false;

        return type.isInstance(data);
    }

    public BigDecimal getReal() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }

        if (getType() == Type.INTEGER) {
            return new BigDecimal((BigInteger) data);
        } else if (getType() == Type.REAL) {
            return (BigDecimal) data;
        } else if (getType() == Type.COMPLEX) {
            return ((BigComplex) data).re;
        } else {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }
    }

    public List<Atom> getList() {
        if (getType() == Type.STRING) {
            return ((String) data).chars().mapToObj(c -> new Atom(String.valueOf((char) c))).collect(Collectors.toList());
        }

        if (getType() != Type.LIST) {
            throw new TypeError("Cannot get list from non-list atom " + typeString());
        }

        return (List<Atom>) data;
    }

    public BigInteger getInteger() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }

        if (getType() == Type.REAL) {
            return ((BigDecimal) data).toBigInteger();
        } else if (getType() == Type.COMPLEX) {
            return ((BigComplex) data).re.toBigInteger();
        } else if (getType() == Type.INTEGER) {
            return (BigInteger) data;
        } else {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }
    }

    public Callable getCallable() {
        if (getType() != Type.CALLABLE) {
            throw new TypeError("Cannot get callable object from non-callable atom" + (getType() == Type.IDENTIFIER ? " (" + Identifier.of(getIdentifier()) + " not bound?)" : ""));
        }

        return (Callable) data;
    }

    public Identifier getIdentifier() {
        if (getType() != Type.IDENTIFIER) {
            throw new TypeError("Cannot get identifier from non-identifier atom " + typeString());
        }

        return (Identifier) data;
    }

    public BigComplex getComplex() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get complex from non-complex atom " + typeString());
        }

        if (getType() == Type.COMPLEX) {
            return (BigComplex) data;
        } else if (getType() == Type.REAL) {
            return BigComplex.valueOf(getReal());
        } else if (getType() == Type.INTEGER) {
            return BigComplex.valueOf(new BigDecimal(getInteger()));
        } else {
            throw new TypeError("Cannot get complex from non-complex atom " + typeString());
        }
    }

    public boolean isNumeric() {
        return getType() == Type.REAL || getType() == Type.COMPLEX || getType() == Type.INTEGER;
    }

    @Override
    public String toString() {
        switch (getType()) {
            case STRING:
                return "\"" + getString() + "\"";
            case REAL:
                String s = getReal().toString();
                if (s.contains(".")) return s;
                return s + ".";
            case LIST:
                if (getList().isEmpty())
                    return "nil";
                if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).toString();
                else if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).toString() + "[" + getList().stream().skip(1).map(Atom::toString).collect(Collectors.joining(" ")) + "]";
                return "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")";
            case CALLABLE:
                return getCallable().stringify();
            case IDENTIFIER:
                return Identifier.of(getIdentifier());
            case INTEGER:
                return getInteger().toString();
            case COMPLEX:
                return getComplex().re.toString() + "J" + getComplex().im.toString();
            case USERDATA:
                return getUserdata().toString();
            default:
                throw new IllegalArgumentException();
        }
    }

    public String toDisplayString() {
        switch (getType()) {
            case STRING:
                return getString();
            case REAL:
                String s = getReal().toString();
                if (s.contains(".")) return s;
                return s + ".";
            case INTEGER:
                return getInteger().toString();
            case LIST:
                if (getList().isEmpty())
                    return "nil";
                if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).toString();
                else if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).toString() + "$[" + getList().stream().skip(1).map(Atom::toString).collect(Collectors.joining(" ")) + "]";
                if (getList().stream().allMatch(x -> x.getType().equals(Type.LIST))) {
                    int len = getList().get(0).getList().size();
                    if (getList().stream().allMatch(x -> x.getList().size() == len)
                            && getList().stream().allMatch(x -> x.getList().stream().allMatch(Atom::isNumeric))) {
                        // Square matrix.
                        // Find the longest representation in each column.
                        int[] max = new int[len];
                        for (int i = 0; i < len; i++) {
                            for (Atom row : getList()) {
                                max[i] = Math.max(max[i], row.getList().get(i).toDisplayString().length());
                            }
                        }
                        for (int i = 0; i < len; i++) {
                            if (max[i] > 20) {
                                // Back to normal display, that wouldn't work otherwise.
                                return "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")";
                            }
                        }
                        StringBuilder b = new StringBuilder();
                        b.append("[[");
                        List<Atom> cur = getList().get(0).getList();
                        for (int i = 0; i < cur.size(); i++) {
                            b.append(Strings.padStart(cur.get(i).toString(), max[i], ' ')).append(i == cur.size() - 1 ? "" : " ");
                        }
                        b.append("]");
                        for (int i = 1; i < getList().size(); i++) {
                            cur = getList().get(i).getList();
                            b.append("\n [");
                            for (int j = 0; j < cur.size(); j++) {
                                b.append(Strings.padStart(cur.get(j).toString(), max[j], ' ')).append(j == cur.size() - 1 ? "" : " ");
                            }
                            b.append("]");
                        }
                        b.append("]");
                        return b.toString();
                    }
                }
                return "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")";
            case CALLABLE:
                return getCallable().stringify();
            case IDENTIFIER:
                return Identifier.of(getIdentifier());
            case COMPLEX:
                return getComplex().re.toString() + "J" + getComplex().im.toString();
            case USERDATA:
                return getUserdata().toDisplayString();
            default:
                throw new IllegalArgumentException();
        }
    }

    public String shortString() {
        switch (getType()) {
            case STRING:
                return "\"" + getString() + "\"";
            case REAL:
                String s = getReal().toString();
                if (s.contains(".")) return s;
                return s + ".";
            case INTEGER:
                return getInteger().toString();
            case LIST:
                if (getList().isEmpty())
                    return "nil";
                if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).shortString();
                else if (getList().get(0).getType() == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).shortString() + "[" + getList().stream().skip(1).map(Atom::shortString).collect(Collectors.joining(" ")) + "]";
                return "(" + getList().stream().limit(2).map(Atom::toString).collect(Collectors.joining(" ")) + (getList().size() > 2 ? " ..." : "") + ")";
            case CALLABLE:
                return "(sic) " + getCallable().frameString() + ".";
            case IDENTIFIER:
                return Identifier.of(getIdentifier());
            case COMPLEX:
                return getComplex().re.toString() + "J" + getComplex().im.toString();
            case USERDATA:
                String ud = getUserdata().toDisplayString();
                if (ud.length() > 20) ud = ud.substring(0, 20) + "...";
                return ud;
            default:
                throw new IllegalArgumentException();
        }
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Atom other) {
            if (isNumeric() && other.isNumeric()) {
                if (getType() == Type.REAL && other.getType() == Type.REAL)
                    return getReal().equals(other.getReal());
                else if (getType() == Type.INTEGER && other.getType() == Type.INTEGER)
                    return getInteger().equals(other.getInteger());
                else if (getType() == Type.COMPLEX && other.getType() == Type.COMPLEX)
                    return getComplex().equals(other.getComplex());
                else if (getType() == Type.REAL && other.getType() == Type.INTEGER)
                    return getReal().equals(new BigDecimal(other.getInteger()));
                else if (getType() == Type.INTEGER && other.getType() == Type.REAL)
                    return new BigDecimal(getInteger()).equals(other.getReal());
                else if (getType() == Type.REAL && other.getType() == Type.COMPLEX)
                    return other.getComplex().equals(BigComplex.valueOf(getReal()));
                else if (getType() == Type.COMPLEX && other.getType() == Type.REAL)
                    return BigComplex.valueOf(other.getReal()).equals(getComplex());
                else if (getType() == Type.INTEGER && other.getType() == Type.COMPLEX)
                    return other.getComplex().equals(BigComplex.valueOf(new BigDecimal(getInteger())));
                else if (getType() == Type.COMPLEX && other.getType() == Type.INTEGER)
                    return BigComplex.valueOf(new BigDecimal(other.getInteger())).equals(getComplex());
                else
                    throw new IllegalStateException();
            }
            if (getType() != other.getType()) {
                return false;
            }
            switch (getType()) {
                case STRING -> {
                    return getString().equals(other.getString());
                }
                case REAL -> {
                    return getReal().equals(other.getReal());
                }
                case LIST -> {
                    List<Atom> l1 = getList();
                    List<Atom> l2 = other.getList();
                    if (l1.size() != l2.size()) {
                        return false;
                    }
                    for (int i = 0; i < l1.size(); i++) {
                        if (!l1.get(i).equals(l2.get(i))) {
                            return false;
                        }
                    }
                    return true;
                }
                case CALLABLE -> {
                    return getCallable().equals(other.getCallable());
                }
                case IDENTIFIER -> {
                    return Identifier.of(getIdentifier()).equals(Identifier.of(other.getIdentifier()));
                }
                case COMPLEX -> {
                    return getComplex().equals(other.getComplex());
                }
                case INTEGER -> {
                    return getInteger().equals(other.getInteger());
                }
                case USERDATA -> {
                    return getUserdata().equals(other.getUserdata());
                }
            }
        }
        return false;
    }

    public boolean coerceBool() {
        return switch (getType()) {
            case STRING -> !getString().isEmpty();
            case REAL -> !getReal().equals(BigDecimal.ZERO);
            case LIST -> !getList().isEmpty();
            case CALLABLE, IDENTIFIER -> true;
            case COMPLEX -> !getComplex().equals(BigComplex.ZERO);
            case INTEGER -> !getInteger().equals(BigInteger.ZERO);
            case USERDATA -> getUserdata().coerceBoolean();
        };
    }

    public void assertTypes(Type... types) {
        for (Type type : types) {
            if (getType() == type) {
                return;
            }
        }
        if (types.length == 1) {
            throw new TypeError("Expected " + types[0] + ", got " + getType());
        } else {
            throw new TypeError("Expected one of " + List.of(types) + ", got " + getType());
        }
    }

    @Override
    public int hashCode() {
        return Objects.hash(type, data);
    }

    @Override
    public int compareTo(Atom a) {
        if (a == null)
            return 1;

        if ((getType() == Type.REAL || getType() == Type.INTEGER) && (a.getType() == Type.REAL || a.getType() == Type.INTEGER)) {
            return getReal().compareTo(a.getReal());
        } else if (isNumeric() && a.isNumeric()) {
            return getComplex().abs(MathContext.DECIMAL128).compareTo(a.getComplex().abs(MathContext.DECIMAL128));
        } else if (getType() == Type.STRING && a.getType() == Type.STRING) {
            return getString().compareTo(a.getString());
        } else if (getType() == Type.LIST && a.getType() == Type.LIST) {
            List<Atom> l1 = getList();
            List<Atom> l2 = a.getList();
            if (l1.size() != l2.size()) {
                return l1.size() - l2.size();
            }
            for (int i = 0; i < l1.size(); i++) {
                int c = l1.get(i).compareTo(l2.get(i));
                if (c != 0) {
                    return c;
                }
            }
            return 0;
        } else if (getType() == Type.IDENTIFIER && a.getType() == Type.IDENTIFIER) {
            return Identifier.of(getIdentifier()).compareTo(Identifier.of(a.getIdentifier()));
        } else if (getType() == Type.CALLABLE && a.getType() == Type.CALLABLE) {
            return Integer.valueOf(getCallable().hashCode()).compareTo(a.getCallable().hashCode());
        } else if (getType() == Type.USERDATA && a.getType() == Type.USERDATA) {
            return getUserdata().compareTo(a.getUserdata());
        } else {
            return getType().ordinal() - a.getType().ordinal();
        }
    }

    public Atom dot(Object index) {
        if (getType() == Type.STRING) {
            if (index instanceof Integer) {
                return new Atom(String.valueOf(getString().charAt((Integer) index)));
            } else {
                throw new TypeError("Expected integer index.");
            }
        } else if (getType() == Type.LIST) {
            if (index instanceof Integer) {
                return getList().get((Integer) index);
            } else if(index instanceof String) {
                switch((String) index) {
                    case "size" -> {
                        return new Atom(BigInteger.valueOf(getList().size()));
                    }
                    case "isEmpty" -> {
                        return getList().isEmpty() ? TRUE : FALSE;
                    }
                    case "toString" -> {
                        return new Atom(getList().toString());
                    }
                    case "car" -> {
                        if(getList().isEmpty())
                            throw new TypeError("Cannot get car of empty list.");
                        return getList().get(0);
                    }
                    case "cdr" -> {
                        if(getList().isEmpty())
                            return Atom.NULL;
                        return new Atom(getList().subList(1, getList().size()));
                    }
                    default -> throw new TypeError("Unknown list method: " + index);
                }
            } else {
                throw new TypeError("Expected integer index.");
            }
        } else if (getType() == Type.USERDATA) {
            return getUserdata().field(index);
        } else {
            throw new TypeError("Expected string or list.");
        }
    }
}
