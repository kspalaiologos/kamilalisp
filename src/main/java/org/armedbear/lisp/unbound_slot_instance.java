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
/*    */ public final class unbound_slot_instance
/*    */   extends Primitive
/*    */ {
/*    */   private unbound_slot_instance() {
/* 43 */     super("unbound-slot-instance");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     if (arg instanceof UnboundSlot)
/* 50 */       return ((UnboundSlot)arg).getInstance(); 
/* 51 */     return Lisp.type_error(arg, Symbol.UNBOUND_SLOT);
/*    */   }
/*    */   
/* 54 */   private static final unbound_slot_instance CELL_ERROR_NAME = new unbound_slot_instance();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/unbound_slot_instance.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */