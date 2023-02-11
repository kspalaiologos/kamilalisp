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
/*     */ public final class SimpleArray_UnsignedByte16
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   private final int[] data;
/*     */   
/*     */   public SimpleArray_UnsignedByte16(int[] dimv) {
/*  46 */     this.dimv = dimv;
/*  47 */     this.totalSize = computeTotalSize(dimv);
/*  48 */     this.data = new int[this.totalSize];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte16(int[] dimv, LispObject initialContents) {
/*  54 */     this.dimv = dimv;
/*  55 */     int rank = dimv.length;
/*  56 */     LispObject rest = initialContents;
/*  57 */     for (int i = 0; i < rank; i++) {
/*  58 */       dimv[i] = rest.length();
/*  59 */       rest = rest.elt(0);
/*     */     } 
/*  61 */     this.totalSize = computeTotalSize(dimv);
/*  62 */     this.data = new int[this.totalSize];
/*  63 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte16(int rank, LispObject initialContents) {
/*  69 */     if (rank < 2)
/*  70 */       Debug.assertTrue(false); 
/*  71 */     this.dimv = new int[rank];
/*  72 */     LispObject rest = initialContents;
/*  73 */     for (int i = 0; i < rank; i++) {
/*  74 */       this.dimv[i] = rest.length();
/*  75 */       if (rest == Lisp.NIL || rest.length() == 0)
/*     */         break; 
/*  77 */       rest = rest.elt(0);
/*     */     } 
/*  79 */     this.totalSize = computeTotalSize(this.dimv);
/*  80 */     this.data = new int[this.totalSize];
/*  81 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/*  88 */     if (dims.length == 0) {
/*     */       try {
/*  90 */         this.data[index] = Lisp.coerceToJavaByte(contents);
/*     */       }
/*  92 */       catch (ArrayIndexOutOfBoundsException e) {
/*  93 */         Lisp.error(new LispError("Bad initial contents for array."));
/*  94 */         return -1;
/*     */       } 
/*  96 */       index++;
/*     */     } else {
/*  98 */       int dim = dims[0];
/*  99 */       if (dim != contents.length()) {
/* 100 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 101 */         return -1;
/*     */       } 
/* 103 */       int[] newDims = new int[dims.length - 1]; int i;
/* 104 */       for (i = 1; i < dims.length; i++)
/* 105 */         newDims[i - 1] = dims[i]; 
/* 106 */       if (contents.listp()) {
/* 107 */         for (i = contents.length(); i-- > 0; ) {
/* 108 */           LispObject content = contents.car();
/*     */           
/* 110 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 111 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 114 */         AbstractVector v = Lisp.checkVector(contents);
/* 115 */         int length = v.length();
/* 116 */         for (int j = 0; j < length; j++) {
/* 117 */           LispObject content = v.AREF(j);
/*     */           
/* 119 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 123 */     return index;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 129 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_16, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 135 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 141 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 142 */       return Lisp.T; 
/* 143 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 144 */       return Lisp.T; 
/* 145 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 151 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 157 */     LispObject result = Lisp.NIL;
/* 158 */     for (int i = this.dimv.length; i-- > 0;)
/* 159 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 160 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 167 */       return this.dimv[n];
/*     */     }
/* 169 */     catch (ArrayIndexOutOfBoundsException e) {
/* 170 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 171 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 178 */     return Lisp.UNSIGNED_BYTE_16;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 184 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 190 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int aref(int index) {
/*     */     try {
/* 197 */       return this.data[index];
/*     */     }
/* 199 */     catch (ArrayIndexOutOfBoundsException e) {
/* 200 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       
/* 202 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 210 */       return Fixnum.getInstance(this.data[index]);
/*     */     }
/* 212 */     catch (ArrayIndexOutOfBoundsException e) {
/* 213 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/*     */     try {
/* 221 */       this.data[index] = Fixnum.getValue(obj);
/*     */     }
/* 223 */     catch (ArrayIndexOutOfBoundsException e) {
/* 224 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 231 */     int rank = this.dimv.length;
/* 232 */     if (rank != subscripts.length) {
/* 233 */       StringBuffer sb = new StringBuffer("Wrong number of subscripts (");
/* 234 */       sb.append(subscripts.length);
/* 235 */       sb.append(") for array of rank ");
/* 236 */       sb.append(rank);
/* 237 */       sb.append('.');
/* 238 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 240 */     int sum = 0;
/* 241 */     int size = 1;
/* 242 */     for (int i = rank; i-- > 0; ) {
/* 243 */       int dim = this.dimv[i];
/* 244 */       int lastSize = size;
/* 245 */       size *= dim;
/* 246 */       int n = subscripts[i];
/* 247 */       if (n < 0 || n >= dim) {
/* 248 */         StringBuffer sb = new StringBuffer("Invalid index ");
/* 249 */         sb.append(n);
/* 250 */         sb.append(" for array ");
/* 251 */         sb.append(this);
/* 252 */         sb.append('.');
/* 253 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 255 */       sum += n * lastSize;
/*     */     } 
/* 257 */     return sum;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 264 */       return Fixnum.getInstance(this.data[getRowMajorIndex(subscripts)]);
/*     */     }
/* 266 */     catch (ArrayIndexOutOfBoundsException e) {
/* 267 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 268 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject obj) {
/*     */     try {
/* 277 */       this.data[getRowMajorIndex(subscripts)] = Fixnum.getValue(obj);
/*     */     }
/* 279 */     catch (ArrayIndexOutOfBoundsException e) {
/* 280 */       Lisp.error(new TypeError("Bad row major index " + 
/* 281 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 288 */     if (!(obj instanceof Fixnum)) {
/* 289 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 293 */     int n = ((Fixnum)obj).value;
/* 294 */     if (n < 0 || n > 65535) {
/* 295 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_16);
/*     */       
/*     */       return;
/*     */     } 
/* 299 */     for (int i = this.totalSize; i-- > 0;) {
/* 300 */       this.data[i] = n;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 306 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 307 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 309 */       return null;
/*     */     } 
/* 311 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 318 */     if (initialContents != null)
/* 319 */       return new SimpleArray_UnsignedByte16(dimv, initialContents); 
/* 320 */     for (int i = 0; i < dimv.length; i++) {
/* 321 */       if (dimv[i] != this.dimv[i]) {
/* 322 */         SimpleArray_UnsignedByte16 newArray = new SimpleArray_UnsignedByte16(dimv);
/*     */         
/* 324 */         if (initialElement != null)
/* 325 */           newArray.fill(initialElement); 
/* 326 */         copyArray(this, newArray);
/* 327 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 331 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 338 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 339 */     int[] subscripts = new int[a1.getRank()];
/* 340 */     int axis = 0;
/* 341 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 348 */     if (axis < subscripts.length) {
/*     */       
/* 350 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 351 */       for (int i = 0; i < limit; i++) {
/* 352 */         subscripts[axis] = i;
/* 353 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 356 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 357 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 358 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 365 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_UnsignedByte16.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */