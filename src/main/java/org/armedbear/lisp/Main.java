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
/*    */ public final class Main
/*    */ {
/* 37 */   public static final long startTimeMillis = System.currentTimeMillis();
/*    */ 
/*    */ 
/*    */   
/*    */   public static void main(final String[] args) {
/* 42 */     Runnable r = new Runnable()
/*    */       {
/*    */         public void run() {
/*    */           try {
/* 46 */             Interpreter interpreter = Interpreter.createDefaultInstance(args);
/* 47 */             if (interpreter != null)
/* 48 */               interpreter.run(); 
/* 49 */           } catch (ProcessingTerminated e) {
/* 50 */             System.exit(e.getStatus());
/*    */           } 
/*    */         }
/*    */       };
/* 54 */     (new Thread(null, r, "interpreter", 4194304L)).start();
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Main.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */