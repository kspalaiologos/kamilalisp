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
/*     */ public final class Fixnum
/*     */   extends LispInteger
/*     */ {
/*     */   public static final int MAX_POS_CACHE = 256;
/*  43 */   public static final Fixnum[] constants = new Fixnum[256];
/*     */   
/*     */   static {
/*  46 */     for (int i = 0; i < 256; i++)
/*  47 */       constants[i] = new Fixnum(i); 
/*     */   }
/*     */   
/*  50 */   public static final Fixnum ZERO = constants[0];
/*  51 */   public static final Fixnum ONE = constants[1];
/*  52 */   public static final Fixnum TWO = constants[2];
/*  53 */   public static final Fixnum THREE = constants[3];
/*     */   
/*  55 */   public static final Fixnum MINUS_ONE = getInstance(-1);
/*     */   public final int value;
/*     */   
/*     */   public static Fixnum getInstance(int n) {
/*  59 */     return (n >= 0 && n < 256) ? constants[n] : new Fixnum(n);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private Fixnum(int value) {
/*  67 */     this.value = value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/*  73 */     return Integer.valueOf(this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<Byte> c) {
/*  79 */     if (c == Byte.class || c == byte.class)
/*  80 */       return Byte.valueOf((byte)this.value); 
/*  81 */     if (c == Short.class || c == short.class)
/*  82 */       return Short.valueOf((short)this.value); 
/*  83 */     if (c == Long.class || c == long.class)
/*  84 */       return Long.valueOf(this.value); 
/*  85 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  91 */     if (this.value == 0 || this.value == 1)
/*  92 */       return Symbol.BIT; 
/*  93 */     if (this.value > 1)
/*  94 */       return Lisp.list(Symbol.INTEGER, new LispObject[] { ZERO, getInstance(2147483647) }); 
/*  95 */     return Symbol.FIXNUM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 101 */     return BuiltInClass.FIXNUM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/* 107 */     StringBuffer sb = new StringBuffer("The fixnum ");
/* 108 */     sb.append(this.value);
/* 109 */     return new SimpleString(sb);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 115 */     if (type instanceof Symbol) {
/*     */       
/* 117 */       if (type == Symbol.FIXNUM)
/* 118 */         return Lisp.T; 
/* 119 */       if (type == Symbol.INTEGER)
/* 120 */         return Lisp.T; 
/* 121 */       if (type == Symbol.RATIONAL)
/* 122 */         return Lisp.T; 
/* 123 */       if (type == Symbol.REAL)
/* 124 */         return Lisp.T; 
/* 125 */       if (type == Symbol.NUMBER)
/* 126 */         return Lisp.T; 
/* 127 */       if (type == Symbol.SIGNED_BYTE)
/* 128 */         return Lisp.T; 
/* 129 */       if (type == Symbol.UNSIGNED_BYTE)
/* 130 */         return (this.value >= 0) ? Lisp.T : Lisp.NIL; 
/* 131 */       if (type == Symbol.BIT) {
/* 132 */         return (this.value == 0 || this.value == 1) ? Lisp.T : Lisp.NIL;
/*     */       }
/* 134 */     } else if (type instanceof LispClass) {
/*     */       
/* 136 */       if (type == BuiltInClass.FIXNUM)
/* 137 */         return Lisp.T; 
/* 138 */       if (type == BuiltInClass.INTEGER)
/* 139 */         return Lisp.T; 
/* 140 */       if (type == BuiltInClass.RATIONAL)
/* 141 */         return Lisp.T; 
/* 142 */       if (type == BuiltInClass.REAL)
/* 143 */         return Lisp.T; 
/* 144 */       if (type == BuiltInClass.NUMBER) {
/* 145 */         return Lisp.T;
/*     */       }
/* 147 */     } else if (type instanceof Cons) {
/*     */       
/* 149 */       if (type.equal(Lisp.UNSIGNED_BYTE_8))
/* 150 */         return (this.value >= 0 && this.value <= 255) ? Lisp.T : Lisp.NIL; 
/* 151 */       if (type.equal(Lisp.UNSIGNED_BYTE_16))
/* 152 */         return (this.value >= 0 && this.value <= 65535) ? Lisp.T : Lisp.NIL; 
/* 153 */       if (type.equal(Lisp.UNSIGNED_BYTE_32))
/* 154 */         return (this.value >= 0) ? Lisp.T : Lisp.NIL; 
/*     */     } 
/* 156 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean numberp() {
/* 162 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean integerp() {
/* 168 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean rationalp() {
/* 174 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean realp() {
/* 180 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(int n) {
/* 186 */     return (this.value == n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(LispObject obj) {
/* 192 */     if (this == obj)
/* 193 */       return true; 
/* 194 */     if (obj instanceof Fixnum)
/*     */     {
/* 196 */       if (this.value == ((Fixnum)obj).value)
/* 197 */         return true; 
/*     */     }
/* 199 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(int n) {
/* 205 */     return (this.value == n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 211 */     if (this == obj)
/* 212 */       return true; 
/* 213 */     if (obj instanceof Fixnum)
/*     */     {
/* 215 */       if (this.value == ((Fixnum)obj).value)
/* 216 */         return true; 
/*     */     }
/* 218 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(int n) {
/* 224 */     return (this.value == n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 230 */     if (obj != null && obj.numberp())
/* 231 */       return isEqualTo(obj); 
/* 232 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ABS() {
/* 238 */     if (this.value >= 0)
/* 239 */       return this; 
/* 240 */     return LispInteger.getInstance(-(this.value));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NUMERATOR() {
/* 246 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject DENOMINATOR() {
/* 252 */     return ONE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean evenp() {
/* 258 */     return ((this.value & 0x1) == 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean oddp() {
/* 264 */     return ((this.value & 0x1) != 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean plusp() {
/* 270 */     return (this.value > 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean minusp() {
/* 276 */     return (this.value < 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 282 */     return (this.value == 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public static int getValue(LispObject obj) {
/* 287 */     if (obj instanceof Fixnum) return ((Fixnum)obj).value; 
/* 288 */     Lisp.type_error(obj, Symbol.FIXNUM);
/*     */     
/* 290 */     return 0;
/*     */   }
/*     */ 
/*     */   
/*     */   public float floatValue() {
/* 295 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public double doubleValue() {
/* 300 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public static int getInt(LispObject obj) {
/* 305 */     if (obj instanceof Fixnum) return ((Fixnum)obj).value; 
/* 306 */     Lisp.type_error(obj, Symbol.FIXNUM);
/*     */     
/* 308 */     return 0;
/*     */   }
/*     */ 
/*     */   
/*     */   public static BigInteger getBigInteger(LispObject obj) {
/* 313 */     if (obj instanceof Fixnum) return BigInteger.valueOf(((Fixnum)obj).value); 
/* 314 */     Lisp.type_error(obj, Symbol.FIXNUM);
/*     */     
/* 316 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int intValue() {
/* 322 */     return this.value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public long longValue() {
/* 328 */     return this.value;
/*     */   }
/*     */ 
/*     */   
/*     */   public final BigInteger getBigInteger() {
/* 333 */     return BigInteger.valueOf(this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 339 */     return LispInteger.getInstance(1L + this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 345 */     return LispInteger.getInstance(-1L + this.value);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject negate() {
/* 351 */     return LispInteger.getInstance(-(this.value));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(int n) {
/* 357 */     return LispInteger.getInstance(this.value + n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 363 */     if (obj instanceof Fixnum) {
/*     */       
/* 365 */       long result = this.value + ((Fixnum)obj).value;
/* 366 */       return LispInteger.getInstance(result);
/*     */     } 
/* 368 */     if (obj instanceof Bignum)
/* 369 */       return Lisp.number(getBigInteger().add(((Bignum)obj).value)); 
/* 370 */     if (obj instanceof Ratio) {
/*     */       
/* 372 */       BigInteger numerator = ((Ratio)obj).numerator();
/* 373 */       BigInteger denominator = ((Ratio)obj).denominator();
/* 374 */       return Lisp.number(getBigInteger().multiply(denominator).add(numerator), denominator);
/*     */     } 
/*     */     
/* 377 */     if (obj instanceof SingleFloat)
/* 378 */       return new SingleFloat(this.value + ((SingleFloat)obj).value); 
/* 379 */     if (obj instanceof DoubleFloat)
/* 380 */       return new DoubleFloat(this.value + ((DoubleFloat)obj).value); 
/* 381 */     if (obj instanceof Complex) {
/*     */       
/* 383 */       Complex c = (Complex)obj;
/* 384 */       return Complex.getInstance(add(c.getRealPart()), c.getImaginaryPart());
/*     */     } 
/* 386 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(int n) {
/* 392 */     return LispInteger.getInstance(this.value - n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 398 */     if (obj instanceof Fixnum)
/* 399 */       return Lisp.number(this.value - ((Fixnum)obj).value); 
/* 400 */     if (obj instanceof Bignum)
/* 401 */       return Lisp.number(getBigInteger().subtract(Bignum.getValue(obj))); 
/* 402 */     if (obj instanceof Ratio) {
/*     */       
/* 404 */       BigInteger numerator = ((Ratio)obj).numerator();
/* 405 */       BigInteger denominator = ((Ratio)obj).denominator();
/* 406 */       return Lisp.number(
/* 407 */           getBigInteger().multiply(denominator).subtract(numerator), denominator);
/*     */     } 
/*     */     
/* 410 */     if (obj instanceof SingleFloat)
/* 411 */       return new SingleFloat(this.value - ((SingleFloat)obj).value); 
/* 412 */     if (obj instanceof DoubleFloat)
/* 413 */       return new DoubleFloat(this.value - ((DoubleFloat)obj).value); 
/* 414 */     if (obj instanceof Complex) {
/*     */       
/* 416 */       Complex c = (Complex)obj;
/* 417 */       return Complex.getInstance(subtract(c.getRealPart()), ZERO
/* 418 */           .subtract(c.getImaginaryPart()));
/*     */     } 
/* 420 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(int n) {
/* 426 */     long result = this.value * n;
/* 427 */     return LispInteger.getInstance(result);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 433 */     if (obj instanceof Fixnum) {
/*     */       
/* 435 */       long result = this.value * ((Fixnum)obj).value;
/* 436 */       return LispInteger.getInstance(result);
/*     */     } 
/* 438 */     if (obj instanceof Bignum)
/* 439 */       return Lisp.number(getBigInteger().multiply(((Bignum)obj).value)); 
/* 440 */     if (obj instanceof Ratio) {
/*     */       
/* 442 */       BigInteger numerator = ((Ratio)obj).numerator();
/* 443 */       BigInteger denominator = ((Ratio)obj).denominator();
/* 444 */       return Lisp.number(
/* 445 */           getBigInteger().multiply(numerator), denominator);
/*     */     } 
/*     */     
/* 448 */     if (obj instanceof SingleFloat)
/* 449 */       return new SingleFloat(this.value * ((SingleFloat)obj).value); 
/* 450 */     if (obj instanceof DoubleFloat)
/* 451 */       return new DoubleFloat(this.value * ((DoubleFloat)obj).value); 
/* 452 */     if (obj instanceof Complex) {
/*     */       
/* 454 */       Complex c = (Complex)obj;
/* 455 */       return Complex.getInstance(multiplyBy(c.getRealPart()), 
/* 456 */           multiplyBy(c.getImaginaryPart()));
/*     */     } 
/* 458 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/*     */     try {
/* 466 */       if (obj instanceof Fixnum) {
/*     */         
/* 468 */         int divisor = ((Fixnum)obj).value;
/*     */         
/* 470 */         if (this.value > Integer.MIN_VALUE && 
/* 471 */           this.value % divisor == 0)
/* 472 */           return getInstance(this.value / divisor); 
/* 473 */         return Lisp.number(BigInteger.valueOf(this.value), 
/* 474 */             BigInteger.valueOf(divisor));
/*     */       } 
/* 476 */       if (obj instanceof Bignum)
/* 477 */         return Lisp.number(getBigInteger(), ((Bignum)obj).value); 
/* 478 */       if (obj instanceof Ratio) {
/*     */         
/* 480 */         BigInteger numerator = ((Ratio)obj).numerator();
/* 481 */         BigInteger denominator = ((Ratio)obj).denominator();
/* 482 */         return Lisp.number(getBigInteger().multiply(denominator), numerator);
/*     */       } 
/*     */       
/* 485 */       if (obj instanceof SingleFloat)
/* 486 */         return new SingleFloat(this.value / ((SingleFloat)obj).value); 
/* 487 */       if (obj instanceof DoubleFloat)
/* 488 */         return new DoubleFloat(this.value / ((DoubleFloat)obj).value); 
/* 489 */       if (obj instanceof Complex) {
/*     */         
/* 491 */         Complex c = (Complex)obj;
/* 492 */         LispObject realPart = c.getRealPart();
/* 493 */         LispObject imagPart = c.getImaginaryPart();
/*     */         
/* 495 */         LispObject denominator = realPart.multiplyBy(realPart).add(imagPart.multiplyBy(imagPart));
/* 496 */         return Complex.getInstance(multiplyBy(realPart).divideBy(denominator), ZERO
/* 497 */             .subtract(multiplyBy(imagPart).divideBy(denominator)));
/*     */       } 
/* 499 */       return Lisp.type_error(obj, Symbol.NUMBER);
/*     */     }
/* 501 */     catch (ArithmeticException e) {
/*     */       
/* 503 */       if (obj.zerop()) {
/* 504 */         LispObject operands = new Cons(this, new Cons(obj));
/* 505 */         LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.SLASH, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*     */ 
/*     */ 
/*     */         
/* 509 */         return Lisp.error(new DivisionByZero(args));
/*     */       } 
/* 511 */       return Lisp.error(new ArithmeticError(e.getMessage()));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(int n) {
/* 518 */     return (this.value == n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 524 */     if (obj instanceof Fixnum)
/* 525 */       return (this.value == ((Fixnum)obj).value); 
/* 526 */     if (obj instanceof SingleFloat)
/* 527 */       return isEqualTo(((SingleFloat)obj).rational()); 
/* 528 */     if (obj instanceof DoubleFloat)
/* 529 */       return (this.value == ((DoubleFloat)obj).value); 
/* 530 */     if (obj instanceof Complex)
/* 531 */       return obj.isEqualTo(this); 
/* 532 */     if (obj.numberp())
/* 533 */       return false; 
/* 534 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 536 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(int n) {
/* 542 */     return (this.value != n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 548 */     if (obj instanceof Fixnum) {
/* 549 */       return (this.value != ((Fixnum)obj).value);
/*     */     }
/* 551 */     if (obj instanceof SingleFloat)
/* 552 */       return isNotEqualTo(((SingleFloat)obj).rational()); 
/* 553 */     if (obj instanceof DoubleFloat)
/* 554 */       return (this.value != ((DoubleFloat)obj).value); 
/* 555 */     if (obj instanceof Complex)
/* 556 */       return obj.isNotEqualTo(this); 
/* 557 */     if (obj.numberp())
/* 558 */       return true; 
/* 559 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 561 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(int n) {
/* 567 */     return (this.value < n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(LispObject obj) {
/* 573 */     if (obj instanceof Fixnum)
/* 574 */       return (this.value < ((Fixnum)obj).value); 
/* 575 */     if (obj instanceof Bignum)
/* 576 */       return (getBigInteger().compareTo(Bignum.getValue(obj)) < 0); 
/* 577 */     if (obj instanceof Ratio) {
/*     */       
/* 579 */       BigInteger n = getBigInteger().multiply(((Ratio)obj).denominator());
/* 580 */       return (n.compareTo(((Ratio)obj).numerator()) < 0);
/*     */     } 
/* 582 */     if (obj instanceof SingleFloat)
/* 583 */       return isLessThan(((SingleFloat)obj).rational()); 
/* 584 */     if (obj instanceof DoubleFloat)
/* 585 */       return isLessThan(((DoubleFloat)obj).rational()); 
/* 586 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 588 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(int n) {
/* 594 */     return (this.value > n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(LispObject obj) {
/* 600 */     if (obj instanceof Fixnum)
/* 601 */       return (this.value > ((Fixnum)obj).value); 
/* 602 */     if (obj instanceof Bignum)
/* 603 */       return (getBigInteger().compareTo(Bignum.getValue(obj)) > 0); 
/* 604 */     if (obj instanceof Ratio) {
/*     */       
/* 606 */       BigInteger n = getBigInteger().multiply(((Ratio)obj).denominator());
/* 607 */       return (n.compareTo(((Ratio)obj).numerator()) > 0);
/*     */     } 
/* 609 */     if (obj instanceof SingleFloat)
/* 610 */       return isGreaterThan(((SingleFloat)obj).rational()); 
/* 611 */     if (obj instanceof DoubleFloat)
/* 612 */       return isGreaterThan(((DoubleFloat)obj).rational()); 
/* 613 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 615 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(int n) {
/* 621 */     return (this.value <= n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 627 */     if (obj instanceof Fixnum)
/* 628 */       return (this.value <= ((Fixnum)obj).value); 
/* 629 */     if (obj instanceof Bignum)
/* 630 */       return (getBigInteger().compareTo(Bignum.getValue(obj)) <= 0); 
/* 631 */     if (obj instanceof Ratio) {
/*     */       
/* 633 */       BigInteger n = getBigInteger().multiply(((Ratio)obj).denominator());
/* 634 */       return (n.compareTo(((Ratio)obj).numerator()) <= 0);
/*     */     } 
/* 636 */     if (obj instanceof SingleFloat)
/* 637 */       return isLessThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 638 */     if (obj instanceof DoubleFloat)
/* 639 */       return isLessThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 640 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 642 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(int n) {
/* 648 */     return (this.value >= n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 654 */     if (obj instanceof Fixnum)
/* 655 */       return (this.value >= ((Fixnum)obj).value); 
/* 656 */     if (obj instanceof Bignum)
/* 657 */       return (getBigInteger().compareTo(Bignum.getValue(obj)) >= 0); 
/* 658 */     if (obj instanceof Ratio) {
/*     */       
/* 660 */       BigInteger n = getBigInteger().multiply(((Ratio)obj).denominator());
/* 661 */       return (n.compareTo(((Ratio)obj).numerator()) >= 0);
/*     */     } 
/* 663 */     if (obj instanceof SingleFloat)
/* 664 */       return isGreaterThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 665 */     if (obj instanceof DoubleFloat)
/* 666 */       return isGreaterThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 667 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 669 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject truncate(LispObject obj) {
/*     */     LispObject value1, value2;
/* 675 */     LispThread thread = LispThread.currentThread();
/*     */ 
/*     */     
/*     */     try {
/* 679 */       if (obj instanceof Fixnum) {
/*     */         
/* 681 */         int divisor = ((Fixnum)obj).value;
/* 682 */         int quotient = this.value / divisor;
/* 683 */         int remainder = this.value % divisor;
/* 684 */         value1 = getInstance(quotient);
/* 685 */         value2 = (remainder == 0) ? ZERO : getInstance(remainder);
/*     */       }
/* 687 */       else if (obj instanceof Bignum) {
/*     */         
/* 689 */         BigInteger val = getBigInteger();
/* 690 */         BigInteger divisor = ((Bignum)obj).value;
/* 691 */         BigInteger[] results = val.divideAndRemainder(divisor);
/* 692 */         BigInteger quotient = results[0];
/* 693 */         BigInteger remainder = results[1];
/* 694 */         value1 = Lisp.number(quotient);
/* 695 */         value2 = (remainder.signum() == 0) ? ZERO : Lisp.number(remainder);
/*     */       }
/* 697 */       else if (obj instanceof Ratio) {
/*     */         
/* 699 */         Ratio divisor = (Ratio)obj;
/*     */         
/* 701 */         LispObject quotient = multiplyBy(divisor.DENOMINATOR()).truncate(divisor.NUMERATOR());
/*     */         
/* 703 */         LispObject remainder = subtract(quotient.multiplyBy(divisor));
/* 704 */         value1 = quotient;
/* 705 */         value2 = remainder;
/*     */       } else {
/* 707 */         if (obj instanceof SingleFloat)
/*     */         {
/*     */ 
/*     */ 
/*     */           
/* 712 */           return (new SingleFloat(this.value)).truncate(obj);
/*     */         }
/* 714 */         if (obj instanceof DoubleFloat)
/*     */         {
/*     */ 
/*     */ 
/*     */           
/* 719 */           return (new DoubleFloat(this.value)).truncate(obj);
/*     */         }
/*     */         
/* 722 */         return Lisp.type_error(obj, Symbol.REAL);
/*     */       } 
/* 724 */     } catch (ArithmeticException e) {
/*     */       
/* 726 */       if (obj.zerop()) {
/* 727 */         LispObject operands = new Cons(this, new Cons(obj));
/* 728 */         LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.TRUNCATE, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*     */ 
/*     */ 
/*     */         
/* 732 */         return Lisp.error(new DivisionByZero(args));
/*     */       } 
/*     */       
/* 735 */       return Lisp.error(new ArithmeticError(e.getMessage()));
/*     */     } 
/* 737 */     return thread.setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject MOD(LispObject divisor) {
/* 743 */     if (divisor instanceof Fixnum)
/* 744 */       return MOD(((Fixnum)divisor).value); 
/* 745 */     return super.MOD(divisor);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject MOD(int divisor) {
/*     */     int r;
/*     */     try {
/* 754 */       r = this.value % divisor;
/*     */     }
/* 756 */     catch (ArithmeticException e) {
/*     */       
/* 758 */       return Lisp.error(new ArithmeticError("Division by zero."));
/*     */     } 
/* 760 */     if (r == 0)
/* 761 */       return ZERO; 
/* 762 */     if (divisor < 0) {
/*     */       
/* 764 */       if (this.value > 0) {
/* 765 */         return getInstance(r + divisor);
/*     */       
/*     */       }
/*     */     }
/* 769 */     else if (this.value < 0) {
/* 770 */       return getInstance(r + divisor);
/*     */     } 
/* 772 */     return getInstance(r);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ash(int shift) {
/* 778 */     if (this.value == 0)
/* 779 */       return this; 
/* 780 */     if (shift == 0)
/* 781 */       return this; 
/* 782 */     long n = this.value;
/* 783 */     if (shift <= -32)
/*     */     {
/*     */       
/* 786 */       return (n >= 0L) ? ZERO : MINUS_ONE;
/*     */     }
/* 788 */     if (shift < 0)
/* 789 */       return getInstance((int)(n >> -shift)); 
/* 790 */     if (shift <= 32) {
/*     */       
/* 792 */       n <<= shift;
/* 793 */       return LispInteger.getInstance(n);
/*     */     } 
/*     */ 
/*     */     
/* 797 */     if (shift == Integer.MIN_VALUE)
/* 798 */       return (n >= 0L) ? ZERO : MINUS_ONE; 
/* 799 */     return Lisp.number(BigInteger.valueOf(this.value).shiftLeft(shift));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ash(LispObject obj) {
/* 805 */     if (obj instanceof Fixnum)
/* 806 */       return ash(((Fixnum)obj).value); 
/* 807 */     if (obj instanceof Bignum) {
/*     */       
/* 809 */       if (this.value == 0)
/* 810 */         return this; 
/* 811 */       BigInteger n = BigInteger.valueOf(this.value);
/* 812 */       BigInteger shift = ((Bignum)obj).value;
/* 813 */       if (shift.signum() > 0)
/* 814 */         return Lisp.error(new LispError("Can't represent result of left shift.")); 
/* 815 */       if (shift.signum() < 0)
/* 816 */         return (n.signum() >= 0) ? ZERO : MINUS_ONE; 
/* 817 */       Debug.bug();
/*     */     } 
/* 819 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGNOT() {
/* 825 */     return getInstance(this.value ^ 0xFFFFFFFF);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGAND(int n) {
/* 831 */     return getInstance(this.value & n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGAND(LispObject obj) {
/* 837 */     if (obj instanceof Fixnum)
/* 838 */       return getInstance(this.value & ((Fixnum)obj).value); 
/* 839 */     if (obj instanceof Bignum) {
/*     */       
/* 841 */       if (this.value >= 0) {
/*     */         
/* 843 */         int i = ((Bignum)obj).value.intValue();
/* 844 */         return getInstance(this.value & i);
/*     */       } 
/*     */ 
/*     */       
/* 848 */       BigInteger n1 = getBigInteger();
/* 849 */       BigInteger n2 = ((Bignum)obj).value;
/* 850 */       return Lisp.number(n1.and(n2));
/*     */     } 
/*     */     
/* 853 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGIOR(int n) {
/* 859 */     return getInstance(this.value | n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGIOR(LispObject obj) {
/* 865 */     if (obj instanceof Fixnum)
/* 866 */       return getInstance(this.value | ((Fixnum)obj).value); 
/* 867 */     if (obj instanceof Bignum) {
/*     */       
/* 869 */       BigInteger n1 = getBigInteger();
/* 870 */       BigInteger n2 = ((Bignum)obj).value;
/* 871 */       return Lisp.number(n1.or(n2));
/*     */     } 
/* 873 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGXOR(int n) {
/* 879 */     return getInstance(this.value ^ n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LOGXOR(LispObject obj) {
/* 885 */     if (obj instanceof Fixnum)
/* 886 */       return getInstance(this.value ^ ((Fixnum)obj).value); 
/* 887 */     if (obj instanceof Bignum) {
/*     */       
/* 889 */       BigInteger n1 = getBigInteger();
/* 890 */       BigInteger n2 = ((Bignum)obj).value;
/* 891 */       return Lisp.number(n1.xor(n2));
/*     */     } 
/* 893 */     return Lisp.type_error(obj, Symbol.INTEGER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject LDB(int size, int position) {
/* 899 */     long n = this.value >> position;
/* 900 */     long mask = (1L << size) - 1L;
/* 901 */     return Lisp.number(n & mask);
/*     */   }
/*     */   
/* 904 */   static final BigInteger BIGINTEGER_TWO = new BigInteger("2");
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject pow(LispObject obj) {
/* 910 */     BigInteger y = Bignum.getValue(obj);
/*     */     
/* 912 */     if (y.compareTo(BigInteger.ZERO) < 0) {
/* 913 */       return getInstance(1).divideBy(pow(Bignum.getInstance(y.negate())));
/*     */     }
/* 915 */     if (y.compareTo(BigInteger.ZERO) == 0)
/*     */     {
/* 917 */       return getInstance(1);
/*     */     }
/* 919 */     int x = this.value;
/*     */     
/* 921 */     if (x == 0) {
/* 922 */       return getInstance(0);
/*     */     }
/* 924 */     if (x == 1) {
/* 925 */       return getInstance(1);
/*     */     }
/* 927 */     BigInteger xy = BigInteger.ONE;
/* 928 */     BigInteger term = BigInteger.valueOf(x);
/*     */     
/* 930 */     while (!y.equals(BigInteger.ZERO)) {
/*     */       
/* 932 */       if (y.testBit(0)) {
/* 933 */         xy = xy.multiply(term);
/*     */       }
/* 935 */       term = term.multiply(term);
/* 936 */       y = y.shiftLeft(1);
/*     */     } 
/*     */     
/* 939 */     return Bignum.getInstance(xy);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 945 */     return this.value;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 951 */     LispThread thread = LispThread.currentThread();
/* 952 */     int base = getValue(Symbol.PRINT_BASE.symbolValue(thread));
/* 953 */     String s = Integer.toString(this.value, base).toUpperCase();
/* 954 */     if (Symbol.PRINT_RADIX.symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 956 */       StringBuilder sb = new StringBuilder();
/* 957 */       switch (base) {
/*     */         
/*     */         case 2:
/* 960 */           sb.append("#b");
/* 961 */           sb.append(s);
/*     */           break;
/*     */         case 8:
/* 964 */           sb.append("#o");
/* 965 */           sb.append(s);
/*     */           break;
/*     */         case 10:
/* 968 */           sb.append(s);
/* 969 */           sb.append('.');
/*     */           break;
/*     */         case 16:
/* 972 */           sb.append("#x");
/* 973 */           sb.append(s);
/*     */           break;
/*     */         default:
/* 976 */           sb.append('#');
/* 977 */           sb.append(String.valueOf(base));
/* 978 */           sb.append('r');
/* 979 */           sb.append(s);
/*     */           break;
/*     */       } 
/* 982 */       s = sb.toString();
/*     */     } 
/* 984 */     return s;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Fixnum.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */