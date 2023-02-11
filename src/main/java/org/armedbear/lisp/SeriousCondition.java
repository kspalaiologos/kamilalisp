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
/*    */ public class SeriousCondition
/*    */   extends Condition
/*    */ {
/*    */   public SeriousCondition() {}
/*    */   
/*    */   protected SeriousCondition(LispClass cls) {
/* 46 */     super(cls);
/*    */   }
/*    */ 
/*    */   
/*    */   public SeriousCondition(LispObject initArgs) {
/* 51 */     super(initArgs);
/*    */   }
/*    */ 
/*    */   
/*    */   public SeriousCondition(String message) {
/* 56 */     super(message);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 62 */     return Symbol.SERIOUS_CONDITION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 68 */     return StandardClass.SERIOUS_CONDITION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 74 */     if (type == Symbol.SERIOUS_CONDITION)
/* 75 */       return Lisp.T; 
/* 76 */     if (type == StandardClass.SERIOUS_CONDITION)
/* 77 */       return Lisp.T; 
/* 78 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SeriousCondition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */