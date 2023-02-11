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
/*    */ public final class rem
/*    */   extends Primitive
/*    */ {
/*    */   private rem() {
/* 41 */     super("rem", "number divisor");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject number, LispObject divisor) {
/* 48 */     number.truncate(divisor);
/* 49 */     LispThread thread = LispThread.currentThread();
/* 50 */     LispObject remainder = thread._values[1];
/* 51 */     thread.clearValues();
/* 52 */     return remainder;
/*    */   }
/*    */   
/* 55 */   private static final Primitive REM = new rem();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/rem.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */