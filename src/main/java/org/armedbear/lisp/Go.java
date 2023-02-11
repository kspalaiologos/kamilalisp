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
/*    */ public final class Go
/*    */   extends ControlTransfer
/*    */ {
/*    */   public final LispObject tagbody;
/*    */   public final LispObject tag;
/*    */   
/*    */   public Go(LispObject tagbody, LispObject tag) {
/* 43 */     this.tagbody = tagbody;
/* 44 */     this.tag = tag;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getTagBody() {
/* 49 */     return this.tagbody;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getTag() {
/* 54 */     return this.tag;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject getCondition() {
/* 60 */     StringBuffer sb = new StringBuffer("No tag named ");
/* 61 */     sb.append(this.tag.princToString());
/* 62 */     sb.append(" is currently visible");
/* 63 */     return new ControlError(sb.toString());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Go.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */