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
/*    */ public final class UndefinedFunction
/*    */   extends CellError
/*    */ {
/*    */   public UndefinedFunction(LispObject obj) {
/* 43 */     super(StandardClass.UNDEFINED_FUNCTION);
/* 44 */     if (obj instanceof Cons) {
/* 45 */       initialize(obj);
/*    */     } else {
/* 47 */       setCellName(obj);
/*    */     } 
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 53 */     return Symbol.UNDEFINED_FUNCTION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 59 */     return StandardClass.UNDEFINED_FUNCTION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 65 */     if (type == Symbol.UNDEFINED_FUNCTION)
/* 66 */       return Lisp.T; 
/* 67 */     if (type == StandardClass.UNDEFINED_FUNCTION)
/* 68 */       return Lisp.T; 
/* 69 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public String getMessage() {
/* 75 */     StringBuilder sb = new StringBuilder("The function ");
/* 76 */     sb.append(getCellName().princToString());
/* 77 */     sb.append(" is undefined.");
/* 78 */     return sb.toString();
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/UndefinedFunction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */