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
/*     */ public final class ComplexVector_UnsignedByte32
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*  43 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private LispObject[] elements;
/*     */   
/*     */   private AbstractArray array;
/*     */   
/*     */   private int displacement;
/*     */ 
/*     */   
/*     */   public ComplexVector_UnsignedByte32(int capacity) {
/*  55 */     this.elements = new LispObject[capacity];
/*  56 */     for (int i = capacity; i-- > 0;)
/*  57 */       this.elements[i] = Fixnum.ZERO; 
/*  58 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexVector_UnsignedByte32(int capacity, AbstractArray array, int displacement) {
/*  64 */     this.capacity = capacity;
/*  65 */     this.array = array;
/*  66 */     this.displacement = displacement;
/*  67 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  73 */     return Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.UNSIGNED_BYTE_32, Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  79 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  85 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  91 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/*  97 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 103 */     if (obj == Lisp.T) {
/* 104 */       this.fillPointer = capacity();
/*     */     } else {
/* 106 */       int n = Fixnum.getValue(obj);
/* 107 */       if (n > capacity()) {
/* 108 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 109 */         sb.append(n);
/* 110 */         sb.append(") exceeds the capacity of the vector (");
/* 111 */         sb.append(capacity());
/* 112 */         sb.append(").");
/* 113 */         Lisp.error(new LispError(sb.toString()));
/* 114 */       } else if (n < 0) {
/* 115 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 116 */         sb.append(n);
/* 117 */         sb.append(") is negative.");
/* 118 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 120 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 127 */     return this.isDisplaced;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 134 */     if (this.array != null) {
/* 135 */       value1 = this.array;
/* 136 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 138 */       value1 = Lisp.NIL;
/* 139 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 141 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 147 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 153 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 159 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 165 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 171 */     int limit = length();
/* 172 */     if (index < 0 || index >= limit)
/* 173 */       badIndex(index, limit); 
/* 174 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 181 */     if (this.elements != null) {
/*     */       try {
/* 183 */         return this.elements[index];
/*     */       }
/* 185 */       catch (ArrayIndexOutOfBoundsException e) {
/* 186 */         badIndex(index, this.elements.length);
/* 187 */         return Lisp.NIL;
/*     */       } 
/*     */     }
/*     */     
/* 191 */     if (index < 0 || index >= this.capacity)
/* 192 */       badIndex(index, this.capacity); 
/* 193 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 200 */     if (this.elements != null) {
/*     */       try {
/* 202 */         this.elements[index] = newValue;
/*     */       }
/* 204 */       catch (ArrayIndexOutOfBoundsException e) {
/* 205 */         badIndex(index, this.elements.length);
/*     */       }
/*     */     
/*     */     }
/* 209 */     else if (index < 0 || index >= this.capacity) {
/* 210 */       badIndex(index, this.capacity);
/*     */     } else {
/* 212 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 219 */     SimpleVector v = new SimpleVector(end - start);
/* 220 */     int i = start, j = 0;
/*     */     try {
/* 222 */       while (i < end)
/* 223 */         v.aset(j++, AREF(i++)); 
/* 224 */       return v;
/*     */     }
/* 226 */     catch (ArrayIndexOutOfBoundsException e) {
/* 227 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 234 */     if (!(obj instanceof LispInteger)) {
/* 235 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 239 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 240 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 242 */     for (int i = this.capacity; i-- > 0;) {
/* 243 */       this.elements[i] = obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 249 */     if (this.elements != null) {
/* 250 */       if (n < this.elements.length) {
/* 251 */         LispObject[] newArray = new LispObject[n];
/* 252 */         System.arraycopy(this.elements, 0, newArray, 0, n);
/* 253 */         this.elements = newArray;
/* 254 */         this.capacity = n;
/*     */         return;
/*     */       } 
/* 257 */       if (n == this.elements.length)
/*     */         return; 
/*     */     } 
/* 260 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 266 */     int length = length();
/* 267 */     SimpleVector result = new SimpleVector(length);
/*     */     
/* 269 */     for (int i = 0, j = length - 1; i < length; i++, j--)
/* 270 */       result.aset(i, AREF(j)); 
/* 271 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 277 */     if (this.elements != null) {
/* 278 */       int i = 0;
/* 279 */       int j = length() - 1;
/* 280 */       while (i < j) {
/* 281 */         LispObject temp = this.elements[i];
/* 282 */         this.elements[i] = this.elements[j];
/* 283 */         this.elements[j] = temp;
/* 284 */         i++;
/* 285 */         j--;
/*     */       } 
/*     */     } else {
/*     */       
/* 289 */       int length = length();
/* 290 */       LispObject[] data = new LispObject[length];
/*     */       
/* 292 */       for (int i = 0, j = length - 1; i < length; i++, j--)
/* 293 */         data[i] = AREF(j); 
/* 294 */       this.elements = data;
/* 295 */       this.capacity = length;
/* 296 */       this.array = null;
/* 297 */       this.displacement = 0;
/* 298 */       this.isDisplaced = false;
/* 299 */       this.fillPointer = -1;
/*     */     } 
/* 301 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 308 */     if (this.fillPointer < 0)
/* 309 */       noFillPointer(); 
/* 310 */     if (this.fillPointer >= this.capacity)
/*     */     {
/* 312 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 314 */     aset(this.fillPointer, element);
/* 315 */     this.fillPointer++;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 322 */     vectorPushExtend(element);
/* 323 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 330 */     int ext = Fixnum.getValue(extension);
/* 331 */     if (this.fillPointer < 0)
/* 332 */       noFillPointer(); 
/* 333 */     if (this.fillPointer >= this.capacity) {
/*     */       
/* 335 */       ext = Math.max(ext, this.capacity + 1);
/* 336 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 338 */     aset(this.fillPointer, element);
/* 339 */     return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */ 
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 344 */     if (this.elements != null) {
/* 345 */       if (this.capacity < minCapacity) {
/* 346 */         LispObject[] newArray = new LispObject[minCapacity];
/* 347 */         System.arraycopy(this.elements, 0, newArray, 0, this.capacity);
/* 348 */         this.elements = newArray;
/* 349 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/*     */       
/* 353 */       Debug.assertTrue((this.array != null));
/* 354 */       if (this.capacity < minCapacity || this.array
/* 355 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */ 
/*     */         
/* 358 */         this.elements = new LispObject[minCapacity];
/*     */         
/* 360 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 361 */         for (int i = 0; i < limit; i++)
/* 362 */           this.elements[i] = this.array.AREF(this.displacement + i); 
/* 363 */         this.capacity = minCapacity;
/* 364 */         this.array = null;
/* 365 */         this.displacement = 0;
/* 366 */         this.isDisplaced = false;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 377 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */       
/* 381 */       LispObject[] newElements = new LispObject[newCapacity];
/* 382 */       if (initialContents.listp()) {
/* 383 */         LispObject list = initialContents;
/* 384 */         for (int i = 0; i < newCapacity; i++) {
/* 385 */           newElements[i] = list.car();
/* 386 */           list = list.cdr();
/*     */         } 
/* 388 */       } else if (initialContents.vectorp()) {
/* 389 */         for (int i = 0; i < newCapacity; i++)
/* 390 */           newElements[i] = initialContents.elt(i); 
/*     */       } else {
/* 392 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 393 */       }  this.elements = newElements;
/*     */     } else {
/* 395 */       if (this.elements == null) {
/*     */         
/* 397 */         this.elements = new LispObject[newCapacity];
/* 398 */         int limit = Math.min(this.capacity, newCapacity);
/* 399 */         for (int i = 0; i < limit; i++)
/* 400 */           this.elements[i] = this.array.AREF(this.displacement + i); 
/* 401 */       } else if (this.capacity != newCapacity) {
/* 402 */         LispObject[] newElements = new LispObject[newCapacity];
/* 403 */         System.arraycopy(this.elements, 0, newElements, 0, 
/* 404 */             Math.min(this.capacity, newCapacity));
/* 405 */         this.elements = newElements;
/*     */       } 
/*     */       
/* 408 */       if (initialElement != null)
/* 409 */         for (int i = this.capacity; i < newCapacity; i++) {
/* 410 */           this.elements[i] = initialElement;
/*     */         } 
/*     */     } 
/* 413 */     this.capacity = newCapacity;
/* 414 */     this.array = null;
/* 415 */     this.displacement = 0;
/* 416 */     this.isDisplaced = false;
/* 417 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 426 */     this.capacity = newCapacity;
/* 427 */     this.array = displacedTo;
/* 428 */     this.displacement = displacement;
/* 429 */     this.elements = null;
/* 430 */     this.isDisplaced = true;
/* 431 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexVector_UnsignedByte32.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */