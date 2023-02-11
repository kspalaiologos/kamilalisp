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
/*     */ public class StandardClass
/*     */   extends SlotClass
/*     */ {
/*  42 */   public static Symbol symName = Symbol.NAME;
/*  43 */   public static Symbol symLayout = Symbol.LAYOUT;
/*  44 */   public static Symbol symDirectSuperclasses = Symbol.DIRECT_SUPERCLASSES;
/*  45 */   public static Symbol symDirectSubclasses = Symbol.DIRECT_SUBCLASSES;
/*  46 */   public static Symbol symPrecedenceList = Symbol.PRECEDENCE_LIST;
/*  47 */   public static Symbol symDirectMethods = Symbol.DIRECT_METHODS;
/*  48 */   public static Symbol symDirectSlots = Symbol.DIRECT_SLOTS;
/*  49 */   public static Symbol symSlots = Symbol.SLOTS;
/*  50 */   public static Symbol symDirectDefaultInitargs = Symbol.DIRECT_DEFAULT_INITARGS;
/*     */   
/*  52 */   public static Symbol symDefaultInitargs = Symbol.DEFAULT_INITARGS;
/*  53 */   public static Symbol symFinalizedP = Symbol.FINALIZED_P;
/*     */ 
/*     */   
/*  56 */   static Function constantlyNil = new Function()
/*     */     {
/*     */       public LispObject execute()
/*     */       {
/*  60 */         return Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  66 */   static Layout layoutStandardClass = new Layout(null, 
/*     */       
/*  68 */       Lisp.list(symName, new LispObject[] { symLayout, symDirectSuperclasses, symDirectSubclasses, symPrecedenceList, symDirectMethods, symDirectSlots, symSlots, symDirectDefaultInitargs, symDefaultInitargs, symFinalizedP, Symbol._DOCUMENTATION }), Lisp.NIL)
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispClass getLispClass()
/*     */       {
/*  85 */         return StandardClass.STANDARD_CLASS;
/*     */       }
/*     */     };
/*     */   
/*  89 */   static Layout layoutFuncallableStandardClass = new Layout(null, 
/*     */       
/*  91 */       Lisp.list(symName, new LispObject[] { symLayout, symDirectSuperclasses, symDirectSubclasses, symPrecedenceList, symDirectMethods, symDirectSlots, symSlots, symDirectDefaultInitargs, symDefaultInitargs, symFinalizedP, Symbol._DOCUMENTATION }), Lisp.NIL)
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispClass getLispClass()
/*     */       {
/* 108 */         return StandardClass.FUNCALLABLE_STANDARD_CLASS;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   public StandardClass() {
/* 114 */     super(layoutStandardClass);
/* 115 */     setDirectSuperclasses(Lisp.NIL);
/* 116 */     setDirectSubclasses(Lisp.NIL);
/* 117 */     setClassLayout(layoutStandardClass);
/* 118 */     setCPL(new LispObject[] { Lisp.NIL });
/* 119 */     setDirectMethods(Lisp.NIL);
/* 120 */     setDocumentation(Lisp.NIL);
/* 121 */     setDirectSlotDefinitions(Lisp.NIL);
/* 122 */     setSlotDefinitions(Lisp.NIL);
/* 123 */     setDirectDefaultInitargs(Lisp.NIL);
/* 124 */     setDefaultInitargs(Lisp.NIL);
/* 125 */     setFinalized(false);
/*     */   }
/*     */ 
/*     */   
/*     */   public StandardClass(Symbol symbol, LispObject directSuperclasses) {
/* 130 */     super(layoutStandardClass, symbol, directSuperclasses);
/*     */     
/* 132 */     setDirectSubclasses(Lisp.NIL);
/* 133 */     setClassLayout(layoutStandardClass);
/* 134 */     setCPL(new LispObject[] { Lisp.NIL });
/* 135 */     setDirectMethods(Lisp.NIL);
/* 136 */     setDocumentation(Lisp.NIL);
/* 137 */     setDirectSlotDefinitions(Lisp.NIL);
/* 138 */     setSlotDefinitions(Lisp.NIL);
/* 139 */     setDirectDefaultInitargs(Lisp.NIL);
/* 140 */     setDefaultInitargs(Lisp.NIL);
/* 141 */     setFinalized(false);
/*     */   }
/*     */ 
/*     */   
/*     */   public StandardClass(Layout layout) {
/* 146 */     super(layout);
/* 147 */     setDirectSuperclasses(Lisp.NIL);
/* 148 */     setDirectSubclasses(Lisp.NIL);
/* 149 */     setClassLayout(layout);
/* 150 */     setCPL(new LispObject[] { Lisp.NIL });
/* 151 */     setDirectMethods(Lisp.NIL);
/* 152 */     setDocumentation(Lisp.NIL);
/* 153 */     setDirectSlotDefinitions(Lisp.NIL);
/* 154 */     setSlotDefinitions(Lisp.NIL);
/* 155 */     setDirectDefaultInitargs(Lisp.NIL);
/* 156 */     setDefaultInitargs(Lisp.NIL);
/* 157 */     setFinalized(false);
/*     */   }
/*     */ 
/*     */   
/*     */   public StandardClass(Layout layout, Symbol symbol, LispObject directSuperclasses) {
/* 162 */     super(layout, symbol, directSuperclasses);
/* 163 */     setDirectSubclasses(Lisp.NIL);
/* 164 */     setClassLayout(layout);
/* 165 */     setCPL(new LispObject[] { Lisp.NIL });
/* 166 */     setDirectMethods(Lisp.NIL);
/* 167 */     setDocumentation(Lisp.NIL);
/* 168 */     setDirectSlotDefinitions(Lisp.NIL);
/* 169 */     setSlotDefinitions(Lisp.NIL);
/* 170 */     setDirectDefaultInitargs(Lisp.NIL);
/* 171 */     setDefaultInitargs(Lisp.NIL);
/* 172 */     setFinalized(false);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getName() {
/* 179 */     return getInstanceSlotValue(symName);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setName(LispObject newName) {
/* 185 */     setInstanceSlotValue(symName, newName);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Layout getClassLayout() {
/* 191 */     LispObject layout = getInstanceSlotValue(symLayout);
/* 192 */     if (layout == Lisp.UNBOUND_VALUE) {
/* 193 */       return null;
/*     */     }
/* 195 */     if (!(layout instanceof Layout))
/*     */     {
/*     */ 
/*     */       
/* 199 */       return (Layout)Lisp.error(Symbol.TYPE_ERROR, new SimpleString("The value " + layout
/* 200 */             .princToString() + " is not of expected type " + Symbol.LAYOUT
/*     */             
/* 202 */             .princToString() + " in class " + 
/* 203 */             princToString() + "."));
/*     */     }
/*     */     
/* 206 */     return (layout == Lisp.UNBOUND_VALUE) ? null : (Layout)layout;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setClassLayout(LispObject newLayout) {
/* 212 */     setInstanceSlotValue(symLayout, newLayout);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDirectSuperclasses() {
/* 218 */     return getInstanceSlotValue(symDirectSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDirectSuperclasses(LispObject directSuperclasses) {
/* 224 */     setInstanceSlotValue(symDirectSuperclasses, directSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final boolean isFinalized() {
/* 230 */     return (getInstanceSlotValue(symFinalizedP) != Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setFinalized(boolean b) {
/* 236 */     setInstanceSlotValue(symFinalizedP, b ? Lisp.T : Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDirectSubclasses() {
/* 242 */     return getInstanceSlotValue(symDirectSubclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDirectSubclasses(LispObject directSubclasses) {
/* 248 */     setInstanceSlotValue(symDirectSubclasses, directSubclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getCPL() {
/* 254 */     return getInstanceSlotValue(symPrecedenceList);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCPL(LispObject... cpl) {
/* 260 */     LispObject obj1 = cpl[0];
/* 261 */     if (obj1.listp() && cpl.length == 1) {
/* 262 */       setInstanceSlotValue(symPrecedenceList, obj1);
/*     */     } else {
/*     */       
/* 265 */       Debug.assertTrue((obj1 == this));
/* 266 */       LispObject l = Lisp.NIL;
/* 267 */       for (int i = cpl.length; i-- > 0;)
/* 268 */         l = new Cons(cpl[i], l); 
/* 269 */       setInstanceSlotValue(symPrecedenceList, l);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDirectMethods() {
/* 276 */     return getInstanceSlotValue(symDirectMethods);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDirectMethods(LispObject methods) {
/* 282 */     setInstanceSlotValue(symDirectMethods, methods);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDocumentation() {
/* 288 */     return getInstanceSlotValue(Symbol._DOCUMENTATION);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDocumentation(LispObject doc) {
/* 294 */     setInstanceSlotValue(Symbol._DOCUMENTATION, doc);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDirectSlotDefinitions() {
/* 300 */     return getInstanceSlotValue(symDirectSlots);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDirectSlotDefinitions(LispObject directSlotDefinitions) {
/* 306 */     setInstanceSlotValue(symDirectSlots, directSlotDefinitions);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSlotDefinitions() {
/* 312 */     return getInstanceSlotValue(symSlots);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setSlotDefinitions(LispObject slotDefinitions) {
/* 318 */     setInstanceSlotValue(symSlots, slotDefinitions);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDirectDefaultInitargs() {
/* 324 */     return getInstanceSlotValue(symDirectDefaultInitargs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDirectDefaultInitargs(LispObject directDefaultInitargs) {
/* 330 */     setInstanceSlotValue(symDirectDefaultInitargs, directDefaultInitargs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDefaultInitargs() {
/* 336 */     return getInstanceSlotValue(symDefaultInitargs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setDefaultInitargs(LispObject defaultInitargs) {
/* 342 */     setInstanceSlotValue(symDefaultInitargs, defaultInitargs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 348 */     return Symbol.STANDARD_CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 354 */     return STANDARD_CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 360 */     if (type == Symbol.STANDARD_CLASS)
/* 361 */       return Lisp.T; 
/* 362 */     if (type == STANDARD_CLASS)
/* 363 */       return Lisp.T; 
/* 364 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 371 */     StringBuilder sb = new StringBuilder(Symbol.STANDARD_CLASS.printObject());
/* 372 */     if (getName() != null) {
/*     */       
/* 374 */       sb.append(' ');
/* 375 */       sb.append(getName().printObject());
/*     */     } 
/* 377 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */   
/*     */   private static final LispObject standardClassSlotDefinitions() {
/* 382 */     return 
/* 383 */       Lisp.list(new SlotDefinition(symName, Lisp.list(Symbol.CLASS_NAME, new LispObject[0]), constantlyNil), new LispObject[] { new SlotDefinition(symLayout, 
/* 384 */             Lisp.list(Symbol.CLASS_LAYOUT, new LispObject[0]), constantlyNil), new SlotDefinition(symDirectSuperclasses, 
/* 385 */             Lisp.list(Symbol.CLASS_DIRECT_SUPERCLASSES, new LispObject[0]), constantlyNil), new SlotDefinition(symDirectSubclasses, 
/* 386 */             Lisp.list(Symbol.CLASS_DIRECT_SUBCLASSES, new LispObject[0]), constantlyNil), new SlotDefinition(symPrecedenceList, 
/* 387 */             Lisp.list(Symbol.CLASS_PRECEDENCE_LIST, new LispObject[0]), constantlyNil), new SlotDefinition(symDirectMethods, 
/* 388 */             Lisp.list(Symbol.CLASS_DIRECT_METHODS, new LispObject[0]), constantlyNil), new SlotDefinition(symDirectSlots, 
/* 389 */             Lisp.list(Symbol.CLASS_DIRECT_SLOTS, new LispObject[0]), constantlyNil), new SlotDefinition(symSlots, 
/* 390 */             Lisp.list(Symbol.CLASS_SLOTS, new LispObject[0]), constantlyNil), new SlotDefinition(symDirectDefaultInitargs, 
/* 391 */             Lisp.list(Symbol.CLASS_DIRECT_DEFAULT_INITARGS, new LispObject[0]), constantlyNil), new SlotDefinition(symDefaultInitargs, 
/* 392 */             Lisp.list(Symbol.CLASS_DEFAULT_INITARGS, new LispObject[0]), constantlyNil), new SlotDefinition(symFinalizedP, 
/* 393 */             Lisp.list(Symbol.CLASS_FINALIZED_P, new LispObject[0]), constantlyNil), new SlotDefinition(Symbol._DOCUMENTATION, 
/*     */             
/* 395 */             Lisp.list(Symbol.CLASS_DOCUMENTATION, new LispObject[0]), constantlyNil, 
/* 396 */             Lisp.list(Lisp.internKeyword("DOCUMENTATION"), new LispObject[0])) });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private static final StandardClass addStandardClass(Symbol name, LispObject directSuperclasses) {
/* 402 */     StandardClass c = new StandardClass(name, directSuperclasses);
/* 403 */     addClass(name, c);
/* 404 */     return c;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private static final FuncallableStandardClass addFuncallableStandardClass(Symbol name, LispObject directSuperclasses) {
/* 410 */     FuncallableStandardClass c = new FuncallableStandardClass(name, directSuperclasses);
/* 411 */     addClass(name, c);
/* 412 */     return c;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 420 */   public static final StandardClass STANDARD_CLASS = addStandardClass(Symbol.STANDARD_CLASS, Lisp.list(BuiltInClass.CLASS_T, new LispObject[0]));
/*     */   
/* 422 */   public static final StandardClass STANDARD_OBJECT = addStandardClass(Symbol.STANDARD_OBJECT, Lisp.list(BuiltInClass.CLASS_T, new LispObject[0]));
/*     */   
/* 424 */   public static final StandardClass METAOBJECT = addStandardClass(Symbol.METAOBJECT, Lisp.list(STANDARD_OBJECT, new LispObject[0]));
/*     */   
/* 426 */   public static final StandardClass SPECIALIZER = addStandardClass(Symbol.SPECIALIZER, Lisp.list(METAOBJECT, new LispObject[0]));
/*     */ 
/*     */   
/* 429 */   public static final StandardClass SLOT_DEFINITION = addStandardClass(Symbol.SLOT_DEFINITION, Lisp.list(METAOBJECT, new LispObject[0]));
/*     */   
/* 431 */   public static final StandardClass STANDARD_SLOT_DEFINITION = addClass(Symbol.STANDARD_SLOT_DEFINITION, new SlotDefinitionClass(Symbol.STANDARD_SLOT_DEFINITION, Lisp.list(SLOT_DEFINITION, new LispObject[0])));
/*     */ 
/*     */   
/*     */   static {
/* 435 */     SLOT_DEFINITION.finalizeClass();
/*     */     
/* 437 */     STANDARD_CLASS.setClassLayout(layoutStandardClass);
/* 438 */     STANDARD_CLASS.setDirectSlotDefinitions(standardClassSlotDefinitions());
/*     */   }
/*     */ 
/*     */   
/* 442 */   public static final StandardClass DIRECT_SLOT_DEFINITION = addStandardClass(Symbol.DIRECT_SLOT_DEFINITION, Lisp.list(SLOT_DEFINITION, new LispObject[0]));
/*     */   
/* 444 */   public static final StandardClass EFFECTIVE_SLOT_DEFINITION = addStandardClass(Symbol.EFFECTIVE_SLOT_DEFINITION, Lisp.list(SLOT_DEFINITION, new LispObject[0]));
/*     */ 
/*     */   
/* 447 */   public static final StandardClass STANDARD_DIRECT_SLOT_DEFINITION = addClass(Symbol.STANDARD_DIRECT_SLOT_DEFINITION, new SlotDefinitionClass(Symbol.STANDARD_DIRECT_SLOT_DEFINITION, 
/*     */         
/* 449 */         Lisp.list(STANDARD_SLOT_DEFINITION, new LispObject[] { DIRECT_SLOT_DEFINITION })));
/*     */   
/* 451 */   public static final StandardClass STANDARD_EFFECTIVE_SLOT_DEFINITION = addClass(Symbol.STANDARD_EFFECTIVE_SLOT_DEFINITION, new SlotDefinitionClass(Symbol.STANDARD_EFFECTIVE_SLOT_DEFINITION, 
/*     */         
/* 453 */         Lisp.list(STANDARD_SLOT_DEFINITION, new LispObject[] { EFFECTIVE_SLOT_DEFINITION })));
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 460 */   public static final StandardClass FUNCALLABLE_STANDARD_OBJECT = addFuncallableStandardClass(Symbol.FUNCALLABLE_STANDARD_OBJECT, 
/* 461 */       Lisp.list(STANDARD_OBJECT, new LispObject[] { BuiltInClass.FUNCTION }));
/*     */ 
/*     */   
/* 464 */   public static final StandardClass CLASS = addStandardClass(Symbol.CLASS, Lisp.list(SPECIALIZER, new LispObject[0]));
/*     */ 
/*     */   
/* 467 */   public static final StandardClass BUILT_IN_CLASS = addStandardClass(Symbol.BUILT_IN_CLASS, Lisp.list(CLASS, new LispObject[0]));
/*     */ 
/*     */   
/* 470 */   public static final StandardClass FUNCALLABLE_STANDARD_CLASS = addStandardClass(Symbol.FUNCALLABLE_STANDARD_CLASS, Lisp.list(CLASS, new LispObject[0]));
/*     */ 
/*     */   
/* 473 */   public static final StandardClass CONDITION = addStandardClass(Symbol.CONDITION, Lisp.list(STANDARD_OBJECT, new LispObject[0]));
/*     */ 
/*     */   
/* 476 */   public static final StandardClass SIMPLE_CONDITION = addStandardClass(Symbol.SIMPLE_CONDITION, Lisp.list(CONDITION, new LispObject[0]));
/*     */ 
/*     */   
/* 479 */   public static final StandardClass WARNING = addStandardClass(Symbol.WARNING, Lisp.list(CONDITION, new LispObject[0]));
/*     */ 
/*     */   
/* 482 */   public static final StandardClass SIMPLE_WARNING = addStandardClass(Symbol.SIMPLE_WARNING, Lisp.list(SIMPLE_CONDITION, new LispObject[] { WARNING }));
/*     */ 
/*     */   
/* 485 */   public static final StandardClass STYLE_WARNING = addStandardClass(Symbol.STYLE_WARNING, Lisp.list(WARNING, new LispObject[0]));
/*     */ 
/*     */   
/* 488 */   public static final StandardClass SERIOUS_CONDITION = addStandardClass(Symbol.SERIOUS_CONDITION, Lisp.list(CONDITION, new LispObject[0]));
/*     */ 
/*     */   
/* 491 */   public static final StandardClass STORAGE_CONDITION = addStandardClass(Symbol.STORAGE_CONDITION, Lisp.list(SERIOUS_CONDITION, new LispObject[0]));
/*     */ 
/*     */   
/* 494 */   public static final StandardClass ERROR = addStandardClass(Symbol.ERROR, Lisp.list(SERIOUS_CONDITION, new LispObject[0]));
/*     */ 
/*     */   
/* 497 */   public static final StandardClass ARITHMETIC_ERROR = addStandardClass(Symbol.ARITHMETIC_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 500 */   public static final StandardClass CELL_ERROR = addStandardClass(Symbol.CELL_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 503 */   public static final StandardClass CONTROL_ERROR = addStandardClass(Symbol.CONTROL_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 506 */   public static final StandardClass FILE_ERROR = addStandardClass(Symbol.FILE_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 509 */   public static final StandardClass DIVISION_BY_ZERO = addStandardClass(Symbol.DIVISION_BY_ZERO, Lisp.list(ARITHMETIC_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 512 */   public static final StandardClass FLOATING_POINT_INEXACT = addStandardClass(Symbol.FLOATING_POINT_INEXACT, Lisp.list(ARITHMETIC_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 515 */   public static final StandardClass FLOATING_POINT_INVALID_OPERATION = addStandardClass(Symbol.FLOATING_POINT_INVALID_OPERATION, Lisp.list(ARITHMETIC_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 518 */   public static final StandardClass FLOATING_POINT_OVERFLOW = addStandardClass(Symbol.FLOATING_POINT_OVERFLOW, Lisp.list(ARITHMETIC_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 521 */   public static final StandardClass FLOATING_POINT_UNDERFLOW = addStandardClass(Symbol.FLOATING_POINT_UNDERFLOW, Lisp.list(ARITHMETIC_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 524 */   public static final StandardClass PROGRAM_ERROR = addStandardClass(Symbol.PROGRAM_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 527 */   public static final StandardClass PACKAGE_ERROR = addStandardClass(Symbol.PACKAGE_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 530 */   public static final StandardClass STREAM_ERROR = addStandardClass(Symbol.STREAM_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 533 */   public static final StandardClass PARSE_ERROR = addStandardClass(Symbol.PARSE_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 536 */   public static final StandardClass PRINT_NOT_READABLE = addStandardClass(Symbol.PRINT_NOT_READABLE, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 539 */   public static final StandardClass READER_ERROR = addStandardClass(Symbol.READER_ERROR, Lisp.list(PARSE_ERROR, new LispObject[] { STREAM_ERROR }));
/*     */ 
/*     */   
/* 542 */   public static final StandardClass END_OF_FILE = addStandardClass(Symbol.END_OF_FILE, Lisp.list(STREAM_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 545 */   public static final StandardClass SIMPLE_ERROR = addStandardClass(Symbol.SIMPLE_ERROR, Lisp.list(SIMPLE_CONDITION, new LispObject[] { ERROR }));
/*     */ 
/*     */   
/* 548 */   public static final StandardClass TYPE_ERROR = addStandardClass(Symbol.TYPE_ERROR, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 551 */   public static final StandardClass SIMPLE_TYPE_ERROR = addStandardClass(Symbol.SIMPLE_TYPE_ERROR, Lisp.list(SIMPLE_CONDITION, new LispObject[] { TYPE_ERROR }));
/*     */ 
/*     */ 
/*     */   
/* 555 */   public static final StandardClass UNBOUND_SLOT = addStandardClass(Symbol.UNBOUND_SLOT, Lisp.list(CELL_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 558 */   public static final StandardClass UNBOUND_VARIABLE = addStandardClass(Symbol.UNBOUND_VARIABLE, Lisp.list(CELL_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 561 */   public static final StandardClass UNDEFINED_FUNCTION = addStandardClass(Symbol.UNDEFINED_FUNCTION, Lisp.list(CELL_ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 564 */   public static final StandardClass JAVA_EXCEPTION = addStandardClass(Symbol.JAVA_EXCEPTION, Lisp.list(ERROR, new LispObject[0]));
/*     */ 
/*     */   
/* 567 */   public static final StandardClass METHOD = addStandardClass(Symbol.METHOD, Lisp.list(METAOBJECT, new LispObject[0]));
/*     */ 
/*     */   
/* 570 */   public static final StandardClass STANDARD_METHOD = addStandardClass(Symbol.STANDARD_METHOD, Lisp.list(METHOD, new LispObject[0]));
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static void initializeStandardClasses() {
/* 577 */     STANDARD_CLASS.setDirectSuperclass(CLASS);
/* 578 */     STANDARD_OBJECT.setDirectSuperclass(BuiltInClass.CLASS_T);
/* 579 */     FUNCALLABLE_STANDARD_OBJECT.setDirectSuperclasses(Lisp.list(STANDARD_OBJECT, new LispObject[] { BuiltInClass.FUNCTION }));
/* 580 */     ARITHMETIC_ERROR.setCPL(new LispObject[] { ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 582 */     ARITHMETIC_ERROR.setDirectSlotDefinitions(
/* 583 */         Lisp.list(new SlotDefinition(Symbol.OPERATION, 
/* 584 */             Lisp.list(Symbol.ARITHMETIC_ERROR_OPERATION, new LispObject[0])), new LispObject[] { new SlotDefinition(Symbol.OPERANDS, 
/*     */               
/* 586 */               Lisp.list(Symbol.ARITHMETIC_ERROR_OPERANDS, new LispObject[0])) }));
/* 587 */     BUILT_IN_CLASS.setCPL(new LispObject[] { BUILT_IN_CLASS, CLASS, SPECIALIZER, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 589 */     CELL_ERROR.setCPL(new LispObject[] { CELL_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 591 */     CELL_ERROR.setDirectSlotDefinitions(
/* 592 */         Lisp.list(new SlotDefinition(Symbol.NAME, 
/* 593 */             Lisp.list(Symbol.CELL_ERROR_NAME, new LispObject[0])), new LispObject[0]));
/* 594 */     CLASS.setCPL(new LispObject[] { CLASS, SPECIALIZER, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 595 */     CONDITION.setCPL(new LispObject[] { CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 596 */     CONDITION.setDirectSlotDefinitions(
/* 597 */         Lisp.list(new SlotDefinition(Symbol.FORMAT_CONTROL, 
/* 598 */             Lisp.list(Symbol.SIMPLE_CONDITION_FORMAT_CONTROL, new LispObject[0])), new LispObject[] { new SlotDefinition(Symbol.FORMAT_ARGUMENTS, 
/*     */               
/* 600 */               Lisp.list(Symbol.SIMPLE_CONDITION_FORMAT_ARGUMENTS, new LispObject[0]), Lisp.NIL) }));
/*     */     
/* 602 */     CONDITION.setDirectDefaultInitargs(Lisp.list(Lisp.list(Keyword.FORMAT_ARGUMENTS, new LispObject[] { Lisp.NIL, constantlyNil }), new LispObject[0]));
/*     */ 
/*     */     
/* 605 */     CONTROL_ERROR.setCPL(new LispObject[] { CONTROL_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 607 */     DIVISION_BY_ZERO.setCPL(new LispObject[] { DIVISION_BY_ZERO, ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 610 */     END_OF_FILE.setCPL(new LispObject[] { END_OF_FILE, STREAM_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 612 */     ERROR.setCPL(new LispObject[] { ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 614 */     FILE_ERROR.setCPL(new LispObject[] { FILE_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 616 */     FILE_ERROR.setDirectSlotDefinitions(
/* 617 */         Lisp.list(new SlotDefinition(Symbol.PATHNAME, 
/* 618 */             Lisp.list(Symbol.FILE_ERROR_PATHNAME, new LispObject[0])), new LispObject[0]));
/* 619 */     FLOATING_POINT_INEXACT.setCPL(new LispObject[] { FLOATING_POINT_INEXACT, ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 622 */     FLOATING_POINT_INVALID_OPERATION.setCPL(new LispObject[] { FLOATING_POINT_INVALID_OPERATION, ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */ 
/*     */     
/* 626 */     FLOATING_POINT_OVERFLOW.setCPL(new LispObject[] { FLOATING_POINT_OVERFLOW, ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 629 */     FLOATING_POINT_UNDERFLOW.setCPL(new LispObject[] { FLOATING_POINT_UNDERFLOW, ARITHMETIC_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 632 */     FUNCALLABLE_STANDARD_OBJECT.setCPL(new LispObject[] { FUNCALLABLE_STANDARD_OBJECT, STANDARD_OBJECT, BuiltInClass.FUNCTION, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 635 */     JAVA_EXCEPTION.setCPL(new LispObject[] { JAVA_EXCEPTION, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 637 */     JAVA_EXCEPTION.setDirectSlotDefinitions(
/* 638 */         Lisp.list(new SlotDefinition(Symbol.CAUSE, Lisp.list(Symbol.JAVA_EXCEPTION_CAUSE, new LispObject[0])), new LispObject[0]));
/* 639 */     METAOBJECT.setCPL(new LispObject[] { METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 640 */     SPECIALIZER.setCPL(new LispObject[] { SPECIALIZER, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 641 */     METHOD.setCPL(new LispObject[] { METHOD, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 642 */     STANDARD_METHOD.setCPL(new LispObject[] { STANDARD_METHOD, METHOD, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 644 */     STANDARD_METHOD.setDirectSlotDefinitions(
/* 645 */         Lisp.list(new SlotDefinition(Symbol._GENERIC_FUNCTION, Lisp.NIL, constantlyNil, 
/* 646 */             Lisp.list(Lisp.internKeyword("GENERIC-FUNCTION"), new LispObject[0])), new LispObject[] { new SlotDefinition(Symbol.LAMBDA_LIST, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol.KEYWORDS, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol.OTHER_KEYWORDS_P, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol.SPECIALIZERS, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol.QUALIFIERS, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol._FUNCTION, Lisp.NIL, constantlyNil, 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */               
/* 653 */               Lisp.list(Lisp.internKeyword("FUNCTION"), new LispObject[0])), new SlotDefinition(Symbol.FAST_FUNCTION, Lisp.NIL, constantlyNil), new SlotDefinition(Symbol._DOCUMENTATION, Lisp.NIL, constantlyNil, 
/*     */ 
/*     */               
/* 656 */               Lisp.list(Lisp.internKeyword("DOCUMENTATION"), new LispObject[0])) }));
/* 657 */     PACKAGE_ERROR.setCPL(new LispObject[] { PACKAGE_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 659 */     PACKAGE_ERROR.setDirectSlotDefinitions(
/* 660 */         Lisp.list(new SlotDefinition(Symbol.PACKAGE, 
/* 661 */             Lisp.list(Symbol.PACKAGE_ERROR_PACKAGE, new LispObject[0])), new LispObject[0]));
/* 662 */     PARSE_ERROR.setCPL(new LispObject[] { PARSE_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 664 */     PRINT_NOT_READABLE.setCPL(new LispObject[] { PRINT_NOT_READABLE, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 666 */     PRINT_NOT_READABLE.setDirectSlotDefinitions(
/* 667 */         Lisp.list(new SlotDefinition(Symbol.OBJECT, 
/* 668 */             Lisp.list(Symbol.PRINT_NOT_READABLE_OBJECT, new LispObject[0])), new LispObject[0]));
/* 669 */     PROGRAM_ERROR.setCPL(new LispObject[] { PROGRAM_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 671 */     READER_ERROR.setCPL(new LispObject[] { READER_ERROR, PARSE_ERROR, STREAM_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 674 */     SERIOUS_CONDITION.setCPL(new LispObject[] { SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 676 */     SIMPLE_CONDITION.setCPL(new LispObject[] { SIMPLE_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 678 */     SIMPLE_ERROR.setCPL(new LispObject[] { SIMPLE_ERROR, SIMPLE_CONDITION, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 681 */     SIMPLE_TYPE_ERROR.setDirectSuperclasses(Lisp.list(SIMPLE_CONDITION, new LispObject[] { TYPE_ERROR }));
/*     */     
/* 683 */     SIMPLE_TYPE_ERROR.setCPL(new LispObject[] { SIMPLE_TYPE_ERROR, SIMPLE_CONDITION, TYPE_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 686 */     SIMPLE_WARNING.setDirectSuperclasses(Lisp.list(SIMPLE_CONDITION, new LispObject[] { WARNING }));
/* 687 */     SIMPLE_WARNING.setCPL(new LispObject[] { SIMPLE_WARNING, SIMPLE_CONDITION, WARNING, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 689 */     STANDARD_CLASS.setCPL(new LispObject[] { STANDARD_CLASS, CLASS, SPECIALIZER, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 691 */     FUNCALLABLE_STANDARD_CLASS.setCPL(new LispObject[] { FUNCALLABLE_STANDARD_CLASS, CLASS, SPECIALIZER, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 696 */     FUNCALLABLE_STANDARD_CLASS.setClassLayout(layoutStandardClass);
/* 697 */     FUNCALLABLE_STANDARD_CLASS.setDirectSlotDefinitions(standardClassSlotDefinitions());
/* 698 */     STANDARD_OBJECT.setCPL(new LispObject[] { STANDARD_OBJECT, BuiltInClass.CLASS_T });
/* 699 */     STORAGE_CONDITION.setCPL(new LispObject[] { STORAGE_CONDITION, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 701 */     STREAM_ERROR.setCPL(new LispObject[] { STREAM_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 703 */     STREAM_ERROR.setDirectSlotDefinitions(
/* 704 */         Lisp.list(new SlotDefinition(Symbol.STREAM, 
/* 705 */             Lisp.list(Symbol.STREAM_ERROR_STREAM, new LispObject[0])), new LispObject[0]));
/* 706 */     STYLE_WARNING.setCPL(new LispObject[] { STYLE_WARNING, WARNING, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 708 */     TYPE_ERROR.setCPL(new LispObject[] { TYPE_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 710 */     TYPE_ERROR.setDirectSlotDefinitions(
/* 711 */         Lisp.list(new SlotDefinition(Symbol.DATUM, 
/* 712 */             Lisp.list(Symbol.TYPE_ERROR_DATUM, new LispObject[0])), new LispObject[] { new SlotDefinition(Symbol.EXPECTED_TYPE, 
/*     */               
/* 714 */               Lisp.list(Symbol.TYPE_ERROR_EXPECTED_TYPE, new LispObject[0])) }));
/* 715 */     UNBOUND_SLOT.setCPL(new LispObject[] { UNBOUND_SLOT, CELL_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 717 */     UNBOUND_SLOT.setDirectSlotDefinitions(
/* 718 */         Lisp.list(new SlotDefinition(Symbol.INSTANCE, 
/* 719 */             Lisp.list(Symbol.UNBOUND_SLOT_INSTANCE, new LispObject[0])), new LispObject[0]));
/* 720 */     UNBOUND_VARIABLE.setCPL(new LispObject[] { UNBOUND_VARIABLE, CELL_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 723 */     UNDEFINED_FUNCTION.setCPL(new LispObject[] { UNDEFINED_FUNCTION, CELL_ERROR, ERROR, SERIOUS_CONDITION, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 726 */     WARNING.setCPL(new LispObject[] { WARNING, CONDITION, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 729 */     STANDARD_CLASS.finalizeClass();
/* 730 */     STANDARD_OBJECT.finalizeClass();
/* 731 */     FUNCALLABLE_STANDARD_OBJECT.finalizeClass();
/* 732 */     FUNCALLABLE_STANDARD_CLASS.finalizeClass();
/* 733 */     ARITHMETIC_ERROR.finalizeClass();
/* 734 */     CELL_ERROR.finalizeClass();
/* 735 */     CONDITION.finalizeClass();
/* 736 */     CONTROL_ERROR.finalizeClass();
/* 737 */     DIVISION_BY_ZERO.finalizeClass();
/* 738 */     END_OF_FILE.finalizeClass();
/* 739 */     ERROR.finalizeClass();
/* 740 */     FILE_ERROR.finalizeClass();
/* 741 */     FLOATING_POINT_INEXACT.finalizeClass();
/* 742 */     FLOATING_POINT_INVALID_OPERATION.finalizeClass();
/* 743 */     FLOATING_POINT_OVERFLOW.finalizeClass();
/* 744 */     FLOATING_POINT_UNDERFLOW.finalizeClass();
/* 745 */     JAVA_EXCEPTION.finalizeClass();
/* 746 */     METAOBJECT.finalizeClass();
/* 747 */     METHOD.finalizeClass();
/* 748 */     STANDARD_METHOD.finalizeClass();
/* 749 */     SPECIALIZER.finalizeClass();
/* 750 */     CLASS.finalizeClass();
/* 751 */     BUILT_IN_CLASS.finalizeClass();
/* 752 */     PACKAGE_ERROR.finalizeClass();
/* 753 */     PARSE_ERROR.finalizeClass();
/* 754 */     PRINT_NOT_READABLE.finalizeClass();
/* 755 */     PROGRAM_ERROR.finalizeClass();
/* 756 */     READER_ERROR.finalizeClass();
/* 757 */     SERIOUS_CONDITION.finalizeClass();
/* 758 */     SIMPLE_CONDITION.finalizeClass();
/* 759 */     SIMPLE_ERROR.finalizeClass();
/* 760 */     SIMPLE_TYPE_ERROR.finalizeClass();
/* 761 */     SIMPLE_WARNING.finalizeClass();
/* 762 */     STORAGE_CONDITION.finalizeClass();
/* 763 */     STREAM_ERROR.finalizeClass();
/* 764 */     STYLE_WARNING.finalizeClass();
/* 765 */     TYPE_ERROR.finalizeClass();
/* 766 */     UNBOUND_SLOT.finalizeClass();
/* 767 */     UNBOUND_VARIABLE.finalizeClass();
/* 768 */     UNDEFINED_FUNCTION.finalizeClass();
/* 769 */     WARNING.finalizeClass();
/*     */ 
/*     */ 
/*     */     
/* 773 */     Debug.assertTrue(SLOT_DEFINITION.isFinalized());
/* 774 */     SLOT_DEFINITION.setCPL(new LispObject[] { SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 776 */     SLOT_DEFINITION.setDirectSlotDefinitions(SLOT_DEFINITION.getClassLayout().generateSlotDefinitions());
/*     */     
/* 778 */     SLOT_DEFINITION.setSlotDefinitions(SLOT_DEFINITION.getDirectSlotDefinitions());
/*     */     
/* 780 */     DIRECT_SLOT_DEFINITION.setCPL(new LispObject[] { DIRECT_SLOT_DEFINITION, SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 782 */     DIRECT_SLOT_DEFINITION.finalizeClass();
/* 783 */     EFFECTIVE_SLOT_DEFINITION.setCPL(new LispObject[] { EFFECTIVE_SLOT_DEFINITION, SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 785 */     EFFECTIVE_SLOT_DEFINITION.finalizeClass();
/* 786 */     STANDARD_SLOT_DEFINITION.setCPL(new LispObject[] { STANDARD_SLOT_DEFINITION, SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */     
/* 788 */     STANDARD_SLOT_DEFINITION.finalizeClass();
/* 789 */     STANDARD_DIRECT_SLOT_DEFINITION.setCPL(new LispObject[] { STANDARD_DIRECT_SLOT_DEFINITION, STANDARD_SLOT_DEFINITION, DIRECT_SLOT_DEFINITION, SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 792 */     STANDARD_DIRECT_SLOT_DEFINITION.finalizeClass();
/* 793 */     STANDARD_EFFECTIVE_SLOT_DEFINITION.setCPL(new LispObject[] { STANDARD_EFFECTIVE_SLOT_DEFINITION, STANDARD_SLOT_DEFINITION, EFFECTIVE_SLOT_DEFINITION, SLOT_DEFINITION, METAOBJECT, STANDARD_OBJECT, BuiltInClass.CLASS_T });
/*     */ 
/*     */     
/* 796 */     STANDARD_EFFECTIVE_SLOT_DEFINITION.finalizeClass();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StandardClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */