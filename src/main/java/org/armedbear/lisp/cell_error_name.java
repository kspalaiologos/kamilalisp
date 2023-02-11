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
/*    */ public final class cell_error_name
/*    */   extends Primitive
/*    */ {
/*    */   private cell_error_name() {
/* 43 */     super(Symbol.CELL_ERROR_NAME, "condition");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/*    */     StandardObject obj;
/* 50 */     if (arg instanceof StandardObject) {
/* 51 */       obj = (StandardObject)arg;
/*    */     } else {
/*    */       
/* 54 */       return Lisp.type_error(arg, Symbol.STANDARD_OBJECT);
/*    */     } 
/* 56 */     return obj.getInstanceSlotValue(Symbol.NAME);
/*    */   }
/*    */   
/* 59 */   private static final Primitive CELL_ERROR_NAME = new cell_error_name();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/cell_error_name.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */