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
/*    */ public final class stream_element_type
/*    */   extends Primitive
/*    */ {
/*    */   private stream_element_type() {
/* 43 */     super("stream-element-type", "stream");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     return Lisp.checkStream(arg).getElementType();
/*    */   }
/*    */   
/* 52 */   private static final Primitive STREAM_ELEMENT_TYPE = new stream_element_type();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/stream_element_type.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */