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
/*    */ public final class simple_list_remove_duplicates
/*    */   extends Primitive
/*    */ {
/*    */   private simple_list_remove_duplicates() {
/* 43 */     super("simple-list-remove-duplicates", Lisp.PACKAGE_SYS, false, "list");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject list) {
/* 49 */     LispObject result = Lisp.NIL;
/* 50 */     while (list != Lisp.NIL) {
/* 51 */       LispObject item = list.car();
/* 52 */       boolean duplicate = false;
/* 53 */       LispObject tail = list.cdr();
/* 54 */       while (tail != Lisp.NIL) {
/* 55 */         if (item.eql(tail.car())) {
/* 56 */           duplicate = true;
/*    */           break;
/*    */         } 
/* 59 */         tail = tail.cdr();
/*    */       } 
/* 61 */       if (!duplicate)
/* 62 */         result = new Cons(item, result); 
/* 63 */       list = list.cdr();
/*    */     } 
/* 65 */     return result.nreverse();
/*    */   }
/*    */   
/* 68 */   private static final Primitive SIMPLE_LIST_REMOVE_DUPLICATES = new simple_list_remove_duplicates();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/simple_list_remove_duplicates.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */