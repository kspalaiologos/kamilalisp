/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.math.BigDecimal;
/*     */ import java.math.BigInteger;
/*     */ import java.math.MathContext;
/*     */ import java.math.RoundingMode;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Ratio
/*     */   extends LispObject
/*     */ {
/*     */   private BigInteger numerator;
/*     */   private BigInteger denominator;
/*     */   
/*     */   public Ratio(BigInteger numerator, BigInteger denominator) {
/*  50 */     this.numerator = numerator;
/*  51 */     this.denominator = denominator;
/*     */   }
/*     */ 
/*     */   
/*     */   public BigInteger numerator() {
/*  56 */     return this.numerator;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NUMERATOR() {
/*  62 */     return Lisp.number(this.numerator);
/*     */   }
/*     */ 
/*     */   
/*     */   public BigInteger denominator() {
/*  67 */     return this.denominator;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject DENOMINATOR() {
/*  73 */     return Lisp.number(this.denominator);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  79 */     return Symbol.RATIO;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  85 */     return BuiltInClass.RATIO;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  91 */     if (type == Symbol.RATIO)
/*  92 */       return Lisp.T; 
/*  93 */     if (type == Symbol.RATIONAL)
/*  94 */       return Lisp.T; 
/*  95 */     if (type == Symbol.REAL)
/*  96 */       return Lisp.T; 
/*  97 */     if (type == Symbol.NUMBER)
/*  98 */       return Lisp.T; 
/*  99 */     if (type == BuiltInClass.RATIO)
/* 100 */       return Lisp.T; 
/* 101 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean numberp() {
/* 107 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean rationalp() {
/* 113 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean realp() {
/* 119 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(LispObject obj) {
/* 125 */     if (this == obj)
/* 126 */       return true; 
/* 127 */     if (obj instanceof Ratio) {
/* 128 */       return (this.numerator.equals(((Ratio)obj).numerator) && this.denominator
/* 129 */         .equals(((Ratio)obj).denominator));
/*     */     }
/* 131 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 137 */     return eql(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 143 */     if (obj != null && obj.numberp())
/* 144 */       return isEqualTo(obj); 
/* 145 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ABS() {
/* 151 */     if (this.numerator.signum() > 0 && this.denominator.signum() > 0)
/* 152 */       return this; 
/* 153 */     if (this.numerator.signum() < 0 && this.denominator.signum() < 0)
/* 154 */       return this; 
/* 155 */     return new Ratio(this.numerator.negate(), this.denominator);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean plusp() {
/* 161 */     return (this.numerator.signum() == this.denominator.signum());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean minusp() {
/* 167 */     return (this.numerator.signum() != this.denominator.signum());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 173 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public float floatValue() {
/* 179 */     float result = (float)doubleValue();
/* 180 */     if (Float.isInfinite(result) && Lisp.TRAP_OVERFLOW) {
/* 181 */       Lisp.type_error(this, Symbol.SINGLE_FLOAT);
/*     */     }
/* 183 */     return (float)doubleValue();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public double doubleValue() {
/* 189 */     double result = this.numerator.doubleValue() / this.denominator.doubleValue();
/* 190 */     if (result != 0.0D && !Double.isNaN(result) && !Double.isInfinite(result))
/* 191 */       return result; 
/* 192 */     boolean negative = (this.numerator.signum() < 0);
/* 193 */     BigInteger num = negative ? this.numerator.negate() : this.numerator;
/* 194 */     BigInteger den = this.denominator;
/* 195 */     int numLen = num.bitLength();
/* 196 */     int denLen = den.bitLength();
/* 197 */     int length = Math.min(numLen, denLen);
/* 198 */     if (length <= 1) {
/*     */ 
/*     */       
/* 201 */       MathContext mathContext = new MathContext(512, RoundingMode.HALF_EVEN);
/* 202 */       BigDecimal p = new BigDecimal(this.numerator, mathContext);
/* 203 */       BigDecimal q = new BigDecimal(this.denominator, mathContext);
/* 204 */       BigDecimal r = p.divide(q, mathContext);
/* 205 */       result = r.doubleValue();
/* 206 */       return result;
/*     */     } 
/*     */     
/* 209 */     BigInteger n = num;
/* 210 */     BigInteger d = den;
/* 211 */     int digits = 54;
/* 212 */     if (length > 54) {
/* 213 */       n = n.shiftRight(length - 54);
/* 214 */       d = d.shiftRight(length - 54);
/* 215 */       length -= 54;
/*     */     } else {
/* 217 */       n = n.shiftRight(1);
/* 218 */       d = d.shiftRight(1);
/* 219 */       length--;
/*     */     } 
/* 221 */     for (int i = 0; i < length; i++) {
/* 222 */       result = n.doubleValue() / d.doubleValue();
/* 223 */       if (result != 0.0D && !Double.isNaN(result) && !Double.isInfinite(result))
/*     */         break; 
/* 225 */       n = n.shiftRight(1);
/* 226 */       d = d.shiftRight(1);
/*     */     } 
/* 228 */     if (Double.isInfinite(result) && Lisp.TRAP_OVERFLOW) {
/* 229 */       Lisp.type_error(this, Symbol.DOUBLE_FLOAT);
/*     */     }
/* 231 */     return negative ? -result : result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 237 */     return new Ratio(this.numerator.add(this.denominator), this.denominator);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 243 */     return new Ratio(this.numerator.subtract(this.denominator), this.denominator);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 249 */     if (obj instanceof Fixnum) {
/*     */       
/* 251 */       BigInteger n = this.numerator.add(BigInteger.valueOf(((Fixnum)obj).value).multiply(this.denominator));
/* 252 */       return Lisp.number(n, this.denominator);
/*     */     } 
/* 254 */     if (obj instanceof Bignum) {
/* 255 */       BigInteger n = ((Bignum)obj).value;
/* 256 */       return Lisp.number(this.numerator.add(n.multiply(this.denominator)), this.denominator);
/*     */     } 
/*     */     
/* 259 */     if (obj instanceof Ratio) {
/* 260 */       BigInteger n = ((Ratio)obj).numerator;
/* 261 */       BigInteger d = ((Ratio)obj).denominator;
/* 262 */       if (this.denominator.equals(d))
/* 263 */         return Lisp.number(this.numerator.add(n), this.denominator); 
/* 264 */       BigInteger common = this.denominator.multiply(d);
/* 265 */       return Lisp.number(this.numerator.multiply(d).add(n.multiply(this.denominator)), common);
/*     */     } 
/*     */     
/* 268 */     if (obj instanceof SingleFloat) {
/* 269 */       return new SingleFloat(floatValue() + ((SingleFloat)obj).value);
/*     */     }
/* 271 */     if (obj instanceof DoubleFloat) {
/* 272 */       return new DoubleFloat(doubleValue() + ((DoubleFloat)obj).value);
/*     */     }
/* 274 */     if (obj instanceof Complex) {
/* 275 */       Complex c = (Complex)obj;
/* 276 */       return Complex.getInstance(add(c.getRealPart()), c.getImaginaryPart());
/*     */     } 
/* 278 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 284 */     if (obj instanceof Fixnum) {
/*     */       
/* 286 */       BigInteger n = this.numerator.subtract(BigInteger.valueOf(((Fixnum)obj).value).multiply(this.denominator));
/* 287 */       return Lisp.number(n, this.denominator);
/*     */     } 
/* 289 */     if (obj instanceof Bignum) {
/* 290 */       BigInteger n = ((Bignum)obj).value;
/* 291 */       return Lisp.number(this.numerator.subtract(n.multiply(this.denominator)), this.denominator);
/*     */     } 
/*     */     
/* 294 */     if (obj instanceof Ratio) {
/* 295 */       BigInteger n = ((Ratio)obj).numerator;
/* 296 */       BigInteger d = ((Ratio)obj).denominator;
/* 297 */       if (this.denominator.equals(d))
/* 298 */         return Lisp.number(this.numerator.subtract(n), this.denominator); 
/* 299 */       BigInteger common = this.denominator.multiply(d);
/* 300 */       return Lisp.number(this.numerator.multiply(d).subtract(n.multiply(this.denominator)), common);
/*     */     } 
/*     */     
/* 303 */     if (obj instanceof SingleFloat) {
/* 304 */       return new SingleFloat(floatValue() - ((SingleFloat)obj).value);
/*     */     }
/* 306 */     if (obj instanceof DoubleFloat) {
/* 307 */       return new DoubleFloat(doubleValue() - ((DoubleFloat)obj).value);
/*     */     }
/* 309 */     if (obj instanceof Complex) {
/* 310 */       Complex c = (Complex)obj;
/* 311 */       return Complex.getInstance(subtract(c.getRealPart()), Fixnum.ZERO
/* 312 */           .subtract(c.getImaginaryPart()));
/*     */     } 
/* 314 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 320 */     if (obj instanceof Fixnum) {
/* 321 */       BigInteger n = ((Fixnum)obj).getBigInteger();
/* 322 */       return Lisp.number(this.numerator.multiply(n), this.denominator);
/*     */     } 
/* 324 */     if (obj instanceof Bignum) {
/* 325 */       BigInteger n = ((Bignum)obj).value;
/* 326 */       return Lisp.number(this.numerator.multiply(n), this.denominator);
/*     */     } 
/* 328 */     if (obj instanceof Ratio) {
/* 329 */       BigInteger n = ((Ratio)obj).numerator;
/* 330 */       BigInteger d = ((Ratio)obj).denominator;
/* 331 */       return Lisp.number(this.numerator.multiply(n), this.denominator.multiply(d));
/*     */     } 
/* 333 */     if (obj instanceof SingleFloat) {
/* 334 */       return new SingleFloat(floatValue() * ((SingleFloat)obj).value);
/*     */     }
/* 336 */     if (obj instanceof DoubleFloat) {
/* 337 */       return new DoubleFloat(doubleValue() * ((DoubleFloat)obj).value);
/*     */     }
/* 339 */     if (obj instanceof Complex) {
/* 340 */       Complex c = (Complex)obj;
/* 341 */       return Complex.getInstance(multiplyBy(c.getRealPart()), 
/* 342 */           multiplyBy(c.getImaginaryPart()));
/*     */     } 
/* 344 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/* 350 */     if (obj.zerop()) {
/* 351 */       LispObject operands = new Cons(this, new Cons(obj));
/* 352 */       LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.SLASH, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*     */ 
/*     */ 
/*     */       
/* 356 */       return Lisp.error(new DivisionByZero(args));
/*     */     } 
/*     */     
/* 359 */     if (obj instanceof Fixnum) {
/* 360 */       BigInteger n = ((Fixnum)obj).getBigInteger();
/* 361 */       return Lisp.number(this.numerator, this.denominator.multiply(n));
/*     */     } 
/* 363 */     if (obj instanceof Bignum) {
/* 364 */       BigInteger n = ((Bignum)obj).value;
/* 365 */       return Lisp.number(this.numerator, this.denominator.multiply(n));
/*     */     } 
/* 367 */     if (obj instanceof Ratio) {
/* 368 */       BigInteger n = ((Ratio)obj).numerator;
/* 369 */       BigInteger d = ((Ratio)obj).denominator;
/* 370 */       return Lisp.number(this.numerator.multiply(d), this.denominator.multiply(n));
/*     */     } 
/* 372 */     if (obj instanceof SingleFloat) {
/* 373 */       return new SingleFloat(floatValue() / ((SingleFloat)obj).value);
/*     */     }
/* 375 */     if (obj instanceof DoubleFloat) {
/* 376 */       return new DoubleFloat(doubleValue() / ((DoubleFloat)obj).value);
/*     */     }
/* 378 */     if (obj instanceof Complex) {
/* 379 */       Complex c = (Complex)obj;
/*     */       
/* 381 */       LispObject realPart = multiplyBy(c.getRealPart());
/*     */       
/* 383 */       LispObject imagPart = Fixnum.ZERO.subtract(this).multiplyBy(c.getImaginaryPart());
/*     */ 
/*     */       
/* 386 */       LispObject d = c.getRealPart().multiplyBy(c.getRealPart());
/* 387 */       d = d.add(c.getImaginaryPart().multiplyBy(c.getImaginaryPart()));
/* 388 */       return Complex.getInstance(realPart.divideBy(d), imagPart
/* 389 */           .divideBy(d));
/*     */     } 
/* 391 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 397 */     if (obj instanceof Ratio)
/* 398 */       return (this.numerator.equals(((Ratio)obj).numerator) && this.denominator
/* 399 */         .equals(((Ratio)obj).denominator)); 
/* 400 */     if (obj instanceof SingleFloat)
/* 401 */       return isEqualTo(((SingleFloat)obj).rational()); 
/* 402 */     if (obj instanceof DoubleFloat)
/* 403 */       return isEqualTo(((DoubleFloat)obj).rational()); 
/* 404 */     if (obj.numberp())
/* 405 */       return false; 
/* 406 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 408 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 414 */     return !isEqualTo(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThan(LispObject obj) {
/* 420 */     if (obj instanceof Fixnum) {
/* 421 */       BigInteger n2 = ((Fixnum)obj).getBigInteger().multiply(this.denominator);
/* 422 */       return (this.numerator.compareTo(n2) < 0);
/*     */     } 
/* 424 */     if (obj instanceof Bignum) {
/* 425 */       BigInteger n = ((Bignum)obj).value.multiply(this.denominator);
/* 426 */       return (this.numerator.compareTo(n) < 0);
/*     */     } 
/* 428 */     if (obj instanceof Ratio) {
/* 429 */       BigInteger n1 = this.numerator.multiply(((Ratio)obj).denominator);
/* 430 */       BigInteger n2 = ((Ratio)obj).numerator.multiply(this.denominator);
/* 431 */       return (n1.compareTo(n2) < 0);
/*     */     } 
/* 433 */     if (obj instanceof SingleFloat)
/* 434 */       return isLessThan(((SingleFloat)obj).rational()); 
/* 435 */     if (obj instanceof DoubleFloat)
/* 436 */       return isLessThan(((DoubleFloat)obj).rational()); 
/* 437 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 439 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThan(LispObject obj) {
/* 445 */     if (obj instanceof Fixnum) {
/* 446 */       BigInteger n2 = ((Fixnum)obj).getBigInteger().multiply(this.denominator);
/* 447 */       return (this.numerator.compareTo(n2) > 0);
/*     */     } 
/* 449 */     if (obj instanceof Bignum) {
/* 450 */       BigInteger n = ((Bignum)obj).value.multiply(this.denominator);
/* 451 */       return (this.numerator.compareTo(n) > 0);
/*     */     } 
/* 453 */     if (obj instanceof Ratio) {
/* 454 */       BigInteger n1 = this.numerator.multiply(((Ratio)obj).denominator);
/* 455 */       BigInteger n2 = ((Ratio)obj).numerator.multiply(this.denominator);
/* 456 */       return (n1.compareTo(n2) > 0);
/*     */     } 
/* 458 */     if (obj instanceof SingleFloat)
/* 459 */       return isGreaterThan(((SingleFloat)obj).rational()); 
/* 460 */     if (obj instanceof DoubleFloat)
/* 461 */       return isGreaterThan(((DoubleFloat)obj).rational()); 
/* 462 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 464 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 470 */     if (obj instanceof Fixnum) {
/* 471 */       BigInteger n2 = ((Fixnum)obj).getBigInteger().multiply(this.denominator);
/* 472 */       return (this.numerator.compareTo(n2) <= 0);
/*     */     } 
/* 474 */     if (obj instanceof Bignum) {
/* 475 */       BigInteger n = ((Bignum)obj).value.multiply(this.denominator);
/* 476 */       return (this.numerator.compareTo(n) <= 0);
/*     */     } 
/* 478 */     if (obj instanceof Ratio) {
/* 479 */       BigInteger n1 = this.numerator.multiply(((Ratio)obj).denominator);
/* 480 */       BigInteger n2 = ((Ratio)obj).numerator.multiply(this.denominator);
/* 481 */       return (n1.compareTo(n2) <= 0);
/*     */     } 
/* 483 */     if (obj instanceof SingleFloat)
/* 484 */       return isLessThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 485 */     if (obj instanceof DoubleFloat)
/* 486 */       return isLessThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 487 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 489 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 495 */     if (obj instanceof Fixnum) {
/* 496 */       BigInteger n2 = ((Fixnum)obj).getBigInteger().multiply(this.denominator);
/* 497 */       return (this.numerator.compareTo(n2) >= 0);
/*     */     } 
/* 499 */     if (obj instanceof Bignum) {
/* 500 */       BigInteger n = ((Bignum)obj).value.multiply(this.denominator);
/* 501 */       return (this.numerator.compareTo(n) >= 0);
/*     */     } 
/* 503 */     if (obj instanceof Ratio) {
/* 504 */       BigInteger n1 = this.numerator.multiply(((Ratio)obj).denominator);
/* 505 */       BigInteger n2 = ((Ratio)obj).numerator.multiply(this.denominator);
/* 506 */       return (n1.compareTo(n2) >= 0);
/*     */     } 
/* 508 */     if (obj instanceof SingleFloat)
/* 509 */       return isGreaterThanOrEqualTo(((SingleFloat)obj).rational()); 
/* 510 */     if (obj instanceof DoubleFloat)
/* 511 */       return isGreaterThanOrEqualTo(((DoubleFloat)obj).rational()); 
/* 512 */     Lisp.type_error(obj, Symbol.REAL);
/*     */     
/* 514 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject truncate(LispObject obj) {
/* 523 */     if (obj instanceof SingleFloat)
/* 524 */       return (new SingleFloat(floatValue())).truncate(obj); 
/* 525 */     if (obj instanceof DoubleFloat)
/* 526 */       return (new DoubleFloat(doubleValue())).truncate(obj); 
/*     */     try {
/*     */       BigInteger n, d;
/* 529 */       if (obj instanceof Fixnum) {
/* 530 */         n = ((Fixnum)obj).getBigInteger();
/* 531 */         d = BigInteger.ONE;
/* 532 */       } else if (obj instanceof Bignum) {
/* 533 */         n = ((Bignum)obj).value;
/* 534 */         d = BigInteger.ONE;
/* 535 */       } else if (obj instanceof Ratio) {
/* 536 */         n = ((Ratio)obj).numerator();
/* 537 */         d = ((Ratio)obj).denominator();
/*     */       } else {
/* 539 */         return Lisp.type_error(obj, Symbol.NUMBER);
/*     */       } 
/*     */       
/* 542 */       BigInteger num = this.numerator.multiply(d);
/* 543 */       BigInteger den = this.denominator.multiply(n);
/* 544 */       BigInteger quotient = num.divide(den);
/*     */       
/* 546 */       LispObject product = Lisp.number(quotient.multiply(n), d);
/*     */       
/* 548 */       LispObject remainder = subtract(product);
/* 549 */       return LispThread.currentThread().setValues(Lisp.number(quotient), remainder);
/*     */     }
/* 551 */     catch (ArithmeticException e) {
/* 552 */       if (obj.zerop()) {
/* 553 */         LispObject operands = new Cons(this, new Cons(obj));
/* 554 */         LispObject args = new Cons(Keyword.OPERATION, new Cons(Symbol.TRUNCATE, new Cons(Keyword.OPERANDS, new Cons(operands))));
/*     */ 
/*     */ 
/*     */         
/* 558 */         return Lisp.error(new DivisionByZero(args));
/*     */       } 
/* 560 */       return Lisp.error(new ArithmeticError(e.getMessage()));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 567 */     return this.numerator.hashCode() ^ this.denominator.hashCode();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 573 */     LispThread thread = LispThread.currentThread();
/* 574 */     int base = Fixnum.getValue(Symbol.PRINT_BASE.symbolValue(thread));
/* 575 */     StringBuffer sb = new StringBuffer(this.numerator.toString(base));
/* 576 */     sb.append('/');
/* 577 */     sb.append(this.denominator.toString(base));
/* 578 */     String s = sb.toString().toUpperCase();
/* 579 */     if (Symbol.PRINT_RADIX.symbolValue(thread) != Lisp.NIL) {
/* 580 */       sb.setLength(0);
/* 581 */       switch (base) {
/*     */         case 2:
/* 583 */           sb.append("#b");
/* 584 */           sb.append(s);
/*     */           break;
/*     */         case 8:
/* 587 */           sb.append("#o");
/* 588 */           sb.append(s);
/*     */           break;
/*     */         case 10:
/* 591 */           sb.append("#10r");
/* 592 */           sb.append(s);
/*     */           break;
/*     */         case 16:
/* 595 */           sb.append("#x");
/* 596 */           sb.append(s);
/*     */           break;
/*     */         default:
/* 599 */           sb.append('#');
/* 600 */           sb.append(String.valueOf(base));
/* 601 */           sb.append('r');
/* 602 */           sb.append(s);
/*     */           break;
/*     */       } 
/* 605 */       s = sb.toString();
/*     */     } 
/* 607 */     return s;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Ratio.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */