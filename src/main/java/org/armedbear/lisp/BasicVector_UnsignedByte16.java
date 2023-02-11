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
/*     */ public final class BasicVector_UnsignedByte16
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private int[] elements;
/*     */   
/*     */   public BasicVector_UnsignedByte16(int capacity) {
/*  47 */     this.elements = new int[capacity];
/*  48 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private BasicVector_UnsignedByte16(LispObject[] array) {
/*  54 */     this.capacity = array.length;
/*  55 */     this.elements = new int[this.capacity];
/*  56 */     for (int i = array.length; i-- > 0;) {
/*  57 */       this.elements[i] = Fixnum.getValue(array[i]);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  63 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_16, new Cons(
/*  64 */             Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  70 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  76 */     if (type == Symbol.SIMPLE_ARRAY)
/*  77 */       return Lisp.T; 
/*  78 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/*  79 */       return Lisp.T; 
/*  80 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  86 */     return Lisp.UNSIGNED_BYTE_16;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/*  92 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  98 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 104 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 110 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 116 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 123 */       return Fixnum.getInstance(this.elements[index]);
/*     */     }
/* 125 */     catch (ArrayIndexOutOfBoundsException e) {
/* 126 */       badIndex(index, this.capacity);
/* 127 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 136 */       return this.elements[index];
/*     */     }
/* 138 */     catch (ArrayIndexOutOfBoundsException e) {
/* 139 */       badIndex(index, this.elements.length);
/*     */       
/* 141 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 150 */       return Fixnum.getInstance(this.elements[index]);
/*     */     }
/* 152 */     catch (ArrayIndexOutOfBoundsException e) {
/* 153 */       badIndex(index, this.elements.length);
/* 154 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/*     */     try {
/* 162 */       this.elements[index] = n;
/*     */     }
/* 164 */     catch (ArrayIndexOutOfBoundsException e) {
/* 165 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/* 172 */     if (obj instanceof Fixnum) {
/*     */       try {
/* 174 */         this.elements[index] = ((Fixnum)obj).value;
/*     */       }
/* 176 */       catch (ArrayIndexOutOfBoundsException e) {
/* 177 */         badIndex(index, this.capacity);
/*     */       } 
/*     */     } else {
/*     */       
/* 181 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 188 */     BasicVector_UnsignedByte16 v = new BasicVector_UnsignedByte16(end - start);
/* 189 */     int i = start, j = 0;
/*     */     try {
/* 191 */       while (i < end)
/* 192 */         v.elements[j++] = this.elements[i++]; 
/* 193 */       return v;
/*     */     }
/* 195 */     catch (ArrayIndexOutOfBoundsException e) {
/* 196 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 203 */     if (!(obj instanceof Fixnum)) {
/* 204 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 208 */     int n = ((Fixnum)obj).value;
/* 209 */     if (n < 0 || n > 65535) {
/* 210 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */       
/*     */       return;
/*     */     } 
/* 214 */     for (int i = this.capacity; i-- > 0;) {
/* 215 */       this.elements[i] = n;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 221 */     if (n < this.capacity) {
/* 222 */       int[] newArray = new int[n];
/* 223 */       System.arraycopy(this.elements, 0, newArray, 0, n);
/* 224 */       this.elements = newArray;
/* 225 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 228 */     if (n == this.capacity)
/*     */       return; 
/* 230 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 236 */     BasicVector_UnsignedByte16 result = new BasicVector_UnsignedByte16(this.capacity);
/*     */     
/* 238 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--)
/* 239 */       result.elements[i] = this.elements[j]; 
/* 240 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 246 */     int i = 0;
/* 247 */     int j = this.capacity - 1;
/* 248 */     while (i < j) {
/* 249 */       int temp = this.elements[i];
/* 250 */       this.elements[i] = this.elements[j];
/* 251 */       this.elements[j] = temp;
/* 252 */       i++;
/* 253 */       j--;
/*     */     } 
/* 255 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 264 */     if (initialContents != null) {
/* 265 */       LispObject[] newElements = new LispObject[newCapacity];
/* 266 */       if (initialContents.listp()) {
/* 267 */         LispObject list = initialContents;
/* 268 */         for (int i = 0; i < newCapacity; i++) {
/* 269 */           newElements[i] = list.car();
/* 270 */           list = list.cdr();
/*     */         } 
/* 272 */       } else if (initialContents.vectorp()) {
/* 273 */         for (int i = 0; i < newCapacity; i++)
/* 274 */           newElements[i] = initialContents.elt(i); 
/*     */       } else {
/* 276 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 277 */       }  return new BasicVector_UnsignedByte16(newElements);
/*     */     } 
/* 279 */     if (this.capacity != newCapacity) {
/* 280 */       LispObject[] newElements = new LispObject[newCapacity];
/* 281 */       System.arraycopy(this.elements, 0, newElements, 0, 
/* 282 */           Math.min(this.capacity, newCapacity));
/* 283 */       if (initialElement != null)
/* 284 */         for (int i = this.capacity; i < newCapacity; i++)
/* 285 */           newElements[i] = initialElement;  
/* 286 */       return new BasicVector_UnsignedByte16(newElements);
/*     */     } 
/*     */     
/* 289 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 297 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_UnsignedByte16.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */