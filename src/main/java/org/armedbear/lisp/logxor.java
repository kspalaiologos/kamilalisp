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
/*    */ public final class logxor
/*    */   extends Primitive
/*    */ {
/*    */   private logxor() {
/* 43 */     super("logxor", "&rest integers");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 49 */     return Fixnum.ZERO;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 55 */     return Lisp.checkInteger(arg);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 62 */     return first.LOGXOR(second);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject[] args) {
/* 68 */     LispObject result = Fixnum.ZERO;
/* 69 */     for (int i = 0; i < args.length; i++)
/* 70 */       result = result.LOGXOR(args[i]); 
/* 71 */     return result;
/*    */   }
/*    */   
/* 74 */   private static final Primitive LOGXOR = new logxor();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logxor.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */