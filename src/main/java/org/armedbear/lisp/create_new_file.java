/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.IOException;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class create_new_file
/*    */   extends Primitive
/*    */ {
/*    */   private create_new_file() {
/* 46 */     super("create-new-file", Lisp.PACKAGE_SYS, true, "namestring");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 52 */     String namestring = arg.getStringValue();
/*    */     try {
/* 54 */       return (new File(namestring)).createNewFile() ? Lisp.T : Lisp.NIL;
/*    */     }
/* 56 */     catch (IOException e) {
/* 57 */       return Lisp.error(new StreamError(null, e));
/*    */     } 
/*    */   }
/*    */   
/* 61 */   private static final Primitive CREATE_NEW_FILE = new create_new_file();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/create_new_file.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */