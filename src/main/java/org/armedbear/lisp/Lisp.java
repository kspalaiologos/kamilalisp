/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.ByteArrayOutputStream;
/*      */ import java.io.File;
/*      */ import java.io.IOException;
/*      */ import java.io.InputStream;
/*      */ import java.io.InputStreamReader;
/*      */ import java.io.Reader;
/*      */ import java.io.StringReader;
/*      */ import java.math.BigInteger;
/*      */ import java.net.URL;
/*      */ import java.nio.charset.Charset;
/*      */ import java.util.Date;
/*      */ import java.util.concurrent.ConcurrentHashMap;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public final class Lisp
/*      */ {
/*      */   public static final boolean debug = true;
/*      */   public static boolean cold = true;
/*      */   public static boolean initialized;
/*   59 */   public static final Package PACKAGE_CL = Packages.createPackage("COMMON-LISP", 2048);
/*      */   
/*   61 */   public static final Package PACKAGE_CL_USER = Packages.createPackage("COMMON-LISP-USER", 1024);
/*      */   
/*   63 */   public static final Package PACKAGE_KEYWORD = Packages.createPackage("KEYWORD", 1024);
/*      */   
/*   65 */   public static final Package PACKAGE_SYS = Packages.createPackage("SYSTEM", 2048);
/*      */   
/*   67 */   public static final Package PACKAGE_MOP = Packages.createPackage("MOP", 512);
/*      */   
/*   69 */   public static final Package PACKAGE_TPL = Packages.createPackage("TOP-LEVEL", 128);
/*      */   
/*   71 */   public static final Package PACKAGE_EXT = Packages.createPackage("EXTENSIONS", 256);
/*      */   
/*   73 */   public static final Package PACKAGE_JVM = Packages.createPackage("JVM", 2048);
/*      */   
/*   75 */   public static final Package PACKAGE_LOOP = Packages.createPackage("LOOP", 512);
/*      */   
/*   77 */   public static final Package PACKAGE_PROF = Packages.createPackage("PROFILER");
/*      */   
/*   79 */   public static final Package PACKAGE_JAVA = Packages.createPackage("JAVA");
/*      */   
/*   81 */   public static final Package PACKAGE_LISP = Packages.createPackage("LISP");
/*      */   
/*   83 */   public static final Package PACKAGE_THREADS = Packages.createPackage("THREADS");
/*      */   
/*   85 */   public static final Package PACKAGE_FORMAT = Packages.createPackage("FORMAT");
/*      */   
/*   87 */   public static final Package PACKAGE_XP = Packages.createPackage("XP");
/*      */   
/*   89 */   public static final Package PACKAGE_PRECOMPILER = Packages.createPackage("PRECOMPILER");
/*      */   
/*   91 */   public static final Package PACKAGE_SEQUENCE = Packages.createPackage("SEQUENCE", 128);
/*      */ 
/*      */   
/*      */   @DocString(name = "nil")
/*   95 */   public static final Symbol NIL = Nil.NIL;
/*      */ 
/*      */ 
/*      */   
/*      */   static {
/*  100 */     PACKAGE_CL.addNickname("CL");
/*  101 */     PACKAGE_CL_USER.addNickname("CL-USER");
/*  102 */     PACKAGE_CL_USER.usePackage(PACKAGE_CL);
/*  103 */     PACKAGE_CL_USER.usePackage(PACKAGE_EXT);
/*  104 */     PACKAGE_CL_USER.usePackage(PACKAGE_JAVA);
/*  105 */     PACKAGE_SYS.addNickname("SYS");
/*  106 */     PACKAGE_SYS.usePackage(PACKAGE_CL);
/*  107 */     PACKAGE_SYS.usePackage(PACKAGE_EXT);
/*  108 */     PACKAGE_MOP.usePackage(PACKAGE_CL);
/*  109 */     PACKAGE_MOP.usePackage(PACKAGE_EXT);
/*  110 */     PACKAGE_MOP.usePackage(PACKAGE_SYS);
/*  111 */     PACKAGE_TPL.addNickname("TPL");
/*  112 */     PACKAGE_TPL.usePackage(PACKAGE_CL);
/*  113 */     PACKAGE_TPL.usePackage(PACKAGE_EXT);
/*  114 */     PACKAGE_EXT.addNickname("EXT");
/*  115 */     PACKAGE_EXT.usePackage(PACKAGE_CL);
/*  116 */     PACKAGE_EXT.usePackage(PACKAGE_THREADS);
/*  117 */     PACKAGE_JVM.usePackage(PACKAGE_CL);
/*  118 */     PACKAGE_JVM.usePackage(PACKAGE_EXT);
/*  119 */     PACKAGE_JVM.usePackage(PACKAGE_SYS);
/*  120 */     PACKAGE_LOOP.usePackage(PACKAGE_CL);
/*  121 */     PACKAGE_PROF.addNickname("PROF");
/*  122 */     PACKAGE_PROF.usePackage(PACKAGE_CL);
/*  123 */     PACKAGE_PROF.usePackage(PACKAGE_EXT);
/*  124 */     PACKAGE_JAVA.usePackage(PACKAGE_CL);
/*  125 */     PACKAGE_JAVA.usePackage(PACKAGE_EXT);
/*  126 */     PACKAGE_LISP.usePackage(PACKAGE_CL);
/*  127 */     PACKAGE_LISP.usePackage(PACKAGE_EXT);
/*  128 */     PACKAGE_LISP.usePackage(PACKAGE_SYS);
/*  129 */     PACKAGE_THREADS.usePackage(PACKAGE_CL);
/*  130 */     PACKAGE_THREADS.usePackage(PACKAGE_EXT);
/*  131 */     PACKAGE_THREADS.usePackage(PACKAGE_SYS);
/*  132 */     PACKAGE_FORMAT.usePackage(PACKAGE_CL);
/*  133 */     PACKAGE_FORMAT.usePackage(PACKAGE_EXT);
/*  134 */     PACKAGE_XP.usePackage(PACKAGE_CL);
/*  135 */     PACKAGE_PRECOMPILER.addNickname("PRE");
/*  136 */     PACKAGE_PRECOMPILER.usePackage(PACKAGE_CL);
/*  137 */     PACKAGE_PRECOMPILER.usePackage(PACKAGE_EXT);
/*  138 */     PACKAGE_PRECOMPILER.usePackage(PACKAGE_SYS);
/*  139 */     PACKAGE_SEQUENCE.usePackage(PACKAGE_CL);
/*      */   }
/*      */ 
/*      */   
/*  143 */   public static final LispObject EOF = new LispObject();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  150 */   public static final int randomStringHashBase = (int)(new Date()).getTime();
/*      */ 
/*      */   
/*      */   public static boolean profiling;
/*      */ 
/*      */   
/*      */   public static boolean sampling;
/*      */ 
/*      */   
/*      */   public static volatile boolean sampleNow;
/*      */ 
/*      */   
/*      */   public static final LispObject funcall(LispObject fun, LispObject[] args, LispThread thread) {
/*  163 */     thread._values = null;
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  168 */     switch (args.length) {
/*      */       
/*      */       case 0:
/*  171 */         return thread.execute(fun);
/*      */       case 1:
/*  173 */         return thread.execute(fun, args[0]);
/*      */       case 2:
/*  175 */         return thread.execute(fun, args[0], args[1]);
/*      */       case 3:
/*  177 */         return thread.execute(fun, args[0], args[1], args[2]);
/*      */       case 4:
/*  179 */         return thread.execute(fun, args[0], args[1], args[2], args[3]);
/*      */       case 5:
/*  181 */         return thread.execute(fun, args[0], args[1], args[2], args[3], args[4]);
/*      */       
/*      */       case 6:
/*  184 */         return thread.execute(fun, args[0], args[1], args[2], args[3], args[4], args[5]);
/*      */       
/*      */       case 7:
/*  187 */         return thread.execute(fun, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
/*      */       
/*      */       case 8:
/*  190 */         return thread.execute(fun, args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
/*      */     } 
/*      */     
/*  193 */     return thread.execute(fun, args);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject macroexpand(LispObject form, Environment env, LispThread thread) {
/*  202 */     LispObject expanded = NIL;
/*      */     
/*      */     while (true) {
/*  205 */       form = macroexpand_1(form, env, thread);
/*  206 */       LispObject[] values = thread._values;
/*  207 */       if (values[1] == NIL) {
/*      */         
/*  209 */         values[1] = expanded;
/*  210 */         return form;
/*      */       } 
/*  212 */       expanded = T;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject macroexpand_1(LispObject form, Environment env, LispThread thread) {
/*  221 */     if (form instanceof Cons) {
/*      */       
/*  223 */       LispObject car = ((Cons)form).car;
/*  224 */       if (car instanceof Symbol)
/*      */       {
/*  226 */         LispObject obj = env.lookupFunction(car);
/*  227 */         if (obj instanceof AutoloadMacro) {
/*      */ 
/*      */ 
/*      */ 
/*      */           
/*  232 */           Autoload autoload = (Autoload)obj;
/*  233 */           autoload.load();
/*  234 */           obj = car.getSymbolFunction();
/*      */         } 
/*  236 */         if (obj instanceof SpecialOperator) {
/*      */           
/*  238 */           obj = get(car, Symbol.MACROEXPAND_MACRO, null);
/*  239 */           if (obj instanceof Autoload) {
/*      */             
/*  241 */             Autoload autoload = (Autoload)obj;
/*  242 */             autoload.load();
/*  243 */             obj = get(car, Symbol.MACROEXPAND_MACRO, null);
/*      */           } 
/*      */         } 
/*  246 */         if (obj instanceof MacroObject)
/*      */         {
/*  248 */           LispObject expander = ((MacroObject)obj).expander;
/*  249 */           if (profiling && 
/*  250 */             !sampling) {
/*  251 */             expander.incrementCallCount();
/*      */           }
/*  253 */           LispObject hook = coerceToFunction(Symbol.MACROEXPAND_HOOK.symbolValue(thread));
/*  254 */           return thread.setValues(hook.execute(expander, form, env), T);
/*      */         }
/*      */       
/*      */       }
/*      */     
/*  259 */     } else if (form instanceof Symbol) {
/*      */       
/*  261 */       Symbol symbol = (Symbol)form;
/*  262 */       LispObject obj = env.lookup(symbol);
/*  263 */       if (obj == null) {
/*  264 */         obj = symbol.getSymbolMacro();
/*      */       }
/*  266 */       if (obj instanceof SymbolMacro) {
/*  267 */         return thread.setValues(((SymbolMacro)obj).getExpansion(), T);
/*      */       }
/*      */     } 
/*      */     
/*  271 */     return thread.setValues(form, NIL);
/*      */   }
/*      */   
/*      */   @DocString(name = "interactive-eval")
/*  275 */   private static final Primitive INTERACTIVE_EVAL = new Primitive("interactive-eval", PACKAGE_SYS, true)
/*      */     {
/*      */       public LispObject execute(LispObject object)
/*      */       {
/*      */         LispObject result;
/*      */         
/*  281 */         LispThread thread = LispThread.currentThread();
/*  282 */         thread.setSpecialVariable(Symbol.MINUS, object);
/*      */ 
/*      */         
/*      */         try {
/*  286 */           result = thread.execute(Symbol.EVAL.getSymbolFunction(), object);
/*      */         }
/*  288 */         catch (OutOfMemoryError e) {
/*      */           
/*  290 */           return Lisp.error(new StorageCondition("Out of memory " + e.getMessage()));
/*      */         }
/*  292 */         catch (StackOverflowError e) {
/*      */           
/*  294 */           thread.setSpecialVariable(Lisp._SAVED_BACKTRACE_, thread
/*  295 */               .backtrace(0));
/*  296 */           return Lisp.error(new StorageCondition("Stack overflow."));
/*      */         }
/*  298 */         catch (ControlTransfer c) {
/*      */           
/*  300 */           throw c;
/*      */         }
/*  302 */         catch (ProcessingTerminated c) {
/*      */           
/*  304 */           throw c;
/*      */         }
/*  306 */         catch (IntegrityError c) {
/*      */           
/*  308 */           throw c;
/*      */         }
/*  310 */         catch (Throwable t) {
/*      */           
/*  312 */           Debug.trace(t);
/*  313 */           thread.setSpecialVariable(Lisp._SAVED_BACKTRACE_, thread
/*  314 */               .backtrace(0));
/*  315 */           return Lisp.error(new LispError("Caught " + t + "."));
/*      */         } 
/*  317 */         Debug.assertTrue((result != null));
/*  318 */         thread.setSpecialVariable(Symbol.STAR_STAR_STAR, thread
/*  319 */             .safeSymbolValue(Symbol.STAR_STAR));
/*  320 */         thread.setSpecialVariable(Symbol.STAR_STAR, thread
/*  321 */             .safeSymbolValue(Symbol.STAR));
/*  322 */         thread.setSpecialVariable(Symbol.STAR, result);
/*  323 */         thread.setSpecialVariable(Symbol.PLUS_PLUS_PLUS, thread
/*  324 */             .safeSymbolValue(Symbol.PLUS_PLUS));
/*  325 */         thread.setSpecialVariable(Symbol.PLUS_PLUS, thread
/*  326 */             .safeSymbolValue(Symbol.PLUS));
/*  327 */         thread.setSpecialVariable(Symbol.PLUS, thread
/*  328 */             .safeSymbolValue(Symbol.MINUS));
/*  329 */         LispObject[] values = thread._values;
/*  330 */         thread.setSpecialVariable(Symbol.SLASH_SLASH_SLASH, thread
/*  331 */             .safeSymbolValue(Symbol.SLASH_SLASH));
/*  332 */         thread.setSpecialVariable(Symbol.SLASH_SLASH, thread
/*  333 */             .safeSymbolValue(Symbol.SLASH));
/*  334 */         if (values != null) {
/*      */           
/*  336 */           LispObject slash = Lisp.NIL;
/*  337 */           for (int i = values.length; i-- > 0;)
/*  338 */             slash = new Cons(values[i], slash); 
/*  339 */           thread.setSpecialVariable(Symbol.SLASH, slash);
/*      */         } else {
/*      */           
/*  342 */           thread.setSpecialVariable(Symbol.SLASH, new Cons(result));
/*  343 */         }  return result;
/*      */       }
/*      */     };
/*      */   public static volatile boolean interrupted; public static volatile LispThread threadToInterrupt; public static final int CALL_REGISTERS_MAX = 8;
/*      */   
/*      */   private static final void pushJavaStackFrames() {
/*  349 */     LispThread thread = LispThread.currentThread();
/*  350 */     StackTraceElement[] frames = thread.getJavaStackTrace();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  356 */     if (frames.length > 5 && frames[3]
/*  357 */       .getClassName().equals("org.armedbear.lisp.Lisp") && frames[3]
/*  358 */       .getMethodName().equals("error") && frames[4]
/*  359 */       .getClassName().startsWith("org.armedbear.lisp.Lisp") && frames[4]
/*  360 */       .getMethodName().equals("eval")) {
/*      */       return;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  367 */     int last = frames.length - 1;
/*  368 */     for (int i = 0; i <= last; i++) {
/*  369 */       if (frames[i].getClassName().startsWith("org.armedbear.lisp.Primitive")) {
/*  370 */         last = i;
/*      */       }
/*      */     } 
/*      */     
/*  374 */     while (last > 2) {
/*  375 */       thread.pushStackFrame(new JavaStackFrame(frames[last]));
/*  376 */       last--;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject error(LispObject condition) {
/*  383 */     pushJavaStackFrames();
/*  384 */     return Symbol.ERROR.execute(condition);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject stackError() {
/*  389 */     pushJavaStackFrames();
/*  390 */     return Symbol.ERROR.execute(new StorageCondition("Stack overflow."));
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject memoryError(OutOfMemoryError exception) {
/*  395 */     pushJavaStackFrames();
/*  396 */     return Symbol.ERROR.execute(new StorageCondition("Out of memory: " + exception
/*  397 */           .getMessage()));
/*      */   }
/*      */ 
/*      */   
/*      */   public static final int ierror(LispObject condition) {
/*  402 */     error(condition);
/*  403 */     return 0;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final String serror(LispObject condition) {
/*  408 */     error(condition);
/*  409 */     return "";
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject error(LispObject condition, LispObject message) {
/*  415 */     pushJavaStackFrames();
/*  416 */     return Symbol.ERROR.execute(condition, Keyword.FORMAT_CONTROL, message);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final int ierror(LispObject condition, LispObject message) {
/*  421 */     error(condition, message);
/*  422 */     return 0;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final String serror(LispObject condition, LispObject message) {
/*  427 */     error(condition, message);
/*  428 */     return "";
/*      */   }
/*      */   
/*      */   public static final LispObject parse_error(String message) {
/*  432 */     return error(new ParseError(message));
/*      */   }
/*      */   
/*      */   public static final LispObject simple_error(String formatControl, Object... args) {
/*  436 */     LispObject lispArgs = NIL;
/*  437 */     for (int i = 0; i < args.length; i++) {
/*  438 */       if (args[i] instanceof LispObject) {
/*  439 */         lispArgs = lispArgs.push((LispObject)args[i]);
/*  440 */       } else if (args[i] instanceof String) {
/*  441 */         lispArgs = lispArgs.push(new SimpleString((String)args[i]));
/*      */       } else {
/*  443 */         lispArgs = lispArgs.push(new JavaObject(args[i]));
/*      */       } 
/*      */     } 
/*  446 */     lispArgs = lispArgs.nreverse();
/*      */     
/*  448 */     LispObject format = new SimpleString(formatControl);
/*      */     
/*  450 */     SimpleError s = new SimpleError(format, lispArgs);
/*  451 */     return error(s);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject type_error(LispObject datum, LispObject expectedType) {
/*  457 */     return error(new TypeError(datum, expectedType));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject type_error(String message, LispObject datum, LispObject expectedType) {
/*  463 */     return error(new TypeError(message, datum, expectedType));
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject program_error(String message) {
/*  468 */     return error(new ProgramError(message));
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject program_error(LispObject initArgs) {
/*  473 */     return error(new ProgramError(initArgs));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final synchronized void setInterrupted(LispThread thread, boolean b) {
/*  481 */     if (b) {
/*  482 */       threadToInterrupt = thread;
/*      */     } else {
/*  484 */       threadToInterrupt = null;
/*  485 */     }  interrupted = b;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final synchronized void handleInterrupt() {
/*  490 */     LispThread currentThread = LispThread.currentThread();
/*  491 */     LispThread checkThread = threadToInterrupt;
/*  492 */     setInterrupted(null, false);
/*  493 */     if (currentThread == threadToInterrupt || threadToInterrupt == null)
/*      */     {
/*      */       
/*  496 */       currentThread.processThreadInterrupts();
/*      */     }
/*  498 */     setInterrupted(null, false);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject loadTimeValue(LispObject obj) {
/*  505 */     LispThread thread = LispThread.currentThread();
/*  506 */     if (Symbol.LOAD_TRUENAME.symbolValue(thread) != NIL) {
/*  507 */       return eval(obj, new Environment(), thread);
/*      */     }
/*  509 */     return NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject eval(LispObject obj) {
/*  515 */     return eval(obj, new Environment(), LispThread.currentThread());
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject eval(LispObject obj, Environment env, LispThread thread) {
/*  523 */     thread._values = null;
/*  524 */     if (interrupted)
/*  525 */       handleInterrupt(); 
/*  526 */     if (thread.isDestroyed())
/*  527 */       throw new ThreadDestroyed(); 
/*  528 */     if (obj instanceof Symbol) {
/*      */       LispObject result;
/*  530 */       Symbol symbol = (Symbol)obj;
/*      */       
/*  532 */       if (symbol.isSpecialVariable()) {
/*      */         
/*  534 */         if (symbol.constantp()) {
/*  535 */           return symbol.getSymbolValue();
/*      */         }
/*  537 */         result = thread.lookupSpecial(symbol);
/*      */       }
/*  539 */       else if (env.isDeclaredSpecial(symbol)) {
/*  540 */         result = thread.lookupSpecial(symbol);
/*      */       } else {
/*  542 */         result = env.lookup(symbol);
/*  543 */       }  if (result == null) {
/*      */         
/*  545 */         result = symbol.getSymbolMacro();
/*  546 */         if (result == null) {
/*  547 */           result = symbol.getSymbolValue();
/*      */         }
/*  549 */         if (result == null) {
/*  550 */           return error(new UnboundVariable(obj));
/*      */         }
/*      */       } 
/*  553 */       if (result instanceof SymbolMacro)
/*  554 */         return eval(((SymbolMacro)result).getExpansion(), env, thread); 
/*  555 */       return result;
/*      */     } 
/*  557 */     if (obj instanceof Cons) {
/*      */       
/*  559 */       LispObject first = ((Cons)obj).car;
/*  560 */       if (first instanceof Symbol) {
/*      */         
/*  562 */         LispObject fun = env.lookupFunction(first);
/*  563 */         if (fun instanceof SpecialOperator) {
/*      */           
/*  565 */           if (profiling && 
/*  566 */             !sampling) {
/*  567 */             fun.incrementCallCount();
/*      */           }
/*  569 */           return fun.execute(((Cons)obj).cdr, env);
/*      */         } 
/*  571 */         if (fun instanceof MacroObject) {
/*      */           
/*      */           try {
/*      */             
/*  575 */             thread.envStack.push(new Environment(null, NIL, fun));
/*  576 */             return eval(macroexpand(obj, env, thread), env, thread);
/*      */           } finally {
/*      */             
/*  579 */             thread.envStack.pop();
/*      */           } 
/*      */         }
/*  582 */         if (fun instanceof Autoload) {
/*      */           
/*  584 */           Autoload autoload = (Autoload)fun;
/*  585 */           autoload.load();
/*  586 */           return eval(obj, env, thread);
/*      */         } 
/*  588 */         return evalCall((fun != null) ? fun : first, ((Cons)obj).cdr, env, thread);
/*      */       } 
/*      */ 
/*      */ 
/*      */       
/*  593 */       if (first instanceof Cons && first.car() == Symbol.LAMBDA) {
/*      */         
/*  595 */         Closure closure = new Closure(first, env);
/*  596 */         return evalCall(closure, ((Cons)obj).cdr, env, thread);
/*      */       } 
/*      */       
/*  599 */       return program_error("Illegal function object: " + first
/*  600 */           .princToString() + ".");
/*      */     } 
/*      */ 
/*      */     
/*  604 */     return obj;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject evalCall(LispObject function, LispObject args, Environment env, LispThread thread) {
/*  616 */     if (args == NIL) {
/*  617 */       return thread.execute(function);
/*      */     }
/*  619 */     LispObject first = eval(args.car(), env, thread);
/*  620 */     args = ((Cons)args).cdr;
/*  621 */     if (args == NIL) {
/*  622 */       thread._values = null;
/*  623 */       return thread.execute(function, first);
/*      */     } 
/*  625 */     LispObject second = eval(args.car(), env, thread);
/*  626 */     args = ((Cons)args).cdr;
/*  627 */     if (args == NIL) {
/*  628 */       thread._values = null;
/*  629 */       return thread.execute(function, first, second);
/*      */     } 
/*  631 */     LispObject third = eval(args.car(), env, thread);
/*  632 */     args = ((Cons)args).cdr;
/*  633 */     if (args == NIL) {
/*  634 */       thread._values = null;
/*  635 */       return thread.execute(function, first, second, third);
/*      */     } 
/*  637 */     LispObject fourth = eval(args.car(), env, thread);
/*  638 */     args = ((Cons)args).cdr;
/*  639 */     if (args == NIL) {
/*  640 */       thread._values = null;
/*  641 */       return thread.execute(function, first, second, third, fourth);
/*      */     } 
/*  643 */     LispObject fifth = eval(args.car(), env, thread);
/*  644 */     args = ((Cons)args).cdr;
/*  645 */     if (args == NIL) {
/*  646 */       thread._values = null;
/*  647 */       return thread.execute(function, first, second, third, fourth, fifth);
/*      */     } 
/*  649 */     LispObject sixth = eval(args.car(), env, thread);
/*  650 */     args = ((Cons)args).cdr;
/*  651 */     if (args == NIL) {
/*  652 */       thread._values = null;
/*  653 */       return thread.execute(function, first, second, third, fourth, fifth, sixth);
/*      */     } 
/*      */     
/*  656 */     LispObject seventh = eval(args.car(), env, thread);
/*  657 */     args = ((Cons)args).cdr;
/*  658 */     if (args == NIL) {
/*  659 */       thread._values = null;
/*  660 */       return thread.execute(function, first, second, third, fourth, fifth, sixth, seventh);
/*      */     } 
/*      */     
/*  663 */     LispObject eighth = eval(args.car(), env, thread);
/*  664 */     args = ((Cons)args).cdr;
/*  665 */     if (args == NIL) {
/*  666 */       thread._values = null;
/*  667 */       return thread.execute(function, first, second, third, fourth, fifth, sixth, seventh, eighth);
/*      */     } 
/*      */ 
/*      */     
/*  671 */     int length = args.length() + 8;
/*  672 */     LispObject[] array = new LispObject[length];
/*  673 */     array[0] = first;
/*  674 */     array[1] = second;
/*  675 */     array[2] = third;
/*  676 */     array[3] = fourth;
/*  677 */     array[4] = fifth;
/*  678 */     array[5] = sixth;
/*  679 */     array[6] = seventh;
/*  680 */     array[7] = eighth;
/*  681 */     for (int i = 8; i < length; i++) {
/*  682 */       array[i] = eval(args.car(), env, thread);
/*  683 */       args = args.cdr();
/*      */     } 
/*  685 */     thread._values = null;
/*  686 */     return thread.execute(function, array);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject parseBody(LispObject body, boolean documentationAllowed) {
/*  693 */     LispObject decls = NIL;
/*  694 */     LispObject doc = NIL;
/*      */     
/*  696 */     while (body != NIL) {
/*  697 */       LispObject form = body.car();
/*  698 */       if (documentationAllowed && form instanceof AbstractString && body
/*  699 */         .cdr() != NIL) {
/*  700 */         doc = body.car();
/*  701 */         documentationAllowed = false;
/*  702 */       } else if (form instanceof Cons && form.car() == Symbol.DECLARE) {
/*  703 */         decls = new Cons(form, decls);
/*      */       } else {
/*      */         break;
/*      */       } 
/*  707 */       body = body.cdr();
/*      */     } 
/*  709 */     return list(body, new LispObject[] { decls.nreverse(), doc });
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject parseSpecials(LispObject forms) {
/*  715 */     LispObject specials = NIL;
/*  716 */     while (forms != NIL) {
/*  717 */       LispObject decls = forms.car();
/*      */       
/*  719 */       Debug.assertTrue(decls instanceof Cons);
/*  720 */       Debug.assertTrue((decls.car() == Symbol.DECLARE));
/*  721 */       decls = decls.cdr();
/*  722 */       while (decls != NIL) {
/*  723 */         LispObject decl = decls.car();
/*      */         
/*  725 */         if (decl instanceof Cons && decl.car() == Symbol.SPECIAL) {
/*  726 */           decl = decl.cdr();
/*  727 */           while (decl != NIL) {
/*  728 */             specials = new Cons(checkSymbol(decl.car()), specials);
/*  729 */             decl = decl.cdr();
/*      */           } 
/*      */         } 
/*      */         
/*  733 */         decls = decls.cdr();
/*      */       } 
/*      */       
/*  736 */       forms = forms.cdr();
/*      */     } 
/*      */     
/*  739 */     return specials;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject progn(LispObject body, Environment env, LispThread thread) {
/*  746 */     LispObject result = NIL;
/*  747 */     while (body != NIL) {
/*      */       
/*  749 */       result = eval(body.car(), env, thread);
/*  750 */       body = ((Cons)body).cdr;
/*      */     } 
/*  752 */     return result;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject preprocessTagBody(LispObject body, Environment env) {
/*  759 */     LispObject localTags = NIL;
/*  760 */     while (body != NIL) {
/*      */       
/*  762 */       LispObject current = body.car();
/*  763 */       body = ((Cons)body).cdr;
/*  764 */       if (current instanceof Cons) {
/*      */         continue;
/*      */       }
/*  767 */       env.addTagBinding(current, body);
/*  768 */       localTags = new Cons(current, localTags);
/*      */     } 
/*  770 */     return localTags;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject nonLocalGo(LispObject tagbody, LispObject tag) {
/*  783 */     if (tagbody == null) {
/*  784 */       return error(new ControlError("Unmatched tag " + tag
/*  785 */             .princToString() + " for GO outside lexical extent."));
/*      */     }
/*      */     
/*  788 */     throw new Go(tagbody, tag);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject nonLocalGo(Binding binding, LispObject tag) {
/*  800 */     if (binding.env.inactive) {
/*  801 */       return error(new ControlError("Unmatched tag " + binding.symbol
/*  802 */             .princToString() + " for GO outside of lexical extent."));
/*      */     }
/*      */     
/*  805 */     throw new Go(binding.env, binding.symbol);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject nonLocalReturn(LispObject blockId, LispObject blockName, LispObject result) {
/*  819 */     if (blockId == null) {
/*  820 */       return error(new ControlError("Unmatched block " + blockName
/*  821 */             .princToString() + " for RETURN-FROM outside lexical extent."));
/*      */     }
/*      */     
/*  824 */     throw new Return(blockId, result);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject nonLocalReturn(Binding binding, Symbol block, LispObject result) {
/*  837 */     if (binding == null)
/*      */     {
/*  839 */       return error(new LispError("No block named " + block.getName() + " is currently visible."));
/*      */     }
/*      */ 
/*      */     
/*  843 */     if (binding.env.inactive) {
/*  844 */       return error(new ControlError("Unmatched block " + binding.symbol
/*  845 */             .princToString() + " for RETURN-FROM outside of lexical extent."));
/*      */     }
/*      */ 
/*      */     
/*  849 */     throw new Return(binding.symbol, binding.value, result);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject processTagBody(LispObject body, LispObject localTags, Environment env) {
/*  857 */     LispObject remaining = body;
/*  858 */     LispThread thread = LispThread.currentThread();
/*  859 */     while (remaining != NIL) {
/*      */       
/*  861 */       LispObject current = remaining.car();
/*  862 */       if (current instanceof Cons) {
/*      */         
/*      */         try {
/*      */           
/*  866 */           if (((Cons)current).car == Symbol.GO) {
/*      */             
/*  868 */             if (interrupted)
/*  869 */               handleInterrupt(); 
/*  870 */             LispObject tag = current.cadr();
/*  871 */             Binding binding = env.getTagBinding(tag);
/*  872 */             if (binding == null) {
/*  873 */               return error(new ControlError("No tag named " + tag
/*  874 */                     .princToString() + " is currently visible."));
/*      */             }
/*  876 */             if (memql(tag, localTags))
/*      */             {
/*  878 */               if (binding.value != null) {
/*      */                 
/*  880 */                 remaining = binding.value;
/*      */                 continue;
/*      */               } 
/*      */             }
/*  884 */             throw new Go(binding.env, tag);
/*      */           } 
/*  886 */           eval(current, env, thread);
/*      */         }
/*  888 */         catch (Go go) {
/*      */           LispObject tag;
/*      */           
/*  891 */           if (go.getTagBody() == env && 
/*  892 */             memql(tag = go.getTag(), localTags)) {
/*      */             
/*  894 */             Binding binding = env.getTagBinding(tag);
/*  895 */             if (binding != null && binding.value != null) {
/*      */               
/*  897 */               remaining = binding.value;
/*      */               continue;
/*      */             } 
/*      */           } 
/*  901 */           throw go;
/*      */         } 
/*      */       }
/*  904 */       remaining = ((Cons)remaining).cdr;
/*      */     } 
/*  906 */     thread._values = null;
/*  907 */     return NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   static final boolean isSpecial(Symbol sym, LispObject ownSpecials) {
/*  913 */     if (ownSpecials != null) {
/*      */       
/*  915 */       if (sym.isSpecialVariable())
/*  916 */         return true; 
/*  917 */       for (; ownSpecials != NIL; ownSpecials = ownSpecials.cdr()) {
/*      */         
/*  919 */         if (sym == ownSpecials.car())
/*  920 */           return true; 
/*      */       } 
/*      */     } 
/*  923 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final void bindArg(LispObject ownSpecials, Symbol sym, LispObject value, Environment env, LispThread thread) {
/*  931 */     if (isSpecial(sym, ownSpecials)) {
/*  932 */       env.declareSpecial(sym);
/*  933 */       thread.bindSpecial(sym, value);
/*      */     } else {
/*      */       
/*  936 */       env.bind(sym, value);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public static void bindArg(boolean special, Symbol sym, LispObject value, Environment env, LispThread thread) {
/*  942 */     if (special) {
/*  943 */       env.declareSpecial(sym);
/*  944 */       thread.bindSpecial(sym, value);
/*      */     } else {
/*      */       
/*  947 */       env.bind(sym, value);
/*      */     } 
/*      */   }
/*      */   public static LispObject list(LispObject[] obj) {
/*  951 */     LispObject theList = NIL;
/*  952 */     if (obj.length > 0)
/*  953 */       for (int i = obj.length - 1; i >= 0; i--)
/*  954 */         theList = new Cons(obj[i], theList);  
/*  955 */     return theList;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Cons list(LispObject obj1, LispObject... remaining) {
/*  960 */     Cons theList = null;
/*  961 */     if (remaining.length > 0) {
/*  962 */       theList = new Cons(remaining[remaining.length - 1]);
/*  963 */       for (int i = remaining.length - 2; i >= 0; i--)
/*  964 */         theList = new Cons(remaining[i], theList); 
/*      */     } 
/*  966 */     return (theList == null) ? new Cons(obj1) : new Cons(obj1, theList);
/*      */   }
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list1(LispObject obj1) {
/*  972 */     return new Cons(obj1);
/*      */   }
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list2(LispObject obj1, LispObject obj2) {
/*  978 */     return new Cons(obj1, new Cons(obj2));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list3(LispObject obj1, LispObject obj2, LispObject obj3) {
/*  985 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3)));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list4(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4) {
/*  992 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list5(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5) {
/* 1003 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4, new Cons(obj5)))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list6(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5, LispObject obj6) {
/* 1015 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4, new Cons(obj5, new Cons(obj6))))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list7(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5, LispObject obj6, LispObject obj7) {
/* 1029 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4, new Cons(obj5, new Cons(obj6, new Cons(obj7)))))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list8(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5, LispObject obj6, LispObject obj7, LispObject obj8) {
/* 1044 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4, new Cons(obj5, new Cons(obj6, new Cons(obj7, new Cons(obj8))))))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final Cons list9(LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5, LispObject obj6, LispObject obj7, LispObject obj8, LispObject obj9) {
/* 1061 */     return new Cons(obj1, new Cons(obj2, new Cons(obj3, new Cons(obj4, new Cons(obj5, new Cons(obj6, new Cons(obj7, new Cons(obj8, new Cons(obj9)))))))));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject multipleValueList(LispObject result) {
/* 1076 */     LispThread thread = LispThread.currentThread();
/* 1077 */     LispObject[] values = thread._values;
/* 1078 */     if (values == null)
/* 1079 */       return new Cons(result); 
/* 1080 */     thread._values = null;
/* 1081 */     LispObject list = NIL;
/* 1082 */     for (int i = values.length; i-- > 0;)
/* 1083 */       list = new Cons(values[i], list); 
/* 1084 */     return list;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject multipleValueCall1(LispObject result, LispObject function, LispThread thread) {
/* 1093 */     LispObject[] values = thread._values;
/* 1094 */     thread._values = null;
/* 1095 */     if (values == null) {
/* 1096 */       return thread.execute(coerceToFunction(function), result);
/*      */     }
/* 1098 */     return funcall(coerceToFunction(function), values, thread);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final void progvBindVars(LispObject symbols, LispObject values, LispThread thread) {
/* 1106 */     for (LispObject list = symbols; list != NIL; list = list.cdr()) {
/*      */       LispObject value;
/* 1108 */       Symbol symbol = checkSymbol(list.car());
/*      */       
/* 1110 */       if (values != NIL) {
/*      */         
/* 1112 */         value = values.car();
/* 1113 */         values = values.cdr();
/*      */       
/*      */       }
/*      */       else {
/*      */ 
/*      */         
/* 1119 */         value = null;
/*      */       } 
/* 1121 */       thread.bindSpecial(symbol, value);
/*      */     } 
/*      */   }
/*      */   
/*      */   public static final LispInteger checkInteger(LispObject obj) {
/* 1126 */     if (obj instanceof LispInteger)
/* 1127 */       return (LispInteger)obj; 
/* 1128 */     return 
/* 1129 */       (LispInteger)type_error(obj, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Symbol checkSymbol(LispObject obj) {
/* 1134 */     if (obj instanceof Symbol)
/* 1135 */       return (Symbol)obj; 
/* 1136 */     return 
/* 1137 */       (Symbol)type_error(obj, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject checkList(LispObject obj) {
/* 1143 */     if (obj.listp())
/* 1144 */       return obj; 
/* 1145 */     return type_error(obj, Symbol.LIST);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final AbstractArray checkArray(LispObject obj) {
/* 1151 */     if (obj instanceof AbstractArray)
/* 1152 */       return (AbstractArray)obj; 
/* 1153 */     return 
/* 1154 */       (AbstractArray)type_error(obj, Symbol.ARRAY);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final AbstractVector checkVector(LispObject obj) {
/* 1160 */     if (obj instanceof AbstractVector)
/* 1161 */       return (AbstractVector)obj; 
/* 1162 */     return 
/* 1163 */       (AbstractVector)type_error(obj, Symbol.VECTOR);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final DoubleFloat checkDoubleFloat(LispObject obj) {
/* 1169 */     if (obj instanceof DoubleFloat)
/* 1170 */       return (DoubleFloat)obj; 
/* 1171 */     return 
/* 1172 */       (DoubleFloat)type_error(obj, Symbol.DOUBLE_FLOAT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final SingleFloat checkSingleFloat(LispObject obj) {
/* 1178 */     if (obj instanceof SingleFloat)
/* 1179 */       return (SingleFloat)obj; 
/* 1180 */     return 
/* 1181 */       (SingleFloat)type_error(obj, Symbol.SINGLE_FLOAT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final StackFrame checkStackFrame(LispObject obj) {
/* 1187 */     if (obj instanceof StackFrame)
/* 1188 */       return (StackFrame)obj; 
/* 1189 */     return 
/* 1190 */       (StackFrame)type_error(obj, Symbol.STACK_FRAME);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   static {
/* 1196 */     Symbol.GENSYM_COUNTER.initializeSpecial(Fixnum.ZERO);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Symbol gensym(LispThread thread) {
/* 1202 */     return gensym("G", thread);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Symbol gensym(String prefix, LispThread thread) {
/*      */     LispObject oldValue;
/* 1208 */     StringBuilder sb = new StringBuilder(prefix);
/* 1209 */     Symbol gensymCounter = Symbol.GENSYM_COUNTER;
/* 1210 */     SpecialBinding binding = thread.getSpecialBinding(gensymCounter);
/*      */     
/* 1212 */     if (binding != null) {
/* 1213 */       oldValue = binding.value;
/* 1214 */       if ((oldValue instanceof Fixnum || oldValue instanceof Bignum) && Fixnum.ZERO
/* 1215 */         .isLessThanOrEqualTo(oldValue)) {
/* 1216 */         binding.value = oldValue.incr();
/*      */       } else {
/*      */         
/* 1219 */         binding.value = Fixnum.ZERO;
/* 1220 */         error(new TypeError("The value of *GENSYM-COUNTER* was not a nonnegative integer. Old value: " + oldValue
/* 1221 */               .princToString() + " New value: 0"));
/*      */       }
/*      */     
/*      */     } else {
/*      */       
/* 1226 */       synchronized (gensymCounter) {
/* 1227 */         oldValue = gensymCounter.getSymbolValue();
/* 1228 */         if ((oldValue instanceof Fixnum || oldValue instanceof Bignum) && Fixnum.ZERO
/* 1229 */           .isLessThanOrEqualTo(oldValue)) {
/* 1230 */           gensymCounter.setSymbolValue(oldValue.incr());
/*      */         } else {
/*      */           
/* 1233 */           gensymCounter.setSymbolValue(Fixnum.ZERO);
/* 1234 */           error(new TypeError("The value of *GENSYM-COUNTER* was not a nonnegative integer. Old value: " + oldValue
/* 1235 */                 .princToString() + " New value: 0"));
/*      */         } 
/*      */       } 
/*      */     } 
/*      */ 
/*      */     
/* 1241 */     if (oldValue instanceof Fixnum) {
/* 1242 */       sb.append(((Fixnum)oldValue).value);
/* 1243 */     } else if (oldValue instanceof Bignum) {
/* 1244 */       sb.append(((Bignum)oldValue).value.toString());
/*      */     } 
/* 1246 */     return new Symbol(new SimpleString(sb));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final String javaString(LispObject arg) {
/* 1252 */     if (arg instanceof AbstractString)
/* 1253 */       return arg.getStringValue(); 
/* 1254 */     if (arg instanceof Symbol)
/* 1255 */       return ((Symbol)arg).getName(); 
/* 1256 */     if (arg instanceof LispCharacter)
/* 1257 */       return String.valueOf(new char[] { ((LispCharacter)arg).value }); 
/* 1258 */     type_error(arg, list(Symbol.OR, new LispObject[] { Symbol.STRING, Symbol.SYMBOL, Symbol.CHARACTER }));
/*      */ 
/*      */     
/* 1261 */     return null;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject number(long n) {
/* 1266 */     if (n >= -2147483648L && n <= 2147483647L) {
/* 1267 */       return Fixnum.getInstance((int)n);
/*      */     }
/* 1269 */     return Bignum.getInstance(n);
/*      */   }
/*      */   
/* 1272 */   private static final BigInteger INT_MIN = BigInteger.valueOf(-2147483648L);
/* 1273 */   private static final BigInteger INT_MAX = BigInteger.valueOf(2147483647L);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject number(BigInteger numerator, BigInteger denominator) {
/* 1279 */     if (denominator.signum() == 0) {
/*      */       
/* 1281 */       LispObject operands = new Cons(Bignum.getInstance(numerator), new Cons(Bignum.getInstance(denominator)));
/* 1282 */       LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.SLASH, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*      */ 
/*      */ 
/*      */ 
/*      */       
/* 1287 */       error(new DivisionByZero(args));
/*      */     } 
/* 1289 */     if (denominator.signum() < 0) {
/*      */       
/* 1291 */       numerator = numerator.negate();
/* 1292 */       denominator = denominator.negate();
/*      */     } 
/* 1294 */     BigInteger gcd = numerator.gcd(denominator);
/* 1295 */     if (!gcd.equals(BigInteger.ONE)) {
/*      */       
/* 1297 */       numerator = numerator.divide(gcd);
/* 1298 */       denominator = denominator.divide(gcd);
/*      */     } 
/* 1300 */     if (denominator.equals(BigInteger.ONE)) {
/* 1301 */       return number(numerator);
/*      */     }
/* 1303 */     return new Ratio(numerator, denominator);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final LispObject number(BigInteger n) {
/* 1308 */     if (n.compareTo(INT_MIN) >= 0 && n.compareTo(INT_MAX) <= 0) {
/* 1309 */       return Fixnum.getInstance(n.intValue());
/*      */     }
/* 1311 */     return Bignum.getInstance(n);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final int mod(int number, int divisor) {
/*      */     int r;
/*      */     try {
/* 1320 */       r = number % divisor;
/*      */     }
/* 1322 */     catch (ArithmeticException e) {
/*      */       
/* 1324 */       error(new ArithmeticError("Division by zero."));
/*      */       
/* 1326 */       return 0;
/*      */     } 
/* 1328 */     if (r == 0)
/* 1329 */       return r; 
/* 1330 */     if (divisor < 0) {
/*      */       
/* 1332 */       if (number > 0) {
/* 1333 */         return r + divisor;
/*      */       
/*      */       }
/*      */     }
/* 1337 */     else if (number < 0) {
/* 1338 */       return r + divisor;
/*      */     } 
/* 1340 */     return r;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final int mix(long x, long y) {
/* 1346 */     long xy = x * 3L + y;
/* 1347 */     return (int)(0x1FFFFFFFL & (0x1A510271L ^ xy ^ xy >> 5L));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static LispObject readObjectFromString(String s) {
/* 1353 */     return readObjectFromReader(new StringReader(s));
/*      */   }
/*      */   
/* 1356 */   static final Charset UTF8CHARSET = Charset.forName("UTF-8");
/*      */   
/*      */   public static LispObject readObjectFromStream(InputStream s) {
/* 1359 */     return readObjectFromReader(new InputStreamReader(s));
/*      */   }
/*      */ 
/*      */   
/*      */   public static LispObject readObjectFromReader(Reader r) {
/* 1364 */     LispThread thread = LispThread.currentThread();
/* 1365 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*      */     try {
/* 1367 */       thread.bindSpecial(Symbol.READ_BASE, LispInteger.getInstance(10));
/* 1368 */       thread.bindSpecial(Symbol.READ_EVAL, Symbol.T);
/* 1369 */       thread.bindSpecial(Symbol.READ_SUPPRESS, Nil.NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */       
/* 1376 */       return (new Stream(Symbol.SYSTEM_STREAM, r)).read(true, NIL, false, 
/* 1377 */           LispThread.currentThread(), Stream.faslReadtable);
/*      */     }
/*      */     finally {
/*      */       
/* 1381 */       thread.resetSpecialBindings(mark);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   @Deprecated
/*      */   public static final LispObject loadCompiledFunction(String namestring) {
/* 1388 */     Pathname name = Pathname.create(namestring);
/* 1389 */     byte[] bytes = readFunctionBytes(name);
/* 1390 */     if (bytes != null) {
/* 1391 */       return loadClassBytes(bytes);
/*      */     }
/* 1393 */     return null;
/*      */   }
/*      */   
/*      */   public static byte[] readFunctionBytes(Pathname name) {
/* 1397 */     LispThread thread = LispThread.currentThread();
/* 1398 */     Pathname load = null;
/* 1399 */     LispObject truenameFasl = Symbol.LOAD_TRUENAME_FASL.symbolValue(thread);
/* 1400 */     LispObject truename = Symbol.LOAD_TRUENAME.symbolValue(thread);
/* 1401 */     if (truenameFasl instanceof Pathname) {
/* 1402 */       load = Pathname.mergePathnames(name, (Pathname)truenameFasl, Keyword.NEWEST);
/* 1403 */     } else if (truename instanceof Pathname) {
/* 1404 */       load = Pathname.mergePathnames(name, (Pathname)truename, Keyword.NEWEST);
/*      */     }
/* 1406 */     else if (!Symbol.PROBE_FILE.execute(name).equals(NIL)) {
/* 1407 */       load = name;
/*      */     } else {
/* 1409 */       load = null;
/*      */     } 
/*      */     
/* 1412 */     InputStream input = null;
/* 1413 */     if (load != null) {
/* 1414 */       input = load.getInputStream();
/*      */     } else {
/*      */       
/* 1417 */       URL url = null;
/*      */       try {
/* 1419 */         url = Lisp.class.getResource(name.getNamestring());
/* 1420 */         input = url.openStream();
/* 1421 */       } catch (IOException e) {
/* 1422 */         System.err.println("Failed to read class bytes from boot class " + url);
/* 1423 */         error(new LispError("Failed to read class bytes from boot class " + url));
/*      */       } 
/*      */     } 
/* 1426 */     byte[] bytes = new byte[4096];
/*      */     try {
/* 1428 */       if (input == null) {
/* 1429 */         Debug.trace("Pathname: " + name);
/* 1430 */         Debug.trace("load: " + load);
/* 1431 */         Debug.trace("LOAD_TRUENAME_FASL: " + truenameFasl);
/* 1432 */         Debug.trace("LOAD_TRUENAME: " + truename);
/* 1433 */         Debug.assertTrue((input != null));
/*      */       } 
/*      */       
/* 1436 */       int n = 0;
/* 1437 */       ByteArrayOutputStream baos = new ByteArrayOutputStream();
/*      */       try {
/* 1439 */         while (n >= 0) {
/* 1440 */           n = input.read(bytes, 0, 4096);
/* 1441 */           if (n >= 0) {
/* 1442 */             baos.write(bytes, 0, n);
/*      */           }
/*      */         } 
/* 1445 */       } catch (IOException e) {
/* 1446 */         Debug.trace("Failed to read bytes from '" + name
/* 1447 */             .getNamestring() + "'");
/* 1448 */         return null;
/*      */       } 
/* 1450 */       bytes = baos.toByteArray();
/*      */     } finally {
/*      */       try {
/* 1453 */         input.close();
/* 1454 */       } catch (IOException e) {
/* 1455 */         Debug.trace("Failed to close InputStream: " + e);
/*      */       } 
/*      */     } 
/* 1458 */     return bytes;
/*      */   }
/*      */   
/*      */   public static final Function makeCompiledFunctionFromClass(Class<?> c) {
/*      */     
/* 1463 */     try { if (c != null) {
/* 1464 */         Function obj = (Function)c.newInstance();
/* 1465 */         return obj;
/*      */       } 
/* 1467 */       return null;
/*      */        }
/*      */     
/* 1470 */     catch (InstantiationException instantiationException) {  }
/* 1471 */     catch (IllegalAccessException illegalAccessException) {}
/*      */     
/* 1473 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject loadCompiledFunction(InputStream in, int size) {
/* 1479 */     byte[] bytes = readFunctionBytes(in, size);
/* 1480 */     if (bytes != null) {
/* 1481 */       return loadClassBytes(bytes);
/*      */     }
/* 1483 */     return error(new FileError("Can't read file off stream."));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private static final byte[] readFunctionBytes(InputStream in, int size) {
/*      */     try {
/* 1492 */       byte[] bytes = new byte[size];
/* 1493 */       int bytesRemaining = size;
/* 1494 */       int bytesRead = 0;
/* 1495 */       while (bytesRemaining > 0) {
/*      */         
/* 1497 */         int n = in.read(bytes, bytesRead, bytesRemaining);
/* 1498 */         if (n < 0)
/*      */           break; 
/* 1500 */         bytesRead += n;
/* 1501 */         bytesRemaining -= n;
/*      */       } 
/* 1503 */       in.close();
/* 1504 */       if (bytesRemaining > 0) {
/* 1505 */         Debug.trace("bytesRemaining = " + bytesRemaining);
/*      */       }
/* 1507 */       return bytes;
/*      */     }
/* 1509 */     catch (IOException t) {
/*      */       
/* 1511 */       Debug.trace(t);
/*      */       
/* 1513 */       return null;
/*      */     } 
/*      */   }
/*      */   
/*      */   public static final Function loadClassBytes(byte[] bytes) {
/* 1518 */     return loadClassBytes(bytes, new JavaClassLoader());
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Function loadClassBytes(byte[] bytes, JavaClassLoader cl) {
/* 1524 */     Class<?> c = cl.loadClassFromByteArray(null, bytes, 0, bytes.length);
/* 1525 */     Function obj = makeCompiledFunctionFromClass(c);
/* 1526 */     if (obj != null) {
/* 1527 */       obj.setClassBytes(bytes);
/*      */     }
/* 1529 */     return obj;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject makeCompiledClosure(LispObject template, ClosureBinding[] context) {
/* 1537 */     return ((CompiledClosure)template).dup().setContext(context);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final String safeWriteToString(LispObject obj) {
/*      */     try {
/* 1543 */       return obj.printObject();
/*      */     }
/* 1545 */     catch (NullPointerException e) {
/*      */       
/* 1547 */       Debug.trace(e);
/* 1548 */       return "null";
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public static final boolean isValidSetfFunctionName(LispObject obj) {
/* 1554 */     if (obj instanceof Cons) {
/*      */       
/* 1556 */       Cons cons = (Cons)obj;
/* 1557 */       if (cons.car == Symbol.SETF && cons.cdr instanceof Cons) {
/*      */         
/* 1559 */         Cons cdr = (Cons)cons.cdr;
/* 1560 */         return (cdr.car instanceof Symbol && cdr.cdr == NIL);
/*      */       } 
/*      */     } 
/* 1563 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final boolean isValidMacroFunctionName(LispObject obj) {
/* 1568 */     if (obj instanceof Cons) {
/*      */       
/* 1570 */       Cons cons = (Cons)obj;
/* 1571 */       if (cons.car == Symbol.MACRO_FUNCTION && cons.cdr instanceof Cons) {
/*      */         
/* 1573 */         Cons cdr = (Cons)cons.cdr;
/* 1574 */         return (cdr.car instanceof Symbol && cdr.cdr == NIL);
/*      */       } 
/*      */     } 
/* 1577 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/* 1582 */   public static final LispObject FUNCTION_NAME = list(Symbol.OR, new LispObject[] {
/*      */         
/* 1584 */         Symbol.SYMBOL, list(Symbol.CONS, new LispObject[] {
/* 1585 */             list(Symbol.EQL, new LispObject[] { Symbol.SETF
/* 1586 */               }), list(Symbol.CONS, new LispObject[] { Symbol.SYMBOL, Symbol.NULL })
/*      */           })
/*      */       });
/* 1589 */   public static final LispObject UNSIGNED_BYTE_8 = list(Symbol.UNSIGNED_BYTE, new LispObject[] { Fixnum.constants[8] });
/*      */ 
/*      */   
/* 1592 */   public static final LispObject UNSIGNED_BYTE_16 = list(Symbol.UNSIGNED_BYTE, new LispObject[] { Fixnum.constants[16] });
/*      */ 
/*      */   
/* 1595 */   public static final LispObject UNSIGNED_BYTE_32 = list(Symbol.UNSIGNED_BYTE, new LispObject[] { Fixnum.constants[32] });
/*      */ 
/*      */   
/* 1598 */   public static final LispObject UNSIGNED_BYTE_32_MAX_VALUE = Bignum.getInstance(4294967295L);
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject getUpgradedArrayElementType(LispObject type) {
/* 1603 */     if (type instanceof Symbol) {
/*      */       
/* 1605 */       if (type == Symbol.CHARACTER || type == Symbol.BASE_CHAR || type == Symbol.STANDARD_CHAR)
/*      */       {
/* 1607 */         return Symbol.CHARACTER; } 
/* 1608 */       if (type == Symbol.BIT)
/* 1609 */         return Symbol.BIT; 
/* 1610 */       if (type == NIL)
/* 1611 */         return NIL; 
/*      */     } 
/* 1613 */     if (type == BuiltInClass.CHARACTER)
/* 1614 */       return Symbol.CHARACTER; 
/* 1615 */     if (type instanceof Cons) {
/*      */       
/* 1617 */       if (type.equal(UNSIGNED_BYTE_8))
/* 1618 */         return type; 
/* 1619 */       if (type.equal(UNSIGNED_BYTE_16))
/* 1620 */         return type; 
/* 1621 */       if (type.equal(UNSIGNED_BYTE_32))
/* 1622 */         return type; 
/* 1623 */       LispObject car = type.car();
/* 1624 */       if (car == Symbol.INTEGER) {
/*      */         
/* 1626 */         LispObject lower = type.cadr();
/* 1627 */         LispObject upper = type.cdr().cadr();
/*      */         
/* 1629 */         if (lower instanceof Cons)
/* 1630 */           lower = lower.car().incr(); 
/* 1631 */         if (upper instanceof Cons)
/* 1632 */           upper = upper.car().decr(); 
/* 1633 */         if (lower.integerp() && upper.integerp()) {
/*      */           
/* 1635 */           if (lower instanceof Fixnum && upper instanceof Fixnum) {
/*      */             
/* 1637 */             int l = ((Fixnum)lower).value;
/* 1638 */             if (l >= 0) {
/*      */               
/* 1640 */               int u = ((Fixnum)upper).value;
/* 1641 */               if (u <= 1)
/* 1642 */                 return Symbol.BIT; 
/* 1643 */               if (u <= 255)
/* 1644 */                 return UNSIGNED_BYTE_8; 
/* 1645 */               if (u <= 65535)
/* 1646 */                 return UNSIGNED_BYTE_16; 
/* 1647 */               return UNSIGNED_BYTE_32;
/*      */             } 
/*      */           } 
/* 1650 */           if (lower.isGreaterThanOrEqualTo(Fixnum.ZERO))
/*      */           {
/* 1652 */             if (lower.isLessThanOrEqualTo(UNSIGNED_BYTE_32_MAX_VALUE))
/*      */             {
/* 1654 */               if (upper.isLessThanOrEqualTo(UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 1655 */                 return UNSIGNED_BYTE_32;
/*      */               }
/*      */             }
/*      */           }
/*      */         } 
/* 1660 */       } else if (car == Symbol.EQL) {
/*      */         
/* 1662 */         LispObject obj = type.cadr();
/* 1663 */         if (obj instanceof Fixnum) {
/*      */           
/* 1665 */           int val = ((Fixnum)obj).value;
/* 1666 */           if (val >= 0)
/*      */           {
/* 1668 */             if (val <= 1)
/* 1669 */               return Symbol.BIT; 
/* 1670 */             if (val <= 255)
/* 1671 */               return UNSIGNED_BYTE_8; 
/* 1672 */             if (val <= 65535)
/* 1673 */               return UNSIGNED_BYTE_16; 
/* 1674 */             return UNSIGNED_BYTE_32;
/*      */           }
/*      */         
/* 1677 */         } else if (obj instanceof Bignum) {
/*      */           
/* 1679 */           if (obj.isGreaterThanOrEqualTo(Fixnum.ZERO))
/*      */           {
/* 1681 */             if (obj.isLessThanOrEqualTo(UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 1682 */               return UNSIGNED_BYTE_32;
/*      */             }
/*      */           }
/*      */         } 
/* 1686 */       } else if (car == Symbol.MEMBER) {
/*      */         
/* 1688 */         LispObject rest = type.cdr();
/* 1689 */         while (rest != NIL) {
/*      */           
/* 1691 */           LispObject obj = rest.car();
/* 1692 */           if (obj instanceof LispCharacter) {
/* 1693 */             rest = rest.cdr(); continue;
/*      */           } 
/* 1695 */           return T;
/*      */         } 
/* 1697 */         return Symbol.CHARACTER;
/*      */       } 
/*      */     } 
/* 1700 */     return T;
/*      */   }
/*      */ 
/*      */   
/*      */   public static final char coerceToJavaChar(LispObject obj) {
/* 1705 */     return (char)Fixnum.getValue(obj);
/*      */   }
/*      */   
/*      */   public static final byte coerceToJavaByte(LispObject obj) {
/* 1709 */     return (byte)Fixnum.getValue(obj);
/*      */   }
/*      */   
/*      */   public static final int coerceToJavaUnsignedInt(LispObject obj) {
/* 1713 */     return (int)(obj.longValue() & 0xFFFFFFFFL);
/*      */   }
/*      */   
/*      */   public static final LispObject coerceFromJavaByte(byte b) {
/* 1717 */     return Fixnum.constants[b & 0xFF];
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispCharacter checkCharacter(LispObject obj) {
/* 1723 */     if (obj instanceof LispCharacter)
/* 1724 */       return (LispCharacter)obj; 
/* 1725 */     return 
/* 1726 */       (LispCharacter)type_error(obj, Symbol.CHARACTER);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Package checkPackage(LispObject obj) {
/* 1732 */     if (obj instanceof Package)
/* 1733 */       return (Package)obj; 
/* 1734 */     return 
/* 1735 */       (Package)type_error(obj, Symbol.PACKAGE);
/*      */   }
/*      */ 
/*      */   
/*      */   public static Pathname checkPathname(LispObject obj) {
/* 1740 */     if (obj instanceof Pathname)
/* 1741 */       return (Pathname)obj; 
/* 1742 */     return 
/* 1743 */       (Pathname)type_error(obj, Symbol.PATHNAME);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Function checkFunction(LispObject obj) {
/* 1749 */     if (obj instanceof Function)
/* 1750 */       return (Function)obj; 
/* 1751 */     return 
/* 1752 */       (Function)type_error(obj, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream checkStream(LispObject obj) {
/* 1758 */     if (obj instanceof Stream)
/* 1759 */       return (Stream)obj; 
/* 1760 */     return 
/* 1761 */       (Stream)type_error(obj, Symbol.STREAM);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream checkCharacterInputStream(LispObject obj) {
/* 1767 */     Stream stream = checkStream(obj);
/* 1768 */     if (stream.isCharacterInputStream())
/* 1769 */       return stream; 
/* 1770 */     return 
/* 1771 */       (Stream)error(new TypeError("The value " + obj.princToString() + " is not a character input stream."));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream checkCharacterOutputStream(LispObject obj) {
/* 1778 */     Stream stream = checkStream(obj);
/* 1779 */     if (stream.isCharacterOutputStream())
/* 1780 */       return stream; 
/* 1781 */     return 
/* 1782 */       (Stream)error(new TypeError("The value " + obj.princToString() + " is not a character output stream."));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream checkBinaryInputStream(LispObject obj) {
/* 1789 */     Stream stream = checkStream(obj);
/* 1790 */     if (stream.isBinaryInputStream())
/* 1791 */       return stream; 
/* 1792 */     return 
/* 1793 */       (Stream)error(new TypeError("The value " + obj.princToString() + " is not a binary input stream."));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream outSynonymOf(LispObject obj) {
/* 1800 */     if (obj instanceof Stream)
/* 1801 */       return (Stream)obj; 
/* 1802 */     if (obj == T)
/* 1803 */       return checkCharacterOutputStream(Symbol.TERMINAL_IO.symbolValue()); 
/* 1804 */     if (obj == NIL)
/* 1805 */       return checkCharacterOutputStream(Symbol.STANDARD_OUTPUT.symbolValue()); 
/* 1806 */     return 
/* 1807 */       (Stream)type_error(obj, Symbol.STREAM);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Stream inSynonymOf(LispObject obj) {
/* 1813 */     if (obj instanceof Stream)
/* 1814 */       return (Stream)obj; 
/* 1815 */     if (obj == T)
/* 1816 */       return checkCharacterInputStream(Symbol.TERMINAL_IO.symbolValue()); 
/* 1817 */     if (obj == NIL)
/* 1818 */       return checkCharacterInputStream(Symbol.STANDARD_INPUT.symbolValue()); 
/* 1819 */     return 
/* 1820 */       (Stream)type_error(obj, Symbol.STREAM);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final void writeByte(int n, LispObject obj) {
/* 1826 */     if (n < 0 || n > 255)
/* 1827 */       type_error(Fixnum.getInstance(n), UNSIGNED_BYTE_8); 
/* 1828 */     checkStream(obj)._writeByte(n);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Readtable checkReadtable(LispObject obj) {
/* 1834 */     if (obj instanceof Readtable)
/* 1835 */       return (Readtable)obj; 
/* 1836 */     return 
/* 1837 */       (Readtable)type_error(obj, Symbol.READTABLE);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final AbstractString checkString(LispObject obj) {
/* 1843 */     if (obj instanceof AbstractString)
/* 1844 */       return (AbstractString)obj; 
/* 1845 */     return 
/* 1846 */       (AbstractString)type_error(obj, Symbol.STRING);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Layout checkLayout(LispObject obj) {
/* 1852 */     if (obj instanceof Layout)
/* 1853 */       return (Layout)obj; 
/* 1854 */     return 
/* 1855 */       (Layout)type_error(obj, Symbol.LAYOUT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Readtable designator_readtable(LispObject obj) {
/* 1861 */     if (obj == NIL)
/* 1862 */       obj = STANDARD_READTABLE.symbolValue(); 
/* 1863 */     if (obj == null)
/* 1864 */       throw new NullPointerException(); 
/* 1865 */     return checkReadtable(obj);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Environment checkEnvironment(LispObject obj) {
/* 1871 */     if (obj instanceof Environment)
/* 1872 */       return (Environment)obj; 
/* 1873 */     return 
/* 1874 */       (Environment)type_error(obj, Symbol.ENVIRONMENT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final void checkBounds(int start, int end, int length) {
/* 1880 */     if (start < 0 || end < 0 || start > end || end > length) {
/*      */       
/* 1882 */       StringBuilder sb = new StringBuilder("The bounding indices ");
/* 1883 */       sb.append(start);
/* 1884 */       sb.append(" and ");
/* 1885 */       sb.append(end);
/* 1886 */       sb.append(" are bad for a sequence of length ");
/* 1887 */       sb.append(length);
/* 1888 */       sb.append('.');
/* 1889 */       error(new TypeError(sb.toString()));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject coerceToFunction(LispObject obj) {
/* 1896 */     if (obj instanceof Function)
/* 1897 */       return obj; 
/* 1898 */     if (obj instanceof FuncallableStandardObject)
/* 1899 */       return obj; 
/* 1900 */     if (obj instanceof Symbol) {
/*      */       
/* 1902 */       LispObject fun = obj.getSymbolFunction();
/* 1903 */       if (fun instanceof Function)
/* 1904 */         return fun; 
/* 1905 */       if (fun instanceof FuncallableStandardObject) {
/* 1906 */         return fun;
/*      */       }
/* 1908 */     } else if (obj instanceof Cons && obj.car() == Symbol.LAMBDA) {
/* 1909 */       return new Closure(obj, new Environment());
/* 1910 */     }  if (obj instanceof Cons && obj.car() == Symbol.NAMED_LAMBDA) {
/* 1911 */       LispObject name = obj.cadr();
/* 1912 */       if (name instanceof Symbol || isValidSetfFunctionName(name)) {
/* 1913 */         return new Closure(name, new Cons(Symbol.LAMBDA, obj
/* 1914 */               .cddr()), new Environment());
/*      */       }
/*      */       
/* 1917 */       return type_error(name, FUNCTION_NAME);
/*      */     } 
/* 1919 */     error(new UndefinedFunction(obj));
/*      */     
/* 1921 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Package coerceToPackage(LispObject obj) {
/* 1928 */     if (obj instanceof Package)
/* 1929 */       return (Package)obj; 
/* 1930 */     String name = javaString(obj);
/* 1931 */     Package pkg = getCurrentPackage().findPackage(name);
/* 1932 */     if (pkg != null)
/* 1933 */       return pkg; 
/* 1934 */     error(new PackageError(obj.princToString() + " is not the name of a package.", obj));
/*      */     
/* 1936 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static Pathname coerceToPathname(LispObject arg) {
/* 1942 */     if (arg instanceof Pathname)
/* 1943 */       return (Pathname)arg; 
/* 1944 */     if (arg instanceof AbstractString)
/* 1945 */       return Pathname.create(((AbstractString)arg).toString()); 
/* 1946 */     if (arg instanceof FileStream)
/* 1947 */       return ((FileStream)arg).getPathname(); 
/* 1948 */     if (arg instanceof JarStream)
/* 1949 */       return ((JarStream)arg).getPathname(); 
/* 1950 */     if (arg instanceof URLStream)
/* 1951 */       return ((URLStream)arg).getPathname(); 
/* 1952 */     type_error(arg, list(Symbol.OR, new LispObject[] { Symbol.STRING, Symbol.PATHNAME, Symbol.JAR_PATHNAME, Symbol.URL_PATHNAME, Symbol.FILE_STREAM, Symbol.JAR_STREAM, Symbol.URL_STREAM }));
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 1957 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static LispObject assq(LispObject item, LispObject alist) {
/* 1963 */     while (alist instanceof Cons) {
/*      */       
/* 1965 */       LispObject entry = ((Cons)alist).car;
/* 1966 */       if (entry instanceof Cons) {
/*      */         
/* 1968 */         if (((Cons)entry).car == item) {
/* 1969 */           return entry;
/*      */         }
/* 1971 */       } else if (entry != NIL) {
/* 1972 */         return type_error(entry, Symbol.LIST);
/* 1973 */       }  alist = ((Cons)alist).cdr;
/*      */     } 
/* 1975 */     if (alist != NIL)
/* 1976 */       return type_error(alist, Symbol.LIST); 
/* 1977 */     return NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final boolean memq(LispObject item, LispObject list) {
/* 1983 */     while (list instanceof Cons) {
/*      */       
/* 1985 */       if (item == ((Cons)list).car)
/* 1986 */         return true; 
/* 1987 */       list = ((Cons)list).cdr;
/*      */     } 
/* 1989 */     if (list != NIL)
/* 1990 */       type_error(list, Symbol.LIST); 
/* 1991 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final boolean memql(LispObject item, LispObject list) {
/* 1997 */     while (list instanceof Cons) {
/*      */       
/* 1999 */       if (item.eql(((Cons)list).car))
/* 2000 */         return true; 
/* 2001 */       list = ((Cons)list).cdr;
/*      */     } 
/* 2003 */     if (list != NIL)
/* 2004 */       type_error(list, Symbol.LIST); 
/* 2005 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject getf(LispObject plist, LispObject indicator, LispObject defaultValue) {
/* 2013 */     LispObject list = plist;
/* 2014 */     while (list != NIL) {
/*      */       
/* 2016 */       if (list.car() == indicator)
/* 2017 */         return list.cadr(); 
/* 2018 */       if (list.cdr() instanceof Cons) {
/* 2019 */         list = list.cddr(); continue;
/*      */       } 
/* 2021 */       return error(new TypeError("Malformed property list: " + plist
/* 2022 */             .princToString()));
/*      */     } 
/* 2024 */     return defaultValue;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject get(LispObject symbol, LispObject indicator) {
/* 2030 */     LispObject list = checkSymbol(symbol).getPropertyList();
/* 2031 */     while (list != NIL) {
/*      */       
/* 2033 */       if (list.car() == indicator)
/* 2034 */         return list.cadr(); 
/* 2035 */       list = list.cddr();
/*      */     } 
/* 2037 */     return NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject get(LispObject symbol, LispObject indicator, LispObject defaultValue) {
/* 2044 */     LispObject list = checkSymbol(symbol).getPropertyList();
/* 2045 */     while (list != NIL) {
/*      */       
/* 2047 */       if (list.car() == indicator)
/* 2048 */         return list.cadr(); 
/* 2049 */       list = list.cddr();
/*      */     } 
/* 2051 */     return defaultValue;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject put(Symbol symbol, LispObject indicator, LispObject value) {
/* 2058 */     LispObject list = symbol.getPropertyList();
/* 2059 */     while (list != NIL) {
/*      */       
/* 2061 */       if (list.car() == indicator) {
/*      */ 
/*      */         
/* 2064 */         LispObject rest = list.cdr();
/* 2065 */         rest.setCar(value);
/* 2066 */         return value;
/*      */       } 
/* 2068 */       list = list.cddr();
/*      */     } 
/*      */     
/* 2071 */     symbol.setPropertyList(new Cons(indicator, new Cons(value, symbol
/*      */             
/* 2073 */             .getPropertyList())));
/* 2074 */     return value;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject putf(LispObject plist, LispObject indicator, LispObject value) {
/* 2081 */     LispObject list = plist;
/* 2082 */     while (list != NIL) {
/*      */       
/* 2084 */       if (list.car() == indicator) {
/*      */ 
/*      */         
/* 2087 */         LispObject rest = list.cdr();
/* 2088 */         rest.setCar(value);
/* 2089 */         return plist;
/*      */       } 
/* 2091 */       list = list.cddr();
/*      */     } 
/*      */     
/* 2094 */     return new Cons(indicator, new Cons(value, plist));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final LispObject remprop(Symbol symbol, LispObject indicator) {
/* 2100 */     LispObject list = checkList(symbol.getPropertyList());
/* 2101 */     LispObject prev = null;
/* 2102 */     while (list != NIL) {
/*      */       
/* 2104 */       if (!(list.cdr() instanceof Cons)) {
/* 2105 */         error(new ProgramError("The symbol " + symbol.princToString() + " has an odd number of items in its property list."));
/*      */       }
/* 2107 */       if (list.car() == indicator) {
/*      */ 
/*      */         
/* 2110 */         if (prev != null) {
/* 2111 */           prev.setCdr(list.cddr());
/*      */         } else {
/* 2113 */           symbol.setPropertyList(list.cddr());
/* 2114 */         }  return T;
/*      */       } 
/* 2116 */       prev = list.cdr();
/* 2117 */       list = list.cddr();
/*      */     } 
/*      */     
/* 2120 */     return NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final String format(LispObject formatControl, LispObject formatArguments) {
/* 2127 */     LispThread thread = LispThread.currentThread();
/* 2128 */     String control = formatControl.getStringValue();
/* 2129 */     LispObject[] args = formatArguments.copyToArray();
/* 2130 */     StringBuffer sb = new StringBuffer();
/* 2131 */     if (control != null) {
/*      */       
/* 2133 */       int limit = control.length();
/* 2134 */       int j = 0;
/* 2135 */       int NEUTRAL = 0;
/* 2136 */       int TILDE = 1;
/* 2137 */       int state = 0;
/* 2138 */       for (int i = 0; i < limit; i++) {
/*      */         
/* 2140 */         char c = control.charAt(i);
/* 2141 */         if (state == 0) {
/*      */           
/* 2143 */           if (c == '~') {
/* 2144 */             state = 1;
/*      */           } else {
/* 2146 */             sb.append(c);
/*      */           } 
/* 2148 */         } else if (state == 1) {
/*      */           
/* 2150 */           if (c == 'A' || c == 'a') {
/*      */             
/* 2152 */             if (j < args.length) {
/*      */               
/* 2154 */               LispObject obj = args[j++];
/* 2155 */               SpecialBindingsMark mark = thread.markSpecialBindings();
/* 2156 */               thread.bindSpecial(Symbol.PRINT_ESCAPE, NIL);
/* 2157 */               thread.bindSpecial(Symbol.PRINT_READABLY, NIL);
/*      */               try {
/* 2159 */                 sb.append(obj.printObject());
/*      */               } finally {
/*      */                 
/* 2162 */                 thread.resetSpecialBindings(mark);
/*      */               }
/*      */             
/*      */             } 
/* 2166 */           } else if (c == 'S' || c == 's') {
/*      */             
/* 2168 */             if (j < args.length) {
/*      */               
/* 2170 */               LispObject obj = args[j++];
/* 2171 */               SpecialBindingsMark mark = thread.markSpecialBindings();
/* 2172 */               thread.bindSpecial(Symbol.PRINT_ESCAPE, T);
/*      */               try {
/* 2174 */                 sb.append(obj.printObject());
/*      */               } finally {
/*      */                 
/* 2177 */                 thread.resetSpecialBindings(mark);
/*      */               }
/*      */             
/*      */             } 
/* 2181 */           } else if (c == 'D' || c == 'd') {
/*      */             
/* 2183 */             if (j < args.length) {
/*      */               
/* 2185 */               LispObject obj = args[j++];
/* 2186 */               SpecialBindingsMark mark = thread.markSpecialBindings();
/* 2187 */               thread.bindSpecial(Symbol.PRINT_ESCAPE, NIL);
/* 2188 */               thread.bindSpecial(Symbol.PRINT_RADIX, NIL);
/* 2189 */               thread.bindSpecial(Symbol.PRINT_BASE, Fixnum.constants[10]);
/*      */               try {
/* 2191 */                 sb.append(obj.printObject());
/*      */               } finally {
/*      */                 
/* 2194 */                 thread.resetSpecialBindings(mark);
/*      */               }
/*      */             
/*      */             } 
/* 2198 */           } else if (c == 'X' || c == 'x') {
/*      */             
/* 2200 */             if (j < args.length) {
/*      */               
/* 2202 */               LispObject obj = args[j++];
/* 2203 */               SpecialBindingsMark mark = thread.markSpecialBindings();
/* 2204 */               thread.bindSpecial(Symbol.PRINT_ESCAPE, NIL);
/* 2205 */               thread.bindSpecial(Symbol.PRINT_RADIX, NIL);
/* 2206 */               thread.bindSpecial(Symbol.PRINT_BASE, Fixnum.constants[16]);
/*      */               try {
/* 2208 */                 sb.append(obj.printObject());
/*      */               } finally {
/*      */                 
/* 2211 */                 thread.resetSpecialBindings(mark);
/*      */               }
/*      */             
/*      */             } 
/* 2215 */           } else if (c == '%') {
/*      */             
/* 2217 */             sb.append('\n');
/*      */           } 
/* 2219 */           state = 0;
/*      */         
/*      */         }
/*      */         else {
/*      */           
/* 2224 */           Debug.assertTrue(false);
/*      */         } 
/*      */       } 
/*      */     } 
/* 2228 */     return sb.toString();
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Symbol intern(String name, Package pkg) {
/* 2233 */     return pkg.intern(name);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Symbol internInPackage(String name, String packageName) {
/* 2240 */     Package pkg = getCurrentPackage().findPackage(packageName);
/* 2241 */     if (pkg == null)
/* 2242 */       error(new LispError(packageName + " is not the name of a package.")); 
/* 2243 */     return pkg.intern(name);
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Symbol internKeyword(String s) {
/* 2248 */     return PACKAGE_KEYWORD.intern(s);
/*      */   }
/*      */ 
/*      */   
/* 2252 */   static final ConcurrentHashMap<String, LispObject> objectTable = new ConcurrentHashMap<>();
/*      */ 
/*      */ 
/*      */   
/*      */   public static LispObject recall(String key) {
/* 2257 */     return objectTable.remove(key);
/*      */   }
/*      */ 
/*      */   
/*      */   public static LispObject recall(SimpleString key) {
/* 2262 */     return objectTable.remove(key.getStringValue());
/*      */   }
/*      */ 
/*      */   
/* 2266 */   public static final Primitive REMEMBER = new Primitive("remember", PACKAGE_SYS, true)
/*      */     {
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject key, LispObject value)
/*      */       {
/* 2273 */         Lisp.objectTable.put(key.getStringValue(), value);
/* 2274 */         return Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Symbol internSpecial(String name, Package pkg, LispObject value) {
/* 2281 */     Symbol symbol = pkg.intern(name);
/* 2282 */     symbol.setSpecial(true);
/* 2283 */     symbol.setSymbolValue(value);
/* 2284 */     return symbol;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Symbol internConstant(String name, Package pkg, LispObject value) {
/* 2290 */     Symbol symbol = pkg.intern(name);
/* 2291 */     symbol.initializeConstant(value);
/* 2292 */     return symbol;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Symbol exportSpecial(String name, Package pkg, LispObject value) {
/* 2298 */     Symbol symbol = pkg.intern(name);
/* 2299 */     pkg.export(symbol);
/* 2300 */     symbol.setSpecial(true);
/* 2301 */     symbol.setSymbolValue(value);
/* 2302 */     return symbol;
/*      */   }
/*      */   public static final Package getCurrentPackage() {
/*      */     return (Package)Symbol._PACKAGE_.symbolValueNoThrow();
/*      */   }
/*      */   
/* 2308 */   public static final Symbol exportConstant(String name, Package pkg, LispObject value) { Symbol symbol = pkg.intern(name);
/* 2309 */     pkg.export(symbol);
/* 2310 */     symbol.initializeConstant(value);
/* 2311 */     return symbol; }
/*      */ 
/*      */ 
/*      */   
/*      */   static {
/* 2316 */     String userDir = System.getProperty("user.dir");
/* 2317 */     if (userDir != null && userDir.length() > 0)
/*      */     {
/* 2319 */       if (userDir.charAt(userDir.length() - 1) != File.separatorChar) {
/* 2320 */         userDir = userDir.concat(File.separator);
/*      */       }
/*      */     }
/* 2323 */     Symbol.DEFAULT_PATHNAME_DEFAULTS.initializeSpecial(new SimpleString(userDir));
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2328 */     Symbol._PACKAGE_.initializeSpecial(PACKAGE_CL_USER);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2375 */     Symbol.CURRENT_READTABLE.initializeSpecial(new Readtable()); }
/*      */   public static final void resetIO(Stream in, Stream out) { stdin = in; stdout = out; Symbol.STANDARD_INPUT.setSymbolValue(stdin); Symbol.STANDARD_OUTPUT.setSymbolValue(stdout); Symbol.ERROR_OUTPUT.setSymbolValue(stdout);
/*      */     Symbol.TRACE_OUTPUT.setSymbolValue(stdout);
/*      */     Symbol.TERMINAL_IO.setSymbolValue(new TwoWayStream(stdin, stdout, true));
/*      */     Symbol.QUERY_IO.setSymbolValue(new TwoWayStream(stdin, stdout, true));
/*      */     Symbol.DEBUG_IO.setSymbolValue(new TwoWayStream(stdin, stdout, true)); }
/* 2381 */   public static final void resetIO() { resetIO(new Stream(Symbol.SYSTEM_STREAM, System.in, Symbol.CHARACTER, true), new Stream(Symbol.SYSTEM_STREAM, System.out, Symbol.CHARACTER, true)); } public static final Symbol STANDARD_READTABLE = internConstant("+STANDARD-READTABLE+", PACKAGE_SYS, new Readtable()); public static final TwoWayStream getTerminalIO() { return (TwoWayStream)Symbol.TERMINAL_IO.symbolValueNoThrow(); }
/*      */   public static final Stream getStandardInput() { return (Stream)Symbol.STANDARD_INPUT.symbolValueNoThrow(); }
/*      */   public static final Stream getStandardOutput() { return checkCharacterOutputStream(Symbol.STANDARD_OUTPUT.symbolValue()); }
/*      */   public static final Readtable currentReadtable() {
/* 2385 */     return (Readtable)Symbol.CURRENT_READTABLE.symbolValue();
/*      */   }
/*      */ 
/*      */   
/*      */   static {
/* 2390 */     Symbol.READ_SUPPRESS.initializeSpecial(NIL);
/* 2391 */     Symbol.DEBUGGER_HOOK.initializeSpecial(NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2396 */     Symbol.MOST_POSITIVE_FIXNUM.initializeConstant(Fixnum.getInstance(2147483647));
/* 2397 */     Symbol.MOST_NEGATIVE_FIXNUM.initializeConstant(Fixnum.getInstance(-2147483648));
/* 2398 */     Symbol.MOST_POSITIVE_JAVA_LONG.initializeConstant(Bignum.getInstance(Long.MAX_VALUE));
/* 2399 */     Symbol.MOST_NEGATIVE_JAVA_LONG.initializeConstant(Bignum.getInstance(Long.MIN_VALUE));
/*      */   }
/*      */ 
/*      */   
/*      */   public static void exit(int status) {
/* 2404 */     Interpreter interpreter = Interpreter.getInstance();
/* 2405 */     if (interpreter != null) {
/* 2406 */       interpreter.kill(status);
/*      */     }
/*      */   }
/*      */   
/* 2410 */   public static final Symbol T = Symbol.T;
/*      */   
/*      */   static {
/* 2413 */     T.initializeConstant(T);
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2418 */     Symbol.READ_EVAL.initializeSpecial(T);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2427 */     String osName = System.getProperty("os.name");
/* 2428 */     String javaVersion = System.getProperty("java.version");
/* 2429 */     String osArch = System.getProperty("os.arch");
/*      */ 
/*      */     
/* 2432 */     LispObject featureList = list(Keyword.ARMEDBEAR, new LispObject[] { Keyword.ABCL, Keyword.COMMON_LISP, Keyword.ANSI_CL, Keyword.CDR6, Keyword.MOP, 
/*      */ 
/*      */ 
/*      */           
/* 2436 */           internKeyword("PACKAGE-LOCAL-NICKNAMES") });
/*      */ 
/*      */     
/* 2439 */     featureList = featureList.push(internKeyword("JVM-" + javaVersion));
/*      */     
/* 2441 */     String platformVersion = null;
/* 2442 */     if (javaVersion.startsWith("1.")) {
/*      */       
/* 2444 */       int i = javaVersion.indexOf(".", 2);
/* 2445 */       platformVersion = javaVersion.substring(2, i);
/*      */     } else {
/* 2447 */       int i = javaVersion.indexOf(".");
/* 2448 */       if (i >= 0) {
/* 2449 */         platformVersion = javaVersion.substring(0, i);
/*      */       } else {
/* 2451 */         platformVersion = javaVersion;
/*      */       } 
/*      */     } 
/*      */ 
/*      */ 
/*      */     
/*      */     try {
/* 2458 */       Integer.parseInt(javaVersion);
/* 2459 */     } catch (NumberFormatException e) {
/* 2460 */       for (int i = 0; i < javaVersion.length(); i++) {
/* 2461 */         char c = javaVersion.charAt(i);
/* 2462 */         if (!Character.isDigit(c)) {
/*      */           
/* 2464 */           featureList.push(internKeyword("JAVA-" + javaVersion));
/* 2465 */           platformVersion = javaVersion.substring(0, i);
/*      */           break;
/*      */         } 
/*      */       } 
/*      */     } 
/* 2470 */     featureList = featureList.push(internKeyword("JAVA-" + platformVersion));
/*      */ 
/*      */ 
/*      */     
/* 2474 */     if (javaVersion.startsWith("1.5")) {
/* 2475 */       featureList = new Cons(Keyword.JAVA_1_5, featureList);
/* 2476 */     } else if (javaVersion.startsWith("1.6")) {
/* 2477 */       featureList = new Cons(Keyword.JAVA_1_6, featureList);
/* 2478 */     } else if (javaVersion.startsWith("1.7")) {
/* 2479 */       featureList = new Cons(Keyword.JAVA_1_7, featureList);
/* 2480 */     } else if (javaVersion.startsWith("1.8")) {
/* 2481 */       featureList = new Cons(Keyword.JAVA_1_8, featureList);
/*      */     } 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2487 */     if (osName.startsWith("Linux")) {
/* 2488 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.LINUX }), featureList);
/*      */     
/*      */     }
/* 2491 */     else if (osName.startsWith("SunOS")) {
/* 2492 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.SUNOS, Keyword.SOLARIS }), featureList);
/*      */ 
/*      */     
/*      */     }
/* 2496 */     else if (osName.startsWith("Mac OS X") || osName
/* 2497 */       .startsWith("Darwin")) {
/* 2498 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.DARWIN }), featureList);
/*      */     
/*      */     }
/* 2501 */     else if (osName.startsWith("FreeBSD")) {
/* 2502 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.FREEBSD }), featureList);
/*      */     
/*      */     }
/* 2505 */     else if (osName.startsWith("OpenBSD")) {
/* 2506 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.OPENBSD }), featureList);
/*      */     
/*      */     }
/* 2509 */     else if (osName.startsWith("NetBSD")) {
/* 2510 */       featureList = Primitives.APPEND.execute(list(Keyword.UNIX, new LispObject[] { Keyword.NETBSD }), featureList);
/*      */     
/*      */     }
/* 2513 */     else if (osName.startsWith("Windows")) {
/* 2514 */       featureList = new Cons(Keyword.WINDOWS, featureList);
/*      */     } 
/*      */     
/* 2517 */     if (osArch != null) {
/* 2518 */       if (osArch.equals("amd64") || osArch.equals("x86_64")) {
/* 2519 */         featureList = featureList.push(Keyword.X86_64);
/* 2520 */       } else if (osArch.equals("x86") || osArch.equals("i386")) {
/* 2521 */         featureList = featureList.push(Keyword.X86);
/*      */       } else {
/*      */         
/* 2524 */         featureList = featureList.push(internKeyword(osArch.toUpperCase()));
/*      */       } 
/*      */     }
/*      */ 
/*      */ 
/*      */     
/* 2530 */     if (LispThread.virtualThreadingAvailable()) {
/* 2531 */       featureList = featureList.push(internKeyword("VIRTUAL-THREADS"));
/*      */     }
/*      */     
/* 2534 */     Symbol.FEATURES.initializeSpecial(featureList);
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2539 */     Symbol.MODULES.initializeSpecial(NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2544 */     Symbol.LOAD_VERBOSE.initializeSpecial(NIL);
/* 2545 */     Symbol.LOAD_PRINT.initializeSpecial(NIL);
/* 2546 */     Symbol.LOAD_PATHNAME.initializeSpecial(NIL);
/* 2547 */     Symbol.LOAD_TRUENAME.initializeSpecial(NIL);
/* 2548 */     Symbol.LOAD_TRUENAME_FASL.initializeSpecial(NIL);
/* 2549 */     Symbol.COMPILE_VERBOSE.initializeSpecial(T);
/* 2550 */     Symbol.COMPILE_PRINT.initializeSpecial(T);
/* 2551 */     Symbol._COMPILE_FILE_PATHNAME_.initializeSpecial(NIL);
/* 2552 */     Symbol.COMPILE_FILE_TRUENAME.initializeSpecial(NIL);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2558 */   public static final Symbol DOUBLE_COLON_PACKAGE_SEPARATORS = internSpecial("*DOUBLE-COLON-PACKAGE-SEPARATORS*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2563 */   public static final Symbol _LOAD_DEPTH_ = internSpecial("*LOAD-DEPTH*", PACKAGE_SYS, Fixnum.ZERO);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2568 */   public static final Symbol _LOAD_STREAM_ = internSpecial("*LOAD-STREAM*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2572 */   public static final Symbol _FASL_LOADER_ = exportSpecial("*FASL-LOADER*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2577 */   public static final Symbol _SOURCE_ = exportSpecial("*SOURCE*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2582 */   public static final Symbol _SOURCE_POSITION_ = exportSpecial("*SOURCE-POSITION*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2587 */   public static final Symbol _AUTOLOAD_VERBOSE_ = exportSpecial("*AUTOLOAD-VERBOSE*", PACKAGE_EXT, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2591 */   public static final Symbol AUTOLOADING_CACHE = internSpecial("*AUTOLOADING-CACHE*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2595 */   public static final Symbol _COMPILE_FILE_TYPE_ = exportSpecial("*COMPILE-FILE-TYPE*", PACKAGE_SYS, new SimpleString("abcl"));
/*      */ 
/*      */ 
/*      */   
/* 2599 */   public static final Symbol _COMPILE_FILE_CLASS_EXTENSION_ = exportSpecial("*COMPILE-FILE-CLASS-EXTENSION*", PACKAGE_SYS, new SimpleString("cls"));
/*      */ 
/*      */ 
/*      */   
/* 2603 */   public static final Symbol _COMPILE_FILE_ZIP_ = exportSpecial("*COMPILE-FILE-ZIP*", PACKAGE_SYS, T); public static final int ARRAY_DIMENSION_MAX = 2147483647;
/*      */   public static final int CHAR_MAX = 65535;
/*      */   
/*      */   static {
/* 2607 */     Symbol.MACROEXPAND_HOOK.initializeSpecial(Symbol.FUNCALL);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2614 */     Symbol.ARRAY_DIMENSION_LIMIT.initializeConstant(Fixnum.getInstance(2147483647));
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2622 */     Symbol.CHAR_CODE_LIMIT.initializeConstant(Fixnum.getInstance(65536));
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2627 */     Symbol.READ_BASE.initializeSpecial(Fixnum.constants[10]);
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2632 */     Symbol.READ_DEFAULT_FLOAT_FORMAT.initializeSpecial(Symbol.SINGLE_FLOAT);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2638 */     Symbol.PRINT_ARRAY.initializeSpecial(T);
/* 2639 */     Symbol.PRINT_BASE.initializeSpecial(Fixnum.constants[10]);
/* 2640 */     Symbol.PRINT_CASE.initializeSpecial(Keyword.UPCASE);
/* 2641 */     Symbol.PRINT_CIRCLE.initializeSpecial(NIL);
/* 2642 */     Symbol.PRINT_ESCAPE.initializeSpecial(T);
/* 2643 */     Symbol.PRINT_GENSYM.initializeSpecial(T);
/* 2644 */     Symbol.PRINT_LENGTH.initializeSpecial(NIL);
/* 2645 */     Symbol.PRINT_LEVEL.initializeSpecial(NIL);
/* 2646 */     Symbol.PRINT_LINES.initializeSpecial(NIL);
/* 2647 */     Symbol.PRINT_MISER_WIDTH.initializeSpecial(NIL);
/* 2648 */     Symbol.PRINT_PPRINT_DISPATCH.initializeSpecial(NIL);
/* 2649 */     Symbol.PRINT_PRETTY.initializeSpecial(NIL);
/* 2650 */     Symbol.PRINT_RADIX.initializeSpecial(NIL);
/* 2651 */     Symbol.PRINT_READABLY.initializeSpecial(NIL);
/* 2652 */     Symbol.PRINT_RIGHT_MARGIN.initializeSpecial(NIL);
/*      */   }
/*      */ 
/*      */   
/* 2656 */   public static final Symbol _PRINT_STRUCTURE_ = exportSpecial("*PRINT-STRUCTURE*", PACKAGE_EXT, T);
/*      */ 
/*      */ 
/*      */   
/* 2660 */   public static final Symbol _CURRENT_PRINT_LENGTH_ = exportSpecial("*CURRENT-PRINT-LENGTH*", PACKAGE_SYS, Fixnum.ZERO);
/*      */ 
/*      */ 
/*      */   
/* 2664 */   public static final Symbol _CURRENT_PRINT_LEVEL_ = exportSpecial("*CURRENT-PRINT-LEVEL*", PACKAGE_SYS, Fixnum.ZERO);
/*      */ 
/*      */   
/* 2667 */   public static final Symbol _PRINT_FASL_ = internSpecial("*PRINT-FASL*", PACKAGE_SYS, NIL);
/*      */ 
/*      */   
/*      */   static {
/* 2671 */     Symbol._RANDOM_STATE_.initializeSpecial(new RandomState());
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2676 */     Symbol.STAR.initializeSpecial(NIL);
/* 2677 */     Symbol.STAR_STAR.initializeSpecial(NIL);
/* 2678 */     Symbol.STAR_STAR_STAR.initializeSpecial(NIL);
/* 2679 */     Symbol.MINUS.initializeSpecial(NIL);
/* 2680 */     Symbol.PLUS.initializeSpecial(NIL);
/* 2681 */     Symbol.PLUS_PLUS.initializeSpecial(NIL);
/* 2682 */     Symbol.PLUS_PLUS_PLUS.initializeSpecial(NIL);
/* 2683 */     Symbol.SLASH.initializeSpecial(NIL);
/* 2684 */     Symbol.SLASH_SLASH.initializeSpecial(NIL);
/* 2685 */     Symbol.SLASH_SLASH_SLASH.initializeSpecial(NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2691 */     Symbol.PI.initializeConstant(new DoubleFloat(Math.PI));
/* 2692 */     Symbol.SHORT_FLOAT_EPSILON.initializeConstant(new SingleFloat(5.960465E-8F));
/* 2693 */     Symbol.SINGLE_FLOAT_EPSILON.initializeConstant(new SingleFloat(5.960465E-8F));
/* 2694 */     Symbol.DOUBLE_FLOAT_EPSILON.initializeConstant(new DoubleFloat(1.1102230246251568E-16D));
/* 2695 */     Symbol.LONG_FLOAT_EPSILON.initializeConstant(new DoubleFloat(1.1102230246251568E-16D));
/* 2696 */     Symbol.SHORT_FLOAT_NEGATIVE_EPSILON.initializeConstant(new SingleFloat(2.9802326E-8F));
/* 2697 */     Symbol.SINGLE_FLOAT_NEGATIVE_EPSILON.initializeConstant(new SingleFloat(2.9802326E-8F));
/* 2698 */     Symbol.DOUBLE_FLOAT_NEGATIVE_EPSILON.initializeConstant(new DoubleFloat(5.551115123125784E-17D));
/* 2699 */     Symbol.LONG_FLOAT_NEGATIVE_EPSILON.initializeConstant(new DoubleFloat(5.551115123125784E-17D));
/* 2700 */     Symbol.MOST_POSITIVE_SHORT_FLOAT.initializeConstant(new SingleFloat(Float.MAX_VALUE));
/* 2701 */     Symbol.MOST_POSITIVE_SINGLE_FLOAT.initializeConstant(new SingleFloat(Float.MAX_VALUE));
/* 2702 */     Symbol.MOST_POSITIVE_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(Double.MAX_VALUE));
/* 2703 */     Symbol.MOST_POSITIVE_LONG_FLOAT.initializeConstant(new DoubleFloat(Double.MAX_VALUE));
/* 2704 */     Symbol.LEAST_POSITIVE_SHORT_FLOAT.initializeConstant(new SingleFloat(Float.MIN_VALUE));
/* 2705 */     Symbol.LEAST_POSITIVE_SINGLE_FLOAT.initializeConstant(new SingleFloat(Float.MIN_VALUE));
/* 2706 */     Symbol.LEAST_POSITIVE_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(Double.MIN_VALUE));
/* 2707 */     Symbol.LEAST_POSITIVE_LONG_FLOAT.initializeConstant(new DoubleFloat(Double.MIN_VALUE));
/* 2708 */     Symbol.LEAST_POSITIVE_NORMALIZED_SHORT_FLOAT.initializeConstant(new SingleFloat(1.17549435E-38F));
/* 2709 */     Symbol.LEAST_POSITIVE_NORMALIZED_SINGLE_FLOAT.initializeConstant(new SingleFloat(1.17549435E-38F));
/* 2710 */     Symbol.LEAST_POSITIVE_NORMALIZED_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(2.2250738585072014E-308D));
/* 2711 */     Symbol.LEAST_POSITIVE_NORMALIZED_LONG_FLOAT.initializeConstant(new DoubleFloat(2.2250738585072014E-308D));
/* 2712 */     Symbol.MOST_NEGATIVE_SHORT_FLOAT.initializeConstant(new SingleFloat(-3.4028235E38F));
/* 2713 */     Symbol.MOST_NEGATIVE_SINGLE_FLOAT.initializeConstant(new SingleFloat(-3.4028235E38F));
/* 2714 */     Symbol.MOST_NEGATIVE_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(-1.7976931348623157E308D));
/* 2715 */     Symbol.MOST_NEGATIVE_LONG_FLOAT.initializeConstant(new DoubleFloat(-1.7976931348623157E308D));
/* 2716 */     Symbol.LEAST_NEGATIVE_SHORT_FLOAT.initializeConstant(new SingleFloat(-1.4E-45F));
/* 2717 */     Symbol.LEAST_NEGATIVE_SINGLE_FLOAT.initializeConstant(new SingleFloat(-1.4E-45F));
/* 2718 */     Symbol.LEAST_NEGATIVE_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(-4.9E-324D));
/* 2719 */     Symbol.LEAST_NEGATIVE_LONG_FLOAT.initializeConstant(new DoubleFloat(-4.9E-324D));
/* 2720 */     Symbol.LEAST_NEGATIVE_NORMALIZED_SHORT_FLOAT.initializeConstant(new SingleFloat(-1.17549435E-38F));
/* 2721 */     Symbol.LEAST_NEGATIVE_NORMALIZED_SINGLE_FLOAT.initializeConstant(new SingleFloat(-1.17549435E-38F));
/* 2722 */     Symbol.LEAST_NEGATIVE_NORMALIZED_DOUBLE_FLOAT.initializeConstant(new DoubleFloat(-2.2250738585072014E-308D));
/* 2723 */     Symbol.LEAST_NEGATIVE_NORMALIZED_LONG_FLOAT.initializeConstant(new DoubleFloat(-2.2250738585072014E-308D));
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2728 */     Symbol.BOOLE_CLR.initializeConstant(Fixnum.ZERO);
/* 2729 */     Symbol.BOOLE_SET.initializeConstant(Fixnum.ONE);
/* 2730 */     Symbol.BOOLE_1.initializeConstant(Fixnum.TWO);
/* 2731 */     Symbol.BOOLE_2.initializeConstant(Fixnum.constants[3]);
/* 2732 */     Symbol.BOOLE_C1.initializeConstant(Fixnum.constants[4]);
/* 2733 */     Symbol.BOOLE_C2.initializeConstant(Fixnum.constants[5]);
/* 2734 */     Symbol.BOOLE_AND.initializeConstant(Fixnum.constants[6]);
/* 2735 */     Symbol.BOOLE_IOR.initializeConstant(Fixnum.constants[7]);
/* 2736 */     Symbol.BOOLE_XOR.initializeConstant(Fixnum.constants[8]);
/* 2737 */     Symbol.BOOLE_EQV.initializeConstant(Fixnum.constants[9]);
/* 2738 */     Symbol.BOOLE_NAND.initializeConstant(Fixnum.constants[10]);
/* 2739 */     Symbol.BOOLE_NOR.initializeConstant(Fixnum.constants[11]);
/* 2740 */     Symbol.BOOLE_ANDC1.initializeConstant(Fixnum.constants[12]);
/* 2741 */     Symbol.BOOLE_ANDC2.initializeConstant(Fixnum.constants[13]);
/* 2742 */     Symbol.BOOLE_ORC1.initializeConstant(Fixnum.constants[14]);
/* 2743 */     Symbol.BOOLE_ORC2.initializeConstant(Fixnum.constants[15]);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2749 */     Symbol.CALL_ARGUMENTS_LIMIT.initializeConstant(Fixnum.getInstance(2147483647));
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2755 */     Symbol.LAMBDA_PARAMETERS_LIMIT.initializeConstant(Fixnum.getInstance(1024));
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2765 */     Symbol.MULTIPLE_VALUES_LIMIT.initializeConstant(Fixnum.constants[32]);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2771 */     Symbol.INTERNAL_TIME_UNITS_PER_SECOND.initializeConstant(Fixnum.getInstance(1000));
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2776 */     Symbol.LAMBDA_LIST_KEYWORDS
/* 2777 */       .initializeConstant(list(Symbol.AND_OPTIONAL, new LispObject[] { Symbol.AND_REST, Symbol.AND_KEY, Symbol.AND_AUX, Symbol.AND_BODY, Symbol.AND_WHOLE, Symbol.AND_ALLOW_OTHER_KEYS, Symbol.AND_ENVIRONMENT }));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2789 */   public static final Symbol CALL_REGISTERS_LIMIT = exportConstant("CALL-REGISTERS-LIMIT", PACKAGE_SYS, Fixnum.constants[8]);
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2794 */   public static final Symbol _WARN_ON_REDEFINITION_ = exportSpecial("*WARN-ON-REDEFINITION*", PACKAGE_EXT, T);
/*      */ 
/*      */ 
/*      */   
/* 2798 */   public static final Symbol _SAVED_BACKTRACE_ = exportSpecial("*SAVED-BACKTRACE*", PACKAGE_EXT, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2802 */   public static final Symbol _COMMAND_LINE_ARGUMENT_LIST_ = exportSpecial("*COMMAND-LINE-ARGUMENT-LIST*", PACKAGE_EXT, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2806 */   public static final Symbol _BATCH_MODE_ = exportSpecial("*BATCH-MODE*", PACKAGE_EXT, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2810 */   public static final Symbol _NOINFORM_ = exportSpecial("*NOINFORM*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2814 */   public static final Symbol _DISASSEMBLER_ = exportSpecial("*DISASSEMBLER*", PACKAGE_EXT, new SimpleString("javap -c -verbose"));
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2819 */   public static final Symbol _SPEED_ = exportSpecial("*SPEED*", PACKAGE_SYS, Fixnum.ONE);
/*      */ 
/*      */ 
/*      */   
/* 2823 */   public static final Symbol _SPACE_ = exportSpecial("*SPACE*", PACKAGE_SYS, Fixnum.ONE);
/*      */ 
/*      */ 
/*      */   
/* 2827 */   public static final Symbol _SAFETY_ = exportSpecial("*SAFETY*", PACKAGE_SYS, Fixnum.ONE);
/*      */ 
/*      */ 
/*      */   
/* 2831 */   public static final Symbol _DEBUG_ = exportSpecial("*DEBUG*", PACKAGE_SYS, Fixnum.ONE);
/*      */ 
/*      */ 
/*      */   
/* 2835 */   public static final Symbol _EXPLAIN_ = exportSpecial("*EXPLAIN*", PACKAGE_SYS, NIL);
/*      */ 
/*      */ 
/*      */   
/* 2839 */   public static final Symbol _ENABLE_INLINE_EXPANSION_ = exportSpecial("*ENABLE-INLINE-EXPANSION*", PACKAGE_EXT, T);
/*      */ 
/*      */ 
/*      */   
/* 2843 */   public static final Symbol _REQUIRE_STACK_FRAME_ = exportSpecial("*REQUIRE-STACK-FRAME*", PACKAGE_EXT, NIL);
/*      */ 
/*      */   
/*      */   static {
/* 2847 */     Symbol.SUPPRESS_COMPILER_WARNINGS.initializeSpecial(NIL);
/*      */   }
/*      */ 
/*      */   
/* 2851 */   public static final Symbol _COMPILE_FILE_ENVIRONMENT_ = exportSpecial("*COMPILE-FILE-ENVIRONMENT*", PACKAGE_SYS, NIL);
/*      */   
/* 2853 */   public static final LispObject UNBOUND_VALUE = new unboundValue();
/*      */   
/*      */   static class unboundValue
/*      */     extends LispObject
/*      */   {
/*      */     public String printObject() {
/* 2859 */       return unreadableString("UNBOUND", false);
/*      */     }
/*      */   }
/*      */   
/* 2863 */   public static final LispObject NULL_VALUE = new nullValue();
/*      */   
/*      */   static class nullValue
/*      */     extends LispObject
/*      */   {
/*      */     public String printObject() {
/* 2869 */       return unreadableString("null", false);
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 2874 */   public static final Symbol _SLOT_UNBOUND_ = exportConstant("+SLOT-UNBOUND+", PACKAGE_SYS, UNBOUND_VALUE);
/*      */ 
/*      */   
/* 2877 */   public static final Symbol _CL_PACKAGE_ = exportConstant("+CL-PACKAGE+", PACKAGE_SYS, PACKAGE_CL);
/*      */ 
/*      */   
/* 2880 */   public static final Symbol _KEYWORD_PACKAGE_ = exportConstant("+KEYWORD-PACKAGE+", PACKAGE_SYS, PACKAGE_KEYWORD);
/*      */ 
/*      */ 
/*      */   
/* 2884 */   public static final Symbol _BACKQUOTE_COUNT_ = internSpecial("*BACKQUOTE-COUNT*", PACKAGE_SYS, Fixnum.ZERO);
/*      */ 
/*      */ 
/*      */   
/* 2888 */   public static final Symbol _BQ_VECTOR_FLAG_ = internSpecial("*BQ-VECTOR-FLAG*", PACKAGE_SYS, list(new Symbol("bqv"), new LispObject[0]));
/*      */ 
/*      */ 
/*      */   
/* 2892 */   public static final Symbol _TRACED_NAMES_ = exportSpecial("*TRACED-NAMES*", PACKAGE_SYS, NIL);
/*      */   protected static boolean TRAP_OVERFLOW = true;
/*      */   protected static boolean TRAP_UNDERFLOW = true;
/*      */   private static Stream stdin;
/*      */   private static Stream stdout;
/*      */   private static final SpecialOperator WITH_INLINE_CODE;
/*      */   public static Object UNREACHED;
/*      */   
/*      */   static {
/* 2901 */     Symbol._INSPECTOR_HOOK_.initializeSpecial(NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2918 */     loadClass("org.armedbear.lisp.Primitives");
/* 2919 */     loadClass("org.armedbear.lisp.SpecialOperators");
/* 2920 */     loadClass("org.armedbear.lisp.Extensions");
/* 2921 */     loadClass("org.armedbear.lisp.CompiledClosure");
/* 2922 */     loadClass("org.armedbear.lisp.Autoload");
/* 2923 */     loadClass("org.armedbear.lisp.AutoloadMacro");
/* 2924 */     loadClass("org.armedbear.lisp.AutoloadGeneralizedReference");
/* 2925 */     loadClass("org.armedbear.lisp.cxr");
/* 2926 */     loadClass("org.armedbear.lisp.Do");
/* 2927 */     loadClass("org.armedbear.lisp.dolist");
/* 2928 */     loadClass("org.armedbear.lisp.dotimes");
/* 2929 */     loadClass("org.armedbear.lisp.Pathname");
/* 2930 */     loadClass("org.armedbear.lisp.LispClass");
/* 2931 */     loadClass("org.armedbear.lisp.BuiltInClass");
/* 2932 */     loadClass("org.armedbear.lisp.StructureObject");
/* 2933 */     loadClass("org.armedbear.lisp.ash");
/* 2934 */     loadClass("org.armedbear.lisp.Java");
/* 2935 */     loadClass("org.armedbear.lisp.PackageFunctions");
/* 2936 */     cold = false;
/*      */ 
/*      */     
/* 2939 */     stdin = new Stream(Symbol.SYSTEM_STREAM, System.in, Symbol.CHARACTER, true);
/*      */     
/* 2941 */     stdout = new Stream(Symbol.SYSTEM_STREAM, System.out, Symbol.CHARACTER, true);
/*      */ 
/*      */ 
/*      */     
/* 2945 */     Symbol.STANDARD_INPUT.initializeSpecial(stdin);
/* 2946 */     Symbol.STANDARD_OUTPUT.initializeSpecial(stdout);
/* 2947 */     Symbol.ERROR_OUTPUT.initializeSpecial(stdout);
/* 2948 */     Symbol.TRACE_OUTPUT.initializeSpecial(stdout);
/* 2949 */     Symbol.TERMINAL_IO.initializeSpecial(new TwoWayStream(stdin, stdout, true));
/* 2950 */     Symbol.QUERY_IO.initializeSpecial(new TwoWayStream(stdin, stdout, true));
/* 2951 */     Symbol.DEBUG_IO.initializeSpecial(new TwoWayStream(stdin, stdout, true));
/*      */ 
/*      */     
/* 2954 */     WITH_INLINE_CODE = new with_inline_code();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 2969 */     UNREACHED = null;
/*      */   }
/*      */   
/*      */   private static final void loadClass(String className) {
/*      */     try {
/*      */       Class.forName(className);
/*      */     } catch (ClassNotFoundException e) {
/*      */       Debug.trace(e);
/*      */     } 
/*      */   }
/*      */   
/*      */   private static class with_inline_code extends SpecialOperator {
/*      */     with_inline_code() {
/*      */       super("with-inline-code", Lisp.PACKAGE_JVM, true, "(&optional target repr) &body body");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/*      */       return Lisp.error(new SimpleError("This is a placeholder. It should only be called in compiled code, and tranformed by the compiler using special form handlers."));
/*      */     }
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Lisp.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */