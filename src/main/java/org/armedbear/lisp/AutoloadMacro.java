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
/*     */ public final class AutoloadMacro
/*     */   extends Autoload
/*     */ {
/*     */   private AutoloadMacro(Symbol symbol) {
/*  42 */     super(symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   private AutoloadMacro(Symbol symbol, String fileName) {
/*  47 */     super(symbol, fileName, (String)null);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   static void installAutoloadMacro(Symbol symbol, String fileName) {
/*  53 */     AutoloadMacro am = new AutoloadMacro(symbol, fileName);
/*  54 */     if (symbol.getSymbolFunction() instanceof SpecialOperator) {
/*  55 */       Lisp.put(symbol, Symbol.MACROEXPAND_MACRO, am);
/*     */     } else {
/*  57 */       symbol.setSymbolFunction(am);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void load() {
/*  63 */     Load.loadSystemFile(getFileName(), true);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  69 */     StringBuilder sb = new StringBuilder();
/*  70 */     sb.append(getSymbol().princToString());
/*  71 */     sb.append(" \"");
/*  72 */     sb.append(getFileName());
/*  73 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */   
/*  77 */   private static final Primitive AUTOLOAD_MACRO = new Primitive("autoload-macro", Lisp.PACKAGE_EXT, true)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first)
/*     */       {
/*  83 */         if (first instanceof Symbol) {
/*  84 */           Symbol symbol = (Symbol)first;
/*  85 */           AutoloadMacro.installAutoloadMacro(symbol, (String)null);
/*  86 */           return Lisp.T;
/*     */         } 
/*  88 */         if (first instanceof Cons) {
/*  89 */           for (LispObject list = first; list != Lisp.NIL; list = list.cdr()) {
/*  90 */             Symbol symbol = Lisp.checkSymbol(list.car());
/*  91 */             AutoloadMacro.installAutoloadMacro(symbol, (String)null);
/*     */           } 
/*  93 */           return Lisp.T;
/*     */         } 
/*  95 */         return Lisp.error(new TypeError(first));
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 101 */         String fileName = second.getStringValue();
/* 102 */         if (first instanceof Symbol) {
/* 103 */           Symbol symbol = (Symbol)first;
/* 104 */           AutoloadMacro.installAutoloadMacro(symbol, fileName);
/* 105 */           return Lisp.T;
/*     */         } 
/* 107 */         if (first instanceof Cons) {
/* 108 */           for (LispObject list = first; list != Lisp.NIL; list = list.cdr()) {
/* 109 */             Symbol symbol = Lisp.checkSymbol(list.car());
/* 110 */             AutoloadMacro.installAutoloadMacro(symbol, fileName);
/*     */           } 
/* 112 */           return Lisp.T;
/*     */         } 
/* 114 */         return Lisp.error(new TypeError(first));
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AutoloadMacro.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */