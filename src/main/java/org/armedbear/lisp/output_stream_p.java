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
/*    */ public final class output_stream_p
/*    */   extends Primitive
/*    */ {
/*    */   private output_stream_p() {
/* 43 */     super("output-stream-p");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     return Lisp.checkStream(arg).isOutputStream() ? Lisp.T : Lisp.NIL;
/*    */   }
/*    */   
/* 52 */   private static final Primitive OUTPUT_STREAM_P = new output_stream_p();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/output_stream_p.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */