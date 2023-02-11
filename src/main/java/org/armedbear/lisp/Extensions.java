/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.IOException;
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
/*     */ 
/*     */ public final class Extensions
/*     */ {
/*  46 */   public static final Symbol _ED_FUNCTIONS_ = Lisp.exportSpecial("*ED-FUNCTIONS*", Lisp.PACKAGE_EXT, 
/*  47 */       Lisp.list(Lisp.intern("DEFAULT-ED-FUNCTION", Lisp.PACKAGE_SYS), new LispObject[0]));
/*     */ 
/*     */   
/*  50 */   private static final SpecialOperator TRULY_THE = new truly_the();
/*     */   
/*     */   private static class truly_the extends SpecialOperator { truly_the() {
/*  53 */       super("truly-the", Lisp.PACKAGE_EXT, true, "type value");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  58 */       if (args.length() != 2)
/*  59 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2)); 
/*  60 */       return Lisp.eval(args.cadr(), env, LispThread.currentThread());
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  65 */   private static final Primitive NEQ = new neq();
/*     */   
/*     */   private static class neq
/*     */     extends Primitive {
/*     */     neq() {
/*  70 */       super(Symbol.NEQ, "obj1 obj2");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*  75 */       return (first != second) ? Lisp.T : Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*  80 */   private static final Primitive MEMQ = new memq();
/*     */   
/*     */   private static class memq
/*     */     extends Primitive {
/*     */     memq() {
/*  85 */       super(Symbol.MEMQ, "item list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject item, LispObject list) {
/*  90 */       while (list instanceof Cons) {
/*     */         
/*  92 */         if (item == ((Cons)list).car)
/*  93 */           return list; 
/*  94 */         list = ((Cons)list).cdr;
/*     */       } 
/*  96 */       if (list != Lisp.NIL)
/*  97 */         Lisp.type_error(list, Symbol.LIST); 
/*  98 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 103 */   private static final Primitive MEMQL = new memql();
/*     */   
/*     */   private static class memql extends Primitive {
/*     */     memql() {
/* 107 */       super(Symbol.MEMQL, "item list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject item, LispObject list) {
/* 112 */       while (list instanceof Cons) {
/*     */         
/* 114 */         if (item.eql(((Cons)list).car))
/* 115 */           return list; 
/* 116 */         list = ((Cons)list).cdr;
/*     */       } 
/* 118 */       if (list != Lisp.NIL)
/* 119 */         Lisp.type_error(list, Symbol.LIST); 
/* 120 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 125 */   private static final Primitive ADJOIN_EQL = new adjoin_eql();
/*     */   
/*     */   private static class adjoin_eql extends Primitive { adjoin_eql() {
/* 128 */       super(Symbol.ADJOIN_EQL, "item list");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject item, LispObject list) {
/* 133 */       return Lisp.memql(item, list) ? list : new Cons(item, list);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 138 */   private static final Primitive SPECIAL_VARIABLE_P = new special_variable_p();
/*     */   
/*     */   private static class special_variable_p extends Primitive { special_variable_p() {
/* 141 */       super("special-variable-p", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 146 */       return arg.isSpecialVariable() ? Lisp.T : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 151 */   private static final Primitive SOURCE = new source();
/*     */   
/*     */   private static class source extends Primitive { source() {
/* 154 */       super("source", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 159 */       return Lisp.get(arg, Symbol._SOURCE, Lisp.NIL);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 164 */   private static final Primitive SOURCE_FILE_POSITION = new source_file_position();
/*     */   
/*     */   private static class source_file_position extends Primitive { source_file_position() {
/* 167 */       super("source-file-position", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 172 */       LispObject obj = Lisp.get(arg, Symbol._SOURCE, Lisp.NIL);
/* 173 */       if (obj instanceof Cons)
/* 174 */         return obj.cdr(); 
/* 175 */       return Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 180 */   public static final Primitive SOURCE_PATHNAME = new pf_source_pathname();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "source-pathname", args = "symbol", doc = "Returns either the pathname corresponding to the file from which this symbol was compiled,or the keyword :TOP-LEVEL.")
/*     */   private static class pf_source_pathname
/*     */     extends Primitive
/*     */   {
/*     */     pf_source_pathname() {
/* 189 */       super("source-pathname", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 194 */       LispObject obj = Lisp.get(arg, Symbol._SOURCE, Lisp.NIL);
/* 195 */       if (obj instanceof Cons)
/* 196 */         return obj.car(); 
/* 197 */       return obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 202 */   private static final Primitive EXIT = new exit();
/*     */   
/*     */   private static class exit extends Primitive { exit() {
/* 205 */       super("exit", Lisp.PACKAGE_EXT, true, "&key status");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 210 */       throw new ProcessingTerminated();
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 216 */       int status = 0;
/* 217 */       if (first == Keyword.STATUS)
/*     */       {
/* 219 */         if (second instanceof Fixnum)
/* 220 */           status = ((Fixnum)second).value; 
/*     */       }
/* 222 */       throw new ProcessingTerminated(status);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 227 */   private static final Primitive QUIT = new quit();
/*     */   
/*     */   private static class quit extends Primitive { quit() {
/* 230 */       super("quit", Lisp.PACKAGE_EXT, true, "&key status");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 235 */       ((Stream)Symbol.STANDARD_OUTPUT.getSymbolValue())._finishOutput();
/* 236 */       ((Stream)Symbol.ERROR_OUTPUT.getSymbolValue())._finishOutput();
/* 237 */       throw new ProcessingTerminated();
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 242 */       int status = 0;
/* 243 */       if (first == Keyword.STATUS)
/*     */       {
/* 245 */         if (second instanceof Fixnum)
/* 246 */           status = ((Fixnum)second).value; 
/*     */       }
/* 248 */       throw new ProcessingTerminated(status);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 253 */   private static final Primitive DUMP_JAVA_STACK = new dump_java_stack();
/*     */   
/*     */   private static class dump_java_stack extends Primitive { dump_java_stack() {
/* 256 */       super("dump-java-stack", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 261 */       Thread.dumpStack();
/* 262 */       return LispThread.currentThread().nothing();
/*     */     } }
/*     */ 
/*     */   
/* 266 */   public static final Primitive MAKE_TEMP_FILE = new make_temp_file();
/*     */   
/*     */   @DocString(name = "make-temp-file", doc = "Create and return the pathname of a previously non-existent file.", args = "&key prefix suffix")
/*     */   private static class make_temp_file
/*     */     extends Primitive {
/*     */     make_temp_file() {
/* 272 */       super("make-temp-file", Lisp.PACKAGE_EXT, true, "&key prefix suffix");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject... args) {
/* 277 */       String prefix = "abcl";
/* 278 */       String suffix = null;
/* 279 */       if (args.length % 2 != 0) {
/* 280 */         Lisp.error(new WrongNumberOfArgumentsException("Expecting an even number of arguments including keywords."));
/*     */       }
/*     */       
/* 283 */       for (int i = 0; i < args.length; i++) {
/* 284 */         if (args[i].SYMBOLP() != Lisp.NIL) {
/* 285 */           if (args[i].equals(Keyword.PREFIX)) {
/* 286 */             String specifiedPrefix = args[i + 1].getStringValue();
/* 287 */             if (specifiedPrefix != null) {
/* 288 */               if (specifiedPrefix.equals(Lisp.NIL.getStringValue())) {
/* 289 */                 Lisp.error(new TypeError("Cannot create temporary file with NIL prefix."));
/*     */               }
/* 291 */               prefix = specifiedPrefix;
/* 292 */               i++;
/*     */             } 
/* 294 */           } else if (args[i].equals(Keyword.SUFFIX)) {
/* 295 */             String specifiedSuffix = args[i + 1].getStringValue();
/* 296 */             if (specifiedSuffix != null) {
/* 297 */               if (specifiedSuffix.equals(Lisp.NIL.getStringValue())) {
/* 298 */                 suffix = null;
/*     */               } else {
/* 300 */                 suffix = specifiedSuffix;
/*     */               } 
/* 302 */               i++;
/*     */             } 
/*     */           } 
/*     */         } else {
/* 306 */           Lisp.error(new TypeError("Expected matching keyword argument.", args[i], Keyword.PREFIX.classOf()));
/*     */         } 
/*     */       } 
/* 309 */       return createTempFile(prefix, suffix);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 314 */       return createTempFile("abcl", null);
/*     */     }
/*     */     
/*     */     private LispObject createTempFile(String prefix, String suffix) {
/*     */       try {
/* 319 */         File file = File.createTempFile(prefix, suffix, null);
/* 320 */         if (file != null)
/* 321 */           return Pathname.create(file.getPath()); 
/* 322 */       } catch (IllegalArgumentException e) {
/*     */         
/* 324 */         Lisp.error(new JavaException(e));
/* 325 */       } catch (SecurityException e) {
/*     */         
/* 327 */         Lisp.error(new JavaException(e));
/* 328 */       } catch (IOException e) {
/*     */         
/* 330 */         Lisp.error(new JavaException(e));
/*     */       } 
/* 332 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */   
/* 336 */   public static final Primitive MAKE_TEMP_DIRECTORY = new make_temp_directory();
/*     */   
/*     */   @DocString(name = "make-temp-directory", doc = "Create and return the pathname of a previously non-existent directory.")
/*     */   private static class make_temp_directory extends Primitive {
/*     */     make_temp_directory() {
/* 341 */       super("make-temp-directory", Lisp.PACKAGE_EXT, true, "");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/*     */       try {
/* 347 */         File dir = File.createTempFile("abcl", null);
/* 348 */         dir.delete();
/* 349 */         if (dir.mkdirs()) {
/* 350 */           return Pathname.create(dir + "/");
/*     */         }
/* 352 */       } catch (Throwable t) {
/* 353 */         Debug.trace(t);
/*     */       } 
/* 355 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 360 */   private static final Primitive INTERRUPT_LISP = new interrupt_lisp();
/*     */   
/*     */   private static class interrupt_lisp extends Primitive { interrupt_lisp() {
/* 363 */       super("interrupt-lisp", Lisp.PACKAGE_EXT, true, "");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject[] args) {
/*     */       LispThread thread;
/* 368 */       if (args.length < 1) {
/* 369 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*     */       }
/* 371 */       if (args[0] instanceof LispThread) {
/* 372 */         thread = (LispThread)args[0];
/*     */       } else {
/*     */         
/* 375 */         return Lisp.type_error(args[0], Symbol.THREAD);
/*     */       } 
/* 377 */       Lisp.setInterrupted(thread, true);
/* 378 */       return Lisp.T;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 383 */   private static final Primitive GETENV = new getenv();
/*     */   
/*     */   private static class getenv
/*     */     extends Primitive {
/*     */     getenv() {
/* 388 */       super("getenv", Lisp.PACKAGE_EXT, true, "variable", "Return the value of the environment VARIABLE if it exists, otherwise return NIL.");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*     */       AbstractString string;
/* 395 */       if (arg instanceof AbstractString) {
/* 396 */         string = (AbstractString)arg;
/*     */       } else {
/* 398 */         return Lisp.type_error(arg, Symbol.STRING);
/* 399 */       }  String result = System.getenv(string.getStringValue());
/* 400 */       if (result != null) {
/* 401 */         return new SimpleString(result);
/*     */       }
/* 403 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 408 */   private static final Primitive GETENV_ALL = new getenv_all();
/*     */   
/*     */   private static class getenv_all
/*     */     extends Primitive {
/*     */     getenv_all() {
/* 413 */       super("getenv-all", Lisp.PACKAGE_EXT, true, "variable", "Returns all environment variables as an alist containing (name . value)");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 419 */       Cons result = new Cons(Lisp.NIL);
/* 420 */       Map<String, String> env = System.getenv();
/* 421 */       for (Map.Entry<String, String> entry : env.entrySet()) {
/*     */         
/* 423 */         Cons entryPair = new Cons(new SimpleString(entry.getKey()), new SimpleString(entry.getValue()));
/* 424 */         result = new Cons(entryPair, result);
/*     */       } 
/* 426 */       return result;
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Extensions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */