/*     */ package org.armedbear.lisp;
/*     */ 
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
/*     */ 
/*     */ public final class ComplexArray_ByteBuffer
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private int totalSize;
/*     */   private ByteBuffer data;
/*     */   private boolean directAllocation;
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv) {
/*  54 */     this(dimv, false);
/*     */   }
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv, boolean directAllocation) {
/*  58 */     this.dimv = dimv;
/*  59 */     this.directAllocation = directAllocation;
/*  60 */     this.totalSize = computeTotalSize(dimv);
/*  61 */     if (directAllocation) {
/*  62 */       this.data = ByteBuffer.allocateDirect(this.totalSize);
/*     */     } else {
/*  64 */       this.data = ByteBuffer.allocate(this.totalSize);
/*     */     } 
/*     */   }
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv, LispObject initialContents) {
/*  69 */     this(dimv, initialContents, false);
/*     */   }
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv, LispObject initialContents, boolean directAllocation) {
/*  73 */     this.dimv = dimv;
/*  74 */     int rank = dimv.length;
/*  75 */     LispObject rest = initialContents;
/*  76 */     this.directAllocation = directAllocation;
/*  77 */     for (int i = 0; i < rank; i++) {
/*  78 */       dimv[i] = rest.length();
/*  79 */       rest = rest.elt(0);
/*     */     } 
/*  81 */     this.totalSize = computeTotalSize(dimv);
/*  82 */     if (directAllocation) {
/*  83 */       this.data = ByteBuffer.allocateDirect(this.totalSize);
/*     */     } else {
/*  85 */       this.data = ByteBuffer.allocate(this.totalSize);
/*     */     } 
/*  87 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv, AbstractArray array, int displacement) {
/*  91 */     this(dimv, array, displacement, false);
/*     */   }
/*     */   
/*     */   public ComplexArray_ByteBuffer(int[] dimv, AbstractArray array, int displacement, boolean directAllocation) {
/*  95 */     this.dimv = dimv;
/*  96 */     this.array = array;
/*  97 */     this.displacement = displacement;
/*  98 */     this.directAllocation = directAllocation;
/*  99 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 106 */     if (dims.length == 0) {
/*     */       try {
/* 108 */         this.data.put(index, Lisp.coerceToJavaByte(contents));
/*     */       }
/* 110 */       catch (IndexOutOfBoundsException e) {
/* 111 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 112 */         return -1;
/*     */       } 
/* 114 */       index++;
/*     */     } else {
/* 116 */       int dim = dims[0];
/* 117 */       if (dim != contents.length()) {
/* 118 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 119 */         return -1;
/*     */       } 
/* 121 */       int[] newDims = new int[dims.length - 1]; int i;
/* 122 */       for (i = 1; i < dims.length; i++)
/* 123 */         newDims[i - 1] = dims[i]; 
/* 124 */       if (contents.listp()) {
/* 125 */         for (i = contents.length(); i-- > 0; ) {
/* 126 */           LispObject content = contents.car();
/*     */           
/* 128 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 129 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 132 */         AbstractVector v = Lisp.checkVector(contents);
/* 133 */         int length = v.length();
/* 134 */         for (int j = 0; j < length; j++) {
/* 135 */           LispObject content = v.AREF(j);
/*     */           
/* 137 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 141 */     return index;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 147 */     return Lisp.list(Symbol.ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 153 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 159 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 165 */     LispObject result = Lisp.NIL;
/* 166 */     for (int i = this.dimv.length; i-- > 0;)
/* 167 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 168 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 175 */       return this.dimv[n];
/*     */     }
/* 177 */     catch (ArrayIndexOutOfBoundsException e) {
/* 178 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 179 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 186 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 192 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 199 */     if (this.array != null) {
/* 200 */       value1 = this.array;
/* 201 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 203 */       value1 = Lisp.NIL;
/* 204 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 206 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 212 */     if (this.data != null) {
/*     */       try {
/* 214 */         return Lisp.coerceFromJavaByte(this.data.get(index));
/*     */       }
/* 216 */       catch (IndexOutOfBoundsException e) {
/* 217 */         return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     }
/* 220 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 226 */     if (this.data != null) {
/*     */       try {
/* 228 */         this.data.put(index, Lisp.coerceToJavaByte(newValue));
/*     */       }
/* 230 */       catch (IndexOutOfBoundsException e) {
/* 231 */         Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     } else {
/* 234 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 240 */     if (!(obj instanceof Fixnum)) {
/* 241 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 245 */     int n = ((Fixnum)obj).value;
/* 246 */     if (n < 0 || n > 255) {
/* 247 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 251 */     if (this.data != null) {
/* 252 */       for (int i = this.data.limit(); i-- > 0;)
/* 253 */         this.data.put(i, (byte)n); 
/*     */     } else {
/* 255 */       for (int i = this.totalSize; i-- > 0;) {
/* 256 */         aset(i, obj);
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 263 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 264 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 266 */       return null;
/*     */     } 
/* 268 */     return printObject(this.dimv);
/*     */   }
/*     */   
/*     */   int arrayTotalSize(int[] dims) {
/* 272 */     int result = 0;
/* 273 */     for (int dim : dims) {
/* 274 */       result += dim;
/*     */     }
/* 276 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public static void fill(ByteBuffer buffer, byte value) {
/* 281 */     for (int i = 0; i < buffer.limit(); i++) {
/* 282 */       buffer.put(i, value);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 291 */     if (isAdjustable()) {
/* 292 */       if (initialContents != null) {
/* 293 */         setInitialContents(0, dims, initialContents, 0);
/*     */       } else {
/*     */         ByteBuffer newBuffer;
/*     */ 
/*     */ 
/*     */         
/* 299 */         if (this.directAllocation) {
/* 300 */           newBuffer = ByteBuffer.allocateDirect(computeTotalSize(dims));
/*     */         } else {
/* 302 */           newBuffer = ByteBuffer.allocate(computeTotalSize(dims));
/*     */         } 
/* 304 */         if (initialElement != null) {
/* 305 */           fill(newBuffer, Lisp.coerceToJavaByte(initialElement));
/*     */         }
/* 307 */         this.data = newBuffer;
/*     */         
/* 309 */         for (int i = 0; i < dims.length; i++)
/* 310 */           this.dimv[i] = dims[i]; 
/*     */       } 
/* 312 */       return this;
/*     */     } 
/* 314 */     if (initialContents != null) {
/* 315 */       return new ComplexArray_ByteBuffer(dims, initialContents);
/*     */     }
/* 317 */     ComplexArray_ByteBuffer newArray = new ComplexArray_ByteBuffer(dims);
/* 318 */     if (initialElement != null)
/* 319 */       newArray.fill(initialElement); 
/* 320 */     return newArray;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 330 */     if (isAdjustable()) {
/* 331 */       for (int i = 0; i < dims.length; i++) {
/* 332 */         this.dimv[i] = dims[i];
/*     */       }
/* 334 */       this.data = null;
/* 335 */       this.array = displacedTo;
/* 336 */       this.displacement = displacement;
/* 337 */       this.totalSize = computeTotalSize(dims);
/*     */       
/* 339 */       return this;
/*     */     } 
/* 341 */     ComplexArray_ByteBuffer a = new ComplexArray_ByteBuffer(dims, displacedTo, displacement);
/*     */     
/* 343 */     return a;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexArray_ByteBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */