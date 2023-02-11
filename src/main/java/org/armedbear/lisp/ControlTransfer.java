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
/*    */ public abstract class ControlTransfer
/*    */   extends RuntimeException
/*    */ {
/*    */   public ControlTransfer() {}
/*    */   
/*    */   public Throwable fillInStackTrace() {
/* 64 */     return this;
/*    */   }
/*    */ 
/*    */   
/*    */   public ControlTransfer(String message) {
/* 69 */     super(message);
/*    */   }
/*    */   
/*    */   public abstract LispObject getCondition();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ControlTransfer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */