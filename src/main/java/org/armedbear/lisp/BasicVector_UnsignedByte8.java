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
/*     */ public final class BasicVector_UnsignedByte8
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private byte[] elements;
/*     */   
/*     */   public BasicVector_UnsignedByte8(int capacity) {
/*  47 */     this.elements = new byte[capacity];
/*  48 */     this.capacity = capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public BasicVector_UnsignedByte8(byte[] array) {
/*  53 */     this.capacity = array.length;
/*  54 */     this.elements = new byte[this.capacity];
/*  55 */     System.arraycopy(array, 0, this.elements, 0, this.capacity);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public BasicVector_UnsignedByte8(LispObject[] array) {
/*  61 */     this.capacity = array.length;
/*  62 */     this.elements = new byte[this.capacity];
/*  63 */     for (int i = array.length; i-- > 0;) {
/*  64 */       this.elements[i] = Lisp.coerceToJavaByte(array[i]);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  70 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, new Cons(Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  76 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  82 */     if (type == Symbol.SIMPLE_ARRAY)
/*  83 */       return Lisp.T; 
/*  84 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/*  85 */       return Lisp.T; 
/*  86 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  92 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/*  98 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 104 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 110 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 116 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 122 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 130 */       return Lisp.coerceFromJavaByte(this.elements[index]);
/*     */     }
/* 132 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 134 */       badIndex(index, this.capacity);
/* 135 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 144 */       return this.elements[index] & 0xFF;
/*     */     }
/* 146 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 148 */       badIndex(index, this.elements.length);
/*     */       
/* 150 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 159 */       return Lisp.coerceFromJavaByte(this.elements[index]);
/*     */     }
/* 161 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 163 */       badIndex(index, this.elements.length);
/* 164 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/*     */     try {
/* 173 */       this.elements[index] = (byte)n;
/*     */     }
/* 175 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 177 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject value) {
/*     */     try {
/* 186 */       this.elements[index] = Lisp.coerceToJavaByte(value);
/*     */     }
/* 188 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 190 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 197 */     BasicVector_UnsignedByte8 v = new BasicVector_UnsignedByte8(end - start);
/* 198 */     int i = start, j = 0;
/*     */     
/*     */     try {
/* 201 */       while (i < end)
/* 202 */         v.elements[j++] = this.elements[i++]; 
/* 203 */       return v;
/*     */     }
/* 205 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 207 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 214 */     if (!(obj instanceof Fixnum)) {
/* 215 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 219 */     int n = ((Fixnum)obj).value;
/* 220 */     if (n < 0 || n > 255) {
/* 221 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 225 */     for (int i = this.capacity; i-- > 0;) {
/* 226 */       this.elements[i] = (byte)n;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 232 */     if (n < this.capacity) {
/*     */       
/* 234 */       byte[] newArray = new byte[n];
/* 235 */       System.arraycopy(this.elements, 0, newArray, 0, n);
/* 236 */       this.elements = newArray;
/* 237 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 240 */     if (n == this.capacity)
/*     */       return; 
/* 242 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 248 */     BasicVector_UnsignedByte8 result = new BasicVector_UnsignedByte8(this.capacity);
/*     */     
/* 250 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--)
/* 251 */       result.elements[i] = this.elements[j]; 
/* 252 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 258 */     int i = 0;
/* 259 */     int j = this.capacity - 1;
/* 260 */     while (i < j) {
/*     */       
/* 262 */       byte temp = this.elements[i];
/* 263 */       this.elements[i] = this.elements[j];
/* 264 */       this.elements[j] = temp;
/* 265 */       i++;
/* 266 */       j--;
/*     */     } 
/* 268 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 277 */     if (initialContents != null) {
/*     */       
/* 279 */       LispObject[] newElements = new LispObject[newCapacity];
/* 280 */       if (initialContents.listp()) {
/*     */         
/* 282 */         LispObject list = initialContents;
/* 283 */         for (int i = 0; i < newCapacity; i++)
/*     */         {
/* 285 */           newElements[i] = list.car();
/* 286 */           list = list.cdr();
/*     */         }
/*     */       
/* 289 */       } else if (initialContents.vectorp()) {
/*     */         
/* 291 */         for (int i = 0; i < newCapacity; i++) {
/* 292 */           newElements[i] = initialContents.elt(i);
/*     */         }
/*     */       } else {
/* 295 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 296 */       }  return new BasicVector_UnsignedByte8(newElements);
/*     */     } 
/* 298 */     if (this.capacity != newCapacity) {
/*     */       
/* 300 */       byte[] newElements = new byte[newCapacity];
/* 301 */       System.arraycopy(this.elements, 0, newElements, 0, 
/* 302 */           Math.min(this.capacity, newCapacity));
/* 303 */       if (initialElement != null) {
/* 304 */         byte initValue = (byte)(initialElement.intValue() & 0xFF);
/* 305 */         for (int i = this.capacity; i < newCapacity; i++)
/* 306 */           newElements[i] = initValue; 
/*     */       } 
/* 308 */       return new BasicVector_UnsignedByte8(newElements);
/*     */     } 
/*     */     
/* 311 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 319 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_UnsignedByte8.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */