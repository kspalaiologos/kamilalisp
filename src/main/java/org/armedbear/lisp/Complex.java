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
/*     */ public final class Complex
/*     */   extends LispObject
/*     */ {
/*     */   public final LispObject realpart;
/*     */   public final LispObject imagpart;
/*     */   
/*     */   private Complex(LispObject realpart, LispObject imagpart) {
/*  45 */     this.realpart = realpart;
/*  46 */     this.imagpart = imagpart;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static LispObject getInstance(LispObject realpart, LispObject imagpart) {
/*  53 */     if (!realpart.realp())
/*  54 */       return Lisp.type_error(realpart, Symbol.REAL); 
/*  55 */     if (!imagpart.realp())
/*  56 */       return Lisp.type_error(imagpart, Symbol.REAL); 
/*  57 */     if (realpart instanceof DoubleFloat) {
/*  58 */       imagpart = DoubleFloat.coerceToFloat(imagpart);
/*  59 */     } else if (imagpart instanceof DoubleFloat) {
/*  60 */       realpart = DoubleFloat.coerceToFloat(realpart);
/*  61 */     } else if (realpart instanceof SingleFloat) {
/*  62 */       imagpart = SingleFloat.coerceToFloat(imagpart);
/*  63 */     } else if (imagpart instanceof SingleFloat) {
/*  64 */       realpart = SingleFloat.coerceToFloat(realpart);
/*  65 */     }  if (imagpart instanceof Fixnum)
/*     */     {
/*  67 */       if (((Fixnum)imagpart).value == 0)
/*  68 */         return realpart; 
/*     */     }
/*  70 */     return new Complex(realpart, imagpart);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getRealPart() {
/*  75 */     return this.realpart;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getImaginaryPart() {
/*  80 */     return this.imagpart;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject coerceToDoubleFloat() {
/*  88 */     return getInstance(DoubleFloat.coerceToFloat(this.realpart), 
/*  89 */         DoubleFloat.coerceToFloat(this.imagpart));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  95 */     return Symbol.COMPLEX;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 101 */     return BuiltInClass.COMPLEX;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 107 */     if (type == Symbol.COMPLEX)
/* 108 */       return Lisp.T; 
/* 109 */     if (type == Symbol.NUMBER)
/* 110 */       return Lisp.T; 
/* 111 */     if (type == BuiltInClass.COMPLEX)
/* 112 */       return Lisp.T; 
/* 113 */     if (type == BuiltInClass.NUMBER)
/* 114 */       return Lisp.T; 
/* 115 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean numberp() {
/* 121 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean eql(LispObject obj) {
/* 127 */     if (this == obj)
/* 128 */       return true; 
/* 129 */     if (obj instanceof Complex) {
/*     */       
/* 131 */       Complex c = (Complex)obj;
/* 132 */       return (this.realpart.eql(c.realpart) && this.imagpart.eql(c.imagpart));
/*     */     } 
/* 134 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 140 */     return eql(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 146 */     if (obj != null && obj.numberp())
/* 147 */       return isEqualTo(obj); 
/* 148 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject incr() {
/* 154 */     return new Complex(this.realpart.add(Fixnum.ONE), this.imagpart);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject decr() {
/* 160 */     return new Complex(this.realpart.subtract(Fixnum.ONE), this.imagpart);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject add(LispObject obj) {
/* 166 */     if (obj instanceof Complex) {
/*     */       
/* 168 */       Complex c = (Complex)obj;
/* 169 */       return getInstance(this.realpart.add(c.realpart), this.imagpart.add(c.imagpart));
/*     */     } 
/* 171 */     return getInstance(this.realpart.add(obj), this.imagpart);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subtract(LispObject obj) {
/* 177 */     if (obj instanceof Complex) {
/*     */       
/* 179 */       Complex c = (Complex)obj;
/* 180 */       return getInstance(this.realpart.subtract(c.realpart), this.imagpart
/* 181 */           .subtract(c.imagpart));
/*     */     } 
/* 183 */     return getInstance(this.realpart.subtract(obj), this.imagpart);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject multiplyBy(LispObject obj) {
/* 189 */     if (obj instanceof Complex) {
/*     */       
/* 191 */       LispObject a = this.realpart;
/* 192 */       LispObject b = this.imagpart;
/* 193 */       LispObject c = ((Complex)obj).getRealPart();
/* 194 */       LispObject d = ((Complex)obj).getImaginaryPart();
/*     */ 
/*     */ 
/*     */       
/* 198 */       LispObject ac = a.multiplyBy(c);
/* 199 */       LispObject bd = b.multiplyBy(d);
/* 200 */       LispObject ad = a.multiplyBy(d);
/* 201 */       LispObject bc = b.multiplyBy(c);
/* 202 */       return getInstance(ac.subtract(bd), ad.add(bc));
/*     */     } 
/* 204 */     return getInstance(this.realpart.multiplyBy(obj), this.imagpart
/* 205 */         .multiplyBy(obj));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject divideBy(LispObject obj) {
/* 211 */     if (obj instanceof Complex) {
/*     */       
/* 213 */       LispObject a = this.realpart;
/* 214 */       LispObject b = this.imagpart;
/* 215 */       LispObject c = ((Complex)obj).getRealPart();
/* 216 */       LispObject d = ((Complex)obj).getImaginaryPart();
/* 217 */       LispObject ac = a.multiplyBy(c);
/* 218 */       LispObject bd = b.multiplyBy(d);
/* 219 */       LispObject bc = b.multiplyBy(c);
/* 220 */       LispObject ad = a.multiplyBy(d);
/* 221 */       LispObject denominator = c.multiplyBy(c).add(d.multiplyBy(d));
/* 222 */       return getInstance(ac.add(bd).divideBy(denominator), bc
/* 223 */           .subtract(ad).divideBy(denominator));
/*     */     } 
/* 225 */     return getInstance(this.realpart.divideBy(obj), this.imagpart
/* 226 */         .divideBy(obj));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isEqualTo(LispObject obj) {
/* 232 */     if (obj instanceof Complex) {
/*     */       
/* 234 */       Complex c = (Complex)obj;
/* 235 */       return (this.realpart.isEqualTo(c.realpart) && this.imagpart
/* 236 */         .isEqualTo(c.imagpart));
/*     */     } 
/* 238 */     if (obj.numberp()) {
/*     */ 
/*     */       
/* 241 */       if (this.imagpart instanceof SingleFloat)
/*     */       {
/* 243 */         if (((SingleFloat)this.imagpart).value == 0.0F) {
/*     */           
/* 245 */           if (obj instanceof Fixnum)
/* 246 */             return (((Fixnum)obj).value == ((SingleFloat)this.realpart).value); 
/* 247 */           if (obj instanceof SingleFloat)
/* 248 */             return (((SingleFloat)obj).value == ((SingleFloat)this.realpart).value); 
/* 249 */           if (obj instanceof DoubleFloat)
/* 250 */             return (((DoubleFloat)obj).value == ((SingleFloat)this.realpart).value); 
/*     */         } 
/*     */       }
/* 253 */       if (this.imagpart instanceof DoubleFloat)
/*     */       {
/* 255 */         if (((DoubleFloat)this.imagpart).value == 0.0D) {
/*     */           
/* 257 */           if (obj instanceof Fixnum)
/* 258 */             return (((Fixnum)obj).value == ((DoubleFloat)this.realpart).value); 
/* 259 */           if (obj instanceof SingleFloat)
/* 260 */             return (((SingleFloat)obj).value == ((DoubleFloat)this.realpart).value); 
/* 261 */           if (obj instanceof DoubleFloat)
/* 262 */             return (((DoubleFloat)obj).value == ((DoubleFloat)this.realpart).value); 
/*     */         } 
/*     */       }
/* 265 */       return false;
/*     */     } 
/* 267 */     Lisp.type_error(obj, Symbol.NUMBER);
/*     */     
/* 269 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isNotEqualTo(LispObject obj) {
/* 275 */     return !isEqualTo(obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject ABS() {
/* 281 */     if (this.realpart.zerop())
/* 282 */       return this.imagpart.ABS(); 
/* 283 */     double real = (DoubleFloat.coerceToFloat(this.realpart)).value;
/* 284 */     double imag = (DoubleFloat.coerceToFloat(this.imagpart)).value;
/* 285 */     if (this.realpart instanceof DoubleFloat) {
/* 286 */       return new DoubleFloat(Math.hypot(real, imag));
/*     */     }
/* 288 */     return new SingleFloat((float)Math.hypot(real, imag));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean zerop() {
/* 294 */     return (this.realpart.zerop() && this.imagpart.zerop());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject COMPLEXP() {
/* 300 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int sxhash() {
/* 306 */     return Lisp.mix(this.realpart.sxhash(), this.imagpart.sxhash()) & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 312 */     return Lisp.mix(this.realpart.psxhash(), this.imagpart.psxhash()) & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 318 */     StringBuilder sb = new StringBuilder("#C(");
/* 319 */     sb.append(this.realpart.printObject());
/* 320 */     sb.append(' ');
/* 321 */     sb.append(this.imagpart.printObject());
/* 322 */     sb.append(')');
/* 323 */     return sb.toString();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Complex.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */