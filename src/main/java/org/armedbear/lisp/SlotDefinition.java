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
/*     */ public final class SlotDefinition
/*     */   extends StandardObject
/*     */ {
/*     */   private SlotDefinition() {
/*  42 */     super(StandardClass.STANDARD_SLOT_DEFINITION, StandardClass.STANDARD_SLOT_DEFINITION
/*  43 */         .getClassLayout().getLength());
/*  44 */     setInstanceSlotValue(Symbol.LOCATION, Lisp.NIL);
/*  45 */     setInstanceSlotValue(Symbol._TYPE, Lisp.T);
/*  46 */     setInstanceSlotValue(Symbol._DOCUMENTATION, Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private SlotDefinition(StandardClass clazz) {
/*  52 */     super(clazz, clazz.getClassLayout().getLength());
/*  53 */     setInstanceSlotValue(Symbol.LOCATION, Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotDefinition(StandardClass clazz, LispObject name) {
/*  59 */     super(clazz, clazz.getClassLayout().getLength());
/*  60 */     Debug.assertTrue(name instanceof Symbol);
/*  61 */     setInstanceSlotValue(Symbol.NAME, name);
/*  62 */     setInstanceSlotValue(Symbol.INITFUNCTION, Lisp.NIL);
/*  63 */     setInstanceSlotValue(Symbol.INITARGS, new Cons(Lisp.PACKAGE_KEYWORD
/*  64 */           .intern(((Symbol)name).getName())));
/*  65 */     setInstanceSlotValue(Symbol.READERS, Lisp.NIL);
/*  66 */     setInstanceSlotValue(Symbol.ALLOCATION, Keyword.INSTANCE);
/*  67 */     setInstanceSlotValue(Symbol.LOCATION, Lisp.NIL);
/*  68 */     setInstanceSlotValue(Symbol._TYPE, Lisp.T);
/*  69 */     setInstanceSlotValue(Symbol._DOCUMENTATION, Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public SlotDefinition(LispObject name, LispObject readers) {
/*  74 */     this();
/*  75 */     Debug.assertTrue(name instanceof Symbol);
/*  76 */     setInstanceSlotValue(Symbol.NAME, name);
/*  77 */     setInstanceSlotValue(Symbol.INITFUNCTION, Lisp.NIL);
/*  78 */     setInstanceSlotValue(Symbol.INITARGS, new Cons(Lisp.PACKAGE_KEYWORD
/*  79 */           .intern(((Symbol)name).getName())));
/*  80 */     setInstanceSlotValue(Symbol.READERS, readers);
/*  81 */     setInstanceSlotValue(Symbol.ALLOCATION, Keyword.INSTANCE);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotDefinition(LispObject name, LispObject readers, LispObject initForm) {
/*  87 */     this();
/*  88 */     Debug.assertTrue(name instanceof Symbol);
/*  89 */     setInstanceSlotValue(Symbol.NAME, name);
/*  90 */     setInstanceSlotValue(Symbol.INITFUNCTION, Lisp.NIL);
/*  91 */     setInstanceSlotValue(Symbol.INITFORM, initForm);
/*  92 */     setInstanceSlotValue(Symbol.INITARGS, new Cons(Lisp.PACKAGE_KEYWORD
/*  93 */           .intern(((Symbol)name).getName())));
/*  94 */     setInstanceSlotValue(Symbol.READERS, readers);
/*  95 */     setInstanceSlotValue(Symbol.ALLOCATION, Keyword.INSTANCE);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotDefinition(LispObject name, LispObject readers, Function initFunction) {
/* 101 */     this();
/* 102 */     Debug.assertTrue(name instanceof Symbol);
/* 103 */     setInstanceSlotValue(Symbol.NAME, name);
/* 104 */     setInstanceSlotValue(Symbol.INITFUNCTION, initFunction);
/* 105 */     setInstanceSlotValue(Symbol.INITFORM, Lisp.NIL);
/* 106 */     setInstanceSlotValue(Symbol.INITARGS, new Cons(Lisp.PACKAGE_KEYWORD
/* 107 */           .intern(((Symbol)name).getName())));
/* 108 */     setInstanceSlotValue(Symbol.READERS, readers);
/* 109 */     setInstanceSlotValue(Symbol.ALLOCATION, Keyword.INSTANCE);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SlotDefinition(LispObject name, LispObject readers, Function initFunction, LispObject initargs) {
/* 115 */     this();
/* 116 */     Debug.assertTrue(name instanceof Symbol);
/* 117 */     setInstanceSlotValue(Symbol.NAME, name);
/* 118 */     setInstanceSlotValue(Symbol.INITFUNCTION, initFunction);
/* 119 */     setInstanceSlotValue(Symbol.INITFORM, Lisp.NIL);
/* 120 */     setInstanceSlotValue(Symbol.INITARGS, initargs);
/* 121 */     setInstanceSlotValue(Symbol.READERS, readers);
/* 122 */     setInstanceSlotValue(Symbol.ALLOCATION, Keyword.INSTANCE);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 129 */     StringBuilder sb = new StringBuilder(Symbol.SLOT_DEFINITION.printObject());
/* 130 */     LispObject name = getInstanceSlotValue(Symbol.NAME);
/* 131 */     if (name != null && name != Lisp.NIL) {
/* 132 */       sb.append(' ');
/* 133 */       sb.append(name.printObject());
/*     */     } 
/* 135 */     return unreadableString(sb.toString());
/*     */   }
/*     */   
/* 138 */   private static final Primitive MAKE_SLOT_DEFINITION = new pf_make_slot_definition();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%make-slot-definition", args = "slot-class", doc = "Argument must be a subclass of standard-slot-definition")
/*     */   private static final class pf_make_slot_definition
/*     */     extends Primitive
/*     */   {
/*     */     pf_make_slot_definition() {
/* 147 */       super("%make-slot-definition", Lisp.PACKAGE_SYS, true, "slot-class");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject slotDefinitionClass) {
/* 152 */       if (!(slotDefinitionClass instanceof StandardClass)) {
/* 153 */         return Lisp.type_error(slotDefinitionClass, StandardClass.STANDARD_SLOT_DEFINITION);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/* 158 */       return new SlotDefinition((StandardClass)slotDefinitionClass);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SlotDefinition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */