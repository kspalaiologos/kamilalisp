/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.net.URL;
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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Load
/*     */ {
/*     */   public static final LispObject load(String filename) {
/*  59 */     LispThread thread = LispThread.currentThread();
/*  60 */     return load(Pathname.create(filename), 
/*  61 */         (Symbol.LOAD_VERBOSE.symbolValue(thread) != Lisp.NIL), 
/*  62 */         (Symbol.LOAD_PRINT.symbolValue(thread) != Lisp.NIL), true);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static final Pathname findLoadableFile(Pathname name) {
/*  69 */     LispObject truename = Symbol.PROBE_FILE.execute(name);
/*  70 */     if (truename instanceof Pathname) {
/*  71 */       Pathname t = (Pathname)truename;
/*  72 */       if (t.getName() != Lisp.NIL && t
/*  73 */         .getName() != null) {
/*  74 */         return t;
/*     */       }
/*     */     } 
/*  77 */     String COMPILE_FILE_TYPE = Lisp._COMPILE_FILE_TYPE_.symbolValue().getStringValue();
/*  78 */     if (name.getType() == Lisp.NIL && (name
/*  79 */       .getName() != Lisp.NIL || name.getName() != null)) {
/*  80 */       Pathname lispPathname = Pathname.create(name);
/*  81 */       lispPathname.setType(new SimpleString("lisp"));
/*  82 */       LispObject lisp = Symbol.PROBE_FILE.execute(lispPathname);
/*  83 */       Pathname abclPathname = Pathname.create(name);
/*  84 */       abclPathname.setType(new SimpleString(COMPILE_FILE_TYPE));
/*  85 */       LispObject abcl = Symbol.PROBE_FILE.execute(abclPathname);
/*  86 */       if (lisp instanceof Pathname && abcl instanceof Pathname) {
/*  87 */         lispPathname = (Pathname)lisp;
/*  88 */         abclPathname = (Pathname)abcl;
/*  89 */         long lispLastModified = lispPathname.getLastModified();
/*  90 */         long abclLastModified = abclPathname.getLastModified();
/*  91 */         if (abclLastModified > lispLastModified) {
/*  92 */           return abclPathname;
/*     */         }
/*  94 */         return lispPathname;
/*     */       } 
/*  96 */       if (abcl instanceof Pathname)
/*  97 */         return (Pathname)abcl; 
/*  98 */       if (lisp instanceof Pathname) {
/*  99 */         return (Pathname)lisp;
/*     */       }
/*     */     } 
/* 102 */     if (name.isJar() && 
/* 103 */       name.getType().equals(Lisp.NIL)) {
/* 104 */       name.setType(COMPILE_FILE_INIT_FASL_TYPE);
/* 105 */       Pathname result = findLoadableFile(name);
/* 106 */       if (result != null) {
/* 107 */         return result;
/*     */       }
/* 109 */       name.setType(new SimpleString(COMPILE_FILE_TYPE));
/* 110 */       result = findLoadableFile(name);
/* 111 */       if (result != null) {
/* 112 */         return result;
/*     */       }
/*     */     } 
/*     */     
/* 116 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject load(Pathname pathname, boolean verbose, boolean print, boolean ifDoesNotExist) {
/* 124 */     return load(pathname, verbose, print, ifDoesNotExist, false, Keyword.DEFAULT);
/*     */   }
/*     */ 
/*     */   
/*     */   public static final LispObject load(InputStream in) {
/* 129 */     return load(in, new SimpleString("UTF-8"));
/*     */   }
/*     */   
/*     */   public static final LispObject load(InputStream in, LispObject format) {
/* 133 */     Stream stream = new Stream(Symbol.SYSTEM_STREAM, in, Symbol.CHARACTER, format);
/*     */     
/* 135 */     LispThread thread = LispThread.currentThread();
/* 136 */     return loadFileFromStream(null, null, stream, 
/*     */ 
/*     */         
/* 139 */         (Symbol.LOAD_VERBOSE.symbolValue(thread) != Lisp.NIL), 
/* 140 */         (Symbol.LOAD_PRINT.symbolValue(thread) != Lisp.NIL), false);
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
/*     */   public static final LispObject load(Pathname pathname, boolean verbose, boolean print, boolean ifDoesNotExist, boolean returnLastResult, LispObject externalFormat) {
/* 152 */     Pathname mergedPathname = null;
/* 153 */     if (!pathname.isAbsolute() && !pathname.isJar()) {
/*     */       
/* 155 */       Pathname pathnameDefaults = Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue());
/* 156 */       mergedPathname = Pathname.mergePathnames(pathname, pathnameDefaults);
/*     */     } 
/* 158 */     Pathname loadableFile = findLoadableFile((mergedPathname != null) ? mergedPathname : pathname);
/*     */     
/* 160 */     Pathname truename = (loadableFile != null) ? (Pathname)Symbol.PROBE_FILE.execute(loadableFile) : null;
/*     */ 
/*     */     
/* 163 */     if (truename == null || truename.equals(Lisp.NIL)) {
/* 164 */       if (ifDoesNotExist) {
/* 165 */         return Lisp.error(new FileError("File not found: " + pathname.princToString(), pathname));
/*     */       }
/* 167 */       Debug.warn("Failed to load " + pathname.getNamestring());
/* 168 */       return Lisp.NIL;
/*     */     } 
/*     */ 
/*     */     
/* 172 */     if (ZipCache.checkZipFile(truename)) {
/* 173 */       if (truename instanceof JarPathname) {
/* 174 */         truename = JarPathname.createFromEntry((JarPathname)truename);
/*     */       } else {
/* 176 */         truename = JarPathname.createFromPathname(truename);
/*     */       } 
/* 178 */       Pathname loader = Pathname.create("__loader__._");
/* 179 */       mergedPathname = (Pathname)Symbol.MERGE_PATHNAMES.execute(loader, truename);
/*     */       
/* 181 */       LispObject initTruename = Symbol.PROBE_FILE.execute(mergedPathname);
/* 182 */       if (initTruename.equals(Lisp.NIL)) {
/*     */         
/* 184 */         Pathname p = Pathname.create(mergedPathname);
/* 185 */         p.setName(Keyword.WILD);
/* 186 */         LispObject result = Symbol.MATCH_WILD_JAR_PATHNAME.execute(p);
/*     */         
/* 188 */         if (result instanceof Cons && ((Cons)result)
/* 189 */           .length() == 1 && ((Cons)result)
/* 190 */           .car() instanceof Pathname) {
/* 191 */           initTruename = result.car();
/*     */         
/*     */         }
/*     */         else {
/*     */ 
/*     */           
/* 197 */           String errorMessage = "Loadable FASL not found for " + pathname.printObject() + " in " + mergedPathname.printObject();
/* 198 */           if (ifDoesNotExist) {
/* 199 */             return Lisp.error(new FileError(errorMessage, mergedPathname));
/*     */           }
/* 201 */           Debug.trace(errorMessage);
/* 202 */           return Lisp.NIL;
/*     */         } 
/*     */       } 
/*     */       
/* 206 */       truename = (Pathname)initTruename;
/*     */     } 
/*     */     
/* 209 */     InputStream in = truename.getInputStream();
/* 210 */     Debug.assertTrue((in != null));
/*     */     
/*     */     try {
/* 213 */       return loadFileFromStream(pathname, truename, new Stream(Symbol.SYSTEM_STREAM, in, Symbol.CHARACTER, externalFormat), verbose, print, false, returnLastResult);
/*     */     
/*     */     }
/*     */     finally {
/*     */       
/* 218 */       if (in != null) {
/*     */         try {
/* 220 */           in.close();
/*     */         }
/* 222 */         catch (IOException e) {
/* 223 */           return Lisp.error(new LispError(e.getMessage()));
/*     */         } 
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispObject loadSystemFile(String filename, boolean auto) {
/* 231 */     LispThread thread = LispThread.currentThread();
/* 232 */     if (auto) {
/* 233 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */ 
/*     */       
/* 236 */       thread.bindSpecial(Symbol.CURRENT_READTABLE, Lisp.STANDARD_READTABLE
/* 237 */           .symbolValue(thread));
/* 238 */       thread.bindSpecial(Symbol.READ_BASE, Fixnum.constants[10]);
/* 239 */       thread.bindSpecial(Symbol.READ_SUPPRESS, Lisp.NIL);
/* 240 */       thread.bindSpecial(Symbol.READ_EVAL, Lisp.T);
/* 241 */       thread.bindSpecial(Symbol.READ_DEFAULT_FLOAT_FORMAT, Symbol.SINGLE_FLOAT);
/* 242 */       thread.bindSpecial(Symbol._PACKAGE_, Lisp.PACKAGE_CL_USER);
/*     */       try {
/* 244 */         return loadSystemFile(filename, 
/* 245 */             (Lisp._AUTOLOAD_VERBOSE_.symbolValue(thread) != Lisp.NIL), 
/* 246 */             (Symbol.LOAD_PRINT.symbolValue(thread) != Lisp.NIL), auto);
/*     */       }
/*     */       finally {
/*     */         
/* 250 */         thread.resetSpecialBindings(mark);
/*     */       } 
/*     */     } 
/* 253 */     return loadSystemFile(filename, 
/* 254 */         (Symbol.LOAD_VERBOSE.symbolValue(thread) != Lisp.NIL), 
/* 255 */         (Symbol.LOAD_PRINT.symbolValue(thread) != Lisp.NIL), auto);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 260 */   private static final Symbol FASL_LOADER = Lisp.PACKAGE_SYS.intern("*FASL-LOADER*");
/*     */   
/* 262 */   static final LispObject COMPILE_FILE_INIT_FASL_TYPE = new SimpleString("_");
/*     */   
/*     */   private static final Pathname coercePathnameOrNull(LispObject p) {
/* 265 */     if (p == null) {
/* 266 */       return null;
/*     */     }
/* 268 */     Pathname result = null;
/*     */     try {
/* 270 */       result = (Pathname)p;
/* 271 */     } catch (Throwable t) {
/* 272 */       return null;
/*     */     } 
/* 274 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final LispObject loadSystemFile(String filename, boolean verbose, boolean print, boolean auto) {
/*     */     Pathname mergedPathname;
/* 283 */     InputStream in = null;
/* 284 */     Pathname pathname = null;
/* 285 */     Pathname truename = null;
/* 286 */     pathname = Pathname.create(filename);
/* 287 */     LispObject bootPath = Site.getLispHome();
/*     */     
/* 289 */     if (bootPath instanceof Pathname) {
/* 290 */       mergedPathname = (Pathname)Symbol.MERGE_PATHNAMES.execute(pathname, bootPath);
/*     */ 
/*     */       
/* 293 */       if (mergedPathname.getDevice().equals(Lisp.NIL) && !Utilities.isPlatformWindows)
/*     */       {
/* 295 */         mergedPathname.setDevice(Keyword.UNSPECIFIC);
/*     */       }
/*     */     } else {
/* 298 */       mergedPathname = pathname;
/*     */     } 
/* 300 */     URL url = null;
/* 301 */     Pathname loadableFile = findLoadableFile(mergedPathname);
/* 302 */     if (loadableFile == null) {
/* 303 */       truename = null;
/*     */     } else {
/* 305 */       truename = (Pathname)Symbol.PROBE_FILE.execute(loadableFile);
/*     */     } 
/*     */ 
/*     */     
/* 309 */     String COMPILE_FILE_TYPE = Lisp._COMPILE_FILE_TYPE_.symbolValue().getStringValue();
/*     */     
/* 311 */     if (truename == null || truename.equals(Lisp.NIL) || bootPath.equals(Lisp.NIL)) {
/*     */       
/* 313 */       String path = pathname.asEntryPath();
/* 314 */       url = Lisp.class.getResource(path);
/* 315 */       if (url == null || url.toString().endsWith("/")) {
/* 316 */         url = Lisp.class.getResource(path.replace('-', '_') + "." + COMPILE_FILE_TYPE);
/* 317 */         if (url == null) {
/* 318 */           url = Lisp.class.getResource(path + ".lisp");
/*     */         }
/*     */       } 
/* 321 */       if (url == null) {
/* 322 */         return Lisp.error(new LispError("Failed to find loadable system file '" + path + "' in boot classpath."));
/*     */       }
/*     */ 
/*     */       
/* 326 */       if (!bootPath.equals(Lisp.NIL)) {
/* 327 */         Pathname urlPathname = URLPathname.create(url);
/* 328 */         loadableFile = findLoadableFile(urlPathname);
/* 329 */         truename = (Pathname)Symbol.PROBE_FILE.execute(loadableFile);
/* 330 */         if (truename.equals(Lisp.NIL)) {
/* 331 */           return Lisp.error(new LispError("Failed to find loadable system file in boot classpath '" + url + "'"));
/*     */         }
/*     */       } else {
/*     */         
/* 335 */         truename = null;
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/* 340 */     if (truename != null && truename
/* 341 */       .getType().princToString().equals(COMPILE_FILE_TYPE) && ZipCache.checkZipFile(truename)) {
/* 342 */       Pathname init = Pathname.create(truename.getNamestring());
/* 343 */       init.setType(COMPILE_FILE_INIT_FASL_TYPE);
/* 344 */       init.setName(new SimpleString("__loader__"));
/* 345 */       LispObject t = Symbol.PROBE_FILE.execute(init);
/* 346 */       if (t instanceof Pathname) {
/* 347 */         truename = (Pathname)t;
/*     */       } else {
/* 349 */         return Lisp.error(new LispError("Failed to find loadable init FASL in '" + init
/* 350 */               .getNamestring() + "'"));
/*     */       } 
/*     */     } 
/*     */     
/* 354 */     if (truename != null) {
/* 355 */       in = truename.getInputStream();
/*     */     } else {
/*     */       try {
/* 358 */         Debug.assertTrue((url != null));
/* 359 */         in = url.openStream();
/* 360 */       } catch (IOException e) {
/* 361 */         Lisp.error(new FileError("Failed to load system file: '" + filename + "' from URL: '" + url + "'"));
/*     */       } 
/*     */     } 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 368 */     if (in != null) {
/* 369 */       LispThread thread = LispThread.currentThread();
/* 370 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/* 371 */       thread.bindSpecial(Lisp._WARN_ON_REDEFINITION_, Lisp.NIL);
/* 372 */       thread.bindSpecial(FASL_LOADER, Lisp.NIL);
/*     */       try {
/* 374 */         Stream stream = new Stream(Symbol.SYSTEM_STREAM, in, Symbol.CHARACTER);
/* 375 */         return loadFileFromStream(pathname, truename, stream, verbose, print, auto);
/*     */       } finally {
/*     */         
/* 378 */         thread.resetSpecialBindings(mark);
/*     */         try {
/* 380 */           in.close();
/*     */         }
/* 382 */         catch (IOException e) {
/* 383 */           return Lisp.error(new LispError(e.getMessage()));
/*     */         } 
/*     */       } 
/*     */     } 
/* 387 */     return Lisp.error(new FileError("Failed to load system file: '" + filename + "' resolved as '" + mergedPathname + "'", truename));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 397 */   static final Symbol _FASL_VERSION_ = Lisp.exportConstant("*FASL-VERSION*", Lisp.PACKAGE_SYS, Fixnum.getInstance(43));
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 402 */   private static final Symbol _FASL_EXTERNAL_FORMAT_ = Lisp.internConstant("*FASL-EXTERNAL-FORMAT*", Lisp.PACKAGE_SYS, new SimpleString("UTF-8"));
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
/* 414 */   public static final Symbol _FASL_UNINTERNED_SYMBOLS_ = Lisp.internSpecial("*FASL-UNINTERNED-SYMBOLS*", Lisp.PACKAGE_SYS, Lisp.NIL);
/*     */ 
/*     */   
/*     */   public static final LispObject getUninternedSymbol(int n) {
/* 418 */     LispThread thread = LispThread.currentThread();
/*     */     
/* 420 */     LispObject uninternedSymbols = _FASL_UNINTERNED_SYMBOLS_.symbolValue(thread);
/*     */     
/* 422 */     if (!(uninternedSymbols instanceof Cons)) {
/* 423 */       return uninternedSymbols.AREF(n);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/* 428 */     LispObject label = LispInteger.getInstance(n);
/* 429 */     while (uninternedSymbols != Lisp.NIL) {
/*     */       
/* 431 */       LispObject item = uninternedSymbols.car();
/* 432 */       if (label.eql(item.cdr())) {
/* 433 */         return item.car();
/*     */       }
/* 435 */       uninternedSymbols = uninternedSymbols.cdr();
/*     */     } 
/* 437 */     return Lisp.error(new LispError("No entry for uninterned symbol."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 442 */   private static final Primitive INIT_FASL = new init_fasl();
/*     */   
/*     */   private static class init_fasl extends Primitive { init_fasl() {
/* 445 */       super("init-fasl", Lisp.PACKAGE_SYS, true, "&key version");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 451 */       LispThread thread = LispThread.currentThread();
/* 452 */       if (first == Keyword.VERSION && 
/* 453 */         second.eql(Load._FASL_VERSION_.getSymbolValue())) {
/*     */         
/* 455 */         thread.bindSpecial(Load._FASL_UNINTERNED_SYMBOLS_, Lisp.NIL);
/* 456 */         thread.bindSpecial(Lisp._SOURCE_, Lisp.NIL);
/* 457 */         return Load.faslLoadStream(thread);
/*     */       } 
/*     */       
/* 460 */       return 
/* 461 */         Lisp.error(new SimpleError("FASL version mismatch; found '" + second
/* 462 */             .princToString() + "' but expected '" + Load._FASL_VERSION_
/* 463 */             .getSymbolValue().princToString() + "' in " + Symbol.LOAD_PATHNAME
/*     */             
/* 465 */             .symbolValue(thread).princToString() + " (try recompiling the file)"));
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static final LispObject loadFileFromStream(Pathname pathname, Pathname truename, Stream in, boolean verbose, boolean print, boolean auto) {
/* 477 */     return loadFileFromStream((pathname == null) ? Lisp.NIL : pathname, (truename == null) ? Lisp.NIL : truename, in, verbose, print, auto, false);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 482 */   private static Symbol[] savedSpecials = new Symbol[] { Symbol.CURRENT_READTABLE, Symbol._PACKAGE_, Lisp._SPEED_, Lisp._SPACE_, Lisp._SAFETY_, Lisp._DEBUG_, Lisp._EXPLAIN_ };
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
/*     */   private static final LispObject loadFileFromStream(LispObject pathname, LispObject truename, Stream in, boolean verbose, boolean print, boolean auto, boolean returnLastResult) {
/* 498 */     long start = System.currentTimeMillis();
/* 499 */     LispThread thread = LispThread.currentThread();
/* 500 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */     
/* 502 */     for (Symbol special : savedSpecials) {
/* 503 */       thread.bindSpecialToCurrentValue(special);
/*     */     }
/* 505 */     thread.bindSpecial(Lisp._BACKQUOTE_COUNT_, Fixnum.getInstance(0));
/* 506 */     int loadDepth = Fixnum.getValue(Lisp._LOAD_DEPTH_.symbolValue(thread));
/* 507 */     thread.bindSpecial(Lisp._LOAD_DEPTH_, Fixnum.getInstance(++loadDepth));
/* 508 */     String prefix = getLoadVerbosePrefix(loadDepth);
/*     */     try {
/* 510 */       thread.bindSpecial(Symbol.LOAD_PATHNAME, pathname);
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
/* 525 */       Pathname truePathname = null;
/* 526 */       if (!truename.equals(Lisp.NIL)) {
/* 527 */         if (truename instanceof Pathname) {
/* 528 */           if (truename instanceof JarPathname) {
/* 529 */             truePathname = new JarPathname();
/* 530 */           } else if (truename instanceof URLPathname) {
/* 531 */             truePathname = new URLPathname();
/*     */           } else {
/* 533 */             truePathname = new Pathname();
/*     */           } 
/* 535 */           truePathname.copyFrom((Pathname)truename);
/* 536 */         } else if (truename instanceof AbstractString) {
/* 537 */           truePathname = Pathname.create(truename.getStringValue());
/*     */         } else {
/* 539 */           Debug.assertTrue(false);
/*     */         } 
/* 541 */         if (truePathname.getType().equal(Lisp._COMPILE_FILE_TYPE_.symbolValue(thread)) || truePathname
/* 542 */           .getType().equal(COMPILE_FILE_INIT_FASL_TYPE)) {
/* 543 */           Pathname truenameFasl = Pathname.create(truePathname);
/* 544 */           thread.bindSpecial(Symbol.LOAD_TRUENAME_FASL, truenameFasl);
/*     */         } 
/* 546 */         if (truePathname.getType().equal(COMPILE_FILE_INIT_FASL_TYPE) && truePathname
/* 547 */           .isJar()) {
/*     */ 
/*     */           
/* 550 */           LispObject possibleTruePathname = probe_file.PROBE_FILE.execute(pathname);
/* 551 */           if (!possibleTruePathname.equals(Lisp.NIL)) {
/* 552 */             truePathname = (Pathname)possibleTruePathname;
/*     */           }
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
/* 577 */           thread.bindSpecial(Symbol.LOAD_TRUENAME, truePathname);
/*     */         } else {
/* 579 */           thread.bindSpecial(Symbol.LOAD_TRUENAME, truename);
/*     */         } 
/*     */       } else {
/* 582 */         thread.bindSpecial(Symbol.LOAD_TRUENAME, truename);
/*     */       } 
/* 584 */       thread.bindSpecial(Lisp._SOURCE_, (pathname != null) ? pathname : Lisp.NIL);
/*     */       
/* 586 */       if (verbose) {
/* 587 */         Stream out = Lisp.getStandardOutput();
/* 588 */         out.freshLine();
/* 589 */         out._writeString(prefix);
/* 590 */         out._writeString(auto ? " Autoloading " : " Loading ");
/* 591 */         out._writeString(!truename.equals(Lisp.NIL) ? truePathname.princToString() : "stream");
/* 592 */         out._writeLine(" ...");
/* 593 */         out._finishOutput();
/* 594 */         LispObject result = loadStream(in, print, thread, returnLastResult);
/* 595 */         long elapsed = System.currentTimeMillis() - start;
/* 596 */         out.freshLine();
/* 597 */         out._writeString(prefix);
/* 598 */         out._writeString(auto ? " Autoloaded " : " Loaded ");
/* 599 */         out._writeString(!truename.equals(Lisp.NIL) ? truePathname.princToString() : "stream");
/* 600 */         out._writeString(" (");
/* 601 */         out._writeString(String.valueOf((float)elapsed / 1000.0F));
/* 602 */         out._writeLine(" seconds)");
/* 603 */         out._finishOutput();
/* 604 */         return result;
/*     */       } 
/* 606 */       return loadStream(in, print, thread, returnLastResult);
/*     */     } finally {
/*     */       
/* 609 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public static String getLoadVerbosePrefix(int loadDepth) {
/* 615 */     StringBuilder sb = new StringBuilder(";");
/* 616 */     for (int i = loadDepth - 1; i-- > 0;)
/* 617 */       sb.append(' '); 
/* 618 */     return sb.toString();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static final LispObject loadStream(Stream in, boolean print, LispThread thread, boolean returnLastResult) {
/* 625 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 626 */     thread.bindSpecial(Lisp._LOAD_STREAM_, in);
/*     */     
/* 628 */     SpecialBinding sourcePositionBinding = thread.bindSpecial(Lisp._SOURCE_POSITION_, Fixnum.ZERO);
/*     */     try {
/* 630 */       Environment env = new Environment();
/* 631 */       LispObject result = Lisp.NIL;
/*     */       while (true) {
/* 633 */         sourcePositionBinding.value = Fixnum.getInstance(in.getOffset());
/* 634 */         LispObject obj = in.read(false, Lisp.EOF, false, thread, Stream.currentReadtable);
/*     */         
/* 636 */         if (obj == Lisp.EOF)
/*     */           break; 
/* 638 */         result = Lisp.eval(obj, env, thread);
/* 639 */         if (print) {
/*     */           
/* 641 */           Stream out = Lisp.checkCharacterOutputStream(Symbol.STANDARD_OUTPUT.symbolValue(thread));
/* 642 */           out._writeLine(result.printObject());
/* 643 */           out._finishOutput();
/*     */         } 
/*     */       } 
/* 646 */       if (returnLastResult) {
/* 647 */         return result;
/*     */       }
/* 649 */       return Lisp.T;
/*     */     }
/*     */     finally {
/*     */       
/* 653 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   static final LispObject faslLoadStream(LispThread thread) {
/* 659 */     Stream in = (Stream)Lisp._LOAD_STREAM_.symbolValue(thread);
/* 660 */     Environment env = new Environment();
/* 661 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 662 */     LispObject result = Lisp.NIL;
/*     */     
/*     */     try {
/* 665 */       thread.bindSpecial(Symbol.READ_BASE, LispInteger.getInstance(10));
/* 666 */       thread.bindSpecial(Symbol.READ_EVAL, Symbol.T);
/* 667 */       thread.bindSpecial(Symbol.READ_SUPPRESS, Nil.NIL);
/*     */       
/* 669 */       in.setExternalFormat(_FASL_EXTERNAL_FORMAT_.symbolValue(thread));
/*     */       while (true) {
/* 671 */         LispObject obj = in.read(false, Lisp.EOF, false, thread, Stream.faslReadtable);
/*     */ 
/*     */         
/* 674 */         if (obj == Lisp.EOF)
/*     */           break; 
/* 676 */         result = Lisp.eval(obj, env, thread);
/*     */       } 
/*     */     } finally {
/*     */       
/* 680 */       thread.resetSpecialBindings(mark);
/*     */     } 
/* 682 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 691 */   private static final Primitive _LOAD = new _load();
/*     */   
/*     */   private static class _load extends Primitive { _load() {
/* 694 */       super("%load", Lisp.PACKAGE_SYS, false, "filespec verbose print if-does-not-exist external-format");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject filespec, LispObject verbose, LispObject print, LispObject ifDoesNotExist, LispObject externalFormat) {
/* 702 */       return Load.load(filespec, verbose, print, ifDoesNotExist, Lisp.NIL, externalFormat);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 707 */   private static final Primitive _LOAD_RETURNING_LAST_RESULT = new _load_returning_last_result();
/*     */   
/*     */   private static class _load_returning_last_result extends Primitive { _load_returning_last_result() {
/* 710 */       super("%load-returning-last-result", Lisp.PACKAGE_SYS, false, "filespec verbose print if-does-not-exist external-format");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject filespec, LispObject verbose, LispObject print, LispObject ifDoesNotExist, LispObject externalFormat) {
/* 717 */       return Load.load(filespec, verbose, print, ifDoesNotExist, Lisp.T, externalFormat);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject load(LispObject filespec, LispObject verbose, LispObject print, LispObject ifDoesNotExist, LispObject returnLastResult, LispObject externalFormat) {
/* 728 */     if (filespec instanceof Stream && (
/* 729 */       (Stream)filespec).isOpen()) {
/*     */       LispObject lispObject1;
/*     */       LispObject truename;
/* 732 */       if (filespec instanceof FileStream) {
/* 733 */         lispObject1 = ((FileStream)filespec).getPathname();
/*     */       } else {
/* 735 */         lispObject1 = Lisp.NIL;
/*     */       } 
/* 737 */       if (lispObject1 instanceof Pathname) {
/* 738 */         truename = lispObject1;
/*     */       } else {
/* 740 */         truename = Lisp.NIL;
/* 741 */       }  return loadFileFromStream(lispObject1, truename, (Stream)filespec, (verbose != Lisp.NIL), (print != Lisp.NIL), false, (returnLastResult != Lisp.NIL));
/*     */     } 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 751 */     Pathname pathname = Lisp.coerceToPathname(filespec);
/* 752 */     if (pathname instanceof LogicalPathname)
/* 753 */       pathname = LogicalPathname.translateLogicalPathname((LogicalPathname)pathname); 
/* 754 */     return load(pathname, (verbose != Lisp.NIL), (print != Lisp.NIL), (ifDoesNotExist != Lisp.NIL), (returnLastResult != Lisp.NIL), externalFormat);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 763 */   private static final Primitive LOAD_SYSTEM_FILE = new load_system_file();
/*     */   
/*     */   private static class load_system_file extends Primitive { load_system_file() {
/* 766 */       super("load-system-file", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 771 */       LispThread thread = LispThread.currentThread();
/* 772 */       return Load.loadSystemFile(arg.getStringValue(), (Symbol.LOAD_VERBOSE
/* 773 */           .symbolValue(thread) != Lisp.NIL || 
/* 774 */           System.getProperty("abcl.autoload.verbose") != null), 
/* 775 */           (Symbol.LOAD_PRINT.symbolValue(thread) != Lisp.NIL), false);
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Load.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */