package palaiologos.kamilalisp.runtime.flt64;

import palaiologos.kamilalisp.atom.*;

import java.math.BigDecimal;
import java.util.List;

public class Flt64AtomThunk extends AtomicThunk {
    public double val;
    private boolean forced = false;

    public Flt64AtomThunk(double val) {
        super();
        this.val = val;
    }

    public void force() {
        if(forced)
            return;
        setType(Type.REAL);
        setData(BigDecimal.valueOf(val));
        forced = true;
    }
}
