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
/*    */ 
/*    */ 
/*    */ public final class logcount
/*    */   extends Primitive
/*    */ {
/*    */   private logcount() {
/* 45 */     super("logcount", "integer");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/*    */     int n;
/* 52 */     if (arg instanceof Fixnum) {
/* 53 */       int value = ((Fixnum)arg).value;
/* 54 */       n = Integer.bitCount((value < 0) ? (value ^ 0xFFFFFFFF) : value);
/* 55 */     } else if (arg instanceof Bignum) {
/* 56 */       n = ((Bignum)arg).value.bitCount();
/*    */     } else {
/* 58 */       return Lisp.type_error(arg, Symbol.INTEGER);
/* 59 */     }  return Fixnum.getInstance(n);
/*    */   }
/*    */   
/* 62 */   private static final Primitive LOGCOUNT = new logcount();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logcount.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */