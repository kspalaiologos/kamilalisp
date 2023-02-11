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
/*    */ public final class file_length
/*    */   extends Primitive
/*    */ {
/*    */   private file_length() {
/* 42 */     super("file-length", "stream");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 50 */     return Lisp.checkStream(arg).fileLength();
/*    */   }
/*    */   
/* 53 */   private static final Primitive FILE_LENGTH = new file_length();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/file_length.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */