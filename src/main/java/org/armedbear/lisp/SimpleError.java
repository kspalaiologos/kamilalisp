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
/*    */ public final class SimpleError
/*    */   extends LispError
/*    */ {
/*    */   public SimpleError(LispObject formatControl, LispObject formatArguments) {
/* 43 */     super(StandardClass.SIMPLE_ERROR);
/* 44 */     setFormatControl(formatControl);
/* 45 */     setFormatArguments(formatArguments);
/*    */   }
/*    */ 
/*    */   
/*    */   public SimpleError(LispObject initArgs) {
/* 50 */     super(StandardClass.SIMPLE_ERROR);
/* 51 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */   
/*    */   public SimpleError(String message) {
/* 56 */     super(StandardClass.SIMPLE_ERROR);
/* 57 */     setFormatControl(message.replaceAll("~", "~~"));
/* 58 */     setFormatArguments(Lisp.NIL);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 64 */     return Symbol.SIMPLE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 70 */     return StandardClass.SIMPLE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 76 */     if (type == Symbol.SIMPLE_ERROR)
/* 77 */       return Lisp.T; 
/* 78 */     if (type == StandardClass.SIMPLE_ERROR)
/* 79 */       return Lisp.T; 
/* 80 */     if (type == Symbol.SIMPLE_CONDITION)
/* 81 */       return Lisp.T; 
/* 82 */     if (type == StandardClass.SIMPLE_CONDITION)
/* 83 */       return Lisp.T; 
/* 84 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */