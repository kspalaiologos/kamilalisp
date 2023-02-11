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
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class Debug
/*    */ {
/*    */   public static final void assertTrue(boolean b) {
/* 45 */     if (!b) {
/* 46 */       String msg = "ABCL Debug.assertTrue() assertion failed!";
/* 47 */       System.err.println(msg);
/* 48 */       Error e = new Error(msg);
/* 49 */       e.printStackTrace(System.err);
/*    */       
/* 51 */       StringBuffer buffer = new StringBuffer();
/* 52 */       String CR = "\n";
/* 53 */       buffer.append(msg).append("\n");
/* 54 */       StackTraceElement[] stack = e.getStackTrace();
/* 55 */       for (int i = 0; i < stack.length; i++) {
/* 56 */         buffer.append(stack[i].toString()).append("\n");
/*    */       }
/* 58 */       throw new Error(buffer.toString());
/*    */     } 
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public static void bug() {
/* 65 */     trace(new Exception("BUG!"));
/*    */   }
/*    */ 
/*    */   
/*    */   public static final void trace(String s) {
/* 70 */     System.err.println(s);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public static final void trace(Throwable t) {
/* 76 */     t.printStackTrace();
/*    */   }
/*    */ 
/*    */   
/*    */   public static final void trace(String message, Throwable t) {
/* 81 */     trace(message);
/* 82 */     trace(t);
/*    */   }
/*    */   
/* 85 */   public static final Symbol _DEBUG_WARN_ = Lisp.exportSpecial("*DEBUG-WARN*", Lisp.PACKAGE_SYS, Lisp.NIL);
/*    */   
/*    */   public static void setDebugWarnings(boolean flag) {
/* 88 */     if (flag) {
/* 89 */       _DEBUG_WARN_.setSymbolValue(Lisp.T);
/*    */     } else {
/* 91 */       _DEBUG_WARN_.setSymbolValue(Lisp.NIL);
/*    */     } 
/*    */   }
/*    */   
/*    */   public static final void warn(String s) {
/* 96 */     if (_DEBUG_WARN_.getSymbolValue() != null)
/* 97 */       trace(s); 
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Debug.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */