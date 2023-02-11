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
/*    */ public final class file_author
/*    */   extends Primitive
/*    */ {
/*    */   private file_author() {
/* 45 */     super("file-author");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 51 */     Pathname pathname = Lisp.coerceToPathname(arg);
/* 52 */     if (pathname.isWild())
/* 53 */       Lisp.error(new FileError("Bad place for a wild pathname.", pathname)); 
/* 54 */     return Lisp.NIL;
/*    */   }
/*    */   
/* 57 */   private static final Primitive FILE_AUTHOR = new file_author();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/file_author.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */