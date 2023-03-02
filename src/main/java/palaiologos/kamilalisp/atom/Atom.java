package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.error.TypeError;
import palaiologos.kamilalisp.runtime.meta.Index;

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
    Object data;
    Type type;

    protected Atom() {
        this.data = List.of();
        this.type = Type.LIST;
    }

    public Atom(@Nonnull String data, boolean isSymbol) {
        if(isSymbol) {
            this.type = Type.IDENTIFIER;
            this.data = data.intern();
        } else {
            this.type = Type.STRING;
            this.data = data;
        }
    }

    public Atom(@Nonnull String data) {
        this.data = data;
        this.type = Type.STRING;
    }

    public Atom(@Nonnull BigDecimal data) {
        if (data.scale() <= 0 || data.stripTrailingZeros().scale() <= 0) {
            this.data = data.toBigInteger();
            this.type = Type.INTEGER;
        } else {
            this.data = data;
            this.type = Type.REAL;
        }
    }

    public Atom(@Nonnull Userdata u) {
        this.data = u;
        this.type = Type.USERDATA;
    }

    public Atom(@Nonnull BigInteger data) {
        this.data = data;
        this.type = Type.INTEGER;
    }

    public Atom(@Nonnull BigComplex data) {
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

    public Atom(@Nonnull List<Atom> data) {
        this.data = data;
        this.type = Type.LIST;
    }

    public Atom(boolean data) {
        this.data = data ? BigInteger.valueOf(1) : BigInteger.valueOf(0);
        this.type = Type.INTEGER;
    }

    public Atom(@Nonnull Callable data) {
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
        if (type != Type.STRING) {
            throw new TypeError("Cannot get string from non-string atom " + typeString());
        }

        return (String) data;
    }

    public Userdata getUserdata() {
        if (type != Type.USERDATA) {
            throw new TypeError("Cannot get userdata from non-userdata atom " + typeString());
        }

        return (Userdata) data;
    }

    public <T extends Userdata> T getUserdata(Class<T> type) {
        if (this.type != Type.USERDATA)
            throw new TypeError("Cannot get userdata from non-userdata atom " + typeString());

        if (!type.isInstance(data))
            throw new TypeError("Cannot get desired userdata from atom of type " + ((Userdata) data).typeName());

        return type.cast(data);
    }

    public boolean isUserdata(Class<? extends Userdata> type) {
        if (this.type != Type.USERDATA)
            return false;

        return type.isInstance(data);
    }

    public BigDecimal getReal() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }

        if (type == Type.INTEGER) {
            return new BigDecimal((BigInteger) data);
        } else if (type == Type.REAL) {
            return (BigDecimal) data;
        } else if (type == Type.COMPLEX) {
            return ((BigComplex) data).re;
        } else {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }
    }

    public List<Atom> getList() {
        if (type == Type.STRING) {
            return ((String) data).chars().mapToObj(c -> new Atom(String.valueOf((char) c), false)).collect(Collectors.toList());
        }

        if (type != Type.LIST) {
            throw new TypeError("Cannot get list from non-list atom " + typeString());
        }

        return (List<Atom>) data;
    }

    public BigInteger getInteger() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }

        if (type == Type.REAL) {
            return ((BigDecimal) data).toBigInteger();
        } else if (type == Type.COMPLEX) {
            return ((BigComplex) data).re.toBigInteger();
        } else if (type == Type.INTEGER) {
            return (BigInteger) data;
        } else {
            throw new TypeError("Cannot get integer from non-integer atom " + typeString());
        }
    }

    public Callable getCallable() {
        if (type != Type.CALLABLE) {
            throw new TypeError("Cannot get callable object from non-callable atom" + (type == Type.IDENTIFIER ? " (" + getIdentifier() + " not bound?)" : ""));
        }

        return (Callable) data;
    }

    public String getIdentifier() {
        if (type != Type.IDENTIFIER) {
            throw new TypeError("Cannot get identifier from non-identifier atom " + typeString());
        }

        return (String) data;
    }

    public BigComplex getComplex() {
        if (!isNumeric()) {
            throw new TypeError("Cannot get complex from non-complex atom " + typeString());
        }

        if (type == Type.COMPLEX) {
            return (BigComplex) data;
        } else if (type == Type.REAL) {
            return BigComplex.valueOf(getReal());
        } else if (type == Type.INTEGER) {
            return BigComplex.valueOf(new BigDecimal(getInteger()));
        } else {
            throw new TypeError("Cannot get complex from non-complex atom " + typeString());
        }
    }

    public boolean isNumeric() {
        return type == Type.REAL || type == Type.COMPLEX || type == Type.INTEGER;
    }

    @Override
    public String toString() {
        switch (type) {
            case STRING:
                return "\"" + getString() + "\"";
            case REAL:
                String s = getReal().toString();
                if (s.contains(".")) return s;
                return s + ".";
            case LIST:
                if (getList().isEmpty())
                    return "nil";
                if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).toString();
                else if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).toString() + "[" + getList().stream().skip(1).map(Atom::toString).collect(Collectors.joining(" ")) + "]";
                return "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")";
            case CALLABLE:
                return getCallable().stringify();
            case IDENTIFIER:
                return getIdentifier();
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
        switch (type) {
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
                if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).toString();
                else if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).toString() + "$[" + getList().stream().skip(1).map(Atom::toString).collect(Collectors.joining(" ")) + "]";
                if (getList().stream().allMatch(x -> x.type.equals(Type.LIST)) && getList().stream().allMatch(x -> x.getList().stream().allMatch(y -> y.getType() != Type.LIST))) {
                    StringBuilder b = new StringBuilder();
                    b.append("[");
                    for (int i = 0; i < getList().size(); i++) {
                        if(i != 0)
                            b.append(" ");
                        b.append(getList().get(i).toDisplayString());
                        if(i != getList().size() - 1)
                            b.append("\n");
                    }
                    b.append("]");
                    return b.toString();
                } else if(getList().stream().allMatch(x -> x.type.equals(Type.STRING))) {
                    StringBuilder b = new StringBuilder();
                    b.append("[");
                    for (int i = 0; i < getList().size(); i++) {
                        if(i != 0)
                            b.append(" ");
                        b.append(getList().get(i).toString());
                        if(i != getList().size() - 1)
                            b.append("\n");
                    }
                    b.append("]");
                    return b.toString();
                }
                return "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")";
            case CALLABLE:
                return getCallable().stringify();
            case IDENTIFIER:
                return getIdentifier();
            case COMPLEX:
                return getComplex().re.toString() + "J" + getComplex().im.toString();
            case USERDATA:
                return getUserdata().toDisplayString();
            default:
                throw new IllegalArgumentException();
        }
    }

    public String shortString() {
        switch (type) {
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
                if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof ReactiveFunction)
                    return getList().get(0).shortString();
                else if (getList().get(0).type == Type.CALLABLE && getList().get(0).getCallable() instanceof Index)
                    return getList().get(0).shortString() + "[" + getList().stream().skip(1).map(Atom::shortString).collect(Collectors.joining(" ")) + "]";
                return "(" + getList().stream().limit(2).map(Atom::toString).collect(Collectors.joining(" ")) + (getList().size() > 2 ? " ..." : "") + ")";
            case CALLABLE:
                return "(sic) " + getCallable().frameString() + ".";
            case IDENTIFIER:
                return getIdentifier();
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
                if (type == Type.REAL && other.type == Type.REAL)
                    return getReal().equals(other.getReal());
                else if (type == Type.INTEGER && other.type == Type.INTEGER)
                    return getInteger().equals(other.getInteger());
                else if (type == Type.COMPLEX && other.type == Type.COMPLEX)
                    return getComplex().equals(other.getComplex());
                else if (type == Type.REAL && other.type == Type.INTEGER)
                    return getReal().equals(new BigDecimal(other.getInteger()));
                else if (type == Type.INTEGER && other.type == Type.REAL)
                    return new BigDecimal(getInteger()).equals(other.getReal());
                else if (type == Type.REAL && other.type == Type.COMPLEX)
                    return other.getComplex().equals(BigComplex.valueOf(getReal()));
                else if (type == Type.COMPLEX && other.type == Type.REAL)
                    return BigComplex.valueOf(other.getReal()).equals(getComplex());
                else if (type == Type.INTEGER && other.type == Type.COMPLEX)
                    return other.getComplex().equals(BigComplex.valueOf(new BigDecimal(getInteger())));
                else if (type == Type.COMPLEX && other.type == Type.INTEGER)
                    return BigComplex.valueOf(new BigDecimal(other.getInteger())).equals(getComplex());
                else
                    throw new IllegalStateException();
            }
            if (type != other.type) {
                return false;
            }
            switch (type) {
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
                    return getIdentifier().equals(other.getIdentifier());
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
        return switch (type) {
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
            if (this.type == type) {
                return;
            }
        }
        if (types.length == 1) {
            throw new TypeError("Expected " + types[0] + ", got " + type);
        } else {
            throw new TypeError("Expected one of " + List.of(types) + ", got " + type);
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

        if ((type == Type.REAL || type == Type.INTEGER) && (a.type == Type.REAL || a.type == Type.INTEGER)) {
            return getReal().compareTo(a.getReal());
        } else if (isNumeric() && a.isNumeric()) {
            return getComplex().abs(MathContext.DECIMAL128).compareTo(a.getComplex().abs(MathContext.DECIMAL128));
        } else if (type == Type.STRING && a.type == Type.STRING) {
            return getString().compareTo(a.getString());
        } else if (type == Type.LIST && a.type == Type.LIST) {
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
        } else if (type == Type.IDENTIFIER && a.type == Type.IDENTIFIER) {
            return getIdentifier().compareTo(a.getIdentifier());
        } else if (type == Type.CALLABLE && a.type == Type.CALLABLE) {
            return Integer.compare(getCallable().hashCode(), a.getCallable().hashCode());
        } else if (type == Type.USERDATA && a.type == Type.USERDATA) {
            return getUserdata().compareTo(a.getUserdata());
        } else {
            return type.ordinal() - a.type.ordinal();
        }
    }

    public Atom dot(Object index) {
        if (type == Type.STRING) {
            if (index instanceof BigDecimal) {
                return new Atom(String.valueOf(getString().charAt(((BigDecimal) index).intValue())), false);
            } else {
                throw new TypeError("Expected integer index.");
            }
        } else if (type == Type.LIST) {
            if (index instanceof BigDecimal) {
                return getList().get(((BigDecimal) index).intValue());
            } else {
                throw new TypeError("Expected integer index.");
            }
        } else if (type == Type.USERDATA) {
            return getUserdata().field(index);
        } else {
            throw new TypeError("Expected string or list.");
        }
    }
}
