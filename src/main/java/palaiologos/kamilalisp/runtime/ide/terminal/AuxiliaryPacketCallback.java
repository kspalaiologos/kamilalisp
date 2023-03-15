package palaiologos.kamilalisp.runtime.ide.terminal;

import palaiologos.kamilalisp.runtime.remote.packet.Packet;

import java.util.function.Consumer;
import java.util.function.Supplier;

public interface AuxiliaryPacketCallback {
    void onSent(Supplier<Packet> receivePacket, Consumer<Packet> sendPacket);
}
