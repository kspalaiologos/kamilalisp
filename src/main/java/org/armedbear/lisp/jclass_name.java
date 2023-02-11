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
/*    */ public final class jclass_name
/*    */   extends Primitive
/*    */ {
/*    */   private jclass_name() {
/* 43 */     super(Symbol.JCLASS_NAME, "class-ref &optional name", "When called with one argument, returns the name of the Java class\n  designated by CLASS-REF. When called with two arguments, tests\n  whether CLASS-REF matches NAME.");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 55 */     if (arg instanceof AbstractString) {
/* 56 */       String s = arg.getStringValue();
/*    */       try {
/* 58 */         return new SimpleString(Class.forName(s).getName());
/*    */       }
/* 60 */       catch (ClassNotFoundException classNotFoundException) {}
/*    */     
/*    */     }
/* 63 */     else if (arg instanceof JavaObject) {
/* 64 */       Object obj = ((JavaObject)arg).getObject();
/* 65 */       if (obj instanceof Class) {
/* 66 */         return new SimpleString(((Class)obj).getName());
/*    */       }
/*    */     } 
/* 69 */     return Lisp.error(new LispError(arg.princToString() + " does not designate a Java class."));
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject first, LispObject second) {
/* 78 */     String className = null;
/* 79 */     if (first instanceof AbstractString) {
/* 80 */       String s = first.getStringValue();
/*    */       try {
/* 82 */         className = Class.forName(s).getName();
/*    */       }
/* 84 */       catch (ClassNotFoundException classNotFoundException) {}
/* 85 */     } else if (first instanceof JavaObject) {
/* 86 */       Object obj = ((JavaObject)first).getObject();
/* 87 */       if (obj instanceof Class)
/* 88 */         className = ((Class)obj).getName(); 
/*    */     } 
/* 90 */     if (className == null)
/* 91 */       return Lisp.error(new LispError(first.princToString() + " does not designate a Java class.")); 
/* 92 */     AbstractString name = Lisp.checkString(second);
/* 93 */     return LispThread.currentThread().setValues(name.getStringValue().equals(className) ? Lisp.T : Lisp.NIL, new SimpleString(className));
/*    */   }
/*    */ 
/*    */   
/* 97 */   private static final Primitive JCLASS_NAME = new jclass_name();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/jclass_name.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */