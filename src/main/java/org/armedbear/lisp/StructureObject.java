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
/*     */ public class StructureObject
/*     */   extends LispObject
/*     */ {
/*     */   private final StructureClass structureClass;
/*     */   final LispObject[] slots;
/*     */   
/*     */   public StructureObject(Symbol symbol) {
/*  46 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  47 */     if (this.structureClass == null) {
/*  48 */       System.err.println("No mitens sitten: " + BuiltInClass.SYSTEM_STREAM.toString());
/*  49 */       System.err.println("joopa joo:" + Symbol.SYSTEM_STREAM.name);
/*  50 */       System.err.println("Oh noes, structure object got a null class:" + symbol.toString() + ", symbol name:" + symbol.name);
/*     */     } 
/*  52 */     this.slots = new LispObject[0];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject[] slots) {
/*  58 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  59 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0) {
/*  65 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  66 */     LispObject[] slots = new LispObject[1];
/*  67 */     slots[0] = obj0;
/*  68 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0, LispObject obj1) {
/*  74 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  75 */     LispObject[] slots = new LispObject[2];
/*  76 */     slots[0] = obj0;
/*  77 */     slots[1] = obj1;
/*  78 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0, LispObject obj1, LispObject obj2) {
/*  85 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  86 */     LispObject[] slots = new LispObject[3];
/*  87 */     slots[0] = obj0;
/*  88 */     slots[1] = obj1;
/*  89 */     slots[2] = obj2;
/*  90 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0, LispObject obj1, LispObject obj2, LispObject obj3) {
/*  97 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/*  98 */     LispObject[] slots = new LispObject[4];
/*  99 */     slots[0] = obj0;
/* 100 */     slots[1] = obj1;
/* 101 */     slots[2] = obj2;
/* 102 */     slots[3] = obj3;
/* 103 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0, LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4) {
/* 110 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/* 111 */     LispObject[] slots = new LispObject[5];
/* 112 */     slots[0] = obj0;
/* 113 */     slots[1] = obj1;
/* 114 */     slots[2] = obj2;
/* 115 */     slots[3] = obj3;
/* 116 */     slots[4] = obj4;
/* 117 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public StructureObject(Symbol symbol, LispObject obj0, LispObject obj1, LispObject obj2, LispObject obj3, LispObject obj4, LispObject obj5) {
/* 125 */     this.structureClass = (StructureClass)LispClass.findClass(symbol);
/* 126 */     LispObject[] slots = new LispObject[6];
/* 127 */     slots[0] = obj0;
/* 128 */     slots[1] = obj1;
/* 129 */     slots[2] = obj2;
/* 130 */     slots[3] = obj3;
/* 131 */     slots[4] = obj4;
/* 132 */     slots[5] = obj5;
/* 133 */     this.slots = slots;
/*     */   }
/*     */ 
/*     */   
/*     */   public StructureObject(StructureObject obj) {
/* 138 */     this.structureClass = obj.structureClass;
/* 139 */     this.slots = new LispObject[obj.slots.length];
/* 140 */     for (int i = this.slots.length; i-- > 0;) {
/* 141 */       this.slots[i] = obj.slots[i];
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 147 */     return this.structureClass.getName();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 153 */     return this.structureClass;
/*     */   }
/*     */   
/*     */   protected int getSlotIndex(LispObject slotName) {
/* 157 */     LispObject effectiveSlots = this.structureClass.getSlotDefinitions();
/* 158 */     LispObject[] effectiveSlotsArray = effectiveSlots.copyToArray();
/* 159 */     for (int i = 0; i < this.slots.length; i++) {
/* 160 */       SimpleVector slotDefinition = (SimpleVector)effectiveSlotsArray[i];
/* 161 */       LispObject candidateSlotName = slotDefinition.AREF(1);
/* 162 */       if (slotName == candidateSlotName) {
/* 163 */         return i;
/*     */       }
/*     */     } 
/* 166 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject SLOT_VALUE(LispObject slotName) {
/*     */     LispObject value;
/* 173 */     int index = getSlotIndex(slotName);
/* 174 */     if (index >= 0) {
/* 175 */       value = this.slots[index];
/*     */     } else {
/* 177 */       value = Lisp.UNBOUND_VALUE;
/* 178 */       value = Symbol.SLOT_UNBOUND.execute(this.structureClass, this, slotName);
/* 179 */       (LispThread.currentThread())._values = null;
/*     */     } 
/* 181 */     return value;
/*     */   }
/*     */   
/*     */   public void setSlotValue(LispObject slotName, LispObject newValue) {
/* 185 */     int index = getSlotIndex(slotName);
/* 186 */     if (index >= 0) {
/* 187 */       this.slots[index] = newValue;
/*     */     } else {
/* 189 */       LispObject[] args = new LispObject[5];
/* 190 */       args[0] = this.structureClass;
/* 191 */       args[1] = this;
/* 192 */       args[2] = slotName;
/* 193 */       args[3] = Symbol.SETF;
/* 194 */       args[4] = newValue;
/* 195 */       Symbol.SLOT_MISSING.execute(args);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 202 */     LispObject result = Lisp.NIL;
/* 203 */     result = result.push(new Cons("class", this.structureClass));
/* 204 */     LispObject effectiveSlots = this.structureClass.getSlotDefinitions();
/* 205 */     LispObject[] effectiveSlotsArray = effectiveSlots.copyToArray();
/* 206 */     Debug.assertTrue((effectiveSlotsArray.length == this.slots.length));
/* 207 */     for (int i = 0; i < this.slots.length; i++) {
/*     */       
/* 209 */       SimpleVector slotDefinition = (SimpleVector)effectiveSlotsArray[i];
/* 210 */       LispObject slotName = slotDefinition.AREF(1);
/* 211 */       result = result.push(new Cons(slotName, this.slots[i]));
/*     */     } 
/* 213 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 219 */     if (type instanceof StructureClass)
/* 220 */       return Lisp.memq(type, this.structureClass.getCPL()) ? Lisp.T : Lisp.NIL; 
/* 221 */     if (type == this.structureClass.getName())
/* 222 */       return Lisp.T; 
/* 223 */     if (type == Symbol.STRUCTURE_OBJECT)
/* 224 */       return Lisp.T; 
/* 225 */     if (type == BuiltInClass.STRUCTURE_OBJECT)
/* 226 */       return Lisp.T; 
/* 227 */     if (type instanceof Symbol) {
/*     */       
/* 229 */       LispClass c = LispClass.findClass((Symbol)type);
/* 230 */       if (c != null)
/* 231 */         return Lisp.memq(c, this.structureClass.getCPL()) ? Lisp.T : Lisp.NIL; 
/*     */     } 
/* 233 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/* 239 */     if (this == obj)
/* 240 */       return true; 
/* 241 */     if (obj instanceof StructureObject) {
/*     */       
/* 243 */       StructureObject o = (StructureObject)obj;
/* 244 */       if (this.structureClass != o.structureClass)
/* 245 */         return false; 
/* 246 */       for (int i = 0; i < this.slots.length; i++) {
/*     */         
/* 248 */         if (!this.slots[i].equalp(o.slots[i]))
/* 249 */           return false; 
/*     */       } 
/* 251 */       return true;
/*     */     } 
/* 253 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotValue_0() {
/*     */     try {
/* 261 */       return this.slots[0];
/*     */     }
/* 263 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 265 */       return badIndex(0);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotValue_1() {
/*     */     try {
/* 274 */       return this.slots[1];
/*     */     }
/* 276 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 278 */       return badIndex(1);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotValue_2() {
/*     */     try {
/* 287 */       return this.slots[2];
/*     */     }
/* 289 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 291 */       return badIndex(2);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotValue_3() {
/*     */     try {
/* 300 */       return this.slots[3];
/*     */     }
/* 302 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 304 */       return badIndex(3);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotValue(int index) {
/*     */     try {
/* 313 */       return this.slots[index];
/*     */     }
/* 315 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 317 */       return badIndex(index);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int getFixnumSlotValue(int index) {
/*     */     try {
/* 326 */       return Fixnum.getValue(this.slots[index]);
/*     */     }
/* 328 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 330 */       badIndex(index);
/*     */       
/* 332 */       return 0;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean getSlotValueAsBoolean(int index) {
/*     */     try {
/* 341 */       return (this.slots[index] != Lisp.NIL);
/*     */     }
/* 343 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 345 */       badIndex(index);
/*     */       
/* 347 */       return false;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue_0(LispObject value) {
/*     */     try {
/* 357 */       this.slots[0] = value;
/*     */     }
/* 359 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 361 */       badIndex(0);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue_1(LispObject value) {
/*     */     try {
/* 371 */       this.slots[1] = value;
/*     */     }
/* 373 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 375 */       badIndex(1);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue_2(LispObject value) {
/*     */     try {
/* 385 */       this.slots[2] = value;
/*     */     }
/* 387 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 389 */       badIndex(2);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue_3(LispObject value) {
/*     */     try {
/* 399 */       this.slots[3] = value;
/*     */     }
/* 401 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 403 */       badIndex(3);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue(int index, LispObject value) {
/*     */     try {
/* 413 */       this.slots[index] = value;
/*     */     }
/* 415 */     catch (ArrayIndexOutOfBoundsException e) {
/*     */       
/* 417 */       badIndex(index);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   private LispObject badIndex(int n) {
/* 423 */     StringBuilder sb = new StringBuilder("Invalid slot index ");
/* 424 */     sb.append(Fixnum.getInstance(n).princToString());
/* 425 */     sb.append(" for ");
/* 426 */     sb.append(princToString());
/* 427 */     return Lisp.error(new LispError(sb.toString()));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int psxhash() {
/* 433 */     return psxhash(4);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int psxhash(int depth) {
/* 439 */     int result = Lisp.mix(this.structureClass.sxhash(), 7814971L);
/* 440 */     if (depth > 0) {
/*     */       
/* 442 */       int limit = this.slots.length;
/* 443 */       if (limit > 4)
/* 444 */         limit = 4; 
/* 445 */       for (int i = 0; i < limit; i++)
/* 446 */         result = Lisp.mix(this.slots[i].psxhash(depth - 1), result); 
/*     */     } 
/* 448 */     return result & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*     */     try {
/* 456 */       LispThread thread = LispThread.currentThread();
/*     */       
/* 458 */       if (typep(Symbol.RESTART) != Lisp.NIL) {
/*     */         
/* 460 */         Symbol PRINT_RESTART = Lisp.PACKAGE_SYS.intern("PRINT-RESTART");
/* 461 */         LispObject fun = PRINT_RESTART.getSymbolFunction();
/* 462 */         StringOutputStream stream = new StringOutputStream();
/* 463 */         thread.execute(fun, this, stream);
/* 464 */         return stream.getString().getStringValue();
/*     */       } 
/* 466 */       if (Lisp._PRINT_STRUCTURE_.symbolValue(thread) == Lisp.NIL)
/* 467 */         return unreadableString(this.structureClass.getName().printObject()); 
/* 468 */       int maxLevel = Integer.MAX_VALUE;
/* 469 */       LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 470 */       if (printLevel instanceof Fixnum) {
/* 471 */         maxLevel = ((Fixnum)printLevel).value;
/*     */       }
/* 473 */       LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 474 */       int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 475 */       if (currentLevel >= maxLevel && this.slots.length > 0)
/* 476 */         return "#"; 
/* 477 */       StringBuilder sb = new StringBuilder("#S(");
/* 478 */       sb.append(this.structureClass.getName().printObject());
/* 479 */       if (currentLevel < maxLevel) {
/*     */         int limit;
/* 481 */         LispObject effectiveSlots = this.structureClass.getSlotDefinitions();
/* 482 */         LispObject[] effectiveSlotsArray = effectiveSlots.copyToArray();
/* 483 */         Debug.assertTrue((effectiveSlotsArray.length == this.slots.length));
/* 484 */         LispObject printLength = Symbol.PRINT_LENGTH.symbolValue(thread);
/*     */         
/* 486 */         if (printLength instanceof Fixnum) {
/* 487 */           limit = Math.min(this.slots.length, ((Fixnum)printLength).value);
/*     */         } else {
/* 489 */           limit = this.slots.length;
/*     */         } 
/* 491 */         boolean printCircle = (Symbol.PRINT_CIRCLE.symbolValue(thread) != Lisp.NIL);
/* 492 */         for (int i = 0; i < limit; i++) {
/*     */           
/* 494 */           sb.append(' ');
/* 495 */           SimpleVector slotDefinition = (SimpleVector)effectiveSlotsArray[i];
/*     */           
/* 497 */           LispObject slotName = slotDefinition.AREF(1);
/* 498 */           Debug.assertTrue(slotName instanceof Symbol);
/* 499 */           sb.append(':');
/* 500 */           sb.append(((Symbol)slotName).name.getStringValue());
/* 501 */           sb.append(' ');
/* 502 */           if (printCircle) {
/*     */             
/* 504 */             StringOutputStream stream = new StringOutputStream();
/* 505 */             thread.execute(Symbol.OUTPUT_OBJECT.getSymbolFunction(), this.slots[i], stream);
/*     */             
/* 507 */             sb.append(stream.getString().getStringValue());
/*     */           } else {
/*     */             
/* 510 */             sb.append(this.slots[i].printObject());
/*     */           } 
/* 512 */         }  if (limit < this.slots.length)
/* 513 */           sb.append(" ..."); 
/*     */       } 
/* 515 */       sb.append(')');
/* 516 */       return sb.toString();
/*     */     }
/* 518 */     catch (StackOverflowError e) {
/*     */       
/* 520 */       Lisp.error(new StorageCondition("Stack overflow."));
/* 521 */       return null;
/*     */     } 
/*     */   }
/*     */   
/* 525 */   private static final Primitive STRUCTURE_OBJECT_P = new pf_structure_object_p();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "structure-object-p", args = "object", returns = "generalized-boolean")
/*     */   private static final class pf_structure_object_p
/*     */     extends Primitive
/*     */   {
/*     */     pf_structure_object_p() {
/* 534 */       super("structure-object-p", Lisp.PACKAGE_SYS, true, "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 539 */       return (arg instanceof StructureObject) ? Lisp.T : Lisp.NIL;
/*     */     }
/*     */   }
/*     */   
/* 543 */   private static final Primitive STRUCTURE_LENGTH = new pf_structure_length();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "structure-length", args = "instance", returns = "length")
/*     */   private static final class pf_structure_length
/*     */     extends Primitive
/*     */   {
/*     */     pf_structure_length() {
/* 552 */       super("structure-length", Lisp.PACKAGE_SYS, true, "instance");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 557 */       if (arg instanceof StructureObject)
/* 558 */         return Fixnum.getInstance(((StructureObject)arg).slots.length); 
/* 559 */       return Lisp.type_error(arg, Symbol.STRUCTURE_OBJECT);
/*     */     }
/*     */   }
/*     */   
/* 563 */   private static final Primitive STRUCTURE_REF = new pf_structure_ref();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "structure-ref", args = "instance index", returns = "value")
/*     */   private static final class pf_structure_ref
/*     */     extends Primitive
/*     */   {
/*     */     pf_structure_ref() {
/* 572 */       super("structure-ref", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 577 */       if (first instanceof StructureObject)
/*     */         
/*     */         try {
/* 580 */           return ((StructureObject)first).slots[Fixnum.getValue(second)];
/*     */         }
/* 582 */         catch (ArrayIndexOutOfBoundsException e) {
/*     */ 
/*     */           
/* 585 */           return Lisp.error(new LispError("Internal error."));
/*     */         }  
/* 587 */       return Lisp.type_error(first, Symbol.STRUCTURE_OBJECT);
/*     */     }
/*     */   }
/*     */   
/* 591 */   private static final Primitive STRUCTURE_SET = new pf_structure_set();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "structure-set", args = "instance index new-value", returns = "new-value")
/*     */   private static final class pf_structure_set
/*     */     extends Primitive
/*     */   {
/*     */     pf_structure_set() {
/* 600 */       super("structure-set", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 606 */       if (first instanceof StructureObject)
/*     */         
/*     */         try {
/* 609 */           ((StructureObject)first).slots[Fixnum.getValue(second)] = third;
/* 610 */           return third;
/*     */         }
/* 612 */         catch (ArrayIndexOutOfBoundsException e) {
/*     */ 
/*     */           
/* 615 */           return Lisp.error(new LispError("Internal error."));
/*     */         }  
/* 617 */       return Lisp.type_error(first, Symbol.STRUCTURE_OBJECT);
/*     */     }
/*     */   }
/*     */   
/* 621 */   private static final Primitive MAKE_STRUCTURE = new pf_make_structure();
/*     */   
/*     */   @DocString(name = "make-structure")
/*     */   private static final class pf_make_structure
/*     */     extends Primitive
/*     */   {
/*     */     pf_make_structure() {
/* 628 */       super("make-structure", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 633 */       return new StructureObject(Lisp.checkSymbol(first), second);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 640 */       return new StructureObject(Lisp.checkSymbol(first), second, third);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 647 */       return new StructureObject(Lisp.checkSymbol(first), second, third, fourth);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 654 */       return new StructureObject(Lisp.checkSymbol(first), second, third, fourth, fifth);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 662 */       return new StructureObject(Lisp.checkSymbol(first), second, third, fourth, fifth, sixth);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 671 */       return new StructureObject(Lisp.checkSymbol(first), second, third, fourth, fifth, sixth, seventh);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 676 */   private static final Primitive _MAKE_STRUCTURE = new pf__make_structure();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%make-structure", args = "name slot-values", returns = "object")
/*     */   private static final class pf__make_structure
/*     */     extends Primitive
/*     */   {
/*     */     pf__make_structure() {
/* 685 */       super("%make-structure", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 690 */       return new StructureObject(Lisp.checkSymbol(first), second.copyToArray());
/*     */     }
/*     */   }
/*     */   
/* 694 */   private static final Primitive COPY_STRUCTURE = new pf_copy_structure();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "copy-structure", args = "structure", returns = "copy")
/*     */   private static final class pf_copy_structure
/*     */     extends Primitive
/*     */   {
/*     */     pf_copy_structure() {
/* 703 */       super(Symbol.COPY_STRUCTURE, "structure");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 708 */       if (arg instanceof StructureObject)
/* 709 */         return new StructureObject((StructureObject)arg); 
/* 710 */       return Lisp.type_error(arg, Symbol.STRUCTURE_OBJECT);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StructureObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */