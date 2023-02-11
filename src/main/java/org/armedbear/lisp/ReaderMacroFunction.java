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
/*    */ public abstract class ReaderMacroFunction
/*    */   extends Function
/*    */ {
/*    */   public ReaderMacroFunction(String name) {
/* 42 */     super(name);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderMacroFunction(String name, String arglist) {
/* 47 */     super(name, arglist);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderMacroFunction(String name, Package pkg) {
/* 52 */     super(name, pkg);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderMacroFunction(String name, Package pkg, boolean exported) {
/* 57 */     super(name, pkg, exported);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public ReaderMacroFunction(String name, Package pkg, boolean exported, String arglist) {
/* 63 */     super(name, pkg, exported, arglist);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 70 */     Stream stream = Lisp.inSynonymOf(first);
/* 71 */     char c = LispCharacter.getValue(second);
/* 72 */     return execute(stream, c);
/*    */   }
/*    */   
/*    */   public abstract LispObject execute(Stream paramStream, char paramChar);
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ReaderMacroFunction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */