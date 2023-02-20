package palaiologos.kamilalisp.runtime.remote;

public class StringPacket implements Packet {
    public String data;

    public StringPacket(String data) {
        this.data = data;
    }
}
