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
/*    */ public final class interactive_stream_p
/*    */   extends Primitive
/*    */ {
/*    */   private interactive_stream_p() {
/* 43 */     super("interactive-stream-p", "stream");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     if (arg instanceof Stream)
/* 50 */       return ((Stream)arg).isInteractive() ? Lisp.T : Lisp.NIL; 
/* 51 */     return Lisp.type_error(arg, Symbol.STREAM);
/*    */   }
/*    */   
/* 54 */   private static final Primitive INTERACTIVE_STREAM_P = new interactive_stream_p();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/interactive_stream_p.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */