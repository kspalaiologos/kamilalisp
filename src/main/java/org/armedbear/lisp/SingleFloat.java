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
/*     */ public final class SingleFloat
/*     */   extends LispObject
/*     */ {
/*  42 */   public static final SingleFloat ZERO = new SingleFloat(0.0F);
/*  43 */   public static final SingleFloat MINUS_ZERO = new SingleFloat(-0.0F);
/*  44 */   public static final SingleFloat ONE = new SingleFloat(1.0F);
/*  45 */   public static final SingleFloat MINUS_ONE = new SingleFloat(-1.0F);
/*     */   
/*  47 */   public static final SingleFloat SINGLE_FLOAT_POSITIVE_INFINITY = new SingleFloat(Float.POSITIVE_INFINITY);
/*     */ 
/*     */   
/*  50 */   public static final SingleFloat SINGLE_FLOAT_NEGATIVE_INFINITY = new SingleFloat(Float.NEGATIVE_INFINITY);
/*     */   public final float value;
/*     */   
/*     */   static {
/*  54 */     Symbol.SINGLE_FLOAT_POSITIVE_INFINITY.initializeConstant(SINGLE_FLOAT_POSITIVE_INFINITY);
/*  55 */     Symbol.SINGLE_FLOAT_NEGATIVE_INFINITY.initializeConstant(SINGLE_FLOAT_NEGATIVE_INFINITY);
/*     */   }
/*     */   
/*     */   public static SingleFloat getInstance(float f) {
/*  59 */     if (f == 0.0F) {
/*  60 */       int bits = Float.floatToRawIntBits(f);
/*  61 */       if (bits < 0) {
/*  62 */         return MINUS_ZERO;
/*     */       }
/*  64 */       return ZERO;
/*     */     } 
/*  66 */     if (f == 1.0F)
/*  67 */       return ONE; 
/*  68 */     if (f == -1.0F) {
/*  69 */       return MINUS_ONE;
/*     */     }
/*  71 */     return new SingleFloat(f);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public SingleFloat(float value) {
/*  78 */     this.value = value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  84 */     return Symbol.SINGLE_FLOAT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  90 */     return BuiltInClass.SINGLE_FLOAT;
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
/* 102 */     if (typeSpecifier == Symbol.SINGLE_FLOAT)
/* 103 */       return Lisp.T; 
/* 104 */     if (typeSpecifier == Symbol.SHORT_FLOAT)
/* 105 */       return Lisp.T; 
/* 106 */     if (typeSpecifier == BuiltInClass.FLOAT)
/* 107 */       return Lisp.T; 
/* 108 */     if (typeSpecifier == BuiltInClass.SINGLE_FLOAT)
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
/* 130 */     if (obj instanceof SingleFloat) {
/* 131 */       if (this.value == 0.0F) {
/*     */ 
/*     */         
/* 134 */         float f = ((SingleFloat)obj).value;
/* 135 */         int bits = Float.floatToRawIntBits(f);
/* 136 */         return (bits == Float.floatToRawIntBits(this.value));
/*     */       } 
/* 138 */       if (this.value == ((SingleFloat)obj).value)
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
/* 149 */     if (obj instanceof SingleFloat) {
/* 150 */       if (this.value == 0.0F) {
/*     */         
/* 152 */         float f = ((SingleFloat)obj).value;
/* 153 */         int bits = Float.floatToRawIntBits(f);
/* 154 */         return (bits == Float.floatToRawIntBits(this.value));
/*     */       } 
/* 156 */       if (this.value == ((SingleFloat)obj).value)
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
/* 180 */     if (this.value > 0.0F)
/* 181 */       return this; 
/* 182 */     if (this.value == 0.0F)
/* 183 */       return ZERO; 
/* 184 */     return new SingleFloat(-this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean plusp() {
/* 190 */     return (this.value > 0.0F);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean minusp() {
/* 196 */     return (this.value < 0.0F);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 202 */     return (this.value == 0.0F);
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
/* 213 */     if (obj instanceof SingleFloat)
/* 214 */       return ((SingleFloat)obj).value; 
/* 215 */     Lisp.type_error(obj, Symbol.FLOAT);
/*     */     
/* 217 */     return 0.0D;
/*     */   }
/*     */ 
/*     */   
/*     */   public final float getValue() {
/* 222 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public float floatValue() {
/* 227 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public double doubleValue() {
/* 232 */     return this.value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/* 238 */     return Float.valueOf(this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<Float> c) {
/* 244 */     if (c == Float.class || c == float.class)
/* 245 */       return Float.valueOf(this.value); 
/* 246 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 252 */     return new SingleFloat(this.value + 1.0F);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 258 */     return new SingleFloat(this.value - 1.0F);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 264 */     if (obj instanceof Fixnum)
/* 265 */       return new SingleFloat(this.value + ((Fixnum)obj).value); 
/* 266 */     if (obj instanceof SingleFloat)
/* 267 */       return new SingleFloat(this.value + ((SingleFloat)obj).value); 
/* 268 */     if (obj instanceof DoubleFloat)
/* 269 */       return new DoubleFloat(this.value + ((DoubleFloat)obj).value); 
/* 270 */     if (obj instanceof Bignum)
/* 271 */       return new SingleFloat(this.value + ((Bignum)obj).floatValue()); 
/* 272 */     if (obj instanceof Ratio)
/* 273 */       return new SingleFloat(this.value + ((Ratio)obj).floatValue()); 
/* 274 */     if (obj instanceof Complex) {
/* 275 */       Complex c = (Complex)obj;
/* 276 */       return Complex.getInstance(add(c.getRealPart()), c.getImaginaryPart());
/*     */     } 
/* 278 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject negate() {
/* 284 */     if (this.value == 0.0F) {
/* 285 */       int bits = Float.floatToRawIntBits(this.value);
/* 286 */       return (bits < 0) ? ZERO : MINUS_ZERO;
/*     */     } 
/* 288 */     return new SingleFloat(-this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 294 */     if (obj instanceof Fixnum)
/* 295 */       return new SingleFloat(this.value - ((Fixnum)obj).value); 
/* 296 */     if (obj instanceof SingleFloat)
/* 297 */       return new SingleFloat(this.value - ((SingleFloat)obj).value); 
/* 298 */     if (obj instanceof DoubleFloat)
/* 299 */       return new DoubleFloat(this.value - ((DoubleFloat)obj).value); 
/* 300 */     if (obj instanceof Bignum)
/* 301 */       return new SingleFloat(this.value - ((Bignum)obj).floatValue()); 
/* 302 */     if (obj instanceof Ratio)
/* 303 */       return new SingleFloat(this.value - ((Ratio)obj).floatValue()); 
/* 304 */     if (obj instanceof Complex) {
/* 305 */       Complex c = (Complex)obj;
/* 306 */       return Complex.getInstance(subtract(c.getRealPart()), ZERO
/* 307 */           .subtract(c.getImaginaryPart()));
/*     */     } 
/* 309 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 315 */     if (obj instanceof Fixnum)
/* 316 */       return new SingleFloat(this.value * ((Fixnum)obj).value); 
/* 317 */     if (obj instanceof SingleFloat)
/* 318 */       return new SingleFloat(this.value * ((SingleFloat)obj).value); 
/* 319 */     if (obj instanceof DoubleFloat)
/* 320 */       return new DoubleFloat(this.value * ((DoubleFloat)obj).value); 
/* 321 */     if (obj instanceof Bignum)
/* 322 */       return new SingleFloat(this.value * ((Bignum)obj).floatValue()); 
/* 323 */     if (obj instanceof Ratio)
/* 324 */       return new SingleFloat(this.value * ((Ratio)obj).floatValue()); 
/* 325 */     if (obj instanceof Complex) {
/* 326 */       Complex c = (Complex)obj;
/* 327 */       return Complex.getInstance(multiplyBy(c.getRealPart()), 
/* 328 */           multiplyBy(c.getImaginaryPart()));
/*     */     } 
/* 330 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/* 336 */     if (obj instanceof Fixnum)
/* 337 */       return new SingleFloat(this.value / ((Fixnum)obj).value); 
/* 338 */     if (obj instanceof SingleFloat)
/* 339 */       return new SingleFloat(this.value / ((SingleFloat)obj).value); 
/* 340 */     if (obj instanceof DoubleFloat)
/* 341 */       return new DoubleFloat(this.value / ((DoubleFloat)obj).value); 
/* 342 */     if (obj instanceof Bignum)
/* 343 */       return new SingleFloat(this.value / ((Bignum)obj).floatValue()); 
/* 344 */     if (obj instanceof Ratio)
/* 345 */       return new SingleFloat(this.value / ((Ratio)obj).floatValue()); 
/* 346 */     if (obj instanceof Complex) {
/* 347 */       Complex c = (Complex)obj;
/* 348 */       LispObject re = c.getRealPart();
/* 349 */       LispObject im = c.getImaginaryPart();
/* 350 */       LispObject denom = re.multiplyBy(re).add(im.multiplyBy(im));
/* 351 */       LispObject resX = multiplyBy(re).divideBy(denom);
/*     */       
/* 353 */       LispObject resY = multiplyBy(Fixnum.MINUS_ONE).multiplyBy(im).divideBy(denom);
/* 354 */       return Complex.getInstance(resX, resY);
/*     */     } 
/* 356 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 362 */     if (obj instanceof Fixnum)
/* 363 */       return rational().isEqualTo(obj); 
/* 364 */     if (obj instanceof SingleFloat)
/* 365 */       return (this.value == ((SingleFloat)obj).value); 
/* 366 */     if (obj instanceof DoubleFloat)
/* 367 */       return (this.value == ((DoubleFloat)obj).value); 
/* 368 */     if (obj instanceof Bignum)
/* 369 */       return rational().isEqualTo(obj); 
/* 370 */     if (obj instanceof Ratio)
/* 371 */       return rational().isEqualTo(obj); 
/* 372 */     if (obj instanceof Complex)
/* 373 */       return obj.isEqualTo(this); 
/* 374 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 376 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 382 */     return !isEqualTo(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(LispObject obj) {
/* 388 */     if (obj instanceof Fixnum)
/* 389 */       return rational().isLessThan(obj); 
/* 390 */     if (obj instanceof SingleFloat)
/* 391 */       return (this.value < ((SingleFloat)obj).value); 
/* 392 */     if (obj instanceof DoubleFloat)
/* 393 */       return (this.value < ((DoubleFloat)obj).value); 
/* 394 */     if (obj instanceof Bignum)
/* 395 */       return rational().isLessThan(obj); 
/* 396 */     if (obj instanceof Ratio)
/* 397 */       return rational().isLessThan(obj); 
/* 398 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 400 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(LispObject obj) {
/* 406 */     if (obj instanceof Fixnum)
/* 407 */       return rational().isGreaterThan(obj); 
/* 408 */     if (obj instanceof SingleFloat)
/* 409 */       return (this.value > ((SingleFloat)obj).value); 
/* 410 */     if (obj instanceof DoubleFloat)
/* 411 */       return (this.value > ((DoubleFloat)obj).value); 
/* 412 */     if (obj instanceof Bignum)
/* 413 */       return rational().isGreaterThan(obj); 
/* 414 */     if (obj instanceof Ratio)
/* 415 */       return rational().isGreaterThan(obj); 
/* 416 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 418 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 424 */     if (obj instanceof Fixnum)
/* 425 */       return rational().isLessThanOrEqualTo(obj); 
/* 426 */     if (obj instanceof SingleFloat)
/* 427 */       return (this.value <= ((SingleFloat)obj).value); 
/* 428 */     if (obj instanceof DoubleFloat)
/* 429 */       return (this.value <= ((DoubleFloat)obj).value); 
/* 430 */     if (obj instanceof Bignum)
/* 431 */       return rational().isLessThanOrEqualTo(obj); 
/* 432 */     if (obj instanceof Ratio)
/* 433 */       return rational().isLessThanOrEqualTo(obj); 
/* 434 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 436 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 442 */     if (obj instanceof Fixnum)
/* 443 */       return rational().isGreaterThanOrEqualTo(obj); 
/* 444 */     if (obj instanceof SingleFloat)
/* 445 */       return (this.value >= ((SingleFloat)obj).value); 
/* 446 */     if (obj instanceof DoubleFloat)
/* 447 */       return (this.value >= ((DoubleFloat)obj).value); 
/* 448 */     if (obj instanceof Bignum)
/* 449 */       return rational().isGreaterThanOrEqualTo(obj); 
/* 450 */     if (obj instanceof Ratio)
/* 451 */       return rational().isGreaterThanOrEqualTo(obj); 
/* 452 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 454 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject truncate(LispObject obj) {
/* 463 */     if (obj instanceof Fixnum) {
/* 464 */       return truncate(new SingleFloat(((Fixnum)obj).value));
/*     */     }
/* 466 */     if (obj instanceof Bignum) {
/* 467 */       return truncate(new SingleFloat(((Bignum)obj).floatValue()));
/*     */     }
/* 469 */     if (obj instanceof Ratio) {
/* 470 */       return truncate(new SingleFloat(((Ratio)obj).floatValue()));
/*     */     }
/* 472 */     if (obj instanceof SingleFloat) {
/* 473 */       long m; LispThread thread = LispThread.currentThread();
/* 474 */       float divisor = ((SingleFloat)obj).value;
/* 475 */       float quotient = this.value / divisor;
/* 476 */       if (this.value != 0.0F)
/* 477 */         MathFunctions.OverUnderFlowCheck(quotient); 
/* 478 */       if (quotient >= -2.14748365E9F && quotient <= 2.14748365E9F) {
/* 479 */         int q = (int)quotient;
/* 480 */         return thread.setValues(Fixnum.getInstance(q), new SingleFloat(this.value - q * divisor));
/*     */       } 
/*     */ 
/*     */       
/* 484 */       int bits = Float.floatToRawIntBits(quotient);
/* 485 */       int s = (bits >> 31 == 0) ? 1 : -1;
/* 486 */       int e = bits >> 23 & 0xFF;
/*     */       
/* 488 */       if (e == 0) {
/* 489 */         m = ((bits & 0x7FFFFF) << 1);
/*     */       } else {
/* 491 */         m = (bits & 0x7FFFFF | 0x800000);
/* 492 */       }  LispObject significand = Lisp.number(m);
/* 493 */       Fixnum exponent = Fixnum.getInstance(e - 150);
/* 494 */       Fixnum sign = Fixnum.getInstance(s);
/* 495 */       LispObject result = significand;
/*     */       
/* 497 */       result = result.multiplyBy(MathFunctions.EXPT.execute(Fixnum.TWO, exponent));
/* 498 */       result = result.multiplyBy(sign);
/*     */       
/* 500 */       LispObject product = result.multiplyBy(obj);
/* 501 */       LispObject remainder = subtract(product);
/* 502 */       return thread.setValues(result, remainder);
/*     */     } 
/* 504 */     if (obj instanceof DoubleFloat) {
/* 505 */       long m; LispThread thread = LispThread.currentThread();
/* 506 */       double divisor = ((DoubleFloat)obj).value;
/* 507 */       double quotient = this.value / divisor;
/* 508 */       if (this.value != 0.0F)
/* 509 */         MathFunctions.OverUnderFlowCheck(quotient); 
/* 510 */       if (quotient >= -2.147483648E9D && quotient <= 2.147483647E9D) {
/* 511 */         int q = (int)quotient;
/* 512 */         return thread.setValues(Fixnum.getInstance(q), new DoubleFloat(this.value - q * divisor));
/*     */       } 
/*     */ 
/*     */       
/* 516 */       long bits = Double.doubleToRawLongBits(quotient);
/* 517 */       int s = (bits >> 63L == 0L) ? 1 : -1;
/* 518 */       int e = (int)(bits >> 52L & 0x7FFL);
/*     */       
/* 520 */       if (e == 0) {
/* 521 */         m = (bits & 0xFFFFFFFFFFFFFL) << 1L;
/*     */       } else {
/* 523 */         m = bits & 0xFFFFFFFFFFFFFL | 0x10000000000000L;
/* 524 */       }  LispObject significand = Lisp.number(m);
/* 525 */       Fixnum exponent = Fixnum.getInstance(e - 1075);
/* 526 */       Fixnum sign = Fixnum.getInstance(s);
/* 527 */       LispObject result = significand;
/*     */       
/* 529 */       result = result.multiplyBy(MathFunctions.EXPT.execute(Fixnum.TWO, exponent));
/* 530 */       result = result.multiplyBy(sign);
/*     */       
/* 532 */       LispObject product = result.multiplyBy(obj);
/* 533 */       LispObject remainder = subtract(product);
/* 534 */       return thread.setValues(result, remainder);
/*     */     } 
/* 536 */     return Lisp.type_error(obj, Symbol.REAL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 542 */     return Float.floatToIntBits(this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 548 */     if (this.value % 1.0F == 0.0F) {
/* 549 */       return (int)this.value & Integer.MAX_VALUE;
/*     */     }
/* 551 */     return hashCode() & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 557 */     if (this.value == Float.POSITIVE_INFINITY) {
/* 558 */       StringBuffer sb = new StringBuffer("#.");
/* 559 */       sb.append(Symbol.SINGLE_FLOAT_POSITIVE_INFINITY.printObject());
/* 560 */       return sb.toString();
/*     */     } 
/* 562 */     if (this.value == Float.NEGATIVE_INFINITY) {
/* 563 */       StringBuffer sb = new StringBuffer("#.");
/* 564 */       sb.append(Symbol.SINGLE_FLOAT_NEGATIVE_INFINITY.printObject());
/* 565 */       return sb.toString();
/*     */     } 
/*     */     
/* 568 */     LispThread thread = LispThread.currentThread();
/* 569 */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/*     */     
/* 571 */     if (this.value != this.value) {
/* 572 */       if (printReadably) {
/* 573 */         return "#.(CL:PROGN \"Comment: create a NaN.\" (CL:/ 0.0s0 0.0s0))";
/*     */       }
/* 575 */       return unreadableString("SINGLE-FLOAT NaN", false);
/*     */     } 
/* 577 */     String s1 = String.valueOf(this.value);
/* 578 */     if (!printReadably)
/* 579 */       if (Lisp.memq(Symbol.READ_DEFAULT_FLOAT_FORMAT.symbolValue(thread), 
/* 580 */           Lisp.list(Symbol.SINGLE_FLOAT, new LispObject[] {
/*     */ 
/*     */               
/*     */               Symbol.SHORT_FLOAT
/*     */ 
/*     */             
/*     */             })))
/* 587 */         return s1;  
/*     */     if (s1.indexOf('E') >= 0)
/*     */       return s1.replace('E', 'f'); 
/*     */     return s1.concat("f0"); } public LispObject rational() { long mantissa;
/*     */     BigInteger numerator, denominator;
/* 592 */     int bits = Float.floatToRawIntBits(this.value);
/* 593 */     int sign = (bits >> 31 == 0) ? 1 : -1;
/* 594 */     int storedExponent = bits >> 23 & 0xFF;
/*     */     
/* 596 */     if (storedExponent == 0) {
/* 597 */       mantissa = ((bits & 0x7FFFFF) << 1);
/*     */     } else {
/* 599 */       mantissa = (bits & 0x7FFFFF | 0x800000);
/* 600 */     }  if (mantissa == 0L)
/* 601 */       return Fixnum.ZERO; 
/* 602 */     if (sign < 0) {
/* 603 */       mantissa = -mantissa;
/*     */     }
/* 605 */     int exponent = storedExponent - 127;
/*     */     
/* 607 */     if (exponent < 0) {
/* 608 */       numerator = BigInteger.valueOf(mantissa);
/* 609 */       denominator = BigInteger.valueOf(1L).shiftLeft(23 - exponent);
/*     */     } else {
/* 611 */       numerator = BigInteger.valueOf(mantissa).shiftLeft(exponent);
/* 612 */       denominator = BigInteger.valueOf(8388608L);
/*     */     } 
/* 614 */     return Lisp.number(numerator, denominator); }
/*     */ 
/*     */ 
/*     */   
/*     */   public static SingleFloat coerceToFloat(LispObject obj) {
/* 619 */     if (obj instanceof Fixnum)
/* 620 */       return new SingleFloat(((Fixnum)obj).value); 
/* 621 */     if (obj instanceof SingleFloat)
/* 622 */       return (SingleFloat)obj; 
/* 623 */     if (obj instanceof DoubleFloat) {
/* 624 */       float result = (float)((DoubleFloat)obj).value;
/* 625 */       if (Float.isInfinite(result) && Lisp.TRAP_OVERFLOW) {
/* 626 */         Lisp.type_error(obj, Symbol.SINGLE_FLOAT);
/*     */       }
/* 628 */       return new SingleFloat(result);
/*     */     } 
/* 630 */     if (obj instanceof Bignum)
/* 631 */       return new SingleFloat(((Bignum)obj).floatValue()); 
/* 632 */     if (obj instanceof Ratio)
/* 633 */       return new SingleFloat(((Ratio)obj).floatValue()); 
/* 634 */     Lisp.error(new TypeError("The value " + obj.princToString() + " cannot be converted to type SINGLE-FLOAT."));
/*     */ 
/*     */     
/* 637 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SingleFloat.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */