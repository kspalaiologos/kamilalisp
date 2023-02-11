/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.nio.ByteBuffer;
/*     */ import java.nio.CharBuffer;
/*     */ import java.nio.IntBuffer;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class make_array
/*     */   extends Primitive
/*     */ {
/*     */   public make_array() {
/*  44 */     super("%make-array", Lisp.PACKAGE_SYS, false);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/*     */     AbstractArray array;
/*  50 */     if (args.length != 13) {
/*  51 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 13));
/*     */     }
/*  53 */     LispObject dimensions = args[0];
/*  54 */     LispObject elementType = args[1];
/*  55 */     LispObject initialElement = args[2];
/*  56 */     LispObject initialElementProvided = args[3];
/*  57 */     LispObject initialContents = args[4];
/*  58 */     LispObject adjustable = args[5];
/*  59 */     LispObject fillPointer = args[6];
/*  60 */     LispObject displacedTo = args[7];
/*  61 */     LispObject displacedIndexOffset = args[8];
/*  62 */     LispObject direct = args[9];
/*     */     
/*  64 */     boolean directAllocation = !direct.equals(Lisp.NIL);
/*  65 */     LispObject nioBuffer = args[11];
/*  66 */     LispObject nioBufferProvided = args[12];
/*     */     
/*  68 */     if (initialElementProvided != Lisp.NIL && initialContents != Lisp.NIL) {
/*  69 */       return Lisp.error(new LispError("MAKE-ARRAY: cannot specify both initial element and initial contents."));
/*     */     }
/*     */     
/*  72 */     int rank = dimensions.listp() ? dimensions.length() : 1;
/*  73 */     int[] dimv = new int[rank];
/*  74 */     if (dimensions.listp()) {
/*  75 */       for (int i = 0; i < rank; i++) {
/*  76 */         LispObject dim = dimensions.car();
/*  77 */         dimv[i] = Fixnum.getValue(dim);
/*  78 */         dimensions = dimensions.cdr();
/*     */       } 
/*     */     } else {
/*  81 */       dimv[0] = Fixnum.getValue(dimensions);
/*     */     } 
/*  83 */     if (displacedTo != Lisp.NIL) {
/*     */       int displacement;
/*     */       
/*  86 */       AbstractArray abstractArray = Lisp.checkArray(displacedTo);
/*  87 */       if (initialElementProvided != Lisp.NIL) {
/*  88 */         return Lisp.error(new LispError("Initial element must not be specified for a displaced array."));
/*     */       }
/*  90 */       if (initialContents != Lisp.NIL) {
/*  91 */         return Lisp.error(new LispError("Initial contents must not be specified for a displaced array."));
/*     */       }
/*     */       
/*  94 */       if (displacedIndexOffset != Lisp.NIL) {
/*  95 */         displacement = Fixnum.getValue(displacedIndexOffset);
/*     */       } else {
/*  97 */         displacement = 0;
/*     */       } 
/*  99 */       if (rank == 1) {
/*     */         
/* 101 */         AbstractVector v = null;
/* 102 */         LispObject arrayElementType = abstractArray.getElementType();
/* 103 */         if (arrayElementType == Symbol.CHARACTER) {
/* 104 */           v = new ComplexString(dimv[0], abstractArray, displacement);
/* 105 */         } else if (arrayElementType == Symbol.BIT) {
/* 106 */           v = new ComplexBitVector(dimv[0], abstractArray, displacement);
/* 107 */         } else if (arrayElementType.equal(Lisp.UNSIGNED_BYTE_8)) {
/* 108 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/*     */             
/* 110 */             v = new ComplexVector_ByteBuffer(dimv[0], abstractArray, displacement, directAllocation);
/*     */           } else {
/* 112 */             v = new ComplexVector_UnsignedByte8(dimv[0], abstractArray, displacement);
/*     */           } 
/* 114 */         } else if (arrayElementType.equal(Lisp.UNSIGNED_BYTE_32)) {
/* 115 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/*     */             
/* 117 */             v = new ComplexVector_IntBuffer(dimv[0], abstractArray, displacement, directAllocation);
/*     */           } else {
/* 119 */             v = new ComplexVector_UnsignedByte32(dimv[0], abstractArray, displacement);
/*     */           } 
/*     */         } else {
/* 122 */           v = new ComplexVector(dimv[0], abstractArray, displacement);
/*     */         } 
/* 124 */         if (fillPointer != Lisp.NIL) {
/* 125 */           v.setFillPointer(fillPointer);
/*     */         }
/* 127 */         return v;
/*     */       } 
/* 129 */       return new ComplexArray(dimv, abstractArray, displacement);
/*     */     } 
/*     */     
/* 132 */     LispObject upgradedType = Lisp.getUpgradedArrayElementType(elementType);
/* 133 */     if (rank == 0) {
/*     */       LispObject data;
/* 135 */       if (initialElementProvided != Lisp.NIL) {
/* 136 */         data = initialElement;
/*     */       } else {
/* 138 */         data = initialContents;
/*     */       } 
/* 140 */       return new ZeroRankArray(upgradedType, data, (adjustable != Lisp.NIL));
/* 141 */     }  if (rank == 1) {
/* 142 */       AbstractVector v; LispObject defaultInitialElement; int size = dimv[0];
/* 143 */       if (size < 0 || size >= Integer.MAX_VALUE) {
/* 144 */         StringBuilder sb = new StringBuilder();
/* 145 */         sb.append("The size specified for this array (");
/* 146 */         sb.append(size);
/* 147 */         sb.append(')');
/* 148 */         if (size >= Integer.MAX_VALUE) {
/* 149 */           sb.append(" is >= ARRAY-DIMENSION-LIMIT (");
/* 150 */           sb.append(2147483647);
/* 151 */           sb.append(").");
/*     */         } else {
/* 153 */           sb.append(" is negative.");
/* 154 */         }  return Lisp.error(new LispError(sb.toString()));
/*     */       } 
/*     */ 
/*     */       
/* 158 */       if (upgradedType == Symbol.CHARACTER) {
/* 159 */         if (fillPointer != Lisp.NIL || adjustable != Lisp.NIL) {
/* 160 */           v = new ComplexString(size);
/*     */         } else {
/* 162 */           v = new SimpleString(size);
/*     */         } 
/* 164 */         defaultInitialElement = LispCharacter.getInstance(false);
/* 165 */       } else if (upgradedType == Symbol.BIT) {
/* 166 */         if (fillPointer != Lisp.NIL || adjustable != Lisp.NIL) {
/* 167 */           v = new ComplexBitVector(size);
/*     */         } else {
/* 169 */           v = new SimpleBitVector(size);
/*     */         } 
/* 171 */         defaultInitialElement = Fixnum.ZERO;
/* 172 */       } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_8)) {
/* 173 */         if (fillPointer != Lisp.NIL || adjustable != Lisp.NIL) {
/* 174 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 175 */             v = new ComplexVector_ByteBuffer(size, directAllocation);
/*     */           } else {
/* 177 */             v = new ComplexVector_UnsignedByte8(size);
/*     */           }
/*     */         
/* 180 */         } else if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 181 */           if (!nioBuffer.equals(Lisp.NIL)) {
/* 182 */             v = new BasicVector_ByteBuffer((ByteBuffer)((JavaObject)nioBuffer).getObject(), directAllocation);
/*     */           } else {
/*     */             
/* 185 */             v = new BasicVector_ByteBuffer(size, directAllocation);
/*     */           } 
/*     */         } else {
/* 188 */           v = new BasicVector_UnsignedByte8(size);
/*     */         } 
/*     */         
/* 191 */         defaultInitialElement = Fixnum.ZERO;
/* 192 */       } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_16) && fillPointer == Lisp.NIL && adjustable == Lisp.NIL) {
/*     */         
/* 194 */         if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 195 */           if (!nioBuffer.equals(Lisp.NIL)) {
/* 196 */             Object o = ((JavaObject)nioBuffer).getObject();
/* 197 */             if (o instanceof CharBuffer) {
/* 198 */               v = new BasicVector_CharBuffer((CharBuffer)o, directAllocation);
/* 199 */             } else if (o instanceof ByteBuffer) {
/* 200 */               v = new BasicVector_CharBuffer((ByteBuffer)o, directAllocation);
/*     */             } else {
/* 202 */               return Lisp.type_error(nioBuffer, JavaObject.getInstance(CharBuffer.class));
/*     */             } 
/*     */           } else {
/* 205 */             v = new BasicVector_CharBuffer(size, directAllocation);
/*     */           } 
/*     */         } else {
/* 208 */           v = new BasicVector_UnsignedByte16(size);
/*     */         } 
/* 210 */         defaultInitialElement = Fixnum.ZERO;
/* 211 */       } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_32)) {
/* 212 */         if (fillPointer != Lisp.NIL || adjustable != Lisp.NIL) {
/* 213 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 214 */             v = new ComplexVector_IntBuffer(size);
/*     */           } else {
/* 216 */             v = new ComplexVector_UnsignedByte32(size);
/*     */           }
/*     */         
/* 219 */         } else if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 220 */           if (!nioBuffer.equals(Lisp.NIL)) {
/* 221 */             Object o = ((JavaObject)nioBuffer).getObject();
/* 222 */             if (o instanceof IntBuffer) {
/* 223 */               v = new BasicVector_IntBuffer((IntBuffer)o, directAllocation);
/* 224 */             } else if (o instanceof ByteBuffer) {
/* 225 */               v = new BasicVector_IntBuffer((ByteBuffer)o, directAllocation);
/*     */             } else {
/* 227 */               return Lisp.type_error(nioBuffer, JavaObject.getInstance(IntBuffer.class));
/*     */             } 
/*     */           } else {
/* 230 */             v = new BasicVector_IntBuffer(size, directAllocation);
/*     */           } 
/*     */         } else {
/* 233 */           v = new BasicVector_UnsignedByte32(size);
/*     */         } 
/*     */         
/* 236 */         defaultInitialElement = Fixnum.ZERO;
/* 237 */       } else if (upgradedType == Lisp.NIL) {
/* 238 */         v = new NilVector(size);
/* 239 */         defaultInitialElement = null;
/*     */       } else {
/* 241 */         if (fillPointer != Lisp.NIL || adjustable != Lisp.NIL) {
/* 242 */           v = new ComplexVector(size);
/*     */         } else {
/* 244 */           v = new SimpleVector(size);
/*     */         } 
/* 246 */         defaultInitialElement = Lisp.NIL;
/*     */       } 
/*     */       
/* 249 */       if (nioBuffer == Lisp.NIL)
/*     */       {
/*     */         
/* 252 */         if (initialElementProvided != Lisp.NIL) {
/*     */           
/* 254 */           v.fill(initialElement);
/* 255 */         } else if (initialContents != Lisp.NIL) {
/* 256 */           if (initialContents.listp()) {
/* 257 */             LispObject list = initialContents;
/* 258 */             for (int i = 0; i < size; i++) {
/* 259 */               v.aset(i, list.car());
/* 260 */               list = list.cdr();
/*     */             } 
/* 262 */           } else if (initialContents.vectorp()) {
/* 263 */             for (int i = 0; i < size; i++) {
/* 264 */               v.aset(i, initialContents.elt(i));
/*     */             }
/*     */           } else {
/* 267 */             return Lisp.type_error(initialContents, Symbol.SEQUENCE);
/*     */           }
/*     */         
/* 270 */         } else if (defaultInitialElement != null) {
/* 271 */           v.fill(defaultInitialElement);
/*     */         } 
/*     */       }
/* 274 */       if (fillPointer != Lisp.NIL) {
/* 275 */         v.setFillPointer(fillPointer);
/*     */       }
/* 277 */       return v;
/*     */     } 
/*     */     
/* 280 */     if (adjustable == Lisp.NIL) {
/* 281 */       if (upgradedType.equal(Lisp.UNSIGNED_BYTE_8)) {
/* 282 */         if (initialContents != Lisp.NIL) {
/* 283 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 284 */             array = new SimpleArray_ByteBuffer(dimv, initialContents, directAllocation);
/*     */           } else {
/* 286 */             array = new SimpleArray_UnsignedByte8(dimv, initialContents);
/*     */           } 
/*     */         } else {
/* 289 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 290 */             array = new SimpleArray_ByteBuffer(dimv, directAllocation);
/*     */           } else {
/* 292 */             array = new SimpleArray_UnsignedByte8(dimv);
/*     */           } 
/* 294 */           if (initialElementProvided != Lisp.NIL) {
/* 295 */             array.fill(initialElement);
/*     */           } else {
/* 297 */             array.fill(Fixnum.ZERO);
/*     */           } 
/*     */         } 
/* 300 */       } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_16)) {
/* 301 */         if (initialContents != Lisp.NIL) {
/* 302 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 303 */             array = new SimpleArray_CharBuffer(dimv, initialContents, directAllocation);
/*     */           } else {
/* 305 */             array = new SimpleArray_UnsignedByte16(dimv, initialContents);
/*     */           } 
/*     */         } else {
/* 308 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 309 */             array = new SimpleArray_CharBuffer(dimv, directAllocation);
/*     */           } else {
/* 311 */             array = new SimpleArray_UnsignedByte16(dimv);
/*     */           } 
/* 313 */           if (initialElementProvided != Lisp.NIL) {
/* 314 */             array.fill(initialElement);
/*     */           } else {
/* 316 */             array.fill(Fixnum.ZERO);
/*     */           } 
/*     */         } 
/* 319 */       } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_32)) {
/* 320 */         if (initialContents != Lisp.NIL) {
/* 321 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 322 */             array = new SimpleArray_IntBuffer(dimv, initialContents, directAllocation);
/*     */           } else {
/* 324 */             array = new SimpleArray_UnsignedByte32(dimv, initialContents);
/*     */           } 
/*     */         } else {
/* 327 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 328 */             array = new SimpleArray_IntBuffer(dimv, directAllocation);
/*     */           } else {
/* 330 */             array = new SimpleArray_UnsignedByte32(dimv);
/*     */           } 
/* 332 */           if (initialElementProvided != Lisp.NIL) {
/* 333 */             array.fill(initialElement);
/*     */           } else {
/* 335 */             array.fill(Fixnum.ZERO);
/*     */           }
/*     */         
/*     */         } 
/* 339 */       } else if (initialContents != Lisp.NIL) {
/* 340 */         array = new SimpleArray_T(dimv, upgradedType, initialContents);
/*     */       } else {
/* 342 */         array = new SimpleArray_T(dimv, upgradedType);
/* 343 */         if (initialElementProvided != Lisp.NIL) {
/* 344 */           array.fill(initialElement);
/*     */         } else {
/* 346 */           array.fill(Lisp.NIL);
/*     */         }
/*     */       
/*     */       }
/*     */     
/* 351 */     } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_8)) {
/* 352 */       if (initialContents != Lisp.NIL) {
/* 353 */         if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 354 */           array = new ComplexArray_ByteBuffer(dimv, initialContents);
/*     */         } else {
/* 356 */           array = new ComplexArray_UnsignedByte8(dimv, initialContents);
/*     */         } 
/*     */       } else {
/* 359 */         if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 360 */           array = new ComplexArray_ByteBuffer(dimv);
/*     */         } else {
/* 362 */           array = new ComplexArray_UnsignedByte8(dimv);
/*     */         } 
/* 364 */         if (initialElementProvided != Lisp.NIL) {
/* 365 */           array.fill(initialElement);
/*     */         } else {
/* 367 */           array.fill(Fixnum.ZERO);
/*     */         } 
/*     */       } 
/* 370 */     } else if (upgradedType.equal(Lisp.UNSIGNED_BYTE_32)) {
/* 371 */       if (initialContents != Lisp.NIL) {
/* 372 */         if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 373 */           array = new ComplexArray_IntBuffer(dimv, initialContents, directAllocation);
/*     */         } else {
/* 375 */           array = new ComplexArray_UnsignedByte32(dimv, initialContents);
/*     */         } 
/*     */       } else {
/* 378 */         if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO)) {
/* 379 */           array = new ComplexArray_IntBuffer(dimv, directAllocation);
/*     */         } else {
/* 381 */           array = new ComplexArray_UnsignedByte32(dimv);
/*     */         } 
/* 383 */         if (initialElementProvided != Lisp.NIL) {
/* 384 */           array.fill(initialElement);
/*     */         } else {
/* 386 */           array.fill(Fixnum.ZERO);
/*     */         }
/*     */       
/*     */       } 
/* 390 */     } else if (initialContents != Lisp.NIL) {
/* 391 */       array = new ComplexArray(dimv, upgradedType, initialContents);
/*     */     } else {
/* 393 */       array = new ComplexArray(dimv, upgradedType);
/* 394 */       if (initialElementProvided != Lisp.NIL) {
/* 395 */         array.fill(initialElement);
/*     */       } else {
/* 397 */         array.fill(Lisp.NIL);
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/* 402 */     return array;
/*     */   }
/*     */ 
/*     */   
/* 406 */   private static final Primitive _MAKE_ARRAY = new make_array();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/make_array.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */