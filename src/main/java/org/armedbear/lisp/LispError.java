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
/*    */ public class LispError
/*    */   extends SeriousCondition
/*    */ {
/*    */   public LispError() {}
/*    */   
/*    */   protected LispError(LispClass cls) {
/* 46 */     super(cls);
/*    */   }
/*    */ 
/*    */   
/*    */   public LispError(LispObject initArgs) {
/* 51 */     super(StandardClass.ERROR);
/* 52 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */   
/*    */   public LispError(String message) {
/* 57 */     super(StandardClass.ERROR);
/* 58 */     setFormatControl(message);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 64 */     return Symbol.ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 70 */     return StandardClass.ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 76 */     if (type == Symbol.ERROR)
/* 77 */       return Lisp.T; 
/* 78 */     if (type == StandardClass.ERROR)
/* 79 */       return Lisp.T; 
/* 80 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */