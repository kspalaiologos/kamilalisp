/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.nio.ByteBuffer;
/*     */ import java.nio.CharBuffer;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class BasicVector_CharBuffer
/*     */   extends AbstractVector
/*     */ {
/*     */   private int capacity;
/*     */   private CharBuffer elements;
/*     */   private boolean directAllocation;
/*     */   
/*     */   public BasicVector_CharBuffer(int capacity) {
/*  48 */     this(capacity, false);
/*     */   }
/*     */   
/*     */   public BasicVector_CharBuffer(int capacity, boolean directAllocation) {
/*  52 */     this.directAllocation = directAllocation;
/*  53 */     if (directAllocation) {
/*  54 */       ByteBuffer b = ByteBuffer.allocateDirect(capacity * 2);
/*  55 */       this.elements = b.asCharBuffer();
/*     */     } else {
/*  57 */       this.elements = CharBuffer.allocate(capacity);
/*     */     } 
/*  59 */     this.capacity = capacity;
/*     */   }
/*     */   
/*     */   public BasicVector_CharBuffer(LispObject[] array, boolean directAllocation) {
/*  63 */     this.capacity = array.length;
/*  64 */     this.directAllocation = directAllocation;
/*  65 */     if (directAllocation) {
/*  66 */       ByteBuffer b = ByteBuffer.allocateDirect(this.capacity * 2);
/*  67 */       this.elements = b.asCharBuffer();
/*     */     } else {
/*  69 */       this.elements = CharBuffer.allocate(this.capacity);
/*     */     } 
/*  71 */     for (int i = array.length; i-- > 0;) {
/*  72 */       this.elements.put(i, (char)Fixnum.getValue(array[i]));
/*     */     }
/*     */   }
/*     */   
/*     */   public BasicVector_CharBuffer(ByteBuffer buffer, boolean directAllocation) {
/*  77 */     this.elements = buffer.asCharBuffer();
/*  78 */     this.directAllocation = directAllocation;
/*  79 */     this.capacity = buffer.limit() / 2;
/*     */   }
/*     */   
/*     */   public BasicVector_CharBuffer(CharBuffer buffer, boolean directAllocation) {
/*  83 */     this.elements = buffer;
/*  84 */     this.directAllocation = directAllocation;
/*  85 */     this.capacity = buffer.limit();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  90 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_16, new Cons(
/*  91 */             Fixnum.getInstance(this.capacity)) });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  96 */     return BuiltInClass.VECTOR;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 101 */     if (type == Symbol.SIMPLE_ARRAY)
/* 102 */       return Lisp.T; 
/* 103 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/* 104 */       return Lisp.T; 
/* 105 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 110 */     return Lisp.UNSIGNED_BYTE_16;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 115 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 120 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 125 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int capacity() {
/* 130 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public int length() {
/* 135 */     return this.capacity;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 141 */       return Fixnum.getInstance(this.elements.get(index));
/* 142 */     } catch (IndexOutOfBoundsException e) {
/* 143 */       badIndex(index, this.capacity);
/* 144 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 152 */       return this.elements.get(index);
/* 153 */     } catch (ArrayIndexOutOfBoundsException e) {
/* 154 */       badIndex(index, this.elements.limit());
/*     */       
/* 156 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 164 */       return Fixnum.getInstance(this.elements.get(index));
/* 165 */     } catch (IndexOutOfBoundsException e) {
/* 166 */       badIndex(index, this.elements.limit());
/* 167 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, int n) {
/*     */     try {
/* 174 */       this.elements.put(index, (char)n);
/* 175 */     } catch (IndexOutOfBoundsException e) {
/* 176 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/* 182 */     if (obj instanceof Fixnum) {
/*     */       try {
/* 184 */         this.elements.put(index, (char)((Fixnum)obj).value);
/* 185 */       } catch (ArrayIndexOutOfBoundsException e) {
/* 186 */         badIndex(index, this.capacity);
/*     */       } 
/*     */     } else {
/* 189 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 195 */     BasicVector_CharBuffer v = new BasicVector_CharBuffer(end - start);
/* 196 */     int i = start, j = 0;
/*     */     try {
/* 198 */       while (i < end) {
/* 199 */         v.elements.put(j++, this.elements.get(i++));
/*     */       }
/* 201 */       return v;
/* 202 */     } catch (IndexOutOfBoundsException e) {
/* 203 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 209 */     if (!(obj instanceof Fixnum)) {
/* 210 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 214 */     int n = ((Fixnum)obj).value;
/* 215 */     if (n < 0 || n > 65535) {
/* 216 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */       
/*     */       return;
/*     */     } 
/* 220 */     char m = (char)n;
/* 221 */     for (int i = this.capacity; i-- > 0;) {
/* 222 */       this.elements.put(i, m);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 232 */     if (n < length()) {
/* 233 */       this.elements.limit(n);
/* 234 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 237 */     if (n == this.capacity) {
/*     */       return;
/*     */     }
/* 240 */     Lisp.error(new LispError("End of native shrink routine:  shouldn't be reachable."));
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 245 */     BasicVector_CharBuffer result = new BasicVector_CharBuffer(this.capacity);
/*     */     
/* 247 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--) {
/* 248 */       result.elements.put(i, this.elements.get(j));
/*     */     }
/* 250 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 255 */     int i = 0;
/* 256 */     int j = this.capacity - 1;
/* 257 */     while (i < j) {
/* 258 */       char temp = this.elements.get(i);
/* 259 */       this.elements.put(i, this.elements.get(j));
/* 260 */       this.elements.put(j, temp);
/* 261 */       i++;
/* 262 */       j--;
/*     */     } 
/* 264 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 271 */     if (initialContents != null) {
/* 272 */       LispObject[] newElements = new LispObject[newCapacity];
/* 273 */       if (initialContents.listp()) {
/* 274 */         LispObject list = initialContents;
/* 275 */         for (int i = 0; i < newCapacity; i++) {
/* 276 */           newElements[i] = list.car();
/* 277 */           list = list.cdr();
/*     */         } 
/* 279 */       } else if (initialContents.vectorp()) {
/* 280 */         for (int i = 0; i < newCapacity; i++)
/* 281 */           newElements[i] = initialContents.elt(i); 
/*     */       } else {
/* 283 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 284 */       }  return new BasicVector_CharBuffer(newElements, this.directAllocation);
/*     */     } 
/* 286 */     if (this.capacity != newCapacity) {
/* 287 */       LispObject[] newElements = new LispObject[newCapacity];
/* 288 */       System.arraycopy(this.elements.array(), 0, newElements, 0, 
/* 289 */           Math.min(this.capacity, newCapacity));
/* 290 */       if (initialElement != null)
/* 291 */         for (int i = this.capacity; i < newCapacity; i++) {
/* 292 */           newElements[i] = initialElement;
/*     */         } 
/* 294 */       return new BasicVector_CharBuffer(newElements, this.directAllocation);
/*     */     } 
/*     */     
/* 297 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 304 */     return new ComplexVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BasicVector_CharBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */