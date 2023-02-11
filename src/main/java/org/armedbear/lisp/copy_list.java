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
/*    */ public final class copy_list
/*    */   extends Primitive
/*    */ {
/*    */   private copy_list() {
/* 43 */     super(Symbol.COPY_LIST, "list");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     if (arg == Lisp.NIL)
/* 50 */       return Lisp.NIL; 
/* 51 */     Cons result = new Cons(arg.car());
/* 52 */     Cons splice = result;
/* 53 */     arg = arg.cdr();
/* 54 */     while (arg instanceof Cons) {
/*    */       
/* 56 */       Cons cons = (Cons)arg;
/* 57 */       Cons temp = new Cons(cons.car);
/* 58 */       splice.cdr = temp;
/* 59 */       splice = temp;
/* 60 */       arg = cons.cdr;
/*    */     } 
/* 62 */     splice.cdr = arg;
/* 63 */     return result;
/*    */   }
/*    */   
/* 66 */   private static final Primitive COPY_LIST = new copy_list();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/copy_list.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */