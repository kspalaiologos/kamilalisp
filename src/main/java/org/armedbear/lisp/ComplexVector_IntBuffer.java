/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.nio.ByteBuffer;
/*     */ import java.nio.IntBuffer;
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
/*     */ public final class ComplexVector_IntBuffer
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*  46 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private IntBuffer elements;
/*     */   
/*     */   private boolean directAllocation;
/*     */   
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexVector_IntBuffer(int capacity) {
/*  58 */     this(capacity, false);
/*     */   }
/*     */   
/*     */   public ComplexVector_IntBuffer(int capacity, boolean directAllocation) {
/*  62 */     this.capacity = capacity;
/*  63 */     this.directAllocation = directAllocation;
/*  64 */     if (directAllocation) {
/*  65 */       ByteBuffer b = ByteBuffer.allocateDirect(capacity * 4);
/*  66 */       this.elements = b.asIntBuffer();
/*     */     } else {
/*  68 */       this.elements = IntBuffer.allocate(capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexVector_IntBuffer(int capacity, AbstractArray array, int displacement) {
/*  74 */     this(capacity, array, displacement, false);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexVector_IntBuffer(int capacity, AbstractArray array, int displacement, boolean directAllocation) {
/*  79 */     this.capacity = capacity;
/*  80 */     this.array = array;
/*  81 */     this.displacement = displacement;
/*  82 */     this.directAllocation = directAllocation;
/*  83 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  88 */     return Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.UNSIGNED_BYTE_32, Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  93 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  98 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/* 103 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/* 108 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 113 */     if (obj == Lisp.T) {
/* 114 */       this.fillPointer = capacity();
/*     */     } else {
/* 116 */       int n = Fixnum.getValue(obj);
/* 117 */       if (n > capacity()) {
/* 118 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 119 */         sb.append(n);
/* 120 */         sb.append(") exceeds the capacity of the vector (");
/* 121 */         sb.append(capacity());
/* 122 */         sb.append(").");
/* 123 */         Lisp.error(new LispError(sb.toString()));
/* 124 */       } else if (n < 0) {
/* 125 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 126 */         sb.append(n);
/* 127 */         sb.append(") is negative.");
/* 128 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 130 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 137 */     return this.isDisplaced;
/*     */   }
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 143 */     if (this.array != null) {
/* 144 */       value1 = this.array;
/* 145 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 147 */       value1 = Lisp.NIL;
/* 148 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 150 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 155 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */   
/*     */   public boolean isSimpleVector() {
/* 159 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 164 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public int length() {
/* 169 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 174 */     int limit = length();
/* 175 */     if (index < 0 || index >= limit)
/* 176 */       badIndex(index, limit); 
/* 177 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 183 */     if (this.elements != null) {
/*     */       try {
/* 185 */         return Lisp.number(this.elements.get(index) & 0xFFFFFFFFL);
/* 186 */       } catch (IndexOutOfBoundsException e) {
/* 187 */         badIndex(index, this.elements.limit());
/* 188 */         return Lisp.NIL;
/*     */       } 
/*     */     }
/*     */     
/* 192 */     if (index < 0 || index >= this.capacity) {
/* 193 */       badIndex(index, this.capacity);
/*     */     }
/* 195 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 201 */     if (newValue.isLessThan(Fixnum.ZERO) || newValue
/* 202 */       .isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 203 */       Lisp.type_error(newValue, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 205 */     if (this.elements != null) {
/*     */       try {
/* 207 */         this.elements.put(index, (int)(newValue.longValue() & 0xFFFFFFFFL));
/* 208 */       } catch (IndexOutOfBoundsException e) {
/* 209 */         badIndex(index, this.elements.limit());
/*     */       }
/*     */     
/*     */     }
/* 213 */     else if (index < 0 || index >= this.capacity) {
/* 214 */       badIndex(index, this.capacity);
/*     */     } else {
/* 216 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 223 */     SimpleVector v = new SimpleVector(end - start);
/* 224 */     int i = start, j = 0;
/*     */     try {
/* 226 */       while (i < end) {
/* 227 */         v.aset(j++, AREF(i++));
/*     */       }
/* 229 */       return v;
/* 230 */     } catch (IndexOutOfBoundsException e) {
/* 231 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 237 */     if (!(obj instanceof LispInteger)) {
/* 238 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 242 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 243 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 245 */     for (int i = this.capacity; i-- > 0;) {
/* 246 */       this.elements.put(i, Lisp.coerceToJavaUnsignedInt(obj));
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 254 */     if (n < length()) {
/* 255 */       this.elements.limit(n);
/* 256 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 259 */     if (n == this.elements.limit()) {
/*     */       return;
/*     */     }
/* 262 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 267 */     int length = length();
/* 268 */     SimpleVector result = new SimpleVector(length);
/*     */     
/* 270 */     for (int i = 0, j = length - 1; i < length; i++, j--) {
/* 271 */       result.aset(i, AREF(j));
/*     */     }
/* 273 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 278 */     if (this.elements != null) {
/* 279 */       int i = 0;
/* 280 */       int j = length() - 1;
/* 281 */       while (i < j) {
/* 282 */         int temp = this.elements.get(i);
/* 283 */         this.elements.put(i, this.elements.get(j));
/* 284 */         this.elements.put(j, temp);
/* 285 */         i++;
/* 286 */         j--;
/*     */       } 
/*     */     } else {
/*     */       
/* 290 */       int length = length();
/* 291 */       IntBuffer data = null;
/* 292 */       if (this.directAllocation) {
/* 293 */         ByteBuffer b = ByteBuffer.allocateDirect(length * 4);
/* 294 */         data = b.asIntBuffer();
/*     */       } else {
/* 296 */         data = IntBuffer.allocate(length);
/*     */       } 
/*     */       
/* 299 */       for (int i = 0, j = length - 1; i < length; i++, j--) {
/* 300 */         data.put(i, Lisp.coerceToJavaUnsignedInt(AREF(j)));
/*     */       }
/* 302 */       this.elements = data;
/* 303 */       this.capacity = length;
/* 304 */       this.array = null;
/* 305 */       this.displacement = 0;
/* 306 */       this.isDisplaced = false;
/* 307 */       this.fillPointer = -1;
/*     */     } 
/* 309 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 314 */     if (this.fillPointer < 0) {
/* 315 */       noFillPointer();
/*     */     }
/* 317 */     if (this.fillPointer >= this.capacity)
/*     */     {
/* 319 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 321 */     aset(this.fillPointer, element);
/* 322 */     this.fillPointer++;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 327 */     vectorPushExtend(element);
/* 328 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 334 */     int ext = Fixnum.getValue(extension);
/* 335 */     if (this.fillPointer < 0) {
/* 336 */       noFillPointer();
/*     */     }
/* 338 */     if (this.fillPointer >= this.capacity) {
/*     */       
/* 340 */       ext = Math.max(ext, this.capacity + 1);
/* 341 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 343 */     aset(this.fillPointer, element);
/* 344 */     return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 348 */     if (this.elements != null) {
/* 349 */       if (this.capacity < minCapacity) {
/* 350 */         IntBuffer newBuffer = null;
/* 351 */         if (this.directAllocation) {
/* 352 */           ByteBuffer b = ByteBuffer.allocateDirect(minCapacity * 4);
/* 353 */           newBuffer = b.asIntBuffer();
/*     */         } else {
/* 355 */           newBuffer = IntBuffer.allocate(minCapacity);
/*     */         } 
/* 357 */         this.elements.position(0);
/* 358 */         newBuffer.put(this.elements);
/* 359 */         newBuffer.position(0);
/* 360 */         this.elements = newBuffer;
/* 361 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/*     */       
/* 365 */       Debug.assertTrue((this.array != null));
/* 366 */       if (this.capacity < minCapacity || this.array
/* 367 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */         
/* 369 */         if (this.directAllocation) {
/* 370 */           ByteBuffer b = ByteBuffer.allocateDirect(minCapacity * 4);
/* 371 */           this.elements = b.asIntBuffer();
/*     */         } else {
/* 373 */           this.elements = IntBuffer.allocate(minCapacity);
/*     */         } 
/*     */         
/* 376 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 377 */         for (int i = 0; i < limit; i++) {
/* 378 */           this.elements.put(i, Lisp.coerceToJavaUnsignedInt(AREF(this.displacement + i)));
/*     */         }
/* 380 */         this.capacity = minCapacity;
/* 381 */         this.array = null;
/* 382 */         this.displacement = 0;
/* 383 */         this.isDisplaced = false;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 392 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */       
/* 396 */       IntBuffer newElements = null;
/* 397 */       if (this.directAllocation) {
/* 398 */         ByteBuffer b = ByteBuffer.allocateDirect(newCapacity * 4);
/* 399 */         newElements = b.asIntBuffer();
/*     */       } else {
/* 401 */         newElements = IntBuffer.allocate(newCapacity);
/*     */       } 
/* 403 */       if (initialContents.listp()) {
/* 404 */         LispObject list = initialContents;
/* 405 */         for (int i = 0; i < newCapacity; i++) {
/* 406 */           newElements.put(i, Lisp.coerceToJavaUnsignedInt(list.car()));
/* 407 */           list = list.cdr();
/*     */         } 
/* 409 */       } else if (initialContents.vectorp()) {
/* 410 */         for (int i = 0; i < newCapacity; i++) {
/* 411 */           newElements.put(i, Lisp.coerceToJavaUnsignedInt(initialContents.elt(i)));
/*     */         }
/*     */       } else {
/*     */         
/* 415 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/*     */       } 
/* 417 */       this.elements = newElements;
/*     */     } else {
/* 419 */       if (this.elements == null) {
/*     */         
/* 421 */         if (this.directAllocation) {
/* 422 */           ByteBuffer b = ByteBuffer.allocateDirect(newCapacity * 4);
/* 423 */           this.elements = b.asIntBuffer();
/*     */         } else {
/* 425 */           this.elements = IntBuffer.allocate(newCapacity);
/*     */         } 
/* 427 */         int limit = Math.min(this.capacity, newCapacity);
/* 428 */         for (int i = 0; i < limit; i++) {
/* 429 */           this.elements.put(i, (int)(this.array.AREF(this.displacement + i).longValue() & 0xFFFFFFFFL));
/*     */         }
/* 431 */       } else if (this.capacity != newCapacity) {
/* 432 */         IntBuffer newElements = null;
/* 433 */         if (this.directAllocation) {
/* 434 */           ByteBuffer b = ByteBuffer.allocateDirect(newCapacity * 4);
/* 435 */           newElements = b.asIntBuffer();
/*     */         } else {
/* 437 */           newElements = IntBuffer.allocate(newCapacity);
/*     */         } 
/* 439 */         newElements.put(this.elements.array(), 0, 
/* 440 */             Math.min(this.capacity, newCapacity));
/* 441 */         newElements.position(0);
/* 442 */         this.elements = newElements;
/*     */       } 
/*     */       
/* 445 */       if (initialElement != null) {
/* 446 */         for (int i = this.capacity; i < newCapacity; i++) {
/* 447 */           this.elements.put(i, Lisp.coerceToJavaUnsignedInt(initialElement));
/*     */         }
/*     */       }
/*     */     } 
/* 451 */     this.capacity = newCapacity;
/* 452 */     this.array = null;
/* 453 */     this.displacement = 0;
/* 454 */     this.isDisplaced = false;
/* 455 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 462 */     this.capacity = newCapacity;
/* 463 */     this.array = displacedTo;
/* 464 */     this.displacement = displacement;
/* 465 */     this.elements = null;
/* 466 */     this.isDisplaced = true;
/* 467 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexVector_IntBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */