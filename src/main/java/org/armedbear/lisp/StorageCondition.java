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
/*    */ public class StorageCondition
/*    */   extends SeriousCondition
/*    */ {
/*    */   public StorageCondition() {}
/*    */   
/*    */   public StorageCondition(LispObject initArgs) {
/* 46 */     super(initArgs);
/*    */   }
/*    */ 
/*    */   
/*    */   public StorageCondition(String message) {
/* 51 */     super(message);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 57 */     return Symbol.STORAGE_CONDITION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 63 */     return StandardClass.STORAGE_CONDITION;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 69 */     if (type == Symbol.STORAGE_CONDITION)
/* 70 */       return Lisp.T; 
/* 71 */     if (type == StandardClass.STORAGE_CONDITION)
/* 72 */       return Lisp.T; 
/* 73 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StorageCondition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */