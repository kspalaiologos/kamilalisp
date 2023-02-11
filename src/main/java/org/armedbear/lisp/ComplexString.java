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
/*     */ public final class ComplexString
/*     */   extends AbstractString
/*     */ {
/*     */   private int capacity;
/*  41 */   private int fillPointer = -1;
/*     */   
/*     */   private boolean isDisplaced;
/*     */   
/*     */   private char[] chars;
/*     */   
/*     */   private AbstractArray array;
/*     */   
/*     */   private int displacement;
/*     */ 
/*     */   
/*     */   public ComplexString(int capacity) {
/*  53 */     this.capacity = capacity;
/*  54 */     this.chars = new char[capacity];
/*  55 */     this.isDisplaced = false;
/*     */   }
/*     */ 
/*     */   
/*     */   public ComplexString(int capacity, AbstractArray array, int displacement) {
/*  60 */     this.capacity = capacity;
/*  61 */     this.array = array;
/*  62 */     this.displacement = displacement;
/*  63 */     this.isDisplaced = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  69 */     return Lisp.list(Symbol.STRING, new LispObject[] { Lisp.number(capacity()) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  75 */     return BuiltInClass.STRING;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean hasFillPointer() {
/*  81 */     return (this.fillPointer >= 0);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFillPointer() {
/*  87 */     return this.fillPointer;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(int n) {
/*  93 */     this.fillPointer = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setFillPointer(LispObject obj) {
/*  99 */     if (obj == Lisp.T) {
/* 100 */       this.fillPointer = capacity();
/*     */     } else {
/*     */       
/* 103 */       int n = Fixnum.getValue(obj);
/* 104 */       if (n > capacity()) {
/*     */         
/* 106 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 107 */         sb.append(n);
/* 108 */         sb.append(") exceeds the capacity of the vector (");
/* 109 */         sb.append(capacity());
/* 110 */         sb.append(").");
/* 111 */         Lisp.error(new LispError(sb.toString()));
/*     */       }
/* 113 */       else if (n < 0) {
/*     */         
/* 115 */         StringBuffer sb = new StringBuffer("The new fill pointer (");
/* 116 */         sb.append(n);
/* 117 */         sb.append(") is negative.");
/* 118 */         Lisp.error(new LispError(sb.toString()));
/*     */       } else {
/*     */         
/* 121 */         this.fillPointer = n;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isDisplaced() {
/* 128 */     return this.isDisplaced;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject arrayDisplacement() {
/*     */     LispObject value1;
/*     */     LispObject value2;
/* 135 */     if (this.array != null) {
/*     */       
/* 137 */       value1 = this.array;
/* 138 */       value2 = Fixnum.getInstance(this.displacement);
/*     */     }
/*     */     else {
/*     */       
/* 142 */       value1 = Lisp.NIL;
/* 143 */       value2 = Fixnum.ZERO;
/*     */     } 
/* 145 */     return LispThread.currentThread().setValues(value1, value2);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] chars() {
/* 151 */     if (this.chars != null)
/* 152 */       return this.chars; 
/* 153 */     Debug.assertTrue((this.array != null));
/* 154 */     char[] copy = new char[this.capacity];
/* 155 */     if (this.array instanceof AbstractString) {
/* 156 */       System.arraycopy(this.array.chars(), this.displacement, copy, 0, this.capacity);
/* 157 */     } else if (this.array.getElementType() == Symbol.CHARACTER) {
/*     */       
/* 159 */       for (int i = 0; i < this.capacity; i++) {
/*     */         
/* 161 */         LispObject obj = this.array.AREF(this.displacement + i);
/* 162 */         copy[i] = LispCharacter.getValue(obj);
/*     */       } 
/*     */     } else {
/*     */       
/* 166 */       Lisp.type_error(this.array, Symbol.STRING);
/* 167 */     }  return copy;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char[] getStringChars() {
/* 173 */     if (this.fillPointer < 0)
/* 174 */       return chars(); 
/* 175 */     char[] ret = new char[this.fillPointer];
/* 176 */     System.arraycopy(chars(), 0, ret, 0, this.fillPointer);
/* 177 */     return ret;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equal(LispObject obj) {
/* 183 */     if (this == obj)
/* 184 */       return true; 
/* 185 */     if (obj instanceof AbstractString) {
/*     */       
/* 187 */       AbstractString string = (AbstractString)obj;
/* 188 */       if (string.length() != length())
/* 189 */         return false; 
/* 190 */       for (int i = length(); i-- > 0;) {
/* 191 */         if (string.charAt(i) != charAt(i))
/* 192 */           return false; 
/* 193 */       }  return true;
/*     */     } 
/* 195 */     if (obj instanceof NilVector)
/* 196 */       return obj.equal(this); 
/* 197 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 203 */     if (this == obj)
/* 204 */       return true; 
/* 205 */     if (obj instanceof AbstractString) {
/*     */       
/* 207 */       AbstractString string = (AbstractString)obj;
/* 208 */       if (string.length() != length())
/* 209 */         return false; 
/* 210 */       for (int i = length(); i-- > 0;) {
/*     */         
/* 212 */         if (string.charAt(i) != charAt(i))
/*     */         {
/* 214 */           if (LispCharacter.toLowerCase(string.charAt(i)) != LispCharacter.toLowerCase(charAt(i)))
/* 215 */             return false; 
/*     */         }
/*     */       } 
/* 218 */       return true;
/*     */     } 
/* 220 */     if (obj instanceof AbstractBitVector)
/* 221 */       return false; 
/* 222 */     if (obj instanceof AbstractArray)
/* 223 */       return obj.equalp(this); 
/* 224 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject subseq(int start, int end) {
/* 230 */     SimpleString s = new SimpleString(end - start);
/* 231 */     int i = start, j = 0;
/* 232 */     while (i < end)
/* 233 */       s.setCharAt(j++, charAt(i++)); 
/* 234 */     return s;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 240 */     fill(LispCharacter.getValue(obj));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void fill(char c) {
/* 246 */     for (int i = length(); i-- > 0;) {
/* 247 */       setCharAt(i, c);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void shrink(int n) {
/* 253 */     if (this.chars != null) {
/*     */       
/* 255 */       if (n < this.capacity) {
/*     */         
/* 257 */         char[] newArray = new char[n];
/* 258 */         System.arraycopy(this.chars, 0, newArray, 0, n);
/* 259 */         this.chars = newArray;
/* 260 */         this.capacity = n;
/* 261 */         this.fillPointer = -1;
/*     */         return;
/*     */       } 
/* 264 */       if (n == this.capacity)
/*     */         return; 
/*     */     } 
/* 267 */     Debug.assertTrue((this.chars == null));
/*     */     
/* 269 */     this.chars = new char[n];
/* 270 */     if (this.array instanceof AbstractString) {
/*     */       
/* 272 */       AbstractString string = (AbstractString)this.array;
/* 273 */       for (int i = 0; i < n; i++)
/*     */       {
/* 275 */         this.chars[i] = string.charAt(this.displacement + i);
/*     */       }
/*     */     }
/*     */     else {
/*     */       
/* 280 */       for (int i = 0; i < n; i++) {
/*     */ 
/*     */         
/* 283 */         LispCharacter character = (LispCharacter)this.array.AREF(this.displacement + i);
/* 284 */         this.chars[i] = character.value;
/*     */       } 
/*     */     } 
/* 287 */     this.capacity = n;
/* 288 */     this.array = null;
/* 289 */     this.displacement = 0;
/* 290 */     this.isDisplaced = false;
/* 291 */     this.fillPointer = -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 297 */     int length = length();
/* 298 */     SimpleString result = new SimpleString(length);
/*     */     
/* 300 */     for (int i = 0, j = length - 1; i < length; i++, j--)
/* 301 */       result.setCharAt(i, charAt(j)); 
/* 302 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 308 */     int i = 0;
/* 309 */     int j = length() - 1;
/* 310 */     while (i < j) {
/*     */       
/* 312 */       char temp = charAt(i);
/* 313 */       setCharAt(i, charAt(j));
/* 314 */       setCharAt(j, temp);
/* 315 */       i++;
/* 316 */       j--;
/*     */     } 
/* 318 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getStringValue() {
/* 324 */     if (this.fillPointer >= 0) {
/* 325 */       return new String(chars(), 0, this.fillPointer);
/*     */     }
/* 327 */     return new String(chars());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/* 333 */     return new String(getStringValue());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class c) {
/* 339 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int capacity() {
/* 345 */     return this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int length() {
/* 351 */     return (this.fillPointer >= 0) ? this.fillPointer : this.capacity;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public char charAt(int index) {
/* 357 */     if (this.chars != null) {
/*     */       
/*     */       try {
/*     */         
/* 361 */         return this.chars[index];
/*     */       }
/* 363 */       catch (ArrayIndexOutOfBoundsException e) {
/*     */         
/* 365 */         badIndex(index, this.capacity);
/* 366 */         return Character.MIN_VALUE;
/*     */       } 
/*     */     }
/*     */     
/* 370 */     return LispCharacter.getValue(this.array.AREF(index + this.displacement));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCharAt(int index, char c) {
/* 376 */     if (this.chars != null) {
/*     */ 
/*     */       
/*     */       try {
/* 380 */         this.chars[index] = c;
/*     */       }
/* 382 */       catch (ArrayIndexOutOfBoundsException e) {
/*     */         
/* 384 */         badIndex(index, this.capacity);
/*     */       } 
/*     */     } else {
/*     */       
/* 388 */       this.array.aset(index + this.displacement, LispCharacter.getInstance(c));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 394 */     int limit = length();
/* 395 */     if (index < 0 || index >= limit)
/* 396 */       badIndex(index, limit); 
/* 397 */     return LispCharacter.getInstance(charAt(index));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject CHAR(int index) {
/* 404 */     return LispCharacter.getInstance(charAt(index));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 411 */     return LispCharacter.getInstance(charAt(index));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject newValue) {
/* 417 */     setCharAt(index, LispCharacter.getValue(newValue));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void vectorPushExtend(LispObject element) {
/* 424 */     if (this.fillPointer < 0)
/* 425 */       noFillPointer(); 
/* 426 */     if (this.fillPointer >= this.capacity)
/*     */     {
/*     */       
/* 429 */       ensureCapacity(this.capacity * 2 + 1);
/*     */     }
/* 431 */     if (this.chars != null) {
/*     */       
/* 433 */       this.chars[this.fillPointer] = LispCharacter.getValue(element);
/*     */     } else {
/*     */       
/* 436 */       this.array.aset(this.fillPointer + this.displacement, element);
/* 437 */     }  this.fillPointer++;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/* 444 */     vectorPushExtend(element);
/* 445 */     return Fixnum.getInstance(this.fillPointer - 1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/* 452 */     int ext = Fixnum.getValue(extension);
/* 453 */     if (this.fillPointer < 0)
/* 454 */       noFillPointer(); 
/* 455 */     if (this.fillPointer >= this.capacity) {
/*     */ 
/*     */       
/* 458 */       ext = Math.max(ext, this.capacity + 1);
/* 459 */       ensureCapacity(this.capacity + ext);
/*     */     } 
/* 461 */     if (this.chars != null) {
/*     */       
/* 463 */       this.chars[this.fillPointer] = LispCharacter.getValue(element);
/*     */     } else {
/*     */       
/* 466 */       this.array.aset(this.fillPointer + this.displacement, element);
/* 467 */     }  return Fixnum.getInstance(this.fillPointer++);
/*     */   }
/*     */ 
/*     */   
/*     */   public final void ensureCapacity(int minCapacity) {
/* 472 */     if (this.chars != null) {
/*     */       
/* 474 */       if (this.capacity < minCapacity)
/*     */       {
/* 476 */         char[] newArray = new char[minCapacity];
/* 477 */         System.arraycopy(this.chars, 0, newArray, 0, this.capacity);
/* 478 */         this.chars = newArray;
/* 479 */         this.capacity = minCapacity;
/*     */       }
/*     */     
/*     */     } else {
/*     */       
/* 484 */       Debug.assertTrue((this.array != null));
/* 485 */       if (this.capacity < minCapacity || this.array
/* 486 */         .getTotalSize() - this.displacement < minCapacity) {
/*     */ 
/*     */         
/* 489 */         this.chars = new char[minCapacity];
/*     */         
/* 491 */         int limit = Math.min(this.capacity, this.array.getTotalSize() - this.displacement);
/* 492 */         if (this.array instanceof AbstractString) {
/*     */           
/* 494 */           AbstractString string = (AbstractString)this.array;
/* 495 */           for (int i = 0; i < limit; i++)
/*     */           {
/* 497 */             this.chars[i] = string.charAt(this.displacement + i);
/*     */           }
/*     */         }
/*     */         else {
/*     */           
/* 502 */           for (int i = 0; i < limit; i++) {
/*     */ 
/*     */             
/* 505 */             LispCharacter character = (LispCharacter)this.array.AREF(this.displacement + i);
/* 506 */             this.chars[i] = character.value;
/*     */           } 
/*     */         } 
/* 509 */         this.capacity = minCapacity;
/* 510 */         this.array = null;
/* 511 */         this.displacement = 0;
/* 512 */         this.isDisplaced = false;
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int sxhash() {
/* 520 */     int hashCode = Lisp.randomStringHashBase;
/* 521 */     int limit = length();
/* 522 */     for (int i = 0; i < limit; i++) {
/*     */       
/* 524 */       hashCode += charAt(i);
/* 525 */       hashCode += hashCode << 10;
/* 526 */       hashCode ^= hashCode >> 6;
/*     */     } 
/* 528 */     hashCode += hashCode << 3;
/* 529 */     hashCode ^= hashCode >> 11;
/* 530 */     hashCode += hashCode << 15;
/* 531 */     return hashCode & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int psxhash() {
/* 538 */     int hashCode = Lisp.randomStringHashBase;
/* 539 */     int limit = length();
/* 540 */     for (int i = 0; i < limit; i++) {
/*     */       
/* 542 */       hashCode += Character.toUpperCase(charAt(i));
/* 543 */       hashCode += hashCode << 10;
/* 544 */       hashCode ^= hashCode >> 6;
/*     */     } 
/* 546 */     hashCode += hashCode << 3;
/* 547 */     hashCode ^= hashCode >> 11;
/* 548 */     hashCode += hashCode << 15;
/* 549 */     return hashCode & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, LispObject initialElement, LispObject initialContents) {
/* 558 */     if (initialContents != null) {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 563 */       char[] newChars = new char[newCapacity];
/* 564 */       if (initialContents.listp()) {
/*     */         
/* 566 */         LispObject list = initialContents;
/* 567 */         for (int i = 0; i < newCapacity; i++)
/*     */         {
/* 569 */           newChars[i] = LispCharacter.getValue(list.car());
/* 570 */           list = list.cdr();
/*     */         }
/*     */       
/* 573 */       } else if (initialContents.vectorp()) {
/*     */         
/* 575 */         for (int i = 0; i < newCapacity; i++) {
/* 576 */           newChars[i] = LispCharacter.getValue(initialContents.elt(i));
/*     */         }
/*     */       } else {
/* 579 */         Lisp.type_error(initialContents, Symbol.SEQUENCE);
/* 580 */       }  this.chars = newChars;
/*     */     }
/*     */     else {
/*     */       
/* 584 */       if (this.chars == null) {
/*     */ 
/*     */         
/* 587 */         this.chars = new char[newCapacity];
/* 588 */         int limit = Math.min(this.capacity, newCapacity);
/* 589 */         if (this.array instanceof AbstractString) {
/*     */           
/* 591 */           AbstractString string = (AbstractString)this.array;
/* 592 */           for (int i = 0; i < limit; i++)
/*     */           {
/* 594 */             this.chars[i] = string.charAt(this.displacement + i);
/*     */           }
/*     */         }
/*     */         else {
/*     */           
/* 599 */           for (int i = 0; i < limit; i++)
/*     */           {
/*     */             
/* 602 */             LispCharacter character = (LispCharacter)this.array.AREF(this.displacement + i);
/* 603 */             this.chars[i] = character.value;
/*     */           }
/*     */         
/*     */         } 
/* 607 */       } else if (this.capacity != newCapacity) {
/*     */         
/* 609 */         char[] newElements = new char[newCapacity];
/* 610 */         System.arraycopy(this.chars, 0, newElements, 0, 
/* 611 */             Math.min(this.capacity, newCapacity));
/* 612 */         this.chars = newElements;
/*     */       } 
/* 614 */       if (initialElement != null && this.capacity < newCapacity) {
/*     */ 
/*     */         
/* 617 */         char c = LispCharacter.getValue(initialElement);
/* 618 */         for (int i = this.capacity; i < newCapacity; i++)
/* 619 */           this.chars[i] = c; 
/*     */       } 
/*     */     } 
/* 622 */     this.capacity = newCapacity;
/* 623 */     this.array = null;
/* 624 */     this.displacement = 0;
/* 625 */     this.isDisplaced = false;
/* 626 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractVector adjustArray(int newCapacity, AbstractArray displacedTo, int displacement) {
/* 635 */     this.capacity = newCapacity;
/* 636 */     this.array = displacedTo;
/* 637 */     this.displacement = displacement;
/* 638 */     this.chars = null;
/* 639 */     this.isDisplaced = true;
/* 640 */     return this;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ComplexString.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */