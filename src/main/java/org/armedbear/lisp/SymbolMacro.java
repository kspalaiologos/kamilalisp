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
/*    */ public final class SymbolMacro
/*    */   extends LispObject
/*    */ {
/*    */   private LispObject expansion;
/*    */   
/*    */   public SymbolMacro(LispObject expansion) {
/* 42 */     this.expansion = expansion;
/*    */   }
/*    */ 
/*    */   
/*    */   public LispObject getExpansion() {
/* 47 */     return this.expansion;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SymbolMacro.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */