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
/*     */ public final class SimpleArray_T
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final LispObject elementType;
/*     */   private final int totalSize;
/*     */   final LispObject[] data;
/*     */   
/*     */   public SimpleArray_T(int[] dimv, LispObject elementType) {
/*  47 */     this.dimv = dimv;
/*  48 */     this.elementType = elementType;
/*  49 */     this.totalSize = computeTotalSize(dimv);
/*  50 */     this.data = new LispObject[this.totalSize];
/*  51 */     for (int i = this.totalSize; i-- > 0;) {
/*  52 */       this.data[i] = Fixnum.ZERO;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_T(int[] dimv, LispObject elementType, LispObject initialContents) {
/*  60 */     this.dimv = dimv;
/*  61 */     this.elementType = elementType;
/*  62 */     int rank = dimv.length;
/*  63 */     LispObject rest = initialContents;
/*  64 */     for (int i = 0; i < rank; i++) {
/*     */       
/*  66 */       dimv[i] = rest.length();
/*  67 */       rest = rest.elt(0);
/*     */     } 
/*  69 */     this.totalSize = computeTotalSize(dimv);
/*  70 */     this.data = new LispObject[this.totalSize];
/*  71 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_T(int rank, LispObject initialContents) {
/*  77 */     if (rank < 2)
/*  78 */       Debug.assertTrue(false); 
/*  79 */     this.dimv = new int[rank];
/*  80 */     this.elementType = Lisp.T;
/*  81 */     LispObject rest = initialContents;
/*  82 */     for (int i = 0; i < rank; i++) {
/*     */       
/*  84 */       this.dimv[i] = rest.length();
/*  85 */       if (rest == Lisp.NIL || rest.length() == 0)
/*     */         break; 
/*  87 */       rest = rest.elt(0);
/*     */     } 
/*  89 */     this.totalSize = computeTotalSize(this.dimv);
/*  90 */     this.data = new LispObject[this.totalSize];
/*  91 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleArray_T(int[] dimv, LispObject[] initialData, LispObject elementType) {
/*  96 */     this.dimv = dimv;
/*  97 */     this.elementType = elementType;
/*  98 */     this.data = initialData;
/*  99 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 106 */     if (dims.length == 0) {
/*     */ 
/*     */       
/*     */       try {
/* 110 */         this.data[index] = contents;
/*     */       }
/* 112 */       catch (ArrayIndexOutOfBoundsException e) {
/*     */         
/* 114 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 115 */         return -1;
/*     */       } 
/* 117 */       index++;
/*     */     }
/*     */     else {
/*     */       
/* 121 */       int dim = dims[0];
/* 122 */       if (dim != contents.length()) {
/*     */         
/* 124 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 125 */         return -1;
/*     */       } 
/* 127 */       int[] newDims = new int[dims.length - 1]; int i;
/* 128 */       for (i = 1; i < dims.length; i++)
/* 129 */         newDims[i - 1] = dims[i]; 
/* 130 */       if (contents.listp()) {
/*     */         
/* 132 */         for (i = contents.length(); i-- > 0; )
/*     */         {
/* 134 */           LispObject content = contents.car();
/*     */           
/* 136 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 137 */           contents = contents.cdr();
/*     */         }
/*     */       
/*     */       } else {
/*     */         
/* 142 */         AbstractVector v = Lisp.checkVector(contents);
/* 143 */         int length = v.length();
/* 144 */         for (int j = 0; j < length; j++) {
/*     */           
/* 146 */           LispObject content = v.AREF(j);
/*     */           
/* 148 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 152 */     return index;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 158 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { this.elementType, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 164 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 170 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 171 */       return Lisp.T; 
/* 172 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 173 */       return Lisp.T; 
/* 174 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 180 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 186 */     LispObject result = Lisp.NIL;
/* 187 */     for (int i = this.dimv.length; i-- > 0;)
/* 188 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 189 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 197 */       return this.dimv[n];
/*     */     }
/* 199 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 201 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 202 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 209 */     return this.elementType;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 215 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 221 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 229 */       return this.data[index];
/*     */     }
/* 231 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 233 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 242 */       this.data[index] = newValue;
/*     */     }
/* 244 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 246 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 253 */     int rank = this.dimv.length;
/* 254 */     if (rank != subscripts.length) {
/*     */       
/* 256 */       StringBuilder sb = new StringBuilder("Wrong number of subscripts (");
/* 257 */       sb.append(subscripts.length);
/* 258 */       sb.append(") for array of rank ");
/* 259 */       sb.append(rank);
/* 260 */       sb.append('.');
/* 261 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 263 */     int sum = 0;
/* 264 */     int size = 1;
/* 265 */     for (int i = rank; i-- > 0; ) {
/*     */       
/* 267 */       int dim = this.dimv[i];
/* 268 */       int lastSize = size;
/* 269 */       size *= dim;
/* 270 */       int n = subscripts[i];
/* 271 */       if (n < 0 || n >= dim) {
/*     */         
/* 273 */         StringBuilder sb = new StringBuilder("Invalid index ");
/* 274 */         sb.append(n);
/* 275 */         sb.append(" for array ");
/* 276 */         sb.append(this);
/* 277 */         sb.append('.');
/* 278 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 280 */       sum += n * lastSize;
/*     */     } 
/* 282 */     return sum;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 290 */       return this.data[getRowMajorIndex(subscripts)];
/*     */     }
/* 292 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 294 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 295 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/*     */     try {
/* 305 */       this.data[getRowMajorIndex(subscripts)] = newValue;
/*     */     }
/* 307 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 309 */       Lisp.error(new TypeError("Bad row major index " + 
/* 310 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 317 */     for (int i = this.totalSize; i-- > 0;) {
/* 318 */       this.data[i] = obj;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 324 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 332 */     if (initialContents != null)
/* 333 */       return new SimpleArray_T(dimv, this.elementType, initialContents); 
/* 334 */     for (int i = 0; i < dimv.length; i++) {
/*     */       
/* 336 */       if (dimv[i] != this.dimv[i]) {
/*     */         
/* 338 */         SimpleArray_T newArray = new SimpleArray_T(dimv, this.elementType);
/* 339 */         if (initialElement != null)
/* 340 */           newArray.fill(initialElement); 
/* 341 */         copyArray(this, newArray);
/* 342 */         return newArray;
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/* 347 */     return new SimpleArray_T(dimv, (LispObject[])this.data.clone(), this.elementType);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 354 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 355 */     int[] subscripts = new int[a1.getRank()];
/* 356 */     int axis = 0;
/* 357 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 364 */     if (axis < subscripts.length) {
/*     */ 
/*     */       
/* 367 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 368 */       for (int i = 0; i < limit; i++)
/*     */       {
/* 370 */         subscripts[axis] = i;
/* 371 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       }
/*     */     
/*     */     } else {
/*     */       
/* 376 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 377 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 378 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 386 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_T.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */