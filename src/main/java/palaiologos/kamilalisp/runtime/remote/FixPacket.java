package palaiologos.kamilalisp.runtime.remote;

public class FixPacket implements Packet {
    public String name;
    public String content;

    public FixPacket(String name, String content) {
        this.name = name;
        this.content = content;
    }
}
