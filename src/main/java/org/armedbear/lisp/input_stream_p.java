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
/*    */ public final class input_stream_p
/*    */   extends Primitive
/*    */ {
/*    */   private input_stream_p() {
/* 43 */     super("input-stream-p");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     return Lisp.checkStream(arg).isInputStream() ? Lisp.T : Lisp.NIL;
/*    */   }
/*    */   
/* 52 */   private static final Primitive INPUT_STREAM_P = new input_stream_p();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/input_stream_p.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */