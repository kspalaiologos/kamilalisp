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
/*    */ public final class assq
/*    */   extends Primitive
/*    */ {
/*    */   private assq() {
/* 43 */     super("assq", Lisp.PACKAGE_EXT, true);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject item, LispObject alist) {
/* 50 */     return Lisp.assq(item, alist);
/*    */   }
/*    */   
/* 53 */   private static final Primitive ASSQ = new assq();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/assq.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */