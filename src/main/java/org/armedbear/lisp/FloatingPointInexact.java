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
/*    */ public final class FloatingPointInexact
/*    */   extends ArithmeticError
/*    */ {
/*    */   public FloatingPointInexact(LispObject initArgs) {
/* 42 */     super(StandardClass.FLOATING_POINT_INEXACT);
/* 43 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 49 */     return Symbol.FLOATING_POINT_INEXACT;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 55 */     return StandardClass.FLOATING_POINT_INEXACT;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 61 */     if (type == Symbol.FLOATING_POINT_INEXACT)
/* 62 */       return Lisp.T; 
/* 63 */     if (type == StandardClass.FLOATING_POINT_INEXACT)
/* 64 */       return Lisp.T; 
/* 65 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FloatingPointInexact.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */