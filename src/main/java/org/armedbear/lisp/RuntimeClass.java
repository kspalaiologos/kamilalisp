/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.HashMap;
/*     */ import java.util.Map;
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
/*     */ 
/*     */ public class RuntimeClass
/*     */ {
/*  44 */   static Map<String, RuntimeClass> classes = new HashMap<>();
/*     */   
/*  46 */   private Map<String, Function> methods = new HashMap<>();
/*     */ 
/*     */ 
/*     */   
/*  50 */   private static final Primitive _JNEW_RUNTIME_CLASS = new Primitive("%jnew-runtime-class", Lisp.PACKAGE_JAVA, false, "class-name &rest method-names-and-defs")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*  56 */         int length = args.length;
/*  57 */         if (length < 3 || length % 2 != 1)
/*  58 */           return Lisp.error(new WrongNumberOfArgumentsException(this)); 
/*  59 */         RuntimeClass rc = new RuntimeClass();
/*  60 */         String className = args[0].getStringValue(); int i;
/*  61 */         for (i = 1; i < length; i += 2) {
/*  62 */           String methodName = args[i].getStringValue();
/*  63 */           rc.addLispMethod(methodName, (Function)args[i + 1]);
/*     */         } 
/*  65 */         RuntimeClass.classes.put(className, rc);
/*  66 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  72 */   private static final Primitive _JREDEFINE_METHOD = new Primitive("%jredefine-method", Lisp.PACKAGE_JAVA, false, "class-name method-name method-def")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject className, LispObject methodName, LispObject methodDef)
/*     */       {
/*  82 */         String cn = className.getStringValue();
/*  83 */         String mn = methodName.getStringValue();
/*  84 */         Function def = (Function)methodDef;
/*  85 */         RuntimeClass rc = null;
/*  86 */         if (RuntimeClass.classes.containsKey(cn)) {
/*  87 */           rc = RuntimeClass.classes.get(cn);
/*  88 */           rc.addLispMethod(mn, def);
/*  89 */           return Lisp.T;
/*     */         } 
/*     */         
/*  92 */         Lisp.error(new LispError("undefined Java class: " + cn));
/*  93 */         return Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  99 */   private static final Primitive _LOAD_JAVA_CLASS_FROM_BYTE_ARRAY = new Primitive("%load-java-class-from-byte-array", Lisp.PACKAGE_JAVA, false, "classname bytearray")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject className, LispObject classBytes)
/*     */       {
/* 107 */         String cn = className.getStringValue();
/* 108 */         String pn = cn.substring(0, cn.lastIndexOf('.'));
/* 109 */         byte[] cb = (byte[])classBytes.javaInstance();
/*     */         try {
/* 111 */           JavaClassLoader loader = JavaClassLoader.getPersistentInstance(pn);
/* 112 */           Class<?> c = loader.loadClassFromByteArray(cn, cb);
/* 113 */           if (c != null) {
/* 114 */             return Lisp.T;
/*     */           }
/*     */         }
/* 117 */         catch (VerifyError e) {
/* 118 */           return Lisp.error(new LispError("class verification failed: " + e
/* 119 */                 .getMessage()));
/*     */         }
/* 121 */         catch (LinkageError e) {
/* 122 */           return Lisp.error(new LispError("class could not be linked: " + e
/* 123 */                 .getMessage()));
/*     */         } 
/* 125 */         return Lisp.error(new LispError("unable to load "
/* 126 */               .concat(cn)));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject evalC(LispObject function, LispObject args, Environment env, LispThread thread) {
/* 136 */     return Lisp.evalCall(function, args, env, thread);
/*     */   }
/*     */   
/*     */   public static RuntimeClass getRuntimeClass(String className) {
/* 140 */     return classes.get(className);
/*     */   }
/*     */   
/*     */   public Function getLispMethod(String methodName) {
/* 144 */     return this.methods.get(methodName);
/*     */   }
/*     */   
/*     */   void addLispMethod(String methodName, Function def) {
/* 148 */     this.methods.put(methodName, def);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final LispObject makeLispObject(Object obj) {
/* 153 */     return new JavaObject(obj);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final Fixnum makeLispObject(byte i) {
/* 158 */     return Fixnum.getInstance(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final Fixnum makeLispObject(short i) {
/* 163 */     return Fixnum.getInstance(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final Fixnum makeLispObject(int i) {
/* 168 */     return Fixnum.getInstance(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final LispInteger makeLispObject(long i) {
/* 173 */     return Bignum.getInstance(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final SingleFloat makeLispObject(float i) {
/* 178 */     return new SingleFloat(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final DoubleFloat makeLispObject(double i) {
/* 183 */     return new DoubleFloat(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final LispCharacter makeLispObject(char i) {
/* 188 */     return LispCharacter.getInstance(i);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final LispObject makeLispObject(boolean i) {
/* 193 */     return i ? Lisp.T : Lisp.NIL;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/RuntimeClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */