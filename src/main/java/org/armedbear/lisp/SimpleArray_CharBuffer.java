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
/*     */ 
/*     */ public final class SimpleArray_CharBuffer
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   final CharBuffer data;
/*     */   boolean directAllocation;
/*     */   
/*     */   public SimpleArray_CharBuffer(int[] dimv) {
/*  50 */     this(dimv, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_CharBuffer(int[] dimv, boolean directAllocation) {
/*  54 */     this.dimv = dimv;
/*  55 */     this.totalSize = computeTotalSize(dimv);
/*  56 */     this.directAllocation = directAllocation;
/*  57 */     if (directAllocation) {
/*  58 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 2);
/*  59 */       this.data = b.asCharBuffer();
/*     */     } else {
/*  61 */       this.data = CharBuffer.allocate(this.totalSize);
/*     */     } 
/*     */   }
/*     */   
/*     */   public SimpleArray_CharBuffer(int[] dimv, LispObject initialContents) {
/*  66 */     this(dimv, initialContents, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_CharBuffer(int[] dimv, LispObject initialContents, boolean directAllocation) {
/*  70 */     this.dimv = dimv;
/*  71 */     int rank = dimv.length;
/*  72 */     LispObject rest = initialContents;
/*  73 */     for (int i = 0; i < rank; i++) {
/*  74 */       dimv[i] = rest.length();
/*  75 */       rest = rest.elt(0);
/*     */     } 
/*  77 */     this.directAllocation = directAllocation;
/*  78 */     this.totalSize = computeTotalSize(dimv);
/*  79 */     if (directAllocation) {
/*  80 */       ByteBuffer b = ByteBuffer.allocate(this.totalSize * 2);
/*  81 */       this.data = b.asCharBuffer();
/*     */     } else {
/*  83 */       this.data = CharBuffer.allocate(this.totalSize);
/*     */     } 
/*  85 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */   
/*     */   public SimpleArray_CharBuffer(int rank, LispObject initialContents) {
/*  89 */     this(rank, initialContents, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_CharBuffer(int rank, LispObject initialContents, boolean directAllocation) {
/*  93 */     if (rank < 2) {
/*  94 */       Debug.assertTrue(false);
/*     */     }
/*  96 */     this.dimv = new int[rank];
/*  97 */     LispObject rest = initialContents;
/*  98 */     for (int i = 0; i < rank; i++) {
/*  99 */       this.dimv[i] = rest.length();
/* 100 */       if (rest == Lisp.NIL || rest.length() == 0) {
/*     */         break;
/*     */       }
/* 103 */       rest = rest.elt(0);
/*     */     } 
/* 105 */     this.directAllocation = directAllocation;
/* 106 */     this.totalSize = computeTotalSize(this.dimv);
/* 107 */     if (directAllocation) {
/* 108 */       ByteBuffer b = ByteBuffer.allocateDirect(this.totalSize * 2);
/* 109 */       this.data = b.asCharBuffer();
/*     */     } else {
/* 111 */       this.data = CharBuffer.allocate(this.totalSize);
/*     */     } 
/* 113 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 118 */     if (dims.length == 0) {
/*     */       try {
/* 120 */         this.data.put(index, Lisp.coerceToJavaChar(contents));
/* 121 */       } catch (IndexOutOfBoundsException e) {
/* 122 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 123 */         return -1;
/*     */       } 
/* 125 */       index++;
/*     */     } else {
/* 127 */       int dim = dims[0];
/* 128 */       if (dim != contents.length()) {
/* 129 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 130 */         return -1;
/*     */       } 
/* 132 */       int[] newDims = new int[dims.length - 1]; int i;
/* 133 */       for (i = 1; i < dims.length; i++) {
/* 134 */         newDims[i - 1] = dims[i];
/*     */       }
/* 136 */       if (contents.listp()) {
/* 137 */         for (i = contents.length(); i-- > 0; ) {
/* 138 */           LispObject content = contents.car();
/*     */           
/* 140 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 141 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 144 */         AbstractVector v = Lisp.checkVector(contents);
/* 145 */         int length = v.length();
/* 146 */         for (int j = 0; j < length; j++) {
/* 147 */           LispObject content = v.AREF(j);
/*     */           
/* 149 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 153 */     return index;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 158 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_16, getDimensions() });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 163 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 168 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 169 */       return Lisp.T; 
/* 170 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 171 */       return Lisp.T; 
/* 172 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 177 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 182 */     LispObject result = Lisp.NIL;
/* 183 */     for (int i = this.dimv.length; i-- > 0;) {
/* 184 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result);
/*     */     }
/* 186 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 192 */       return this.dimv[n];
/*     */     }
/* 194 */     catch (ArrayIndexOutOfBoundsException e) {
/* 195 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 196 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 202 */     return Lisp.UNSIGNED_BYTE_16;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 207 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 212 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 218 */       return this.data.get(index);
/* 219 */     } catch (IndexOutOfBoundsException e) {
/* 220 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       
/* 222 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 229 */       return Fixnum.getInstance(this.data.get(index));
/*     */     }
/* 231 */     catch (IndexOutOfBoundsException e) {
/* 232 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/*     */     try {
/* 239 */       this.data.put(index, (char)Fixnum.getValue(obj));
/*     */     }
/* 241 */     catch (IndexOutOfBoundsException e) {
/* 242 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 248 */     int rank = this.dimv.length;
/* 249 */     if (rank != subscripts.length) {
/* 250 */       StringBuffer sb = new StringBuffer("Wrong number of subscripts (");
/* 251 */       sb.append(subscripts.length);
/* 252 */       sb.append(") for array of rank ");
/* 253 */       sb.append(rank);
/* 254 */       sb.append('.');
/* 255 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 257 */     int sum = 0;
/* 258 */     int size = 1;
/* 259 */     for (int i = rank; i-- > 0; ) {
/* 260 */       int dim = this.dimv[i];
/* 261 */       int lastSize = size;
/* 262 */       size *= dim;
/* 263 */       int n = subscripts[i];
/* 264 */       if (n < 0 || n >= dim) {
/* 265 */         StringBuffer sb = new StringBuffer("Invalid index ");
/* 266 */         sb.append(n);
/* 267 */         sb.append(" for array ");
/* 268 */         sb.append(this);
/* 269 */         sb.append('.');
/* 270 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 272 */       sum += n * lastSize;
/*     */     } 
/* 274 */     return sum;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 280 */       return Fixnum.getInstance(this.data.get(getRowMajorIndex(subscripts)));
/* 281 */     } catch (IndexOutOfBoundsException e) {
/* 282 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 283 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject obj) {
/*     */     try {
/* 290 */       this.data.put(getRowMajorIndex(subscripts), (char)Fixnum.getValue(obj));
/* 291 */     } catch (ArrayIndexOutOfBoundsException e) {
/* 292 */       Lisp.error(new TypeError("Bad row major index " + 
/* 293 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 299 */     if (!(obj instanceof Fixnum)) {
/* 300 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 304 */     int n = ((Fixnum)obj).value;
/* 305 */     if (n < 0 || n > 65535) {
/* 306 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */       
/*     */       return;
/*     */     } 
/* 310 */     for (int i = this.totalSize; i-- > 0;) {
/* 311 */       this.data.put(i, (char)n);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 317 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 318 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 320 */       return null;
/*     */     } 
/* 322 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 327 */     if (initialContents != null) {
/* 328 */       return new SimpleArray_CharBuffer(dimv, initialContents);
/*     */     }
/* 330 */     for (int i = 0; i < dimv.length; i++) {
/* 331 */       if (dimv[i] != this.dimv[i]) {
/* 332 */         SimpleArray_CharBuffer newArray = new SimpleArray_CharBuffer(dimv);
/* 333 */         if (initialElement != null) {
/* 334 */           newArray.fill(initialElement);
/*     */         }
/* 336 */         copyArray(this, newArray);
/* 337 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 341 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   private static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 346 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 347 */     int[] subscripts = new int[a1.getRank()];
/* 348 */     int axis = 0;
/* 349 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 354 */     if (axis < subscripts.length) {
/*     */       
/* 356 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 357 */       for (int i = 0; i < limit; i++) {
/* 358 */         subscripts[axis] = i;
/* 359 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 362 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 363 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 364 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 370 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_CharBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */