/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.Serializable;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public abstract class AbstractArray
/*     */   extends LispObject
/*     */   implements Serializable
/*     */ {
/*     */   public LispObject typep(LispObject type) {
/*  43 */     if (type == Symbol.ARRAY)
/*  44 */       return Lisp.T; 
/*  45 */     if (type == BuiltInClass.ARRAY)
/*  46 */       return Lisp.T; 
/*  47 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/*  53 */     if (obj instanceof AbstractArray) {
/*  54 */       AbstractArray a = (AbstractArray)obj;
/*  55 */       if (getRank() != a.getRank())
/*  56 */         return false;  int i;
/*  57 */       for (i = getRank(); i-- > 0;) {
/*  58 */         if (getDimension(i) != a.getDimension(i))
/*  59 */           return false; 
/*     */       } 
/*  61 */       for (i = getTotalSize(); i-- > 0;) {
/*  62 */         if (!AREF(i).equalp(a.AREF(i)))
/*  63 */           return false; 
/*     */       } 
/*  65 */       return true;
/*     */     } 
/*  67 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/*  72 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*  77 */     return LispThread.currentThread().setValues(Lisp.NIL, Fixnum.ZERO);
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  82 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  87 */     noFillPointer();
/*  88 */     return -1;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject fillPointer) {
/*  93 */     setFillPointer(fillPointer.intValue());
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFillPointer(int fillPointer) {
/*  98 */     noFillPointer();
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 103 */     return true;
/*     */   }
/*     */ 
/*     */   
/*     */   public abstract int getRank();
/*     */ 
/*     */   
/*     */   public abstract LispObject getDimensions();
/*     */ 
/*     */   
/*     */   public abstract int getDimension(int paramInt);
/*     */ 
/*     */   
/*     */   public abstract LispObject getElementType();
/*     */   
/*     */   public abstract int getTotalSize();
/*     */   
/*     */   public abstract void aset(int paramInt, LispObject paramLispObject);
/*     */   
/*     */   protected static final int computeTotalSize(int[] dimensions) {
/* 123 */     int size = 1;
/* 124 */     for (int i = dimensions.length; i-- > 0;)
/* 125 */       size *= dimensions[i]; 
/* 126 */     return size;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(LispObject[] subscripts) {
/* 132 */     int[] subs = new int[subscripts.length];
/* 133 */     for (int i = 0; i < subscripts.length; i++) {
/* 134 */       LispObject subscript = subscripts[i];
/* 135 */       if (subscript instanceof Fixnum) {
/* 136 */         subs[i] = ((Fixnum)subscript).value;
/*     */       } else {
/* 138 */         Lisp.type_error(subscript, Symbol.FIXNUM);
/*     */       } 
/* 140 */     }  return getRowMajorIndex(subs);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getRowMajorIndex(int[] subscripts) {
/* 145 */     int rank = getRank();
/* 146 */     if (rank != subscripts.length) {
/*     */       
/* 148 */       String errorMsg = "Wrong number of subscripts (%d) for array of rank %d.";
/*     */       
/* 150 */       Lisp.program_error(String.format("Wrong number of subscripts (%d) for array of rank %d.", new Object[] { Integer.valueOf(subscripts.length), Integer.valueOf(rank) }));
/*     */     } 
/* 152 */     int sum = 0;
/* 153 */     int size = 1;
/* 154 */     for (int i = rank; i-- > 0; ) {
/* 155 */       int dim = getDimension(i);
/* 156 */       int lastSize = size;
/* 157 */       size *= dim;
/* 158 */       int n = subscripts[i];
/* 159 */       if (n < 0 || n >= dim) {
/*     */         
/* 161 */         String errorMsg = "Invalid index %d for array %s.";
/*     */         
/* 163 */         Lisp.program_error(String.format("Invalid index %d for array %s.", new Object[] { Integer.valueOf(n), printObject() }));
/*     */       } 
/* 165 */       sum += n * lastSize;
/*     */     } 
/* 167 */     return sum;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject get(int[] subscripts) {
/* 172 */     return AREF(getRowMajorIndex(subscripts));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void set(int[] subscripts, LispObject newValue) {
/* 178 */     aset(getRowMajorIndex(subscripts), newValue);
/*     */   }
/*     */ 
/*     */   
/*     */   public abstract void fill(LispObject paramLispObject);
/*     */   
/*     */   public String printObject(int[] dimv) {
/* 185 */     StringBuilder sb = new StringBuilder();
/* 186 */     LispThread thread = LispThread.currentThread();
/* 187 */     LispObject printReadably = Symbol.PRINT_READABLY.symbolValue(thread);
/* 188 */     if (printReadably != Lisp.NIL || Symbol.PRINT_ARRAY.symbolValue(thread) != Lisp.NIL) {
/* 189 */       int maxLevel = Integer.MAX_VALUE;
/* 190 */       if (printReadably != Lisp.NIL) {
/* 191 */         for (int j = 0; j < dimv.length - 1; j++) {
/* 192 */           if (dimv[j] == 0) {
/* 193 */             for (int k = j + 1; k < dimv.length; k++) {
/* 194 */               if (dimv[k] != 0) {
/* 195 */                 Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */                 
/* 197 */                 return null;
/*     */               } 
/*     */             } 
/*     */           }
/*     */         } 
/*     */       } else {
/* 203 */         LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 204 */         if (printLevel instanceof Fixnum) {
/* 205 */           maxLevel = ((Fixnum)printLevel).value;
/*     */         }
/*     */       } 
/* 208 */       LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 209 */       int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 210 */       if (currentLevel >= maxLevel)
/* 211 */         return "#"; 
/* 212 */       sb.append('#');
/* 213 */       sb.append(dimv.length);
/* 214 */       sb.append('A');
/* 215 */       appendContents(dimv, 0, sb, thread);
/* 216 */       return sb.toString();
/*     */     } 
/* 218 */     sb.append('(');
/* 219 */     if (this instanceof SimpleArray_T)
/* 220 */       sb.append("SIMPLE-"); 
/* 221 */     sb.append("ARRAY " + getElementType().printObject() + " (");
/* 222 */     for (int i = 0; i < dimv.length; i++) {
/* 223 */       sb.append(dimv[i]);
/* 224 */       if (i < dimv.length - 1)
/* 225 */         sb.append(' '); 
/*     */     } 
/* 227 */     sb.append("))");
/* 228 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private void appendContents(int[] dimensions, int index, StringBuilder sb, LispThread thread) {
/* 236 */     if (dimensions.length == 0) {
/* 237 */       if (Symbol.PRINT_CIRCLE.symbolValue(thread) != Lisp.NIL) {
/* 238 */         StringOutputStream stream = new StringOutputStream();
/* 239 */         thread.execute(Symbol.OUTPUT_OBJECT.getSymbolFunction(), 
/* 240 */             AREF(index), stream);
/* 241 */         sb.append(stream.getString().getStringValue());
/*     */       } else {
/* 243 */         sb.append(AREF(index).printObject());
/*     */       } 
/*     */     } else {
/* 246 */       LispObject printReadably = Symbol.PRINT_READABLY.symbolValue(thread);
/* 247 */       int maxLength = Integer.MAX_VALUE;
/* 248 */       int maxLevel = Integer.MAX_VALUE;
/* 249 */       if (printReadably == Lisp.NIL) {
/*     */         
/* 251 */         LispObject printLength = Symbol.PRINT_LENGTH.symbolValue(thread);
/* 252 */         if (printLength instanceof Fixnum) {
/* 253 */           maxLength = ((Fixnum)printLength).value;
/*     */         }
/* 255 */         LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 256 */         if (printLevel instanceof Fixnum) {
/* 257 */           maxLevel = ((Fixnum)printLevel).value;
/*     */         }
/*     */       } 
/* 260 */       LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 261 */       int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 262 */       if (currentLevel < maxLevel) {
/* 263 */         SpecialBindingsMark mark = thread.markSpecialBindings();
/* 264 */         thread.bindSpecial(Lisp._CURRENT_PRINT_LEVEL_, currentPrintLevel.incr());
/*     */         try {
/* 266 */           sb.append('(');
/* 267 */           int[] dims = new int[dimensions.length - 1];
/* 268 */           for (int i = 1; i < dimensions.length; i++)
/* 269 */             dims[i - 1] = dimensions[i]; 
/* 270 */           int count = 1;
/* 271 */           for (int j = 0; j < dims.length; j++)
/* 272 */             count *= dims[j]; 
/* 273 */           int length = dimensions[0];
/* 274 */           int limit = Math.min(length, maxLength);
/* 275 */           for (int k = 0; k < limit; k++) {
/* 276 */             appendContents(dims, index, sb, thread);
/* 277 */             if (k < limit - 1 || limit < length)
/* 278 */               sb.append(' '); 
/* 279 */             index += count;
/*     */           } 
/* 281 */           if (limit < length)
/* 282 */             sb.append("..."); 
/* 283 */           sb.append(')');
/*     */         } finally {
/*     */           
/* 286 */           thread.resetSpecialBindings(mark);
/*     */         } 
/*     */       } else {
/* 289 */         sb.append('#');
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 297 */     long result = 128387L;
/* 298 */     int rank = getRank();
/* 299 */     int limit = (rank < 4) ? rank : 4;
/* 300 */     for (int i = 0; i < limit; i++)
/* 301 */       result = Lisp.mix(result, getDimension(i)); 
/* 302 */     int length = getTotalSize();
/* 303 */     limit = (length < 4) ? length : 4;
/* 304 */     for (int j = 0; j < length; j++)
/* 305 */       result = Lisp.mix(result, AREF(j).psxhash()); 
/* 306 */     return (int)(result & 0x7FFFFFFFL);
/*     */   }
/*     */   
/*     */   public abstract AbstractArray adjustArray(int[] paramArrayOfint, LispObject paramLispObject1, LispObject paramLispObject2);
/*     */   
/*     */   public abstract AbstractArray adjustArray(int[] paramArrayOfint, AbstractArray paramAbstractArray, int paramInt);
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AbstractArray.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */