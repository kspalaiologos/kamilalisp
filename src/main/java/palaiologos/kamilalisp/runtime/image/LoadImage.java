package palaiologos.kamilalisp.runtime.image;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.util.AbstractList;
import java.util.List;

public class LoadImage extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 1);
        String fileName = args.get(0).getString();
        BufferedImage image;

        try {
            image = ImageIO.read(new File(fileName));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return new Atom(new AbstractList<>() {
            @Override
            public Atom get(int y) {
                if(y < 0 || y >= image.getHeight()) {
                    throw new IndexOutOfBoundsException();
                }

                return new Atom(new AbstractList<>() {
                    @Override
                    public Atom get(int x) {
                        if(x < 0 || x >= image.getWidth()) {
                            throw new IndexOutOfBoundsException();
                        }

                        return new Atom(BigInteger.valueOf(Integer.toUnsignedLong(image.getRGB(x, y))));
                    }

                    @Override
                    public int size() {
                        return image.getWidth();
                    }
                });
            }

            @Override
            public int size() {
                return image.getHeight();
            }
        });
    }

    @Override
    protected String name() {
        return "img:read";
    }
}
