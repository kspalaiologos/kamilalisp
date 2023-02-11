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
/*     */ public final class SimpleString
/*     */   extends AbstractString
/*     */ {
/*     */   private int capacity;
/*     */   private char[] chars;
/*     */   
/*     */   public SimpleString(LispCharacter c) {
/*  45 */     this.chars = new char[1];
/*  46 */     this.chars[0] = c.value;
/*  47 */     this.capacity = 1;
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(char c) {
/*  52 */     this.chars = new char[1];
/*  53 */     this.chars[0] = c;
/*  54 */     this.capacity = 1;
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(int capacity) {
/*  59 */     this.capacity = capacity;
/*  60 */     this.chars = new char[capacity];
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(String s) {
/*  65 */     this.capacity = s.length();
/*  66 */     this.chars = s.toCharArray();
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(StringBuffer sb) {
/*  71 */     this.chars = new char[this.capacity = sb.length()];
/*  72 */     sb.getChars(0, this.capacity, this.chars, 0);
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(StringBuilder sb) {
/*  77 */     this.chars = sb.toString().toCharArray();
/*  78 */     this.capacity = this.chars.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleString(char[] chars) {
/*  83 */     this.chars = chars;
/*  84 */     this.capacity = chars.length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] chars() {
/*  90 */     return this.chars;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] getStringChars() {
/*  96 */     return this.chars;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 102 */     return Lisp.list(Symbol.SIMPLE_BASE_STRING, new LispObject[] { Fixnum.getInstance(this.capacity) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 108 */     return BuiltInClass.SIMPLE_BASE_STRING;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/* 114 */     StringBuilder sb = new StringBuilder("A simple-string (");
/* 115 */     sb.append(this.capacity);
/* 116 */     sb.append(") \"");
/* 117 */     sb.append(this.chars);
/* 118 */     sb.append('"');
/* 119 */     return new SimpleString(sb);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 125 */     if (type == Symbol.SIMPLE_STRING)
/* 126 */       return Lisp.T; 
/* 127 */     if (type == Symbol.SIMPLE_ARRAY)
/* 128 */       return Lisp.T; 
/* 129 */     if (type == Symbol.SIMPLE_BASE_STRING)
/* 130 */       return Lisp.T; 
/* 131 */     if (type == BuiltInClass.SIMPLE_STRING)
/* 132 */       return Lisp.T; 
/* 133 */     if (type == BuiltInClass.SIMPLE_ARRAY)
/* 134 */       return Lisp.T; 
/* 135 */     if (type == BuiltInClass.SIMPLE_BASE_STRING)
/* 136 */       return Lisp.T; 
/* 137 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SIMPLE_STRING_P() {
/* 143 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/* 149 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isAdjustable() {
/* 155 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 161 */     if (this == obj)
/* 162 */       return true; 
/* 163 */     if (obj instanceof SimpleString) {
/* 164 */       SimpleString string = (SimpleString)obj;
/* 165 */       if (string.capacity != this.capacity)
/* 166 */         return false; 
/* 167 */       for (int i = this.capacity; i-- > 0;) {
/* 168 */         if (string.chars[i] != this.chars[i])
/* 169 */           return false; 
/* 170 */       }  return true;
/*     */     } 
/* 172 */     if (obj instanceof AbstractString) {
/* 173 */       AbstractString string = (AbstractString)obj;
/* 174 */       if (string.length() != this.capacity)
/* 175 */         return false; 
/* 176 */       for (int i = length(); i-- > 0;) {
/* 177 */         if (string.charAt(i) != this.chars[i])
/* 178 */           return false; 
/* 179 */       }  return true;
/*     */     } 
/* 181 */     if (obj instanceof NilVector)
/* 182 */       return obj.equal(this); 
/* 183 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 189 */     if (this == obj)
/* 190 */       return true; 
/* 191 */     if (obj instanceof SimpleString) {
/* 192 */       SimpleString string = (SimpleString)obj;
/* 193 */       if (string.capacity != this.capacity)
/* 194 */         return false; 
/* 195 */       for (int i = this.capacity; i-- > 0;) {
/* 196 */         if (string.chars[i] != this.chars[i] && 
/* 197 */           LispCharacter.toLowerCase(string.chars[i]) != LispCharacter.toLowerCase(this.chars[i])) {
/* 198 */           return false;
/*     */         }
/*     */       } 
/* 201 */       return true;
/*     */     } 
/* 203 */     if (obj instanceof AbstractString) {
/* 204 */       AbstractString string = (AbstractString)obj;
/* 205 */       if (string.length() != this.capacity)
/* 206 */         return false; 
/* 207 */       for (int i = length(); i-- > 0;) {
/* 208 */         if (string.charAt(i) != this.chars[i] && 
/* 209 */           LispCharacter.toLowerCase(string.charAt(i)) != LispCharacter.toLowerCase(this.chars[i])) {
/* 210 */           return false;
/*     */         }
/*     */       } 
/* 213 */       return true;
/*     */     } 
/* 215 */     if (obj instanceof AbstractBitVector)
/* 216 */       return false; 
/* 217 */     if (obj instanceof AbstractArray)
/* 218 */       return obj.equalp(this); 
/* 219 */     return false;
/*     */   }
/*     */ 
/*     */   
/*     */   public final SimpleString substring(int start) {
/* 224 */     return substring(start, this.capacity);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final SimpleString substring(int start, int end) {
/* 230 */     SimpleString s = new SimpleString(end - start);
/* 231 */     int i = start, j = 0;
/*     */     try {
/* 233 */       while (i < end)
/* 234 */         s.chars[j++] = this.chars[i++]; 
/* 235 */       return s;
/*     */     }
/* 237 */     catch (ArrayIndexOutOfBoundsException e) {
/* 238 */       Lisp.error(new TypeError("Array index out of bounds: " + i));
/*     */       
/* 240 */       return null;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject subseq(int start, int end) {
/* 247 */     return substring(start, end);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 253 */     fill(LispCharacter.getValue(obj));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(char c) {
/* 259 */     for (int i = this.capacity; i-- > 0;) {
/* 260 */       this.chars[i] = c;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 266 */     if (n < this.capacity) {
/* 267 */       char[] newArray = new char[n];
/* 268 */       System.arraycopy(this.chars, 0, newArray, 0, n);
/* 269 */       this.chars = newArray;
/* 270 */       this.capacity = n;
/*     */       return;
/*     */     } 
/* 273 */     if (n == this.capacity)
/*     */       return; 
/* 275 */     Lisp.error(new LispError());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 281 */     SimpleString result = new SimpleString(this.capacity);
/*     */     
/* 283 */     for (int i = 0, j = this.capacity - 1; i < this.capacity; i++, j--)
/* 284 */       result.chars[i] = this.chars[j]; 
/* 285 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 291 */     int i = 0;
/* 292 */     int j = this.capacity - 1;
/* 293 */     while (i < j) {
/* 294 */       char temp = this.chars[i];
/* 295 */       this.chars[i] = this.chars[j];
/* 296 */       this.chars[j] = temp;
/* 297 */       i++;
/* 298 */       j--;
/*     */     } 
/* 300 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getStringValue() {
/* 306 */     return String.valueOf(this.chars);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/* 312 */     return String.valueOf(this.chars);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class c) {
/* 318 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int capacity() {
/* 324 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int length() {
/* 330 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char charAt(int index) {
/*     */     try {
/* 337 */       return this.chars[index];
/*     */     }
/* 339 */     catch (ArrayIndexOutOfBoundsException e) {
/* 340 */       badIndex(index, this.capacity);
/* 341 */       return Character.MIN_VALUE;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCharAt(int index, char c) {
/*     */     try {
/* 349 */       this.chars[index] = c;
/*     */     }
/* 351 */     catch (ArrayIndexOutOfBoundsException e) {
/* 352 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/*     */     try {
/* 360 */       return LispCharacter.getInstance(this.chars[index]);
/*     */     }
/* 362 */     catch (ArrayIndexOutOfBoundsException e) {
/* 363 */       badIndex(index, this.capacity);
/* 364 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject CHAR(int index) {
/*     */     try {
/* 372 */       return LispCharacter.getInstance(this.chars[index]);
/*     */     }
/* 374 */     catch (ArrayIndexOutOfBoundsException e) {
/* 375 */       badIndex(index, this.capacity);
/* 376 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SCHAR(int index) {
/*     */     try {
/* 384 */       return LispCharacter.getInstance(this.chars[index]);
/*     */     }
/* 386 */     catch (ArrayIndexOutOfBoundsException e) {
/* 387 */       badIndex(index, this.capacity);
/* 388 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/*     */     try {
/* 396 */       return LispCharacter.getInstance(this.chars[index]);
/*     */     }
/* 398 */     catch (ArrayIndexOutOfBoundsException e) {
/* 399 */       badIndex(index, this.capacity);
/* 400 */       return Lisp.NIL;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/*     */     try {
/* 409 */       this.chars[index] = LispCharacter.getValue(obj);
/*     */     }
/* 411 */     catch (ArrayIndexOutOfBoundsException e) {
/* 412 */       badIndex(index, this.capacity);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int sxhash() {
/* 419 */     if (this.capacity == 0) return 0; 
/* 420 */     int hashCode = Lisp.randomStringHashBase;
/* 421 */     for (int i = 0; i < this.capacity; i++) {
/* 422 */       hashCode += this.chars[i];
/* 423 */       hashCode += hashCode << 10;
/* 424 */       hashCode ^= hashCode >> 6;
/*     */     } 
/* 426 */     hashCode += hashCode << 3;
/* 427 */     hashCode ^= hashCode >> 11;
/* 428 */     hashCode += hashCode << 15;
/* 429 */     return hashCode & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 436 */     if (this.capacity == 0) return 0; 
/* 437 */     int hashCode = Lisp.randomStringHashBase;
/* 438 */     for (int i = 0; i < this.capacity; i++) {
/* 439 */       hashCode += Character.toUpperCase(this.chars[i]);
/* 440 */       hashCode += hashCode << 10;
/* 441 */       hashCode ^= hashCode >> 6;
/*     */     } 
/* 443 */     hashCode += hashCode << 3;
/* 444 */     hashCode ^= hashCode >> 11;
/* 445 */     hashCode += hashCode << 15;
/* 446 */     return hashCode & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 455 */     if (initialContents != null) {
/* 456 */       char[] newChars = new char[newCapacity];
/* 457 */       if (initialContents.listp()) {
/* 458 */         LispObject list = initialContents;
/* 459 */         for (int i = 0; i < newCapacity; i++) {
/* 460 */           newChars[i] = LispCharacter.getValue(list.car());
/* 461 */           list = list.cdr();
/*     */         } 
/* 463 */       } else if (initialContents.vectorp()) {
/* 464 */         for (int i = 0; i < newCapacity; i++)
/* 465 */           newChars[i] = LispCharacter.getValue(initialContents.elt(i)); 
/*     */       } else {
/* 467 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 468 */       }  return new SimpleString(newChars);
/*     */     } 
/* 470 */     if (this.capacity != newCapacity) {
/* 471 */       char[] newChars = new char[newCapacity];
/* 472 */       System.arraycopy(this.chars, 0, newChars, 0, Math.min(newCapacity, this.capacity));
/* 473 */       if (initialElement != null && this.capacity < newCapacity) {
/* 474 */         char c = LispCharacter.getValue(initialElement);
/* 475 */         for (int i = this.capacity; i < newCapacity; i++)
/* 476 */           newChars[i] = c; 
/*     */       } 
/* 478 */       return new SimpleString(newChars);
/*     */     } 
/*     */     
/* 481 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 490 */     return new ComplexString(newCapacity, displacedTo, displacement);
/*     */   }
/*     */ 
/*     */   
/*     */   public String toString() {
/* 495 */     return String.valueOf(this.chars);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleString.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */