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
/*     */ public final class ComplexArray_UnsignedByte32
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private int totalSize;
/*     */   private LispObject[] data;
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexArray_UnsignedByte32(int[] dimv) {
/*  53 */     this.dimv = dimv;
/*  54 */     this.totalSize = computeTotalSize(dimv);
/*  55 */     this.data = new LispObject[this.totalSize];
/*  56 */     for (int i = this.totalSize; i-- > 0;) {
/*  57 */       this.data[i] = Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray_UnsignedByte32(int[] dimv, LispObject initialContents) {
/*  63 */     this.dimv = dimv;
/*  64 */     int rank = dimv.length;
/*  65 */     LispObject rest = initialContents;
/*  66 */     for (int i = 0; i < rank; i++) {
/*  67 */       dimv[i] = rest.length();
/*  68 */       rest = rest.elt(0);
/*     */     } 
/*  70 */     this.totalSize = computeTotalSize(dimv);
/*  71 */     this.data = new LispObject[this.totalSize];
/*  72 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexArray_UnsignedByte32(int[] dimv, AbstractArray array, int displacement) {
/*  78 */     this.dimv = dimv;
/*  79 */     this.array = array;
/*  80 */     this.displacement = displacement;
/*  81 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/*  88 */     if (dims.length == 0) {
/*     */       try {
/*  90 */         this.data[index] = contents;
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
/* 129 */     return Lisp.list(Symbol.ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_32, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 135 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 141 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 147 */     LispObject result = Lisp.NIL;
/* 148 */     for (int i = this.dimv.length; i-- > 0;)
/* 149 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 150 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 157 */       return this.dimv[n];
/*     */     }
/* 159 */     catch (ArrayIndexOutOfBoundsException e) {
/* 160 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 161 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 168 */     return Lisp.UNSIGNED_BYTE_32;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 174 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 181 */     if (this.array != null) {
/* 182 */       value1 = this.array;
/* 183 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 185 */       value1 = Lisp.NIL;
/* 186 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 188 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 194 */     if (this.data != null) {
/*     */       try {
/* 196 */         return this.data[index];
/*     */       }
/* 198 */       catch (ArrayIndexOutOfBoundsException e) {
/* 199 */         return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     }
/* 202 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 208 */     if (this.data != null) {
/*     */       try {
/* 210 */         this.data[index] = newValue;
/*     */       }
/* 212 */       catch (ArrayIndexOutOfBoundsException e) {
/* 213 */         Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     } else {
/* 216 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 222 */     if (!(obj instanceof LispInteger)) {
/* 223 */       Lisp.type_error(obj, Symbol.INTEGER);
/*     */       
/*     */       return;
/*     */     } 
/* 227 */     if (obj.isLessThan(Fixnum.ZERO) || obj.isGreaterThan(Lisp.UNSIGNED_BYTE_32_MAX_VALUE)) {
/* 228 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_32);
/*     */     }
/* 230 */     if (this.data != null) {
/* 231 */       for (int i = this.data.length; i-- > 0;)
/* 232 */         this.data[i] = obj; 
/*     */     } else {
/* 234 */       for (int i = this.totalSize; i-- > 0;) {
/* 235 */         aset(i, obj);
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 242 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 251 */     if (isAdjustable()) {
/* 252 */       if (initialContents != null) {
/* 253 */         setInitialContents(0, dims, initialContents, 0);
/*     */       }
/*     */       else {
/*     */         
/* 257 */         SimpleArray_UnsignedByte32 tempArray = new SimpleArray_UnsignedByte32(dims);
/* 258 */         if (initialElement != null)
/* 259 */           tempArray.fill(initialElement); 
/* 260 */         SimpleArray_UnsignedByte32.copyArray(this, tempArray);
/* 261 */         this.data = tempArray.data;
/*     */         
/* 263 */         for (int i = 0; i < dims.length; i++)
/* 264 */           this.dimv[i] = dims[i]; 
/*     */       } 
/* 266 */       return this;
/*     */     } 
/* 268 */     if (initialContents != null) {
/* 269 */       return new ComplexArray_UnsignedByte32(dims, initialContents);
/*     */     }
/* 271 */     ComplexArray_UnsignedByte32 newArray = new ComplexArray_UnsignedByte32(dims);
/* 272 */     if (initialElement != null)
/* 273 */       newArray.fill(initialElement); 
/* 274 */     return newArray;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 284 */     if (isAdjustable()) {
/* 285 */       for (int i = 0; i < dims.length; i++) {
/* 286 */         this.dimv[i] = dims[i];
/*     */       }
/* 288 */       this.data = null;
/* 289 */       this.array = displacedTo;
/* 290 */       this.displacement = displacement;
/* 291 */       this.totalSize = computeTotalSize(dims);
/*     */       
/* 293 */       return this;
/*     */     } 
/* 295 */     ComplexArray_UnsignedByte32 a = new ComplexArray_UnsignedByte32(dims, displacedTo, displacement);
/*     */     
/* 297 */     return a;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexArray_UnsignedByte32.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */