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
/*     */ public final class ComplexArray_UnsignedByte8
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private int totalSize;
/*     */   private byte[] data;
/*     */   private AbstractArray array;
/*     */   private int displacement;
/*     */   
/*     */   public ComplexArray_UnsignedByte8(int[] dimv) {
/*  52 */     this.dimv = dimv;
/*  53 */     this.totalSize = computeTotalSize(dimv);
/*  54 */     this.data = new byte[this.totalSize];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public ComplexArray_UnsignedByte8(int[] dimv, LispObject initialContents) {
/*  60 */     this.dimv = dimv;
/*  61 */     int rank = dimv.length;
/*  62 */     LispObject rest = initialContents;
/*  63 */     for (int i = 0; i < rank; i++) {
/*  64 */       dimv[i] = rest.length();
/*  65 */       rest = rest.elt(0);
/*     */     } 
/*  67 */     this.totalSize = computeTotalSize(dimv);
/*  68 */     this.data = new byte[this.totalSize];
/*  69 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexArray_UnsignedByte8(int[] dimv, AbstractArray array, int displacement) {
/*  74 */     this.dimv = dimv;
/*  75 */     this.array = array;
/*  76 */     this.displacement = displacement;
/*  77 */     this.totalSize = computeTotalSize(dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/*  84 */     if (dims.length == 0) {
/*     */       try {
/*  86 */         this.data[index] = Lisp.coerceToJavaByte(contents);
/*     */       }
/*  88 */       catch (ArrayIndexOutOfBoundsException e) {
/*  89 */         Lisp.error(new LispError("Bad initial contents for array."));
/*  90 */         return -1;
/*     */       } 
/*  92 */       index++;
/*     */     } else {
/*  94 */       int dim = dims[0];
/*  95 */       if (dim != contents.length()) {
/*  96 */         Lisp.error(new LispError("Bad initial contents for array."));
/*  97 */         return -1;
/*     */       } 
/*  99 */       int[] newDims = new int[dims.length - 1]; int i;
/* 100 */       for (i = 1; i < dims.length; i++)
/* 101 */         newDims[i - 1] = dims[i]; 
/* 102 */       if (contents.listp()) {
/* 103 */         for (i = contents.length(); i-- > 0; ) {
/* 104 */           LispObject content = contents.car();
/*     */           
/* 106 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 107 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 110 */         AbstractVector v = Lisp.checkVector(contents);
/* 111 */         int length = v.length();
/* 112 */         for (int j = 0; j < length; j++) {
/* 113 */           LispObject content = v.AREF(j);
/*     */           
/* 115 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 119 */     return index;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 125 */     return Lisp.list(Symbol.ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, getDimensions() });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 131 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 137 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 143 */     LispObject result = Lisp.NIL;
/* 144 */     for (int i = this.dimv.length; i-- > 0;)
/* 145 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 146 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 153 */       return this.dimv[n];
/*     */     }
/* 155 */     catch (ArrayIndexOutOfBoundsException e) {
/* 156 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 157 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 164 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 170 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 177 */     if (this.array != null) {
/* 178 */       value1 = this.array;
/* 179 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     } else {
/* 181 */       value1 = Lisp.NIL;
/* 182 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 184 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 190 */     if (this.data != null) {
/*     */       try {
/* 192 */         return Lisp.coerceFromJavaByte(this.data[index]);
/*     */       }
/* 194 */       catch (ArrayIndexOutOfBoundsException e) {
/* 195 */         return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     }
/* 198 */     return this.array.AREF(index + this.displacement);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 204 */     if (this.data != null) {
/*     */       try {
/* 206 */         this.data[index] = Lisp.coerceToJavaByte(newValue);
/*     */       }
/* 208 */       catch (ArrayIndexOutOfBoundsException e) {
/* 209 */         Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */       } 
/*     */     } else {
/* 212 */       this.array.aset(index + this.displacement, newValue);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 218 */     if (!(obj instanceof Fixnum)) {
/* 219 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 223 */     int n = ((Fixnum)obj).value;
/* 224 */     if (n < 0 || n > 255) {
/* 225 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 229 */     if (this.data != null) {
/* 230 */       for (int i = this.data.length; i-- > 0;)
/* 231 */         this.data[i] = (byte)n; 
/*     */     } else {
/* 233 */       for (int i = this.totalSize; i-- > 0;) {
/* 234 */         aset(i, obj);
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 241 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/* 242 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 244 */       return null;
/*     */     } 
/* 246 */     return printObject(this.dimv);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 255 */     if (isAdjustable()) {
/* 256 */       if (initialContents != null) {
/* 257 */         setInitialContents(0, dims, initialContents, 0);
/*     */       }
/*     */       else {
/*     */         
/* 261 */         SimpleArray_UnsignedByte8 tempArray = new SimpleArray_UnsignedByte8(dims);
/* 262 */         if (initialElement != null)
/* 263 */           tempArray.fill(initialElement); 
/* 264 */         SimpleArray_UnsignedByte8.copyArray(this, tempArray);
/* 265 */         this.data = tempArray.data;
/*     */         
/* 267 */         for (int i = 0; i < dims.length; i++)
/* 268 */           this.dimv[i] = dims[i]; 
/*     */       } 
/* 270 */       return this;
/*     */     } 
/* 272 */     if (initialContents != null) {
/* 273 */       return new ComplexArray_UnsignedByte8(dims, initialContents);
/*     */     }
/* 275 */     ComplexArray_UnsignedByte8 newArray = new ComplexArray_UnsignedByte8(dims);
/* 276 */     if (initialElement != null)
/* 277 */       newArray.fill(initialElement); 
/* 278 */     return newArray;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 288 */     if (isAdjustable()) {
/* 289 */       for (int i = 0; i < dims.length; i++) {
/* 290 */         this.dimv[i] = dims[i];
/*     */       }
/* 292 */       this.data = null;
/* 293 */       this.array = displacedTo;
/* 294 */       this.displacement = displacement;
/* 295 */       this.totalSize = computeTotalSize(dims);
/*     */       
/* 297 */       return this;
/*     */     } 
/* 299 */     ComplexArray_UnsignedByte8 a = new ComplexArray_UnsignedByte8(dims, displacedTo, displacement);
/*     */     
/* 301 */     return a;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexArray_UnsignedByte8.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */