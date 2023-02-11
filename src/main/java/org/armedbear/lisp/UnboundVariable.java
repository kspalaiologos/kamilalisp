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
/*    */ public final class UnboundVariable
/*    */   extends CellError
/*    */ {
/*    */   public UnboundVariable(LispObject obj) {
/* 43 */     super(StandardClass.UNBOUND_VARIABLE);
/* 44 */     if (obj instanceof Cons) {
/* 45 */       initialize(obj);
/*    */     } else {
/* 47 */       setCellName(obj);
/*    */     } 
/*    */   }
/*    */ 
/*    */   
/*    */   public String getMessage() {
/* 53 */     LispThread thread = LispThread.currentThread();
/* 54 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 55 */     thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.T);
/* 56 */     StringBuffer sb = new StringBuffer("The variable ");
/*    */     try {
/* 58 */       sb.append(getCellName().princToString());
/*    */     } finally {
/*    */       
/* 61 */       thread.resetSpecialBindings(mark);
/*    */     } 
/* 63 */     sb.append(" is unbound.");
/* 64 */     return sb.toString();
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 70 */     return Symbol.UNBOUND_VARIABLE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 76 */     return StandardClass.UNBOUND_VARIABLE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 82 */     if (type == Symbol.UNBOUND_VARIABLE)
/* 83 */       return Lisp.T; 
/* 84 */     if (type == StandardClass.UNBOUND_VARIABLE)
/* 85 */       return Lisp.T; 
/* 86 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/UnboundVariable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */