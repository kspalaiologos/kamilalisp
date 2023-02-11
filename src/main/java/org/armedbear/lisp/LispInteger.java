/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.Serializable;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public class LispInteger
/*    */   extends LispObject
/*    */   implements Serializable
/*    */ {
/*    */   public static LispInteger getInstance(long l) {
/* 43 */     if (-2147483648L <= l && l <= 2147483647L) {
/* 44 */       return Fixnum.getInstance((int)l);
/*    */     }
/* 46 */     return Bignum.getInstance(l);
/*    */   }
/*    */   
/*    */   public static LispInteger getInstance(int i) {
/* 50 */     return Fixnum.getInstance(i);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispInteger.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */