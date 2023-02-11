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
/*     */ public final class ComplexArray
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final LispObject elementType;
/*     */   private int totalSize;
/*     */   private LispObject[] data;
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexArray(int[] dimv, LispObject elementType) {
/*  53 */     this.dimv = dimv;
/*  54 */     this.elementType = elementType;
/*  55 */     this.totalSize = computeTotalSize(dimv);
/*  56 */     this.data = new LispObject[this.totalSize];
/*  57 */     for (int i = this.totalSize; i-- > 0;) {
/*  58 */       this.data[i] = Fixnum.ZERO;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexArray(int[] dimv, LispObject elementType, LispObject initialContents) {
/*  66 */     this.dimv = dimv;
/*  67 */     this.elementType = elementType;
/*  68 */     int rank = dimv.length;
/*  69 */     LispObject rest = initialContents;
/*  70 */     for (int i = 0; i < rank; i++) {
/*  71 */       dimv[i] = rest.length();
/*  72 */       rest = rest.elt(0);
/*     */     } 
/*  74 */     this.totalSize = computeTotalSize(dimv);
/*  75 */     this.data = new LispObject[this.totalSize];
/*  76 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray(int[] dimv, AbstractArray array, int displacement) {
/*  81 */     this.dimv = dimv;
/*  82 */     this.elementType = array.getElementType();
/*  83 */     this.array = array;
/*  84 */     this.displacement = displacement;
/*  85 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/*  92 */     if (dims.length == 0) {
/*     */       try {
/*  94 */         this.data[index] = contents;
/*     */       }
/*  96 */       catch (ArrayIndexOutOfBoundsException e) {
/*  97 */         Lisp.error(new LispError("Bad initial contents for array."));
/*  98 */         return -1;
/*     */       } 
/* 100 */       index++;
/*     */     } else {
/* 102 */       int dim = dims[0];
/* 103 */       if (dim != contents.length()) {
/* 104 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 105 */         return -1;
/*     */       } 
/* 107 */       int[] newDims = new int[dims.length - 1]; int i;
/* 108 */       for (i = 1; i < dims.length; i++)
/* 109 */         newDims[i - 1] = dims[i]; 
/* 110 */       if (contents.listp()) {
/* 111 */         for (i = contents.length(); i-- > 0; ) {
/* 112 */           LispObject content = contents.car();
/*     */           
/* 114 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 115 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 118 */         AbstractVector v = Lisp.checkVector(contents);
/* 119 */         int length = v.length();
/* 120 */         for (int j = 0; j < length; j++) {
/* 121 */           LispObject content = v.AREF(j);
/*     */           
/* 123 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 127 */     return index;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 133 */     return Lisp.list(Symbol.ARRAY, new LispObject[] { this.elementType, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 139 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 145 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 151 */     LispObject result = Lisp.NIL;
/* 152 */     for (int i = this.dimv.length; i-- > 0;)
/* 153 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 154 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 161 */       return this.dimv[n];
/*     */     }
/* 163 */     catch (ArrayIndexOutOfBoundsException e) {
/* 164 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 165 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 172 */     return this.elementType;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 178 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 185 */     if (this.array != null) {
/* 186 */       value1 = this.array;
/* 187 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 189 */       value1 = Lisp.NIL;
/* 190 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 192 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 198 */     if (this.data != null) {
/*     */       try {
/* 200 */         return this.data[index];
/*     */       }
/* 202 */       catch (ArrayIndexOutOfBoundsException e) {
/* 203 */         return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     }
/* 206 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 212 */     if (this.data != null) {
/*     */       try {
/* 214 */         this.data[index] = newValue;
/*     */       }
/* 216 */       catch (ArrayIndexOutOfBoundsException e) {
/* 217 */         Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     } else {
/* 220 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 226 */     if (this.data != null) {
/* 227 */       for (int i = this.data.length; i-- > 0;)
/* 228 */         this.data[i] = obj; 
/*     */     } else {
/* 230 */       for (int i = this.totalSize; i-- > 0;) {
/* 231 */         aset(i, obj);
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 238 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 246 */     if (isAdjustable()) {
/* 247 */       if (initialContents != null) {
/* 248 */         setInitialContents(0, dims, initialContents, 0);
/*     */       }
/*     */       else {
/*     */         
/* 252 */         SimpleArray_T tempArray = new SimpleArray_T(dims, this.elementType);
/* 253 */         if (initialElement != null)
/* 254 */           tempArray.fill(initialElement); 
/* 255 */         SimpleArray_T.copyArray(this, tempArray);
/* 256 */         this.data = tempArray.data;
/*     */         
/* 258 */         for (int i = 0; i < dims.length; i++)
/* 259 */           this.dimv[i] = dims[i]; 
/*     */       } 
/* 261 */       return this;
/*     */     } 
/* 263 */     if (initialContents != null) {
/* 264 */       return new ComplexArray(dims, this.elementType, initialContents);
/*     */     }
/* 266 */     ComplexArray newArray = new ComplexArray(dims, this.elementType);
/* 267 */     if (initialElement != null)
/* 268 */       newArray.fill(initialElement); 
/* 269 */     return newArray;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 279 */     if (isAdjustable()) {
/* 280 */       for (int i = 0; i < dims.length; i++) {
/* 281 */         this.dimv[i] = dims[i];
/*     */       }
/* 283 */       this.data = null;
/* 284 */       this.array = displacedTo;
/* 285 */       this.displacement = displacement;
/* 286 */       this.totalSize = computeTotalSize(dims);
/*     */       
/* 288 */       return this;
/*     */     } 
/* 290 */     ComplexArray a = new ComplexArray(dims, displacedTo, displacement);
/*     */     
/* 292 */     return a;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexArray.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */