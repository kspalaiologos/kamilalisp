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
/*    */ public final class file_string_length
/*    */   extends Primitive
/*    */ {
/*    */   private file_string_length() {
/* 43 */     super("file-string-length", "stream object");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 50 */     return Lisp.checkStream(first).fileStringLength(second);
/*    */   }
/*    */   
/* 53 */   private static final Primitive FILE_STRING_LENGTH = new file_string_length();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/file_string_length.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */