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
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class SpecialBindingsMark
/*    */ {
/*    */   int idx;
/*    */   SpecialBinding binding;
/*    */   SpecialBindingsMark next;
/*    */   
/*    */   SpecialBindingsMark(int idx, SpecialBinding binding, SpecialBindingsMark next) {
/* 54 */     this.idx = idx;
/* 55 */     this.binding = binding;
/* 56 */     this.next = next;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SpecialBindingsMark.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */