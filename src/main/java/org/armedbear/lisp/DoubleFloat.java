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
/*     */ public final class DoubleFloat
/*     */   extends LispObject
/*     */ {
/*  42 */   public static final DoubleFloat ZERO = new DoubleFloat(0.0D);
/*  43 */   public static final DoubleFloat MINUS_ZERO = new DoubleFloat(-0.0D);
/*  44 */   public static final DoubleFloat ONE = new DoubleFloat(1.0D);
/*  45 */   public static final DoubleFloat MINUS_ONE = new DoubleFloat(-1.0D);
/*     */   
/*  47 */   public static final DoubleFloat DOUBLE_FLOAT_POSITIVE_INFINITY = new DoubleFloat(Double.POSITIVE_INFINITY);
/*     */ 
/*     */   
/*  50 */   public static final DoubleFloat DOUBLE_FLOAT_NEGATIVE_INFINITY = new DoubleFloat(Double.NEGATIVE_INFINITY);
/*     */   public final double value;
/*     */   
/*     */   static {
/*  54 */     Symbol.DOUBLE_FLOAT_POSITIVE_INFINITY.initializeConstant(DOUBLE_FLOAT_POSITIVE_INFINITY);
/*  55 */     Symbol.DOUBLE_FLOAT_NEGATIVE_INFINITY.initializeConstant(DOUBLE_FLOAT_NEGATIVE_INFINITY);
/*     */   }
/*     */   
/*     */   public static DoubleFloat getInstance(double d) {
/*  59 */     if (d == 0.0D) {
/*  60 */       long bits = Double.doubleToRawLongBits(d);
/*  61 */       if (bits < 0L) {
/*  62 */         return MINUS_ZERO;
/*     */       }
/*  64 */       return ZERO;
/*     */     } 
/*  66 */     if (d == 1.0D)
/*  67 */       return ONE; 
/*  68 */     if (d == -1.0D) {
/*  69 */       return MINUS_ONE;
/*     */     }
/*  71 */     return new DoubleFloat(d);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public DoubleFloat(double value) {
/*  78 */     this.value = value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  84 */     return Symbol.DOUBLE_FLOAT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  90 */     return BuiltInClass.DOUBLE_FLOAT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  96 */     if (typeSpecifier == Symbol.FLOAT)
/*  97 */       return Lisp.T; 
/*  98 */     if (typeSpecifier == Symbol.REAL)
/*  99 */       return Lisp.T; 
/* 100 */     if (typeSpecifier == Symbol.NUMBER)
/* 101 */       return Lisp.T; 
/* 102 */     if (typeSpecifier == Symbol.DOUBLE_FLOAT)
/* 103 */       return Lisp.T; 
/* 104 */     if (typeSpecifier == Symbol.LONG_FLOAT)
/* 105 */       return Lisp.T; 
/* 106 */     if (typeSpecifier == BuiltInClass.FLOAT)
/* 107 */       return Lisp.T; 
/* 108 */     if (typeSpecifier == BuiltInClass.DOUBLE_FLOAT)
/* 109 */       return Lisp.T; 
/* 110 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean numberp() {
/* 116 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean realp() {
/* 122 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(LispObject obj) {
/* 128 */     if (this == obj)
/* 129 */       return true; 
/* 130 */     if (obj instanceof DoubleFloat) {
/* 131 */       if (this.value == 0.0D) {
/*     */ 
/*     */         
/* 134 */         double d = ((DoubleFloat)obj).value;
/* 135 */         long bits = Double.doubleToRawLongBits(d);
/* 136 */         return (bits == Double.doubleToRawLongBits(this.value));
/*     */       } 
/* 138 */       if (this.value == ((DoubleFloat)obj).value)
/* 139 */         return true; 
/*     */     } 
/* 141 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 147 */     if (this == obj)
/* 148 */       return true; 
/* 149 */     if (obj instanceof DoubleFloat) {
/* 150 */       if (this.value == 0.0D) {
/*     */         
/* 152 */         double d = ((DoubleFloat)obj).value;
/* 153 */         long bits = Double.doubleToRawLongBits(d);
/* 154 */         return (bits == Double.doubleToRawLongBits(this.value));
/*     */       } 
/* 156 */       if (this.value == ((DoubleFloat)obj).value)
/* 157 */         return true; 
/*     */     } 
/* 159 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(int n) {
/* 166 */     return (this.value == n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 172 */     if (obj != null && obj.numberp())
/* 173 */       return isEqualTo(obj); 
/* 174 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ABS() {
/* 180 */     if (this.value > 0.0D)
/* 181 */       return this; 
/* 182 */     if (this.value == 0.0D)
/* 183 */       return ZERO; 
/* 184 */     return new DoubleFloat(-this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean plusp() {
/* 190 */     return (this.value > 0.0D);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean minusp() {
/* 196 */     return (this.value < 0.0D);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 202 */     return (this.value == 0.0D);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean floatp() {
/* 208 */     return true;
/*     */   }
/*     */ 
/*     */   
/*     */   public static double getValue(LispObject obj) {
/* 213 */     if (obj instanceof DoubleFloat)
/* 214 */       return ((DoubleFloat)obj).value; 
/* 215 */     Lisp.type_error(obj, Symbol.FLOAT);
/*     */     
/* 217 */     return 0.0D;
/*     */   }
/*     */ 
/*     */   
/*     */   public final double getValue() {
/* 222 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public double doubleValue() {
/* 227 */     return this.value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/* 233 */     return Double.valueOf(this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<Float> c) {
/* 239 */     if (c == Float.class || c == float.class)
/* 240 */       return Float.valueOf((float)this.value); 
/* 241 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 247 */     return new DoubleFloat(this.value + 1.0D);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 253 */     return new DoubleFloat(this.value - 1.0D);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject negate() {
/* 259 */     if (this.value == 0.0D) {
/* 260 */       long bits = Double.doubleToRawLongBits(this.value);
/* 261 */       return (bits < 0L) ? ZERO : MINUS_ZERO;
/*     */     } 
/* 263 */     return new DoubleFloat(-this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 269 */     if (obj instanceof Fixnum)
/* 270 */       return new DoubleFloat(this.value + ((Fixnum)obj).value); 
/* 271 */     if (obj instanceof SingleFloat)
/* 272 */       return new DoubleFloat(this.value + ((SingleFloat)obj).value); 
/* 273 */     if (obj instanceof DoubleFloat)
/* 274 */       return new DoubleFloat(this.value + ((DoubleFloat)obj).value); 
/* 275 */     if (obj instanceof Bignum)
/* 276 */       return new DoubleFloat(this.value + ((Bignum)obj).doubleValue()); 
/* 277 */     if (obj instanceof Ratio)
/* 278 */       return new DoubleFloat(this.value + ((Ratio)obj).doubleValue()); 
/* 279 */     if (obj instanceof Complex) {
/* 280 */       Complex c = (Complex)obj;
/* 281 */       return Complex.getInstance(add(c.getRealPart()), c.getImaginaryPart());
/*     */     } 
/* 283 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 289 */     if (obj instanceof Fixnum)
/* 290 */       return new DoubleFloat(this.value - ((Fixnum)obj).value); 
/* 291 */     if (obj instanceof SingleFloat)
/* 292 */       return new DoubleFloat(this.value - ((SingleFloat)obj).value); 
/* 293 */     if (obj instanceof DoubleFloat)
/* 294 */       return new DoubleFloat(this.value - ((DoubleFloat)obj).value); 
/* 295 */     if (obj instanceof Bignum)
/* 296 */       return new DoubleFloat(this.value - ((Bignum)obj).doubleValue()); 
/* 297 */     if (obj instanceof Ratio)
/* 298 */       return new DoubleFloat(this.value - ((Ratio)obj).doubleValue()); 
/* 299 */     if (obj instanceof Complex) {
/* 300 */       Complex c = (Complex)obj;
/* 301 */       return Complex.getInstance(subtract(c.getRealPart()), ZERO
/* 302 */           .subtract(c.getImaginaryPart()));
/*     */     } 
/* 304 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 310 */     if (obj instanceof Fixnum)
/* 311 */       return new DoubleFloat(this.value * ((Fixnum)obj).value); 
/* 312 */     if (obj instanceof SingleFloat)
/* 313 */       return new DoubleFloat(this.value * ((SingleFloat)obj).value); 
/* 314 */     if (obj instanceof DoubleFloat)
/* 315 */       return new DoubleFloat(this.value * ((DoubleFloat)obj).value); 
/* 316 */     if (obj instanceof Bignum)
/* 317 */       return new DoubleFloat(this.value * ((Bignum)obj).doubleValue()); 
/* 318 */     if (obj instanceof Ratio)
/* 319 */       return new DoubleFloat(this.value * ((Ratio)obj).doubleValue()); 
/* 320 */     if (obj instanceof Complex) {
/* 321 */       Complex c = (Complex)obj;
/* 322 */       return Complex.getInstance(multiplyBy(c.getRealPart()), 
/* 323 */           multiplyBy(c.getImaginaryPart()));
/*     */     } 
/* 325 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/* 331 */     if (obj instanceof Fixnum)
/* 332 */       return new DoubleFloat(this.value / ((Fixnum)obj).value); 
/* 333 */     if (obj instanceof SingleFloat)
/* 334 */       return new DoubleFloat(this.value / ((SingleFloat)obj).value); 
/* 335 */     if (obj instanceof DoubleFloat)
/* 336 */       return new DoubleFloat(this.value / ((DoubleFloat)obj).value); 
/* 337 */     if (obj instanceof Bignum)
/* 338 */       return new DoubleFloat(this.value / ((Bignum)obj).doubleValue()); 
/* 339 */     if (obj instanceof Ratio)
/* 340 */       return new DoubleFloat(this.value / ((Ratio)obj).doubleValue()); 
/* 341 */     if (obj instanceof Complex) {
/* 342 */       Complex c = (Complex)obj;
/* 343 */       LispObject re = c.getRealPart();
/* 344 */       LispObject im = c.getImaginaryPart();
/* 345 */       LispObject denom = re.multiplyBy(re).add(im.multiplyBy(im));
/* 346 */       LispObject resX = multiplyBy(re).divideBy(denom);
/*     */       
/* 348 */       LispObject resY = multiplyBy(Fixnum.MINUS_ONE).multiplyBy(im).divideBy(denom);
/* 349 */       return Complex.getInstance(resX, resY);
/*     */     } 
/* 351 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 357 */     if (obj instanceof Fixnum)
/* 358 */       return (this.value == ((Fixnum)obj).value); 
/* 359 */     if (obj instanceof SingleFloat)
/* 360 */       return (this.value == ((SingleFloat)obj).value); 
/* 361 */     if (obj instanceof DoubleFloat)
/* 362 */       return (this.value == ((DoubleFloat)obj).value); 
/* 363 */     if (obj instanceof Bignum)
/* 364 */       return rational().isEqualTo(obj); 
/* 365 */     if (obj instanceof Ratio)
/* 366 */       return rational().isEqualTo(obj); 
/* 367 */     if (obj instanceof Complex)
/* 368 */       return obj.isEqualTo(this); 
/* 369 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 371 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 377 */     return !isEqualTo(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(LispObject obj) {
/* 383 */     if (obj instanceof Fixnum)
/* 384 */       return (this.value < ((Fixnum)obj).value); 
/* 385 */     if (obj instanceof SingleFloat)
/* 386 */       return (this.value < ((SingleFloat)obj).value); 
/* 387 */     if (obj instanceof DoubleFloat)
/* 388 */       return (this.value < ((DoubleFloat)obj).value); 
/* 389 */     if (obj instanceof Bignum)
/* 390 */       return rational().isLessThan(obj); 
/* 391 */     if (obj instanceof Ratio)
/* 392 */       return rational().isLessThan(obj); 
/* 393 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 395 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(LispObject obj) {
/* 401 */     if (obj instanceof Fixnum)
/* 402 */       return (this.value > ((Fixnum)obj).value); 
/* 403 */     if (obj instanceof SingleFloat)
/* 404 */       return (this.value > ((SingleFloat)obj).value); 
/* 405 */     if (obj instanceof DoubleFloat)
/* 406 */       return (this.value > ((DoubleFloat)obj).value); 
/* 407 */     if (obj instanceof Bignum)
/* 408 */       return rational().isGreaterThan(obj); 
/* 409 */     if (obj instanceof Ratio)
/* 410 */       return rational().isGreaterThan(obj); 
/* 411 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 413 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 419 */     if (obj instanceof Fixnum)
/* 420 */       return (this.value <= ((Fixnum)obj).value); 
/* 421 */     if (obj instanceof SingleFloat)
/* 422 */       return (this.value <= ((SingleFloat)obj).value); 
/* 423 */     if (obj instanceof DoubleFloat)
/* 424 */       return (this.value <= ((DoubleFloat)obj).value); 
/* 425 */     if (obj instanceof Bignum)
/* 426 */       return rational().isLessThanOrEqualTo(obj); 
/* 427 */     if (obj instanceof Ratio)
/* 428 */       return rational().isLessThanOrEqualTo(obj); 
/* 429 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 431 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 437 */     if (obj instanceof Fixnum)
/* 438 */       return (this.value >= ((Fixnum)obj).value); 
/* 439 */     if (obj instanceof SingleFloat)
/* 440 */       return (this.value >= ((SingleFloat)obj).value); 
/* 441 */     if (obj instanceof DoubleFloat)
/* 442 */       return (this.value >= ((DoubleFloat)obj).value); 
/* 443 */     if (obj instanceof Bignum)
/* 444 */       return rational().isGreaterThanOrEqualTo(obj); 
/* 445 */     if (obj instanceof Ratio)
/* 446 */       return rational().isGreaterThanOrEqualTo(obj); 
/* 447 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 449 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject truncate(LispObject obj) {
/* 458 */     if (obj instanceof Fixnum) {
/* 459 */       return truncate(new DoubleFloat(((Fixnum)obj).value));
/*     */     }
/* 461 */     if (obj instanceof Bignum) {
/* 462 */       return truncate(new DoubleFloat(((Bignum)obj).doubleValue()));
/*     */     }
/* 464 */     if (obj instanceof Ratio) {
/* 465 */       return truncate(new DoubleFloat(((Ratio)obj).doubleValue()));
/*     */     }
/* 467 */     if (obj instanceof SingleFloat) {
/* 468 */       long m; LispThread thread = LispThread.currentThread();
/* 469 */       double divisor = ((SingleFloat)obj).value;
/* 470 */       double quotient = this.value / divisor;
/* 471 */       if (this.value != 0.0D)
/* 472 */         MathFunctions.OverUnderFlowCheck(quotient); 
/* 473 */       if (quotient >= -2.147483648E9D && quotient <= 2.147483647E9D) {
/* 474 */         int q = (int)quotient;
/* 475 */         return thread.setValues(Fixnum.getInstance(q), new DoubleFloat(this.value - q * divisor));
/*     */       } 
/*     */ 
/*     */       
/* 479 */       long bits = Double.doubleToRawLongBits(quotient);
/* 480 */       int s = (bits >> 63L == 0L) ? 1 : -1;
/* 481 */       int e = (int)(bits >> 52L & 0x7FFL);
/*     */       
/* 483 */       if (e == 0) {
/* 484 */         m = (bits & 0xFFFFFFFFFFFFFL) << 1L;
/*     */       } else {
/* 486 */         m = bits & 0xFFFFFFFFFFFFFL | 0x10000000000000L;
/* 487 */       }  LispObject significand = Lisp.number(m);
/* 488 */       Fixnum exponent = Fixnum.getInstance(e - 1075);
/* 489 */       Fixnum sign = Fixnum.getInstance(s);
/* 490 */       LispObject result = significand;
/*     */       
/* 492 */       result = result.multiplyBy(MathFunctions.EXPT.execute(Fixnum.TWO, exponent));
/* 493 */       result = result.multiplyBy(sign);
/*     */       
/* 495 */       LispObject product = result.multiplyBy(obj);
/* 496 */       LispObject remainder = subtract(product);
/* 497 */       return thread.setValues(result, remainder);
/*     */     } 
/* 499 */     if (obj instanceof DoubleFloat) {
/*     */       long m;
/* 501 */       LispThread thread = LispThread.currentThread();
/* 502 */       double divisor = ((DoubleFloat)obj).value;
/*     */       
/* 504 */       double quotient = this.value / divisor;
/* 505 */       if (this.value != 0.0D) {
/* 506 */         MathFunctions.OverUnderFlowCheck(quotient);
/*     */       }
/* 508 */       if (quotient >= -2.147483648E9D && quotient <= 2.147483647E9D) {
/* 509 */         int q = (int)quotient;
/* 510 */         return thread.setValues(Fixnum.getInstance(q), new DoubleFloat(this.value - q * divisor));
/*     */       } 
/*     */ 
/*     */       
/* 514 */       long bits = Double.doubleToRawLongBits(quotient);
/* 515 */       int s = (bits >> 63L == 0L) ? 1 : -1;
/* 516 */       int e = (int)(bits >> 52L & 0x7FFL);
/*     */       
/* 518 */       if (e == 0) {
/* 519 */         m = (bits & 0xFFFFFFFFFFFFFL) << 1L;
/*     */       } else {
/* 521 */         m = bits & 0xFFFFFFFFFFFFFL | 0x10000000000000L;
/* 522 */       }  LispObject significand = Lisp.number(m);
/*     */       
/* 524 */       Fixnum exponent = Fixnum.getInstance(e - 1075);
/*     */       
/* 526 */       Fixnum sign = Fixnum.getInstance(s);
/*     */       
/* 528 */       LispObject result = significand;
/*     */ 
/*     */       
/* 531 */       result = result.multiplyBy(MathFunctions.EXPT.execute(Fixnum.TWO, exponent));
/*     */ 
/*     */ 
/*     */       
/* 535 */       result = result.truncate(Fixnum.ONE);
/* 536 */       LispObject remainder = coerceToFloat(thread._values[1]);
/*     */       
/* 538 */       result = result.multiplyBy(sign);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 544 */       return thread.setValues(result, remainder);
/*     */     } 
/* 546 */     return Lisp.type_error(obj, Symbol.REAL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 552 */     long bits = Double.doubleToLongBits(this.value);
/* 553 */     return (int)(bits ^ bits >>> 32L);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 559 */     if (this.value % 1.0D == 0.0D) {
/* 560 */       return (int)this.value & Integer.MAX_VALUE;
/*     */     }
/* 562 */     return hashCode() & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 568 */     if (this.value == Double.POSITIVE_INFINITY) {
/* 569 */       StringBuilder sb = new StringBuilder("#.");
/* 570 */       sb.append(Symbol.DOUBLE_FLOAT_POSITIVE_INFINITY.printObject());
/* 571 */       return sb.toString();
/*     */     } 
/* 573 */     if (this.value == Double.NEGATIVE_INFINITY) {
/* 574 */       StringBuilder sb = new StringBuilder("#.");
/* 575 */       sb.append(Symbol.DOUBLE_FLOAT_NEGATIVE_INFINITY.printObject());
/* 576 */       return sb.toString();
/*     */     } 
/*     */     
/* 579 */     LispThread thread = LispThread.currentThread();
/* 580 */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/*     */     
/* 582 */     if (this.value != this.value) {
/* 583 */       if (printReadably) {
/* 584 */         return "#.(CL:PROGN \"Comment: create a NaN.\" (CL:/ 0.0d0 0.0d0))";
/*     */       }
/* 586 */       return unreadableString("DOUBLE-FLOAT NaN", false);
/*     */     } 
/* 588 */     String s1 = String.valueOf(this.value);
/* 589 */     if (!printReadably)
/* 590 */       if (Lisp.memq(Symbol.READ_DEFAULT_FLOAT_FORMAT.symbolValue(thread), 
/* 591 */           Lisp.list(Symbol.DOUBLE_FLOAT, new LispObject[] {
/*     */ 
/*     */               
/*     */               Symbol.LONG_FLOAT
/*     */ 
/*     */             
/*     */             })))
/* 598 */         return s1;  
/*     */     if (s1.indexOf('E') >= 0)
/*     */       return s1.replace('E', 'd'); 
/*     */     return s1.concat("d0"); } public LispObject rational() { long mantissa;
/*     */     BigInteger numerator, denominator;
/* 603 */     long bits = Double.doubleToRawLongBits(this.value);
/* 604 */     int sign = (bits >> 63L == 0L) ? 1 : -1;
/* 605 */     int storedExponent = (int)(bits >> 52L & 0x7FFL);
/*     */     
/* 607 */     if (storedExponent == 0) {
/* 608 */       mantissa = (bits & 0xFFFFFFFFFFFFFL) << 1L;
/*     */     } else {
/* 610 */       mantissa = bits & 0xFFFFFFFFFFFFFL | 0x10000000000000L;
/* 611 */     }  if (mantissa == 0L)
/* 612 */       return Fixnum.ZERO; 
/* 613 */     if (sign < 0) {
/* 614 */       mantissa = -mantissa;
/*     */     }
/* 616 */     int exponent = storedExponent - 1023;
/*     */     
/* 618 */     if (exponent < 0) {
/* 619 */       numerator = BigInteger.valueOf(mantissa);
/* 620 */       denominator = BigInteger.valueOf(1L).shiftLeft(52 - exponent);
/*     */     } else {
/* 622 */       numerator = BigInteger.valueOf(mantissa).shiftLeft(exponent);
/* 623 */       denominator = BigInteger.valueOf(4503599627370496L);
/*     */     } 
/* 625 */     return Lisp.number(numerator, denominator); }
/*     */ 
/*     */ 
/*     */   
/*     */   public static DoubleFloat coerceToFloat(LispObject obj) {
/* 630 */     if (obj instanceof DoubleFloat)
/* 631 */       return (DoubleFloat)obj; 
/* 632 */     if (obj instanceof Fixnum)
/* 633 */       return new DoubleFloat(((Fixnum)obj).value); 
/* 634 */     if (obj instanceof Bignum)
/* 635 */       return new DoubleFloat(((Bignum)obj).doubleValue()); 
/* 636 */     if (obj instanceof SingleFloat)
/* 637 */       return new DoubleFloat(((SingleFloat)obj).value); 
/* 638 */     if (obj instanceof Ratio)
/* 639 */       return new DoubleFloat(((Ratio)obj).doubleValue()); 
/* 640 */     Lisp.error(new TypeError("The value " + obj.princToString() + " cannot be converted to type DOUBLE-FLOAT."));
/*     */ 
/*     */     
/* 643 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/DoubleFloat.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */