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
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class MathFunctions
/*     */ {
/*     */   private static final LispObject complexToRealFixup(LispObject result, LispObject arg) {
/*  48 */     if (result instanceof Complex && !(arg instanceof Complex)) {
/*     */       
/*  50 */       Complex c = (Complex)result;
/*  51 */       LispObject im = c.getImaginaryPart();
/*  52 */       if (im.zerop())
/*  53 */         return c.getRealPart(); 
/*     */     } 
/*  55 */     return result;
/*     */   }
/*     */ 
/*     */   
/*  59 */   private static final Primitive SIN = new Primitive("sin", "radians")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  64 */         return MathFunctions.sin(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject sin(LispObject arg) {
/*  70 */     if (arg instanceof DoubleFloat)
/*  71 */       return new DoubleFloat(Math.sin(((DoubleFloat)arg).value)); 
/*  72 */     if (arg.realp())
/*  73 */       return new SingleFloat((float)Math.sin((SingleFloat.coerceToFloat(arg)).value)); 
/*  74 */     if (arg instanceof Complex) {
/*  75 */       LispObject n = arg.multiplyBy(Complex.getInstance(Fixnum.ZERO, Fixnum.ONE));
/*     */       
/*  77 */       LispObject result = exp(n);
/*  78 */       result = result.subtract(exp(n.multiplyBy(Fixnum.MINUS_ONE)));
/*  79 */       return result.divideBy(Fixnum.TWO.multiplyBy(Complex.getInstance(Fixnum.ZERO, Fixnum.ONE)));
/*     */     } 
/*     */     
/*  82 */     return Lisp.type_error(arg, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */   
/*  86 */   private static final Primitive COS = new Primitive("cos", "radians")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  91 */         return MathFunctions.cos(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject cos(LispObject arg) {
/*  97 */     if (arg instanceof DoubleFloat)
/*  98 */       return new DoubleFloat(Math.cos(((DoubleFloat)arg).value)); 
/*  99 */     if (arg.realp())
/* 100 */       return new SingleFloat((float)Math.cos((SingleFloat.coerceToFloat(arg)).value)); 
/* 101 */     if (arg instanceof Complex) {
/* 102 */       LispObject n = arg.multiplyBy(Complex.getInstance(Fixnum.ZERO, Fixnum.ONE));
/*     */       
/* 104 */       LispObject result = exp(n);
/* 105 */       result = result.add(exp(n.multiplyBy(Fixnum.MINUS_ONE)));
/* 106 */       return result.divideBy(Fixnum.TWO);
/*     */     } 
/* 108 */     return Lisp.type_error(arg, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */   
/* 112 */   private static final Primitive TAN = new Primitive("tan", "radians")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 117 */         if (arg instanceof DoubleFloat)
/* 118 */           return new DoubleFloat(Math.tan(((DoubleFloat)arg).value)); 
/* 119 */         if (arg.realp())
/* 120 */           return new SingleFloat((float)Math.tan((SingleFloat.coerceToFloat(arg)).value)); 
/* 121 */         return MathFunctions.sin(arg).divideBy(MathFunctions.cos(arg));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 126 */   private static final Primitive ASIN = new Primitive("asin", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 131 */         return MathFunctions.asin(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject asin(LispObject arg) {
/* 137 */     if (arg instanceof SingleFloat) {
/* 138 */       float f = ((SingleFloat)arg).value;
/* 139 */       if (Math.abs(f) <= 1.0F)
/* 140 */         return new SingleFloat((float)Math.asin(f)); 
/*     */     } 
/* 142 */     if (arg instanceof DoubleFloat) {
/* 143 */       double d = ((DoubleFloat)arg).value;
/* 144 */       if (Math.abs(d) <= 1.0D)
/* 145 */         return new DoubleFloat(Math.asin(d)); 
/*     */     } 
/* 147 */     LispObject result = arg.multiplyBy(arg);
/* 148 */     result = Fixnum.ONE.subtract(result);
/* 149 */     result = sqrt(result);
/* 150 */     LispObject n = Complex.getInstance(Fixnum.ZERO, Fixnum.ONE);
/* 151 */     n = n.multiplyBy(arg);
/* 152 */     result = n.add(result);
/* 153 */     result = log(result);
/* 154 */     result = result.multiplyBy(Complex.getInstance(Fixnum.ZERO, Fixnum.MINUS_ONE));
/*     */ 
/*     */     
/* 157 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 161 */   private static final Primitive ACOS = new Primitive("acos", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 166 */         return MathFunctions.acos(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject acos(LispObject arg) {
/* 172 */     if (arg instanceof DoubleFloat) {
/* 173 */       double d = ((DoubleFloat)arg).value;
/* 174 */       if (Math.abs(d) <= 1.0D)
/* 175 */         return new DoubleFloat(Math.acos(d)); 
/*     */     } 
/* 177 */     if (arg instanceof SingleFloat) {
/* 178 */       float f = ((SingleFloat)arg).value;
/* 179 */       if (Math.abs(f) <= 1.0F)
/* 180 */         return new SingleFloat((float)Math.acos(f)); 
/*     */     } 
/* 182 */     LispObject result = new DoubleFloat(1.5707963267948966D);
/* 183 */     if (!(arg instanceof DoubleFloat) && (
/* 184 */       !(arg instanceof Complex) || 
/* 185 */       !(((Complex)arg).getRealPart() instanceof DoubleFloat)))
/*     */     {
/*     */ 
/*     */       
/* 189 */       result = new SingleFloat((float)((DoubleFloat)result).value);
/*     */     }
/* 191 */     result = result.subtract(asin(arg));
/*     */     
/* 193 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 197 */   private static final Primitive ATAN = new Primitive("atan", "number1 &optional number2")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 203 */         if (arg.numberp())
/* 204 */           return MathFunctions.atan(arg); 
/* 205 */         return Lisp.type_error(arg, Symbol.NUMBER);
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject y, LispObject x) {
/* 219 */         if (!y.realp())
/* 220 */           return Lisp.type_error(y, Symbol.REAL); 
/* 221 */         if (!x.realp()) {
/* 222 */           return Lisp.type_error(x, Symbol.REAL);
/*     */         }
/* 224 */         double d1 = (DoubleFloat.coerceToFloat(y)).value;
/* 225 */         double d2 = (DoubleFloat.coerceToFloat(x)).value;
/* 226 */         double result = Math.atan2(d1, d2);
/* 227 */         if (y instanceof DoubleFloat || x instanceof DoubleFloat) {
/* 228 */           return new DoubleFloat(result);
/*     */         }
/* 230 */         return new SingleFloat((float)result);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject atan(LispObject arg) {
/* 236 */     if (arg instanceof Complex) {
/* 237 */       LispObject im = ((Complex)arg).imagpart;
/* 238 */       if (im.zerop()) {
/* 239 */         return Complex.getInstance(atan(((Complex)arg).realpart), im);
/*     */       }
/* 241 */       LispObject result = arg.multiplyBy(arg);
/* 242 */       result = result.add(Fixnum.ONE);
/* 243 */       result = Fixnum.ONE.divideBy(result);
/* 244 */       result = sqrt(result);
/* 245 */       LispObject n = Complex.getInstance(Fixnum.ZERO, Fixnum.ONE);
/* 246 */       n = n.multiplyBy(arg);
/* 247 */       n = n.add(Fixnum.ONE);
/* 248 */       result = n.multiplyBy(result);
/* 249 */       result = log(result);
/* 250 */       result = result.multiplyBy(Complex.getInstance(Fixnum.ZERO, Fixnum.MINUS_ONE));
/* 251 */       return result;
/*     */     } 
/* 253 */     if (arg instanceof DoubleFloat)
/* 254 */       return new DoubleFloat(Math.atan(((DoubleFloat)arg).value)); 
/* 255 */     return new SingleFloat((float)Math.atan((SingleFloat.coerceToFloat(arg)).value));
/*     */   }
/*     */ 
/*     */   
/* 259 */   private static final Primitive SINH = new Primitive("sinh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 264 */         return MathFunctions.sinh(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject sinh(LispObject arg) {
/* 270 */     if (arg instanceof Complex) {
/* 271 */       LispObject im = ((Complex)arg).getImaginaryPart();
/* 272 */       if (im.zerop()) {
/* 273 */         return Complex.getInstance(sinh(((Complex)arg).getRealPart()), im);
/*     */       }
/*     */     } 
/* 276 */     if (arg instanceof SingleFloat) {
/* 277 */       double d = Math.sinh(((SingleFloat)arg).value);
/* 278 */       return new SingleFloat((float)d);
/* 279 */     }  if (arg instanceof DoubleFloat) {
/* 280 */       double d = Math.sinh(((DoubleFloat)arg).value);
/* 281 */       return new DoubleFloat(d);
/*     */     } 
/* 283 */     LispObject result = exp(arg);
/* 284 */     result = result.subtract(exp(arg.multiplyBy(Fixnum.MINUS_ONE)));
/* 285 */     result = result.divideBy(Fixnum.TWO);
/*     */     
/* 287 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 291 */   private static final Primitive COSH = new Primitive("cosh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 296 */         return MathFunctions.cosh(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject cosh(LispObject arg) {
/* 302 */     if (arg instanceof Complex) {
/* 303 */       LispObject im = ((Complex)arg).getImaginaryPart();
/* 304 */       if (im.zerop()) {
/* 305 */         return Complex.getInstance(cosh(((Complex)arg).getRealPart()), im);
/*     */       }
/*     */     } 
/* 308 */     if (arg instanceof SingleFloat) {
/* 309 */       double d = Math.cosh(((SingleFloat)arg).value);
/* 310 */       return new SingleFloat((float)d);
/* 311 */     }  if (arg instanceof DoubleFloat) {
/* 312 */       double d = Math.cosh(((DoubleFloat)arg).value);
/* 313 */       return new DoubleFloat(d);
/*     */     } 
/* 315 */     LispObject result = exp(arg);
/* 316 */     result = result.add(exp(arg.multiplyBy(Fixnum.MINUS_ONE)));
/* 317 */     result = result.divideBy(Fixnum.TWO);
/*     */     
/* 319 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 323 */   private static final Primitive TANH = new Primitive("tanh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 328 */         if (arg instanceof SingleFloat) {
/* 329 */           double d = Math.tanh(((SingleFloat)arg).value);
/* 330 */           return new SingleFloat((float)d);
/* 331 */         }  if (arg instanceof DoubleFloat) {
/* 332 */           double d = Math.tanh(((DoubleFloat)arg).value);
/* 333 */           return new DoubleFloat(d);
/*     */         } 
/* 335 */         return MathFunctions.sinh(arg).divideBy(MathFunctions.cosh(arg));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 340 */   private static final Primitive ASINH = new Primitive("asinh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 345 */         return MathFunctions.asinh(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject asinh(LispObject arg) {
/* 351 */     if (arg instanceof Complex) {
/* 352 */       LispObject im = ((Complex)arg).getImaginaryPart();
/* 353 */       if (im.zerop()) {
/* 354 */         return Complex.getInstance(asinh(((Complex)arg).getRealPart()), im);
/*     */       }
/*     */     } 
/* 357 */     LispObject result = arg.multiplyBy(arg);
/* 358 */     result = Fixnum.ONE.add(result);
/* 359 */     result = sqrt(result);
/* 360 */     result = result.add(arg);
/* 361 */     result = log(result);
/*     */     
/* 363 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 367 */   private static final Primitive ACOSH = new Primitive("acosh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 372 */         return MathFunctions.acosh(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject acosh(LispObject arg) {
/* 378 */     if (arg instanceof Complex) {
/* 379 */       LispObject im = ((Complex)arg).getImaginaryPart();
/* 380 */       if (im.zerop()) {
/* 381 */         return Complex.getInstance(acosh(((Complex)arg).getRealPart()), im);
/*     */       }
/*     */     } 
/* 384 */     LispObject n1 = arg.add(Fixnum.ONE);
/* 385 */     n1 = n1.divideBy(Fixnum.TWO);
/* 386 */     n1 = sqrt(n1);
/* 387 */     LispObject n2 = arg.subtract(Fixnum.ONE);
/* 388 */     n2 = n2.divideBy(Fixnum.TWO);
/* 389 */     n2 = sqrt(n2);
/* 390 */     LispObject result = n1.add(n2);
/* 391 */     result = log(result);
/* 392 */     result = result.multiplyBy(Fixnum.TWO);
/*     */     
/* 394 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 398 */   private static final Primitive ATANH = new Primitive("atanh", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 403 */         return MathFunctions.atanh(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject atanh(LispObject arg) {
/* 409 */     if (arg instanceof Complex) {
/* 410 */       LispObject im = ((Complex)arg).getImaginaryPart();
/* 411 */       if (im.zerop()) {
/* 412 */         return Complex.getInstance(atanh(((Complex)arg).getRealPart()), im);
/*     */       }
/*     */     } 
/* 415 */     LispObject n1 = log(Fixnum.ONE.add(arg));
/* 416 */     LispObject n2 = log(Fixnum.ONE.subtract(arg));
/* 417 */     LispObject result = n1.subtract(n2);
/* 418 */     result = result.divideBy(Fixnum.TWO);
/*     */     
/* 420 */     return complexToRealFixup(result, arg);
/*     */   }
/*     */ 
/*     */   
/* 424 */   private static final Primitive CIS = new Primitive("cis", "radians")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 429 */         return MathFunctions.cis(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject cis(LispObject arg) {
/* 435 */     if (arg.realp())
/* 436 */       return Complex.getInstance(cos(arg), sin(arg)); 
/* 437 */     return Lisp.type_error(arg, Symbol.REAL);
/*     */   }
/*     */ 
/*     */   
/* 441 */   private static final Primitive EXP = new Primitive("exp", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 446 */         return MathFunctions.exp(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static LispObject exp(LispObject arg) {
/* 452 */     if (arg.realp()) {
/* 453 */       if (arg instanceof DoubleFloat) {
/* 454 */         double d = Math.pow(Math.E, ((DoubleFloat)arg).value);
/* 455 */         return OverUnderFlowCheck(new DoubleFloat(d));
/*     */       } 
/* 457 */       float f = (float)Math.pow(Math.E, (SingleFloat.coerceToFloat(arg)).value);
/* 458 */       return OverUnderFlowCheck(new SingleFloat(f));
/*     */     } 
/*     */     
/* 461 */     if (arg instanceof Complex) {
/* 462 */       Complex c = (Complex)arg;
/* 463 */       return exp(c.getRealPart()).multiplyBy(cis(c.getImaginaryPart()));
/*     */     } 
/* 465 */     return Lisp.type_error(arg, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */   
/* 469 */   private static final Primitive SQRT = new Primitive("sqrt", "number")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 474 */         return MathFunctions.sqrt(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static final LispObject sqrt(LispObject obj) {
/* 480 */     if (obj instanceof DoubleFloat) {
/* 481 */       if (obj.minusp())
/* 482 */         return Complex.getInstance(new DoubleFloat(0.0D), sqrt(obj.negate())); 
/* 483 */       return new DoubleFloat(Math.sqrt((DoubleFloat.coerceToFloat(obj)).value));
/*     */     } 
/* 485 */     if (obj.realp()) {
/* 486 */       if (obj.minusp())
/* 487 */         return Complex.getInstance(new SingleFloat(0.0F), sqrt(obj.negate())); 
/* 488 */       return new SingleFloat((float)Math.sqrt((SingleFloat.coerceToFloat(obj)).value));
/*     */     } 
/* 490 */     if (obj instanceof Complex) {
/* 491 */       LispObject imagpart = ((Complex)obj).imagpart;
/* 492 */       if (imagpart.zerop()) {
/* 493 */         LispObject realpart = ((Complex)obj).realpart;
/* 494 */         if (realpart.minusp()) {
/* 495 */           return Complex.getInstance(imagpart, sqrt(realpart.negate()));
/*     */         }
/* 497 */         return Complex.getInstance(sqrt(realpart), imagpart);
/*     */       } 
/* 499 */       return exp(log(obj).divideBy(Fixnum.TWO));
/*     */     } 
/* 501 */     return Lisp.type_error(obj, Symbol.NUMBER);
/*     */   }
/*     */ 
/*     */   
/* 505 */   private static final Primitive LOG = new Primitive("log", "number &optional base")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 511 */         return MathFunctions.log(arg);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject number, LispObject base) {
/* 517 */         if (number.realp() && !number.minusp() && base
/* 518 */           .isEqualTo(Fixnum.getInstance(10))) {
/*     */           
/* 520 */           double d = Math.log10((DoubleFloat.coerceToFloat(number)).value);
/* 521 */           if (number instanceof DoubleFloat || base instanceof DoubleFloat)
/*     */           {
/* 523 */             return new DoubleFloat(d);
/*     */           }
/* 525 */           return new SingleFloat((float)d);
/*     */         } 
/* 527 */         return MathFunctions.log(number).divideBy(MathFunctions.log(base));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   static final LispObject log(LispObject obj) {
/* 533 */     if (obj.realp() && !obj.minusp()) {
/*     */       
/* 535 */       if (obj instanceof Fixnum)
/* 536 */         return new SingleFloat((float)Math.log(((Fixnum)obj).value)); 
/* 537 */       if (obj instanceof Bignum)
/* 538 */         return new SingleFloat((float)Math.log(((Bignum)obj).doubleValue())); 
/* 539 */       if (obj instanceof Ratio)
/* 540 */         return new SingleFloat((float)Math.log(((Ratio)obj).doubleValue())); 
/* 541 */       if (obj instanceof SingleFloat)
/* 542 */         return new SingleFloat((float)Math.log(((SingleFloat)obj).value)); 
/* 543 */       if (obj instanceof DoubleFloat) {
/* 544 */         return new DoubleFloat(Math.log(((DoubleFloat)obj).value));
/*     */       }
/*     */     } else {
/* 547 */       if (obj.realp() && obj.minusp()) {
/* 548 */         if (obj instanceof DoubleFloat) {
/* 549 */           DoubleFloat doubleFloat1 = DoubleFloat.coerceToFloat(obj);
/* 550 */           DoubleFloat doubleFloat2 = new DoubleFloat(Math.abs(doubleFloat1.value));
/* 551 */           DoubleFloat doubleFloat3 = new DoubleFloat(Math.PI);
/* 552 */           return Complex.getInstance(new DoubleFloat(Math.log(doubleFloat2.getValue())), doubleFloat3);
/*     */         } 
/* 554 */         SingleFloat re = SingleFloat.coerceToFloat(obj);
/* 555 */         SingleFloat abs = new SingleFloat(Math.abs(re.value));
/* 556 */         SingleFloat phase = new SingleFloat(3.1415927F);
/* 557 */         return Complex.getInstance(new SingleFloat((float)Math.log(abs.value)), phase);
/*     */       } 
/* 559 */       if (obj instanceof Complex) {
/* 560 */         if (((Complex)obj).getRealPart() instanceof DoubleFloat) {
/* 561 */           DoubleFloat doubleFloat1 = DoubleFloat.coerceToFloat(((Complex)obj).getRealPart());
/* 562 */           DoubleFloat doubleFloat2 = DoubleFloat.coerceToFloat(((Complex)obj).getImaginaryPart());
/*     */           
/* 564 */           DoubleFloat doubleFloat3 = new DoubleFloat(Math.atan2(doubleFloat2.getValue(), doubleFloat1.getValue()));
/* 565 */           DoubleFloat doubleFloat4 = DoubleFloat.coerceToFloat(obj.ABS());
/* 566 */           return Complex.getInstance(new DoubleFloat(Math.log(doubleFloat4.getValue())), doubleFloat3);
/*     */         } 
/* 568 */         SingleFloat re = SingleFloat.coerceToFloat(((Complex)obj).getRealPart());
/* 569 */         SingleFloat im = SingleFloat.coerceToFloat(((Complex)obj).getImaginaryPart());
/*     */         
/* 571 */         SingleFloat phase = new SingleFloat((float)Math.atan2(im.value, re.value));
/* 572 */         SingleFloat abs = SingleFloat.coerceToFloat(obj.ABS());
/* 573 */         return Complex.getInstance(new SingleFloat((float)Math.log(abs.value)), phase);
/*     */       } 
/*     */     } 
/*     */     
/* 577 */     Lisp.type_error(obj, Symbol.NUMBER);
/* 578 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */   
/* 582 */   public static final Primitive EXPT = new Primitive("expt", "base-number power-number")
/*     */     {
/*     */       public LispObject execute(LispObject base, LispObject power)
/*     */       {
/*     */         double x, y;
/*     */ 
/*     */         
/* 589 */         if (power.zerop()) {
/* 590 */           if (power instanceof Fixnum) {
/* 591 */             if (base instanceof SingleFloat)
/* 592 */               return SingleFloat.ONE; 
/* 593 */             if (base instanceof DoubleFloat)
/* 594 */               return DoubleFloat.ONE; 
/* 595 */             if (base instanceof Complex) {
/* 596 */               if (((Complex)base).realpart instanceof SingleFloat) {
/* 597 */                 return Complex.getInstance(SingleFloat.ONE, SingleFloat.ZERO);
/*     */               }
/* 599 */               if (((Complex)base).realpart instanceof DoubleFloat) {
/* 600 */                 return Complex.getInstance(DoubleFloat.ONE, DoubleFloat.ZERO);
/*     */               }
/*     */             } 
/* 603 */             return Fixnum.ONE;
/*     */           } 
/* 605 */           if (power instanceof DoubleFloat)
/* 606 */             return DoubleFloat.ONE; 
/* 607 */           if (base instanceof DoubleFloat)
/* 608 */             return DoubleFloat.ONE; 
/* 609 */           return SingleFloat.ONE;
/*     */         } 
/* 611 */         if (base.zerop())
/* 612 */           return base; 
/* 613 */         if (base.isEqualTo(1)) {
/* 614 */           return base;
/*     */         }
/* 616 */         if ((power instanceof Fixnum || power instanceof Bignum) && (base
/*     */           
/* 618 */           .rationalp() || (base instanceof Complex && ((Complex)base).realpart
/*     */           
/* 620 */           .rationalp())))
/*     */         {
/* 622 */           return MathFunctions.intexp(base, power);
/*     */         }
/*     */ 
/*     */         
/* 626 */         boolean wantDoubleFloat = false;
/* 627 */         if (base instanceof DoubleFloat) {
/* 628 */           wantDoubleFloat = true;
/* 629 */         } else if (power instanceof DoubleFloat) {
/* 630 */           wantDoubleFloat = true;
/* 631 */         } else if (base instanceof Complex && (((Complex)base)
/* 632 */           .getRealPart() instanceof DoubleFloat || ((Complex)base)
/* 633 */           .getImaginaryPart() instanceof DoubleFloat)) {
/* 634 */           wantDoubleFloat = true;
/* 635 */         } else if (power instanceof Complex && (((Complex)power)
/* 636 */           .getRealPart() instanceof DoubleFloat || ((Complex)power)
/* 637 */           .getImaginaryPart() instanceof DoubleFloat)) {
/* 638 */           wantDoubleFloat = true;
/*     */         } 
/* 640 */         if (wantDoubleFloat) {
/* 641 */           if (power instanceof Complex) {
/* 642 */             power = ((Complex)power).coerceToDoubleFloat();
/*     */           } else {
/* 644 */             power = DoubleFloat.coerceToFloat(power);
/*     */           } 
/* 646 */           if (base instanceof Complex) {
/* 647 */             base = ((Complex)base).coerceToDoubleFloat();
/*     */           } else {
/* 649 */             base = DoubleFloat.coerceToFloat(base);
/*     */           } 
/*     */         } 
/*     */ 
/*     */         
/* 654 */         if (base instanceof Complex || power instanceof Complex) {
/* 655 */           return MathFunctions.exp(power.multiplyBy(MathFunctions.log(base)));
/*     */         }
/*     */         
/* 658 */         if (base instanceof Fixnum) {
/* 659 */           x = ((Fixnum)base).value;
/* 660 */         } else if (base instanceof Bignum) {
/* 661 */           x = ((Bignum)base).doubleValue();
/* 662 */         } else if (base instanceof Ratio) {
/* 663 */           x = ((Ratio)base).doubleValue();
/* 664 */         } else if (base instanceof SingleFloat) {
/* 665 */           x = ((SingleFloat)base).value;
/* 666 */         } else if (base instanceof DoubleFloat) {
/* 667 */           x = ((DoubleFloat)base).value;
/*     */         } else {
/* 669 */           return Lisp.error(new LispError("EXPT: unsupported case: base is of type " + base
/* 670 */                 .typeOf().princToString()));
/*     */         } 
/* 672 */         if (power instanceof Fixnum) {
/* 673 */           y = ((Fixnum)power).value;
/* 674 */         } else if (power instanceof Bignum) {
/* 675 */           y = ((Bignum)power).doubleValue();
/* 676 */         } else if (power instanceof Ratio) {
/* 677 */           y = ((Ratio)power).doubleValue();
/* 678 */         } else if (power instanceof SingleFloat) {
/* 679 */           y = ((SingleFloat)power).value;
/* 680 */         } else if (power instanceof DoubleFloat) {
/* 681 */           y = ((DoubleFloat)power).value;
/*     */         } else {
/* 683 */           return Lisp.error(new LispError("EXPT: unsupported case: power is of type " + power
/* 684 */                 .typeOf().princToString()));
/* 685 */         }  double r = Math.pow(x, y);
/* 686 */         if (Double.isNaN(r) && 
/* 687 */           x < 0.0D) {
/* 688 */           r = Math.pow(-x, y);
/* 689 */           double realPart = r * Math.cos(y * Math.PI);
/* 690 */           double imagPart = r * Math.sin(y * Math.PI);
/* 691 */           if (base instanceof DoubleFloat || power instanceof DoubleFloat) {
/* 692 */             return 
/* 693 */               Complex.getInstance(MathFunctions.OverUnderFlowCheck(new DoubleFloat(realPart)), 
/* 694 */                 MathFunctions.OverUnderFlowCheck(new DoubleFloat(imagPart)));
/*     */           }
/* 696 */           return 
/* 697 */             Complex.getInstance(MathFunctions.OverUnderFlowCheck(new SingleFloat((float)realPart)), 
/* 698 */               MathFunctions.OverUnderFlowCheck(new SingleFloat((float)imagPart)));
/*     */         } 
/*     */         
/* 701 */         if (base instanceof DoubleFloat || power instanceof DoubleFloat) {
/* 702 */           return MathFunctions.OverUnderFlowCheck(new DoubleFloat(r));
/*     */         }
/* 704 */         return MathFunctions.OverUnderFlowCheck(new SingleFloat((float)r));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject OverUnderFlowCheck(LispObject number) {
/* 716 */     if (number instanceof Complex) {
/* 717 */       OverUnderFlowCheck(((Complex)number).realpart);
/* 718 */       OverUnderFlowCheck(((Complex)number).imagpart);
/* 719 */       return number;
/*     */     } 
/*     */     
/* 722 */     if (Lisp.TRAP_OVERFLOW) {
/* 723 */       if (number instanceof SingleFloat && 
/* 724 */         Float.isInfinite(((SingleFloat)number).value))
/* 725 */         return Lisp.error(new FloatingPointOverflow(Lisp.NIL)); 
/* 726 */       if (number instanceof DoubleFloat && 
/* 727 */         Double.isInfinite(((DoubleFloat)number).value))
/* 728 */         return Lisp.error(new FloatingPointOverflow(Lisp.NIL)); 
/*     */     } 
/* 730 */     if (Lisp.TRAP_UNDERFLOW && 
/* 731 */       number.zerop()) {
/* 732 */       return Lisp.error(new FloatingPointUnderflow(Lisp.NIL));
/*     */     }
/* 734 */     return number;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final float OverUnderFlowCheck(float number) {
/* 745 */     if (Lisp.TRAP_OVERFLOW && 
/* 746 */       Float.isInfinite(number)) {
/* 747 */       Lisp.error(new FloatingPointOverflow(Lisp.NIL));
/*     */     }
/* 749 */     if (Lisp.TRAP_UNDERFLOW && 
/* 750 */       number == 0.0F) {
/* 751 */       Lisp.error(new FloatingPointUnderflow(Lisp.NIL));
/*     */     }
/* 753 */     return number;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static final double OverUnderFlowCheck(double number) {
/* 764 */     if (Lisp.TRAP_OVERFLOW && 
/* 765 */       Double.isInfinite(number)) {
/* 766 */       Lisp.error(new FloatingPointOverflow(Lisp.NIL));
/*     */     }
/* 768 */     if (Lisp.TRAP_UNDERFLOW && 
/* 769 */       number == 0.0D) {
/* 770 */       Lisp.error(new FloatingPointUnderflow(Lisp.NIL));
/*     */     }
/* 772 */     return number;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject intexp(LispObject base, LispObject power) {
/*     */     LispObject total;
/* 783 */     if (power.isEqualTo(0))
/* 784 */       return Fixnum.ONE; 
/* 785 */     if (base.isEqualTo(1))
/* 786 */       return base; 
/* 787 */     if (base.isEqualTo(0)) {
/* 788 */       return base;
/*     */     }
/* 790 */     if (power.minusp()) {
/* 791 */       power = Fixnum.ZERO.subtract(power);
/* 792 */       return Fixnum.ONE.divideBy(intexp(base, power));
/*     */     } 
/* 794 */     if (base.eql(Fixnum.TWO)) {
/* 795 */       return Fixnum.ONE.ash(power);
/*     */     }
/* 797 */     LispObject nextn = power.ash(Fixnum.MINUS_ONE);
/*     */     
/* 799 */     if (power.oddp()) {
/* 800 */       total = base;
/*     */     } else {
/* 802 */       total = Fixnum.ONE;
/*     */     }  while (true) {
/* 804 */       if (nextn.zerop())
/* 805 */         return total; 
/* 806 */       base = base.multiplyBy(base);
/*     */       
/* 808 */       if (nextn.oddp())
/* 809 */         total = base.multiplyBy(total); 
/* 810 */       nextn = nextn.ash(Fixnum.MINUS_ONE);
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/MathFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */