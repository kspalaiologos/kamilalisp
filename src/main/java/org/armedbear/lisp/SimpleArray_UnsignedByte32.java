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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class SimpleArray_UnsignedByte32
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   final LispObject[] data;
/*     */   
/*     */   public SimpleArray_UnsignedByte32(int[] dimv) {
/*  74 */     this.dimv = dimv;
/*  75 */     this.totalSize = computeTotalSize(dimv);
/*  76 */     this.data = new LispObject[this.totalSize];
/*  77 */     for (int i = this.totalSize; i-- > 0;) {
/*  78 */       this.data[i] = Fixnum.ZERO;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte32(int[] dimv, LispObject initialContents) {
/*  84 */     this.dimv = dimv;
/*  85 */     int rank = dimv.length;
/*  86 */     LispObject rest = initialContents;
/*  87 */     for (int i = 0; i < rank; i++) {
/*  88 */       dimv[i] = rest.length();
/*  89 */       rest = rest.elt(0);
/*     */     } 
/*  91 */     this.totalSize = computeTotalSize(dimv);
/*  92 */     this.data = new LispObject[this.totalSize];
/*  93 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte32(int rank, LispObject initialContents) {
/*  99 */     if (rank < 2)
/* 100 */       Debug.assertTrue(false); 
/* 101 */     this.dimv = new int[rank];
/* 102 */     LispObject rest = initialContents;
/* 103 */     for (int i = 0; i < rank; i++) {
/* 104 */       this.dimv[i] = rest.length();
/* 105 */       if (rest == Lisp.NIL || rest.length() == 0)
/*     */         break; 
/* 107 */       rest = rest.elt(0);
/*     */     } 
/* 109 */     this.totalSize = computeTotalSize(this.dimv);
/* 110 */     this.data = new LispObject[this.totalSize];
/* 111 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 118 */     if (dims.length == 0) {
/*     */       try {
/* 120 */         this.data[index] = contents;
/*     */       }
/* 122 */       catch (ArrayIndexOutOfBoundsException e) {
/* 123 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 124 */         return -1;
/*     */       } 
/* 126 */       index++;
/*     */     } else {
/* 128 */       int dim = dims[0];
/* 129 */       if (dim != contents.length()) {
/* 130 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 131 */         return -1;
/*     */       } 
/* 133 */       int[] newDims = new int[dims.length - 1]; int i;
/* 134 */       for (i = 1; i < dims.length; i++)
/* 135 */         newDims[i - 1] = dims[i]; 
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
/*     */   
/*     */   public LispObject typeOf() {
/* 159 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 165 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 171 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 172 */       return Lisp.T; 
/* 173 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 174 */       return Lisp.T; 
/* 175 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 181 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 187 */     LispObject result = Lisp.NIL;
/* 188 */     for (int i = this.dimv.length; i-- > 0;)
/* 189 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 190 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 197 */       return this.dimv[n];
/*     */     }
/* 199 */     catch (ArrayIndexOutOfBoundsException e) {
/* 200 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 201 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 208 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 214 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 220 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 227 */       return this.data[index];
/*     */     }
/* 229 */     catch (ArrayIndexOutOfBoundsException e) {
/* 230 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 238 */       this.data[index] = newValue;
/*     */     }
/* 240 */     catch (ArrayIndexOutOfBoundsException e) {
/* 241 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
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
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 281 */       return this.data[getRowMajorIndex(subscripts)];
/*     */     }
/* 283 */     catch (ArrayIndexOutOfBoundsException e) {
/* 284 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 285 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/*     */     try {
/* 294 */       this.data[getRowMajorIndex(subscripts)] = newValue;
/*     */     }
/* 296 */     catch (ArrayIndexOutOfBoundsException e) {
/* 297 */       Lisp.error(new TypeError("Bad row major index " + 
/* 298 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 305 */     if (!(obj instanceof LispInteger)) {
/* 306 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 310 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 311 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 313 */     for (int i = this.totalSize; i-- > 0;) {
/* 314 */       this.data[i] = obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 320 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 321 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 323 */       return null;
/*     */     } 
/* 325 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 332 */     if (initialContents != null)
/* 333 */       return new SimpleArray_UnsignedByte32(dimv, initialContents); 
/* 334 */     for (int i = 0; i < dimv.length; i++) {
/* 335 */       if (dimv[i] != this.dimv[i]) {
/* 336 */         SimpleArray_UnsignedByte32 newArray = new SimpleArray_UnsignedByte32(dimv);
/*     */         
/* 338 */         if (initialElement != null)
/* 339 */           newArray.fill(initialElement); 
/* 340 */         copyArray(this, newArray);
/* 341 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 345 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 352 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 353 */     int[] subscripts = new int[a1.getRank()];
/* 354 */     int axis = 0;
/* 355 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 362 */     if (axis < subscripts.length) {
/*     */       
/* 364 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 365 */       for (int i = 0; i < limit; i++) {
/* 366 */         subscripts[axis] = i;
/* 367 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 370 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 371 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 372 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 379 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_UnsignedByte32.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */