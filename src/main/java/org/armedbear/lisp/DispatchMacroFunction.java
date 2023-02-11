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
/*    */ public abstract class DispatchMacroFunction
/*    */   extends Function
/*    */ {
/*    */   public DispatchMacroFunction(String name) {
/* 42 */     super(name);
/*    */   }
/*    */ 
/*    */   
/*    */   public DispatchMacroFunction(String name, String arglist) {
/* 47 */     super(name, arglist);
/*    */   }
/*    */ 
/*    */   
/*    */   public DispatchMacroFunction(String name, Package pkg) {
/* 52 */     super(name, pkg);
/*    */   }
/*    */ 
/*    */   
/*    */   public DispatchMacroFunction(String name, Package pkg, boolean exported) {
/* 57 */     super(name, pkg, exported);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public DispatchMacroFunction(String name, Package pkg, boolean exported, String arglist) {
/* 63 */     super(name, pkg, exported, arglist);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*    */     int n;
/* 71 */     Stream stream = Lisp.inSynonymOf(first);
/* 72 */     char c = LispCharacter.getValue(second);
/*    */     
/* 74 */     if (third == Lisp.NIL) {
/* 75 */       n = -1;
/*    */     } else {
/* 77 */       n = Fixnum.getValue(third);
/* 78 */     }  return execute(stream, c, n);
/*    */   }
/*    */   
/*    */   public abstract LispObject execute(Stream paramStream, char paramChar, int paramInt);
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/DispatchMacroFunction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */