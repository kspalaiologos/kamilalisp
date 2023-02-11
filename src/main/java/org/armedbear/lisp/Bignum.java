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
/*     */ public final class Bignum
/*     */   extends LispInteger
/*     */ {
/*     */   public final BigInteger value;
/*  45 */   private static BigInteger MOST_NEGATIVE_FIXNUM = BigInteger.valueOf(-2147483648L);
/*     */   
/*  47 */   private static BigInteger MOST_POSITIVE_FIXNUM = BigInteger.valueOf(2147483647L);
/*     */   
/*     */   public static LispInteger getInstance(long l) {
/*  50 */     if (-2147483648L <= l && l <= 2147483647L) {
/*  51 */       return Fixnum.getInstance(l);
/*     */     }
/*  53 */     return new Bignum(l);
/*     */   }
/*     */   
/*     */   public static LispInteger getInstance(BigInteger n) {
/*  57 */     if (MOST_NEGATIVE_FIXNUM.compareTo(n) < 0 || MOST_POSITIVE_FIXNUM
/*  58 */       .compareTo(n) > 0) {
/*  59 */       return new Bignum(n);
/*     */     }
/*  61 */     return Fixnum.getInstance(n.intValue());
/*     */   }
/*     */   
/*     */   public static LispInteger getInstance(String s, int radix) {
/*  65 */     BigInteger value = new BigInteger(s, radix);
/*     */     
/*  67 */     return getInstance(value);
/*     */   }
/*     */ 
/*     */   
/*     */   private Bignum(long l) {
/*  72 */     this.value = BigInteger.valueOf(l);
/*     */   }
/*     */ 
/*     */   
/*     */   private Bignum(BigInteger n) {
/*  77 */     this.value = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/*  83 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<Byte> c) {
/*  88 */     if (c == Byte.class || c == byte.class)
/*  89 */       return Byte.valueOf((byte)this.value.intValue()); 
/*  90 */     if (c == Short.class || c == short.class)
/*  91 */       return Short.valueOf((short)this.value.intValue()); 
/*  92 */     if (c == Integer.class || c == int.class)
/*  93 */       return Integer.valueOf(this.value.intValue()); 
/*  94 */     if (c == Long.class || c == long.class)
/*  95 */       return Long.valueOf(this.value.longValue()); 
/*  96 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 103 */     if (this.value.signum() > 0) {
/* 104 */       return Lisp.list(Symbol.INTEGER, new LispObject[] { new Bignum(2147483648L) });
/*     */     }
/* 106 */     return Symbol.BIGNUM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 112 */     return BuiltInClass.BIGNUM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 118 */     if (type instanceof Symbol) {
/*     */       
/* 120 */       if (type == Symbol.BIGNUM)
/* 121 */         return Lisp.T; 
/* 122 */       if (type == Symbol.INTEGER)
/* 123 */         return Lisp.T; 
/* 124 */       if (type == Symbol.RATIONAL)
/* 125 */         return Lisp.T; 
/* 126 */       if (type == Symbol.REAL)
/* 127 */         return Lisp.T; 
/* 128 */       if (type == Symbol.NUMBER)
/* 129 */         return Lisp.T; 
/* 130 */       if (type == Symbol.SIGNED_BYTE)
/* 131 */         return Lisp.T; 
/* 132 */       if (type == Symbol.UNSIGNED_BYTE) {
/* 133 */         return (this.value.signum() >= 0) ? Lisp.T : Lisp.NIL;
/*     */       }
/* 135 */     } else if (type instanceof LispClass) {
/*     */       
/* 137 */       if (type == BuiltInClass.BIGNUM)
/* 138 */         return Lisp.T; 
/* 139 */       if (type == BuiltInClass.INTEGER)
/* 140 */         return Lisp.T; 
/* 141 */       if (type == BuiltInClass.RATIONAL)
/* 142 */         return Lisp.T; 
/* 143 */       if (type == BuiltInClass.REAL)
/* 144 */         return Lisp.T; 
/* 145 */       if (type == BuiltInClass.NUMBER) {
/* 146 */         return Lisp.T;
/*     */       }
/* 148 */     } else if (type instanceof Cons) {
/*     */       
/* 150 */       if (type.equal(Lisp.UNSIGNED_BYTE_8))
/* 151 */         return Lisp.NIL; 
/* 152 */       if (type.equal(Lisp.UNSIGNED_BYTE_32)) {
/*     */         
/* 154 */         if (minusp())
/* 155 */           return Lisp.NIL; 
/* 156 */         return isLessThanOrEqualTo(Lisp.UNSIGNED_BYTE_32_MAX_VALUE) ? Lisp.T : Lisp.NIL;
/*     */       } 
/*     */     } 
/* 159 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean numberp() {
/* 165 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean integerp() {
/* 171 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean rationalp() {
/* 177 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean realp() {
/* 183 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(LispObject obj) {
/* 189 */     if (this == obj)
/* 190 */       return true; 
/* 191 */     if (obj instanceof Bignum)
/*     */     {
/* 193 */       if (this.value.equals(((Bignum)obj).value))
/* 194 */         return true; 
/*     */     }
/* 196 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 202 */     if (this == obj)
/* 203 */       return true; 
/* 204 */     if (obj instanceof Bignum)
/*     */     {
/* 206 */       if (this.value.equals(((Bignum)obj).value))
/* 207 */         return true; 
/*     */     }
/* 209 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 215 */     if (obj != null && obj.numberp())
/* 216 */       return isEqualTo(obj); 
/* 217 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ABS() {
/* 223 */     if (this.value.signum() >= 0)
/* 224 */       return this; 
/* 225 */     return new Bignum(this.value.negate());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NUMERATOR() {
/* 231 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject DENOMINATOR() {
/* 237 */     return Fixnum.ONE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean evenp() {
/* 243 */     return !this.value.testBit(0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean oddp() {
/* 249 */     return this.value.testBit(0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean plusp() {
/* 255 */     return (this.value.signum() > 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean minusp() {
/* 261 */     return (this.value.signum() < 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 267 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int intValue() {
/* 273 */     return this.value.intValue();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public long longValue() {
/* 279 */     return this.value.longValue();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public float floatValue() {
/* 285 */     float f = this.value.floatValue();
/* 286 */     if (Float.isInfinite(f)) {
/* 287 */       Lisp.error(new TypeError("The value " + princToString() + " is too large to be converted to a single float."));
/*     */     }
/* 289 */     return f;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public double doubleValue() {
/* 295 */     double d = this.value.doubleValue();
/* 296 */     if (Double.isInfinite(d)) {
/* 297 */       Lisp.error(new TypeError("The value " + princToString() + " is too large to be converted to a double float."));
/*     */     }
/* 299 */     return d;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static BigInteger getValue(LispObject obj) {
/* 305 */     if (obj instanceof Bignum)
/*     */     {
/* 307 */       return ((Bignum)obj).value;
/*     */     }
/* 309 */     Lisp.type_error(obj, Symbol.BIGNUM);
/*     */     
/* 311 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 317 */     return Lisp.number(this.value.add(BigInteger.ONE));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 323 */     return Lisp.number(this.value.subtract(BigInteger.ONE));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(int n) {
/* 329 */     return Lisp.number(this.value.add(BigInteger.valueOf(n)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 335 */     if (obj instanceof Fixnum)
/* 336 */       return Lisp.number(this.value.add(Fixnum.getBigInteger(obj))); 
/* 337 */     if (obj instanceof Bignum)
/* 338 */       return Lisp.number(this.value.add(((Bignum)obj).value)); 
/* 339 */     if (obj instanceof Ratio) {
/*     */       
/* 341 */       BigInteger numerator = ((Ratio)obj).numerator();
/* 342 */       BigInteger denominator = ((Ratio)obj).denominator();
/* 343 */       return Lisp.number(this.value.multiply(denominator).add(numerator), denominator);
/*     */     } 
/*     */     
/* 346 */     if (obj instanceof SingleFloat)
/* 347 */       return new SingleFloat(floatValue() + ((SingleFloat)obj).value); 
/* 348 */     if (obj instanceof DoubleFloat)
/* 349 */       return new DoubleFloat(doubleValue() + ((DoubleFloat)obj).value); 
/* 350 */     if (obj instanceof Complex) {
/*     */       
/* 352 */       Complex c = (Complex)obj;
/* 353 */       return Complex.getInstance(add(c.getRealPart()), c.getImaginaryPart());
/*     */     } 
/* 355 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 361 */     if (obj instanceof Fixnum)
/* 362 */       return Lisp.number(this.value.subtract(Fixnum.getBigInteger(obj))); 
/* 363 */     if (obj instanceof Bignum)
/* 364 */       return Lisp.number(this.value.subtract(((Bignum)obj).value)); 
/* 365 */     if (obj instanceof Ratio) {
/*     */       
/* 367 */       BigInteger numerator = ((Ratio)obj).numerator();
/* 368 */       BigInteger denominator = ((Ratio)obj).denominator();
/* 369 */       return Lisp.number(this.value.multiply(denominator).subtract(numerator), denominator);
/*     */     } 
/*     */     
/* 372 */     if (obj instanceof SingleFloat)
/* 373 */       return new SingleFloat(floatValue() - ((SingleFloat)obj).value); 
/* 374 */     if (obj instanceof DoubleFloat)
/* 375 */       return new DoubleFloat(doubleValue() - ((DoubleFloat)obj).value); 
/* 376 */     if (obj instanceof Complex) {
/*     */       
/* 378 */       Complex c = (Complex)obj;
/* 379 */       return Complex.getInstance(subtract(c.getRealPart()), Fixnum.ZERO
/* 380 */           .subtract(c.getImaginaryPart()));
/*     */     } 
/* 382 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(int n) {
/* 388 */     if (n == 0)
/* 389 */       return Fixnum.ZERO; 
/* 390 */     if (n == 1)
/* 391 */       return this; 
/* 392 */     return new Bignum(this.value.multiply(BigInteger.valueOf(n)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 398 */     if (obj instanceof Fixnum) {
/*     */       
/* 400 */       int n = ((Fixnum)obj).value;
/* 401 */       if (n == 0)
/* 402 */         return Fixnum.ZERO; 
/* 403 */       if (n == 1)
/* 404 */         return this; 
/* 405 */       return new Bignum(this.value.multiply(BigInteger.valueOf(n)));
/*     */     } 
/* 407 */     if (obj instanceof Bignum)
/* 408 */       return new Bignum(this.value.multiply(((Bignum)obj).value)); 
/* 409 */     if (obj instanceof Ratio) {
/*     */       
/* 411 */       BigInteger n = ((Ratio)obj).numerator();
/* 412 */       return Lisp.number(n.multiply(this.value), ((Ratio)obj).denominator());
/*     */     } 
/* 414 */     if (obj instanceof SingleFloat)
/* 415 */       return new SingleFloat(floatValue() * ((SingleFloat)obj).value); 
/* 416 */     if (obj instanceof DoubleFloat)
/* 417 */       return new DoubleFloat(doubleValue() * ((DoubleFloat)obj).value); 
/* 418 */     if (obj instanceof Complex) {
/*     */       
/* 420 */       Complex c = (Complex)obj;
/* 421 */       return Complex.getInstance(multiplyBy(c.getRealPart()), 
/* 422 */           multiplyBy(c.getImaginaryPart()));
/*     */     } 
/* 424 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/* 430 */     if (obj instanceof Fixnum)
/* 431 */       return Lisp.number(this.value, Fixnum.getBigInteger(obj)); 
/* 432 */     if (obj instanceof Bignum)
/* 433 */       return Lisp.number(this.value, ((Bignum)obj).value); 
/* 434 */     if (obj instanceof Ratio) {
/*     */       
/* 436 */       BigInteger d = ((Ratio)obj).denominator();
/* 437 */       return Lisp.number(d.multiply(this.value), ((Ratio)obj).numerator());
/*     */     } 
/* 439 */     if (obj instanceof SingleFloat)
/* 440 */       return new SingleFloat(floatValue() / ((SingleFloat)obj).value); 
/* 441 */     if (obj instanceof DoubleFloat)
/* 442 */       return new DoubleFloat(doubleValue() / ((DoubleFloat)obj).value); 
/* 443 */     if (obj instanceof Complex) {
/*     */       
/* 445 */       Complex c = (Complex)obj;
/* 446 */       LispObject realPart = c.getRealPart();
/* 447 */       LispObject imagPart = c.getImaginaryPart();
/*     */       
/* 449 */       LispObject denominator = realPart.multiplyBy(realPart).add(imagPart.multiplyBy(imagPart));
/* 450 */       return Complex.getInstance(multiplyBy(realPart).divideBy(denominator), Fixnum.ZERO
/* 451 */           .subtract(multiplyBy(imagPart).divideBy(denominator)));
/*     */     } 
/* 453 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 459 */     if (obj instanceof Bignum)
/* 460 */       return this.value.equals(((Bignum)obj).value); 
/* 461 */     if (obj instanceof SingleFloat)
/* 462 */       return isEqualTo(((SingleFloat)obj).rational()); 
/* 463 */     if (obj instanceof DoubleFloat)
/* 464 */       return isEqualTo(((DoubleFloat)obj).rational()); 
/* 465 */     if (obj.numberp())
/* 466 */       return false; 
/* 467 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 469 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 475 */     if (obj instanceof Bignum)
/* 476 */       return !this.value.equals(((Bignum)obj).value); 
/* 477 */     if (obj instanceof SingleFloat)
/* 478 */       return isNotEqualTo(((SingleFloat)obj).rational()); 
/* 479 */     if (obj instanceof DoubleFloat)
/* 480 */       return isNotEqualTo(((DoubleFloat)obj).rational()); 
/* 481 */     if (obj.numberp())
/* 482 */       return true; 
/* 483 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 485 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(LispObject obj) {
/* 491 */     if (obj instanceof Fixnum)
/* 492 */       return (this.value.compareTo(Fixnum.getBigInteger(obj)) < 0); 
/* 493 */     if (obj instanceof Bignum)
/* 494 */       return (this.value.compareTo(((Bignum)obj).value) < 0); 
/* 495 */     if (obj instanceof Ratio) {
/*     */       
/* 497 */       BigInteger n = this.value.multiply(((Ratio)obj).denominator());
/* 498 */       return (n.compareTo(((Ratio)obj).numerator()) < 0);
/*     */     } 
/* 500 */     if (obj instanceof SingleFloat)
/* 501 */       return isLessThan(((SingleFloat)obj).rational()); 
/* 502 */     if (obj instanceof DoubleFloat)
/* 503 */       return isLessThan(((DoubleFloat)obj).rational()); 
/* 504 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 506 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(LispObject obj) {
/* 512 */     if (obj instanceof Fixnum)
/* 513 */       return (this.value.compareTo(Fixnum.getBigInteger(obj)) > 0); 
/* 514 */     if (obj instanceof Bignum)
/* 515 */       return (this.value.compareTo(((Bignum)obj).value) > 0); 
/* 516 */     if (obj instanceof Ratio) {
/*     */       
/* 518 */       BigInteger n = this.value.multiply(((Ratio)obj).denominator());
/* 519 */       return (n.compareTo(((Ratio)obj).numerator()) > 0);
/*     */     } 
/* 521 */     if (obj instanceof SingleFloat)
/* 522 */       return isGreaterThan(((SingleFloat)obj).rational()); 
/* 523 */     if (obj instanceof DoubleFloat)
/* 524 */       return isGreaterThan(((DoubleFloat)obj).rational()); 
/* 525 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 527 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 533 */     if (obj instanceof Fixnum)
/* 534 */       return (this.value.compareTo(Fixnum.getBigInteger(obj)) <= 0); 
/* 535 */     if (obj instanceof Bignum)
/* 536 */       return (this.value.compareTo(((Bignum)obj).value) <= 0); 
/* 537 */     if (obj instanceof Ratio) {
/*     */       
/* 539 */       BigInteger n = this.value.multiply(((Ratio)obj).denominator());
/* 540 */       return (n.compareTo(((Ratio)obj).numerator()) <= 0);
/*     */     } 
/* 542 */     if (obj instanceof SingleFloat)
/* 543 */       return isLessThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 544 */     if (obj instanceof DoubleFloat)
/* 545 */       return isLessThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 546 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 548 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 554 */     if (obj instanceof Fixnum)
/* 555 */       return (this.value.compareTo(Fixnum.getBigInteger(obj)) >= 0); 
/* 556 */     if (obj instanceof Bignum)
/* 557 */       return (this.value.compareTo(((Bignum)obj).value) >= 0); 
/* 558 */     if (obj instanceof Ratio) {
/*     */       
/* 560 */       BigInteger n = this.value.multiply(((Ratio)obj).denominator());
/* 561 */       return (n.compareTo(((Ratio)obj).numerator()) >= 0);
/*     */     } 
/* 563 */     if (obj instanceof SingleFloat)
/* 564 */       return isGreaterThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 565 */     if (obj instanceof DoubleFloat)
/* 566 */       return isGreaterThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 567 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 569 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject truncate(LispObject obj) {
/*     */     LispObject value1, value2;
/* 575 */     LispThread thread = LispThread.currentThread();
/*     */ 
/*     */     
/*     */     try {
/* 579 */       if (obj instanceof Fixnum) {
/*     */         
/* 581 */         BigInteger divisor = ((Fixnum)obj).getBigInteger();
/* 582 */         BigInteger[] results = this.value.divideAndRemainder(divisor);
/* 583 */         BigInteger quotient = results[0];
/* 584 */         BigInteger remainder = results[1];
/* 585 */         value1 = Lisp.number(quotient);
/* 586 */         value2 = (remainder.signum() == 0) ? Fixnum.ZERO : Lisp.number(remainder);
/*     */       }
/* 588 */       else if (obj instanceof Bignum) {
/*     */         
/* 590 */         BigInteger divisor = ((Bignum)obj).value;
/* 591 */         BigInteger[] results = this.value.divideAndRemainder(divisor);
/* 592 */         BigInteger quotient = results[0];
/* 593 */         BigInteger remainder = results[1];
/* 594 */         value1 = Lisp.number(quotient);
/* 595 */         value2 = (remainder.signum() == 0) ? Fixnum.ZERO : Lisp.number(remainder);
/*     */       }
/* 597 */       else if (obj instanceof Ratio) {
/*     */         
/* 599 */         Ratio divisor = (Ratio)obj;
/*     */         
/* 601 */         LispObject quotient = multiplyBy(divisor.DENOMINATOR()).truncate(divisor.NUMERATOR());
/*     */         
/* 603 */         LispObject remainder = subtract(quotient.multiplyBy(divisor));
/* 604 */         value1 = quotient;
/* 605 */         value2 = remainder;
/*     */       } else {
/* 607 */         if (obj instanceof SingleFloat)
/*     */         {
/*     */ 
/*     */ 
/*     */           
/* 612 */           return (new SingleFloat(floatValue())).truncate(obj);
/*     */         }
/* 614 */         if (obj instanceof DoubleFloat)
/*     */         {
/*     */ 
/*     */ 
/*     */           
/* 619 */           return (new DoubleFloat(doubleValue())).truncate(obj);
/*     */         }
/*     */         
/* 622 */         return Lisp.type_error(obj, Symbol.REAL);
/*     */       } 
/* 624 */     } catch (ArithmeticException e) {
/*     */       
/* 626 */       if (obj.zerop()) {
/* 627 */         LispObject operands = new Cons(this, new Cons(obj));
/* 628 */         LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.TRUNCATE, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 633 */         return Lisp.error(new DivisionByZero(args));
/*     */       } 
/*     */       
/* 636 */       return Lisp.error(new ArithmeticError(e.getMessage()));
/*     */     } 
/* 638 */     return thread.setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ash(LispObject obj) {
/* 644 */     BigInteger n = this.value;
/* 645 */     if (obj instanceof Fixnum) {
/*     */       
/* 647 */       int count = ((Fixnum)obj).value;
/* 648 */       if (count == 0) {
/* 649 */         return this;
/*     */       }
/*     */       
/* 652 */       if (count == Integer.MIN_VALUE)
/* 653 */         return (n.signum() >= 0) ? Fixnum.ZERO : Fixnum.MINUS_ONE; 
/* 654 */       return Lisp.number(n.shiftLeft(count));
/*     */     } 
/* 656 */     if (obj instanceof Bignum) {
/*     */       
/* 658 */       BigInteger count = ((Bignum)obj).value;
/* 659 */       if (count.signum() > 0)
/* 660 */         return Lisp.error(new LispError("Can't represent result of left shift.")); 
/* 661 */       if (count.signum() < 0)
/* 662 */         return (n.signum() >= 0) ? Fixnum.ZERO : Fixnum.MINUS_ONE; 
/* 663 */       Debug.bug();
/*     */     } 
/* 665 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGNOT() {
/* 671 */     return Lisp.number(this.value.not());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGAND(int n) {
/* 677 */     if (n >= 0) {
/* 678 */       return Fixnum.getInstance(this.value.intValue() & n);
/*     */     }
/* 680 */     return Lisp.number(this.value.and(BigInteger.valueOf(n)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGAND(LispObject obj) {
/* 686 */     if (obj instanceof Fixnum) {
/*     */       
/* 688 */       int n = ((Fixnum)obj).value;
/* 689 */       if (n >= 0) {
/* 690 */         return Fixnum.getInstance(this.value.intValue() & n);
/*     */       }
/* 692 */       return Lisp.number(this.value.and(BigInteger.valueOf(n)));
/*     */     } 
/* 694 */     if (obj instanceof Bignum) {
/*     */       
/* 696 */       BigInteger n = ((Bignum)obj).value;
/* 697 */       return Lisp.number(this.value.and(n));
/*     */     } 
/*     */     
/* 700 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGIOR(int n) {
/* 706 */     return Lisp.number(this.value.or(BigInteger.valueOf(n)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGIOR(LispObject obj) {
/* 712 */     if (obj instanceof Fixnum) {
/*     */       
/* 714 */       BigInteger n = ((Fixnum)obj).getBigInteger();
/* 715 */       return Lisp.number(this.value.or(n));
/*     */     } 
/* 717 */     if (obj instanceof Bignum) {
/*     */       
/* 719 */       BigInteger n = ((Bignum)obj).value;
/* 720 */       return Lisp.number(this.value.or(n));
/*     */     } 
/*     */     
/* 723 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGXOR(int n) {
/* 729 */     return Lisp.number(this.value.xor(BigInteger.valueOf(n)));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGXOR(LispObject obj) {
/*     */     BigInteger n;
/* 736 */     if (obj instanceof Fixnum) {
/* 737 */       n = ((Fixnum)obj).getBigInteger();
/* 738 */     } else if (obj instanceof Bignum) {
/* 739 */       n = ((Bignum)obj).value;
/*     */     } else {
/* 741 */       return Lisp.type_error(obj, Symbol.INTEGER);
/* 742 */     }  return Lisp.number(this.value.xor(n));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LDB(int size, int position) {
/* 748 */     BigInteger n = this.value.shiftRight(position);
/* 749 */     BigInteger mask = BigInteger.ONE.shiftLeft(size).subtract(BigInteger.ONE);
/* 750 */     return Lisp.number(n.and(mask));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 756 */     return this.value.hashCode();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 762 */     LispThread thread = LispThread.currentThread();
/* 763 */     int base = Fixnum.getValue(Symbol.PRINT_BASE.symbolValue(thread));
/* 764 */     String s = this.value.toString(base).toUpperCase();
/* 765 */     if (Symbol.PRINT_RADIX.symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 767 */       StringBuffer sb = new StringBuffer();
/* 768 */       switch (base) {
/*     */         
/*     */         case 2:
/* 771 */           sb.append("#b");
/* 772 */           sb.append(s);
/*     */           break;
/*     */         case 8:
/* 775 */           sb.append("#o");
/* 776 */           sb.append(s);
/*     */           break;
/*     */         case 10:
/* 779 */           sb.append(s);
/* 780 */           sb.append('.');
/*     */           break;
/*     */         case 16:
/* 783 */           sb.append("#x");
/* 784 */           sb.append(s);
/*     */           break;
/*     */         default:
/* 787 */           sb.append('#');
/* 788 */           sb.append(String.valueOf(base));
/* 789 */           sb.append('r');
/* 790 */           sb.append(s);
/*     */           break;
/*     */       } 
/* 793 */       s = sb.toString();
/*     */     } 
/* 795 */     return s;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Bignum.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */