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
/*     */ 
/*     */ 
/*     */ public final class BasicVector_UnsignedByte32
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private long[] elements;
/*     */   
/*     */   public BasicVector_UnsignedByte32(int capacity) {
/*  48 */     this.elements = new long[capacity];
/*  49 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public BasicVector_UnsignedByte32(LispObject[] array) {
/*  55 */     this.capacity = array.length;
/*  56 */     this.elements = new long[this.capacity];
/*  57 */     for (int i = array.length; i-- > 0;) {
/*  58 */       this.elements[i] = array[i].longValue();
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  64 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, new Cons(
/*  65 */             Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  71 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  77 */     if (type == Symbol.SIMPLE_ARRAY)
/*  78 */       return Lisp.T; 
/*  79 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/*  80 */       return Lisp.T; 
/*  81 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  87 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/*  93 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  99 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 105 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 111 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 117 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 125 */       return Lisp.number(this.elements[index]);
/*     */     }
/* 127 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 129 */       badIndex(index, this.capacity);
/* 130 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 139 */       return (int)this.elements[index];
/*     */     }
/* 141 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 143 */       badIndex(index, this.elements.length);
/* 144 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public long aref_long(int index) {
/*     */     try {
/* 153 */       return this.elements[index];
/*     */     }
/* 155 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 157 */       badIndex(index, this.elements.length);
/* 158 */       return -1L;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 167 */       return Lisp.number(this.elements[index]);
/*     */     }
/* 169 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 171 */       badIndex(index, this.elements.length);
/* 172 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 181 */       this.elements[index] = newValue.longValue();
/*     */     }
/* 183 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 185 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 192 */     BasicVector_UnsignedByte32 v = new BasicVector_UnsignedByte32(end - start);
/* 193 */     int i = start, j = 0;
/*     */     
/*     */     try {
/* 196 */       while (i < end)
/* 197 */         v.elements[j++] = this.elements[i++]; 
/* 198 */       return v;
/*     */     }
/* 200 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */ 
/*     */       
/* 203 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 210 */     if (!(obj instanceof LispInteger)) {
/* 211 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 215 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 216 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 218 */     long value = obj.longValue();
/* 219 */     for (int i = this.capacity; i-- > 0;) {
/* 220 */       this.elements[i] = value;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 226 */     if (n < this.capacity) {
/*     */       
/* 228 */       long[] newArray = new long[n];
/* 229 */       System.arraycopy(this.elements, 0, newArray, 0, n);
/* 230 */       this.elements = newArray;
/* 231 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 234 */     if (n == this.capacity)
/*     */       return; 
/* 236 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 242 */     BasicVector_UnsignedByte32 result = new BasicVector_UnsignedByte32(this.capacity);
/*     */     
/* 244 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--)
/* 245 */       result.elements[i] = this.elements[j]; 
/* 246 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 252 */     int i = 0;
/* 253 */     int j = this.capacity - 1;
/* 254 */     while (i < j) {
/*     */       
/* 256 */       long temp = this.elements[i];
/* 257 */       this.elements[i] = this.elements[j];
/* 258 */       this.elements[j] = temp;
/* 259 */       i++;
/* 260 */       j--;
/*     */     } 
/* 262 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 271 */     if (initialContents != null) {
/*     */       
/* 273 */       LispObject[] newElements = new LispObject[newCapacity];
/* 274 */       if (initialContents.listp()) {
/*     */         
/* 276 */         LispObject list = initialContents;
/* 277 */         for (int i = 0; i < newCapacity; i++)
/*     */         {
/* 279 */           newElements[i] = list.car();
/* 280 */           list = list.cdr();
/*     */         }
/*     */       
/* 283 */       } else if (initialContents.vectorp()) {
/*     */         
/* 285 */         for (int i = 0; i < newCapacity; i++) {
/* 286 */           newElements[i] = initialContents.elt(i);
/*     */         }
/*     */       } else {
/* 289 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 290 */       }  return new BasicVector_UnsignedByte32(newElements);
/*     */     } 
/* 292 */     if (this.capacity != newCapacity) {
/*     */       
/* 294 */       LispObject[] newElements = new LispObject[newCapacity];
/* 295 */       System.arraycopy(this.elements, 0, newElements, 0, 
/* 296 */           Math.min(this.capacity, newCapacity));
/* 297 */       if (initialElement != null)
/* 298 */         for (int i = this.capacity; i < newCapacity; i++)
/* 299 */           newElements[i] = initialElement;  
/* 300 */       return new BasicVector_UnsignedByte32(newElements);
/*     */     } 
/*     */     
/* 303 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 311 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_UnsignedByte32.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */