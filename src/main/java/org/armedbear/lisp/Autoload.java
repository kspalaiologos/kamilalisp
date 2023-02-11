/*     */ package org.armedbear.lisp;
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
/*     */ 
/*     */ 
/*     */ 
/*     */ public class Autoload
/*     */   extends Function
/*     */ {
/*     */   protected final String fileName;
/*     */   protected final String className;
/*     */   protected final Symbol symbol;
/*     */   
/*     */   protected Autoload(Symbol symbol) {
/*  51 */     this.fileName = null;
/*  52 */     this.className = null;
/*  53 */     this.symbol = symbol;
/*  54 */     symbol.setBuiltInFunction(false);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected Autoload(Symbol symbol, String fileName, String className) {
/*  60 */     this.fileName = fileName;
/*  61 */     this.className = className;
/*  62 */     this.symbol = symbol;
/*  63 */     symbol.setBuiltInFunction(false);
/*     */   }
/*     */ 
/*     */   
/*     */   protected final Symbol getSymbol() {
/*  68 */     return this.symbol;
/*     */   }
/*     */ 
/*     */   
/*     */   public static void autoload(String symbolName, String className) {
/*  73 */     autoload(Lisp.PACKAGE_CL, symbolName, className);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static void autoload(Package pkg, String symbolName, String className) {
/*  79 */     autoload(pkg, symbolName, className, false);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static void autoload(Package pkg, String symbolName, String className, boolean exported) {
/*  85 */     Symbol symbol = Lisp.intern(symbolName.toUpperCase(), pkg);
/*  86 */     if (pkg != Lisp.PACKAGE_CL && exported) {
/*  87 */       pkg.export(symbol);
/*     */     }
/*  89 */     if (symbol.getSymbolFunction() == null) {
/*  90 */       symbol.setSymbolFunction(new Autoload(symbol, null, "org.armedbear.lisp."
/*  91 */             .concat(className)));
/*     */     }
/*     */   }
/*     */   
/*     */   public static void autoload(Symbol symbol, String className) {
/*  96 */     if (symbol.getSymbolFunction() == null)
/*  97 */       symbol.setSymbolFunction(new Autoload(symbol, null, "org.armedbear.lisp."
/*  98 */             .concat(className))); 
/*     */   }
/*     */   
/*     */   private static void effectiveLoad(String className, String fileName) {
/* 102 */     if (className != null) {
/*     */       try {
/* 104 */         Class.forName(className);
/*     */       }
/* 106 */       catch (ClassNotFoundException e) {
/* 107 */         e.printStackTrace();
/*     */       } 
/*     */     } else {
/* 110 */       Load.loadSystemFile(fileName, true);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   private static void loadVerbose(Symbol sym, int loadDepth, String className, String fileName) {
/* 116 */     String prefix = Load.getLoadVerbosePrefix(loadDepth);
/* 117 */     Stream out = Lisp.getStandardOutput();
/* 118 */     out._writeString(prefix);
/* 119 */     out._writeString(sym.getQualifiedName() + " triggers autoloading of ");
/* 120 */     out._writeString((className == null) ? fileName : className);
/* 121 */     out._writeLine(" ...");
/* 122 */     out._finishOutput();
/* 123 */     long start = System.currentTimeMillis();
/* 124 */     effectiveLoad(className, fileName);
/* 125 */     long elapsed = System.currentTimeMillis() - start;
/* 126 */     out._writeString(prefix);
/* 127 */     out._writeString(" Autoloaded ");
/* 128 */     out._writeString((className == null) ? fileName : className);
/* 129 */     out._writeString(" (");
/* 130 */     out._writeString(String.valueOf((float)elapsed / 1000.0F));
/* 131 */     out._writeLine(" seconds)");
/* 132 */     out._finishOutput();
/*     */   }
/*     */ 
/*     */   
/*     */   public void load() {
/* 137 */     LispThread thread = LispThread.currentThread();
/* 138 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 139 */     int loadDepth = Fixnum.getValue(Lisp._LOAD_DEPTH_.symbolValue());
/* 140 */     thread.bindSpecial(Lisp._LOAD_DEPTH_, Fixnum.getInstance(++loadDepth));
/*     */     try {
/* 142 */       if (Lisp._AUTOLOAD_VERBOSE_.symbolValue(thread) != Lisp.NIL || "Y"
/* 143 */         .equals(System.getProperty("abcl.autoload.verbose"))) {
/*     */         
/* 145 */         loadVerbose(this.symbol, loadDepth, this.className, getFileName());
/*     */       } else {
/* 147 */         effectiveLoad(this.className, getFileName());
/*     */       } 
/*     */     } finally {
/* 150 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */     
/* 153 */     if (this.symbol != null && 
/* 154 */       this.symbol.getSymbolFunction() instanceof Autoload) {
/* 155 */       Lisp.simple_error("Unable to autoload " + this.symbol.princToString(), new Object[] { this.symbol, this.fileName, this.className });
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected final String getFileName() {
/* 162 */     if (this.fileName != null)
/* 163 */       return this.fileName; 
/* 164 */     return this.symbol.getName().toLowerCase();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 170 */     load();
/* 171 */     return this.symbol.execute();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 177 */     load();
/* 178 */     return this.symbol.execute(arg);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 185 */     load();
/* 186 */     return this.symbol.execute(first, second);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 194 */     load();
/* 195 */     return this.symbol.execute(first, second, third);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 203 */     load();
/* 204 */     return this.symbol.execute(first, second, third, fourth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 213 */     load();
/* 214 */     return this.symbol.execute(first, second, third, fourth, fifth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 223 */     load();
/* 224 */     return this.symbol.execute(first, second, third, fourth, fifth, sixth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 234 */     load();
/* 235 */     return this.symbol.execute(first, second, third, fourth, fifth, sixth, seventh);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 246 */     load();
/* 247 */     return this.symbol.execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 254 */     load();
/* 255 */     return this.symbol.execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 261 */     StringBuilder sb = new StringBuilder();
/* 262 */     sb.append(this.symbol.princToString());
/* 263 */     sb.append(" stub to be autoloaded from \"");
/* 264 */     if (this.className != null) {
/* 265 */       int index = this.className.lastIndexOf('.');
/* 266 */       if (index >= 0) {
/* 267 */         sb.append(this.className.substring(index + 1));
/*     */       } else {
/* 269 */         sb.append(this.className);
/* 270 */       }  sb.append(".class");
/*     */     } else {
/* 272 */       sb.append(getFileName());
/* 273 */     }  sb.append("\"");
/* 274 */     return unreadableString(sb.toString());
/*     */   }
/*     */   
/* 277 */   public static final Primitive AUTOLOAD = new pf_autoload();
/*     */   
/*     */   @DocString(name = "autoload", args = "symbol-or-symbols &optional filename", doc = "Setup the autoload for SYMBOL-OR-SYMBOLS optionally corresponding to FILENAME.")
/*     */   private static final class pf_autoload
/*     */     extends Primitive {
/*     */     pf_autoload() {
/* 283 */       super("autoload", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first) {
/* 288 */       if (first instanceof Symbol) {
/* 289 */         Symbol symbol = (Symbol)first;
/* 290 */         symbol.setSymbolFunction(new Autoload(symbol));
/* 291 */         return Lisp.T;
/*     */       } 
/* 293 */       if (first instanceof Cons) {
/* 294 */         for (LispObject list = first; list != Lisp.NIL; list = list.cdr()) {
/* 295 */           Symbol symbol = Lisp.checkSymbol(list.car());
/* 296 */           symbol.setSymbolFunction(new Autoload(symbol));
/*     */         } 
/* 298 */         return Lisp.T;
/*     */       } 
/* 300 */       return Lisp.error(new TypeError(first));
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 306 */       String fileName = second.getStringValue();
/* 307 */       if (first instanceof Symbol) {
/* 308 */         Symbol symbol = (Symbol)first;
/* 309 */         symbol.setSymbolFunction(new Autoload(symbol, fileName, null));
/* 310 */         return Lisp.T;
/*     */       } 
/* 312 */       if (first instanceof Cons) {
/* 313 */         for (LispObject list = first; list != Lisp.NIL; list = list.cdr()) {
/* 314 */           Symbol symbol = Lisp.checkSymbol(list.car());
/* 315 */           symbol.setSymbolFunction(new Autoload(symbol, fileName, null));
/*     */         } 
/* 317 */         return Lisp.T;
/*     */       } 
/* 319 */       return Lisp.error(new TypeError(first));
/*     */     }
/*     */   }
/*     */   
/* 323 */   public static final Primitive RESOLVE = new pf_resolve();
/*     */   
/*     */   @DocString(name = "resolve", args = "symbol", doc = "Resolve the function named by SYMBOL via the autoloader mechanism.\nReturns either the function or NIL if no resolution was possible.")
/*     */   private static final class pf_resolve
/*     */     extends Primitive
/*     */   {
/*     */     pf_resolve() {
/* 330 */       super("resolve", Lisp.PACKAGE_EXT, true, "symbol");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 334 */       Symbol symbol = Lisp.checkSymbol(arg);
/* 335 */       LispObject fun = symbol.getSymbolFunction();
/* 336 */       if (fun instanceof Autoload) {
/* 337 */         Autoload autoload = (Autoload)fun;
/* 338 */         autoload.load();
/* 339 */         return symbol.getSymbolFunction();
/*     */       } 
/* 341 */       return (fun == null) ? Lisp.NIL : fun;
/*     */     }
/*     */   }
/*     */   
/* 345 */   public static final Primitive AUTOLOADP = new pf_autoloadp();
/*     */   
/*     */   @DocString(name = "autoloadp", args = "symbol", doc = "Boolean predicate for whether SYMBOL stands for a function that currently needs to be autoloaded.")
/*     */   private static final class pf_autoloadp
/*     */     extends Primitive {
/*     */     pf_autoloadp() {
/* 351 */       super("autoloadp", Lisp.PACKAGE_EXT, true, "symbol");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 357 */       if (arg instanceof Symbol && 
/* 358 */         arg.getSymbolFunction() instanceof Autoload) {
/* 359 */         return Lisp.T;
/*     */       }
/* 361 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */   
/*     */   static {
/* 366 */     autoload("acos", "MathFunctions");
/* 367 */     autoload("acosh", "MathFunctions");
/* 368 */     autoload("arithmetic-error-operands", "ArithmeticError");
/* 369 */     autoload("arithmetic-error-operation", "ArithmeticError");
/* 370 */     autoload("ash", "ash");
/* 371 */     autoload("asin", "MathFunctions");
/* 372 */     autoload("asinh", "MathFunctions");
/* 373 */     autoload("atan", "MathFunctions");
/* 374 */     autoload("atanh", "MathFunctions");
/* 375 */     autoload("broadcast-stream-streams", "BroadcastStream");
/* 376 */     autoload("ceiling", "ceiling");
/* 377 */     autoload("char", "StringFunctions");
/* 378 */     autoload("char-equal", "CharacterFunctions");
/* 379 */     autoload("char-greaterp", "CharacterFunctions");
/* 380 */     autoload("char-lessp", "CharacterFunctions");
/* 381 */     autoload("char-not-greaterp", "CharacterFunctions");
/* 382 */     autoload("char-not-lessp", "CharacterFunctions");
/* 383 */     autoload("char<", "CharacterFunctions");
/* 384 */     autoload("char<=", "CharacterFunctions");
/* 385 */     autoload("char=", "CharacterFunctions");
/* 386 */     autoload("cis", "MathFunctions");
/* 387 */     autoload("clrhash", "HashTableFunctions");
/* 388 */     autoload("clrhash", "HashTableFunctions");
/* 389 */     autoload("concatenated-stream-streams", "ConcatenatedStream");
/* 390 */     autoload("cos", "MathFunctions");
/* 391 */     autoload("cosh", "MathFunctions");
/* 392 */     autoload("delete-file", "delete_file");
/* 393 */     autoload(Lisp.PACKAGE_SYS, "%delete-package", "PackageFunctions");
/* 394 */     autoload("echo-stream-input-stream", "EchoStream");
/* 395 */     autoload("echo-stream-output-stream", "EchoStream");
/* 396 */     autoload("exp", "MathFunctions");
/* 397 */     autoload("expt", "MathFunctions");
/* 398 */     autoload("file-author", "file_author");
/* 399 */     autoload("file-length", "file_length");
/* 400 */     autoload("file-string-length", "file_string_length");
/* 401 */     autoload("file-write-date", "file_write_date");
/* 402 */     autoload("float", "FloatFunctions");
/* 403 */     autoload("float-digits", "FloatFunctions");
/* 404 */     autoload("float-radix", "FloatFunctions");
/* 405 */     autoload("float-sign", "float_sign");
/* 406 */     autoload("floatp", "FloatFunctions");
/* 407 */     autoload("floor", "floor");
/* 408 */     autoload("ftruncate", "ftruncate");
/* 409 */     autoload("get-internal-real-time", "Time");
/* 410 */     autoload("get-internal-run-time", "Time");
/* 411 */     autoload("get-output-stream-string", "StringOutputStream");
/* 412 */     autoload("get-properties", "get_properties");
/* 413 */     autoload("get-universal-time", "Time");
/* 414 */     autoload("gethash", "HashTableFunctions");
/* 415 */     autoload("gethash", "HashTableFunctions");
/* 416 */     autoload("hash-table-count", "HashTableFunctions");
/* 417 */     autoload("hash-table-count", "HashTableFunctions");
/* 418 */     autoload("hash-table-p", "HashTableFunctions");
/* 419 */     autoload("hash-table-p", "HashTableFunctions");
/* 420 */     autoload("hash-table-rehash-size", "HashTableFunctions");
/* 421 */     autoload("hash-table-rehash-size", "HashTableFunctions");
/* 422 */     autoload("hash-table-rehash-threshold", "HashTableFunctions");
/* 423 */     autoload("hash-table-rehash-threshold", "HashTableFunctions");
/* 424 */     autoload("hash-table-size", "HashTableFunctions");
/* 425 */     autoload("hash-table-size", "HashTableFunctions");
/* 426 */     autoload("hash-table-test", "HashTableFunctions");
/* 427 */     autoload("hash-table-test", "HashTableFunctions");
/* 428 */     autoload(Lisp.PACKAGE_SYS, "%import", "PackageFunctions");
/* 429 */     autoload("input-stream-p", "input_stream_p");
/* 430 */     autoload("integer-decode-float", "FloatFunctions");
/* 431 */     autoload("interactive-stream-p", "interactive_stream_p");
/* 432 */     autoload("last", "last");
/* 433 */     autoload("lisp-implementation-type", "lisp_implementation_type");
/* 434 */     autoload("lisp-implementation-version", "lisp_implementation_version");
/* 435 */     autoload("list-all-packages", "PackageFunctions");
/* 436 */     autoload("listen", "listen");
/* 437 */     autoload("log", "MathFunctions");
/* 438 */     autoload("logand", "logand");
/* 439 */     autoload("logandc1", "logandc1");
/* 440 */     autoload("logandc2", "logandc2");
/* 441 */     autoload("logbitp", "logbitp");
/* 442 */     autoload("logcount", "logcount");
/* 443 */     autoload("logeqv", "logeqv");
/* 444 */     autoload("logior", "logior");
/* 445 */     autoload("lognand", "lognand");
/* 446 */     autoload("lognor", "lognor");
/* 447 */     autoload("lognot", "lognot");
/* 448 */     autoload("logorc1", "logorc1");
/* 449 */     autoload("logorc2", "logorc2");
/* 450 */     autoload("logtest", "logtest");
/* 451 */     autoload("logxor", "logxor");
/* 452 */     autoload("long-site-name", "SiteName");
/* 453 */     autoload("machine-instance", "SiteName");
/* 454 */     autoload("machine-type", "machine_type");
/* 455 */     autoload("machine-version", "machine_version");
/* 456 */     autoload("make-broadcast-stream", "BroadcastStream");
/* 457 */     autoload("make-concatenated-stream", "ConcatenatedStream");
/* 458 */     autoload("make-echo-stream", "EchoStream");
/* 459 */     autoload("make-string-input-stream", "StringInputStream");
/* 460 */     autoload("make-synonym-stream", "SynonymStream");
/* 461 */     autoload("maphash", "HashTableFunctions");
/* 462 */     autoload("mod", "mod");
/* 463 */     autoload("open-stream-p", "open_stream_p");
/* 464 */     autoload("output-stream-p", "output_stream_p");
/* 465 */     autoload("package-name", "PackageFunctions");
/* 466 */     autoload("package-nicknames", "PackageFunctions");
/* 467 */     autoload("package-shadowing-symbols", "PackageFunctions");
/* 468 */     autoload("package-use-list", "PackageFunctions");
/* 469 */     autoload("package-used-by-list", "PackageFunctions");
/* 470 */     autoload("packagep", "PackageFunctions");
/* 471 */     autoload("peek-char", "peek_char");
/* 472 */     autoload("print-not-readable-object", "PrintNotReadable");
/* 473 */     autoload("probe-file", "probe_file");
/* 474 */     autoload("rational", "FloatFunctions");
/* 475 */     autoload("rem", "rem");
/* 476 */     autoload("remhash", "HashTableFunctions");
/* 477 */     autoload("remhash", "HashTableFunctions");
/* 478 */     autoload("rename-package", "PackageFunctions");
/* 479 */     autoload("room", "room");
/* 480 */     autoload("scale-float", "FloatFunctions");
/* 481 */     autoload("schar", "StringFunctions");
/* 482 */     autoload("shadow", "PackageFunctions");
/* 483 */     autoload("shadowing-import", "PackageFunctions");
/* 484 */     autoload("short-site-name", "SiteName");
/* 485 */     autoload("simple-condition-format-arguments", "SimpleCondition");
/* 486 */     autoload("simple-condition-format-control", "SimpleCondition");
/* 487 */     autoload("simple-string-p", "StringFunctions");
/* 488 */     autoload("sin", "MathFunctions");
/* 489 */     autoload("sinh", "MathFunctions");
/* 490 */     autoload("software-type", "software_type");
/* 491 */     autoload("software-version", "software_version");
/* 492 */     autoload("sqrt", "MathFunctions");
/* 493 */     autoload("stream-element-type", "stream_element_type");
/* 494 */     autoload("stream-error-stream", "StreamError");
/* 495 */     autoload("stream-external-format", "stream_external_format");
/* 496 */     autoload(Lisp.PACKAGE_SYS, "%set-stream-external-format", "Stream");
/* 497 */     autoload("stringp", "StringFunctions");
/* 498 */     autoload("sxhash", "HashTableFunctions");
/* 499 */     autoload("sxhash", "HashTableFunctions");
/* 500 */     autoload("synonym-stream-symbol", "SynonymStream");
/* 501 */     autoload("tan", "MathFunctions");
/* 502 */     autoload("tanh", "MathFunctions");
/* 503 */     autoload("truename", "probe_file");
/* 504 */     autoload("truncate", "truncate");
/* 505 */     autoload("type-error-datum", "TypeError");
/* 506 */     autoload("type-error-expected-type", "TypeError");
/* 507 */     autoload("unbound-slot-instance", "unbound_slot_instance");
/* 508 */     autoload("unexport", "PackageFunctions");
/* 509 */     autoload("unuse-package", "PackageFunctions");
/* 510 */     autoload(Lisp.PACKAGE_EXT, "arglist", "arglist", true);
/* 511 */     autoload(Lisp.PACKAGE_EXT, "assq", "assq", true);
/* 512 */     autoload(Lisp.PACKAGE_EXT, "assql", "assql", true);
/* 513 */     autoload(Lisp.PACKAGE_EXT, "file-directory-p", "probe_file", true);
/* 514 */     autoload(Lisp.PACKAGE_EXT, "gc", "gc", true);
/* 515 */     autoload(Lisp.PACKAGE_EXT, "get-floating-point-modes", "FloatFunctions", true);
/* 516 */     autoload(Lisp.PACKAGE_EXT, "get-time-zone", "Time", true);
/* 517 */     autoload(Lisp.PACKAGE_EXT, "make-slime-input-stream", "SlimeInputStream", true);
/* 518 */     autoload(Lisp.PACKAGE_EXT, "make-slime-output-stream", "SlimeOutputStream", true);
/* 519 */     autoload(Lisp.PACKAGE_EXT, "probe-directory", "probe_file", true);
/* 520 */     autoload(Lisp.PACKAGE_EXT, "set-floating-point-modes", "FloatFunctions", true);
/* 521 */     autoload(Lisp.PACKAGE_EXT, "simple-string-fill", "StringFunctions");
/* 522 */     autoload(Lisp.PACKAGE_EXT, "simple-string-search", "StringFunctions");
/* 523 */     autoload(Lisp.PACKAGE_EXT, "string-input-stream-current", "StringInputStream", true);
/* 524 */     autoload(Lisp.PACKAGE_EXT, "string-find", "StringFunctions");
/* 525 */     autoload(Lisp.PACKAGE_EXT, "string-position", "StringFunctions");
/* 526 */     autoload(Lisp.PACKAGE_EXT, "make-weak-reference", "WeakReference", true);
/* 527 */     autoload(Lisp.PACKAGE_EXT, "weak-reference-value", "WeakReference", true);
/* 528 */     autoload(Lisp.PACKAGE_EXT, "finalize", "Primitives", true);
/* 529 */     autoload(Lisp.PACKAGE_EXT, "cancel-finalization", "Primitives", true);
/* 530 */     autoload(Lisp.PACKAGE_JAVA, "%jnew-proxy", "JProxy");
/* 531 */     autoload(Lisp.PACKAGE_JAVA, "%find-java-class", "JavaObject");
/* 532 */     autoload(Lisp.PACKAGE_JAVA, "%register-java-class", "JavaObject");
/* 533 */     autoload(Lisp.PACKAGE_JAVA, "%jmake-invocation-handler", "JProxy");
/* 534 */     autoload(Lisp.PACKAGE_JAVA, "%jmake-proxy", "JProxy");
/* 535 */     autoload(Lisp.PACKAGE_JAVA, "%jnew-runtime-class", "RuntimeClass");
/* 536 */     autoload(Lisp.PACKAGE_JAVA, "%jredefine-method", "RuntimeClass");
/* 537 */     autoload(Lisp.PACKAGE_JAVA, "%jregister-handler", "JHandler");
/* 538 */     autoload(Lisp.PACKAGE_JAVA, "%load-java-class-from-byte-array", "RuntimeClass");
/* 539 */     autoload(Lisp.PACKAGE_JAVA, "get-default-classloader", "JavaClassLoader");
/* 540 */     autoload(Lisp.PACKAGE_JAVA, "make-classloader", "JavaClassLoader");
/* 541 */     autoload(Lisp.PACKAGE_JAVA, "%add-to-classpath", "JavaClassLoader");
/* 542 */     autoload(Lisp.PACKAGE_JAVA, "dump-classpath", "JavaClassLoader");
/* 543 */     autoload(Lisp.PACKAGE_MOP, "eql-specializer-object", "EqualSpecializerObject", true);
/* 544 */     autoload(Lisp.PACKAGE_MOP, "funcallable-instance-function", "FuncallableStandardObject", false);
/* 545 */     autoload(Lisp.PACKAGE_MOP, "set-funcallable-instance-function", "FuncallableStandardObject", true);
/* 546 */     autoload(Lisp.PACKAGE_PROF, "%start-profiler", "Profiler", true);
/* 547 */     autoload(Lisp.PACKAGE_PROF, "stop-profiler", "Profiler", true);
/* 548 */     autoload(Lisp.PACKAGE_SYS, "%%string=", "StringFunctions");
/* 549 */     autoload(Lisp.PACKAGE_SYS, "%adjust-array", "adjust_array");
/* 550 */     autoload(Lisp.PACKAGE_SYS, "%defpackage", "PackageFunctions");
/* 551 */     autoload(Lisp.PACKAGE_SYS, "%get-output-stream-bytes", "ByteArrayOutputStream");
/* 552 */     autoload(Lisp.PACKAGE_SYS, "%get-output-stream-array", "ByteArrayOutputStream");
/* 553 */     autoload(Lisp.PACKAGE_SYS, "%make-array", "make_array");
/* 554 */     autoload(Lisp.PACKAGE_SYS, "%make-byte-array-input-stream", "ByteArrayInputStream");
/* 555 */     autoload(Lisp.PACKAGE_SYS, "%make-byte-array-output-stream", "ByteArrayOutputStream");
/* 556 */     autoload(Lisp.PACKAGE_SYS, "%make-condition", "make_condition", true);
/* 557 */     autoload(Lisp.PACKAGE_SYS, "%make-emf-cache", "EMFCache", true);
/* 558 */     autoload(Lisp.PACKAGE_SYS, "%make-hash-table", "HashTableFunctions");
/* 559 */     autoload(Lisp.PACKAGE_SYS, "%make-hash-table", "HashTableFunctions");
/* 560 */     autoload(Lisp.PACKAGE_SYS, "%make-logical-pathname", "LogicalPathname", true);
/* 561 */     autoload(Lisp.PACKAGE_SYS, "%make-server-socket", "make_server_socket");
/* 562 */     autoload(Lisp.PACKAGE_SYS, "%make-socket", "make_socket");
/* 563 */     autoload(Lisp.PACKAGE_SYS, "%make-string", "StringFunctions");
/* 564 */     autoload(Lisp.PACKAGE_SYS, "%make-string-output-stream", "StringOutputStream");
/* 565 */     autoload(Lisp.PACKAGE_SYS, "%nstring-capitalize", "StringFunctions");
/* 566 */     autoload(Lisp.PACKAGE_SYS, "%nstring-downcase", "StringFunctions");
/* 567 */     autoload(Lisp.PACKAGE_SYS, "%nstring-upcase", "StringFunctions");
/* 568 */     autoload(Lisp.PACKAGE_SYS, "%reinit-emf-cache", "EMFCache", true);
/* 569 */     autoload(Lisp.PACKAGE_SYS, "%run-shell-command", "ShellCommand");
/* 570 */     autoload(Lisp.PACKAGE_SYS, "%server-socket-close", "server_socket_close");
/* 571 */     autoload(Lisp.PACKAGE_SYS, "%set-arglist", "arglist");
/* 572 */     autoload(Lisp.PACKAGE_CL, "find-class", "LispClass", true);
/* 573 */     autoload(Lisp.PACKAGE_SYS, "%set-find-class", "LispClass", true);
/* 574 */     autoload(Lisp.PACKAGE_SYS, "%set-class-direct-slots", "SlotClass", true);
/* 575 */     autoload(Lisp.PACKAGE_SYS, "%set-function-info", "function_info");
/* 576 */     autoload(Lisp.PACKAGE_SYS, "%set-symbol-macro", "Primitives");
/* 577 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-and", "SimpleBitVector");
/* 578 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-andc1", "SimpleBitVector");
/* 579 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-andc2", "SimpleBitVector");
/* 580 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-eqv", "SimpleBitVector");
/* 581 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-ior", "SimpleBitVector");
/* 582 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-nand", "SimpleBitVector");
/* 583 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-nor", "SimpleBitVector");
/* 584 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-not", "SimpleBitVector");
/* 585 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-orc1", "SimpleBitVector");
/* 586 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-orc2", "SimpleBitVector");
/* 587 */     autoload(Lisp.PACKAGE_SYS, "%simple-bit-vector-bit-xor", "SimpleBitVector");
/* 588 */     autoload(Lisp.PACKAGE_SYS, "%socket-accept", "socket_accept");
/* 589 */     autoload(Lisp.PACKAGE_SYS, "%socket-close", "socket_close");
/* 590 */     autoload(Lisp.PACKAGE_SYS, "%socket-stream", "socket_stream");
/* 591 */     autoload(Lisp.PACKAGE_SYS, "%string-capitalize", "StringFunctions");
/* 592 */     autoload(Lisp.PACKAGE_SYS, "%string-downcase", "StringFunctions");
/* 593 */     autoload(Lisp.PACKAGE_SYS, "%string-equal", "StringFunctions");
/* 594 */     autoload(Lisp.PACKAGE_SYS, "%string-greaterp", "StringFunctions");
/* 595 */     autoload(Lisp.PACKAGE_SYS, "%string-lessp", "StringFunctions");
/* 596 */     autoload(Lisp.PACKAGE_SYS, "%string-not-equal", "StringFunctions");
/* 597 */     autoload(Lisp.PACKAGE_SYS, "%string-not-greaterp", "StringFunctions");
/* 598 */     autoload(Lisp.PACKAGE_SYS, "%string-not-lessp", "StringFunctions");
/* 599 */     autoload(Lisp.PACKAGE_SYS, "%string-upcase", "StringFunctions");
/* 600 */     autoload(Lisp.PACKAGE_SYS, "%string/=", "StringFunctions");
/* 601 */     autoload(Lisp.PACKAGE_SYS, "%string<", "StringFunctions");
/* 602 */     autoload(Lisp.PACKAGE_SYS, "%string<=", "StringFunctions");
/* 603 */     autoload(Lisp.PACKAGE_SYS, "%string=", "StringFunctions");
/* 604 */     autoload(Lisp.PACKAGE_SYS, "%string>", "StringFunctions");
/* 605 */     autoload(Lisp.PACKAGE_SYS, "%string>=", "StringFunctions");
/* 606 */     autoload(Lisp.PACKAGE_SYS, "%time", "Time");
/* 607 */     autoload(Lisp.PACKAGE_SYS, "cache-emf", "EMFCache", true);
/* 608 */     autoload(Lisp.PACKAGE_SYS, "canonicalize-logical-host", "LogicalPathname", true);
/* 609 */     autoload(Lisp.PACKAGE_SYS, "%class-direct-slots", "SlotClass");
/* 610 */     autoload(Lisp.PACKAGE_SYS, "%float-bits", "FloatFunctions");
/* 611 */     autoload(Lisp.PACKAGE_SYS, "coerce-to-double-float", "FloatFunctions");
/* 612 */     autoload(Lisp.PACKAGE_SYS, "coerce-to-single-float", "FloatFunctions");
/* 613 */     autoload(Lisp.PACKAGE_SYS, "create-new-file", "create_new_file");
/* 614 */     autoload(Lisp.PACKAGE_SYS, "default-time-zone", "Time");
/* 615 */     autoload(Lisp.PACKAGE_SYS, "disassemble-class-bytes", "disassemble_class_bytes", true);
/* 616 */     autoload(Lisp.PACKAGE_SYS, "disable-zip-cache", "ZipCache", true);
/* 617 */     autoload(Lisp.PACKAGE_SYS, "double-float-high-bits", "FloatFunctions", true);
/* 618 */     autoload(Lisp.PACKAGE_SYS, "double-float-low-bits", "FloatFunctions", true);
/* 619 */     autoload(Lisp.PACKAGE_SYS, "float-infinity-p", "FloatFunctions", true);
/* 620 */     autoload(Lisp.PACKAGE_SYS, "float-nan-p", "FloatFunctions", true);
/* 621 */     autoload(Lisp.PACKAGE_SYS, "float-string", "FloatFunctions", true);
/* 622 */     autoload(Lisp.PACKAGE_SYS, "function-info", "function_info");
/* 623 */     autoload(Lisp.PACKAGE_SYS, "get-cached-emf", "EMFCache", true);
/* 624 */     autoload(Lisp.PACKAGE_SYS, "get-function-info-value", "function_info");
/* 625 */     autoload(Lisp.PACKAGE_SYS, "hash-table-entries", "HashTableFunctions");
/* 626 */     autoload(Lisp.PACKAGE_SYS, "hash-table-entries", "HashTableFunctions");
/* 627 */     autoload(Lisp.PACKAGE_SYS, "layout-class", "Layout", true);
/* 628 */     autoload(Lisp.PACKAGE_SYS, "layout-length", "Layout", true);
/* 629 */     autoload(Lisp.PACKAGE_SYS, "layout-slot-index", "Layout", true);
/* 630 */     autoload(Lisp.PACKAGE_SYS, "layout-slot-location", "Layout", true);
/* 631 */     autoload(Lisp.PACKAGE_SYS, "make-case-frob-stream", "CaseFrobStream");
/* 632 */     autoload(Lisp.PACKAGE_SYS, "make-double-float", "FloatFunctions", true);
/* 633 */     autoload(Lisp.PACKAGE_SYS, "make-file-stream", "FileStream");
/* 634 */     autoload(Lisp.PACKAGE_SYS, "make-fill-pointer-output-stream", "FillPointerOutputStream");
/* 635 */     autoload(Lisp.PACKAGE_SYS, "make-layout", "Layout", true);
/* 636 */     autoload(Lisp.PACKAGE_SYS, "make-single-float", "FloatFunctions", true);
/* 637 */     autoload(Lisp.PACKAGE_SYS, "%make-slot-definition", "SlotDefinition", true);
/* 638 */     autoload(Lisp.PACKAGE_SYS, "make-structure-class", "StructureClass");
/* 639 */     autoload(Lisp.PACKAGE_SYS, "make-symbol-macro", "Primitives");
/* 640 */     autoload(Lisp.PACKAGE_SYS, "psxhash", "HashTableFunctions");
/* 641 */     autoload(Lisp.PACKAGE_SYS, "puthash", "HashTableFunctions");
/* 642 */     autoload(Lisp.PACKAGE_SYS, "puthash", "HashTableFunctions");
/* 643 */     autoload(Lisp.PACKAGE_SYS, "remove-zip-cache-entry", "ZipCache");
/* 644 */     autoload(Lisp.PACKAGE_SYS, "set-function-info-value", "function_info");
/* 645 */     autoload(Lisp.PACKAGE_SYS, "simple-list-remove-duplicates", "simple_list_remove_duplicates");
/* 646 */     autoload(Lisp.PACKAGE_SYS, "single-float-bits", "FloatFunctions", true);
/* 647 */     autoload(Lisp.PACKAGE_SYS, "%std-allocate-instance", "StandardObject", true);
/* 648 */     autoload(Lisp.PACKAGE_SYS, "swap-slots", "StandardObject", true);
/* 649 */     autoload(Lisp.PACKAGE_SYS, "std-instance-layout", "StandardObject", true);
/* 650 */     autoload(Lisp.PACKAGE_SYS, "%set-std-instance-layout", "StandardObject", true);
/* 651 */     autoload(Lisp.PACKAGE_SYS, "std-instance-class", "StandardObject", true);
/* 652 */     autoload(Lisp.PACKAGE_SYS, "standard-instance-access", "StandardObject", true);
/* 653 */     autoload(Lisp.PACKAGE_SYS, "%set-standard-instance-access", "StandardObject", true);
/* 654 */     autoload(Lisp.PACKAGE_SYS, "std-slot-boundp", "StandardObject", true);
/* 655 */     autoload(Lisp.PACKAGE_SYS, "std-slot-value", "StandardObject", true);
/* 656 */     autoload(Lisp.PACKAGE_SYS, "set-std-slot-value", "StandardObject", true);
/* 657 */     autoload(Lisp.PACKAGE_SYS, "%allocate-funcallable-instance", "FuncallableStandardObject", true);
/* 658 */     autoload(Lisp.PACKAGE_SYS, "unzip", "unzip", true);
/* 659 */     autoload(Lisp.PACKAGE_SYS, "zip", "zip", true);
/*     */     
/* 661 */     autoload(Symbol.COPY_LIST, "copy_list");
/*     */     
/* 663 */     autoload(Lisp.PACKAGE_SYS, "make-fasl-class-loader", "FaslClassLoader", false);
/* 664 */     autoload(Lisp.PACKAGE_SYS, "get-fasl-function", "FaslClassLoader", false);
/*     */     
/* 666 */     autoload(Lisp.PACKAGE_SYS, "make-memory-class-loader", "MemoryClassLoader", false);
/* 667 */     autoload(Lisp.PACKAGE_SYS, "put-memory-function", "MemoryClassLoader", false);
/* 668 */     autoload(Lisp.PACKAGE_SYS, "get-memory-function", "MemoryClassLoader", false);
/*     */     
/* 670 */     autoload(Symbol.SET_CHAR, "StringFunctions");
/* 671 */     autoload(Symbol.SET_SCHAR, "StringFunctions");
/*     */     
/* 673 */     autoload(Symbol._SET_CLASS_SLOTS, "SlotClass");
/* 674 */     autoload(Symbol._CLASS_SLOTS, "SlotClass");
/*     */     
/* 676 */     autoload(Symbol.JAVA_EXCEPTION_CAUSE, "JavaException");
/* 677 */     autoload(Symbol.JCLASS_NAME, "jclass_name");
/* 678 */     autoload(Symbol.JCLASS_OF, "jclass_of");
/* 679 */     autoload(Symbol.JMETHOD_RETURN_TYPE, "jmethod_return_type");
/*     */     
/* 681 */     autoload(Lisp.PACKAGE_JAVA, "%jget-property-value", "JavaBeans", false);
/* 682 */     autoload(Lisp.PACKAGE_JAVA, "%jset-property-value", "JavaBeans", false);
/*     */     
/* 684 */     autoload(Lisp.PACKAGE_EXT, "autoload-setf-expander", "AutoloadGeneralizedReference", true);
/* 685 */     autoload(Lisp.PACKAGE_EXT, "autoload-setf-function", "AutoloadGeneralizedReference", true);
/* 686 */     autoload(Lisp.PACKAGE_EXT, "autoload-ref-p", "AutoloadGeneralizedReference", true);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Autoload.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */