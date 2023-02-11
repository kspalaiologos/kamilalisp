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
/*    */ public class CompiledPrimitive
/*    */   extends Primitive
/*    */ {
/*    */   public CompiledPrimitive(LispObject name) {
/* 40 */     super(name);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name) {
/* 45 */     super(name);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(Symbol symbol) {
/* 50 */     super(symbol);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(Symbol symbol, String arglist) {
/* 55 */     super(symbol, arglist);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(Symbol symbol, String arglist, String docstring) {
/* 60 */     super(symbol, arglist, docstring);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name, String arglist) {
/* 65 */     super(name, arglist);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(LispObject name, LispObject lambdaList) {
/* 70 */     super(name, lambdaList);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name, Package pkg) {
/* 75 */     super(name, pkg);
/*    */   }
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name, Package pkg, boolean exported) {
/* 80 */     super(name, pkg, exported);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name, Package pkg, boolean exported, String arglist) {
/* 86 */     super(name, pkg, exported, arglist);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public CompiledPrimitive(String name, Package pkg, boolean exported, String arglist, String docstring) {
/* 92 */     super(name, pkg, exported, arglist, docstring);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CompiledPrimitive.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */