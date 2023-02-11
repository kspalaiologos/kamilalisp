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
/*    */ public final class floor
/*    */   extends Primitive
/*    */ {
/*    */   private floor() {
/* 41 */     super("floor", "number &optional divisor");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject number) {
/* 48 */     LispObject quotient = number.truncate(Fixnum.ONE);
/* 49 */     LispThread thread = LispThread.currentThread();
/* 50 */     LispObject remainder = thread._values[1];
/* 51 */     if (!remainder.zerop() && 
/* 52 */       number.minusp()) {
/* 53 */       quotient = quotient.decr();
/* 54 */       remainder = remainder.incr();
/* 55 */       thread._values[0] = quotient;
/* 56 */       thread._values[1] = remainder;
/*    */     } 
/*    */     
/* 59 */     return quotient;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject number, LispObject divisor) {
/* 66 */     LispObject quotient = number.truncate(divisor);
/* 67 */     LispThread thread = LispThread.currentThread();
/* 68 */     LispObject remainder = thread._values[1];
/* 69 */     boolean adjust = false;
/* 70 */     if (!remainder.zerop()) {
/* 71 */       if (divisor.minusp()) {
/* 72 */         if (number.plusp()) {
/* 73 */           adjust = true;
/*    */         }
/* 75 */       } else if (number.minusp()) {
/* 76 */         adjust = true;
/*    */       } 
/*    */     }
/* 79 */     if (adjust) {
/* 80 */       quotient = quotient.decr();
/* 81 */       remainder = remainder.add(divisor);
/* 82 */       thread._values[0] = quotient;
/* 83 */       thread._values[1] = remainder;
/*    */     } 
/* 85 */     return quotient;
/*    */   }
/*    */   
/* 88 */   private static final Primitive FLOOR = new floor();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/floor.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */