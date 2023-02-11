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
/*     */ public class StandardObject
/*     */   extends LispObject
/*     */ {
/*     */   protected Layout layout;
/*     */   protected LispObject[] slots;
/*     */   
/*     */   protected StandardObject() {
/*  45 */     this.layout = new Layout(StandardClass.STANDARD_OBJECT, Lisp.NIL, Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected StandardObject(Layout layout) {
/*  51 */     this(layout, layout.getLength());
/*     */   }
/*     */ 
/*     */   
/*     */   protected StandardObject(Layout layout, int length) {
/*  56 */     this.layout = layout;
/*  57 */     this.slots = new LispObject[length];
/*  58 */     for (int i = this.slots.length; i-- > 0;) {
/*  59 */       this.slots[i] = Lisp.UNBOUND_VALUE;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   protected StandardObject(LispClass cls, int length) {
/*  65 */     this.layout = (cls == null) ? null : cls.getClassLayout();
/*  66 */     this.slots = new LispObject[length];
/*  67 */     for (int i = this.slots.length; i-- > 0;) {
/*  68 */       this.slots[i] = Lisp.UNBOUND_VALUE;
/*     */     }
/*     */   }
/*     */   
/*     */   protected StandardObject(LispClass cls) {
/*  73 */     this.layout = (cls == null) ? null : cls.getClassLayout();
/*  74 */     this.slots = new LispObject[(this.layout == null) ? 0 : this.layout.getLength()];
/*  75 */     for (int i = this.slots.length; i-- > 0;) {
/*  76 */       this.slots[i] = Lisp.UNBOUND_VALUE;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/*  82 */     LispObject parts = Lisp.NIL;
/*  83 */     if (this.layout != null)
/*     */     {
/*  85 */       if (this.layout.isInvalid())
/*     */       {
/*     */         
/*  88 */         this.layout = updateLayout();
/*     */       }
/*     */     }
/*  91 */     parts = parts.push(new Cons("LAYOUT", this.layout));
/*  92 */     if (this.layout != null) {
/*     */       
/*  94 */       LispObject[] slotNames = this.layout.getSlotNames();
/*  95 */       if (slotNames != null)
/*     */       {
/*  97 */         for (int i = 0; i < slotNames.length; i++)
/*     */         {
/*  99 */           parts = parts.push(new Cons(slotNames[i], this.slots[i]));
/*     */         }
/*     */       }
/*     */     } 
/* 103 */     return parts.nreverse();
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getLispClass() {
/* 108 */     return this.layout.getLispClass();
/*     */   }
/*     */ 
/*     */   
/*     */   private LispObject helperGetClassName() {
/* 113 */     LispObject c1 = this.layout.getLispClass();
/* 114 */     if (c1 instanceof LispClass) {
/* 115 */       return ((LispClass)c1).getName();
/*     */     }
/* 117 */     return LispThread.currentThread().execute(Symbol.CLASS_NAME, c1);
/*     */   }
/*     */ 
/*     */   
/*     */   private LispObject helperGetCPL() {
/* 122 */     LispObject c1 = this.layout.getLispClass();
/* 123 */     if (c1 instanceof LispClass) {
/* 124 */       return ((LispClass)c1).getCPL();
/*     */     }
/* 126 */     return LispThread.currentThread().execute(Symbol.CLASS_PRECEDENCE_LIST, c1);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 136 */     LispObject name, c1 = this.layout.getLispClass();
/*     */     
/* 138 */     if (c1 instanceof LispClass) {
/* 139 */       name = ((LispClass)c1).getName();
/*     */     } else {
/* 141 */       name = LispThread.currentThread().execute(Symbol.CLASS_NAME, c1);
/*     */     } 
/*     */ 
/*     */     
/* 145 */     if (name != Lisp.NIL && name != Lisp.UNBOUND_VALUE) {
/*     */ 
/*     */       
/* 148 */       LispObject c2 = LispClass.findClass(name, false);
/* 149 */       if (c2 == c1)
/* 150 */         return name; 
/*     */     } 
/* 152 */     return c1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 158 */     return this.layout.getLispClass();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 164 */     if (type == Symbol.STANDARD_OBJECT)
/* 165 */       return Lisp.T; 
/* 166 */     if (type == StandardClass.STANDARD_OBJECT)
/* 167 */       return Lisp.T; 
/* 168 */     LispObject cls = (this.layout != null) ? this.layout.getLispClass() : null;
/* 169 */     if (cls != null) {
/*     */       
/* 171 */       if (type == cls)
/* 172 */         return Lisp.T; 
/* 173 */       if (type == helperGetClassName())
/* 174 */         return Lisp.T; 
/* 175 */       LispObject cpl = helperGetCPL();
/* 176 */       while (cpl != Lisp.NIL) {
/*     */         
/* 178 */         if (type == cpl.car()) {
/* 179 */           return Lisp.T;
/*     */         }
/*     */         
/* 182 */         LispObject otherClass = cpl.car();
/* 183 */         if (otherClass instanceof LispClass) {
/* 184 */           if (type == ((LispClass)otherClass).getName()) {
/* 185 */             return Lisp.T;
/*     */           }
/*     */         }
/* 188 */         else if (type == 
/* 189 */           LispThread.currentThread().execute(Symbol.CLASS_NAME, otherClass)) {
/* 190 */           return Lisp.T;
/*     */         } 
/* 192 */         cpl = cpl.cdr();
/*     */       } 
/*     */     } 
/* 195 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 201 */     LispThread thread = LispThread.currentThread();
/* 202 */     int maxLevel = Integer.MAX_VALUE;
/* 203 */     LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 204 */     if (printLevel instanceof Fixnum) {
/* 205 */       maxLevel = ((Fixnum)printLevel).value;
/*     */     }
/* 207 */     LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 208 */     int currentLevel = Fixnum.getValue(currentPrintLevel);
/* 209 */     if (currentLevel >= maxLevel)
/* 210 */       return "#"; 
/* 211 */     return unreadableString(typeOf().printObject());
/*     */   }
/*     */   
/*     */   synchronized Layout updateLayout() {
/*     */     Layout newLayout;
/* 216 */     if (!this.layout.isInvalid()) return this.layout; 
/* 217 */     Layout oldLayout = this.layout;
/* 218 */     LispObject cls = oldLayout.getLispClass();
/*     */ 
/*     */     
/* 221 */     if (cls instanceof LispClass) {
/* 222 */       newLayout = ((LispClass)cls).getClassLayout();
/*     */     } else {
/* 224 */       newLayout = (Layout)Symbol.CLASS_LAYOUT.execute(cls);
/*     */     } 
/* 226 */     Debug.assertTrue(!newLayout.isInvalid());
/* 227 */     StandardObject newInstance = new StandardObject(newLayout);
/* 228 */     Debug.assertTrue((newInstance.layout == newLayout));
/* 229 */     LispObject added = Lisp.NIL;
/* 230 */     LispObject discarded = Lisp.NIL;
/* 231 */     LispObject plist = Lisp.NIL;
/*     */     
/* 233 */     LispObject[] oldSlotNames = oldLayout.getSlotNames();
/* 234 */     for (int i = 0; i < oldSlotNames.length; i++) {
/*     */       
/* 236 */       LispObject slotName = oldSlotNames[i];
/* 237 */       int k = newLayout.getSlotIndex(slotName);
/* 238 */       if (k >= 0) {
/* 239 */         newInstance.slots[k] = this.slots[i];
/*     */       } else {
/*     */         
/* 242 */         discarded = discarded.push(slotName);
/* 243 */         if (this.slots[i] != Lisp.UNBOUND_VALUE) {
/*     */           
/* 245 */           plist = plist.push(slotName);
/* 246 */           plist = plist.push(this.slots[i]);
/*     */         } 
/*     */       } 
/*     */     } 
/*     */     
/* 251 */     LispObject rest = oldLayout.getSharedSlots();
/* 252 */     if (rest != null)
/*     */     {
/* 254 */       while (rest != Lisp.NIL) {
/*     */         
/* 256 */         LispObject location = rest.car();
/* 257 */         LispObject slotName = location.car();
/* 258 */         int k = newLayout.getSlotIndex(slotName);
/* 259 */         if (k >= 0)
/* 260 */           newInstance.slots[k] = location.cdr(); 
/* 261 */         rest = rest.cdr();
/*     */       } 
/*     */     }
/*     */     
/* 265 */     LispObject[] newSlotNames = newLayout.getSlotNames();
/* 266 */     for (int j = 0; j < newSlotNames.length; j++) {
/*     */       
/* 268 */       LispObject slotName = newSlotNames[j];
/* 269 */       int k = oldLayout.getSlotIndex(slotName);
/* 270 */       if (k < 0) {
/*     */         
/* 272 */         LispObject location = oldLayout.getSharedSlotLocation(slotName);
/* 273 */         if (location == null)
/*     */         {
/*     */           
/* 276 */           added = added.push(slotName); } 
/*     */       } 
/*     */     } 
/* 279 */     LispObject[] tempSlots = this.slots;
/* 280 */     this.slots = newInstance.slots;
/* 281 */     newInstance.slots = tempSlots;
/*     */     
/* 283 */     Layout tempLayout = this.layout;
/* 284 */     this.layout = newInstance.layout;
/* 285 */     newInstance.layout = tempLayout;
/* 286 */     Debug.assertTrue(!this.layout.isInvalid());
/*     */     
/* 288 */     Symbol.UPDATE_INSTANCE_FOR_REDEFINED_CLASS.execute(this, added, discarded, plist);
/*     */     
/* 290 */     return newLayout;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getInstanceSlotValue(LispObject slotName) {
/* 297 */     Debug.assertTrue((this.layout != null));
/* 298 */     if (this.layout.isInvalid())
/*     */     {
/*     */       
/* 301 */       this.layout = updateLayout();
/*     */     }
/* 303 */     Debug.assertTrue((this.layout != null));
/* 304 */     int index = this.layout.getSlotIndex(slotName);
/* 305 */     if (index < 0) {
/*     */       
/* 307 */       LispThread thread = LispThread.currentThread();
/*     */ 
/*     */ 
/*     */       
/* 311 */       LispObject value = thread.execute(Symbol.SLOT_MISSING, 
/* 312 */           getLispClass(), this, slotName, Symbol.SLOT_VALUE);
/*     */       
/* 314 */       thread._values = null;
/* 315 */       return value;
/*     */     } 
/* 317 */     return this.slots[index];
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void setInstanceSlotValue(LispObject slotName, LispObject newValue) {
/* 324 */     Debug.assertTrue((this.layout != null));
/* 325 */     if (this.layout.isInvalid())
/*     */     {
/*     */       
/* 328 */       this.layout = updateLayout();
/*     */     }
/* 330 */     Debug.assertTrue((this.layout != null));
/* 331 */     int index = this.layout.getSlotIndex(slotName);
/* 332 */     if (index < 0) {
/*     */       
/* 334 */       LispThread thread = LispThread.currentThread();
/*     */ 
/*     */       
/* 337 */       thread.execute(Symbol.SLOT_MISSING, getLispClass(), this, slotName, Symbol.SETF, newValue);
/*     */       
/* 339 */       thread._values = null;
/*     */     } 
/* 341 */     this.slots[index] = newValue;
/*     */   }
/*     */ 
/*     */   
/*     */   public static final StandardObject checkStandardObject(LispObject first) {
/* 346 */     if (first instanceof StandardObject)
/* 347 */       return (StandardObject)first; 
/* 348 */     return (StandardObject)Lisp.type_error(first, Symbol.STANDARD_OBJECT);
/*     */   }
/*     */   
/* 351 */   private static final Primitive SWAP_SLOTS = new pf_swap_slots();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "swap-slots", args = "instance-1 instance-2", returns = "nil")
/*     */   private static final class pf_swap_slots
/*     */     extends Primitive
/*     */   {
/*     */     pf_swap_slots() {
/* 360 */       super("swap-slots", Lisp.PACKAGE_SYS, true, "instance-1 instance-2");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 365 */       StandardObject obj1 = StandardObject.checkStandardObject(first);
/* 366 */       StandardObject obj2 = StandardObject.checkStandardObject(second);
/* 367 */       LispObject[] temp = obj1.slots;
/* 368 */       obj1.slots = obj2.slots;
/* 369 */       obj2.slots = temp;
/* 370 */       return Lisp.NIL;
/*     */     }
/*     */   }
/*     */   
/* 374 */   private static final Primitive STD_INSTANCE_LAYOUT = new pf_std_instance_layout();
/*     */   
/*     */   @DocString(name = "std-instance-layout")
/*     */   private static final class pf_std_instance_layout
/*     */     extends Primitive
/*     */   {
/*     */     pf_std_instance_layout() {
/* 381 */       super("std-instance-layout", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 386 */       StandardObject instance = StandardObject.checkStandardObject(arg);
/* 387 */       Layout layout = instance.layout;
/* 388 */       if (layout.isInvalid())
/*     */       {
/*     */         
/* 391 */         layout = instance.updateLayout();
/*     */       }
/* 393 */       return layout;
/*     */     }
/*     */   }
/*     */   
/* 397 */   private static final Primitive _SET_STD_INSTANCE_LAYOUT = new pf__set_std_instance_layout();
/*     */   
/*     */   @DocString(name = "%set-std-instance-layout")
/*     */   private static final class pf__set_std_instance_layout
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_std_instance_layout() {
/* 404 */       super("%set-std-instance-layout", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 409 */       (StandardObject.checkStandardObject(first)).layout = Lisp.checkLayout(second);
/* 410 */       return second;
/*     */     }
/*     */   }
/*     */   
/* 414 */   private static final Primitive STD_INSTANCE_CLASS = new pf_std_instance_class();
/*     */   
/*     */   @DocString(name = "std-instance-class")
/*     */   private static final class pf_std_instance_class
/*     */     extends Primitive
/*     */   {
/*     */     pf_std_instance_class() {
/* 421 */       super("std-instance-class", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 426 */       return (StandardObject.checkStandardObject(arg)).layout.getLispClass();
/*     */     }
/*     */   }
/*     */   
/* 430 */   private static final Primitive STANDARD_INSTANCE_ACCESS = new pf_standard_instance_access();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "standard-instance-access", args = "instance location", returns = "value")
/*     */   private static final class pf_standard_instance_access
/*     */     extends Primitive
/*     */   {
/*     */     pf_standard_instance_access() {
/* 439 */       super("standard-instance-access", Lisp.PACKAGE_SYS, true, "instance location");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/*     */       int index;
/*     */       LispObject value;
/* 445 */       StandardObject instance = StandardObject.checkStandardObject(first);
/* 446 */       if (instance.layout.isInvalid())
/*     */       {
/* 448 */         instance.updateLayout();
/*     */       }
/*     */       
/* 451 */       if (second instanceof Fixnum) {
/* 452 */         index = ((Fixnum)second).value;
/*     */       } else {
/* 454 */         return Lisp.type_error(second, Symbol.INTEGER);
/*     */       } 
/*     */ 
/*     */       
/*     */       try {
/* 459 */         value = instance.slots[index];
/* 460 */       } catch (ArrayIndexOutOfBoundsException e) {
/* 461 */         if (instance.slots.length > 0)
/* 462 */           return Lisp.type_error(second, 
/* 463 */               Lisp.list(Symbol.INTEGER, new LispObject[] {
/* 464 */                   Fixnum.ZERO, Fixnum.getInstance(instance.slots.length - 1)
/*     */                 })); 
/* 466 */         return Lisp.program_error("The object " + instance.princToString() + " has no slots.");
/*     */       } 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 474 */       return value;
/*     */     }
/*     */   }
/*     */   
/* 478 */   private static final Primitive _SET_STANDARD_INSTANCE_ACCESS = new pf__set_standard_instance_access();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%set-standard-instance-access", args = "instance location new-value", returns = "new-value")
/*     */   private static final class pf__set_standard_instance_access
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_standard_instance_access() {
/* 487 */       super("%set-standard-instance-access", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*     */       int index;
/* 493 */       StandardObject instance = StandardObject.checkStandardObject(first);
/* 494 */       if (instance.layout.isInvalid())
/*     */       {
/* 496 */         instance.updateLayout();
/*     */       }
/*     */       
/* 499 */       if (second instanceof Fixnum) {
/* 500 */         index = ((Fixnum)second).value;
/*     */       } else {
/* 502 */         return Lisp.type_error(second, Symbol.INTEGER);
/*     */       } 
/*     */       try {
/* 505 */         instance.slots[index] = third;
/* 506 */       } catch (ArrayIndexOutOfBoundsException e) {
/* 507 */         if (instance.slots.length > 0)
/* 508 */           return Lisp.type_error(second, 
/* 509 */               Lisp.list(Symbol.INTEGER, new LispObject[] {
/* 510 */                   Fixnum.ZERO, Fixnum.getInstance(instance.slots.length - 1)
/*     */                 })); 
/* 512 */         return Lisp.program_error("The object " + instance.princToString() + " has no slots.");
/*     */       } 
/*     */       
/* 515 */       return third;
/*     */     }
/*     */   }
/*     */   
/* 519 */   private static final Primitive STD_SLOT_BOUNDP = new pf_std_slot_boundp();
/*     */   
/*     */   @DocString(name = "std-slot-boundp")
/*     */   private static final class pf_std_slot_boundp
/*     */     extends Primitive
/*     */   {
/*     */     pf_std_slot_boundp() {
/* 526 */       super(Symbol.STD_SLOT_BOUNDP, "instance slot-name");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 531 */       StandardObject instance = StandardObject.checkStandardObject(first);
/* 532 */       Layout layout = instance.layout;
/* 533 */       if (layout.isInvalid())
/*     */       {
/*     */         
/* 536 */         layout = instance.updateLayout();
/*     */       }
/* 538 */       LispObject index = layout.slotTable.get(second);
/* 539 */       if (index != null)
/*     */       {
/*     */         
/* 542 */         return (instance.slots[((Fixnum)index).value] != Lisp.UNBOUND_VALUE) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */       
/* 545 */       LispObject location = layout.getSharedSlotLocation(second);
/* 546 */       if (location != null) {
/* 547 */         return (location.cdr() != Lisp.UNBOUND_VALUE) ? Lisp.T : Lisp.NIL;
/*     */       }
/* 549 */       LispThread thread = LispThread.currentThread();
/*     */       
/* 551 */       LispObject value = thread.execute(Symbol.SLOT_MISSING, instance.getLispClass(), instance, second, Symbol.SLOT_BOUNDP);
/*     */ 
/*     */ 
/*     */       
/* 555 */       thread._values = null;
/* 556 */       return (value != Lisp.NIL) ? Lisp.T : Lisp.NIL;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject SLOT_VALUE(LispObject slotName) {
/*     */     LispObject value;
/* 563 */     if (this.layout.isInvalid())
/*     */     {
/*     */       
/* 566 */       this.layout = updateLayout();
/*     */     }
/*     */     
/* 569 */     LispObject index = this.layout.slotTable.get(slotName);
/* 570 */     if (index != null) {
/*     */ 
/*     */       
/* 573 */       value = this.slots[((Fixnum)index).value];
/*     */     
/*     */     }
/*     */     else {
/*     */       
/* 578 */       LispObject location = this.layout.getSharedSlotLocation(slotName);
/* 579 */       if (location == null) {
/* 580 */         return Symbol.SLOT_MISSING.execute(getLispClass(), this, slotName, Symbol.SLOT_VALUE);
/*     */       }
/* 582 */       value = location.cdr();
/*     */     } 
/* 584 */     if (value == Lisp.UNBOUND_VALUE) {
/*     */       
/* 586 */       value = Symbol.SLOT_UNBOUND.execute(getLispClass(), this, slotName);
/* 587 */       (LispThread.currentThread())._values = null;
/*     */     } 
/* 589 */     return value;
/*     */   }
/*     */   
/* 592 */   private static final Primitive STD_SLOT_VALUE = new pf_std_slot_value();
/*     */   
/*     */   @DocString(name = "std-slot-value")
/*     */   private static final class pf_std_slot_value
/*     */     extends Primitive
/*     */   {
/*     */     pf_std_slot_value() {
/* 599 */       super(Symbol.STD_SLOT_VALUE, "instance slot-name");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 604 */       return first.SLOT_VALUE(second);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotValue(LispObject slotName, LispObject newValue) {
/* 611 */     if (this.layout.isInvalid())
/*     */     {
/*     */       
/* 614 */       this.layout = updateLayout();
/*     */     }
/* 616 */     LispObject index = this.layout.slotTable.get(slotName);
/* 617 */     if (index != null) {
/*     */ 
/*     */       
/* 620 */       this.slots[((Fixnum)index).value] = newValue;
/*     */       
/*     */       return;
/*     */     } 
/* 624 */     LispObject location = this.layout.getSharedSlotLocation(slotName);
/* 625 */     if (location != null) {
/*     */       
/* 627 */       location.setCdr(newValue);
/*     */       return;
/*     */     } 
/* 630 */     LispObject[] args = new LispObject[5];
/* 631 */     args[0] = getLispClass();
/* 632 */     args[1] = this;
/* 633 */     args[2] = slotName;
/* 634 */     args[3] = Symbol.SETF;
/* 635 */     args[4] = newValue;
/* 636 */     Symbol.SLOT_MISSING.execute(args);
/*     */   }
/*     */   
/* 639 */   private static final Primitive SET_STD_SLOT_VALUE = new pf_set_std_slot_value();
/*     */   
/*     */   @DocString(name = "set-std-slot-value")
/*     */   private static final class pf_set_std_slot_value
/*     */     extends Primitive
/*     */   {
/*     */     pf_set_std_slot_value() {
/* 646 */       super(Symbol.SET_STD_SLOT_VALUE, "instance slot-name new-value");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 652 */       first.setSlotValue(second, third);
/* 653 */       return third;
/*     */     }
/*     */   }
/*     */   
/* 657 */   private static final Primitive _STD_ALLOCATE_INSTANCE = new pf__std_allocate_instance();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%std-allocate-instance", args = "class", returns = "instance")
/*     */   private static final class pf__std_allocate_instance
/*     */     extends Primitive
/*     */   {
/*     */     pf__std_allocate_instance() {
/* 666 */       super("%std-allocate-instance", Lisp.PACKAGE_SYS, true, "class");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 671 */       if (arg == StandardClass.FUNCALLABLE_STANDARD_CLASS)
/* 672 */         return new FuncallableStandardClass(); 
/* 673 */       if (arg == StandardClass.STANDARD_CLASS)
/* 674 */         return new StandardClass(); 
/* 675 */       if (arg instanceof StandardClass) {
/* 676 */         StandardClass cls = (StandardClass)arg;
/* 677 */         Layout layout = cls.getClassLayout();
/* 678 */         if (layout == null) {
/* 679 */           Lisp.program_error("No layout for class " + cls.princToString() + ".");
/*     */         }
/* 681 */         return new StandardObject(cls, layout.getLength());
/* 682 */       }  if (arg.typep(StandardClass.STANDARD_CLASS) != Lisp.NIL) {
/* 683 */         LispObject l = Symbol.CLASS_LAYOUT.execute(arg);
/* 684 */         if (!(l instanceof Layout)) {
/* 685 */           Lisp.program_error("Invalid standard class layout for class " + arg
/* 686 */               .princToString() + ".");
/*     */         }
/* 688 */         return new StandardObject((Layout)l);
/*     */       } 
/* 690 */       return Lisp.type_error(arg, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StandardObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */