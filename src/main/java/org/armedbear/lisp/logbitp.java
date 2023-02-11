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
/*    */ public final class logbitp
/*    */   extends Primitive
/*    */ {
/*    */   private logbitp() {
/* 45 */     super("logbitp", "index integer");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/*    */     BigInteger n;
/* 52 */     int index = -1;
/* 53 */     if (first instanceof Fixnum) {
/* 54 */       index = ((Fixnum)first).value;
/* 55 */     } else if (first instanceof Bignum) {
/*    */ 
/*    */       
/* 58 */       if (((Bignum)first).value.signum() > 0)
/* 59 */         index = Integer.MAX_VALUE; 
/*    */     } 
/* 61 */     if (index < 0) {
/* 62 */       return Lisp.type_error(first, Symbol.UNSIGNED_BYTE);
/*    */     }
/* 64 */     if (second instanceof Fixnum) {
/* 65 */       n = ((Fixnum)second).getBigInteger();
/* 66 */     } else if (second instanceof Bignum) {
/* 67 */       n = ((Bignum)second).value;
/*    */     } else {
/* 69 */       return Lisp.type_error(second, Symbol.INTEGER);
/*    */     } 
/* 71 */     if (index == Integer.MAX_VALUE)
/* 72 */       return (n.signum() < 0) ? Lisp.T : Lisp.NIL; 
/* 73 */     return n.testBit(index) ? Lisp.T : Lisp.NIL;
/*    */   }
/*    */   
/* 76 */   private static final Primitive LOGBITP = new logbitp();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logbitp.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */