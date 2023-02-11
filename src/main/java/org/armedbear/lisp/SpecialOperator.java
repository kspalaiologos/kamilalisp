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
/*     */ public class SpecialOperator
/*     */   extends Operator
/*     */ {
/*     */   private int callCount;
/*     */   private int hotCount;
/*     */   
/*     */   public SpecialOperator(Symbol symbol) {
/*  45 */     symbol.setSymbolFunction(this);
/*  46 */     setLambdaName(symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   public SpecialOperator(Symbol symbol, String arglist) {
/*  51 */     symbol.setSymbolFunction(this);
/*  52 */     setLambdaName(symbol);
/*  53 */     setLambdaList(new SimpleString(arglist));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SpecialOperator(String name, Package pkg, boolean exported, String arglist) {
/*     */     Symbol symbol;
/*  60 */     if (exported) {
/*  61 */       symbol = pkg.internAndExport(name.toUpperCase());
/*     */     } else {
/*  63 */       symbol = pkg.intern(name.toUpperCase());
/*  64 */     }  symbol.setSymbolFunction(this);
/*  65 */     setLambdaName(symbol);
/*  66 */     setLambdaList(new SimpleString(arglist));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/*  72 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/*  78 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/*  85 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*  93 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 101 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 110 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 119 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 129 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 139 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 145 */     return Lisp.error(new UndefinedFunction(getLambdaName()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 151 */     StringBuilder sb = new StringBuilder("SPECIAL-OPERATOR ");
/* 152 */     sb.append(this.lambdaName.princToString());
/* 153 */     return unreadableString(sb.toString(), false);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getCallCount() {
/* 160 */     return this.callCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setCallCount(int n) {
/* 166 */     this.callCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementCallCount() {
/* 172 */     this.callCount++;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getHotCount() {
/* 178 */     return this.hotCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setHotCount(int n) {
/* 184 */     this.callCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementHotCount() {
/* 190 */     this.hotCount++;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SpecialOperator.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */