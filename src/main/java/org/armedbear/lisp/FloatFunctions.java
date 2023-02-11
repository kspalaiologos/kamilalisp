/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.math.BigInteger;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class FloatFunctions
/*     */ {
/*  43 */   private static final Primitive SET_FLOATING_POINT_MODES = new Primitive("set-floating-point-modes", Lisp.PACKAGE_EXT, true, "&key traps")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*  50 */         if (args.length % 2 != 0)
/*  51 */           Lisp.program_error("Odd number of keyword arguments."); 
/*  52 */         for (int i = 0; i < args.length; i += 2) {
/*  53 */           LispObject key = Lisp.checkSymbol(args[i]);
/*  54 */           LispObject value = args[i + 1];
/*  55 */           if (key == Keyword.TRAPS) {
/*  56 */             boolean trap_overflow = false;
/*  57 */             boolean trap_underflow = false;
/*  58 */             while (value != Lisp.NIL) {
/*  59 */               LispObject car = value.car();
/*  60 */               if (car == Keyword.OVERFLOW) {
/*  61 */                 trap_overflow = true;
/*  62 */               } else if (car == Keyword.UNDERFLOW) {
/*  63 */                 trap_underflow = true;
/*     */               } else {
/*  65 */                 Lisp.error(new LispError("Unsupported floating point trap: " + car
/*  66 */                       .princToString()));
/*  67 */               }  value = value.cdr();
/*     */             } 
/*  69 */             Lisp.TRAP_OVERFLOW = trap_overflow;
/*  70 */             Lisp.TRAP_UNDERFLOW = trap_underflow;
/*     */           } else {
/*  72 */             Lisp.error(new LispError("Unrecognized keyword: " + key.princToString()));
/*     */           } 
/*  74 */         }  return LispThread.currentThread().nothing();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  79 */   private static final Primitive GET_FLOATING_POINT_MODES = new Primitive("get-floating-point-modes", Lisp.PACKAGE_EXT, true, "")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/*  85 */         LispObject traps = Lisp.NIL;
/*  86 */         if (Lisp.TRAP_UNDERFLOW)
/*  87 */           traps = traps.push(Keyword.UNDERFLOW); 
/*  88 */         if (Lisp.TRAP_OVERFLOW)
/*  89 */           traps = traps.push(Keyword.OVERFLOW); 
/*  90 */         return Lisp.list(Keyword.TRAPS, new LispObject[] { traps });
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  95 */   private static final Primitive INTEGER_DECODE_FLOAT = new Primitive("integer-decode-float", "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 101 */         if (arg instanceof SingleFloat) {
/* 102 */           int m; if (arg.equals(SingleFloat.SINGLE_FLOAT_POSITIVE_INFINITY) || arg
/* 103 */             .equals(SingleFloat.SINGLE_FLOAT_NEGATIVE_INFINITY)) {
/* 104 */             return Lisp.error(new LispError("Cannot decode infinity."));
/*     */           }
/*     */           
/* 107 */           int bits = Float.floatToRawIntBits(((SingleFloat)arg).value);
/* 108 */           int s = (bits >> 31 == 0) ? 1 : -1;
/* 109 */           int e = (int)((bits >> 23) & 0xFFL);
/*     */           
/* 111 */           if (e == 0) {
/* 112 */             m = (bits & 0x7FFFFF) << 1;
/*     */           } else {
/* 114 */             m = bits & 0x7FFFFF | 0x800000;
/* 115 */           }  LispObject significand = Lisp.number(m);
/* 116 */           Fixnum exponent = Fixnum.getInstance(e - 150);
/* 117 */           Fixnum sign = Fixnum.getInstance(s);
/* 118 */           return LispThread.currentThread().setValues(significand, exponent, sign);
/*     */         } 
/*     */ 
/*     */         
/* 122 */         if (arg instanceof DoubleFloat) {
/* 123 */           long m; if (arg.equals(DoubleFloat.DOUBLE_FLOAT_POSITIVE_INFINITY) || arg
/* 124 */             .equals(DoubleFloat.DOUBLE_FLOAT_NEGATIVE_INFINITY)) {
/* 125 */             return Lisp.error(new LispError("Cannot decode infinity."));
/*     */           }
/*     */ 
/*     */           
/* 129 */           long bits = Double.doubleToRawLongBits(((DoubleFloat)arg).value);
/* 130 */           int s = (bits >> 63L == 0L) ? 1 : -1;
/* 131 */           int e = (int)(bits >> 52L & 0x7FFL);
/*     */           
/* 133 */           if (e == 0) {
/* 134 */             m = (bits & 0xFFFFFFFFFFFFFL) << 1L;
/*     */           } else {
/* 136 */             m = bits & 0xFFFFFFFFFFFFFL | 0x10000000000000L;
/* 137 */           }  LispObject significand = Lisp.number(m);
/* 138 */           Fixnum exponent = Fixnum.getInstance(e - 1075);
/* 139 */           Fixnum sign = Fixnum.getInstance(s);
/* 140 */           return LispThread.currentThread().setValues(significand, exponent, sign);
/*     */         } 
/*     */ 
/*     */         
/* 144 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 149 */   private static final Primitive _FLOAT_BITS = new Primitive("%float-bits", Lisp.PACKAGE_SYS, true, "integer")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 155 */         if (arg instanceof SingleFloat) {
/* 156 */           int bits = Float.floatToIntBits(((SingleFloat)arg).value);
/* 157 */           BigInteger big = BigInteger.valueOf((bits >> 1));
/* 158 */           return Bignum.getInstance(big.shiftLeft(1).add(((bits & 0x1) == 1) ? BigInteger.ONE : BigInteger.ZERO));
/*     */         } 
/* 160 */         if (arg instanceof DoubleFloat) {
/* 161 */           long bits = Double.doubleToLongBits(((DoubleFloat)arg).value);
/* 162 */           BigInteger big = BigInteger.valueOf(bits >> 1L);
/* 163 */           return Bignum.getInstance(big.shiftLeft(1).add(((bits & 0x1L) == 1L) ? BigInteger.ONE : BigInteger.ZERO));
/*     */         } 
/* 165 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 170 */   private static final Primitive RATIONAL = new Primitive("rational", "number")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 176 */         if (arg instanceof SingleFloat)
/* 177 */           return ((SingleFloat)arg).rational(); 
/* 178 */         if (arg instanceof DoubleFloat)
/* 179 */           return ((DoubleFloat)arg).rational(); 
/* 180 */         if (arg.rationalp())
/* 181 */           return arg; 
/* 182 */         return Lisp.type_error(arg, Symbol.REAL);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 188 */   private static final Primitive FLOAT_RADIX = new Primitive("float-radix", "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 194 */         if (arg instanceof SingleFloat || arg instanceof DoubleFloat)
/* 195 */           return Fixnum.TWO; 
/* 196 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */   
/* 200 */   static final Fixnum FIXNUM_24 = Fixnum.getInstance(24);
/* 201 */   static final Fixnum FIXNUM_53 = Fixnum.getInstance(53);
/*     */ 
/*     */ 
/*     */   
/* 205 */   private static final Primitive FLOAT_DIGITS = new Primitive("float-digits", "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 211 */         if (arg instanceof SingleFloat)
/* 212 */           return FloatFunctions.FIXNUM_24; 
/* 213 */         if (arg instanceof DoubleFloat)
/* 214 */           return FloatFunctions.FIXNUM_53; 
/* 215 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 220 */   private static final Primitive SCALE_FLOAT = new Primitive("scale-float", "float integer")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 227 */         if (first instanceof SingleFloat) {
/* 228 */           float f = ((SingleFloat)first).value;
/* 229 */           int n = Fixnum.getValue(second);
/* 230 */           return new SingleFloat(f * (float)Math.pow(2.0D, n));
/*     */         } 
/* 232 */         if (first instanceof DoubleFloat) {
/* 233 */           double d = ((DoubleFloat)first).value;
/* 234 */           int n = Fixnum.getValue(second);
/* 235 */           return new DoubleFloat(d * Math.pow(2.0D, n));
/*     */         } 
/* 237 */         return Lisp.type_error(first, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 242 */   private static final Primitive COERCE_TO_SINGLE_FLOAT = new Primitive("coerce-to-single-float", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 248 */         return SingleFloat.coerceToFloat(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 253 */   private static final Primitive COERCE_TO_DOUBLE_FLOAT = new Primitive("coerce-to-double-float", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 259 */         return DoubleFloat.coerceToFloat(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 265 */   private static final Primitive FLOAT = new Primitive("float", "number &optional prototype")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 271 */         if (arg instanceof SingleFloat || arg instanceof DoubleFloat)
/* 272 */           return arg; 
/* 273 */         return SingleFloat.coerceToFloat(arg);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 279 */         if (second instanceof SingleFloat)
/* 280 */           return SingleFloat.coerceToFloat(first); 
/* 281 */         if (second instanceof DoubleFloat)
/* 282 */           return DoubleFloat.coerceToFloat(first); 
/* 283 */         return Lisp.type_error(second, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 289 */   private static final Primitive FLOATP = new Primitive("floatp", "object")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 294 */         if (arg instanceof SingleFloat)
/* 295 */           return Lisp.T; 
/* 296 */         if (arg instanceof DoubleFloat)
/* 297 */           return Lisp.T; 
/* 298 */         return Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 303 */   private static final Primitive SINGLE_FLOAT_BITS = new Primitive("single-float-bits", Lisp.PACKAGE_SYS, true, "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 309 */         if (arg instanceof SingleFloat) {
/* 310 */           SingleFloat f = (SingleFloat)arg;
/* 311 */           return Fixnum.getInstance(Float.floatToIntBits(f.value));
/*     */         } 
/* 313 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 318 */   private static final Primitive DOUBLE_FLOAT_HIGH_BITS = new Primitive("double-float-high-bits", Lisp.PACKAGE_SYS, true, "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 324 */         if (arg instanceof DoubleFloat) {
/* 325 */           DoubleFloat f = (DoubleFloat)arg;
/* 326 */           return Lisp.number(Double.doubleToLongBits(f.value) >>> 32L);
/*     */         } 
/* 328 */         return Lisp.type_error(arg, Symbol.DOUBLE_FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 333 */   private static final Primitive DOUBLE_FLOAT_LOW_BITS = new Primitive("double-float-low-bits", Lisp.PACKAGE_SYS, true, "float")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 339 */         if (arg instanceof DoubleFloat) {
/* 340 */           DoubleFloat f = (DoubleFloat)arg;
/* 341 */           return Lisp.number(Double.doubleToLongBits(f.value) & 0xFFFFFFFFL);
/*     */         } 
/* 343 */         return Lisp.type_error(arg, Symbol.DOUBLE_FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 348 */   private static final Primitive MAKE_SINGLE_FLOAT = new Primitive("make-single-float", Lisp.PACKAGE_SYS, true, "bits")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 355 */         if (arg instanceof Fixnum) {
/* 356 */           int bits = ((Fixnum)arg).value;
/* 357 */           return new SingleFloat(Float.intBitsToFloat(bits));
/*     */         } 
/* 359 */         if (arg instanceof Bignum) {
/* 360 */           long bits = ((Bignum)arg).value.longValue();
/* 361 */           return new SingleFloat(Float.intBitsToFloat((int)bits));
/*     */         } 
/* 363 */         return Lisp.type_error(arg, Symbol.INTEGER);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 368 */   private static final Primitive MAKE_DOUBLE_FLOAT = new Primitive("make-double-float", Lisp.PACKAGE_SYS, true, "bits")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 375 */         if (arg instanceof Fixnum) {
/* 376 */           long bits = ((Fixnum)arg).value;
/* 377 */           return new DoubleFloat(Double.longBitsToDouble(bits));
/*     */         } 
/* 379 */         if (arg instanceof Bignum) {
/* 380 */           long bits = ((Bignum)arg).value.longValue();
/* 381 */           return new DoubleFloat(Double.longBitsToDouble(bits));
/*     */         } 
/* 383 */         return Lisp.type_error(arg, Symbol.INTEGER);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 388 */   private static final Primitive FLOAT_INFINITY_P = new Primitive("float-infinity-p", Lisp.PACKAGE_SYS, true)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 395 */         if (arg instanceof SingleFloat)
/* 396 */           return Float.isInfinite(((SingleFloat)arg).value) ? Lisp.T : Lisp.NIL; 
/* 397 */         if (arg instanceof DoubleFloat)
/* 398 */           return Double.isInfinite(((DoubleFloat)arg).value) ? Lisp.T : Lisp.NIL; 
/* 399 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 404 */   private static final Primitive FLOAT_NAN_P = new Primitive("float-nan-p", Lisp.PACKAGE_SYS, true)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 411 */         if (arg instanceof SingleFloat)
/* 412 */           return Float.isNaN(((SingleFloat)arg).value) ? Lisp.T : Lisp.NIL; 
/* 413 */         if (arg instanceof DoubleFloat)
/* 414 */           return Double.isNaN(((DoubleFloat)arg).value) ? Lisp.T : Lisp.NIL; 
/* 415 */         return Lisp.type_error(arg, Symbol.FLOAT);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 420 */   private static final Primitive FLOAT_STRING = new Primitive("float-string", Lisp.PACKAGE_SYS, true)
/*     */     {
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*     */         String s1;
/*     */ 
/*     */         
/* 427 */         if (arg instanceof SingleFloat) {
/* 428 */           s1 = String.valueOf(((SingleFloat)arg).value);
/* 429 */         } else if (arg instanceof DoubleFloat) {
/* 430 */           s1 = String.valueOf(((DoubleFloat)arg).value);
/*     */         } else {
/* 432 */           return Lisp.type_error(arg, Symbol.FLOAT);
/* 433 */         }  int i = s1.indexOf('E');
/* 434 */         if (i < 0)
/* 435 */           return new SimpleString(s1); 
/* 436 */         String s2 = s1.substring(0, i);
/* 437 */         int exponent = Integer.parseInt(s1.substring(i + 1));
/* 438 */         if (exponent == 0)
/* 439 */           return new SimpleString(s2); 
/* 440 */         int index = s2.indexOf('.');
/* 441 */         if (index < 0)
/* 442 */           return new SimpleString(s2); 
/* 443 */         StringBuffer sb = new StringBuffer(s2);
/* 444 */         if (index >= 0) {
/* 445 */           sb.deleteCharAt(index);
/*     */         }
/* 447 */         if (exponent > 0) {
/* 448 */           int newIndex = index + exponent;
/* 449 */           if (newIndex < sb.length()) {
/* 450 */             sb.insert(newIndex, '.');
/* 451 */           } else if (newIndex == sb.length()) {
/* 452 */             sb.append('.');
/*     */           } else {
/*     */             
/* 455 */             while (newIndex > sb.length())
/* 456 */               sb.append('0'); 
/* 457 */             sb.append('.');
/*     */           } 
/*     */         } else {
/* 460 */           Debug.assertTrue((exponent < 0));
/* 461 */           int newIndex = index + exponent;
/* 462 */           while (newIndex < 0) {
/* 463 */             sb.insert(0, '0');
/* 464 */             newIndex++;
/*     */           } 
/* 466 */           sb.insert(0, '.');
/*     */         } 
/* 468 */         return new SimpleString(sb.toString());
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FloatFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */