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
/*    */ public final class gc
/*    */   extends Primitive
/*    */ {
/*    */   private gc() {
/* 43 */     super("gc", Lisp.PACKAGE_EXT);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 49 */     Runtime runtime = Runtime.getRuntime();
/* 50 */     long free = 0L;
/* 51 */     long maxFree = 0L;
/*    */     while (true) {
/*    */       try {
/* 54 */         runtime.gc();
/* 55 */         Thread.sleep(100L);
/* 56 */         runtime.runFinalization();
/* 57 */         Thread.sleep(100L);
/* 58 */         runtime.gc();
/* 59 */         Thread.sleep(100L);
/*    */       }
/* 61 */       catch (InterruptedException interruptedException) {}
/* 62 */       free = runtime.freeMemory();
/* 63 */       if (free > maxFree) {
/* 64 */         maxFree = free; continue;
/*    */       } 
/*    */       break;
/*    */     } 
/* 68 */     return Lisp.number(free);
/*    */   }
/*    */   
/* 71 */   private static final Primitive GC = new gc();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/gc.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */