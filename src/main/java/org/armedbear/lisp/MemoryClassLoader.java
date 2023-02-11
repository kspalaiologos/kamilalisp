/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.HashMap;
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
/*     */ public class MemoryClassLoader
/*     */   extends JavaClassLoader
/*     */ {
/*  43 */   private final HashMap<String, JavaObject> hashtable = new HashMap<>();
/*  44 */   private final JavaObject boxedThis = new JavaObject(this);
/*     */   private final String internalNamePrefix;
/*     */   
/*     */   public MemoryClassLoader() {
/*  48 */     this("org/armedbear/lisp/");
/*     */   }
/*     */   
/*     */   public MemoryClassLoader(String internalNamePrefix) {
/*  52 */     this.internalNamePrefix = internalNamePrefix;
/*     */   }
/*     */   
/*     */   public MemoryClassLoader(JavaClassLoader parent) {
/*  56 */     super(parent);
/*  57 */     this.internalNamePrefix = "";
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
/*  72 */     if (this.hashtable.containsKey(name)) {
/*  73 */       String internalName = this.internalNamePrefix + name;
/*  74 */       Class<?> c = findLoadedClass(internalName);
/*     */       
/*  76 */       if (c == null) {
/*  77 */         c = findClass(name);
/*     */       }
/*  79 */       if (c != null) {
/*  80 */         if (resolve) {
/*  81 */           resolveClass(c);
/*     */         }
/*  83 */         return c;
/*     */       } 
/*     */     } 
/*     */     
/*  87 */     if (checkPreCompiledClassLoader) {
/*  88 */       Class<?> c = findPrecompiledClassOrNull(name);
/*  89 */       if (c != null) {
/*  90 */         return c;
/*     */       }
/*     */     } 
/*     */ 
/*     */     
/*  95 */     return super.loadClass(name, resolve);
/*     */   }
/*     */ 
/*     */   
/*     */   protected Class<?> findClass(String name) throws ClassNotFoundException {
/*     */     try {
/* 101 */       if (checkPreCompiledClassLoader) {
/* 102 */         Class<?> c = findPrecompiledClassOrNull(name);
/* 103 */         if (c != null)
/* 104 */           return c; 
/*     */       } 
/* 106 */       byte[] b = getFunctionClassBytes(name);
/* 107 */       return defineLispClass(name, b, 0, b.length);
/* 108 */     } catch (Throwable e) {
/* 109 */       e.printStackTrace();
/* 110 */       if (e instanceof ControlTransfer) throw (ControlTransfer)e; 
/* 111 */       throw new ClassNotFoundException("Function class not found: " + name, e);
/*     */     } 
/*     */   }
/*     */   
/*     */   public byte[] getFunctionClassBytes(String name) {
/* 116 */     if (this.hashtable.containsKey(name)) {
/* 117 */       return (byte[])((JavaObject)this.hashtable.get(name)).javaInstance();
/*     */     }
/* 119 */     return super.getFunctionClassBytes(name);
/*     */   }
/*     */   
/*     */   public LispObject loadFunction(String name) {
/*     */     try {
/* 124 */       Class<?> clz = loadClass(name);
/* 125 */       Function f = (Function)clz.newInstance();
/* 126 */       getFunctionClassBytes(f);
/* 127 */       return f;
/* 128 */     } catch (Throwable e) {
/* 129 */       if (e instanceof ControlTransfer) throw (ControlTransfer)e; 
/* 130 */       Debug.trace(e);
/* 131 */       return Lisp.error(new LispError("Compiled function can't be loaded: " + name + " from memory"));
/*     */     } 
/*     */   }
/*     */   
/* 135 */   private static final Primitive MAKE_MEMORY_CLASS_LOADER = new pf_make_memory_class_loader();
/*     */   
/*     */   private static final class pf_make_memory_class_loader extends Primitive { pf_make_memory_class_loader() {
/* 138 */       super("make-memory-class-loader", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 143 */       return (new MemoryClassLoader()).boxedThis;
/*     */     } }
/*     */ 
/*     */   
/* 147 */   public static final Primitive PUT_MEMORY_FUNCTION = new pf_put_memory_function();
/*     */   
/*     */   private static final class pf_put_memory_function extends Primitive { pf_put_memory_function() {
/* 150 */       super("put-memory-function", Lisp.PACKAGE_SYS, false, "loader class-name class-bytes");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject loader, LispObject className, LispObject classBytes) {
/* 155 */       MemoryClassLoader l = (MemoryClassLoader)loader.javaInstance(MemoryClassLoader.class);
/* 156 */       return l.hashtable.put(className.getStringValue(), classBytes);
/*     */     } }
/*     */ 
/*     */   
/* 160 */   private static final Primitive GET_MEMORY_FUNCTION = new pf_get_memory_function();
/*     */   
/*     */   private static final class pf_get_memory_function extends Primitive { pf_get_memory_function() {
/* 163 */       super("get-memory-function", Lisp.PACKAGE_SYS, false, "loader class-name");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject loader, LispObject name) {
/* 168 */       MemoryClassLoader l = (MemoryClassLoader)loader.javaInstance(MemoryClassLoader.class);
/* 169 */       return l.loadFunction(name.getStringValue());
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/MemoryClassLoader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */