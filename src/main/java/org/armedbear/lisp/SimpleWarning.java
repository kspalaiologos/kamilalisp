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
/*    */ public final class SimpleWarning
/*    */   extends Warning
/*    */ {
/*    */   public SimpleWarning(LispObject initArgs) {
/* 42 */     super(StandardClass.SIMPLE_WARNING);
/* 43 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public SimpleWarning(LispObject formatControl, LispObject formatArguments) {
/* 49 */     super(StandardClass.SIMPLE_WARNING);
/* 50 */     setFormatControl(formatControl);
/* 51 */     setFormatArguments(formatArguments);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 57 */     return Symbol.SIMPLE_WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 63 */     return StandardClass.SIMPLE_WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 69 */     if (type == Symbol.SIMPLE_WARNING)
/* 70 */       return Lisp.T; 
/* 71 */     if (type == StandardClass.SIMPLE_WARNING)
/* 72 */       return Lisp.T; 
/* 73 */     if (type == Symbol.SIMPLE_CONDITION)
/* 74 */       return Lisp.T; 
/* 75 */     if (type == StandardClass.SIMPLE_CONDITION)
/* 76 */       return Lisp.T; 
/* 77 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleWarning.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */