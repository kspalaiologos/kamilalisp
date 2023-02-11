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
/*    */ public final class Throw
/*    */   extends ControlTransfer
/*    */ {
/*    */   public final LispObject tag;
/*    */   private final LispObject result;
/*    */   private final LispObject[] values;
/*    */   
/*    */   public Throw(LispObject tag, LispObject result, LispThread thread) {
/* 45 */     this.tag = tag;
/* 46 */     this.result = result;
/* 47 */     this.values = thread._values;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getResult(LispThread thread) {
/* 52 */     thread._values = this.values;
/* 53 */     return this.result;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject getCondition() {
/* 59 */     return new ControlError("Attempt to throw to the nonexistent tag " + this.tag
/* 60 */         .princToString() + ".");
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Throw.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */