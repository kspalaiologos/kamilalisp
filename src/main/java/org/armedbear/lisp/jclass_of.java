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
/*    */ public final class jclass_of
/*    */   extends Primitive
/*    */ {
/*    */   private jclass_of() {
/* 43 */     super(Symbol.JCLASS_OF, "object &optional name", "Returns the name of the Java class of OBJECT. If the NAME argument is\n  supplied, verifies that OBJECT is an instance of the named class. The name\n  of the class or nil is always returned as a second value.");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/*    */     String className;
/* 54 */     if (arg instanceof AbstractString) {
/* 55 */       className = "java.lang.String";
/* 56 */     } else if (arg instanceof JavaObject) {
/* 57 */       className = ((JavaObject)arg).getObject().getClass().getName();
/*    */     } else {
/* 59 */       className = null;
/* 60 */     }  LispObject value = (className != null) ? new SimpleString(className) : Lisp.NIL;
/*    */     
/* 62 */     return LispThread.currentThread().setValues(value, value);
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/*    */     String className;
/* 70 */     if (first instanceof AbstractString) {
/* 71 */       className = "java.lang.String";
/* 72 */     } else if (first instanceof JavaObject) {
/* 73 */       className = ((JavaObject)first).getObject().getClass().getName();
/*    */     } else {
/* 75 */       className = null;
/* 76 */     }  String name = Lisp.javaString(second);
/* 77 */     return LispThread.currentThread().setValues(name.equals(className) ? Lisp.T : Lisp.NIL, new SimpleString(className));
/*    */   }
/*    */ 
/*    */   
/* 81 */   private static final Primitive JCLASS_OF = new jclass_of();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/jclass_of.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */