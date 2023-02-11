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
/*    */ public final class float_sign
/*    */   extends Primitive
/*    */ {
/*    */   private float_sign() {
/* 43 */     super("float-sign", "float-1 &optional float-2");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 49 */     if (arg instanceof SingleFloat) {
/* 50 */       float f = ((SingleFloat)arg).value;
/* 51 */       int bits = Float.floatToRawIntBits(f);
/* 52 */       return (bits < 0) ? SingleFloat.MINUS_ONE : SingleFloat.ONE;
/*    */     } 
/* 54 */     if (arg instanceof DoubleFloat) {
/* 55 */       double d = ((DoubleFloat)arg).value;
/* 56 */       long bits = Double.doubleToRawLongBits(d);
/* 57 */       return (bits < 0L) ? DoubleFloat.MINUS_ONE : DoubleFloat.ONE;
/*    */     } 
/* 59 */     return Lisp.type_error(arg, Symbol.FLOAT);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 66 */     if (!first.floatp())
/* 67 */       return Lisp.type_error(first, Symbol.FLOAT); 
/* 68 */     if (!second.floatp())
/* 69 */       return Lisp.type_error(second, Symbol.FLOAT); 
/* 70 */     if (first.minusp()) {
/* 71 */       if (second.minusp()) {
/* 72 */         return second;
/*    */       }
/* 74 */       return Fixnum.ZERO.subtract(second);
/*    */     } 
/* 76 */     return second.ABS();
/*    */   }
/*    */   
/* 79 */   private static final Primitive FLOAT_SIGN = new float_sign();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/float_sign.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */