package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;
import palaiologos.kamilalisp.error.TypeError;

import javax.annotation.Nonnull;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

public class Atom {
    @Nonnull
    private Object data;
    private Type type;

    public static Atom NULL = new Atom();

    public Atom() {
        this.data = List.of();
        this.type = Type.LIST;
    }

    public Atom(String data) {
        this.data = data;
        this.type = Type.STRING;
    }

    public Atom(BigDecimal data) {
        this.data = data;
        this.type = Type.REAL;
    }

    public Atom(BigComplex data) {
        this.data = data;
        this.type = Type.COMPLEX;
    }

    public Atom(List<Atom> data) {
        this.data = data;
        this.type = Type.LIST;
    }

    public Atom(Callable data) {
        if(data instanceof ReactiveFunction) {
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

    public String getString() {
        if(getType() != Type.STRING) {
            throw new TypeError("Cannot get string from non-string atom " + getType());
        }

        return (String) data;
    }

    public BigDecimal getReal() {
        if(getType() != Type.REAL) {
            throw new TypeError("Cannot get integer from non-integer atom " + getType());
        }

        return (BigDecimal) data;
    }

    public List<Atom> getList() {
        if(getType() != Type.LIST) {
            throw new TypeError("Cannot get list from non-list atom " + getType());
        }

        return (List<Atom>) data;
    }

    public Callable getCallable() {
        if(getType() != Type.CALLABLE) {
            throw new TypeError("Cannot get callable object from non-callable atom" + (getType() == Type.IDENTIFIER ? " (" + Identifier.of(getIdentifier()) + " not bound?)" : ""));
        }

        return (Callable) data;
    }

    public Identifier getIdentifier() {
        if(getType() != Type.IDENTIFIER) {
            throw new TypeError("Cannot get identifier from non-identifier atom " + getType());
        }

        return (Identifier) data;
    }

    public BigComplex getComplex() {
        if(getType() != Type.COMPLEX) {
            throw new TypeError("Cannot get complex from non-complex atom " + getType());
        }

        return (BigComplex) data;
    }

    public boolean isNumeric() {
        return getType() == Type.REAL || getType() == Type.COMPLEX;
    }

    @Override
    public String toString() {
        return switch (getType()) {
            case STRING -> "\"" + getString() + "\"";
            case REAL -> getReal().toString();
            case LIST -> getList().isEmpty() ? "nil" :
                (getList().get(0) instanceof ReactiveFunction ? getList().get(0).toString()
                        : "(" + getList().stream().map(Atom::toString).collect(Collectors.joining(" ")) + ")");
            case CALLABLE -> getCallable().stringify();
            case IDENTIFIER -> Identifier.of(getIdentifier());
            case COMPLEX -> getComplex().re.toString() + "J" + getComplex().im.toString();
        };
    }

    public String shortString() {
        return switch (getType()) {
            case STRING -> "\"" + getString() + "\"";
            case REAL -> getReal().toString();
            case LIST -> getList().isEmpty() ? "nil" :
                (getList().get(0) instanceof ReactiveFunction ? getList().get(0).toString()
                        : "(" + getList().get(0).shortString() + " ...)");
            case CALLABLE -> "(sic) " + getCallable().frameString() + ".";
            case IDENTIFIER -> Identifier.of(getIdentifier());
            case COMPLEX -> getComplex().re.toString() + "J" + getComplex().im.toString();
        };
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Atom other) {
            if(getType() != other.getType()) {
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
                    if(l1.size() != l2.size()) {
                        return false;
                    }
                    for(int i = 0; i < l1.size(); i++) {
                        if(!l1.get(i).equals(l2.get(i))) {
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
        };
    }

    public void assertTypes(Type... types) {
        for(Type type : types) {
            if(getType() == type) {
                return;
            }
        }
        if(types.length == 1) {
            throw new TypeError("Expected " + types[0] + ", got " + getType());
        } else {
            throw new TypeError("Expected one of " + List.of(types) + ", got " + getType());
        }
    }
}
