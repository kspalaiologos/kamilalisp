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
/*    */ public final class SimpleTypeError
/*    */   extends TypeError
/*    */ {
/*    */   public SimpleTypeError(LispObject initArgs) {
/* 42 */     super(StandardClass.SIMPLE_TYPE_ERROR);
/* 43 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 49 */     return Symbol.SIMPLE_TYPE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 55 */     return StandardClass.SIMPLE_TYPE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 61 */     if (type == Symbol.SIMPLE_TYPE_ERROR)
/* 62 */       return Lisp.T; 
/* 63 */     if (type == StandardClass.SIMPLE_TYPE_ERROR)
/* 64 */       return Lisp.T; 
/* 65 */     if (type == Symbol.SIMPLE_CONDITION)
/* 66 */       return Lisp.T; 
/* 67 */     if (type == StandardClass.SIMPLE_CONDITION)
/* 68 */       return Lisp.T; 
/* 69 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public String getMessage() {
/* 75 */     LispObject formatControl = getFormatControl();
/* 76 */     if (formatControl != Lisp.NIL) {
/* 77 */       LispObject formatArguments = getFormatArguments();
/*    */ 
/*    */       
/* 80 */       LispObject result = Primitives.APPLY.execute(Symbol.FORMAT, Primitives.APPEND
/* 81 */           .execute(Lisp.list(Lisp.NIL, new LispObject[] { formatControl }), formatArguments));
/*    */ 
/*    */       
/* 84 */       return result.getStringValue();
/*    */     } 
/* 86 */     return super.getMessage();
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleTypeError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */