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
/*    */ public final class mod
/*    */   extends Primitive
/*    */ {
/*    */   private mod() {
/* 41 */     super("mod", "number divisor");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject number, LispObject divisor) {
/* 48 */     return number.MOD(divisor);
/*    */   }
/*    */   
/* 51 */   private static final Primitive MOD = new mod();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/mod.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */