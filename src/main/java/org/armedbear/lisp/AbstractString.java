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
/*     */ public abstract class AbstractString
/*     */   extends AbstractVector
/*     */ {
/*     */   public LispObject typep(LispObject type) {
/*  43 */     if (type instanceof Symbol) {
/*  44 */       if (type == Symbol.STRING)
/*  45 */         return Lisp.T; 
/*  46 */       if (type == Symbol.BASE_STRING)
/*  47 */         return Lisp.T; 
/*     */     } 
/*  49 */     if (type == BuiltInClass.STRING)
/*  50 */       return Lisp.T; 
/*  51 */     if (type == BuiltInClass.BASE_STRING)
/*  52 */       return Lisp.T; 
/*  53 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean stringp() {
/*  59 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  65 */     return Symbol.CHARACTER;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean isSimpleVector() {
/*  71 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject STRING() {
/*  77 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public abstract void fill(char paramChar);
/*     */ 
/*     */   
/*     */   public abstract char charAt(int paramInt);
/*     */   
/*     */   public abstract void setCharAt(int paramInt, char paramChar);
/*     */   
/*     */   public final String printObject(int beginIndex, int endIndex) {
/*  89 */     if (beginIndex < 0) {
/*  90 */       beginIndex = 0;
/*     */     }
/*  92 */     int limit = length();
/*  93 */     if (endIndex > limit)
/*  94 */       endIndex = limit; 
/*  95 */     LispThread thread = LispThread.currentThread();
/*  96 */     if (Symbol.PRINT_ESCAPE.symbolValue(thread) != Lisp.NIL || Symbol.PRINT_READABLY
/*  97 */       .symbolValue(thread) != Lisp.NIL) {
/*     */       
/*  99 */       StringBuilder sb = new StringBuilder("\"");
/* 100 */       for (int i = beginIndex; i < endIndex; i++) {
/* 101 */         char c = charAt(i);
/* 102 */         if (c == '"' || c == '\\')
/* 103 */           sb.append('\\'); 
/* 104 */         sb.append(c);
/*     */       } 
/* 106 */       sb.append('"');
/* 107 */       return sb.toString();
/*     */     } 
/* 109 */     return getStringValue().substring(beginIndex, endIndex);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 115 */     return printObject(0, length());
/*     */   }
/*     */   
/*     */   public String toString() {
/* 119 */     int length = length();
/* 120 */     StringBuilder sb = new StringBuilder(length);
/* 121 */     for (int i = 0; i < length; i++) {
/* 122 */       sb.append(charAt(i));
/*     */     }
/* 124 */     return sb.toString();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AbstractString.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */