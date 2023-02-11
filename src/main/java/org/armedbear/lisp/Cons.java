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
/*     */ public final class Cons
/*     */   extends LispObject
/*     */   implements Serializable
/*     */ {
/*     */   public LispObject car;
/*     */   public LispObject cdr;
/*     */   private static long count;
/*     */   
/*     */   public Cons(LispObject car, LispObject cdr) {
/*  45 */     this.car = car;
/*  46 */     this.cdr = cdr;
/*  47 */     count++;
/*     */   }
/*     */ 
/*     */   
/*     */   public Cons(LispObject car) {
/*  52 */     this.car = car;
/*  53 */     this.cdr = Lisp.NIL;
/*  54 */     count++;
/*     */   }
/*     */ 
/*     */   
/*     */   public Cons(String name, LispObject value) {
/*  59 */     this.car = new SimpleString(name);
/*  60 */     this.cdr = (value != null) ? value : Lisp.NULL_VALUE;
/*  61 */     count++;
/*     */   }
/*     */ 
/*     */   
/*     */   public Cons(Cons original) {
/*  66 */     Cons rest = original;
/*  67 */     LispObject result = Lisp.NIL;
/*  68 */     while (rest.car() != Lisp.NIL) {
/*  69 */       result = result.push(rest.car());
/*  70 */       if (rest.cdr() == Lisp.NIL) {
/*     */         break;
/*     */       }
/*  73 */       rest = (Cons)rest.cdr();
/*     */     } 
/*  75 */     result = result.nreverse();
/*  76 */     this.car = result.car();
/*  77 */     this.cdr = result.cdr();
/*  78 */     count++;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  84 */     return Symbol.CONS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  90 */     return BuiltInClass.CONS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  96 */     if (typeSpecifier instanceof Symbol) {
/*     */       
/*  98 */       if (typeSpecifier == Symbol.LIST)
/*  99 */         return Lisp.T; 
/* 100 */       if (typeSpecifier == Symbol.CONS)
/* 101 */         return Lisp.T; 
/* 102 */       if (typeSpecifier == Symbol.SEQUENCE)
/* 103 */         return Lisp.T; 
/* 104 */       if (typeSpecifier == Lisp.T) {
/* 105 */         return Lisp.T;
/*     */       }
/* 107 */     } else if (typeSpecifier instanceof LispClass) {
/*     */       
/* 109 */       if (typeSpecifier == BuiltInClass.LIST)
/* 110 */         return Lisp.T; 
/* 111 */       if (typeSpecifier == BuiltInClass.CONS)
/* 112 */         return Lisp.T; 
/* 113 */       if (typeSpecifier == BuiltInClass.SEQUENCE)
/* 114 */         return Lisp.T; 
/* 115 */       if (typeSpecifier == BuiltInClass.CLASS_T)
/* 116 */         return Lisp.T; 
/*     */     } 
/* 118 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean constantp() {
/* 124 */     if (this.car == Symbol.QUOTE)
/*     */     {
/* 126 */       if (this.cdr instanceof Cons && 
/* 127 */         ((Cons)this.cdr).cdr == Lisp.NIL)
/* 128 */         return true; 
/*     */     }
/* 130 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean atom() {
/* 136 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject RPLACA(LispObject obj) {
/* 142 */     this.car = obj;
/* 143 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject RPLACD(LispObject obj) {
/* 149 */     this.cdr = obj;
/* 150 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public int hashCode() {
/* 155 */     return sxhash();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int sxhash() {
/* 161 */     return computeHash(this, 4);
/*     */   }
/*     */ 
/*     */   
/*     */   private static final int computeHash(LispObject obj, int depth) {
/* 166 */     if (obj instanceof Cons) {
/*     */       
/* 168 */       if (depth > 0) {
/*     */         
/* 170 */         int n1 = computeHash(((Cons)obj).car, depth - 1);
/* 171 */         int n2 = computeHash(((Cons)obj).cdr, depth - 1);
/* 172 */         return n1 ^ n2;
/*     */       } 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 179 */       return 261835505;
/*     */     } 
/*     */ 
/*     */     
/* 183 */     return obj.sxhash();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int psxhash() {
/* 189 */     return computeEqualpHash(this, 4);
/*     */   }
/*     */ 
/*     */   
/*     */   private static final int computeEqualpHash(LispObject obj, int depth) {
/* 194 */     if (obj instanceof Cons) {
/*     */       
/* 196 */       if (depth > 0) {
/*     */         
/* 198 */         int n1 = computeEqualpHash(((Cons)obj).car, depth - 1);
/* 199 */         int n2 = computeEqualpHash(((Cons)obj).cdr, depth - 1);
/* 200 */         return n1 ^ n2;
/*     */       } 
/*     */       
/* 203 */       return 261835505;
/*     */     } 
/*     */     
/* 206 */     return obj.psxhash();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean equal(LispObject obj) {
/* 212 */     if (this == obj)
/* 213 */       return true; 
/* 214 */     if (obj instanceof Cons)
/*     */     {
/* 216 */       if (this.car.equal(((Cons)obj).car) && this.cdr.equal(((Cons)obj).cdr))
/* 217 */         return true; 
/*     */     }
/* 219 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean equalp(LispObject obj) {
/* 225 */     if (this == obj)
/* 226 */       return true; 
/* 227 */     if (obj instanceof Cons)
/*     */     {
/* 229 */       if (this.car.equalp(((Cons)obj).car) && this.cdr.equalp(((Cons)obj).cdr))
/* 230 */         return true; 
/*     */     }
/* 232 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int length() {
/* 238 */     int length = 1;
/* 239 */     LispObject obj = this.cdr;
/* 240 */     while (obj != Lisp.NIL) {
/*     */       
/* 242 */       length++;
/* 243 */       if (obj instanceof Cons) {
/* 244 */         obj = ((Cons)obj).cdr; continue;
/* 245 */       }  Lisp.type_error(obj, Symbol.LIST);
/*     */     } 
/* 247 */     return length;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NTH(int index) {
/* 253 */     if (index < 0)
/* 254 */       Lisp.type_error(Fixnum.getInstance(index), Symbol.UNSIGNED_BYTE); 
/* 255 */     int i = 0;
/* 256 */     LispObject obj = this;
/*     */     
/*     */     while (true) {
/* 259 */       if (i == index)
/* 260 */         return obj.car(); 
/* 261 */       obj = obj.cdr();
/* 262 */       if (obj == Lisp.NIL)
/* 263 */         return Lisp.NIL; 
/* 264 */       i++;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 271 */     if (index < 0)
/* 272 */       Lisp.type_error(Fixnum.getInstance(index), Symbol.UNSIGNED_BYTE); 
/* 273 */     int i = 0;
/* 274 */     Cons cons = this;
/*     */     
/*     */     while (true) {
/* 277 */       if (i == index)
/* 278 */         return cons.car; 
/* 279 */       LispObject conscdr = cons.cdr;
/* 280 */       if (conscdr instanceof Cons) {
/*     */         
/* 282 */         cons = (Cons)conscdr;
/*     */       }
/*     */       else {
/*     */         
/* 286 */         if (conscdr == Lisp.NIL) {
/*     */ 
/*     */           
/* 289 */           Lisp.type_error(Fixnum.getInstance(index), 
/* 290 */               Lisp.list(Symbol.INTEGER, new LispObject[] {
/* 291 */                   Fixnum.ZERO, Fixnum.getInstance(length() - 1)
/*     */                 }));
/*     */         }
/*     */         else {
/*     */           
/* 296 */           Lisp.type_error(conscdr, Symbol.LIST);
/*     */         } 
/*     */         
/* 299 */         return Lisp.NIL;
/*     */       } 
/* 301 */       i++;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 308 */     Cons cons = this;
/* 309 */     LispObject result = new Cons(cons.car);
/* 310 */     while (cons.cdr instanceof Cons) {
/*     */       
/* 312 */       cons = (Cons)cons.cdr;
/* 313 */       result = new Cons(cons.car, result);
/*     */     } 
/* 315 */     if (cons.cdr != Lisp.NIL)
/* 316 */       return Lisp.type_error(cons.cdr, Symbol.LIST); 
/* 317 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject nreverse() {
/*     */     Cons cons;
/* 323 */     if (this.cdr instanceof Cons)
/*     */     
/* 325 */     { cons = (Cons)this.cdr;
/* 326 */       if (cons.cdr instanceof Cons)
/*     */       
/* 328 */       { Cons cons1 = cons;
/* 329 */         LispObject list = Lisp.NIL;
/*     */         
/*     */         while (true)
/* 332 */         { Cons cons2 = (Cons)cons.cdr;
/* 333 */           cons.cdr = list;
/* 334 */           list = cons;
/* 335 */           cons = cons2;
/*     */           
/* 337 */           if (!(cons.cdr instanceof Cons)) {
/* 338 */             if (cons.cdr != Lisp.NIL)
/* 339 */               return Lisp.type_error(cons.cdr, Symbol.LIST); 
/* 340 */             this.cdr = list;
/* 341 */             cons1.cdr = cons;
/*     */           } else {
/*     */             continue;
/*     */           } 
/* 345 */           LispObject temp = this.car;
/* 346 */           this.car = cons.car;
/* 347 */           cons.car = temp;
/*     */ 
/*     */ 
/*     */           
/* 351 */           return this; }  }  if (cons.cdr != Lisp.NIL) return Lisp.type_error(cons.cdr, Symbol.LIST);  } else { if (this.cdr != Lisp.NIL) return Lisp.type_error(this.cdr, Symbol.LIST);  return this; }  LispObject lispObject = this.car; this.car = cons.car; cons.car = lispObject; return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject[] copyToArray() {
/* 357 */     int length = length();
/* 358 */     LispObject[] array = new LispObject[length];
/* 359 */     LispObject rest = this;
/* 360 */     for (int i = 0; i < length; i++) {
/*     */       
/* 362 */       array[i] = rest.car();
/* 363 */       rest = rest.cdr();
/*     */     } 
/* 365 */     return array;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 371 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 373 */       Closure closure = new Closure(this, new Environment());
/* 374 */       return closure.execute();
/*     */     } 
/* 376 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 382 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 384 */       Closure closure = new Closure(this, new Environment());
/* 385 */       return closure.execute(arg);
/*     */     } 
/* 387 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 394 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 396 */       Closure closure = new Closure(this, new Environment());
/* 397 */       return closure.execute(first, second);
/*     */     } 
/* 399 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 407 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 409 */       Closure closure = new Closure(this, new Environment());
/* 410 */       return closure.execute(first, second, third);
/*     */     } 
/* 412 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 420 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 422 */       Closure closure = new Closure(this, new Environment());
/* 423 */       return closure.execute(first, second, third, fourth);
/*     */     } 
/* 425 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 434 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 436 */       Closure closure = new Closure(this, new Environment());
/* 437 */       return closure.execute(first, second, third, fourth, fifth);
/*     */     } 
/* 439 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 448 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 450 */       Closure closure = new Closure(this, new Environment());
/* 451 */       return closure.execute(first, second, third, fourth, fifth, sixth);
/*     */     } 
/* 453 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 463 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 465 */       Closure closure = new Closure(this, new Environment());
/* 466 */       return closure.execute(first, second, third, fourth, fifth, sixth, seventh);
/*     */     } 
/*     */     
/* 469 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 479 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 481 */       Closure closure = new Closure(this, new Environment());
/* 482 */       return closure.execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*     */     } 
/*     */     
/* 485 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 491 */     if (this.car == Symbol.LAMBDA) {
/*     */       
/* 493 */       Closure closure = new Closure(this, new Environment());
/* 494 */       return closure.execute(args);
/*     */     } 
/* 496 */     return signalExecutionError();
/*     */   }
/*     */ 
/*     */   
/*     */   private final LispObject signalExecutionError() {
/* 501 */     return Lisp.type_error(this, Lisp.list(Symbol.OR, new LispObject[] { Symbol.FUNCTION, Symbol.SYMBOL }));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*     */     int maxLength, maxLevel;
/* 508 */     LispThread thread = LispThread.currentThread();
/* 509 */     LispObject printLength = Symbol.PRINT_LENGTH.symbolValue(thread);
/*     */     
/* 511 */     if (printLength instanceof Fixnum) {
/* 512 */       maxLength = ((Fixnum)printLength).value;
/*     */     } else {
/* 514 */       maxLength = Integer.MAX_VALUE;
/* 515 */     }  LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/*     */     
/* 517 */     if (printLevel instanceof Fixnum) {
/* 518 */       maxLevel = ((Fixnum)printLevel).value;
/*     */     } else {
/* 520 */       maxLevel = Integer.MAX_VALUE;
/* 521 */     }  StringBuilder sb = new StringBuilder();
/* 522 */     if (this.car == Symbol.QUOTE)
/*     */     {
/* 524 */       if (this.cdr instanceof Cons)
/*     */       {
/*     */         
/* 527 */         if (this.cdr.cdr() == Lisp.NIL) {
/*     */           
/* 529 */           sb.append('\'');
/* 530 */           sb.append(this.cdr.car().printObject());
/* 531 */           return sb.toString();
/*     */         } 
/*     */       }
/*     */     }
/* 535 */     if (this.car == Symbol.FUNCTION)
/*     */     {
/* 537 */       if (this.cdr instanceof Cons)
/*     */       {
/*     */         
/* 540 */         if (this.cdr.cdr() == Lisp.NIL) {
/*     */           
/* 542 */           sb.append("#'");
/* 543 */           sb.append(this.cdr.car().printObject());
/* 544 */           return sb.toString();
/*     */         } 
/*     */       }
/*     */     }
/*     */     
/* 549 */     LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 550 */     int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 551 */     if (currentLevel < maxLevel) {
/*     */       
/* 553 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/* 554 */       thread.bindSpecial(Lisp._CURRENT_PRINT_LEVEL_, currentPrintLevel.incr());
/*     */       
/*     */       try {
/* 557 */         int count = 0;
/* 558 */         boolean truncated = false;
/* 559 */         sb.append('(');
/* 560 */         if (count < maxLength) {
/*     */           
/* 562 */           LispObject p = this;
/* 563 */           sb.append(p.car().printObject());
/* 564 */           count++;
/* 565 */           while (p = p.cdr() instanceof Cons) {
/*     */             
/* 567 */             sb.append(' ');
/* 568 */             if (count < maxLength) {
/*     */               
/* 570 */               sb.append(p.car().printObject());
/* 571 */               count++;
/*     */               
/*     */               continue;
/*     */             } 
/* 575 */             truncated = true;
/*     */           } 
/*     */ 
/*     */           
/* 579 */           if (!truncated && p != Lisp.NIL) {
/*     */             
/* 581 */             sb.append(" . ");
/* 582 */             sb.append(p.printObject());
/*     */           } 
/*     */         } else {
/*     */           
/* 586 */           truncated = true;
/* 587 */         }  if (truncated)
/* 588 */           sb.append("..."); 
/* 589 */         sb.append(')');
/*     */       }
/*     */       finally {
/*     */         
/* 593 */         thread.resetSpecialBindings(mark);
/*     */       } 
/*     */     } else {
/*     */       
/* 597 */       sb.append('#');
/* 598 */     }  return sb.toString();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static long getCount() {
/* 606 */     return count;
/*     */   }
/*     */ 
/*     */   
/*     */   static void setCount(long n) {
/* 611 */     count = n;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Cons.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */