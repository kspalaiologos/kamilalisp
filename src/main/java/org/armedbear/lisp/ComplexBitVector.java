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
/*     */ public final class ComplexBitVector
/*     */   extends AbstractBitVector
/*     */ {
/*  40 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private AbstractArray array;
/*     */   
/*     */   private int displacement;
/*     */   
/*     */   public ComplexBitVector(int capacity) {
/*  49 */     this.capacity = capacity;
/*  50 */     int size = capacity >>> 6;
/*  51 */     if ((capacity & 0x3F) != 0)
/*  52 */       size++; 
/*  53 */     this.bits = new long[size];
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexBitVector(int capacity, AbstractArray array, int displacement) {
/*  58 */     this.capacity = capacity;
/*  59 */     this.array = array;
/*  60 */     this.displacement = displacement;
/*  61 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  67 */     return Lisp.list(Symbol.BIT_VECTOR, new LispObject[] { Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  73 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  79 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/*  85 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/*  91 */     if (obj == Lisp.T) {
/*  92 */       this.fillPointer = capacity();
/*     */     } else {
/*  94 */       int n = Fixnum.getValue(obj);
/*  95 */       if (n > capacity()) {
/*  96 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/*  97 */         sb.append(n);
/*  98 */         sb.append(") exceeds the capacity of the vector (");
/*  99 */         sb.append(capacity());
/* 100 */         sb.append(").");
/* 101 */         Lisp.error(new LispError(sb.toString()));
/* 102 */       } else if (n < 0) {
/* 103 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 104 */         sb.append(n);
/* 105 */         sb.append(") is negative.");
/* 106 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/* 108 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 116 */     if (this.array != null) {
/* 117 */       value1 = this.array;
/* 118 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 120 */       value1 = Lisp.NIL;
/* 121 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 123 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 129 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 135 */     if (index >= length())
/* 136 */       badIndex(index, length()); 
/* 137 */     return AREF(index);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 143 */     if (index < 0 || index >= this.capacity)
/* 144 */       badIndex(index, this.capacity); 
/* 145 */     if (this.bits != null) {
/* 146 */       int offset = index >> 6;
/* 147 */       return ((this.bits[offset] & 1L << index) != 0L) ? Fixnum.ONE : Fixnum.ZERO;
/*     */     } 
/*     */     
/* 150 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int getBit(int index) {
/* 157 */     if (this.bits != null) {
/* 158 */       int offset = index >> 6;
/* 159 */       return ((this.bits[offset] & 1L << index) != 0L) ? 1 : 0;
/*     */     } 
/* 161 */     return Fixnum.getValue(this.array.AREF(index + this.displacement));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 167 */     if (index < 0 || index >= this.capacity)
/* 168 */       badIndex(index, this.capacity); 
/* 169 */     if (newValue instanceof Fixnum) {
/* 170 */       switch (((Fixnum)newValue).value) {
/*     */         case 0:
/* 172 */           if (this.bits != null) {
/* 173 */             int offset = index >> 6;
/* 174 */             this.bits[offset] = this.bits[offset] & (1L << index ^ 0xFFFFFFFFFFFFFFFFL);
/*     */           } else {
/* 176 */             clearBit(index);
/*     */           }  return;
/*     */         case 1:
/* 179 */           if (this.bits != null) {
/* 180 */             int offset = index >> 6;
/* 181 */             this.bits[offset] = this.bits[offset] | 1L << index;
/*     */           } else {
/* 183 */             setBit(index);
/*     */           } 
/*     */           return;
/*     */       } 
/*     */     }
/* 188 */     Lisp.type_error(newValue, Symbol.BIT);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void setBit(int index) {
/* 194 */     if (this.bits != null) {
/* 195 */       int offset = index >> 6;
/* 196 */       this.bits[offset] = this.bits[offset] | 1L << index;
/*     */     } else {
/* 198 */       this.array.aset(index + this.displacement, Fixnum.ONE);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   protected void clearBit(int index) {
/* 204 */     if (this.bits != null) {
/* 205 */       int offset = index >> 6;
/* 206 */       this.bits[offset] = this.bits[offset] & (1L << index ^ 0xFFFFFFFFFFFFFFFFL);
/*     */     } else {
/* 208 */       this.array.aset(index + this.displacement, Fixnum.ZERO);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 214 */     if (this.bits != null) {
/* 215 */       if (n < this.capacity) {
/* 216 */         int size = n >>> 6;
/* 217 */         if ((n & 0x3F) != 0)
/* 218 */           size++; 
/* 219 */         if (size < this.bits.length) {
/* 220 */           long[] newbits = new long[size];
/* 221 */           System.arraycopy(this.bits, 0, newbits, 0, size);
/* 222 */           this.bits = newbits;
/*     */         } 
/* 224 */         this.capacity = n;
/*     */         return;
/*     */       } 
/* 227 */       if (n == this.capacity)
/*     */         return; 
/*     */     } 
/* 230 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 236 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 243 */     int fp = getFillPointer();
/* 244 */     if (fp < 0)
/* 245 */       noFillPointer(); 
/* 246 */     if (fp >= capacity())
/*     */     {
/* 248 */       ensureCapacity(capacity() * 2 + 1);
/*     */     }
/* 250 */     aset(fp, element);
/* 251 */     setFillPointer(fp + 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 259 */     vectorPushExtend(element);
/* 260 */     return Fixnum.getInstance(getFillPointer() - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 268 */     int ext = Fixnum.getValue(extension);
/* 269 */     int fp = getFillPointer();
/* 270 */     if (fp < 0)
/* 271 */       noFillPointer(); 
/* 272 */     if (fp >= capacity()) {
/*     */       
/* 274 */       ext = Math.max(ext, capacity() + 1);
/* 275 */       ensureCapacity(capacity() + ext);
/*     */     } 
/* 277 */     aset(fp, element);
/* 278 */     setFillPointer(fp + 1);
/* 279 */     return Fixnum.getInstance(fp);
/*     */   }
/*     */ 
/*     */   
/*     */   private final void ensureCapacity(int minCapacity) {
/* 284 */     if (this.bits != null) {
/* 285 */       if (this.capacity < minCapacity) {
/* 286 */         int size = minCapacity >>> 6;
/* 287 */         if ((minCapacity & 0x3F) != 0)
/* 288 */           size++; 
/* 289 */         long[] newBits = new long[size];
/* 290 */         System.arraycopy(this.bits, 0, newBits, 0, this.bits.length);
/* 291 */         this.bits = newBits;
/* 292 */         this.capacity = minCapacity;
/*     */       } 
/*     */     } else {
/* 295 */       Debug.assertTrue((this.array != null));
/* 296 */       if (this.capacity < minCapacity || this.array
/* 297 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */ 
/*     */         
/* 300 */         int size = minCapacity >>> 6;
/* 301 */         if ((minCapacity & 0x3F) != 0)
/* 302 */           size++; 
/* 303 */         this.bits = new long[size];
/*     */         
/* 305 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 306 */         for (int i = 0; i < limit; i++) {
/* 307 */           int n = Fixnum.getValue(this.array.AREF(this.displacement + i));
/* 308 */           if (n == 1) {
/* 309 */             setBit(i);
/*     */           } else {
/* 311 */             clearBit(i);
/*     */           } 
/* 313 */         }  this.capacity = minCapacity;
/* 314 */         this.array = null;
/* 315 */         this.displacement = 0;
/* 316 */         this.isDisplaced = false;
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
/* 327 */     if (this.bits == null) {
/*     */       
/* 329 */       int size = this.capacity >>> 6;
/* 330 */       if ((this.capacity & 0x3F) != 0)
/* 331 */         size++; 
/* 332 */       this.bits = new long[size];
/* 333 */       for (int i = 0; i < this.capacity; i++) {
/* 334 */         int n = Fixnum.getValue(this.array.AREF(this.displacement + i));
/* 335 */         if (n == 1) {
/* 336 */           setBit(i);
/*     */         } else {
/* 338 */           clearBit(i);
/*     */         } 
/* 340 */       }  this.array = null;
/* 341 */       this.displacement = 0;
/* 342 */       this.isDisplaced = false;
/*     */     } 
/* 344 */     if (this.capacity != newCapacity) {
/* 345 */       int size = newCapacity >>> 6;
/* 346 */       if ((newCapacity & 0x3F) != 0)
/* 347 */         size++; 
/* 348 */       if (initialContents != null)
/* 349 */       { this.bits = new long[size];
/* 350 */         this.capacity = newCapacity;
/* 351 */         if (initialContents.listp()) {
/* 352 */           LispObject list = initialContents;
/* 353 */           for (int i = 0; i < newCapacity; i++) {
/* 354 */             aset(i, list.car());
/* 355 */             list = list.cdr();
/*     */           } 
/* 357 */         } else if (initialContents.vectorp()) {
/* 358 */           for (int i = 0; i < newCapacity; i++)
/* 359 */             aset(i, initialContents.elt(i)); 
/*     */         } else {
/* 361 */           Lisp.type_error(initialContents, Symbol.SEQUENCE);
/*     */         }  }
/* 363 */       else { long[] newBits = new long[size];
/* 364 */         System.arraycopy(this.bits, 0, newBits, 0, 
/* 365 */             Math.min(this.bits.length, newBits.length));
/* 366 */         this.bits = newBits;
/* 367 */         if (newCapacity > this.capacity && initialElement != null) {
/* 368 */           int n = Fixnum.getValue(initialElement);
/* 369 */           if (n == 1) {
/* 370 */             for (int i = this.capacity; i < newCapacity; i++)
/* 371 */               setBit(i); 
/*     */           } else {
/* 373 */             for (int i = this.capacity; i < newCapacity; i++)
/* 374 */               clearBit(i); 
/*     */           } 
/*     */         }  }
/* 377 */        this.capacity = newCapacity;
/*     */     } 
/* 379 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int size, AbstractArray displacedTo, int displacement) {
/* 387 */     this.capacity = size;
/* 388 */     this.array = displacedTo;
/* 389 */     this.displacement = displacement;
/* 390 */     this.bits = null;
/* 391 */     this.isDisplaced = true;
/* 392 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexBitVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */