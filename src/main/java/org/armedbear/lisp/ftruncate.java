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
/*     */ public final class ftruncate
/*     */   extends Primitive
/*     */ {
/*     */   private ftruncate() {
/*  49 */     super("ftruncate", "number &optional divisor");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/*  55 */     LispThread thread = LispThread.currentThread();
/*  56 */     if (arg.zerop()) {
/*  57 */       LispObject r, lispObject1 = arg;
/*     */       
/*  59 */       if (arg instanceof DoubleFloat) {
/*  60 */         r = DoubleFloat.ZERO;
/*     */       } else {
/*  62 */         r = SingleFloat.ZERO;
/*  63 */       }  return thread.setValues(lispObject1, r);
/*     */     } 
/*  65 */     if (arg instanceof DoubleFloat) {
/*  66 */       double d = ((DoubleFloat)arg).value;
/*  67 */       if (Double.isInfinite(d) || Double.isNaN(d))
/*  68 */         return thread.setValues(arg, new DoubleFloat(Double.NaN)); 
/*  69 */     } else if (arg instanceof SingleFloat) {
/*  70 */       float f = ((SingleFloat)arg).value;
/*  71 */       if (Float.isInfinite(f) || Float.isNaN(f))
/*  72 */         return thread.setValues(arg, new SingleFloat(Float.NaN)); 
/*     */     } 
/*  74 */     LispObject q = arg.truncate(Fixnum.ONE);
/*  75 */     if (arg instanceof DoubleFloat) {
/*  76 */       if (q.zerop()) {
/*  77 */         if (arg.minusp())
/*  78 */         { q = new DoubleFloat(-0.0D); }
/*     */         else
/*  80 */         { q = new DoubleFloat(0.0D); } 
/*  81 */       } else if (q instanceof Fixnum) {
/*  82 */         q = new DoubleFloat(((Fixnum)q).value);
/*     */       } else {
/*  84 */         q = new DoubleFloat(((Bignum)q).doubleValue());
/*     */       } 
/*  86 */     } else if (q.zerop()) {
/*  87 */       if (arg.minusp())
/*  88 */       { q = new SingleFloat(-0.0F); }
/*     */       else
/*  90 */       { q = new SingleFloat(0.0F); } 
/*  91 */     } else if (q instanceof Fixnum) {
/*  92 */       q = new SingleFloat(((Fixnum)q).value);
/*     */     } else {
/*  94 */       q = new SingleFloat(((Bignum)q).floatValue());
/*     */     } 
/*  96 */     thread._values[0] = q;
/*  97 */     return q;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 104 */     LispThread thread = LispThread.currentThread();
/* 105 */     if (first.zerop()) {
/* 106 */       LispObject r, lispObject1 = first;
/*     */       
/* 108 */       if (first instanceof DoubleFloat) {
/* 109 */         r = DoubleFloat.ZERO;
/*     */       } else {
/* 111 */         r = SingleFloat.ZERO;
/* 112 */       }  return thread.setValues(lispObject1, r);
/*     */     } 
/* 114 */     if (first instanceof DoubleFloat) {
/* 115 */       double d1 = ((DoubleFloat)first).value;
/* 116 */       if (Double.isInfinite(d1) || Double.isNaN(d1))
/* 117 */         return thread.setValues(first, new DoubleFloat(Double.NaN)); 
/* 118 */     } else if (first instanceof SingleFloat) {
/* 119 */       float f1 = ((SingleFloat)first).value;
/* 120 */       if (Float.isInfinite(f1) || Float.isNaN(f1))
/* 121 */         return thread.setValues(first, new SingleFloat(Float.NaN)); 
/*     */     } 
/* 123 */     LispObject q = first.truncate(second);
/* 124 */     if (first instanceof DoubleFloat || second instanceof DoubleFloat) {
/* 125 */       if (q.zerop()) {
/* 126 */         if (first.minusp())
/* 127 */         { if (second.minusp())
/* 128 */           { q = new DoubleFloat(0.0D); }
/*     */           else
/* 130 */           { q = new DoubleFloat(-0.0D); }  }
/* 131 */         else if (second.minusp())
/* 132 */         { q = new DoubleFloat(-0.0D); }
/*     */         else
/* 134 */         { q = new DoubleFloat(0.0D); } 
/* 135 */       } else if (q instanceof Fixnum) {
/* 136 */         q = new DoubleFloat(((Fixnum)q).value);
/*     */       } else {
/* 138 */         q = new DoubleFloat(((Bignum)q).doubleValue());
/*     */       } 
/* 140 */     } else if (q.zerop()) {
/* 141 */       if (first.minusp())
/* 142 */       { if (second.minusp())
/* 143 */         { q = new SingleFloat(0.0F); }
/*     */         else
/* 145 */         { q = new SingleFloat(-0.0F); }  }
/* 146 */       else if (second.minusp())
/* 147 */       { q = new SingleFloat(-0.0F); }
/*     */       else
/* 149 */       { q = new SingleFloat(0.0F); } 
/* 150 */     } else if (q instanceof Fixnum) {
/* 151 */       q = new SingleFloat(((Fixnum)q).value);
/*     */     } else {
/* 153 */       q = new SingleFloat(((Bignum)q).floatValue());
/*     */     } 
/* 155 */     thread._values[0] = q;
/* 156 */     return q;
/*     */   }
/*     */   
/* 159 */   private static final Primitive FTRUNCATE = new ftruncate();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ftruncate.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */