/*     */ package org.armedbear.lisp.util;
/*     */ 
/*     */

import java.lang.ref.ReferenceQueue;
import java.lang.ref.WeakReference;
import java.util.*;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class Finalizer
/*     */ {
/*     */   private static class FinalizingWeakReference
/*     */     extends WeakReference<Object>
/*     */   {
/*  55 */     private LinkedList<Runnable> finalizers = new LinkedList<>();
/*     */     
/*     */     FinalizingWeakReference(Object o, ReferenceQueue<? super Object> q, Runnable finalizer) {
/*  58 */       super(o, q);
/*  59 */       this.finalizers.add(finalizer);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     void addFinalizer(Runnable finalizer) {
/*  69 */       this.finalizers.add(finalizer);
/*     */     }
/*     */ 
/*     */     
/*     */     void cancelFinalizers() {
/*  74 */       this.finalizers.clear();
/*     */     }
/*     */ 
/*     */     
/*     */     void run() {
/*  79 */       Iterator<Runnable> iterator = this.finalizers.iterator();
/*  80 */       while (iterator.hasNext()) {
/*  81 */         ((Runnable)iterator.next()).run();
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  90 */   private static ReferenceQueue queue = null;
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  95 */   private static Map<Object, FinalizingWeakReference> references = null;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 102 */   private static Map<FinalizingWeakReference, FinalizingWeakReference> anchor = null;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static synchronized void checkQueue() {
/* 109 */     if (queue == null) {
/* 110 */       queue = new ReferenceQueue();
/* 111 */       references = Collections.synchronizedMap(new WeakHashMap<>());
/* 112 */       anchor = Collections.synchronizedMap(new HashMap<>());
/*     */       
/* 114 */       Thread handler = new Thread(new Runnable()
/*     */           {
/*     */             public void run()
/*     */             {
/*     */               while (true) {
/*     */                 try {
/*     */                   while (true)
/* 121 */                   { Finalizer.FinalizingWeakReference ref = (Finalizer.FinalizingWeakReference)Finalizer.queue.remove();
/* 122 */                     Finalizer.anchor.remove(ref);
/* 123 */                     ref.run(); }
/* 124 */                 } catch (InterruptedException interruptedException) {}
/*     */               } 
/*     */             }
/*     */           },  "ABCL finalizer");
/*     */ 
/*     */       
/* 130 */       handler.setPriority(10);
/* 131 */       handler.setDaemon(true);
/* 132 */       handler.start();
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static void addFinalizer(Object o, Runnable r) {
/* 145 */     if (queue == null) {
/* 146 */       checkQueue();
/*     */     }
/*     */     
/* 149 */     FinalizingWeakReference ref = references.get(o);
/* 150 */     if (ref != null) {
/* 151 */       ref.addFinalizer(r);
/*     */     } else {
/* 153 */       ref = new FinalizingWeakReference(o, queue, r);
/* 154 */       references.put(o, ref);
/* 155 */       anchor.put(ref, ref);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static void clearFinalizers(Object o) {
/* 165 */     FinalizingWeakReference ref = references.get(o);
/*     */     
/* 167 */     if (ref != null) {
/* 168 */       ref.cancelFinalizers();
/* 169 */       anchor.remove(ref);
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/util/Finalizer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */