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
/*    */ 
/*    */ public final class FloatingPointOverflow
/*    */   extends ArithmeticError
/*    */ {
/*    */   public FloatingPointOverflow(LispObject initArgs) {
/* 43 */     super(StandardClass.FLOATING_POINT_OVERFLOW);
/* 44 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 50 */     return Symbol.FLOATING_POINT_OVERFLOW;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 56 */     return StandardClass.FLOATING_POINT_OVERFLOW;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 62 */     if (type == Symbol.FLOATING_POINT_OVERFLOW)
/* 63 */       return Lisp.T; 
/* 64 */     if (type == StandardClass.FLOATING_POINT_OVERFLOW)
/* 65 */       return Lisp.T; 
/* 66 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FloatingPointOverflow.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */