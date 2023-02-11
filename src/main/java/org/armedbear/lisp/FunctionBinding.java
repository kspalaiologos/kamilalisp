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
/*    */ final class FunctionBinding
/*    */   implements Serializable
/*    */ {
/*    */   LispObject name;
/*    */   LispObject value;
/*    */   final FunctionBinding next;
/*    */   
/*    */   FunctionBinding() {
/* 47 */     this.next = null;
/*    */   }
/*    */ 
/*    */   
/*    */   FunctionBinding(LispObject name, LispObject value, FunctionBinding next) {
/* 52 */     this.name = name;
/* 53 */     this.value = value;
/* 54 */     this.next = next;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FunctionBinding.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */