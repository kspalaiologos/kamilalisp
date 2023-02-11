/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.nio.BufferOverflowException;
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
/*     */ 
/*     */ 
/*     */ public final class BasicVector_ByteBuffer
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private ByteBuffer elements;
/*     */   private boolean directAllocation;
/*     */   
/*     */   public BasicVector_ByteBuffer(int capacity) {
/*  51 */     this(capacity, false);
/*     */   }
/*     */   
/*     */   public BasicVector_ByteBuffer(int capacity, boolean directAllocation) {
/*  55 */     this.directAllocation = directAllocation;
/*  56 */     if (directAllocation) {
/*  57 */       this.elements = ByteBuffer.allocateDirect(capacity);
/*     */     } else {
/*  59 */       this.elements = ByteBuffer.allocate(capacity);
/*     */     } 
/*  61 */     this.capacity = capacity;
/*     */   }
/*     */   
/*     */   public BasicVector_ByteBuffer(byte[] array, boolean directAllocation) {
/*  65 */     this.capacity = array.length;
/*  66 */     this.directAllocation = directAllocation;
/*  67 */     this.elements = ByteBuffer.wrap(array);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public BasicVector_ByteBuffer(LispObject[] array, boolean directAllocation) {
/*  74 */     this.directAllocation = directAllocation;
/*  75 */     this.capacity = array.length;
/*  76 */     if (directAllocation) {
/*  77 */       this.elements = ByteBuffer.allocateDirect(array.length);
/*     */     } else {
/*  79 */       this.elements = ByteBuffer.allocate(array.length);
/*     */     } 
/*  81 */     for (int i = array.length; i-- > 0;)
/*     */     {
/*  83 */       this.elements.put(i, Lisp.coerceToJavaByte(array[i]));
/*     */     }
/*     */   }
/*     */   
/*     */   public BasicVector_ByteBuffer(ByteBuffer buffer, boolean directAllocation) {
/*  88 */     this.elements = buffer;
/*  89 */     this.directAllocation = directAllocation;
/*  90 */     this.capacity = buffer.limit();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  95 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, new Cons(
/*  96 */             Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 101 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 106 */     if (type == Symbol.SIMPLE_ARRAY)
/* 107 */       return Lisp.T; 
/* 108 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/* 109 */       return Lisp.T; 
/* 110 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 115 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 120 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 125 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 130 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 135 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public int length() {
/* 140 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 146 */       return Lisp.coerceFromJavaByte(this.elements.get(index));
/* 147 */     } catch (IndexOutOfBoundsException e) {
/* 148 */       badIndex(index, this.capacity);
/* 149 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 156 */       return this.elements.get(index) & 0xFF;
/* 157 */     } catch (IndexOutOfBoundsException e) {
/* 158 */       badIndex(index, this.elements.limit());
/*     */       
/* 160 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 167 */       return Lisp.coerceFromJavaByte(this.elements.get(index));
/* 168 */     } catch (IndexOutOfBoundsException e) {
/* 169 */       badIndex(index, this.elements.limit());
/* 170 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/*     */     try {
/* 177 */       this.elements.put(index, (byte)n);
/* 178 */     } catch (IndexOutOfBoundsException e) {
/* 179 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject value) {
/*     */     try {
/* 186 */       this.elements.put(index, Lisp.coerceToJavaByte(value));
/* 187 */     } catch (IndexOutOfBoundsException e) {
/* 188 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 195 */     BasicVector_ByteBuffer v = new BasicVector_ByteBuffer(end - start, this.directAllocation);
/* 196 */     ByteBuffer view = this.elements.asReadOnlyBuffer();
/* 197 */     view.position(start);
/* 198 */     view.limit(end);
/*     */     try {
/* 200 */       v.elements.put(view);
/* 201 */       v.elements.position(0);
/* 202 */       return v;
/* 203 */     } catch (BufferOverflowException e) {
/* 204 */       return Lisp.error(new TypeError("Could not form a subseq from " + start + " to " + end));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 210 */     if (!(obj instanceof Fixnum)) {
/* 211 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 215 */     int n = ((Fixnum)obj).value;
/* 216 */     if (n < 0 || n > 255) {
/* 217 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/*     */     
/* 222 */     for (int i = length(); i-- > 0;) {
/* 223 */       this.elements.put(i, (byte)n);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 233 */     if (n < length()) {
/* 234 */       this.elements.limit(n);
/* 235 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 238 */     if (n == length()) {
/*     */       return;
/*     */     }
/* 241 */     Lisp.error(new LispError("Attempted to shrink an array to a size greater than its capacity"));
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 246 */     BasicVector_ByteBuffer result = new BasicVector_ByteBuffer(length(), this.directAllocation);
/*     */     
/* 248 */     for (int i = 0, j = length() - 1; i < length(); i++, j--) {
/* 249 */       result.elements.put(i, this.elements.get(j));
/*     */     }
/* 251 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 256 */     int i = 0;
/* 257 */     int j = capacity() - 1;
/* 258 */     while (i < j) {
/* 259 */       byte temp = this.elements.get(i);
/* 260 */       this.elements.put(i, this.elements.get(j));
/* 261 */       this.elements.put(j, temp);
/* 262 */       i++;
/* 263 */       j--;
/*     */     } 
/* 265 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 272 */     if (initialContents != null) {
/*     */       ByteBuffer newElements;
/* 274 */       if (this.directAllocation) {
/* 275 */         newElements = ByteBuffer.allocateDirect(newCapacity);
/*     */       } else {
/* 277 */         newElements = ByteBuffer.allocate(newCapacity);
/*     */       } 
/*     */       
/* 280 */       if (initialContents.listp()) {
/* 281 */         LispObject list = initialContents;
/* 282 */         for (int i = 0; i < newCapacity; i++) {
/* 283 */           newElements.put(i, Lisp.coerceToJavaByte(list.car()));
/* 284 */           list = list.cdr();
/*     */         } 
/* 286 */       } else if (initialContents.vectorp()) {
/* 287 */         for (int i = 0; i < newCapacity; i++)
/* 288 */           newElements.put(i, Lisp.coerceToJavaByte(initialContents.elt(i))); 
/*     */       } else {
/* 290 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 291 */       }  return new BasicVector_ByteBuffer(newElements, this.directAllocation);
/*     */     } 
/* 293 */     if (length() != newCapacity) {
/*     */       ByteBuffer newElements;
/* 295 */       if (this.directAllocation) {
/* 296 */         newElements = ByteBuffer.allocateDirect(newCapacity);
/*     */       } else {
/* 298 */         newElements = ByteBuffer.allocate(newCapacity);
/*     */       } 
/*     */       
/* 301 */       if (this.elements.hasArray()) {
/* 302 */         newElements.put(this.elements.array(), 0, Math.min(length(), newCapacity));
/*     */       } else {
/*     */         
/* 305 */         int limit = Math.min(length(), newCapacity);
/* 306 */         for (int i = 0; i < limit; i++) {
/* 307 */           newElements.put(i, this.elements.get(i));
/*     */         }
/*     */       } 
/*     */       
/* 311 */       if (initialElement != null) {
/* 312 */         byte initValue = (byte)(initialElement.intValue() & 0xFF);
/* 313 */         for (int i = length(); i < newCapacity; i++)
/* 314 */           newElements.put(i, initValue); 
/*     */       } 
/* 316 */       return new BasicVector_ByteBuffer(newElements, this.directAllocation);
/*     */     } 
/*     */     
/* 319 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 326 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_ByteBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */