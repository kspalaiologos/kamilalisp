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
/*    */ public final class logtest
/*    */   extends Primitive
/*    */ {
/*    */   private logtest() {
/* 46 */     super("logtest", "integer-1 integer-2");
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/*    */     BigInteger n1;
/*    */     BigInteger n2;
/* 53 */     if (first instanceof Fixnum && second instanceof Fixnum) {
/* 54 */       return ((((Fixnum)first).value & ((Fixnum)second).value) == 0) ? Lisp.NIL : Lisp.T;
/*    */     }
/*    */     
/* 57 */     if (first instanceof Fixnum) {
/* 58 */       n1 = ((Fixnum)first).getBigInteger();
/* 59 */     } else if (first instanceof Bignum) {
/* 60 */       n1 = ((Bignum)first).value;
/*    */     } else {
/* 62 */       return Lisp.type_error(first, Symbol.INTEGER);
/* 63 */     }  if (second instanceof Fixnum) {
/* 64 */       n2 = ((Fixnum)second).getBigInteger();
/* 65 */     } else if (second instanceof Bignum) {
/* 66 */       n2 = ((Bignum)second).value;
/*    */     } else {
/* 68 */       return Lisp.type_error(second, Symbol.INTEGER);
/* 69 */     }  return (n1.and(n2).signum() == 0) ? Lisp.NIL : Lisp.T;
/*    */   }
/*    */ 
/*    */   
/* 73 */   private static final Primitive LOGTEST = new logtest();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logtest.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */