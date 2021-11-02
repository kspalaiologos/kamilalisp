package kamilalisp.data;

public class StringConstant {
    private String value;

    public StringConstant(String value) {
        this.value = value;
    }

    public String get() {
        return value;
    }

    @Override
    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if(!(o instanceof StringConstant)) return false;
        return value.equals(((StringConstant) o).get());
    }
}
