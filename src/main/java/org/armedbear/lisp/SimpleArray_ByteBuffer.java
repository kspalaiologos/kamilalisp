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
/*     */ public final class SimpleArray_ByteBuffer
/*     */   extends AbstractArray
/*     */ {
/*     */   private final int[] dimv;
/*     */   private final int totalSize;
/*     */   final ByteBuffer data;
/*     */   private boolean directAllocation;
/*     */   
/*     */   public SimpleArray_ByteBuffer(int[] dimv) {
/*  48 */     this(dimv, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_ByteBuffer(int[] dimv, boolean directAllocation) {
/*  52 */     this.dimv = dimv;
/*  53 */     this.directAllocation = directAllocation;
/*  54 */     this.totalSize = computeTotalSize(dimv);
/*  55 */     if (directAllocation) {
/*  56 */       this.data = ByteBuffer.allocateDirect(this.totalSize);
/*     */     } else {
/*  58 */       this.data = ByteBuffer.allocate(this.totalSize);
/*     */     } 
/*     */   }
/*     */   
/*     */   public SimpleArray_ByteBuffer(int[] dimv, LispObject initialContents) {
/*  63 */     this(dimv, initialContents, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_ByteBuffer(int[] dimv, LispObject initialContents, boolean directAllocation) {
/*  67 */     this.dimv = dimv;
/*  68 */     int rank = dimv.length;
/*  69 */     this.directAllocation = directAllocation;
/*  70 */     LispObject rest = initialContents;
/*  71 */     for (int i = 0; i < rank; i++) {
/*  72 */       dimv[i] = rest.length();
/*  73 */       rest = rest.elt(0);
/*     */     } 
/*  75 */     this.totalSize = computeTotalSize(dimv);
/*  76 */     if (directAllocation) {
/*  77 */       this.data = ByteBuffer.allocateDirect(this.totalSize);
/*     */     } else {
/*  79 */       this.data = ByteBuffer.allocate(this.totalSize);
/*     */     } 
/*  81 */     setInitialContents(0, dimv, initialContents, 0);
/*     */   }
/*     */   
/*     */   public SimpleArray_ByteBuffer(int rank, LispObject initialContents) {
/*  85 */     this(rank, initialContents, false);
/*     */   }
/*     */   
/*     */   public SimpleArray_ByteBuffer(int rank, LispObject initialContents, boolean directAllocation) {
/*  89 */     if (rank < 2) {
/*  90 */       Debug.assertTrue(false);
/*     */     }
/*  92 */     this.dimv = new int[rank];
/*  93 */     LispObject rest = initialContents;
/*  94 */     for (int i = 0; i < rank; i++) {
/*  95 */       this.dimv[i] = rest.length();
/*  96 */       if (rest == Lisp.NIL || rest.length() == 0)
/*     */         break; 
/*  98 */       rest = rest.elt(0);
/*     */     } 
/* 100 */     this.totalSize = computeTotalSize(this.dimv);
/* 101 */     if (directAllocation) {
/* 102 */       this.data = ByteBuffer.allocateDirect(this.totalSize);
/*     */     } else {
/* 104 */       this.data = ByteBuffer.allocate(this.totalSize);
/*     */     } 
/* 106 */     setInitialContents(0, this.dimv, initialContents, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   private int setInitialContents(int axis, int[] dims, LispObject contents, int index) {
/* 111 */     if (dims.length == 0) {
/*     */       try {
/* 113 */         this.data.put(index, Lisp.coerceToJavaByte(contents));
/* 114 */       } catch (IndexOutOfBoundsException e) {
/* 115 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 116 */         return -1;
/*     */       } 
/* 118 */       index++;
/*     */     } else {
/* 120 */       int dim = dims[0];
/* 121 */       if (dim != contents.length()) {
/* 122 */         Lisp.error(new LispError("Bad initial contents for array."));
/* 123 */         return -1;
/*     */       } 
/* 125 */       int[] newDims = new int[dims.length - 1]; int i;
/* 126 */       for (i = 1; i < dims.length; i++)
/* 127 */         newDims[i - 1] = dims[i]; 
/* 128 */       if (contents.listp()) {
/* 129 */         for (i = contents.length(); i-- > 0; ) {
/* 130 */           LispObject content = contents.car();
/*     */           
/* 132 */           index = setInitialContents(axis + 1, newDims, content, index);
/* 133 */           contents = contents.cdr();
/*     */         } 
/*     */       } else {
/* 136 */         AbstractVector v = Lisp.checkVector(contents);
/* 137 */         int length = v.length();
/* 138 */         for (int j = 0; j < length; j++) {
/* 139 */           LispObject content = v.AREF(j);
/*     */           
/* 141 */           index = setInitialContents(axis + 1, newDims, content, index);
/*     */         } 
/*     */       } 
/*     */     } 
/* 145 */     return index;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 150 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { Lisp.UNSIGNED_BYTE_8, getDimensions() });
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 155 */     return BuiltInClass.SIMPLE_ARRAY;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 160 */     if (typeSpecifier == Symbol.SIMPLE_ARRAY)
/* 161 */       return Lisp.T; 
/* 162 */     if (typeSpecifier == BuiltInClass.SIMPLE_ARRAY)
/* 163 */       return Lisp.T; 
/* 164 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRank() {
/* 169 */     return this.dimv.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/* 174 */     LispObject result = Lisp.NIL;
/* 175 */     for (int i = this.dimv.length; i-- > 0;)
/* 176 */       result = new Cons(Fixnum.getInstance(this.dimv[i]), result); 
/* 177 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*     */     try {
/* 183 */       return this.dimv[n];
/* 184 */     } catch (ArrayIndexOutOfBoundsException e) {
/* 185 */       Lisp.error(new TypeError("Bad array dimension " + n + "."));
/* 186 */       return -1;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 192 */     return Lisp.UNSIGNED_BYTE_8;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 197 */     return this.totalSize;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 202 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 208 */       return Lisp.coerceFromJavaByte(this.data.get(index));
/* 209 */     } catch (IndexOutOfBoundsException e) {
/* 210 */       return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/*     */     try {
/* 217 */       this.data.put(index, Lisp.coerceToJavaByte(newValue));
/* 218 */     } catch (IndexOutOfBoundsException e) {
/* 219 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 225 */     int rank = this.dimv.length;
/* 226 */     if (rank != subscripts.length) {
/* 227 */       StringBuffer sb = new StringBuffer("Wrong number of subscripts (");
/* 228 */       sb.append(subscripts.length);
/* 229 */       sb.append(") for array of rank ");
/* 230 */       sb.append(rank);
/* 231 */       sb.append('.');
/* 232 */       Lisp.program_error(sb.toString());
/*     */     } 
/* 234 */     int sum = 0;
/* 235 */     int size = 1;
/* 236 */     for (int i = rank; i-- > 0; ) {
/* 237 */       int dim = this.dimv[i];
/* 238 */       int lastSize = size;
/* 239 */       size *= dim;
/* 240 */       int n = subscripts[i];
/* 241 */       if (n < 0 || n >= dim) {
/* 242 */         StringBuffer sb = new StringBuffer("Invalid index ");
/* 243 */         sb.append(n);
/* 244 */         sb.append(" for array ");
/* 245 */         sb.append(this);
/* 246 */         sb.append('.');
/* 247 */         Lisp.program_error(sb.toString());
/*     */       } 
/* 249 */       sum += n * lastSize;
/*     */     } 
/* 251 */     return sum;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/*     */     try {
/* 257 */       return Lisp.coerceFromJavaByte(this.data.get(getRowMajorIndex(subscripts)));
/* 258 */     } catch (IndexOutOfBoundsException e) {
/* 259 */       return Lisp.error(new TypeError("Bad row major index " + 
/* 260 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/*     */     try {
/* 267 */       this.data.put(getRowMajorIndex(subscripts), Lisp.coerceToJavaByte(newValue));
/* 268 */     } catch (IndexOutOfBoundsException e) {
/* 269 */       Lisp.error(new TypeError("Bad row major index " + 
/* 270 */             getRowMajorIndex(subscripts) + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 276 */     if (!(obj instanceof Fixnum)) {
/* 277 */       Lisp.type_error(obj, Symbol.FIXNUM);
/*     */       
/*     */       return;
/*     */     } 
/* 281 */     int n = ((Fixnum)obj).value;
/* 282 */     if (n < 0 || n > 255) {
/* 283 */       Lisp.type_error(obj, Lisp.UNSIGNED_BYTE_8);
/*     */       
/*     */       return;
/*     */     } 
/* 287 */     for (int i = this.totalSize; i-- > 0;) {
/* 288 */       this.data.put(i, (byte)n);
/*     */     }
/*     */   }
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
/*     */   public AbstractArray adjustArray(int[] dimv, LispObject initialElement, LispObject initialContents) {
/* 303 */     if (initialContents != null)
/* 304 */       return new SimpleArray_ByteBuffer(dimv, initialContents); 
/* 305 */     for (int i = 0; i < dimv.length; i++) {
/* 306 */       if (dimv[i] != this.dimv[i]) {
/* 307 */         SimpleArray_ByteBuffer newArray = new SimpleArray_ByteBuffer(dimv);
/*     */         
/* 309 */         if (initialElement != null)
/* 310 */           newArray.fill(initialElement); 
/* 311 */         copyArray(this, newArray);
/* 312 */         return newArray;
/*     */       } 
/*     */     } 
/*     */     
/* 316 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   static void copyArray(AbstractArray a1, AbstractArray a2) {
/* 321 */     Debug.assertTrue((a1.getRank() == a2.getRank()));
/* 322 */     int[] subscripts = new int[a1.getRank()];
/* 323 */     int axis = 0;
/* 324 */     copySubArray(a1, a2, subscripts, axis);
/*     */   }
/*     */ 
/*     */   
/*     */   private static void copySubArray(AbstractArray a1, AbstractArray a2, int[] subscripts, int axis) {
/* 329 */     if (axis < subscripts.length) {
/*     */       
/* 331 */       int limit = Math.min(a1.getDimension(axis), a2.getDimension(axis));
/* 332 */       for (int i = 0; i < limit; i++) {
/* 333 */         subscripts[axis] = i;
/* 334 */         copySubArray(a1, a2, subscripts, axis + 1);
/*     */       } 
/*     */     } else {
/* 337 */       int i1 = a1.getRowMajorIndex(subscripts);
/* 338 */       int i2 = a2.getRowMajorIndex(subscripts);
/* 339 */       a2.aset(i2, a1.AREF(i1));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dimv, AbstractArray displacedTo, int displacement) {
/* 345 */     return new ComplexArray(dimv, displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleArray_ByteBuffer.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */