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
/*    */ public final class open_stream_p
/*    */   extends Primitive
/*    */ {
/*    */   private open_stream_p() {
/* 43 */     super("open-stream-p");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     return Lisp.checkStream(arg).isOpen() ? Lisp.T : Lisp.NIL;
/*    */   }
/*    */   
/* 52 */   private static final Primitive OPEN_STREAM_P = new open_stream_p();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/open_stream_p.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */