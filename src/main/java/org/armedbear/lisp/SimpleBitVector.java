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
/*     */ public final class SimpleBitVector
/*     */   extends AbstractBitVector
/*     */ {
/*     */   public SimpleBitVector(int capacity) {
/*  45 */     this.capacity = capacity;
/*  46 */     int size = capacity >>> 6;
/*     */ 
/*     */     
/*  49 */     if ((capacity & 0x3F) != 0)
/*  50 */       size++; 
/*  51 */     this.bits = new long[size];
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleBitVector(String s) {
/*  56 */     this(s.length());
/*  57 */     for (int i = this.capacity; i-- > 0; ) {
/*  58 */       char c = s.charAt(i);
/*  59 */       if (c == '0')
/*  60 */         continue;  if (c == '1') {
/*  61 */         setBit(i); continue;
/*     */       } 
/*  63 */       Debug.assertTrue(false);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  70 */     return Lisp.list(Symbol.SIMPLE_BIT_VECTOR, new LispObject[] { Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  76 */     return BuiltInClass.SIMPLE_BIT_VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  82 */     if (type == Symbol.SIMPLE_BIT_VECTOR)
/*  83 */       return Lisp.T; 
/*  84 */     if (type == Symbol.SIMPLE_ARRAY)
/*  85 */       return Lisp.T; 
/*  86 */     if (type == BuiltInClass.SIMPLE_BIT_VECTOR)
/*  87 */       return Lisp.T; 
/*  88 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/*  89 */       return Lisp.T; 
/*  90 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  96 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 102 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 108 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 114 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 120 */     if (index < 0 || index >= length())
/* 121 */       badIndex(index, length()); 
/* 122 */     int offset = index >> 6;
/* 123 */     return ((this.bits[offset] & 1L << (index & 0x3F)) != 0L) ? Fixnum.ONE : Fixnum.ZERO;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 129 */     if (index < 0 || index >= this.capacity)
/* 130 */       badIndex(index, this.capacity); 
/* 131 */     int offset = index >> 6;
/* 132 */     return ((this.bits[offset] & 1L << (index & 0x3F)) != 0L) ? Fixnum.ONE : Fixnum.ZERO;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 138 */     if (index < 0 || index >= this.capacity)
/* 139 */       badIndex(index, this.capacity); 
/* 140 */     int offset = index >> 6;
/* 141 */     if (newValue instanceof Fixnum) {
/* 142 */       switch (((Fixnum)newValue).value) {
/*     */         case 0:
/* 144 */           this.bits[offset] = this.bits[offset] & (1L << (index & 0x3F) ^ 0xFFFFFFFFFFFFFFFFL);
/*     */           return;
/*     */         case 1:
/* 147 */           this.bits[offset] = this.bits[offset] | 1L << (index & 0x3F);
/*     */           return;
/*     */       } 
/*     */     
/*     */     }
/* 152 */     Lisp.type_error(newValue, Symbol.BIT);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected int getBit(int index) {
/* 158 */     int offset = index >> 6;
/* 159 */     return ((this.bits[offset] & 1L << (index & 0x3F)) != 0L) ? 1 : 0;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void setBit(int index) {
/* 165 */     int offset = index >> 6;
/* 166 */     this.bits[offset] = this.bits[offset] | 1L << (index & 0x3F);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void clearBit(int index) {
/* 172 */     int offset = index >> 6;
/* 173 */     this.bits[offset] = this.bits[offset] & (1L << (index & 0x3F) ^ 0xFFFFFFFFFFFFFFFFL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 179 */     if (n < this.capacity) {
/* 180 */       int size = n >>> 6;
/* 181 */       if ((n & 0x3F) != 0)
/* 182 */         size++; 
/* 183 */       if (size < this.bits.length) {
/* 184 */         long[] newbits = new long[size];
/* 185 */         System.arraycopy(this.bits, 0, newbits, 0, size);
/* 186 */         this.bits = newbits;
/*     */       } 
/* 188 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 191 */     if (n == this.capacity)
/*     */       return; 
/* 193 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 202 */     if (initialContents != null) {
/* 203 */       SimpleBitVector v = new SimpleBitVector(newCapacity);
/* 204 */       if (initialContents.listp()) {
/* 205 */         LispObject list = initialContents;
/* 206 */         for (int i = 0; i < newCapacity; i++) {
/* 207 */           v.aset(i, list.car());
/* 208 */           list = list.cdr();
/*     */         } 
/* 210 */       } else if (initialContents.vectorp()) {
/* 211 */         for (int i = 0; i < newCapacity; i++)
/* 212 */           v.aset(i, initialContents.elt(i)); 
/*     */       } else {
/* 214 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 215 */       }  return v;
/*     */     } 
/* 217 */     if (this.capacity != newCapacity) {
/* 218 */       SimpleBitVector v = new SimpleBitVector(newCapacity);
/* 219 */       int limit = Math.min(this.capacity, newCapacity);
/* 220 */       for (int i = limit; i-- > 0; ) {
/* 221 */         if (getBit(i) == 1) {
/* 222 */           v.setBit(i); continue;
/*     */         } 
/* 224 */         v.clearBit(i);
/*     */       } 
/* 226 */       if (initialElement != null && this.capacity < newCapacity) {
/* 227 */         int n = Fixnum.getValue(initialElement);
/* 228 */         if (n == 1) {
/* 229 */           for (int j = this.capacity; j < newCapacity; j++)
/* 230 */             v.setBit(j); 
/*     */         } else {
/* 232 */           for (int j = this.capacity; j < newCapacity; j++)
/* 233 */             v.clearBit(j); 
/*     */         } 
/* 235 */       }  return v;
/*     */     } 
/*     */     
/* 238 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 247 */     return new ComplexBitVector(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector and(SimpleBitVector v, SimpleBitVector result) {
/* 252 */     if (result == null)
/* 253 */       result = new SimpleBitVector(this.capacity); 
/* 254 */     for (int i = this.bits.length; i-- > 0;)
/* 255 */       result.bits[i] = this.bits[i] & v.bits[i]; 
/* 256 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector ior(SimpleBitVector v, SimpleBitVector result) {
/* 261 */     if (result == null)
/* 262 */       result = new SimpleBitVector(this.capacity); 
/* 263 */     for (int i = this.bits.length; i-- > 0;)
/* 264 */       result.bits[i] = this.bits[i] | v.bits[i]; 
/* 265 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector xor(SimpleBitVector v, SimpleBitVector result) {
/* 270 */     if (result == null)
/* 271 */       result = new SimpleBitVector(this.capacity); 
/* 272 */     for (int i = this.bits.length; i-- > 0;)
/* 273 */       result.bits[i] = this.bits[i] ^ v.bits[i]; 
/* 274 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector eqv(SimpleBitVector v, SimpleBitVector result) {
/* 279 */     if (result == null)
/* 280 */       result = new SimpleBitVector(this.capacity); 
/* 281 */     for (int i = this.bits.length; i-- > 0;)
/* 282 */       result.bits[i] = this.bits[i] ^ v.bits[i] ^ 0xFFFFFFFFFFFFFFFFL; 
/* 283 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector nand(SimpleBitVector v, SimpleBitVector result) {
/* 288 */     if (result == null)
/* 289 */       result = new SimpleBitVector(this.capacity); 
/* 290 */     for (int i = this.bits.length; i-- > 0;)
/* 291 */       result.bits[i] = this.bits[i] & v.bits[i] ^ 0xFFFFFFFFFFFFFFFFL; 
/* 292 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector nor(SimpleBitVector v, SimpleBitVector result) {
/* 297 */     if (result == null)
/* 298 */       result = new SimpleBitVector(this.capacity); 
/* 299 */     for (int i = this.bits.length; i-- > 0;)
/* 300 */       result.bits[i] = (this.bits[i] | v.bits[i]) ^ 0xFFFFFFFFFFFFFFFFL; 
/* 301 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector andc1(SimpleBitVector v, SimpleBitVector result) {
/* 306 */     if (result == null)
/* 307 */       result = new SimpleBitVector(this.capacity); 
/* 308 */     for (int i = this.bits.length; i-- > 0;)
/* 309 */       result.bits[i] = (this.bits[i] ^ 0xFFFFFFFFFFFFFFFFL) & v.bits[i]; 
/* 310 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector andc2(SimpleBitVector v, SimpleBitVector result) {
/* 315 */     if (result == null)
/* 316 */       result = new SimpleBitVector(this.capacity); 
/* 317 */     for (int i = this.bits.length; i-- > 0;)
/* 318 */       result.bits[i] = this.bits[i] & (v.bits[i] ^ 0xFFFFFFFFFFFFFFFFL); 
/* 319 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector orc1(SimpleBitVector v, SimpleBitVector result) {
/* 324 */     if (result == null)
/* 325 */       result = new SimpleBitVector(this.capacity); 
/* 326 */     for (int i = this.bits.length; i-- > 0;)
/* 327 */       result.bits[i] = this.bits[i] ^ 0xFFFFFFFFFFFFFFFFL | v.bits[i]; 
/* 328 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   SimpleBitVector orc2(SimpleBitVector v, SimpleBitVector result) {
/* 333 */     if (result == null)
/* 334 */       result = new SimpleBitVector(this.capacity); 
/* 335 */     for (int i = this.bits.length; i-- > 0;)
/* 336 */       result.bits[i] = this.bits[i] | v.bits[i] ^ 0xFFFFFFFFFFFFFFFFL; 
/* 337 */     return result;
/*     */   }
/*     */ 
/*     */   
/* 341 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_AND = new Primitive("%simple-bit-vector-bit-and", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 350 */         return ((SimpleBitVector)first).and((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 356 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_IOR = new Primitive("%simple-bit-vector-bit-ior", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 365 */         return ((SimpleBitVector)first).ior((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 372 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_XOR = new Primitive("%simple-bit-vector-bit-xor", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 381 */         return ((SimpleBitVector)first).xor((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 388 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_EQV = new Primitive("%simple-bit-vector-bit-eqv", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 397 */         return ((SimpleBitVector)first).eqv((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 403 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_NAND = new Primitive("%simple-bit-vector-bit-nand", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 412 */         return ((SimpleBitVector)first).nand((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 418 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_NOR = new Primitive("%simple-bit-vector-bit-nor", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 427 */         return ((SimpleBitVector)first).nor((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 433 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_ANDC1 = new Primitive("%simple-bit-vector-bit-andc1", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 442 */         return ((SimpleBitVector)first).andc1((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 448 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_ANDC2 = new Primitive("%simple-bit-vector-bit-andc2", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 457 */         return ((SimpleBitVector)first).andc2((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 464 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_ORC1 = new Primitive("%simple-bit-vector-bit-orc1", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 473 */         return ((SimpleBitVector)first).orc1((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 479 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_ORC2 = new Primitive("%simple-bit-vector-bit-orc2", Lisp.PACKAGE_SYS, false, "bit-vector1 bit-vector2 result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 488 */         return ((SimpleBitVector)first).orc2((SimpleBitVector)second, (SimpleBitVector)third);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 494 */   private static final Primitive _SIMPLE_BIT_VECTOR_BIT_NOT = new Primitive("%simple-bit-vector-bit-not", Lisp.PACKAGE_SYS, false, "bit-vector result-bit-vector")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 502 */         SimpleBitVector v = (SimpleBitVector)first;
/* 503 */         SimpleBitVector result = (SimpleBitVector)second;
/* 504 */         for (int i = v.bits.length; i-- > 0;)
/* 505 */           result.bits[i] = v.bits[i] ^ 0xFFFFFFFFFFFFFFFFL; 
/* 506 */         return result;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleBitVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */