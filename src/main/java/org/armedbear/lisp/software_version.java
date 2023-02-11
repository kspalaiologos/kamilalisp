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
/*    */ public final class software_version
/*    */   extends Primitive
/*    */ {
/*    */   private software_version() {
/* 41 */     super("software-version");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 47 */     return new SimpleString(System.getProperty("os.version"));
/*    */   }
/*    */   
/* 50 */   private static final Primitive SOFTWARE_VERSION = new software_version();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/software_version.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */