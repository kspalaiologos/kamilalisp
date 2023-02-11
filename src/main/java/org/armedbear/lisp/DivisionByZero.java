/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class DivisionByZero
/*    */   extends ArithmeticError
/*    */ {
/*    */   public DivisionByZero() {
/* 42 */     super(StandardClass.DIVISION_BY_ZERO);
/* 43 */     setFormatControl("Arithmetic error DIVISION-BY-ZERO signalled.");
/*    */   }
/*    */ 
/*    */   
/*    */   public DivisionByZero(LispObject initArgs) {
/* 48 */     super(StandardClass.DIVISION_BY_ZERO);
/* 49 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 55 */     return Symbol.DIVISION_BY_ZERO;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 61 */     return StandardClass.DIVISION_BY_ZERO;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 67 */     if (type == Symbol.DIVISION_BY_ZERO)
/* 68 */       return Lisp.T; 
/* 69 */     if (type == StandardClass.DIVISION_BY_ZERO)
/* 70 */       return Lisp.T; 
/* 71 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/DivisionByZero.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */