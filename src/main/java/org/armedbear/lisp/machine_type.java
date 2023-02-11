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
/*    */ public final class machine_type
/*    */   extends Primitive
/*    */ {
/*    */   private machine_type() {
/* 41 */     super("machine-type");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 47 */     String s = System.getProperty("os.arch");
/* 48 */     if (s == null) {
/* 49 */       s = "UNKNOWN";
/* 50 */     } else if (s.equals("amd64")) {
/* 51 */       s = "X86-64";
/*    */     } else {
/* 53 */       s = s.toUpperCase();
/* 54 */     }  return new SimpleString(s);
/*    */   }
/*    */   
/* 57 */   private static final Primitive MACHINE_TYPE = new machine_type();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/machine_type.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */