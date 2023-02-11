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
/*    */ public final class ControlError
/*    */   extends LispError
/*    */ {
/*    */   public ControlError(LispObject initArgs) {
/* 42 */     super(StandardClass.CONTROL_ERROR);
/* 43 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */   
/*    */   public ControlError(String message) {
/* 48 */     super(StandardClass.CONTROL_ERROR);
/* 49 */     setFormatControl(message.replaceAll("~", "~~"));
/* 50 */     setFormatArguments(Lisp.NIL);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 56 */     return Symbol.CONTROL_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 62 */     return StandardClass.CONTROL_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 68 */     if (type == Symbol.CONTROL_ERROR)
/* 69 */       return Lisp.T; 
/* 70 */     if (type == StandardClass.CONTROL_ERROR)
/* 71 */       return Lisp.T; 
/* 72 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ControlError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */