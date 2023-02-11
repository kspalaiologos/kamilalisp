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
/*     */ public final class BasicVector_IntBuffer
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private IntBuffer elements;
/*     */   private boolean directAllocation;
/*     */   
/*     */   public BasicVector_IntBuffer(int capacity) {
/*  50 */     this(capacity, false);
/*     */   }
/*     */   
/*     */   public BasicVector_IntBuffer(int capacity, boolean directAllocation) {
/*  54 */     this.directAllocation = directAllocation;
/*  55 */     if (directAllocation) {
/*  56 */       ByteBuffer b = ByteBuffer.allocateDirect(capacity * 4);
/*  57 */       this.elements = b.asIntBuffer();
/*     */     } else {
/*  59 */       this.elements = IntBuffer.allocate(capacity);
/*     */     } 
/*  61 */     this.capacity = capacity;
/*     */   }
/*     */   
/*     */   public BasicVector_IntBuffer(LispObject[] array, boolean directAllocation) {
/*  65 */     this.capacity = array.length;
/*  66 */     this.directAllocation = directAllocation;
/*  67 */     if (directAllocation) {
/*  68 */       ByteBuffer b = ByteBuffer.allocateDirect(this.capacity * 4);
/*  69 */       this.elements = b.asIntBuffer();
/*     */     } else {
/*  71 */       this.elements = IntBuffer.allocate(this.capacity);
/*     */     } 
/*  73 */     for (int i = array.length; i-- > 0;)
/*     */     {
/*  75 */       this.elements.put(i, (int)(array[i].longValue() & 0xFFFFFFFFL));
/*     */     }
/*     */   }
/*     */   
/*     */   public BasicVector_IntBuffer(ByteBuffer buffer, boolean directAllocation) {
/*  80 */     this.directAllocation = directAllocation;
/*  81 */     this.elements = buffer.asIntBuffer();
/*  82 */     this.capacity = buffer.limit() / 4;
/*     */   }
/*     */   
/*     */   public BasicVector_IntBuffer(IntBuffer buffer) {
/*  86 */     this(buffer, false);
/*     */   }
/*     */   
/*     */   public BasicVector_IntBuffer(IntBuffer buffer, boolean directAllocation) {
/*  90 */     this.directAllocation = directAllocation;
/*  91 */     this.elements = buffer;
/*  92 */     this.capacity = buffer.limit();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  97 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, new Cons(
/*  98 */             Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 103 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 108 */     if (type == Symbol.SIMPLE_ARRAY)
/* 109 */       return Lisp.T; 
/* 110 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/* 111 */       return Lisp.T; 
/* 112 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 117 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 122 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 127 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 132 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 137 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public int length() {
/* 142 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 148 */       return Lisp.number(this.elements.get(index) & 0xFFFFFFFFL);
/* 149 */     } catch (IndexOutOfBoundsException e) {
/* 150 */       badIndex(index, this.capacity);
/* 151 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 159 */       return Lisp.number(this.elements.get(index) & 0xFFFFFFFFL).intValue();
/* 160 */     } catch (IndexOutOfBoundsException e) {
/* 161 */       badIndex(index, this.elements.limit());
/* 162 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public long aref_long(int index) {
/*     */     try {
/* 169 */       return this.elements.get(index) & 0xFFFFFFFFL;
/* 170 */     } catch (IndexOutOfBoundsException e) {
/* 171 */       badIndex(index, this.elements.limit());
/* 172 */       return -1L;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 179 */       return Lisp.number(this.elements.get(index) & 0xFFFFFFFFL);
/* 180 */     } catch (IndexOutOfBoundsException e) {
/* 181 */       badIndex(index, this.elements.limit());
/* 182 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 189 */       if (newValue.isLessThan(Fixnum.ZERO) || newValue.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 190 */         Lisp.type_error(newValue, Lisp.UNSIGNED_BYTE_32);
/*     */       }
/* 192 */       this.elements.put(index, (int)(newValue.longValue() & 0xFFFFFFFFL));
/* 193 */     } catch (IndexOutOfBoundsException e) {
/* 194 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 200 */     BasicVector_IntBuffer v = new BasicVector_IntBuffer(end - start);
/* 201 */     int i = start, j = 0;
/*     */     try {
/* 203 */       while (i < end) {
/* 204 */         v.elements.put(j++, this.elements.get(i++));
/*     */       }
/* 206 */       return v;
/* 207 */     } catch (IndexOutOfBoundsException e) {
/*     */       
/* 209 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 215 */     if (!(obj instanceof LispInteger)) {
/* 216 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 220 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 221 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 223 */     for (int i = this.capacity; i-- > 0;) {
/* 224 */       this.elements.put(i, (int)(obj.longValue() & 0xFFFFFFFFL));
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 230 */     if (n < length()) {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 235 */       this.elements.limit(n);
/* 236 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 239 */     if (n == this.capacity) {
/*     */       return;
/*     */     }
/* 242 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 247 */     BasicVector_IntBuffer result = new BasicVector_IntBuffer(this.capacity);
/*     */     
/* 249 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--) {
/* 250 */       result.elements.put(i, this.elements.get(j));
/*     */     }
/* 252 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 257 */     int i = 0;
/* 258 */     int j = this.capacity - 1;
/* 259 */     while (i < j) {
/* 260 */       int temp = this.elements.get(i);
/* 261 */       this.elements.put(i, this.elements.get(j));
/* 262 */       this.elements.put(j, temp);
/* 263 */       i++;
/* 264 */       j--;
/*     */     } 
/* 266 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 273 */     if (initialContents != null) {
/* 274 */       LispObject[] newElements = new LispObject[newCapacity];
/* 275 */       if (initialContents.listp()) {
/* 276 */         LispObject list = initialContents;
/* 277 */         for (int i = 0; i < newCapacity; i++) {
/* 278 */           newElements[i] = list.car();
/* 279 */           list = list.cdr();
/*     */         } 
/* 281 */       } else if (initialContents.vectorp()) {
/* 282 */         for (int i = 0; i < newCapacity; i++) {
/* 283 */           newElements[i] = initialContents.elt(i);
/*     */         }
/*     */       } else {
/* 286 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/*     */       } 
/* 288 */       return new BasicVector_IntBuffer(newElements, this.directAllocation);
/*     */     } 
/* 290 */     if (this.capacity != newCapacity) {
/* 291 */       LispObject[] newElements = new LispObject[newCapacity];
/* 292 */       System.arraycopy(this.elements.array(), 0, newElements, 0, 
/* 293 */           Math.min(this.capacity, newCapacity));
/* 294 */       if (initialElement != null) {
/* 295 */         for (int i = this.capacity; i < newCapacity; i++) {
/* 296 */           newElements[i] = initialElement;
/*     */         }
/*     */       }
/* 299 */       return new BasicVector_IntBuffer(newElements, this.directAllocation);
/*     */     } 
/*     */     
/* 302 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 309 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_IntBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */