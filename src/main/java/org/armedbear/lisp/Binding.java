/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.Serializable;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ final class Binding
/*    */   implements Serializable
/*    */ {
/*    */   final LispObject symbol;
/* 56 */   Environment env = null;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   LispObject value;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   boolean specialp;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   final Binding next;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   Binding(LispObject symbol, LispObject value, Binding next) {
/* 84 */     this.symbol = symbol;
/* 85 */     this.value = value;
/* 86 */     this.next = next;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   Binding(LispObject symbol, Environment env, LispObject value, Binding next) {
/* 92 */     this(symbol, value, next);
/* 93 */     this.env = env;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Binding.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */