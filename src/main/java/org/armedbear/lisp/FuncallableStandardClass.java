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
/*    */ public class FuncallableStandardClass
/*    */   extends StandardClass
/*    */ {
/*    */   public FuncallableStandardClass() {
/* 42 */     super(StandardClass.layoutFuncallableStandardClass);
/*    */   }
/*    */ 
/*    */   
/*    */   public FuncallableStandardClass(Symbol symbol, LispObject directSuperclasses) {
/* 47 */     super(StandardClass.layoutFuncallableStandardClass, symbol, directSuperclasses);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 54 */     return Symbol.FUNCALLABLE_STANDARD_CLASS;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 60 */     return StandardClass.FUNCALLABLE_STANDARD_CLASS;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 66 */     if (type == Symbol.FUNCALLABLE_STANDARD_CLASS)
/* 67 */       return Lisp.T; 
/* 68 */     if (type == StandardClass.FUNCALLABLE_STANDARD_CLASS)
/* 69 */       return Lisp.T; 
/* 70 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public String printObject() {
/* 77 */     StringBuilder sb = new StringBuilder(Symbol.FUNCALLABLE_STANDARD_CLASS.printObject());
/* 78 */     if (getName() != null) {
/*    */       
/* 80 */       sb.append(' ');
/* 81 */       sb.append(getName().printObject());
/*    */     } 
/* 83 */     return unreadableString(sb.toString());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FuncallableStandardClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */