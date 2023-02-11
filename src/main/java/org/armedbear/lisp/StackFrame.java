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
/*    */ public abstract class StackFrame
/*    */   extends LispObject
/*    */ {
/*    */   StackFrame next;
/*    */   
/*    */   public LispObject typep(LispObject typeSpecifier) {
/* 45 */     if (typeSpecifier == Symbol.STACK_FRAME)
/* 46 */       return Lisp.T; 
/* 47 */     if (typeSpecifier == BuiltInClass.STACK_FRAME)
/* 48 */       return Lisp.T; 
/* 49 */     return super.typep(typeSpecifier);
/*    */   }
/*    */ 
/*    */   
/* 53 */   Environment env = null;
/*    */   
/*    */   void setNext(StackFrame nextFrame) {
/* 56 */     this.next = nextFrame;
/*    */   }
/*    */   StackFrame getNext() {
/* 59 */     return this.next;
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public Environment setEnv(Environment env) {
/* 66 */     Environment e = this.env;
/* 67 */     this.env = env;
/* 68 */     return e;
/*    */   }
/*    */   
/*    */   public Environment getEnv() {
/* 72 */     return this.env;
/*    */   }
/*    */   
/*    */   public abstract LispObject toLispList();
/*    */   
/*    */   public abstract SimpleString toLispString();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StackFrame.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */