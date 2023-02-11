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
/*    */ public final class assql
/*    */   extends Primitive
/*    */ {
/*    */   private assql() {
/* 43 */     super("assql", Lisp.PACKAGE_EXT);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject item, LispObject alist) {
/* 50 */     while (alist != Lisp.NIL) {
/* 51 */       LispObject cons = alist.car();
/* 52 */       if (cons instanceof Cons) {
/* 53 */         if (cons.car().eql(item))
/* 54 */           return cons; 
/* 55 */       } else if (cons != Lisp.NIL) {
/* 56 */         return Lisp.type_error(cons, Symbol.LIST);
/* 57 */       }  alist = alist.cdr();
/*    */     } 
/* 59 */     return Lisp.NIL;
/*    */   }
/*    */   
/* 62 */   private static final Primitive ASSQL = new assql();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/assql.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */