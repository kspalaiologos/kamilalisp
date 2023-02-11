/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.InputStream;
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
/*     */ public class FaslClassLoader
/*     */   extends JavaClassLoader
/*     */ {
/*     */   private final String baseName;
/*  43 */   private final JavaObject boxedThis = new JavaObject(this);
/*     */   
/*     */   public FaslClassLoader(String baseName) {
/*  46 */     this.baseName = baseName;
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
/*     */ 
/*     */ 
/*     */   
/*     */   protected Class<?> loadClass(String name, boolean resolve) throws ClassNotFoundException {
/*  61 */     if (name.startsWith(this.baseName + "_")) {
/*  62 */       String internalName = name.replace(".", "/");
/*  63 */       if (!internalName.contains("/")) internalName = "org/armedbear/lisp/" + internalName; 
/*  64 */       Class<?> c = findLoadedClass(internalName);
/*     */       
/*  66 */       if (c == null && checkPreCompiledClassLoader) {
/*  67 */         c = findPrecompiledClassOrNull(name);
/*     */         
/*  69 */         if (c != null)
/*  70 */           return c; 
/*     */       } 
/*  72 */       if (c == null) {
/*  73 */         c = findClass(name);
/*     */       }
/*  75 */       if (c != null) {
/*  76 */         if (resolve) {
/*  77 */           resolveClass(c);
/*     */         }
/*  79 */         return c;
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/*  84 */     return super.loadClass(name, resolve);
/*     */   }
/*     */ 
/*     */   
/*     */   protected Class<?> findClass(String name) throws ClassNotFoundException {
/*     */     try {
/*  90 */       if (checkPreCompiledClassLoader) {
/*  91 */         Class<?> c = findPrecompiledClassOrNull(name);
/*  92 */         if (c != null)
/*  93 */           return c; 
/*     */       } 
/*  95 */       byte[] b = getFunctionClassBytes(name);
/*  96 */       return defineLispClass(name, b, 0, b.length);
/*  97 */     } catch (Throwable e) {
/*  98 */       e.printStackTrace();
/*  99 */       if (e instanceof ControlTransfer) throw (ControlTransfer)e; 
/* 100 */       throw new ClassNotFoundException("Function class not found: " + name, e);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public InputStream getResourceAsStream(String resourceName) {
/* 106 */     LispThread thread = LispThread.currentThread();
/*     */     
/* 108 */     Pathname name = Pathname.create(resourceName.substring("org/armedbear/lisp/".length()));
/* 109 */     LispObject truenameFasl = Symbol.LOAD_TRUENAME_FASL.symbolValue(thread);
/* 110 */     LispObject truename = Symbol.LOAD_TRUENAME.symbolValue(thread);
/*     */     
/* 112 */     if (truenameFasl instanceof Pathname)
/* 113 */       return Pathname.mergePathnames(name, (Pathname)truenameFasl, Keyword.NEWEST)
/* 114 */         .getInputStream(); 
/* 115 */     if (truename instanceof Pathname)
/* 116 */       return Pathname.mergePathnames(name, (Pathname)truename, Keyword.NEWEST)
/* 117 */         .getInputStream(); 
/* 118 */     if (!Symbol.PROBE_FILE.execute(name).equals(Lisp.NIL)) {
/* 119 */       return name.getInputStream();
/*     */     }
/*     */     
/* 122 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject loadFunction(int fnNumber) {
/* 127 */     String name = this.baseName + "_" + (fnNumber + 1);
/*     */     try {
/* 129 */       Class<?> clz = loadClass(name);
/* 130 */       Function f = (Function)clz.newInstance();
/* 131 */       if (clz.getClassLoader() instanceof JavaClassLoader)
/*     */       {
/* 133 */         f.setClassBytes(getFunctionClassBytes(name));
/*     */       }
/* 135 */       return f;
/* 136 */     } catch (Throwable e) {
/* 137 */       if (e instanceof ControlTransfer) throw (ControlTransfer)e; 
/* 138 */       Debug.trace(e);
/* 139 */       return Lisp.error(new LispError("Compiled function can't be loaded: " + name + " from " + Symbol.LOAD_TRUENAME.symbolValue()));
/*     */     } 
/*     */   }
/*     */   
/* 143 */   private static final Primitive MAKE_FASL_CLASS_LOADER = new pf_make_fasl_class_loader();
/*     */   
/*     */   private static final class pf_make_fasl_class_loader extends Primitive { pf_make_fasl_class_loader() {
/* 146 */       super("make-fasl-class-loader", Lisp.PACKAGE_SYS, false, "base-name");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject baseName) {
/* 151 */       return (new FaslClassLoader(baseName.getStringValue())).boxedThis;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 156 */   private static final Primitive GET_FASL_FUNCTION = new pf_get_fasl_function();
/*     */   
/*     */   private static final class pf_get_fasl_function extends Primitive { pf_get_fasl_function() {
/* 159 */       super("get-fasl-function", Lisp.PACKAGE_SYS, false, "loader function-number");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject loader, LispObject fnNumber) {
/* 164 */       FaslClassLoader l = (FaslClassLoader)loader.javaInstance(FaslClassLoader.class);
/* 165 */       return l.loadFunction(fnNumber.intValue());
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FaslClassLoader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */