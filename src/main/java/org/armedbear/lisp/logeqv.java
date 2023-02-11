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
/*    */ public final class logeqv
/*    */   extends Primitive
/*    */ {
/*    */   private logeqv() {
/* 47 */     super("logeqv", "&rest integers");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 53 */     return Fixnum.MINUS_ONE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 59 */     return Lisp.checkInteger(arg);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject[] args) {
/* 65 */     BigInteger result = null;
/* 66 */     for (int i = 0; i < args.length; i++) {
/* 67 */       BigInteger n; LispObject arg = args[i];
/*    */       
/* 69 */       if (arg instanceof Fixnum) {
/* 70 */         n = ((Fixnum)arg).getBigInteger();
/* 71 */       } else if (arg instanceof Bignum) {
/* 72 */         n = ((Bignum)arg).value;
/*    */       } else {
/* 74 */         return Lisp.type_error(arg, Symbol.INTEGER);
/* 75 */       }  if (result == null) {
/* 76 */         result = n;
/*    */       } else {
/* 78 */         result = result.xor(n).not();
/*    */       } 
/* 80 */     }  return Lisp.number(result);
/*    */   }
/*    */   
/* 83 */   private static final Primitive LOGEQV = new logeqv();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logeqv.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */