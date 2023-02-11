/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.ByteArrayInputStream;
/*     */ import java.io.ByteArrayOutputStream;
/*     */ import java.io.ObjectInputStream;
/*     */ import java.io.ObjectOutputStream;
/*     */ import java.math.BigInteger;
/*     */ import java.util.Random;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class RandomState
/*     */   extends LispObject
/*     */ {
/*     */   private Random random;
/*     */   
/*     */   public RandomState() {
/*  51 */     this.random = new Random();
/*     */   }
/*     */ 
/*     */   
/*     */   public RandomState(RandomState rs) {
/*     */     try {
/*  57 */       ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
/*  58 */       ObjectOutputStream out = new ObjectOutputStream(byteOut);
/*  59 */       out.writeObject(rs.random);
/*  60 */       out.close();
/*  61 */       ByteArrayInputStream byteIn = new ByteArrayInputStream(byteOut.toByteArray());
/*  62 */       ObjectInputStream in = new ObjectInputStream(byteIn);
/*  63 */       this.random = (Random)in.readObject();
/*  64 */       in.close();
/*     */     }
/*  66 */     catch (Throwable t) {
/*  67 */       Lisp.error(new LispError("Unable to copy random state."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public RandomState(SimpleVector v) {
/*  73 */     int length = v.capacity;
/*  74 */     byte[] bytes = new byte[length];
/*  75 */     for (int i = 0; i < length; i++) {
/*  76 */       LispObject obj = v.data[i];
/*  77 */       if (obj instanceof Fixnum) {
/*  78 */         bytes[i] = (byte)((Fixnum)obj).value;
/*     */       } else {
/*  80 */         Lisp.error(Lisp.type_error(obj, Symbol.FIXNUM));
/*     */       } 
/*     */     } 
/*     */     try {
/*  84 */       ByteArrayInputStream byteIn = new ByteArrayInputStream(bytes);
/*  85 */       ObjectInputStream in = new ObjectInputStream(byteIn);
/*  86 */       this.random = (Random)in.readObject();
/*  87 */       in.close();
/*     */     }
/*  89 */     catch (Throwable t) {
/*  90 */       Lisp.error(new LispError("Unable to read random state."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  97 */     return Symbol.RANDOM_STATE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 103 */     return BuiltInClass.RANDOM_STATE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 109 */     if (type == Symbol.RANDOM_STATE)
/* 110 */       return Lisp.T; 
/* 111 */     if (type == BuiltInClass.RANDOM_STATE)
/* 112 */       return Lisp.T; 
/* 113 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 119 */     LispThread thread = LispThread.currentThread();
/* 120 */     StringBuilder sb = new StringBuilder();
/* 121 */     if (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 123 */       if (Symbol.READ_EVAL.symbolValue(thread) == Lisp.NIL) {
/* 124 */         Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */         
/* 126 */         return null;
/*     */       } 
/* 128 */       int base = Fixnum.getValue(Symbol.PRINT_BASE.symbolValue(thread));
/* 129 */       ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
/*     */       try {
/* 131 */         sb.append("#.(SYSTEM::READ-RANDOM-STATE #(");
/* 132 */         ObjectOutputStream out = new ObjectOutputStream(byteOut);
/* 133 */         out.writeObject(this.random);
/* 134 */         out.close();
/*     */       }
/* 136 */       catch (Throwable t) {
/* 137 */         Lisp.error(new LispError("Unable to copy random state."));
/*     */       } 
/* 139 */       byte[] bytes = byteOut.toByteArray();
/* 140 */       for (int i = 0; i < bytes.length; i++) {
/* 141 */         if (i != 0) {
/* 142 */           sb.append(" ");
/*     */         }
/* 144 */         sb.append(Integer.toString(bytes[i], base).toUpperCase());
/*     */       } 
/* 146 */       sb.append("))");
/*     */     } else {
/* 148 */       return unreadableString("RANDOM-STATE");
/*     */     } 
/* 150 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject random(LispObject arg) {
/* 155 */     if (arg instanceof Fixnum) {
/* 156 */       int limit = ((Fixnum)arg).value;
/* 157 */       if (limit > 0) {
/* 158 */         int n = this.random.nextInt(limit);
/* 159 */         return Fixnum.getInstance(n);
/*     */       } 
/* 161 */     } else if (arg instanceof Bignum) {
/* 162 */       BigInteger limit = ((Bignum)arg).value;
/* 163 */       if (limit.signum() > 0) {
/* 164 */         int bitLength = limit.bitLength();
/* 165 */         BigInteger rand = new BigInteger(bitLength + 1, this.random);
/* 166 */         BigInteger remainder = rand.remainder(limit);
/* 167 */         return Lisp.number(remainder);
/*     */       } 
/* 169 */     } else if (arg instanceof SingleFloat) {
/* 170 */       float limit = ((SingleFloat)arg).value;
/* 171 */       if (limit > 0.0F) {
/* 172 */         float rand = this.random.nextFloat();
/* 173 */         return new SingleFloat(rand * limit);
/*     */       } 
/* 175 */     } else if (arg instanceof DoubleFloat) {
/* 176 */       double limit = ((DoubleFloat)arg).value;
/* 177 */       if (limit > 0.0D) {
/* 178 */         double rand = this.random.nextDouble();
/* 179 */         return new DoubleFloat(rand * limit);
/*     */       } 
/*     */     } 
/* 182 */     return Lisp.type_error(arg, Lisp.list(Symbol.OR, new LispObject[] {
/* 183 */             Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.ONE
/* 184 */               }), Lisp.list(Symbol.FLOAT, new LispObject[] { Lisp.list(Fixnum.ZERO, new LispObject[0]) })
/*     */           }));
/*     */   }
/*     */   
/* 188 */   private static final Primitive RANDOM = new Primitive(Symbol.RANDOM, "limit &optional random-state")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 195 */         RandomState randomState = (RandomState)Symbol._RANDOM_STATE_.symbolValue();
/* 196 */         return randomState.random(arg);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 202 */         if (second instanceof RandomState) {
/* 203 */           RandomState randomState = (RandomState)second;
/* 204 */           return randomState.random(first);
/*     */         } 
/* 206 */         return Lisp.type_error(first, Symbol.RANDOM_STATE);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 211 */   private static final Primitive MAKE_RANDOM_STATE = new Primitive(Symbol.MAKE_RANDOM_STATE, "&optional state")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 217 */         return new RandomState((RandomState)Symbol._RANDOM_STATE_.symbolValue());
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 223 */         if (arg == Lisp.NIL)
/* 224 */           return new RandomState((RandomState)Symbol._RANDOM_STATE_.symbolValue()); 
/* 225 */         if (arg == Lisp.T)
/* 226 */           return new RandomState(); 
/* 227 */         if (arg instanceof RandomState)
/* 228 */           return new RandomState((RandomState)arg); 
/* 229 */         return Lisp.type_error(arg, Symbol.RANDOM_STATE);
/*     */       }
/*     */     };
/*     */   
/* 233 */   private static final Primitive READ_RANDOM_STATE = new Primitive(Symbol.READ_RANDOM_STATE, "state")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 240 */         if (arg instanceof SimpleVector)
/* 241 */           return new RandomState((SimpleVector)arg); 
/* 242 */         return Lisp.type_error(arg, Symbol.RANDOM_STATE);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 247 */   private static final Primitive RANDOM_STATE_P = new Primitive(Symbol.RANDOM_STATE_P, "object")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 253 */         return (arg instanceof RandomState) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/RandomState.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */