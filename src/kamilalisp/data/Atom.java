package kamilalisp.data;

import com.google.common.base.Joiner;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Atom {
    public Atom() { this.content = new LbcSupplier<>(() -> new LinkedList<Atom>()); this.type = Type.LIST; }
    public Atom(BigDecimal atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.NUMBER; }
    public Atom(String atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.STRING; }
    public Atom(StringConstant atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.STRING_CONSTANT; }
    public Atom(List<Atom> atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.LIST; }
    public Atom(Closure atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.CLOSURE; }
    public Atom(Macro atom) { this.content = new LbcSupplier<>(() -> atom); this.type = Type.MACRO; }
    public Atom(LbcSupplier<?> atom, Type t) { this.content = atom; this.type = t; }
    public Atom(LbcSupplier<?> atom) { this.content = atom; this.type = null; }

    public LbcSupplier<BigDecimal> getNumber() { assert getType() == Type.NUMBER; return (LbcSupplier<BigDecimal>) content; }
    public LbcSupplier<String> getString() { assert getType() == Type.STRING; return (LbcSupplier<String>) content; }
    public LbcSupplier<StringConstant> getStringConstant() { assert getType() == Type.STRING_CONSTANT; return (LbcSupplier<StringConstant>) content; }
    public LbcSupplier<List<Atom>> getList() { assert getType() == Type.LIST; return (LbcSupplier<List<Atom>>) content; }
    public LbcSupplier<Closure> getClosure() { assert getType() == Type.CLOSURE; return (LbcSupplier<Closure>) content; }
    public LbcSupplier<Macro> getMacro() { assert getType() == Type.MACRO; return (LbcSupplier<Macro>) content; }
    public LbcSupplier<?> get() { return content; }
    public Type getType() {
        if(type != null)
            return type;

        Object data = content.get();

        if (data instanceof BigDecimal)
            type = Type.NUMBER;
        else if (data instanceof String)
            type = Type.STRING;
        else if (data instanceof StringConstant)
            type = Type.STRING_CONSTANT;
        else if (data instanceof List)
            type = Type.LIST;
        else if (data instanceof Closure)
            type = Type.CLOSURE;
        else if (data instanceof Macro)
            type = Type.MACRO;
        else
            throw new Error("Unknown type: " + data.getClass().getSimpleName());

        content = new LbcSupplier<>(() -> data);

        return type;
    }

    private LbcSupplier<?> content;
    private Type type;

    public static Atom NULL = new Atom();

    @Override
    public String toString() {
        switch(getType()) {
            case CLOSURE: return getClosure().get().representation();
            case MACRO: return getMacro().get().representation();
            case STRING_CONSTANT: return "\"" + getStringConstant().get().get() + "\"";
            case NUMBER: return getNumber().get().toPlainString();
            case STRING: return getString().get();
            case LIST:
                return "(" + getList().get().stream().map(x -> x.toString()).collect(Collectors.joining(" ")) + ")";
        }

        return "??";
    }

    @Override
    public boolean equals(Object o) {
        if(o == this) return true;
        if(!(o instanceof Atom)) return false;
        Atom other = (Atom) o;
        if(!getType().equals(other.getType()))
            return false;
        if((getType() == Type.STRING_CONSTANT && other.getStringConstant().get().get().equals(getStringConstant().get().get()))
                || (getType() == Type.STRING && other.getString().get().equals(getString().get()))
                || (getType() == Type.NUMBER && other.getNumber().get().compareTo(getNumber().get()) == 0)
                || (getType() == Type.CLOSURE && other.getClosure().get().equals(getClosure().get()))
                || (getType() == Type.MACRO && other.getMacro().get().equals(getMacro().get())))
            return true;
        else if(getType() == Type.LIST && other.getList().get().size() == getList().get().size()) {
            List<Atom> l1 = other.getList().get(), l2 = getList().get();
            for(int i = 0; i < l1.size(); i++)
                if(!l1.get(0).get().get().equals(l2.get(0).get().get()))
                    return false;
            return true;
        }
        return false;
    }

    public void guardType(String cause, Type... t) throws Error {
        if(t.length > 1) {
            if(Arrays.stream(t).noneMatch(x -> x == getType()))
                throw new Error(cause + ": expected any of " + Joiner.on(", ").join(t) + " got " + getType().name());
        } else {
            if(t[0] != getType())
                throw new Error(cause + ": expected " + t[0].name() + " got " + getType().name());
        }
    }

    public boolean coerceBool() {
        return (this.getType() == Type.NUMBER && this.getNumber().get().compareTo(BigDecimal.ZERO) != 0)
            || (this.getType() == Type.STRING_CONSTANT && this.getStringConstant().get().get().length() > 0);
    }
}
