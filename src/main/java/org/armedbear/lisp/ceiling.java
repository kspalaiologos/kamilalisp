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
/*    */ public final class ceiling
/*    */   extends Primitive
/*    */ {
/*    */   private ceiling() {
/* 41 */     super("ceiling", "number &optional divisor");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 47 */     return execute(arg, Fixnum.ONE);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 54 */     LispObject quotient = first.truncate(second);
/* 55 */     LispThread thread = LispThread.currentThread();
/* 56 */     LispObject remainder = thread._values[1];
/* 57 */     if (remainder.zerop())
/* 58 */       return quotient; 
/* 59 */     if (second.minusp()) {
/* 60 */       if (first.plusp()) {
/* 61 */         return quotient;
/*    */       }
/* 63 */     } else if (first.minusp()) {
/* 64 */       return quotient;
/*    */     } 
/* 66 */     quotient = quotient.incr();
/* 67 */     thread._values[0] = quotient;
/* 68 */     thread._values[1] = remainder.subtract(second);
/* 69 */     return quotient;
/*    */   }
/*    */   
/* 72 */   private static final Primitive CEILING = new ceiling();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ceiling.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */