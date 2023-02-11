/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.lang.reflect.Method;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class jmethod_return_type
/*    */   extends Primitive
/*    */ {
/*    */   private jmethod_return_type() {
/* 45 */     super(Symbol.JMETHOD_RETURN_TYPE, "method", "Returns a reference to the Class object that represents the formal return type of METHOD.");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 53 */     if (arg instanceof JavaObject) {
/* 54 */       Object method = ((JavaObject)arg).getObject();
/* 55 */       if (method instanceof Method)
/* 56 */         return new JavaObject(((Method)method).getReturnType()); 
/*    */     } 
/* 58 */     return Lisp.error(new LispError(arg.princToString() + " does not designate a Java method."));
/*    */   }
/*    */   
/* 61 */   private static final Primitive JMETHOD_RETURN_TYPE = new jmethod_return_type();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/jmethod_return_type.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */