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
/*     */ public final class NilVector
/*     */   extends AbstractString
/*     */ {
/*     */   private int capacity;
/*     */   
/*     */   public NilVector(int capacity) {
/*  44 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] chars() {
/*  50 */     if (this.capacity != 0)
/*  51 */       accessError(); 
/*  52 */     return new char[0];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] getStringChars() {
/*  58 */     if (this.capacity != 0)
/*  59 */       accessError(); 
/*  60 */     return new char[0];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getStringValue() {
/*  66 */     if (this.capacity != 0)
/*  67 */       accessError(); 
/*  68 */     return "";
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  74 */     return Lisp.list(Symbol.NIL_VECTOR, new LispObject[] { Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  80 */     return BuiltInClass.NIL_VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  86 */     if (type == Symbol.NIL_VECTOR)
/*  87 */       return Lisp.T; 
/*  88 */     if (type == Symbol.SIMPLE_STRING)
/*  89 */       return Lisp.T; 
/*  90 */     if (type == Symbol.SIMPLE_ARRAY)
/*  91 */       return Lisp.T; 
/*  92 */     if (type == BuiltInClass.NIL_VECTOR)
/*  93 */       return Lisp.T; 
/*  94 */     if (type == BuiltInClass.SIMPLE_STRING)
/*  95 */       return Lisp.T; 
/*  96 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/*  97 */       return Lisp.T; 
/*  98 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SIMPLE_STRING_P() {
/* 104 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 110 */     if (obj instanceof NilVector) {
/* 111 */       if (this.capacity != ((NilVector)obj).capacity)
/* 112 */         return false; 
/* 113 */       if (this.capacity != 0) {
/* 114 */         accessError();
/*     */         
/* 116 */         return false;
/*     */       } 
/* 118 */       return true;
/*     */     } 
/* 120 */     if (obj instanceof AbstractString) {
/* 121 */       if (this.capacity != obj.length())
/* 122 */         return false; 
/* 123 */       if (this.capacity != 0) {
/* 124 */         accessError();
/*     */         
/* 126 */         return false;
/*     */       } 
/* 128 */       return true;
/*     */     } 
/* 130 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public String getValue() {
/* 135 */     if (this.capacity == 0)
/* 136 */       return ""; 
/* 137 */     accessError();
/*     */     
/* 139 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 145 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 151 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 157 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject CHAR(int index) {
/* 163 */     return accessError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SCHAR(int index) {
/* 169 */     return accessError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 175 */     return accessError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 181 */     storeError(newValue);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char charAt(int index) {
/* 187 */     accessError();
/*     */     
/* 189 */     return Character.MIN_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCharAt(int index, char c) {
/* 195 */     storeError(LispCharacter.getInstance(c));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 201 */     if (this.capacity == 0 && start == 0 && end == 0)
/* 202 */       return this; 
/* 203 */     return accessError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 209 */     storeError(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(char c) {
/* 215 */     storeError(LispCharacter.getInstance(c));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {}
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 226 */     return accessError();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject accessError() {
/* 231 */     return Lisp.error(new TypeError("Attempt to access an array of element type NIL."));
/*     */   }
/*     */ 
/*     */   
/*     */   private void storeError(LispObject obj) {
/* 236 */     Lisp.error(new TypeError(String.valueOf(obj) + " is not of type NIL."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int sxhash() {
/* 242 */     return 0;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 251 */     accessError();
/*     */     
/* 253 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int size, AbstractArray displacedTo, int displacement) {
/* 261 */     accessError();
/*     */     
/* 263 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/NilVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */