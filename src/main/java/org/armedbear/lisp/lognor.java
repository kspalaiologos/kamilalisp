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
/*    */ public final class lognor
/*    */   extends Primitive
/*    */ {
/*    */   private lognor() {
/* 44 */     super("lognor", "integer-1 integer-2");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 51 */     if (first instanceof Fixnum) {
/* 52 */       if (second instanceof Fixnum) {
/* 53 */         return Fixnum.getInstance((((Fixnum)first).value | ((Fixnum)second).value) ^ 0xFFFFFFFF);
/*    */       }
/* 55 */       if (second instanceof Bignum) {
/* 56 */         BigInteger n1 = ((Fixnum)first).getBigInteger();
/* 57 */         BigInteger n2 = ((Bignum)second).value;
/* 58 */         return Lisp.number(n1.or(n2).not());
/*    */       } 
/* 60 */       return Lisp.type_error(second, Symbol.INTEGER);
/*    */     } 
/* 62 */     if (first instanceof Bignum) {
/* 63 */       BigInteger n1 = ((Bignum)first).value;
/* 64 */       if (second instanceof Fixnum) {
/* 65 */         BigInteger n2 = ((Fixnum)second).getBigInteger();
/* 66 */         return Lisp.number(n1.or(n2).not());
/*    */       } 
/* 68 */       if (second instanceof Bignum) {
/* 69 */         BigInteger n2 = ((Bignum)second).value;
/* 70 */         return Lisp.number(n1.or(n2).not());
/*    */       } 
/* 72 */       return Lisp.type_error(second, Symbol.INTEGER);
/*    */     } 
/* 74 */     return Lisp.type_error(first, Symbol.INTEGER);
/*    */   }
/*    */   
/* 77 */   private static final Primitive LOGNOR = new lognor();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/lognor.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */