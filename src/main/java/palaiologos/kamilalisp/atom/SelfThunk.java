package palaiologos.kamilalisp.atom;

import ch.obermuhlner.math.big.BigComplex;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

public class SelfThunk extends Atom {
    public List<Atom> args;
    public Callable c;
    public Environment env;

    private void force() {
        if(c == null)
            return;
        Atom obj = Evaluation.evaluate(env, c, args);
        this.type = obj.getType();
        this.data = obj.data;
        c = null;
        args = null;
        env = null;
    }

    public SelfThunk(Callable c, List<Atom> args, Environment env) {
        super();
        this.args = args;
        this.c = c;
        this.env = env;
    }

    @Override
    public Type getType() {
        force();
        return super.getType();
    }

    @Override
    public String getString() {
        force();
        return super.getString();
    }

    @Override
    public Userdata getUserdata() {
        force();
        return super.getUserdata();
    }

    @Override
    public <T extends Userdata> T getUserdata(Class<T> type) {
        force();
        return super.getUserdata(type);
    }

    @Override
    public boolean isUserdata(Class<? extends Userdata> type) {
        force();
        return super.isUserdata(type);
    }

    @Override
    public BigDecimal getReal() {
        force();
        return super.getReal();
    }

    @Override
    public List<Atom> getList() {
        force();
        return super.getList();
    }

    @Override
    public BigInteger getInteger() {
        force();
        return super.getInteger();
    }

    @Override
    public Callable getCallable() {
        force();
        return super.getCallable();
    }

    @Override
    public String getIdentifier() {
        force();
        return super.getIdentifier();
    }

    @Override
    public BigComplex getComplex() {
        force();
        return super.getComplex();
    }

    @Override
    public boolean isNumeric() {
        force();
        return super.isNumeric();
    }

    @Override
    public String toString() {
        force();
        return super.toString();
    }

    @Override
    public String toDisplayString() {
        force();
        return super.toDisplayString();
    }

    @Override
    public String shortString() {
        force();
        return super.shortString();
    }

    @Override
    public boolean equals(Object obj) {
        force();
        return super.equals(obj);
    }

    @Override
    public boolean coerceBool() {
        force();
        return super.coerceBool();
    }

    @Override
    public void assertTypes(Type... types) {
        force();
        super.assertTypes(types);
    }

    @Override
    public int hashCode() {
        force();
        return super.hashCode();
    }

    @Override
    public int compareTo(Atom a) {
        force();
        return super.compareTo(a);
    }

    @Override
    public Atom dot(Object index) {
        force();
        return super.dot(index);
    }
}
