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
/*     */ public final class ComplexVector_UnsignedByte8
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*  43 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private byte[] elements;
/*     */   
/*     */   private AbstractArray array;
/*     */   
/*     */   private int displacement;
/*     */ 
/*     */   
/*     */   public ComplexVector_UnsignedByte8(int capacity) {
/*  55 */     this.elements = new byte[capacity];
/*  56 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexVector_UnsignedByte8(int capacity, AbstractArray array, int displacement) {
/*  62 */     this.capacity = capacity;
/*  63 */     this.array = array;
/*  64 */     this.displacement = displacement;
/*  65 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  71 */     return Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.UNSIGNED_BYTE_8, Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  77 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  83 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  89 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/*  95 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 101 */     if (obj == Lisp.T) {
/* 102 */       this.fillPointer = capacity();
/*     */     } else {
/* 104 */       int n = Fixnum.getValue(obj);
/* 105 */       if (n > capacity()) {
/* 106 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 107 */         sb.append(n);
/* 108 */         sb.append(") exceeds the capacity of the vector (");
/* 109 */         sb.append(capacity());
/* 110 */         sb.append(").");
/* 111 */         Lisp.error(new LispError(sb.toString()));
/* 112 */       } else if (n < 0) {
/* 113 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 114 */         sb.append(n);
/* 115 */         sb.append(") is negative.");
/* 116 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 118 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 125 */     return this.isDisplaced;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 132 */     if (this.array != null) {
/* 133 */       value1 = this.array;
/* 134 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 136 */       value1 = Lisp.NIL;
/* 137 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 139 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 145 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 151 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 157 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 163 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 169 */     int limit = length();
/* 170 */     if (index < 0 || index >= limit)
/* 171 */       badIndex(index, limit); 
/* 172 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 179 */     if (this.elements != null) {
/*     */       try {
/* 181 */         return Lisp.coerceFromJavaByte(this.elements[index]);
/*     */       }
/* 183 */       catch (ArrayIndexOutOfBoundsException e) {
/* 184 */         badIndex(index, this.elements.length);
/* 185 */         return Lisp.NIL;
/*     */       } 
/*     */     }
/*     */     
/* 189 */     if (index < 0 || index >= this.capacity)
/* 190 */       badIndex(index, this.capacity); 
/* 191 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/* 198 */     if (this.elements != null) {
/*     */       try {
/* 200 */         this.elements[index] = (byte)n;
/*     */       }
/* 202 */       catch (ArrayIndexOutOfBoundsException e) {
/* 203 */         badIndex(index, this.elements.length);
/*     */       }
/*     */     
/*     */     }
/* 207 */     else if (index < 0 || index >= this.capacity) {
/* 208 */       badIndex(index, this.capacity);
/*     */     } else {
/* 210 */       this.array.aset(index + this.displacement, n);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 217 */     if (this.elements != null) {
/*     */       try {
/* 219 */         this.elements[index] = Lisp.coerceToJavaByte(newValue);
/*     */       }
/* 221 */       catch (ArrayIndexOutOfBoundsException e) {
/* 222 */         badIndex(index, this.elements.length);
/*     */       } 
/*     */     } else {
/* 225 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 231 */     SimpleVector v = new SimpleVector(end - start);
/* 232 */     int i = start, j = 0;
/*     */     try {
/* 234 */       while (i < end)
/* 235 */         v.aset(j++, AREF(i++)); 
/* 236 */       return v;
/*     */     }
/* 238 */     catch (ArrayIndexOutOfBoundsException e) {
/* 239 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 246 */     if (!(obj instanceof Fixnum)) {
/* 247 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 251 */     int n = ((Fixnum)obj).value;
/* 252 */     if (n < 0 || n > 255) {
/* 253 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 257 */     for (int i = this.capacity; i-- > 0;) {
/* 258 */       this.elements[i] = (byte)n;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 264 */     if (this.elements != null) {
/* 265 */       if (n < this.elements.length) {
/* 266 */         byte[] newArray = new byte[n];
/* 267 */         System.arraycopy(this.elements, 0, newArray, 0, n);
/* 268 */         this.elements = newArray;
/* 269 */         this.capacity = n;
/*     */         return;
/*     */       } 
/* 272 */       if (n == this.elements.length)
/*     */         return; 
/*     */     } 
/* 275 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 281 */     int length = length();
/* 282 */     BasicVector_UnsignedByte8 result = new BasicVector_UnsignedByte8(length);
/*     */     
/* 284 */     for (int i = 0, j = length - 1; i < length; i++, j--)
/* 285 */       result.aset(i, AREF(j)); 
/* 286 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 292 */     if (this.elements != null) {
/* 293 */       int i = 0;
/* 294 */       int j = length() - 1;
/* 295 */       while (i < j) {
/* 296 */         byte temp = this.elements[i];
/* 297 */         this.elements[i] = this.elements[j];
/* 298 */         this.elements[j] = temp;
/* 299 */         i++;
/* 300 */         j--;
/*     */       } 
/*     */     } else {
/*     */       
/* 304 */       int length = length();
/* 305 */       byte[] data = new byte[length];
/*     */       
/* 307 */       for (int i = 0, j = length - 1; i < length; i++, j--)
/* 308 */         data[i] = Lisp.coerceToJavaByte(AREF(j)); 
/* 309 */       this.elements = data;
/* 310 */       this.capacity = length;
/* 311 */       this.array = null;
/* 312 */       this.displacement = 0;
/* 313 */       this.isDisplaced = false;
/* 314 */       this.fillPointer = -1;
/*     */     } 
/* 316 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 322 */     if (this.fillPointer < 0)
/* 323 */       noFillPointer(); 
/* 324 */     if (this.fillPointer >= this.capacity)
/*     */     {
/* 326 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 328 */     aset(this.fillPointer, element);
/* 329 */     this.fillPointer++;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 336 */     vectorPushExtend(element);
/* 337 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 344 */     int ext = Fixnum.getValue(extension);
/* 345 */     if (this.fillPointer < 0)
/* 346 */       noFillPointer(); 
/* 347 */     if (this.fillPointer >= this.capacity) {
/*     */       
/* 349 */       ext = Math.max(ext, this.capacity + 1);
/* 350 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 352 */     aset(this.fillPointer, element);
/* 353 */     return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */ 
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 358 */     if (this.elements != null) {
/* 359 */       if (this.capacity < minCapacity) {
/* 360 */         byte[] newArray = new byte[minCapacity];
/* 361 */         System.arraycopy(this.elements, 0, newArray, 0, this.capacity);
/* 362 */         this.elements = newArray;
/* 363 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/*     */       
/* 367 */       Debug.assertTrue((this.array != null));
/* 368 */       if (this.capacity < minCapacity || this.array
/* 369 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */ 
/*     */         
/* 372 */         this.elements = new byte[minCapacity];
/*     */         
/* 374 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 375 */         for (int i = 0; i < limit; i++)
/* 376 */           this.elements[i] = Lisp.coerceToJavaByte(this.array.AREF(this.displacement + i)); 
/* 377 */         this.capacity = minCapacity;
/* 378 */         this.array = null;
/* 379 */         this.displacement = 0;
/* 380 */         this.isDisplaced = false;
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
/* 391 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */       
/* 395 */       byte[] newElements = new byte[newCapacity];
/* 396 */       if (initialContents.listp()) {
/* 397 */         LispObject list = initialContents;
/* 398 */         for (int i = 0; i < newCapacity; i++) {
/* 399 */           newElements[i] = Lisp.coerceToJavaByte(list.car());
/* 400 */           list = list.cdr();
/*     */         } 
/* 402 */       } else if (initialContents.vectorp()) {
/* 403 */         for (int i = 0; i < newCapacity; i++)
/* 404 */           newElements[i] = Lisp.coerceToJavaByte(initialContents.elt(i)); 
/*     */       } else {
/* 406 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 407 */       }  this.elements = newElements;
/*     */     } else {
/* 409 */       if (this.elements == null) {
/*     */         
/* 411 */         this.elements = new byte[newCapacity];
/* 412 */         int limit = Math.min(this.capacity, newCapacity);
/* 413 */         for (int i = 0; i < limit; i++)
/* 414 */           this.elements[i] = Lisp.coerceToJavaByte(this.array.AREF(this.displacement + i)); 
/* 415 */       } else if (this.capacity != newCapacity) {
/* 416 */         byte[] newElements = new byte[newCapacity];
/* 417 */         System.arraycopy(this.elements, 0, newElements, 0, 
/* 418 */             Math.min(this.capacity, newCapacity));
/* 419 */         this.elements = newElements;
/*     */       } 
/*     */       
/* 422 */       if (initialElement != null) {
/* 423 */         byte b = Lisp.coerceToJavaByte(initialElement);
/* 424 */         for (int i = this.capacity; i < newCapacity; i++)
/* 425 */           this.elements[i] = b; 
/*     */       } 
/*     */     } 
/* 428 */     this.capacity = newCapacity;
/* 429 */     this.array = null;
/* 430 */     this.displacement = 0;
/* 431 */     this.isDisplaced = false;
/* 432 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 441 */     this.capacity = newCapacity;
/* 442 */     this.array = displacedTo;
/* 443 */     this.displacement = displacement;
/* 444 */     this.elements = null;
/* 445 */     this.isDisplaced = true;
/* 446 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexVector_UnsignedByte8.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */