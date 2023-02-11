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
/*    */ public final class file_write_date
/*    */   extends Primitive
/*    */ {
/*    */   private file_write_date() {
/* 45 */     super("file-write-date");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 51 */     Pathname pathname = Lisp.coerceToPathname(arg);
/* 52 */     if (pathname.isWild())
/* 53 */       Lisp.error(new FileError("Bad place for a wild pathname.", pathname)); 
/* 54 */     Pathname defaultedPathname = (Pathname)Pathname.MERGE_PATHNAMES.execute(pathname);
/* 55 */     long lastModified = defaultedPathname.getLastModified();
/* 56 */     if (lastModified == 0L)
/* 57 */       return Lisp.NIL; 
/* 58 */     return Lisp.number(lastModified / 1000L + 2208988800L);
/*    */   }
/*    */   
/* 61 */   private static final Primitive FILE_WRITE_DATE = new file_write_date();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/file_write_date.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */