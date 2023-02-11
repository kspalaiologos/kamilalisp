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
/*    */ public class ProcessingTerminated
/*    */   extends Error
/*    */ {
/*    */   private int status;
/*    */   
/*    */   public ProcessingTerminated() {}
/*    */   
/*    */   public ProcessingTerminated(int status) {
/* 52 */     this.status = status;
/*    */   }
/*    */   
/*    */   public int getStatus() {
/* 56 */     return this.status;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ProcessingTerminated.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */