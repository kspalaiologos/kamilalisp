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
/*     */ public final class MacroObject
/*     */   extends Function
/*     */ {
/*     */   protected final LispObject name;
/*     */   public final LispObject expander;
/*     */   
/*     */   public MacroObject(LispObject name, LispObject expander) {
/*  45 */     this.name = name;
/*  46 */     this.expander = expander;
/*  47 */     if (name instanceof Symbol && name != Lisp.NIL && expander instanceof Function) {
/*  48 */       ((Function)expander).setLambdaName(Lisp.list(Symbol.MACRO_FUNCTION, new LispObject[] { name }));
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/*  55 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/*  61 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/*  68 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*  76 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*  84 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/*  93 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 102 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 112 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 122 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 128 */     return Lisp.error(new UndefinedFunction(this.name));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 134 */     return unreadableString("MACRO-OBJECT");
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/MacroObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */