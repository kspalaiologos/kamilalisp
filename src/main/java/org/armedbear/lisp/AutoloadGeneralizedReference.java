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
/*     */ public final class AutoloadGeneralizedReference
/*     */   extends Autoload
/*     */ {
/*     */   Symbol indicator;
/*     */   
/*     */   private AutoloadGeneralizedReference(Symbol symbol, Symbol indicator, String filename) {
/*  42 */     super(symbol, filename, null);
/*  43 */     this.indicator = indicator;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void load() {
/*  49 */     Load.loadSystemFile(getFileName(), true);
/*     */   }
/*     */   
/*  52 */   static final Symbol SETF_EXPANDER = Lisp.PACKAGE_SYS.intern("SETF-EXPANDER");
/*  53 */   public static final Primitive AUTOLOAD_SETF_EXPANDER = new pf_autoload_setf_expander();
/*     */ 
/*     */   
/*     */   @DocString(name = "autoload-setf-expander", args = "symbol-or-symbols filename", doc = "Setup the autoload for SYMBOL-OR-SYMBOLS on the setf-expander from FILENAME.")
/*     */   private static final class pf_autoload_setf_expander
/*     */     extends Primitive
/*     */   {
/*     */     pf_autoload_setf_expander() {
/*  61 */       super("autoload-setf-expander", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*  65 */       String filename = second.getStringValue();
/*  66 */       return AutoloadGeneralizedReference.installAutoloadGeneralizedReference(first, AutoloadGeneralizedReference.SETF_EXPANDER, filename);
/*     */     }
/*     */   }
/*     */   
/*  70 */   static final Symbol SETF_FUNCTION = Lisp.PACKAGE_SYS.intern("SETF-FUNCTION");
/*  71 */   public static final Primitive AUTOLOAD_SETF_FUNCTION = new pf_autoload_setf_function();
/*     */ 
/*     */   
/*     */   @DocString(name = "autoload-setf-function", args = "symbol-or-symbols filename", doc = "Setup the autoload for SYMBOL-OR-SYMBOLS on the setf-function from FILENAME.")
/*     */   private static final class pf_autoload_setf_function
/*     */     extends Primitive
/*     */   {
/*     */     pf_autoload_setf_function() {
/*  79 */       super("autoload-setf-function", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*  83 */       String filename = second.getStringValue();
/*  84 */       return AutoloadGeneralizedReference.installAutoloadGeneralizedReference(first, AutoloadGeneralizedReference.SETF_FUNCTION, filename);
/*     */     }
/*     */   }
/*     */   
/*  88 */   public static final Primitive AUTOLOAD_REF_P = new pf_autoload_ref_p();
/*     */ 
/*     */   
/*     */   @DocString(name = "autoload-ref-p", args = "symbol", doc = "Boolean predicate for whether SYMBOL has generalized reference functions which need to be resolved.")
/*     */   private static final class pf_autoload_ref_p
/*     */     extends Primitive
/*     */   {
/*     */     pf_autoload_ref_p() {
/*  96 */       super("autoload-ref-p", Lisp.PACKAGE_EXT, true, "symbol");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 100 */       LispObject list = Lisp.checkSymbol(arg).getPropertyList();
/* 101 */       while (list != Lisp.NIL) {
/* 102 */         if (list.car() instanceof AutoloadGeneralizedReference) {
/* 103 */           return Lisp.T;
/*     */         }
/*     */         
/* 106 */         list = list.cdr();
/*     */       } 
/* 108 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static final LispObject installAutoloadGeneralizedReference(LispObject first, Symbol indicator, String filename) {
/* 117 */     if (first instanceof Symbol) {
/* 118 */       Symbol symbol = Lisp.checkSymbol(first);
/* 119 */       install(symbol, indicator, filename);
/* 120 */       return Lisp.T;
/*     */     } 
/* 122 */     if (first instanceof Cons) {
/* 123 */       for (LispObject list = first; list != Lisp.NIL; list = list.cdr()) {
/* 124 */         Symbol symbol = Lisp.checkSymbol(list.car());
/* 125 */         install(symbol, indicator, filename);
/*     */       } 
/* 127 */       return Lisp.T;
/*     */     } 
/* 129 */     return Lisp.error(new TypeError(first));
/*     */   }
/*     */   
/*     */   private static LispObject install(Symbol symbol, Symbol indicator, String filename) {
/* 133 */     if (Lisp.get(symbol, indicator) == Lisp.NIL) {
/* 134 */       return Primitives.PUT.execute(symbol, indicator, new AutoloadGeneralizedReference(symbol, indicator, filename));
/*     */     }
/*     */     
/* 137 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 144 */     load();
/* 145 */     return Lisp.get(this.symbol, this.indicator, null).execute();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 151 */     load();
/* 152 */     return Lisp.get(this.symbol, this.indicator, null).execute(arg);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 159 */     load();
/* 160 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 168 */     load();
/* 169 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second, third);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 177 */     load();
/* 178 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second, third, fourth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 187 */     load();
/* 188 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second, third, fourth, fifth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 197 */     load();
/* 198 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second, third, fourth, fifth, sixth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 208 */     load();
/* 209 */     return this.symbol.execute(first, second, third, fourth, fifth, sixth, seventh);
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
/* 220 */     load();
/* 221 */     return Lisp.get(this.symbol, this.indicator, null).execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 228 */     load();
/* 229 */     return Lisp.get(this.symbol, this.indicator, null).execute(args);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AutoloadGeneralizedReference.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */