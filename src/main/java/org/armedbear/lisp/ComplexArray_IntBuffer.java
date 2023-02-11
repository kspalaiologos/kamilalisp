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
/*     */ 
/*     */ 
/*     */ public final class ComplexArray_IntBuffer
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private int totalSize;
/*     */   private IntBuffer data;
/*     */   private boolean directAllocation;
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv) {
/*  55 */     this(dimv, false);
/*     */   }
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv, boolean directAllocation) {
/*  59 */     this.dimv = dimv;
/*  60 */     this.directAllocation = directAllocation;
/*  61 */     this.totalSize = computeTotalSize(dimv);
/*  62 */     if (directAllocation) {
/*  63 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 4);
/*  64 */       this.data = b.asIntBuffer();
/*     */     } else {
/*  66 */       this.data = IntBuffer.allocate(this.totalSize);
/*     */     } 
/*     */   }
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv, LispObject initialContents) {
/*  71 */     this(dimv, initialContents, false);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv, LispObject initialContents, boolean directAllocation) {
/*  76 */     this.dimv = dimv;
/*  77 */     this.directAllocation = directAllocation;
/*  78 */     int rank = dimv.length;
/*  79 */     LispObject rest = initialContents;
/*  80 */     for (int i = 0; i < rank; i++) {
/*  81 */       dimv[i] = rest.length();
/*  82 */       rest = rest.elt(0);
/*     */     } 
/*  84 */     this.totalSize = computeTotalSize(dimv);
/*  85 */     if (directAllocation) {
/*  86 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 4);
/*  87 */       this.data = b.asIntBuffer();
/*     */     } else {
/*  89 */       this.data = IntBuffer.allocate(this.totalSize);
/*     */     } 
/*  91 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv, AbstractArray array, int displacement) {
/*  96 */     this(dimv, array, displacement, false);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray_IntBuffer(int[] dimv, AbstractArray array, int displacement, boolean directAllocation) {
/* 101 */     this.dimv = dimv;
/* 102 */     this.array = array;
/* 103 */     this.displacement = displacement;
/* 104 */     this.directAllocation = directAllocation;
/* 105 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 110 */     if (dims.length == 0) {
/*     */       try {
/* 112 */         this.data.put(index, (int)(contents.longValue() & 0xFFFFFFFFL));
/* 113 */       } catch (IndexOutOfBoundsException e) {
/* 114 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 115 */         return -1;
/*     */       } 
/* 117 */       index++;
/*     */     } else {
/* 119 */       int dim = dims[0];
/* 120 */       if (dim != contents.length()) {
/* 121 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 122 */         return -1;
/*     */       } 
/* 124 */       int[] newDims = new int[dims.length - 1]; int i;
/* 125 */       for (i = 1; i < dims.length; i++) {
/* 126 */         newDims[i - 1] = dims[i];
/*     */       }
/* 128 */       if (contents.listp()) {
/* 129 */         for (i = contents.length(); i-- > 0; ) {
/* 130 */           LispObject content = contents.car();
/* 131 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 132 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 135 */         AbstractVector v = Lisp.checkVector(contents);
/* 136 */         int length = v.length();
/* 137 */         for (int j = 0; j < length; j++) {
/* 138 */           LispObject content = v.AREF(j);
/*     */           
/* 140 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 144 */     return index;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 149 */     return Lisp.list(Symbol.ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, getDimensions() });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 154 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 159 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 164 */     LispObject result = Lisp.NIL;
/* 165 */     for (int i = this.dimv.length; i-- > 0;) {
/* 166 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result);
/*     */     }
/* 168 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 174 */       return this.dimv[n];
/* 175 */     } catch (ArrayIndexOutOfBoundsException e) {
/* 176 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 177 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 183 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 188 */     return this.totalSize;
/*     */   }
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 194 */     if (this.array != null) {
/* 195 */       value1 = this.array;
/* 196 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 198 */       value1 = Lisp.NIL;
/* 199 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 201 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 206 */     if (this.data != null) {
/*     */       try {
/* 208 */         return Lisp.number(this.data.get(index) & 0xFFFFFFFFL);
/* 209 */       } catch (IndexOutOfBoundsException e) {
/* 210 */         return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     }
/* 213 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 218 */     if (this.data != null) {
/*     */       try {
/* 220 */         if (newValue.isLessThan(Fixnum.ZERO) || newValue.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 221 */           Lisp.type_error(newValue, Lisp.UNSIGNED_BYTE_32);
/*     */         }
/* 223 */         this.data.put(index, (int)(newValue.longValue() & 0xFFFFFFFFL));
/* 224 */       } catch (IndexOutOfBoundsException e) {
/* 225 */         Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     } else {
/* 228 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */   
/*     */   public void fill(LispObject obj) {
/* 233 */     if (!(obj instanceof LispInteger)) {
/* 234 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 238 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 239 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 241 */     if (this.data != null) {
/* 242 */       for (int i = this.data.limit(); i-- > 0;) {
/* 243 */         this.data.put(i, (int)(obj.longValue() & 0xFFFFFFFFL));
/*     */       }
/*     */     } else {
/* 246 */       for (int i = this.totalSize; i-- > 0;) {
/* 247 */         aset(i, obj);
/*     */       }
/*     */     } 
/*     */   }
/*     */   
/*     */   public String printObject() {
/* 253 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 260 */     if (isAdjustable()) {
/* 261 */       if (initialContents != null) {
/* 262 */         setInitialContents(0, dims, initialContents, 0);
/*     */       
/*     */       }
/*     */       else {
/*     */         
/* 267 */         SimpleArray_IntBuffer tempArray = new SimpleArray_IntBuffer(dims);
/* 268 */         if (initialElement != null) {
/* 269 */           tempArray.fill(initialElement);
/*     */         }
/* 271 */         SimpleArray_IntBuffer.copyArray(this, tempArray);
/* 272 */         this.data = tempArray.data;
/*     */         
/* 274 */         for (int i = 0; i < dims.length; i++) {
/* 275 */           this.dimv[i] = dims[i];
/*     */         }
/*     */       } 
/* 278 */       return this;
/*     */     } 
/* 280 */     if (initialContents != null) {
/* 281 */       return new ComplexArray_IntBuffer(dims, initialContents);
/*     */     }
/* 283 */     ComplexArray_IntBuffer newArray = new ComplexArray_IntBuffer(dims);
/* 284 */     if (initialElement != null) {
/* 285 */       newArray.fill(initialElement);
/*     */     }
/* 287 */     return newArray;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 296 */     if (isAdjustable()) {
/* 297 */       for (int i = 0; i < dims.length; i++) {
/* 298 */         this.dimv[i] = dims[i];
/*     */       }
/*     */       
/* 301 */       this.data = null;
/* 302 */       this.array = displacedTo;
/* 303 */       this.displacement = displacement;
/* 304 */       this.totalSize = computeTotalSize(dims);
/*     */       
/* 306 */       return this;
/*     */     } 
/* 308 */     ComplexArray_IntBuffer a = new ComplexArray_IntBuffer(dims, displacedTo, displacement);
/* 309 */     return a;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexArray_IntBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */