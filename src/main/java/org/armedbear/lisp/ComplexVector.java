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
/*     */ public final class ComplexVector
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
/*     */   public ComplexVector(int capacity) {
/*  55 */     this.elements = new LispObject[capacity];
/*  56 */     for (int i = capacity; i-- > 0;)
/*  57 */       this.elements[i] = Fixnum.ZERO; 
/*  58 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexVector(int capacity, AbstractArray array, int displacement) {
/*  63 */     this.capacity = capacity;
/*  64 */     this.array = array;
/*  65 */     this.displacement = displacement;
/*  66 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  72 */     return Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.T, Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  78 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  84 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  90 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/*  96 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 102 */     if (obj == Lisp.T) {
/* 103 */       this.fillPointer = capacity();
/*     */     } else {
/* 105 */       int n = Fixnum.getValue(obj);
/* 106 */       if (n > capacity()) {
/* 107 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 108 */         sb.append(n);
/* 109 */         sb.append(") exceeds the capacity of the vector (");
/* 110 */         sb.append(capacity());
/* 111 */         sb.append(").");
/* 112 */         Lisp.error(new LispError(sb.toString()));
/* 113 */       } else if (n < 0) {
/* 114 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 115 */         sb.append(n);
/* 116 */         sb.append(") is negative.");
/* 117 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 119 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 126 */     return this.isDisplaced;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 133 */     if (this.array != null) {
/* 134 */       value1 = this.array;
/* 135 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 137 */       value1 = Lisp.NIL;
/* 138 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 140 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 146 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 152 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 158 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 164 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 170 */     int limit = length();
/* 171 */     if (index < 0 || index >= limit)
/* 172 */       badIndex(index, limit); 
/* 173 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 180 */     if (this.elements != null) {
/*     */       try {
/* 182 */         return this.elements[index];
/*     */       }
/* 184 */       catch (ArrayIndexOutOfBoundsException e) {
/* 185 */         badIndex(index, this.elements.length);
/* 186 */         return Lisp.NIL;
/*     */       } 
/*     */     }
/*     */     
/* 190 */     if (index < 0 || index >= this.capacity)
/* 191 */       badIndex(index, this.capacity); 
/* 192 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 199 */     if (this.elements != null) {
/*     */       try {
/* 201 */         this.elements[index] = newValue;
/*     */       }
/* 203 */       catch (ArrayIndexOutOfBoundsException e) {
/* 204 */         badIndex(index, this.elements.length);
/*     */       }
/*     */     
/*     */     }
/* 208 */     else if (index < 0 || index >= this.capacity) {
/* 209 */       badIndex(index, this.capacity);
/*     */     } else {
/* 211 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 218 */     SimpleVector v = new SimpleVector(end - start);
/* 219 */     int i = start, j = 0;
/*     */     try {
/* 221 */       while (i < end)
/* 222 */         v.aset(j++, AREF(i++)); 
/* 223 */       return v;
/*     */     }
/* 225 */     catch (ArrayIndexOutOfBoundsException e) {
/* 226 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 233 */     for (int i = this.capacity; i-- > 0;) {
/* 234 */       this.elements[i] = obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 240 */     if (this.elements != null) {
/* 241 */       if (n < this.elements.length) {
/* 242 */         LispObject[] newArray = new LispObject[n];
/* 243 */         System.arraycopy(this.elements, 0, newArray, 0, n);
/* 244 */         this.elements = newArray;
/* 245 */         this.capacity = n;
/* 246 */         if (this.fillPointer != -1)
/*     */         {
/* 248 */           this.fillPointer = Math.min(this.fillPointer, this.capacity);
/*     */         }
/*     */         return;
/*     */       } 
/* 252 */       if (n == this.elements.length)
/*     */         return; 
/*     */     } 
/* 255 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 261 */     int length = length();
/* 262 */     SimpleVector result = new SimpleVector(length);
/*     */     
/* 264 */     for (int i = 0, j = length - 1; i < length; i++, j--)
/* 265 */       result.aset(i, AREF(j)); 
/* 266 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 272 */     if (this.elements != null) {
/* 273 */       int i = 0;
/* 274 */       int j = length() - 1;
/* 275 */       while (i < j) {
/* 276 */         LispObject temp = this.elements[i];
/* 277 */         this.elements[i] = this.elements[j];
/* 278 */         this.elements[j] = temp;
/* 279 */         i++;
/* 280 */         j--;
/*     */       } 
/*     */     } else {
/*     */       
/* 284 */       int length = length();
/* 285 */       LispObject[] data = new LispObject[length];
/*     */       
/* 287 */       for (int i = 0, j = length - 1; i < length; i++, j--)
/* 288 */         data[i] = AREF(j); 
/* 289 */       this.elements = data;
/* 290 */       this.capacity = length;
/* 291 */       this.array = null;
/* 292 */       this.displacement = 0;
/* 293 */       this.isDisplaced = false;
/* 294 */       this.fillPointer = -1;
/*     */     } 
/* 296 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 303 */     if (this.fillPointer < 0)
/* 304 */       noFillPointer(); 
/* 305 */     if (this.fillPointer >= this.capacity)
/*     */     {
/* 307 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 309 */     aset(this.fillPointer++, element);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 316 */     vectorPushExtend(element);
/* 317 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 324 */     int ext = Fixnum.getValue(extension);
/* 325 */     if (this.fillPointer < 0)
/* 326 */       noFillPointer(); 
/* 327 */     if (this.fillPointer >= this.capacity) {
/*     */       
/* 329 */       ext = Math.max(ext, this.capacity + 1);
/* 330 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 332 */     aset(this.fillPointer, element);
/* 333 */     return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */ 
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 338 */     if (this.elements != null) {
/* 339 */       if (this.capacity < minCapacity) {
/* 340 */         LispObject[] newArray = new LispObject[minCapacity];
/* 341 */         System.arraycopy(this.elements, 0, newArray, 0, this.capacity);
/* 342 */         this.elements = newArray;
/* 343 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/*     */       
/* 347 */       Debug.assertTrue((this.array != null));
/* 348 */       if (this.capacity < minCapacity || this.array
/* 349 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */ 
/*     */         
/* 352 */         this.elements = new LispObject[minCapacity];
/*     */         
/* 354 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 355 */         for (int i = 0; i < limit; i++)
/* 356 */           this.elements[i] = this.array.AREF(this.displacement + i); 
/* 357 */         this.capacity = minCapacity;
/* 358 */         this.array = null;
/* 359 */         this.displacement = 0;
/* 360 */         this.isDisplaced = false;
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
/* 371 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */       
/* 375 */       LispObject[] newElements = new LispObject[newCapacity];
/* 376 */       if (initialContents.listp()) {
/* 377 */         LispObject list = initialContents;
/* 378 */         for (int i = 0; i < newCapacity; i++) {
/* 379 */           newElements[i] = list.car();
/* 380 */           list = list.cdr();
/*     */         } 
/* 382 */       } else if (initialContents.vectorp()) {
/* 383 */         for (int i = 0; i < newCapacity; i++)
/* 384 */           newElements[i] = initialContents.elt(i); 
/*     */       } else {
/* 386 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 387 */       }  this.elements = newElements;
/*     */     } else {
/* 389 */       if (this.elements == null) {
/*     */         
/* 391 */         this.elements = new LispObject[newCapacity];
/* 392 */         int limit = Math.min(this.capacity, newCapacity);
/* 393 */         for (int i = 0; i < limit; i++)
/* 394 */           this.elements[i] = this.array.AREF(this.displacement + i); 
/* 395 */       } else if (this.capacity != newCapacity) {
/* 396 */         LispObject[] newElements = new LispObject[newCapacity];
/* 397 */         System.arraycopy(this.elements, 0, newElements, 0, 
/* 398 */             Math.min(this.capacity, newCapacity));
/* 399 */         this.elements = newElements;
/*     */       } 
/*     */       
/* 402 */       if (initialElement != null)
/* 403 */         for (int i = this.capacity; i < newCapacity; i++)
/* 404 */           this.elements[i] = initialElement;  
/*     */     } 
/* 406 */     this.capacity = newCapacity;
/* 407 */     this.array = null;
/* 408 */     this.displacement = 0;
/* 409 */     this.isDisplaced = false;
/* 410 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 419 */     this.capacity = newCapacity;
/* 420 */     this.array = displacedTo;
/* 421 */     this.displacement = displacement;
/* 422 */     this.elements = null;
/* 423 */     this.isDisplaced = true;
/* 424 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */