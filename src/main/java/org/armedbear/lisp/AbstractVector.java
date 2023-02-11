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
/*     */ public abstract class AbstractVector
/*     */   extends AbstractArray
/*     */ {
/*     */   public LispObject typep(LispObject type) {
/*  42 */     if (type == Symbol.VECTOR)
/*  43 */       return Lisp.T; 
/*  44 */     if (type == BuiltInClass.VECTOR)
/*  45 */       return Lisp.T; 
/*  46 */     if (type == Symbol.SEQUENCE)
/*  47 */       return Lisp.T; 
/*  48 */     if (type == BuiltInClass.SEQUENCE)
/*  49 */       return Lisp.T; 
/*  50 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean vectorp() {
/*  56 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/*  62 */     if (obj instanceof AbstractVector) {
/*     */       
/*  64 */       if (length() != obj.length())
/*  65 */         return false; 
/*  66 */       AbstractVector v = (AbstractVector)obj;
/*  67 */       for (int i = length(); i-- > 0;) {
/*  68 */         if (!AREF(i).equalp(v.AREF(i)))
/*  69 */           return false; 
/*  70 */       }  return true;
/*     */     } 
/*  72 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getRank() {
/*  78 */     return 1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getDimensions() {
/*  84 */     return new Cons(Fixnum.getInstance(capacity()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getDimension(int n) {
/*  90 */     if (n != 0) {
/*     */       
/*  92 */       Lisp.error(new TypeError("bad dimension for vector"));
/*     */       
/*  94 */       return 0;
/*     */     } 
/*  96 */     return capacity();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getTotalSize() {
/* 102 */     return capacity();
/*     */   }
/*     */ 
/*     */   
/*     */   public abstract int capacity();
/*     */   
/*     */   public abstract LispObject subseq(int paramInt1, int paramInt2);
/*     */   
/*     */   public LispObject deleteEq(LispObject item) {
/* 111 */     int limit = length();
/* 112 */     int i = 0;
/* 113 */     int j = 0;
/* 114 */     while (i < limit) {
/*     */       
/* 116 */       LispObject obj = AREF(i++);
/* 117 */       if (obj != item)
/* 118 */         aset(j++, obj); 
/*     */     } 
/* 120 */     int newLength = j;
/* 121 */     if (newLength < capacity())
/* 122 */       shrink(newLength); 
/* 123 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject deleteEql(LispObject item) {
/* 128 */     int limit = length();
/* 129 */     int i = 0;
/* 130 */     int j = 0;
/* 131 */     while (i < limit) {
/*     */       
/* 133 */       LispObject obj = AREF(i++);
/* 134 */       if (!obj.eql(item))
/* 135 */         aset(j++, obj); 
/*     */     } 
/* 137 */     int newLength = j;
/* 138 */     if (newLength < capacity())
/* 139 */       shrink(newLength); 
/* 140 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public abstract void shrink(int paramInt);
/*     */   
/*     */   public int checkIndex(int index) {
/* 147 */     if (index < 0 || index >= capacity())
/* 148 */       badIndex(index, capacity()); 
/* 149 */     return index;
/*     */   }
/*     */ 
/*     */   
/*     */   protected void badIndex(int index, int limit) {
/* 154 */     StringBuilder sb = new StringBuilder("Invalid array index ");
/* 155 */     sb.append(index);
/* 156 */     sb.append(" for ");
/* 157 */     sb.append(princToString());
/* 158 */     if (limit > 0) {
/*     */       
/* 160 */       sb.append(" (should be >= 0 and < ");
/* 161 */       sb.append(limit);
/* 162 */       sb.append(").");
/*     */     } 
/* 164 */     Lisp.error(new TypeError(sb.toString(), 
/* 165 */           Fixnum.getInstance(index), 
/* 166 */           Lisp.list(Symbol.INTEGER, new LispObject[] {
/*     */               
/* 168 */               Fixnum.ZERO, Fixnum.getInstance(limit - 1)
/*     */             })));
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/* 174 */     noFillPointer();
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/* 179 */     noFillPointer();
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isSimpleVector() {
/* 184 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public abstract LispObject reverse();
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 193 */     int i = 0;
/* 194 */     int j = length() - 1;
/* 195 */     while (i < j) {
/*     */       
/* 197 */       LispObject temp = AREF(i);
/* 198 */       aset(i, AREF(j));
/* 199 */       aset(j, temp);
/* 200 */       i++;
/* 201 */       j--;
/*     */     } 
/* 203 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 209 */     LispThread thread = LispThread.currentThread();
/* 210 */     if (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 212 */       StringBuilder stringBuilder = new StringBuilder("#(");
/* 213 */       int limit = length();
/* 214 */       for (int i = 0; i < limit; i++) {
/*     */         
/* 216 */         if (i > 0)
/* 217 */           stringBuilder.append(' '); 
/* 218 */         stringBuilder.append(AREF(i).printObject());
/*     */       } 
/* 220 */       stringBuilder.append(')');
/* 221 */       return stringBuilder.toString();
/*     */     } 
/* 223 */     if (Symbol.PRINT_ARRAY.symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 225 */       int maxLevel = Integer.MAX_VALUE;
/*     */       
/* 227 */       LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 228 */       if (printLevel instanceof Fixnum) {
/* 229 */         maxLevel = ((Fixnum)printLevel).value;
/*     */       }
/* 231 */       LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 232 */       int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 233 */       if (currentLevel < maxLevel) {
/*     */         
/* 235 */         StringBuffer stringBuffer = new StringBuffer("#(");
/* 236 */         int maxLength = Integer.MAX_VALUE;
/*     */         
/* 238 */         LispObject printLength = Symbol.PRINT_LENGTH.symbolValue(thread);
/* 239 */         if (printLength instanceof Fixnum)
/* 240 */           maxLength = ((Fixnum)printLength).value; 
/* 241 */         int length = length();
/* 242 */         int limit = Math.min(length, maxLength);
/* 243 */         SpecialBindingsMark mark = thread.markSpecialBindings();
/* 244 */         thread.bindSpecial(Lisp._CURRENT_PRINT_LEVEL_, currentPrintLevel.incr());
/*     */         
/*     */         try {
/* 247 */           for (int i = 0; i < limit; i++)
/*     */           {
/* 249 */             if (i > 0)
/* 250 */               stringBuffer.append(' '); 
/* 251 */             stringBuffer.append(AREF(i).printObject());
/*     */           }
/*     */         
/*     */         } finally {
/*     */           
/* 256 */           thread.resetSpecialBindings(mark);
/*     */         } 
/* 258 */         if (limit < length)
/* 259 */           stringBuffer.append((limit > 0) ? " ..." : "..."); 
/* 260 */         stringBuffer.append(')');
/* 261 */         return stringBuffer.toString();
/*     */       } 
/*     */       
/* 264 */       return "#";
/*     */     } 
/*     */ 
/*     */     
/* 268 */     StringBuffer sb = new StringBuffer();
/* 269 */     sb.append(isSimpleVector() ? "SIMPLE-VECTOR " : "VECTOR ");
/* 270 */     sb.append(capacity());
/* 271 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 279 */     int length = length();
/* 280 */     int limit = (length < 4) ? length : 4;
/* 281 */     long result = 48920713L;
/* 282 */     for (int i = 0; i < limit; i++)
/* 283 */       result = Lisp.mix(result, AREF(i).psxhash()); 
/* 284 */     return (int)(result & 0x7FFFFFFFL);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public abstract AbstractArray adjustArray(int paramInt, LispObject paramLispObject1, LispObject paramLispObject2);
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public abstract AbstractArray adjustArray(int paramInt1, AbstractArray paramAbstractArray, int paramInt2);
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 301 */     return adjustArray(dims[0], initialElement, initialContents);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 308 */     return adjustArray(dims[0], displacedTo, displacement);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AbstractVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */