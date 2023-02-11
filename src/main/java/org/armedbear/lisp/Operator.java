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
/*    */ public abstract class Operator
/*    */   extends LispObject
/*    */ {
/*    */   protected LispObject lambdaName;
/*    */   private LispObject lambdaList;
/*    */   
/*    */   public final LispObject getLambdaName() {
/* 46 */     return this.lambdaName;
/*    */   }
/*    */ 
/*    */   
/*    */   public final void setLambdaName(LispObject obj) {
/* 51 */     this.lambdaName = obj;
/*    */   }
/*    */ 
/*    */   
/*    */   public final LispObject getLambdaList() {
/* 56 */     if (this.lambdaList == null) {
/* 57 */       DocString ds = getClass().<DocString>getAnnotation(DocString.class);
/* 58 */       if (ds != null)
/* 59 */         this.lambdaList = new SimpleString(ds.args()); 
/*    */     } 
/* 61 */     return this.lambdaList;
/*    */   }
/*    */ 
/*    */   
/*    */   public final void setLambdaList(LispObject obj) {
/* 66 */     this.lambdaList = obj;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject getParts() {
/* 72 */     LispObject result = Lisp.NIL;
/* 73 */     result = result.push(new Cons("lambda-name", this.lambdaName));
/* 74 */     result = result.push(new Cons("lambda-list", this.lambdaList));
/* 75 */     return result.nreverse();
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Operator.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */