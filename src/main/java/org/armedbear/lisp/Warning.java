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
/*    */ public class Warning
/*    */   extends Condition
/*    */ {
/*    */   protected Warning() {}
/*    */   
/*    */   public Warning(LispObject initArgs) {
/* 46 */     super(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 52 */     return Symbol.WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 58 */     return StandardClass.WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 64 */     if (type == Symbol.WARNING)
/* 65 */       return Lisp.T; 
/* 66 */     if (type == StandardClass.WARNING)
/* 67 */       return Lisp.T; 
/* 68 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Warning.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */