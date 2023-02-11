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
/*    */ public final class StyleWarning
/*    */   extends Warning
/*    */ {
/*    */   public StyleWarning(LispObject initArgs) {
/* 42 */     super(StandardClass.STYLE_WARNING);
/* 43 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 49 */     return Symbol.STYLE_WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 55 */     return StandardClass.STYLE_WARNING;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 61 */     if (type == Symbol.STYLE_WARNING)
/* 62 */       return Lisp.T; 
/* 63 */     if (type == StandardClass.STYLE_WARNING)
/* 64 */       return Lisp.T; 
/* 65 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StyleWarning.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */