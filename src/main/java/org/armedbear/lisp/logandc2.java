/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.math.BigInteger;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class logandc2
/*    */   extends Primitive
/*    */ {
/*    */   private logandc2() {
/* 47 */     super("logandc2", "integer-1 integer-2");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 54 */     if (first instanceof Fixnum) {
/* 55 */       if (second instanceof Fixnum) {
/* 56 */         return Fixnum.getInstance(((Fixnum)first).value & (((Fixnum)second).value ^ 0xFFFFFFFF));
/*    */       }
/* 58 */       if (second instanceof Bignum) {
/* 59 */         BigInteger n1 = ((Fixnum)first).getBigInteger();
/* 60 */         BigInteger n2 = ((Bignum)second).value;
/* 61 */         return Lisp.number(n1.and(n2.not()));
/*    */       } 
/* 63 */       return Lisp.type_error(second, Symbol.INTEGER);
/*    */     } 
/* 65 */     if (first instanceof Bignum) {
/* 66 */       BigInteger n1 = ((Bignum)first).value;
/* 67 */       if (second instanceof Fixnum) {
/* 68 */         BigInteger n2 = ((Fixnum)second).getBigInteger();
/* 69 */         return Lisp.number(n1.and(n2.not()));
/*    */       } 
/* 71 */       if (second instanceof Bignum) {
/* 72 */         BigInteger n2 = ((Bignum)second).value;
/* 73 */         return Lisp.number(n1.and(n2.not()));
/*    */       } 
/* 75 */       return Lisp.type_error(second, Symbol.INTEGER);
/*    */     } 
/* 77 */     return Lisp.type_error(first, Symbol.INTEGER);
/*    */   }
/*    */   
/* 80 */   private static final Primitive LOGANDC2 = new logandc2();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logandc2.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */