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
/*    */ public final class FloatingPointInvalidOperation
/*    */   extends ArithmeticError
/*    */ {
/*    */   public FloatingPointInvalidOperation(LispObject initArgs) {
/* 43 */     super(StandardClass.FLOATING_POINT_INVALID_OPERATION);
/* 44 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 50 */     return Symbol.FLOATING_POINT_INVALID_OPERATION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 56 */     return StandardClass.FLOATING_POINT_INVALID_OPERATION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 62 */     if (type == Symbol.FLOATING_POINT_INVALID_OPERATION)
/* 63 */       return Lisp.T; 
/* 64 */     if (type == StandardClass.FLOATING_POINT_INVALID_OPERATION)
/* 65 */       return Lisp.T; 
/* 66 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FloatingPointInvalidOperation.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */