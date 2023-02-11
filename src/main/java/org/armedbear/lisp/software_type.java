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
/*    */ public final class software_type
/*    */   extends Primitive
/*    */ {
/*    */   private software_type() {
/* 41 */     super("software-type");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 47 */     return new SimpleString(System.getProperty("os.name"));
/*    */   }
/*    */   
/* 50 */   private static final Primitive SOFTWARE_TYPE = new software_type();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/software_type.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */