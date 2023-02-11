/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.lang.ref.WeakReference;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class SpecialBinding
/*    */ {
/*    */   final int idx;
/*    */   public LispObject value;
/*    */   
/*    */   SpecialBinding(int idx, LispObject value) {
/* 48 */     this.idx = idx;
/* 49 */     this.value = value;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public final LispObject getValue() {
/* 60 */     if (this.value == null)
/*    */     {
/* 62 */       Lisp.error(new UnboundVariable(((WeakReference<LispObject>)LispThread.specialNames.get(Integer.valueOf(this.idx))).get()));
/*    */     }
/* 64 */     return this.value;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public final void setValue(LispObject value) {
/* 74 */     this.value = value;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SpecialBinding.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */