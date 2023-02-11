/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.File;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.InputStreamReader;
/*     */ import java.io.OutputStream;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Interpreter
/*     */ {
/*     */   public static Interpreter interpreter;
/*     */   private final boolean jlisp;
/*     */   private final InputStream inputStream;
/*     */   private final OutputStream outputStream;
/*     */   private static boolean noinit = false;
/*     */   private static boolean nosystem = false;
/*     */   private static boolean noinform = false;
/*     */   private static boolean help = false;
/*     */   private static boolean doubledash = false;
/*     */   private static boolean topLevelInitialized;
/*     */   
/*     */   public static synchronized Interpreter getInstance() {
/*  62 */     return interpreter;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static synchronized Interpreter createInstance() {
/*  68 */     if (interpreter != null)
/*  69 */       return null; 
/*  70 */     interpreter = new Interpreter();
/*  71 */     Lisp._NOINFORM_.setSymbolValue(Lisp.T);
/*  72 */     initializeLisp();
/*  73 */     return interpreter;
/*     */   }
/*     */
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static synchronized Interpreter createJLispInstance(InputStream in, OutputStream out, String initialDirectory, String version) {
/* 121 */     if (interpreter != null)
/* 122 */       return null; 
/* 123 */     interpreter = new Interpreter(in, out, initialDirectory);
/*     */     
/* 130 */     initializeJLisp();
/* 131 */     initializeTopLevel();
/* 132 */     initializeSystem();
/* 134 */     return interpreter;
/*     */   }
/*     */   
/*     */   public static boolean initialized() {
/* 138 */     return Lisp.initialized;
/*     */   }
/*     */ 
/*     */   
/*     */   private Interpreter() {
/* 143 */     this.jlisp = false;
/* 144 */     this.inputStream = null;
/* 145 */     this.outputStream = null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private Interpreter(InputStream inputStream, OutputStream outputStream, String initialDirectory) {
/* 151 */     this.jlisp = true;
/* 152 */     this.inputStream = inputStream;
/* 153 */     this.outputStream = outputStream;
/* 154 */     Lisp.resetIO(new Stream(Symbol.SYSTEM_STREAM, inputStream, Symbol.CHARACTER), new Stream(Symbol.SYSTEM_STREAM, outputStream, Symbol.CHARACTER));
/*     */     
/* 156 */     if (!initialDirectory.endsWith(File.separator))
/* 157 */       initialDirectory = initialDirectory.concat(File.separator); 
/* 158 */     Symbol.DEFAULT_PATHNAME_DEFAULTS.setSymbolValue(Pathname.create(initialDirectory));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject eval(String s) {
/* 164 */     return Lisp.eval((new StringInputStream(s)).read(true, Lisp.NIL, false, 
/* 165 */           LispThread.currentThread(), Stream.currentReadtable));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static synchronized void initializeLisp() {
/* 171 */     if (!Lisp.initialized) {
/* 172 */       Load.loadSystemFile("boot.lisp", false, false, false);
/* 173 */       Lisp.initialized = true;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public static synchronized void initializeJLisp() {
/* 179 */     if (!Lisp.initialized) {
/* 180 */       Symbol.FEATURES.setSymbolValue(new Cons(Keyword.J, Symbol.FEATURES
/* 181 */             .getSymbolValue()));
/* 182 */       Load.loadSystemFile("boot.lisp", false, false, false);
/*     */       
/*     */       try {
/* 185 */         Class.forName("org.armedbear.j.LispAPI");
/*     */       }
/* 187 */       catch (ClassNotFoundException classNotFoundException) {}
/*     */       
/* 189 */       Load.loadSystemFile("j.lisp", false);
/*     */       
/* 191 */       Lisp.initialized = true;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static synchronized void initializeTopLevel() {
/* 199 */     if (!topLevelInitialized) {
/*     */       
/* 201 */       Symbol TOP_LEVEL_LOOP = Lisp.intern("TOP-LEVEL-LOOP", Lisp.PACKAGE_TPL);
/* 202 */       LispObject tplFun = TOP_LEVEL_LOOP.getSymbolFunction();
/* 203 */       if (tplFun instanceof Autoload) {
/* 204 */         Autoload autoload = (Autoload)tplFun;
/* 205 */         autoload.load();
/*     */       } 
/*     */       
/* 208 */       topLevelInitialized = true;
/*     */     } 
/*     */   }
/*     */   
/*     */   private static synchronized void initializeSystem() {
/* 237 */     Load.loadSystemFile("system", false);
/*     */   }
/*     */ 
/*     */
/*     */   
/*     */   public void run() {
/* 356 */     LispThread thread = LispThread.currentThread();
/*     */     try {
/* 358 */       Symbol TOP_LEVEL_LOOP = Lisp.intern("TOP-LEVEL-LOOP", Lisp.PACKAGE_TPL);
/* 359 */       LispObject tplFun = TOP_LEVEL_LOOP.getSymbolFunction();
/* 360 */       if (tplFun instanceof Function) {
/* 361 */         thread.execute(tplFun);
/*     */         
/*     */         return;
/*     */       } 
/* 365 */     } catch (ProcessingTerminated e) {
/* 366 */       throw e;
/*     */     }
/* 368 */     catch (IntegrityError e) {
/*     */       
/*     */       return;
/* 371 */     } catch (Throwable t) {
/* 372 */       t.printStackTrace();
/*     */ 
/*     */       
/*     */       return;
/*     */     } 
/*     */     
/* 378 */     Stream out = Lisp.getStandardOutput();
/*     */     while (true) {
/*     */       try {
/* 381 */         thread.resetStack();
/* 382 */         thread.clearSpecialBindings();
/* 383 */         out._writeString("* ");
/* 384 */         out._finishOutput();
/*     */         
/* 386 */         LispObject object = Lisp.getStandardInput().read(false, Lisp.EOF, false, thread, Stream.currentReadtable);
/*     */         
/* 388 */         if (object == Lisp.EOF)
/*     */           break; 
/* 390 */         out.setCharPos(0);
/* 391 */         Symbol.MINUS.setSymbolValue(object);
/* 392 */         LispObject result = Lisp.eval(object, new Environment(), thread);
/* 393 */         Debug.assertTrue((result != null));
/* 394 */         Symbol.STAR_STAR_STAR.setSymbolValue(Symbol.STAR_STAR.getSymbolValue());
/* 395 */         Symbol.STAR_STAR.setSymbolValue(Symbol.STAR.getSymbolValue());
/* 396 */         Symbol.STAR.setSymbolValue(result);
/* 397 */         Symbol.PLUS_PLUS_PLUS.setSymbolValue(Symbol.PLUS_PLUS.getSymbolValue());
/* 398 */         Symbol.PLUS_PLUS.setSymbolValue(Symbol.PLUS.getSymbolValue());
/* 399 */         Symbol.PLUS.setSymbolValue(Symbol.MINUS.getSymbolValue());
/* 400 */         out = Lisp.getStandardOutput();
/* 401 */         out.freshLine();
/* 402 */         LispObject[] values = thread.getValues();
/* 403 */         Symbol.SLASH_SLASH_SLASH.setSymbolValue(Symbol.SLASH_SLASH.getSymbolValue());
/* 404 */         Symbol.SLASH_SLASH.setSymbolValue(Symbol.SLASH.getSymbolValue());
/* 405 */         if (values != null) {
/* 406 */           LispObject slash = Lisp.NIL; int i;
/* 407 */           for (i = values.length; i-- > 0;)
/* 408 */             slash = new Cons(values[i], slash); 
/* 409 */           Symbol.SLASH.setSymbolValue(slash);
/* 410 */           for (i = 0; i < values.length; i++)
/* 411 */             out._writeLine(values[i].printObject()); 
/*     */         } else {
/* 413 */           Symbol.SLASH.setSymbolValue(new Cons(result));
/* 414 */           out._writeLine(result.printObject());
/*     */         } 
/* 416 */         out._finishOutput();
/*     */       }
/* 418 */       catch (StackOverflowError e) {
/* 419 */         Lisp.getStandardInput().clearInput();
/* 420 */         out._writeLine("Stack overflow");
/*     */       }
/* 422 */       catch (ControlTransfer c) {
/*     */ 
/*     */         
/* 425 */         reportError(c, thread);
/*     */       }
/* 427 */       catch (ProcessingTerminated e) {
/* 428 */         throw e;
/*     */       }
/* 430 */       catch (IntegrityError e) {
/*     */         
/*     */         return;
/* 433 */       } catch (Throwable t) {
/* 434 */         Lisp.getStandardInput().clearInput();
/* 435 */         out.printStackTrace(t);
/* 436 */         thread.printBacktrace();
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   private static void reportError(ControlTransfer c, LispThread thread) {
/* 443 */     Lisp.getStandardInput().clearInput();
/* 444 */     Stream out = Lisp.getStandardOutput();
/* 445 */     out.freshLine();
/* 446 */     Condition condition = (Condition)c.getCondition();
/* 447 */     out._writeLine("Error: unhandled condition: " + condition
/* 448 */         .princToString());
/* 449 */     if (thread != null) {
/* 450 */       thread.printBacktrace();
/*     */     }
/*     */   }
/*     */   
/*     */   private static void reportError(UnhandledCondition c, LispThread thread) {
/* 455 */     Lisp.getStandardInput().clearInput();
/* 456 */     Stream out = Lisp.getStandardOutput();
/* 457 */     out.freshLine();
/* 458 */     Condition condition = (Condition)c.getCondition();
/* 459 */     out._writeLine("Error: unhandled condition: " + condition
/* 460 */         .princToString());
/* 461 */     if (thread != null) {
/* 462 */       thread.printBacktrace();
/*     */     }
/*     */   }
/*     */   
/*     */   public void kill(int status) {
/* 467 */     if (this.jlisp) {
/*     */       try {
/* 469 */         this.inputStream.close();
/*     */       }
/* 471 */       catch (IOException e) {
/* 472 */         Debug.trace(e);
/*     */       } 
/*     */       try {
/* 475 */         this.outputStream.close();
/*     */       }
/* 477 */       catch (IOException e) {
/* 478 */         Debug.trace(e);
/*     */       } 
/*     */     } else {
/* 481 */       ((Stream)Symbol.STANDARD_OUTPUT.getSymbolValue())._finishOutput();
/* 482 */       ((Stream)Symbol.ERROR_OUTPUT.getSymbolValue())._finishOutput();
/* 483 */       System.exit(status);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized void dispose() {
/* 489 */     Debug.trace("Interpreter.dispose");
/* 490 */     Debug.assertTrue((interpreter == this));
/* 491 */     interpreter = null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void finalize() throws Throwable {
/* 497 */     System.err.println("Interpreter.finalize");
/*     */   }
/*     */   
/*     */   public static final class UnhandledCondition
/*     */     extends Error {
/*     */     LispObject condition;
/*     */     
/*     */     UnhandledCondition(LispObject condition) {
/* 505 */       this.condition = condition;
/*     */     }
/*     */     
/*     */     public LispObject getCondition() {
/* 509 */       return this.condition;
/*     */     }
/*     */ 
/*     */     
/*     */     public String getMessage() {
/*     */       String conditionText;
/* 515 */       LispThread thread = LispThread.currentThread();
/* 516 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/* 517 */       thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.NIL);
/*     */       try {
/* 519 */         conditionText = getCondition().princToString();
/* 520 */       } catch (Throwable t) {
/* 521 */         conditionText = "<error printing Lisp condition>";
/*     */       } finally {
/* 523 */         thread.resetSpecialBindings(mark);
/*     */       } 
/*     */       
/* 526 */       return "Unhandled lisp condition: " + conditionText;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 532 */   private static final Primitive _DEBUGGER_HOOK_FUNCTION = new Primitive("%debugger-hook-function", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 538 */         LispObject condition = first;
/* 539 */         if (Interpreter.interpreter == null) {
/* 540 */           LispThread thread = LispThread.currentThread();
/* 541 */           SpecialBindingsMark mark = thread.markSpecialBindings();
/* 542 */           thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.NIL);
/*     */ 
/*     */           
/* 545 */           try { LispObject truename = Symbol.LOAD_TRUENAME.symbolValue(thread);
/* 546 */             if (truename != Lisp.NIL) {
/*     */               
/* 548 */               LispObject stream = Lisp._LOAD_STREAM_.symbolValue(thread);
/* 549 */               if (stream instanceof Stream) {
/*     */                 
/* 551 */                 int lineNumber = ((Stream)stream).getLineNumber() + 1;
/*     */                 
/* 553 */                 int offset = ((Stream)stream).getOffset();
/* 554 */                 Debug.trace("Error loading " + truename
/* 555 */                     .princToString() + " at line " + lineNumber + " (offset " + offset + ")");
/*     */               } 
/*     */             } 
/*     */ 
/*     */             
/* 560 */             Debug.trace("Encountered unhandled condition of type " + condition
/* 561 */                 .typeOf().princToString() + ':');
/* 562 */             Debug.trace("  " + condition.princToString()); }
/*     */           
/* 564 */           catch (Throwable throwable) {  }
/*     */           finally
/* 566 */           { thread.resetSpecialBindings(mark); }
/*     */         
/*     */         } 
/* 569 */         Interpreter.UnhandledCondition uc = new Interpreter.UnhandledCondition(condition);
/* 570 */         if (condition.typep(Symbol.JAVA_EXCEPTION) != Lisp.NIL)
/* 571 */           uc.initCause((Throwable)JavaException.JAVA_EXCEPTION_CAUSE
/* 572 */               .execute(condition).javaInstance()); 
/* 573 */         throw uc;
/*     */       }
/*     */     };
/*     */   public static final LispObject readFromString(String s) {
/* 579 */     return (new StringInputStream(s)).read(true, Lisp.NIL, false, 
/* 580 */         LispThread.currentThread(), Stream.currentReadtable);
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
/*     */   public static LispObject evaluate(String s) {
/* 594 */     if (!Lisp.initialized)
/* 595 */       initializeJLisp(); 
/* 596 */     StringInputStream stream = new StringInputStream(s);
/* 597 */     LispThread thread = LispThread.currentThread();
/* 598 */     LispObject obj = null;
/*     */     
/* 600 */     SpecialBindingsMark mark0 = thread.markSpecialBindings();
/* 601 */     thread.bindSpecial(Symbol.DEBUGGER_HOOK, _DEBUGGER_HOOK_FUNCTION);
/*     */     try {
/* 603 */       obj = stream.read(false, Lisp.EOF, false, thread, Stream.currentReadtable);
/*     */     } finally {
/*     */       
/* 606 */       thread.resetSpecialBindings(mark0);
/*     */     } 
/* 608 */     if (obj == Lisp.EOF) {
/* 609 */       return Lisp.error(new EndOfFile(stream));
/*     */     }
/* 611 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 612 */     thread.bindSpecial(Symbol.DEBUGGER_HOOK, _DEBUGGER_HOOK_FUNCTION);
/*     */     try {
/* 614 */       return Lisp.eval(obj, new Environment(), thread);
/*     */     } finally {
/*     */       
/* 617 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Interpreter.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */