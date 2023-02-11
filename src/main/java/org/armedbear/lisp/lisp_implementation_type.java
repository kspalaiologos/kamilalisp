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
/*    */ public final class lisp_implementation_type
/*    */   extends Primitive
/*    */ {
/*    */   private lisp_implementation_type() {
/* 41 */     super("lisp-implementation-type", "");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 47 */     return new SimpleString("Armed Bear Common Lisp");
/*    */   }
/*    */   
/* 50 */   private static final lisp_implementation_type LISP_IMPLEMENTATION_TYPE = new lisp_implementation_type();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/lisp_implementation_type.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */