/*     */ package org.armedbear.lisp;
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
/*     */ public final class last
/*     */   extends Primitive
/*     */ {
/*     */   public last() {
/*  43 */     super("last", "list &optional n");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/*  49 */     if (arg == Lisp.NIL)
/*  50 */       return Lisp.NIL; 
/*  51 */     if (arg instanceof Cons)
/*     */     {
/*     */       while (true) {
/*     */         
/*  55 */         LispObject cdr = ((Cons)arg).cdr;
/*  56 */         if (!(cdr instanceof Cons))
/*  57 */           return arg; 
/*  58 */         arg = cdr;
/*     */       } 
/*     */     }
/*     */     
/*  62 */     return Lisp.type_error(arg, Symbol.LIST);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/*  69 */     LispObject list = Lisp.checkList(first);
/*  70 */     if (second instanceof Fixnum) {
/*     */       
/*  72 */       int n = ((Fixnum)second).value;
/*  73 */       if (n >= 0) {
/*  74 */         if (list == Lisp.NIL)
/*  75 */           return Lisp.NIL; 
/*  76 */         LispObject result = list;
/*  77 */         while (list instanceof Cons) {
/*     */           
/*  79 */           list = list.cdr();
/*  80 */           if (n-- <= 0)
/*  81 */             result = result.cdr(); 
/*     */         } 
/*  83 */         return result;
/*     */       }
/*     */     
/*  86 */     } else if (second instanceof Bignum) {
/*     */       
/*  88 */       if (list == Lisp.NIL)
/*  89 */         return Lisp.NIL; 
/*  90 */       LispObject n = second;
/*  91 */       LispObject result = list;
/*  92 */       while (list instanceof Cons) {
/*     */         
/*  94 */         list = list.cdr();
/*  95 */         if (!n.plusp())
/*  96 */           result = result.cdr(); 
/*  97 */         n = n.decr();
/*     */       } 
/*  99 */       return result;
/*     */     } 
/* 101 */     return Lisp.type_error(second, Symbol.UNSIGNED_BYTE);
/*     */   }
/*     */   
/* 104 */   private static final Primitive LAST = new last();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/last.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */