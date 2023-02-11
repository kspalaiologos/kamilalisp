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
/*     */ public class SlotClass
/*     */   extends LispClass
/*     */ {
/*  40 */   private LispObject directSlotDefinitions = Lisp.NIL;
/*  41 */   private LispObject slotDefinitions = Lisp.NIL;
/*  42 */   private LispObject directDefaultInitargs = Lisp.NIL;
/*  43 */   private LispObject defaultInitargs = Lisp.NIL;
/*     */ 
/*     */   
/*     */   public SlotClass(Layout layout) {
/*  47 */     super(layout);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotClass(Symbol symbol, LispObject directSuperclasses) {
/*  54 */     this((Layout)null, symbol, directSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotClass(Layout layout, Symbol symbol, LispObject directSuperclasses) {
/*  60 */     super(layout, symbol, directSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/*  66 */     LispObject result = super.getParts().nreverse();
/*  67 */     result = result.push(new Cons("DIRECT-SLOTS", 
/*  68 */           getDirectSlotDefinitions()));
/*  69 */     result = result.push(new Cons("SLOTS", getSlotDefinitions()));
/*  70 */     result = result.push(new Cons("DIRECT-DEFAULT-INITARGS", 
/*  71 */           getDirectDefaultInitargs()));
/*  72 */     result = result.push(new Cons("DEFAULT-INITARGS", 
/*  73 */           getDefaultInitargs()));
/*  74 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  80 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDirectSlotDefinitions() {
/*  85 */     return this.directSlotDefinitions;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDirectSlotDefinitions(LispObject directSlotDefinitions) {
/*  90 */     this.directSlotDefinitions = directSlotDefinitions;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getSlotDefinitions() {
/*  95 */     return this.slotDefinitions;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setSlotDefinitions(LispObject slotDefinitions) {
/* 100 */     this.slotDefinitions = slotDefinitions;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDirectDefaultInitargs() {
/* 105 */     return this.directDefaultInitargs;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDirectDefaultInitargs(LispObject directDefaultInitargs) {
/* 110 */     this.directDefaultInitargs = directDefaultInitargs;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDefaultInitargs() {
/* 115 */     return this.defaultInitargs;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDefaultInitargs(LispObject defaultInitargs) {
/* 120 */     this.defaultInitargs = defaultInitargs;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   LispObject computeDefaultInitargs() {
/* 128 */     LispObject result = Lisp.NIL;
/* 129 */     LispObject cpl = getCPL();
/* 130 */     while (cpl != Lisp.NIL) {
/* 131 */       LispClass c = (LispClass)cpl.car();
/* 132 */       if (c instanceof StandardClass) {
/* 133 */         LispObject obj = ((StandardClass)c).getDirectDefaultInitargs();
/* 134 */         if (obj != Lisp.NIL)
/* 135 */           result = Symbol.APPEND.execute(result, obj); 
/*     */       } 
/* 137 */       cpl = cpl.cdr();
/*     */     } 
/* 139 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public void finalizeClass() {
/* 144 */     if (isFinalized()) {
/*     */       return;
/*     */     }
/* 147 */     LispObject defs = getSlotDefinitions();
/* 148 */     Debug.assertTrue((defs == Lisp.NIL));
/* 149 */     LispObject cpl = getCPL();
/* 150 */     Debug.assertTrue((cpl != null));
/* 151 */     Debug.assertTrue(cpl.listp());
/* 152 */     cpl = cpl.reverse();
/* 153 */     while (cpl != Lisp.NIL) {
/* 154 */       LispObject car = cpl.car();
/* 155 */       if (car instanceof StandardClass) {
/* 156 */         StandardClass cls = (StandardClass)car;
/* 157 */         LispObject directDefs = cls.getDirectSlotDefinitions();
/* 158 */         Debug.assertTrue((directDefs != null));
/* 159 */         Debug.assertTrue(directDefs.listp());
/* 160 */         while (directDefs != Lisp.NIL) {
/* 161 */           defs = defs.push(directDefs.car());
/* 162 */           directDefs = directDefs.cdr();
/*     */         } 
/*     */       } 
/* 165 */       cpl = cpl.cdr();
/*     */     } 
/* 167 */     setSlotDefinitions(defs.nreverse());
/* 168 */     LispObject[] instanceSlotNames = new LispObject[defs.length()];
/* 169 */     int i = 0;
/* 170 */     LispObject tail = getSlotDefinitions();
/* 171 */     while (tail != Lisp.NIL) {
/* 172 */       SlotDefinition slotDefinition = (SlotDefinition)tail.car();
/* 173 */       slotDefinition.setInstanceSlotValue(Symbol.LOCATION, 
/* 174 */           Fixnum.getInstance(i));
/* 175 */       instanceSlotNames[i++] = slotDefinition
/* 176 */         .getInstanceSlotValue(Symbol.NAME);
/* 177 */       tail = tail.cdr();
/*     */     } 
/* 179 */     setClassLayout(new Layout(this, instanceSlotNames, Lisp.NIL));
/* 180 */     setDefaultInitargs(computeDefaultInitargs());
/* 181 */     setFinalized(true);
/*     */   }
/*     */   
/*     */   @DocString(name = "%class-direct-slots")
/* 185 */   private static final Primitive CLASS_DIRECT_SLOTS = new pf__class_direct_slots();
/*     */   
/*     */   private static final class pf__class_direct_slots
/*     */     extends Primitive
/*     */   {
/*     */     pf__class_direct_slots() {
/* 191 */       super("%class-direct-slots", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 197 */       if (arg instanceof SlotClass)
/* 198 */         return ((SlotClass)arg).getDirectSlotDefinitions(); 
/* 199 */       if (arg instanceof BuiltInClass)
/* 200 */         return Lisp.NIL; 
/* 201 */       return Lisp.type_error(arg, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */   
/*     */   @DocString(name = "%set-class-direct-slots")
/* 206 */   private static final Primitive _SET_CLASS_DIRECT_SLOT = new pf__set_class_direct_slots();
/*     */   
/*     */   private static final class pf__set_class_direct_slots
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_class_direct_slots() {
/* 212 */       super("%set-class-direct-slots", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 218 */       if (second instanceof SlotClass) {
/* 219 */         ((SlotClass)second).setDirectSlotDefinitions(first);
/* 220 */         return first;
/*     */       } 
/* 222 */       return Lisp.type_error(second, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%class-slots", args = "class")
/* 229 */   private static final Primitive _CLASS_SLOTS = new pf__class_slots();
/*     */   
/*     */   private static final class pf__class_slots
/*     */     extends Primitive
/*     */   {
/*     */     pf__class_slots() {
/* 235 */       super(Symbol._CLASS_SLOTS, "class");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 241 */       if (arg instanceof SlotClass)
/* 242 */         return ((SlotClass)arg).getSlotDefinitions(); 
/* 243 */       if (arg instanceof BuiltInClass)
/* 244 */         return Lisp.NIL; 
/* 245 */       return Lisp.type_error(arg, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   @DocString(name = "%set-class-slots", args = "class slot-definitions")
/* 251 */   private static final Primitive _SET_CLASS_SLOTS = new pf__set_class_slots();
/*     */   
/*     */   private static final class pf__set_class_slots
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_class_slots() {
/* 257 */       super(Symbol._SET_CLASS_SLOTS, "class slot-definitions");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 262 */       if (second instanceof SlotClass) {
/* 263 */         ((SlotClass)second).setSlotDefinitions(first);
/* 264 */         return first;
/*     */       } 
/* 266 */       return Lisp.type_error(second, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   @DocString(name = "%class-direct-default-initargs")
/* 272 */   private static final Primitive CLASS_DIRECT_DEFAULT_INITARGS = new pf__class_direct_default_initargs();
/*     */   
/*     */   private static final class pf__class_direct_default_initargs
/*     */     extends Primitive
/*     */   {
/*     */     pf__class_direct_default_initargs() {
/* 278 */       super("%class-direct-default-initargs", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 283 */       if (arg instanceof SlotClass)
/* 284 */         return ((SlotClass)arg).getDirectDefaultInitargs(); 
/* 285 */       if (arg instanceof BuiltInClass)
/* 286 */         return Lisp.NIL; 
/* 287 */       return Lisp.type_error(arg, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */   
/*     */   @DocString(name = "%set-class-direct-default-initargs")
/* 292 */   private static final Primitive _SET_CLASS_DIRECT_DEFAULT_INITARGS = new pf__set_class_direct_default_initargs();
/*     */   
/*     */   private static final class pf__set_class_direct_default_initargs
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_class_direct_default_initargs() {
/* 298 */       super("%set-class-direct-default-initargs", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 303 */       if (second instanceof SlotClass) {
/* 304 */         ((SlotClass)second).setDirectDefaultInitargs(first);
/* 305 */         return first;
/*     */       } 
/* 307 */       return Lisp.type_error(second, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */   
/*     */   @DocString(name = "%class-default-initargs")
/* 312 */   private static final Primitive CLASS_DEFAULT_INITARGS = new pf__class_default_initargs();
/*     */   
/*     */   private static final class pf__class_default_initargs
/*     */     extends Primitive
/*     */   {
/*     */     pf__class_default_initargs() {
/* 318 */       super("%class-default-initargs", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 323 */       if (arg instanceof SlotClass)
/* 324 */         return ((SlotClass)arg).getDefaultInitargs(); 
/* 325 */       if (arg instanceof BuiltInClass)
/* 326 */         return Lisp.NIL; 
/* 327 */       return Lisp.type_error(arg, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */   
/*     */   @DocString(name = "%set-class-default-initargs")
/* 332 */   private static final Primitive _SET_CLASS_DEFAULT_INITARGS = new pf__set_class_default_initargs();
/*     */ 
/*     */   
/*     */   private static final class pf__set_class_default_initargs
/*     */     extends Primitive
/*     */   {
/*     */     pf__set_class_default_initargs() {
/* 339 */       super("%set-class-default-initargs", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 344 */       if (second instanceof SlotClass) {
/* 345 */         ((SlotClass)second).setDefaultInitargs(first);
/* 346 */         return first;
/*     */       } 
/* 348 */       return Lisp.type_error(second, Symbol.STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SlotClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */