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
/*     */ public abstract class AbstractBitVector
/*     */   extends AbstractVector
/*     */ {
/*     */   protected static final int LONG_MASK = 63;
/*     */   protected int capacity;
/*     */   protected long[] bits;
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  50 */     if (type == Symbol.BIT_VECTOR)
/*  51 */       return Lisp.T; 
/*  52 */     if (type == BuiltInClass.BIT_VECTOR)
/*  53 */       return Lisp.T; 
/*  54 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  60 */     return BuiltInClass.BIT_VECTOR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int capacity() {
/*  66 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getElementType() {
/*  72 */     return Symbol.BIT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/*  78 */     if (this == obj)
/*  79 */       return true; 
/*  80 */     if (obj instanceof AbstractBitVector) {
/*  81 */       AbstractBitVector v = (AbstractBitVector)obj;
/*  82 */       if (length() != v.length())
/*  83 */         return false; 
/*  84 */       for (int i = length(); i-- > 0;) {
/*  85 */         if (getBit(i) != v.getBit(i))
/*  86 */           return false; 
/*     */       } 
/*  88 */       return true;
/*     */     } 
/*  90 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/*  96 */     if (this == obj)
/*  97 */       return true; 
/*  98 */     if (obj instanceof AbstractBitVector) {
/*  99 */       AbstractBitVector v = (AbstractBitVector)obj;
/* 100 */       if (length() != v.length())
/* 101 */         return false; 
/* 102 */       for (int i = length(); i-- > 0;) {
/* 103 */         if (getBit(i) != v.getBit(i))
/* 104 */           return false; 
/*     */       } 
/* 106 */       return true;
/*     */     } 
/* 108 */     if (obj instanceof AbstractString)
/* 109 */       return false; 
/* 110 */     if (obj instanceof AbstractVector)
/* 111 */       return ((AbstractVector)obj).equalp(this); 
/* 112 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 118 */     if (obj instanceof Fixnum) {
/* 119 */       switch (((Fixnum)obj).value) {
/*     */         case 0:
/* 121 */           if (this.bits != null) {
/* 122 */             for (int i = this.bits.length; i-- > 0;)
/* 123 */               this.bits[i] = 0L; 
/*     */           } else {
/* 125 */             for (int i = this.capacity; i-- > 0;)
/* 126 */               clearBit(i); 
/*     */           } 
/*     */           return;
/*     */         case 1:
/* 130 */           if (this.bits != null) {
/* 131 */             for (int i = this.bits.length; i-- > 0;)
/* 132 */               this.bits[i] = -1L; 
/*     */           } else {
/* 134 */             for (int i = this.capacity; i-- > 0;) {
/* 135 */               setBit(i);
/*     */             }
/*     */           } 
/*     */           return;
/*     */       } 
/*     */     }
/* 141 */     Lisp.type_error(obj, Symbol.BIT);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 147 */     SimpleBitVector v = new SimpleBitVector(end - start);
/* 148 */     int i = start, j = 0;
/*     */     try {
/* 150 */       while (i < end) {
/* 151 */         if (getBit(i++) == 0) {
/* 152 */           v.clearBit(j++); continue;
/*     */         } 
/* 154 */         v.setBit(j++);
/*     */       } 
/* 156 */       return v;
/*     */     }
/* 158 */     catch (ArrayIndexOutOfBoundsException e) {
/* 159 */       return Lisp.error(new TypeError("Array index out of bounds: " + i + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 166 */     int hashCode = 1;
/*     */     
/* 168 */     int limit = Math.min(length(), 64);
/* 169 */     for (int i = 0; i < limit; i++)
/* 170 */       hashCode = hashCode * 31 + getBit(i); 
/* 171 */     return hashCode;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 177 */     LispThread thread = LispThread.currentThread();
/* 178 */     int length = length();
/* 179 */     if (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL || Symbol.PRINT_ARRAY
/* 180 */       .symbolValue(thread) != Lisp.NIL) {
/*     */       
/* 182 */       StringBuilder sb = new StringBuilder(length + 2);
/* 183 */       sb.append("#*");
/* 184 */       for (int i = 0; i < length; i++)
/* 185 */         sb.append((getBit(i) == 1) ? 49 : 48); 
/* 186 */       return sb.toString();
/*     */     } 
/* 188 */     String str = "(%sBIT-VECTOR %d)";
/* 189 */     String pre = (this instanceof SimpleBitVector) ? "SIMPLE-" : "";
/* 190 */     return unreadableString(String.format("(%sBIT-VECTOR %d)", new Object[] { pre, Integer.valueOf(length) }));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 197 */     int length = length();
/* 198 */     SimpleBitVector result = new SimpleBitVector(length);
/*     */     
/* 200 */     for (int i = 0, j = length - 1; i < length; i++, j--) {
/* 201 */       if (getBit(j) == 1) {
/* 202 */         result.setBit(i);
/*     */       } else {
/* 204 */         result.clearBit(i);
/*     */       } 
/* 206 */     }  return result;
/*     */   }
/*     */   
/*     */   protected abstract int getBit(int paramInt);
/*     */   
/*     */   protected abstract void setBit(int paramInt);
/*     */   
/*     */   protected abstract void clearBit(int paramInt);
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/AbstractBitVector.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */