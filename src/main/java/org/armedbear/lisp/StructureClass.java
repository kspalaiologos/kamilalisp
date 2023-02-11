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
/*     */ public class StructureClass
/*     */   extends SlotClass
/*     */ {
/*     */   StructureClass(Symbol symbol) {
/*  42 */     super(symbol, new Cons(BuiltInClass.STRUCTURE_OBJECT));
/*     */   }
/*     */ 
/*     */   
/*     */   public StructureClass(Symbol symbol, LispObject directSuperclasses) {
/*  47 */     super(symbol, directSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  53 */     return Symbol.STRUCTURE_CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  59 */     return LispClass.findClass(Symbol.STRUCTURE_CLASS);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  65 */     if (type == Symbol.STRUCTURE_CLASS)
/*  66 */       return Lisp.T; 
/*  67 */     if (type == LispClass.findClass(Symbol.STRUCTURE_CLASS))
/*  68 */       return Lisp.T; 
/*  69 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/*  75 */     return new SimpleString(princToString());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  81 */     StringBuilder sb = new StringBuilder("STRUCTURE-CLASS ");
/*  82 */     sb.append(getName().princToString());
/*  83 */     return unreadableString(sb.toString(), false);
/*     */   }
/*     */ 
/*     */   
/*  87 */   private static final Primitive MAKE_STRUCTURE_CLASS = new Primitive("make-structure-class", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth)
/*     */       {
/*  95 */         Symbol symbol = Lisp.checkSymbol(first);
/*  96 */         LispClass existingClass = LispClass.findClass(symbol);
/*     */         
/*  98 */         if (existingClass instanceof StructureClass)
/*     */         {
/*     */ 
/*     */ 
/*     */ 
/*     */           
/* 104 */           return existingClass;
/*     */         }
/*     */ 
/*     */         
/* 108 */         LispObject directSlots = Lisp.checkList(second);
/* 109 */         LispObject slots = Lisp.checkList(third);
/* 110 */         Symbol include = Lisp.checkSymbol(fourth);
/*     */         
/* 112 */         StructureClass c = new StructureClass(symbol);
/* 113 */         if (include != Lisp.NIL) {
/* 114 */           LispClass includedClass = LispClass.findClass(include);
/* 115 */           if (includedClass == null) {
/* 116 */             return Lisp.error(new SimpleError("Class " + include + " is undefined."));
/*     */           }
/* 118 */           c.setCPL(new LispObject[] { new Cons(c, includedClass.getCPL()) });
/*     */         } else {
/* 120 */           c.setCPL(new LispObject[] { c, BuiltInClass.STRUCTURE_OBJECT, BuiltInClass.CLASS_T });
/* 121 */         }  c.setDirectSlotDefinitions(directSlots);
/* 122 */         c.setSlotDefinitions(slots);
/* 123 */         c.setFinalized(true);
/* 124 */         LispClass.addClass(symbol, c);
/* 125 */         return c;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StructureClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */