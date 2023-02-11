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
/*    */ public final class logand
/*    */   extends Primitive
/*    */ {
/*    */   private logand() {
/* 45 */     super("logand", "&rest integers");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 51 */     return Fixnum.MINUS_ONE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 57 */     return Lisp.checkInteger(arg);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 64 */     return first.LOGAND(second);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject[] args) {
/* 70 */     LispObject result = Fixnum.MINUS_ONE;
/* 71 */     for (int i = 0; i < args.length; i++)
/* 72 */       result = result.LOGAND(args[i]); 
/* 73 */     return result;
/*    */   }
/*    */   
/* 76 */   private static final Primitive LOGAND = new logand();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/logand.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */