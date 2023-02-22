package palaiologos.kamilalisp.runtime.sh;

import palaiologos.kamilalisp.atom.Atom;
import palaiologos.kamilalisp.atom.Environment;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;

public class SysArch {
    public static void registerProperties(Environment env) {
        OperatingSystemMXBean bean = ManagementFactory.getOperatingSystemMXBean();
        env.setPrimitive("sh:path-sep", new Atom(File.separator));
        env.setPrimitive("sh:os-name", new Atom(bean.getName()));
        env.setPrimitive("sh:os-arch", new Atom(bean.getArch()));
        env.setPrimitive("sh:os-version", new Atom(bean.getVersion()));

        String javaHome = System.getProperty("java.home");
        String javaBin = javaHome + File.separator + "bin" + File.separator + "java";
        env.setPrimitive("sh:java-bin", new Atom(javaBin));
        env.setPrimitive("sh:java-home", new Atom(javaHome));
    }
}
