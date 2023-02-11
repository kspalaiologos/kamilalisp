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
/*     */ public final class SimpleArray_UnsignedByte8
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   final byte[] data;
/*     */   
/*     */   public SimpleArray_UnsignedByte8(int[] dimv) {
/*  46 */     this.dimv = dimv;
/*  47 */     this.totalSize = computeTotalSize(dimv);
/*  48 */     this.data = new byte[this.totalSize];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte8(int[] dimv, LispObject initialContents) {
/*  54 */     this.dimv = dimv;
/*  55 */     int rank = dimv.length;
/*  56 */     LispObject rest = initialContents;
/*  57 */     for (int i = 0; i < rank; i++) {
/*  58 */       dimv[i] = rest.length();
/*  59 */       rest = rest.elt(0);
/*     */     } 
/*  61 */     this.totalSize = computeTotalSize(dimv);
/*  62 */     this.data = new byte[this.totalSize];
/*  63 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleArray_UnsignedByte8(int rank, LispObject initialContents) {
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
/*  80 */     this.data = new byte[this.totalSize];
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
/* 129 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, getDimensions() });
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
/* 178 */     return Lisp.UNSIGNED_BYTE_8;
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
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 197 */       return Lisp.coerceFromJavaByte(this.data[index]);
/*     */     }
/* 199 */     catch (ArrayIndexOutOfBoundsException e) {
/* 200 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 208 */       this.data[index] = Lisp.coerceToJavaByte(newValue);
/*     */     }
/* 210 */     catch (ArrayIndexOutOfBoundsException e) {
/* 211 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 218 */     int rank = this.dimv.length;
/* 219 */     if (rank != subscripts.length) {
/* 220 */       StringBuffer sb = new StringBuffer("Wrong number of subscripts (");
/* 221 */       sb.append(subscripts.length);
/* 222 */       sb.append(") for array of rank ");
/* 223 */       sb.append(rank);
/* 224 */       sb.append('.');
/* 225 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 227 */     int sum = 0;
/* 228 */     int size = 1;
/* 229 */     for (int i = rank; i-- > 0; ) {
/* 230 */       int dim = this.dimv[i];
/* 231 */       int lastSize = size;
/* 232 */       size *= dim;
/* 233 */       int n = subscripts[i];
/* 234 */       if (n < 0 || n >= dim) {
/* 235 */         StringBuffer sb = new StringBuffer("Invalid index ");
/* 236 */         sb.append(n);
/* 237 */         sb.append(" for array ");
/* 238 */         sb.append(this);
/* 239 */         sb.append('.');
/* 240 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 242 */       sum += n * lastSize;
/*     */     } 
/* 244 */     return sum;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 251 */       return Lisp.coerceFromJavaByte(this.data[getRowMajorIndex(subscripts)]);
/*     */     }
/* 253 */     catch (ArrayIndexOutOfBoundsException e) {
/* 254 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 255 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/*     */     try {
/* 264 */       this.data[getRowMajorIndex(subscripts)] = Lisp.coerceToJavaByte(newValue);
/*     */     }
/* 266 */     catch (ArrayIndexOutOfBoundsException e) {
/* 267 */       Lisp.error(new TypeError("Bad row major index " + 
/* 268 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 275 */     if (!(obj instanceof Fixnum)) {
/* 276 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 280 */     int n = ((Fixnum)obj).value;
/* 281 */     if (n < 0 || n > 255) {
/* 282 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 286 */     for (int i = this.totalSize; i-- > 0;) {
/* 287 */       this.data[i] = (byte)n;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 293 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 294 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 296 */       return null;
/*     */     } 
/* 298 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 305 */     if (initialContents != null)
/* 306 */       return new SimpleArray_UnsignedByte8(dimv, initialContents); 
/* 307 */     for (int i = 0; i < dimv.length; i++) {
/* 308 */       if (dimv[i] != this.dimv[i]) {
/* 309 */         SimpleArray_UnsignedByte8 newArray = new SimpleArray_UnsignedByte8(dimv);
/*     */         
/* 311 */         if (initialElement != null)
/* 312 */           newArray.fill(initialElement); 
/* 313 */         copyArray(this, newArray);
/* 314 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 318 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 325 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 326 */     int[] subscripts = new int[a1.getRank()];
/* 327 */     int axis = 0;
/* 328 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 335 */     if (axis < subscripts.length) {
/*     */       
/* 337 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 338 */       for (int i = 0; i < limit; i++) {
/* 339 */         subscripts[axis] = i;
/* 340 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 343 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 344 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 345 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 352 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_UnsignedByte8.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */