/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.ByteArrayInputStream;
/*     */ import java.io.ByteArrayOutputStream;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.InvalidObjectException;
/*     */ import java.io.ObjectInputStream;
/*     */ import java.io.ObjectOutputStream;
/*     */ import java.io.ObjectStreamClass;
/*     */ import java.io.ObjectStreamException;
/*     */ import java.io.Serializable;
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
/*     */ public abstract class Function
/*     */   extends Operator
/*     */   implements Serializable
/*     */ {
/*  43 */   private LispObject propertyList = Lisp.NIL;
/*     */   
/*     */   private int callCount;
/*     */   
/*     */   private int hotCount;
/*     */   
/*     */   public final LispObject loadedFrom;
/*     */ 
/*     */   
/*     */   protected Function() {
/*  53 */     LispObject loadTruename = Symbol.LOAD_TRUENAME.symbolValueNoThrow();
/*  54 */     LispObject loadTruenameFasl = Symbol.LOAD_TRUENAME_FASL.symbolValueNoThrow();
/*  55 */     this.loadedFrom = (loadTruenameFasl != null) ? loadTruenameFasl : ((loadTruename != null) ? loadTruename : Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(String name) {
/*  60 */     this(name, (String)null);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(String name, String arglist) {
/*  65 */     this();
/*  66 */     if (arglist != null)
/*  67 */       setLambdaList(new SimpleString(arglist)); 
/*  68 */     if (name != null) {
/*  69 */       Symbol symbol = Symbol.addFunction(name.toUpperCase(), this);
/*  70 */       if (Lisp.cold)
/*  71 */         symbol.setBuiltInFunction(true); 
/*  72 */       setLambdaName(symbol);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(Symbol symbol) {
/*  78 */     this(symbol, (String)null, (String)null);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(Symbol symbol, String arglist) {
/*  83 */     this(symbol, arglist, (String)null);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(Symbol symbol, String arglist, String docstring) {
/*  88 */     this();
/*  89 */     symbol.setSymbolFunction(this);
/*  90 */     if (Lisp.cold)
/*  91 */       symbol.setBuiltInFunction(true); 
/*  92 */     setLambdaName(symbol);
/*  93 */     if (arglist != null)
/*  94 */       setLambdaList(new SimpleString(arglist)); 
/*  95 */     if (docstring != null) {
/*  96 */       symbol.setDocumentation(Symbol.FUNCTION, new SimpleString(docstring));
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(String name, Package pkg) {
/* 102 */     this(name, pkg, false);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(String name, Package pkg, boolean exported) {
/* 107 */     this(name, pkg, exported, (String)null, (String)null);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Function(String name, Package pkg, boolean exported, String arglist) {
/* 113 */     this(name, pkg, exported, arglist, (String)null);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Function(String name, Package pkg, boolean exported, String arglist, String docstring) {
/* 119 */     this();
/* 120 */     if (arglist instanceof String)
/* 121 */       setLambdaList(new SimpleString(arglist)); 
/* 122 */     if (name != null) {
/*     */       Symbol symbol;
/* 124 */       if (exported) {
/* 125 */         symbol = pkg.internAndExport(name.toUpperCase());
/*     */       } else {
/* 127 */         symbol = pkg.intern(name.toUpperCase());
/* 128 */       }  symbol.setSymbolFunction(this);
/* 129 */       if (Lisp.cold)
/* 130 */         symbol.setBuiltInFunction(true); 
/* 131 */       setLambdaName(symbol);
/* 132 */       if (docstring != null) {
/* 133 */         symbol.setDocumentation(Symbol.FUNCTION, new SimpleString(docstring));
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(LispObject name) {
/* 140 */     this();
/* 141 */     setLambdaName(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Function(LispObject name, LispObject lambdaList) {
/* 146 */     this();
/* 147 */     setLambdaName(name);
/* 148 */     setLambdaList(lambdaList);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 154 */     return Symbol.FUNCTION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 160 */     return BuiltInClass.FUNCTION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 166 */     if (typeSpecifier == Symbol.FUNCTION)
/* 167 */       return Lisp.T; 
/* 168 */     if (typeSpecifier == Symbol.COMPILED_FUNCTION)
/* 169 */       return Lisp.T; 
/* 170 */     if (typeSpecifier == BuiltInClass.FUNCTION)
/* 171 */       return Lisp.T; 
/* 172 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getPropertyList() {
/* 178 */     if (this.propertyList == null)
/* 179 */       this.propertyList = Lisp.NIL; 
/* 180 */     return this.propertyList;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setPropertyList(LispObject obj) {
/* 186 */     if (obj == null)
/* 187 */       throw new NullPointerException(); 
/* 188 */     this.propertyList = obj;
/*     */   }
/*     */ 
/*     */   
/*     */   public final void setClassBytes(byte[] bytes) {
/* 193 */     this.propertyList = Lisp.putf(this.propertyList, Symbol.CLASS_BYTES, new JavaObject(bytes));
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getClassBytes() {
/* 198 */     LispObject o = Lisp.getf(this.propertyList, Symbol.CLASS_BYTES, Lisp.NIL);
/* 199 */     if (o != Lisp.NIL) {
/* 200 */       return o;
/*     */     }
/* 202 */     ClassLoader c = getClass().getClassLoader();
/* 203 */     if (c instanceof JavaClassLoader) {
/* 204 */       LispThread thread = LispThread.currentThread();
/* 205 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */       try {
/* 207 */         thread.bindSpecial(Symbol.LOAD_TRUENAME, this.loadedFrom);
/* 208 */         return new JavaObject(((JavaClassLoader)c).getFunctionClassBytes(this));
/* 209 */       } catch (Throwable t) {
/*     */ 
/*     */         
/* 212 */         if (t instanceof ControlTransfer) {
/* 213 */           throw (ControlTransfer)t;
/*     */         }
/* 215 */         return Lisp.NIL;
/*     */       } finally {
/*     */         
/* 218 */         thread.resetSpecialBindings(mark);
/*     */       } 
/*     */     } 
/* 221 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 226 */   public static final Primitive FUNCTION_CLASS_BYTES = new pf_function_class_bytes();
/*     */   
/*     */   public static final class pf_function_class_bytes extends Primitive { public pf_function_class_bytes() {
/* 229 */       super("function-class-bytes", Lisp.PACKAGE_SYS, false, "function");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 233 */       if (arg instanceof Function) {
/* 234 */         return ((Function)arg).getClassBytes();
/*     */       }
/* 236 */       return Lisp.type_error(arg, Symbol.FUNCTION);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 243 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 0));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 249 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 1));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 256 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 2));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 264 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 3));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 272 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 4));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 281 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 5));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 290 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 6));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 300 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 7));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 310 */     return Lisp.error(new WrongNumberOfArgumentsException(this, 8));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 316 */     return Lisp.error(new WrongNumberOfArgumentsException(this));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 322 */     LispObject name = getLambdaName();
/* 323 */     if (name != null && name != Lisp.NIL) {
/* 324 */       return unreadableString(name.princToString());
/*     */     }
/*     */     
/* 327 */     LispObject lambdaList = getLambdaList();
/* 328 */     if (lambdaList != null) {
/* 329 */       StringBuilder sb = new StringBuilder("FUNCTION ");
/* 330 */       sb.append("(LAMBDA ");
/* 331 */       if (lambdaList == Lisp.NIL) {
/* 332 */         sb.append("()");
/*     */       } else {
/* 334 */         LispThread thread = LispThread.currentThread();
/* 335 */         SpecialBindingsMark mark = thread.markSpecialBindings();
/* 336 */         thread.bindSpecial(Symbol.PRINT_LENGTH, Fixnum.THREE);
/*     */         try {
/* 338 */           sb.append(lambdaList.printObject());
/*     */         } finally {
/*     */           
/* 341 */           thread.resetSpecialBindings(mark);
/*     */         } 
/*     */       } 
/* 344 */       sb.append(")");
/* 345 */       return unreadableString(sb.toString());
/*     */     } 
/* 347 */     return unreadableString("FUNCTION");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void argCountError() {
/* 353 */     Lisp.error(new WrongNumberOfArgumentsException(this));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getCallCount() {
/* 360 */     return this.callCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCallCount(int n) {
/* 366 */     this.callCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementCallCount() {
/* 372 */     this.callCount++;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getHotCount() {
/* 378 */     return this.hotCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setHotCount(int n) {
/* 384 */     this.hotCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementHotCount() {
/* 390 */     this.hotCount++;
/*     */   }
/*     */   
/*     */   public static class SerializedNamedFunction implements Serializable {
/*     */     private final Symbol name;
/*     */     
/*     */     public SerializedNamedFunction(Symbol name) {
/* 397 */       this.name = name;
/*     */     }
/*     */     
/*     */     public Object readResolve() {
/* 401 */       return this.name.getSymbolFunctionOrDie();
/*     */     } }
/*     */   
/*     */   public static class ObjectInputStreamWithClassLoader extends ObjectInputStream {
/*     */     private final ClassLoader classLoader;
/*     */     
/*     */     public ObjectInputStreamWithClassLoader(InputStream in, ClassLoader classLoader) throws IOException {
/* 408 */       super(in);
/* 409 */       this.classLoader = classLoader;
/*     */     }
/*     */ 
/*     */     
/*     */     protected Class<?> resolveClass(ObjectStreamClass desc) throws IOException, ClassNotFoundException {
/* 414 */       return Class.forName(desc.getName(), false, this.classLoader);
/*     */     }
/*     */   }
/*     */   
/*     */   public static class SerializedLocalFunction implements Serializable {
/*     */     final LispObject className;
/*     */     final LispObject classBytes;
/*     */     final byte[] serializedFunction;
/*     */     
/*     */     public SerializedLocalFunction(Function function) {
/* 424 */       this.className = new SimpleString(function.getClass().getName());
/* 425 */       this.classBytes = function.getClassBytes();
/* 426 */       Function.serializingClosure.set(Boolean.valueOf(true));
/*     */       try {
/* 428 */         ByteArrayOutputStream baos = new ByteArrayOutputStream();
/* 429 */         (new ObjectOutputStream(baos)).writeObject(function);
/* 430 */         this.serializedFunction = baos.toByteArray();
/* 431 */       } catch (IOException e) {
/* 432 */         throw new RuntimeException(e);
/*     */       } finally {
/* 434 */         Function.serializingClosure.remove();
/*     */       } 
/*     */     }
/*     */     
/*     */     public Object readResolve() throws InvalidObjectException {
/* 439 */       MemoryClassLoader loader = new MemoryClassLoader();
/* 440 */       MemoryClassLoader.PUT_MEMORY_FUNCTION.execute(JavaObject.getInstance(loader), this.className, this.classBytes);
/*     */       try {
/* 442 */         ByteArrayInputStream in = new ByteArrayInputStream(this.serializedFunction);
/* 443 */         return (new Function.ObjectInputStreamWithClassLoader(in, loader)).readObject();
/* 444 */       } catch (Exception e) {
/* 445 */         InvalidObjectException ex = new InvalidObjectException("Could not read the serialized function back");
/* 446 */         ex.initCause(e);
/* 447 */         throw ex;
/*     */       } 
/*     */     }
/*     */   }
/*     */   
/* 452 */   private static final ThreadLocal<Boolean> serializingClosure = new ThreadLocal<>();
/*     */   
/*     */   public Object writeReplace() throws ObjectStreamException {
/* 455 */     if (shouldSerializeByName())
/* 456 */       return new SerializedNamedFunction((Symbol)getLambdaName()); 
/* 457 */     if (getClassBytes() == Lisp.NIL || serializingClosure.get() != null) {
/* 458 */       return this;
/*     */     }
/* 460 */     return new SerializedLocalFunction(this);
/*     */   }
/*     */ 
/*     */   
/*     */   protected boolean shouldSerializeByName() {
/* 465 */     LispObject lambdaName = getLambdaName();
/* 466 */     return (lambdaName instanceof Symbol && lambdaName.getSymbolFunction() == this);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Function.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */