package palaiologos.kamilalisp.runtime.image;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;
import palaiologos.kamilalisp.atom.Lambda;
import palaiologos.kamilalisp.atom.PrimitiveFunction;
import palaiologos.kamilalisp.runtime.array.Rank;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

public class WriteImage extends PrimitiveFunction implements Lambda {

    @Override
    public Atom apply(Environment env, List<Atom> args) {
        assertArity(args, 2);
        String fileName = args.get(0).getString();
        String fileFormat = "png";
        int rank;
        List<List<Atom>> imageData;
        if (args.size() == 3) {
            fileFormat = args.get(1).getString();
            rank = Rank.computeRank(args.get(2));
            if (rank != 2) {
                throw new RuntimeException("Expected rank 2 argument (RGBA matrix).");
            }
            imageData = args.get(2).getList().stream().map(Atom::getList).toList();
        } else {
            rank = Rank.computeRank(args.get(1));
            if (rank != 2) {
                throw new RuntimeException("Expected rank 2 argument (RGBA matrix).");
            }
            imageData = args.get(1).getList().stream().map(Atom::getList).toList();
        }
        BufferedImage img = new BufferedImage(imageData.get(0).size(), imageData.size(), BufferedImage.TYPE_INT_ARGB);
        for (int y = 0; y < imageData.size(); y++) {
            List<Atom> row = imageData.get(y);
            for (int x = 0; x < row.size(); x++) {
                img.setRGB(x, y, (int) row.get(x).getInteger().longValueExact());
            }
        }
        try {
            ImageIO.write(img, fileFormat, new File(fileName).getAbsoluteFile());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return args.get(0);
    }

    @Override
    protected String name() {
        return "img:write";
    }
}
