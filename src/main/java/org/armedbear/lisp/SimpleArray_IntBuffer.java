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
/*     */ public final class SimpleArray_IntBuffer
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   final IntBuffer data;
/*     */   private boolean directAllocation;
/*     */   
/*     */   public SimpleArray_IntBuffer(int[] dimv) {
/*  50 */     this(dimv, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_IntBuffer(int[] dimv, boolean directAllocation) {
/*  54 */     this.dimv = dimv;
/*  55 */     this.directAllocation = directAllocation;
/*  56 */     this.totalSize = computeTotalSize(dimv);
/*  57 */     if (directAllocation) {
/*  58 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 4);
/*  59 */       this.data = b.asIntBuffer();
/*     */     } else {
/*  61 */       this.data = IntBuffer.allocate(this.totalSize);
/*     */     } 
/*     */   }
/*     */   
/*     */   public SimpleArray_IntBuffer(int[] dimv, LispObject initialContents) {
/*  66 */     this(dimv, initialContents, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_IntBuffer(int[] dimv, LispObject initialContents, boolean directAllocation) {
/*  70 */     this.dimv = dimv;
/*  71 */     int rank = dimv.length;
/*  72 */     this.directAllocation = directAllocation;
/*  73 */     LispObject rest = initialContents;
/*  74 */     for (int i = 0; i < rank; i++) {
/*  75 */       dimv[i] = rest.length();
/*  76 */       rest = rest.elt(0);
/*     */     } 
/*  78 */     this.totalSize = computeTotalSize(dimv);
/*  79 */     if (directAllocation) {
/*  80 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 4);
/*  81 */       this.data = b.asIntBuffer();
/*     */     } else {
/*  83 */       this.data = IntBuffer.allocate(this.totalSize);
/*     */     } 
/*     */     
/*  86 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */   
/*     */   public SimpleArray_IntBuffer(int rank, LispObject initialContents) {
/*  90 */     this(rank, initialContents, false);
/*     */   }
/*     */   public SimpleArray_IntBuffer(int rank, LispObject initialContents, boolean directAllocation) {
/*  93 */     if (rank < 2) {
/*  94 */       Debug.assertTrue(false);
/*     */     }
/*  96 */     this.dimv = new int[rank];
/*  97 */     LispObject rest = initialContents;
/*  98 */     for (int i = 0; i < rank; i++) {
/*  99 */       this.dimv[i] = rest.length();
/* 100 */       if (rest == Lisp.NIL || rest.length() == 0)
/*     */         break; 
/* 102 */       rest = rest.elt(0);
/*     */     } 
/* 104 */     this.totalSize = computeTotalSize(this.dimv);
/* 105 */     if (directAllocation) {
/* 106 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 4);
/* 107 */       this.data = b.asIntBuffer();
/*     */     } else {
/* 109 */       this.data = IntBuffer.allocate(this.totalSize);
/*     */     } 
/*     */     
/* 112 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 117 */     if (dims.length == 0) {
/*     */       try {
/* 119 */         this.data.put(index, (int)(contents.longValue() & 0xFFFFFFFFL));
/* 120 */       } catch (IndexOutOfBoundsException e) {
/* 121 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 122 */         return -1;
/*     */       } 
/* 124 */       index++;
/*     */     } else {
/* 126 */       int dim = dims[0];
/* 127 */       if (dim != contents.length()) {
/* 128 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 129 */         return -1;
/*     */       } 
/* 131 */       int[] newDims = new int[dims.length - 1]; int i;
/* 132 */       for (i = 1; i < dims.length; i++)
/* 133 */         newDims[i - 1] = dims[i]; 
/* 134 */       if (contents.listp()) {
/* 135 */         for (i = contents.length(); i-- > 0; ) {
/* 136 */           LispObject content = contents.car();
/*     */           
/* 138 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 139 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 142 */         AbstractVector v = Lisp.checkVector(contents);
/* 143 */         int length = v.length();
/* 144 */         for (int j = 0; j < length; j++) {
/* 145 */           LispObject content = v.AREF(j);
/*     */           
/* 147 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 151 */     return index;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 156 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, getDimensions() });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 161 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 166 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 167 */       return Lisp.T; 
/* 168 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 169 */       return Lisp.T; 
/* 170 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 175 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 180 */     LispObject result = Lisp.NIL;
/* 181 */     for (int i = this.dimv.length; i-- > 0;)
/* 182 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 183 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 189 */       return this.dimv[n];
/* 190 */     } catch (ArrayIndexOutOfBoundsException e) {
/* 191 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 192 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 198 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 203 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 208 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 214 */       return Lisp.number(this.data.get(index) & 0xFFFFFFFFL);
/* 215 */     } catch (IndexOutOfBoundsException e) {
/* 216 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 223 */       if (newValue.isLessThan(Fixnum.ZERO) || newValue.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 224 */         Lisp.type_error(newValue, Lisp.UNSIGNED_BYTE_32);
/*     */       }
/* 226 */       this.data.put(index, (int)(newValue.longValue() & 0xFFFFFFFFL));
/* 227 */     } catch (IndexOutOfBoundsException e) {
/* 228 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 234 */     int rank = this.dimv.length;
/* 235 */     if (rank != subscripts.length) {
/* 236 */       StringBuffer sb = new StringBuffer("Wrong number of subscripts (");
/* 237 */       sb.append(subscripts.length);
/* 238 */       sb.append(") for array of rank ");
/* 239 */       sb.append(rank);
/* 240 */       sb.append('.');
/* 241 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 243 */     int sum = 0;
/* 244 */     int size = 1;
/* 245 */     for (int i = rank; i-- > 0; ) {
/* 246 */       int dim = this.dimv[i];
/* 247 */       int lastSize = size;
/* 248 */       size *= dim;
/* 249 */       int n = subscripts[i];
/* 250 */       if (n < 0 || n >= dim) {
/* 251 */         StringBuffer sb = new StringBuffer("Invalid index ");
/* 252 */         sb.append(n);
/* 253 */         sb.append(" for array ");
/* 254 */         sb.append(this);
/* 255 */         sb.append('.');
/* 256 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 258 */       sum += n * lastSize;
/*     */     } 
/* 260 */     return sum;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 266 */       return Lisp.number(this.data.get(getRowMajorIndex(subscripts)) & 0xFFFFFFFFL);
/* 267 */     } catch (IndexOutOfBoundsException e) {
/* 268 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 269 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/*     */     try {
/* 276 */       if (newValue.isLessThan(Fixnum.ZERO) || newValue.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 277 */         Lisp.type_error(newValue, Lisp.UNSIGNED_BYTE_32);
/*     */       }
/* 279 */       this.data.put(getRowMajorIndex(subscripts), (int)(newValue.longValue() & 0xFFFFFFFFL));
/* 280 */     } catch (IndexOutOfBoundsException e) {
/* 281 */       Lisp.error(new TypeError("Bad row major index " + 
/* 282 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 288 */     if (!(obj instanceof LispInteger)) {
/* 289 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 293 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 294 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 296 */     for (int i = this.totalSize; i-- > 0;) {
/* 297 */       this.data.put(i, (int)(obj.longValue() & 0xFFFFFFFFL));
/*     */     }
/*     */   }
/*     */   
/*     */   public String printObject() {
/* 302 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 303 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 305 */       return null;
/*     */     } 
/* 307 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 312 */     if (initialContents != null) {
/* 313 */       return new SimpleArray_IntBuffer(dimv, initialContents);
/*     */     }
/* 315 */     for (int i = 0; i < dimv.length; i++) {
/* 316 */       if (dimv[i] != this.dimv[i]) {
/* 317 */         SimpleArray_IntBuffer newArray = new SimpleArray_IntBuffer(dimv, this.directAllocation);
/*     */         
/* 319 */         if (initialElement != null) {
/* 320 */           newArray.fill(initialElement);
/*     */         }
/* 322 */         copyArray(this, newArray);
/*     */         
/* 324 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 328 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 333 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 334 */     int[] subscripts = new int[a1.getRank()];
/* 335 */     int axis = 0;
/* 336 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 341 */     if (axis < subscripts.length) {
/*     */       
/* 343 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 344 */       for (int i = 0; i < limit; i++) {
/* 345 */         subscripts[axis] = i;
/* 346 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 349 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 350 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 351 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 357 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_IntBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */