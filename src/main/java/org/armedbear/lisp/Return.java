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
/*    */ public final class Return
/*    */   extends ControlTransfer
/*    */ {
/*    */   public final LispObject tag;
/*    */   public final LispObject block;
/*    */   public final LispObject result;
/*    */   
/*    */   public Return(LispObject tag, LispObject block, LispObject result) {
/* 44 */     this.tag = tag;
/* 45 */     this.block = block;
/* 46 */     this.result = result;
/*    */   }
/*    */ 
/*    */   
/*    */   public Return(LispObject tag, LispObject result) {
/* 51 */     this.tag = tag;
/* 52 */     this.block = null;
/* 53 */     this.result = result;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getTag() {
/* 58 */     return this.tag;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getBlock() {
/* 63 */     return this.block;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getResult() {
/* 68 */     return this.result;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject getCondition() {
/* 74 */     StringBuilder sb = new StringBuilder("No block named ");
/* 75 */     sb.append(this.tag.princToString());
/* 76 */     sb.append(" is currently visible.");
/* 77 */     return new ControlError(sb.toString());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Return.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */