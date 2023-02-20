package palaiologos.kamilalisp.runtime.remote;

import java.io.Serializable;
import java.util.List;

public class IDEPacket implements Packet {
    public String kind;
    public List<Serializable> data;

    public IDEPacket(String kind, List<Serializable> data) {
        this.kind = kind;
        this.data = data;
    }
}
