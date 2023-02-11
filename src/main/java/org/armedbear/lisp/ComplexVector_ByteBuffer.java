/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.nio.ByteBuffer;
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
/*     */ public final class ComplexVector_ByteBuffer
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*  44 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private ByteBuffer elements;
/*     */   
/*     */   private boolean directAllocation;
/*     */   
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexVector_ByteBuffer(int capacity) {
/*  56 */     this(capacity, false);
/*     */   }
/*     */   
/*     */   public ComplexVector_ByteBuffer(int capacity, boolean directAllocation) {
/*  60 */     this.capacity = capacity;
/*  61 */     this.directAllocation = directAllocation;
/*  62 */     if (directAllocation) {
/*  63 */       this.elements = ByteBuffer.allocateDirect(capacity);
/*     */     } else {
/*  65 */       this.elements = ByteBuffer.allocate(capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexVector_ByteBuffer(int capacity, AbstractArray array, int displacement) {
/*  71 */     this(capacity, array, displacement, false);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexVector_ByteBuffer(int capacity, AbstractArray array, int displacement, boolean directAllocation) {
/*  77 */     this.capacity = capacity;
/*  78 */     this.array = array;
/*  79 */     this.displacement = displacement;
/*  80 */     this.directAllocation = directAllocation;
/*  81 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  86 */     return Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.UNSIGNED_BYTE_8, Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  91 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  96 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/* 102 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/* 108 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 114 */     if (obj == Lisp.T) {
/* 115 */       this.fillPointer = capacity();
/*     */     } else {
/* 117 */       int n = Fixnum.getValue(obj);
/* 118 */       if (n > capacity()) {
/* 119 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 120 */         sb.append(n);
/* 121 */         sb.append(") exceeds the capacity of the vector (");
/* 122 */         sb.append(capacity());
/* 123 */         sb.append(").");
/* 124 */         Lisp.error(new LispError(sb.toString()));
/* 125 */       } else if (n < 0) {
/* 126 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 127 */         sb.append(n);
/* 128 */         sb.append(") is negative.");
/* 129 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 131 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 138 */     return this.isDisplaced;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 145 */     if (this.array != null) {
/* 146 */       value1 = this.array;
/* 147 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 149 */       value1 = Lisp.NIL;
/* 150 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 152 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 158 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 164 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 170 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public int length() {
/* 175 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 181 */     int limit = length();
/* 182 */     if (index < 0 || index >= limit)
/* 183 */       badIndex(index, limit); 
/* 184 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 190 */     if (this.elements != null) {
/*     */       try {
/* 192 */         return Lisp.coerceFromJavaByte(this.elements.get(index));
/* 193 */       } catch (ArrayIndexOutOfBoundsException e) {
/* 194 */         badIndex(index, this.elements.limit());
/* 195 */         return Lisp.NIL;
/*     */       } 
/*     */     }
/*     */     
/* 199 */     if (index < 0 || index >= this.capacity) {
/* 200 */       badIndex(index, this.capacity);
/*     */     }
/* 202 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/* 208 */     if (this.elements != null) {
/*     */       try {
/* 210 */         this.elements.put(index, (byte)n);
/* 211 */       } catch (IndexOutOfBoundsException e) {
/* 212 */         badIndex(index, this.capacity);
/*     */       }
/*     */     
/*     */     }
/* 216 */     else if (index < 0 || index >= this.capacity) {
/* 217 */       badIndex(index, this.capacity);
/*     */     } else {
/* 219 */       this.array.aset(index + this.displacement, n);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 227 */     if (this.elements != null) {
/*     */       try {
/* 229 */         this.elements.put(index, Lisp.coerceToJavaByte(newValue));
/* 230 */       } catch (IndexOutOfBoundsException e) {
/* 231 */         badIndex(index, this.elements.limit());
/*     */       } 
/*     */     } else {
/* 234 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 240 */     SimpleVector v = new SimpleVector(end - start);
/* 241 */     int i = start, j = 0;
/*     */     try {
/* 243 */       while (i < end)
/* 244 */         v.aset(j++, AREF(i++)); 
/* 245 */       return v;
/*     */     }
/* 247 */     catch (IndexOutOfBoundsException e) {
/* 248 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 255 */     if (!(obj instanceof Fixnum)) {
/* 256 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 260 */     int n = ((Fixnum)obj).value;
/* 261 */     if (n < 0 || n > 255) {
/* 262 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 266 */     for (int i = this.capacity; i-- > 0;) {
/* 267 */       this.elements.put(i, (byte)n);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 274 */     if (n < length()) {
/* 275 */       this.elements.limit(n);
/* 276 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 279 */     if (n == this.elements.limit()) {
/*     */       return;
/*     */     }
/* 282 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 288 */     int length = length();
/* 289 */     BasicVector_ByteBuffer result = new BasicVector_ByteBuffer(length, this.directAllocation);
/*     */     
/* 291 */     for (int i = 0, j = length - 1; i < length; i++, j--)
/* 292 */       result.aset(i, AREF(j)); 
/* 293 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 298 */     if (this.elements != null) {
/* 299 */       int i = 0;
/* 300 */       int j = length() - 1;
/* 301 */       while (i < j) {
/* 302 */         byte temp = this.elements.get(i);
/* 303 */         this.elements.put(i, this.elements.get(j));
/* 304 */         this.elements.put(j, temp);
/* 305 */         i++;
/* 306 */         j--;
/*     */       } 
/*     */     } else {
/*     */       
/* 310 */       int length = length();
/* 311 */       ByteBuffer data = null;
/* 312 */       if (this.directAllocation) {
/* 313 */         data = ByteBuffer.allocateDirect(length);
/*     */       } else {
/* 315 */         data = ByteBuffer.allocate(length);
/*     */       } 
/*     */       
/* 318 */       for (int i = 0, j = length - 1; i < length; i++, j--) {
/* 319 */         data.put(i, Lisp.coerceToJavaByte(AREF(j)));
/*     */       }
/* 321 */       this.elements = data;
/* 322 */       this.capacity = length;
/* 323 */       this.array = null;
/* 324 */       this.displacement = 0;
/* 325 */       this.isDisplaced = false;
/* 326 */       this.fillPointer = -1;
/*     */     } 
/* 328 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 334 */     if (this.fillPointer < 0)
/* 335 */       noFillPointer(); 
/* 336 */     if (this.fillPointer >= this.capacity)
/*     */     {
/* 338 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 340 */     aset(this.fillPointer, element);
/* 341 */     this.fillPointer++;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 348 */     vectorPushExtend(element);
/* 349 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 356 */     int ext = Fixnum.getValue(extension);
/* 357 */     if (this.fillPointer < 0)
/* 358 */       noFillPointer(); 
/* 359 */     if (this.fillPointer >= this.capacity) {
/*     */       
/* 361 */       ext = Math.max(ext, this.capacity + 1);
/* 362 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 364 */     aset(this.fillPointer, element);
/* 365 */     return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 369 */     if (this.elements != null) {
/* 370 */       if (this.capacity < minCapacity) {
/* 371 */         ByteBuffer newBuffer = null;
/* 372 */         if (this.directAllocation) {
/* 373 */           newBuffer = ByteBuffer.allocateDirect(minCapacity);
/*     */         } else {
/* 375 */           newBuffer = ByteBuffer.allocate(minCapacity);
/*     */         } 
/* 377 */         this.elements.position(0);
/* 378 */         newBuffer.put(this.elements);
/* 379 */         newBuffer.position(0);
/* 380 */         this.elements = newBuffer;
/* 381 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/*     */       
/* 385 */       Debug.assertTrue((this.array != null));
/* 386 */       if (this.capacity < minCapacity || this.array
/* 387 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */         
/* 389 */         if (this.directAllocation) {
/* 390 */           this.elements = ByteBuffer.allocateDirect(minCapacity);
/*     */         } else {
/* 392 */           this.elements = ByteBuffer.allocate(minCapacity);
/*     */         } 
/*     */         
/* 395 */         int limit = Math.min(length(), this.array.getTotalSize() - this.displacement);
/* 396 */         for (int i = 0; i < limit; i++) {
/* 397 */           this.elements.put(i, Lisp.coerceToJavaByte(this.array.AREF(this.displacement + i)));
/*     */         }
/* 399 */         this.capacity = minCapacity;
/* 400 */         this.array = null;
/* 401 */         this.displacement = 0;
/* 402 */         this.isDisplaced = false;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 411 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */       
/* 415 */       ByteBuffer newElements = null;
/* 416 */       if (this.directAllocation) {
/* 417 */         newElements = ByteBuffer.allocateDirect(newCapacity);
/*     */       } else {
/* 419 */         newElements = ByteBuffer.allocate(newCapacity);
/*     */       } 
/*     */       
/* 422 */       if (initialContents.listp()) {
/* 423 */         LispObject list = initialContents;
/* 424 */         for (int i = 0; i < newCapacity; i++) {
/* 425 */           newElements.put(i, Lisp.coerceToJavaByte(list.car()));
/* 426 */           list = list.cdr();
/*     */         } 
/* 428 */       } else if (initialContents.vectorp()) {
/* 429 */         for (int i = 0; i < newCapacity; i++) {
/* 430 */           newElements.put(i, Lisp.coerceToJavaByte(initialContents.elt(i)));
/*     */         }
/*     */       } else {
/* 433 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/*     */       } 
/* 435 */       this.elements = newElements;
/*     */     } else {
/*     */       
/* 438 */       if (this.elements == null) {
/*     */         
/* 440 */         if (this.directAllocation) {
/* 441 */           this.elements = ByteBuffer.allocateDirect(newCapacity);
/*     */         } else {
/* 443 */           this.elements = ByteBuffer.allocate(newCapacity);
/*     */         } 
/* 445 */         int limit = Math.min(this.capacity, newCapacity);
/* 446 */         for (int i = 0; i < limit; i++) {
/* 447 */           this.elements.put(i, Lisp.coerceToJavaByte(this.array.AREF(this.displacement + i)));
/*     */         }
/* 449 */       } else if (this.capacity != newCapacity) {
/* 450 */         ByteBuffer newElements = null;
/* 451 */         if (this.directAllocation) {
/* 452 */           newElements = ByteBuffer.allocateDirect(newCapacity);
/*     */         } else {
/* 454 */           newElements = ByteBuffer.allocate(newCapacity);
/*     */         } 
/* 456 */         newElements.put(this.elements.array(), 0, 
/* 457 */             Math.min(this.capacity, newCapacity));
/* 458 */         this.elements = newElements;
/*     */       } 
/*     */       
/* 461 */       if (initialElement != null) {
/* 462 */         byte b = Lisp.coerceToJavaByte(initialElement);
/* 463 */         for (int i = this.capacity; i < newCapacity; i++) {
/* 464 */           this.elements.put(i, b);
/*     */         }
/*     */       } 
/*     */     } 
/* 468 */     this.capacity = newCapacity;
/* 469 */     this.array = null;
/* 470 */     this.displacement = 0;
/* 471 */     this.isDisplaced = false;
/* 472 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 479 */     this.capacity = newCapacity;
/* 480 */     this.array = displacedTo;
/* 481 */     this.displacement = displacement;
/* 482 */     this.elements = null;
/* 483 */     this.isDisplaced = true;
/* 484 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexVector_ByteBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */