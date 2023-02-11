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
/*     */ public final class SimpleVector
/*     */   extends AbstractVector
/*     */ {
/*     */   int capacity;
/*     */   LispObject[] data;
/*     */   
/*     */   public SimpleVector(int capacity) {
/*  48 */     this.data = new LispObject[capacity];
/*  49 */     for (int i = capacity; i-- > 0;)
/*  50 */       this.data[i] = Fixnum.ZERO; 
/*  51 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleVector(LispObject obj) {
/*  56 */     if (obj.listp()) {
/*     */       
/*  58 */       this.data = obj.copyToArray();
/*  59 */       this.capacity = this.data.length;
/*     */     }
/*  61 */     else if (obj instanceof AbstractVector) {
/*     */       
/*  63 */       this.capacity = obj.length();
/*  64 */       this.data = new LispObject[this.capacity];
/*  65 */       for (int i = 0; i < this.capacity; i++) {
/*  66 */         this.data[i] = obj.elt(i);
/*     */       }
/*     */     } else {
/*  69 */       Debug.assertTrue(false);
/*     */     } 
/*     */   }
/*     */   
/*     */   public SimpleVector(LispObject[] array) {
/*  74 */     this.data = array;
/*  75 */     this.capacity = array.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  81 */     return Lisp.list(Symbol.SIMPLE_VECTOR, new LispObject[] { Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  87 */     return BuiltInClass.SIMPLE_VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/*  93 */     StringBuffer sb = new StringBuffer("A simple vector with ");
/*  94 */     sb.append(this.capacity);
/*  95 */     sb.append(" elements");
/*  96 */     return new SimpleString(sb);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 102 */     if (type == Symbol.SIMPLE_VECTOR)
/* 103 */       return Lisp.T; 
/* 104 */     if (type == Symbol.SIMPLE_ARRAY)
/* 105 */       return Lisp.T; 
/* 106 */     if (type == BuiltInClass.SIMPLE_VECTOR)
/* 107 */       return Lisp.T; 
/* 108 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/* 109 */       return Lisp.T; 
/* 110 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 116 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 122 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 128 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 134 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 140 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 146 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 154 */       return this.data[index];
/*     */     }
/* 156 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 158 */       badIndex(index, this.capacity);
/* 159 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 168 */       return this.data[index];
/*     */     }
/* 170 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 172 */       badIndex(index, this.data.length);
/* 173 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 182 */       this.data[index] = newValue;
/*     */     }
/* 184 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 186 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SVREF(int index) {
/*     */     try {
/* 195 */       return this.data[index];
/*     */     }
/* 197 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 199 */       badIndex(index, this.data.length);
/* 200 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void svset(int index, LispObject newValue) {
/*     */     try {
/* 209 */       this.data[index] = newValue;
/*     */     }
/* 211 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 213 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 220 */     SimpleVector v = new SimpleVector(end - start);
/* 221 */     int i = start, j = 0;
/*     */     
/*     */     try {
/* 224 */       while (i < end)
/* 225 */         v.data[j++] = this.data[i++]; 
/* 226 */       return v;
/*     */     }
/* 228 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 230 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 237 */     for (int i = this.capacity; i-- > 0;) {
/* 238 */       this.data[i] = obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject deleteEq(LispObject item) {
/* 244 */     int limit = this.capacity;
/* 245 */     int i = 0;
/* 246 */     int j = 0;
/* 247 */     while (i < limit) {
/*     */       
/* 249 */       LispObject obj = this.data[i++];
/* 250 */       if (obj != item)
/* 251 */         this.data[j++] = obj; 
/*     */     } 
/* 253 */     if (j < limit)
/* 254 */       shrink(j); 
/* 255 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject deleteEql(LispObject item) {
/* 261 */     int limit = this.capacity;
/* 262 */     int i = 0;
/* 263 */     int j = 0;
/* 264 */     while (i < limit) {
/*     */       
/* 266 */       LispObject obj = this.data[i++];
/* 267 */       if (!obj.eql(item))
/* 268 */         this.data[j++] = obj; 
/*     */     } 
/* 270 */     if (j < limit)
/* 271 */       shrink(j); 
/* 272 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 278 */     if (n < this.capacity) {
/*     */       
/* 280 */       LispObject[] newData = new LispObject[n];
/* 281 */       System.arraycopy(this.data, 0, newData, 0, n);
/* 282 */       this.data = newData;
/* 283 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 286 */     if (n == this.capacity)
/*     */       return; 
/* 288 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 294 */     SimpleVector result = new SimpleVector(this.capacity);
/*     */     
/* 296 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--)
/* 297 */       result.data[i] = this.data[j]; 
/* 298 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 304 */     int i = 0;
/* 305 */     int j = this.capacity - 1;
/* 306 */     while (i < j) {
/*     */       
/* 308 */       LispObject temp = this.data[i];
/* 309 */       this.data[i] = this.data[j];
/* 310 */       this.data[j] = temp;
/* 311 */       i++;
/* 312 */       j--;
/*     */     } 
/* 314 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 323 */     if (initialContents != null) {
/*     */       
/* 325 */       LispObject[] newData = new LispObject[newCapacity];
/* 326 */       if (initialContents.listp()) {
/*     */         
/* 328 */         LispObject list = initialContents;
/* 329 */         for (int i = 0; i < newCapacity; i++)
/*     */         {
/* 331 */           newData[i] = list.car();
/* 332 */           list = list.cdr();
/*     */         }
/*     */       
/* 335 */       } else if (initialContents.vectorp()) {
/*     */         
/* 337 */         for (int i = 0; i < newCapacity; i++) {
/* 338 */           newData[i] = initialContents.elt(i);
/*     */         }
/*     */       } else {
/* 341 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 342 */       }  return new SimpleVector(newData);
/*     */     } 
/* 344 */     if (this.capacity != newCapacity) {
/*     */       
/* 346 */       LispObject[] newData = new LispObject[newCapacity];
/* 347 */       System.arraycopy(this.data, 0, newData, 0, 
/* 348 */           Math.min(this.capacity, newCapacity));
/* 349 */       if (initialElement != null)
/* 350 */         for (int i = this.capacity; i < newCapacity; i++)
/* 351 */           newData[i] = initialElement;  
/* 352 */       return new SimpleVector(newData);
/*     */     } 
/*     */     
/* 355 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 363 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 368 */   private static final Primitive SVREF = new Primitive("svref", "simple-vector index")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 375 */         if (first instanceof SimpleVector) {
/* 376 */           SimpleVector sv = (SimpleVector)first;
/* 377 */           int index = Fixnum.getValue(second);
/*     */           try {
/* 379 */             return sv.data[index];
/* 380 */           } catch (ArrayIndexOutOfBoundsException e) {
/* 381 */             int capacity = sv.capacity;
/* 382 */             sv.badIndex(index, capacity);
/*     */             
/* 384 */             return Lisp.NIL;
/*     */           } 
/*     */         } 
/* 387 */         return Lisp.type_error(first, Symbol.SIMPLE_VECTOR);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 392 */   private static final Primitive SVSET = new Primitive("svset", Lisp.PACKAGE_SYS, true, "simple-vector index new-value")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 400 */         if (first instanceof SimpleVector) {
/* 401 */           SimpleVector sv = (SimpleVector)first;
/* 402 */           int index = Fixnum.getValue(second);
/*     */           try {
/* 404 */             sv.data[index] = third;
/* 405 */             return third;
/* 406 */           } catch (ArrayIndexOutOfBoundsException e) {
/* 407 */             int capacity = sv.capacity;
/* 408 */             sv.badIndex(index, capacity);
/*     */             
/* 410 */             return Lisp.NIL;
/*     */           } 
/*     */         } 
/* 413 */         return Lisp.type_error(first, Symbol.SIMPLE_VECTOR);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */