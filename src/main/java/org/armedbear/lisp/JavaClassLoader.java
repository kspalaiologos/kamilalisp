/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.DataInputStream;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.net.URL;
/*     */ import java.net.URLClassLoader;
/*     */ import java.util.Collections;
/*     */ import java.util.HashSet;
/*     */ import java.util.Set;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class JavaClassLoader
/*     */   extends URLClassLoader
/*     */ {
/*     */   private static JavaClassLoader persistentInstance;
/*     */   public static boolean checkPreCompiledClassLoader = true;
/*     */   
/*     */   public Class<?> loadClass(String name) throws ClassNotFoundException {
/*  54 */     if (checkPreCompiledClassLoader) {
/*  55 */       Class<?> c = findPrecompiledClassOrNull(name);
/*  56 */       if (c != null) {
/*  57 */         return c;
/*     */       }
/*     */     } 
/*  60 */     return loadClass(name, false);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Class<?> findPrecompiledClassOrNull(String name) {
/*  72 */     ClassLoader ourCL = JavaClassLoader.class.getClassLoader();
/*  73 */     while (ourCL != null) {
/*     */       try {
/*  75 */         return Class.forName(name, true, ourCL);
/*  76 */       } catch (ClassNotFoundException classNotFoundException) {
/*     */         
/*  78 */         ourCL = ourCL.getParent();
/*     */       } 
/*     */     }  try {
/*  81 */       return findSystemClass(name);
/*  82 */     } catch (ClassNotFoundException e) {
/*  83 */       return null;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public byte[] getFunctionClassBytes(String name) {
/*  89 */     Pathname pathname = Pathname.create(name.substring("org/armedbear/lisp/".length()) + "." + Lisp._COMPILE_FILE_CLASS_EXTENSION_
/*  90 */         .symbolValue().getStringValue());
/*  91 */     return Lisp.readFunctionBytes(pathname);
/*     */   }
/*     */   
/*     */   public byte[] getFunctionClassBytes(Class<?> functionClass) {
/*  95 */     String className = functionClass.getName();
/*     */     try {
/*  97 */       String ext = Lisp._COMPILE_FILE_CLASS_EXTENSION_.symbolValue().getStringValue();
/*  98 */       InputStream is = getResourceAsStream(className.replace('.', '/') + "." + ext);
/*  99 */       if (is != null) {
/* 100 */         byte[] imgDataBa = new byte[is.available()];
/* 101 */         DataInputStream dataIs = new DataInputStream(is);
/* 102 */         dataIs.readFully(imgDataBa);
/* 103 */         return imgDataBa;
/*     */       } 
/* 105 */     } catch (IOException iOException) {}
/*     */     
/* 107 */     return getFunctionClassBytes(className);
/*     */   }
/*     */   
/*     */   public final byte[] getFunctionClassBytes(Function f) {
/* 111 */     byte[] b = getFunctionClassBytes(f.getClass());
/* 112 */     f.setClassBytes(b);
/* 113 */     return b;
/*     */   }
/*     */   
/* 116 */   private static Set<String> packages = Collections.synchronizedSet(new HashSet<>());
/*     */ 
/*     */   
/*     */   public JavaClassLoader() {
/* 120 */     this(JavaClassLoader.class.getClassLoader());
/*     */   }
/*     */   
/*     */   public JavaClassLoader(ClassLoader parent) {
/* 124 */     super(new URL[0], parent);
/*     */   }
/*     */   
/*     */   public JavaClassLoader(JavaClassLoader parent) {
/* 128 */     super(new URL[0], parent);
/*     */   }
/*     */   
/*     */   public JavaClassLoader(URL[] classpath, ClassLoader parent) {
/* 132 */     super(classpath, parent);
/*     */   }
/*     */ 
/*     */   
/*     */   public static JavaClassLoader getPersistentInstance() {
/* 137 */     return getPersistentInstance((String)null);
/*     */   }
/*     */ 
/*     */   
/*     */   public static JavaClassLoader getPersistentInstance(String packageName) {
/* 142 */     if (persistentInstance == null)
/* 143 */       persistentInstance = new JavaClassLoader(); 
/* 144 */     definePackage(packageName);
/* 145 */     return persistentInstance;
/*     */   }
/*     */ 
/*     */   
/*     */   private static void definePackage(String packageName) {
/* 150 */     if (packageName != null && !packages.contains(packageName)) {
/* 151 */       persistentInstance.definePackage(packageName, "", "1.0", "", "", "1.0", "", null);
/* 152 */       packages.add(packageName);
/*     */     } 
/*     */   }
/*     */   
/*     */   public Class<?> loadClassFromByteArray(byte[] classbytes) {
/* 157 */     return loadClassFromByteArray((String)null, classbytes);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Class<?> loadClassFromByteArray(String className, byte[] classbytes) {
/*     */     try {
/* 164 */       long length = classbytes.length;
/* 165 */       if (length < 2147483647L) {
/*     */         
/* 167 */         Class<?> c = defineLispClass(className, classbytes, 0, (int)length);
/* 168 */         if (c != null) {
/* 169 */           resolveClass(c);
/* 170 */           return c;
/*     */         }
/*     */       
/*     */       } 
/* 174 */     } catch (LinkageError e) {
/* 175 */       throw e;
/*     */     }
/* 177 */     catch (Throwable t) {
/* 178 */       Debug.trace(t);
/*     */     } 
/* 180 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected final Class<?> defineLispClass(String name, byte[] b, int off, int len) throws ClassFormatError {
/* 186 */     return defineClass(name, b, off, len);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Class<?> loadClassFromByteArray(String className, byte[] bytes, int offset, int length) {
/*     */     try {
/* 193 */       Class<?> c = defineLispClass(className, bytes, offset, length);
/* 194 */       if (c != null) {
/* 195 */         resolveClass(c);
/* 196 */         return c;
/*     */       }
/*     */     
/* 199 */     } catch (VerifyError e) {
/*     */       
/* 201 */       Lisp.error(new LispError("Class verification failed: " + e.getMessage()));
/*     */     }
/* 203 */     catch (Throwable t) {
/* 204 */       Debug.trace(t);
/*     */     } 
/* 206 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public void addURL(URL url) {
/* 211 */     super.addURL(url);
/*     */   }
/*     */   
/* 214 */   public static final Symbol CLASSLOADER = Lisp.PACKAGE_JAVA.intern("*CLASSLOADER*");
/*     */   
/* 216 */   private static final Primitive GET_DEFAULT_CLASSLOADER = new pf_get_default_classloader();
/*     */   
/*     */   private static final class pf_get_default_classloader extends Primitive {
/* 219 */     private final LispObject defaultClassLoader = new JavaObject(new JavaClassLoader());
/*     */     
/*     */     pf_get_default_classloader() {
/* 222 */       super("get-default-classloader", Lisp.PACKAGE_JAVA, true, "");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 227 */       return this.defaultClassLoader;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 232 */   private static final Primitive MAKE_CLASSLOADER = new pf_make_classloader();
/*     */   
/*     */   private static final class pf_make_classloader
/*     */     extends Primitive {
/*     */     pf_make_classloader() {
/* 237 */       super("make-classloader", Lisp.PACKAGE_JAVA, true, "&optional parent");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 242 */       return new JavaObject(new JavaClassLoader(JavaClassLoader.getCurrentClassLoader()));
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject parent) {
/* 247 */       return new JavaObject(new JavaClassLoader((ClassLoader)parent.javaInstance(ClassLoader.class)));
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 252 */   private static final Primitive DUMP_CLASSPATH = new pf_dump_classpath();
/*     */   
/*     */   private static final class pf_dump_classpath
/*     */     extends Primitive {
/*     */     pf_dump_classpath() {
/* 257 */       super("dump-classpath", Lisp.PACKAGE_JAVA, true, "&optional classloader");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 262 */       return execute(new JavaObject(JavaClassLoader.getCurrentClassLoader()));
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject classloader) {
/* 267 */       LispObject list = Lisp.NIL;
/* 268 */       Object o = classloader.javaInstance();
/* 269 */       while (o instanceof ClassLoader) {
/* 270 */         ClassLoader cl = (ClassLoader)o;
/* 271 */         list = list.push(JavaClassLoader.dumpClassPath(cl));
/* 272 */         o = cl.getParent();
/*     */       } 
/* 274 */       return list.nreverse();
/*     */     }
/*     */   }
/*     */   
/* 278 */   private static final Primitive GET_CURRENT_CLASSLOADER = new pf_get_current_classloader();
/*     */   
/*     */   @DocString(name = "get-current-classloader")
/*     */   private static final class pf_get_current_classloader extends Primitive { pf_get_current_classloader() {
/* 282 */       super("get-current-classloader", Lisp.PACKAGE_JAVA, true);
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/* 286 */       return new JavaObject(JavaClassLoader.getCurrentClassLoader());
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 291 */   private static final Primitive ADD_TO_CLASSPATH = new pf_add_to_classpath();
/*     */   
/*     */   private static final class pf_add_to_classpath
/*     */     extends Primitive {
/*     */     pf_add_to_classpath() {
/* 296 */       super("%add-to-classpath", Lisp.PACKAGE_JAVA, false, "jar-or-jars &optional (classloader (get-current-classloader))");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject jarOrJars) {
/* 302 */       return execute(jarOrJars, new JavaObject(JavaClassLoader.getCurrentClassLoader()));
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject jarOrJars, LispObject classloader) {
/* 307 */       Object o = classloader.javaInstance();
/* 308 */       if (o instanceof JavaClassLoader) {
/* 309 */         JavaClassLoader jcl = (JavaClassLoader)o;
/* 310 */         if (jarOrJars instanceof Cons) {
/* 311 */           while (jarOrJars != Lisp.NIL) {
/* 312 */             JavaClassLoader.addURL(jcl, jarOrJars.car());
/* 313 */             jarOrJars = jarOrJars.cdr();
/*     */           } 
/*     */         } else {
/* 316 */           JavaClassLoader.addURL(jcl, jarOrJars);
/*     */         } 
/* 318 */         return Lisp.T;
/*     */       } 
/* 320 */       return Lisp.error(new TypeError(o + " must be an instance of " + JavaClassLoader.class.getName()));
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   protected static void addURL(JavaClassLoader jcl, LispObject jar) {
/* 326 */     URLPathname urlPathname = null;
/* 327 */     if (jar instanceof URLPathname) {
/* 328 */       urlPathname = (URLPathname)jar;
/* 329 */     } else if (jar instanceof Pathname) {
/* 330 */       urlPathname = URLPathname.createFromFile((Pathname)jar);
/* 331 */     } else if (jar instanceof AbstractString) {
/* 332 */       String namestring = jar.getStringValue();
/* 333 */       if (!Pathname.isValidURL(namestring)) {
/* 334 */         Pathname p = Pathname.create(namestring);
/* 335 */         if (p != null) {
/* 336 */           urlPathname = URLPathname.create(p);
/*     */         }
/*     */       } else {
/* 339 */         urlPathname = URLPathname.create(namestring);
/*     */       } 
/*     */     } 
/* 342 */     if (urlPathname == null) {
/* 343 */       Lisp.error(new TypeError(jar + " must be a pathname designator"));
/*     */     }
/* 345 */     jcl.addURL(urlPathname.toURL());
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispObject dumpClassPath(ClassLoader o) {
/* 350 */     if (o instanceof URLClassLoader) {
/* 351 */       LispObject list = Lisp.NIL;
/* 352 */       for (URL u : ((URLClassLoader)o).getURLs()) {
/* 353 */         list = list.push(URLPathname.create(u));
/*     */       }
/* 355 */       return new Cons(new JavaObject(o), list.nreverse());
/*     */     } 
/* 357 */     return new JavaObject(o);
/*     */   }
/*     */ 
/*     */   
/*     */   public static ClassLoader getCurrentClassLoader() {
/* 362 */     LispObject classLoader = CLASSLOADER.symbolValueNoThrow();
/* 363 */     if (classLoader != null) {
/* 364 */       return (ClassLoader)classLoader.javaInstance(ClassLoader.class);
/*     */     }
/* 366 */     return Lisp.class.getClassLoader();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JavaClassLoader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */