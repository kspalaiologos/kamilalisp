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
/*     */ public class Profiler
/*     */ {
/*  40 */   static int sleep = 1;
/*     */ 
/*     */ 
/*     */   
/*  44 */   public static final Primitive _START_PROFILER = new Primitive("%start-profiler", Lisp.PACKAGE_PROF, false)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/*  51 */         final LispThread thread = LispThread.currentThread();
/*  52 */         Stream out = Lisp.getStandardOutput();
/*  53 */         out.freshLine();
/*  54 */         if (Lisp.profiling) {
/*  55 */           out._writeLine("; Profiler already started.");
/*     */         } else {
/*  57 */           if (first == Keyword.TIME) {
/*  58 */             Lisp.sampling = true;
/*  59 */           } else if (first == Keyword.COUNT_ONLY) {
/*  60 */             Lisp.sampling = false;
/*     */           } else {
/*  62 */             return Lisp.error(new LispError("%START-PROFILER: argument must be either :TIME or :COUNT-ONLY"));
/*     */           } 
/*  64 */           Package[] packages = Packages.getAllPackages();
/*  65 */           for (int i = 0; i < packages.length; i++) {
/*  66 */             Package pkg = packages[i];
/*  67 */             Symbol[] symbols = pkg.symbols();
/*  68 */             for (int j = 0; j < symbols.length; j++) {
/*  69 */               Symbol symbol = symbols[j];
/*  70 */               LispObject object = symbol.getSymbolFunction();
/*  71 */               if (object != null) {
/*  72 */                 object.setCallCount(0);
/*  73 */                 object.setHotCount(0);
/*  74 */                 LispObject methods = null;
/*  75 */                 if (object.typep(Symbol.STANDARD_GENERIC_FUNCTION) != Lisp.NIL)
/*     */                 {
/*  77 */                   methods = Symbol.GENERIC_FUNCTION_METHODS.execute(object);
/*     */                 }
/*  79 */                 while (methods != null && methods != Lisp.NIL) {
/*  80 */                   LispObject method = methods.car();
/*     */                   
/*  82 */                   LispObject function = Symbol.METHOD_FUNCTION.execute(method);
/*  83 */                   if (function != Lisp.NIL) {
/*  84 */                     function.setCallCount(0);
/*  85 */                     function.setHotCount(0);
/*  86 */                     methods = methods.cdr();
/*     */                   } 
/*     */                 } 
/*     */               } 
/*     */             } 
/*     */           } 
/*  92 */           if (Lisp.sampling) {
/*  93 */             Profiler.sleep = Fixnum.getValue(second);
/*  94 */             Runnable profilerRunnable = new Runnable()
/*     */               {
/*     */                 public void run() {
/*  97 */                   Lisp.profiling = true;
/*  98 */                   while (Lisp.profiling) {
/*     */                     try {
/* 100 */                       thread.incrementCallCounts();
/* 101 */                       Thread.sleep(Profiler.sleep);
/*     */                     
/*     */                     }
/* 104 */                     catch (InterruptedException e) {
/* 105 */                       Debug.trace(e);
/*     */                     } 
/*     */                   } 
/*     */                 }
/*     */               };
/* 110 */             Thread t = new Thread(profilerRunnable);
/*     */ 
/*     */             
/* 113 */             t.setPriority(10);
/* 114 */             (new Thread(profilerRunnable)).start();
/*     */           } 
/* 116 */           out._writeLine("; Profiler started.");
/*     */         } 
/* 118 */         return thread.nothing();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 123 */   public static final Primitive STOP_PROFILER = new Primitive("stop-profiler", Lisp.PACKAGE_PROF, true)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 129 */         Stream out = Lisp.getStandardOutput();
/* 130 */         out.freshLine();
/* 131 */         if (Lisp.profiling) {
/* 132 */           Lisp.profiling = false;
/* 133 */           out._writeLine("; Profiler stopped.");
/*     */         } else {
/* 135 */           out._writeLine("; Profiler was not started.");
/* 136 */         }  out._finishOutput();
/* 137 */         return LispThread.currentThread().nothing();
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Profiler.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */