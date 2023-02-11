/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.concurrent.ConcurrentHashMap;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class Layout
/*     */   extends LispObject
/*     */ {
/*     */   private final LispObject lispClass;
/*     */   public final ConcurrentHashMap<LispObject, LispObject> slotTable;
/*     */   final LispObject[] slotNames;
/*     */   final LispObject sharedSlots;
/*     */   private boolean invalid;
/*     */   
/*     */   public Layout(LispObject lispClass, LispObject instanceSlots, LispObject sharedSlots) {
/*  51 */     this.lispClass = lispClass;
/*  52 */     Debug.assertTrue(instanceSlots.listp());
/*  53 */     int length = instanceSlots.length();
/*  54 */     this.slotNames = new LispObject[length];
/*  55 */     int i = 0;
/*     */     
/*  57 */     while (instanceSlots != Lisp.NIL) {
/*     */       
/*  59 */       this.slotNames[i++] = instanceSlots.car();
/*  60 */       instanceSlots = instanceSlots.cdr();
/*     */     } 
/*     */     
/*  63 */     Debug.assertTrue((i == length));
/*  64 */     this.sharedSlots = sharedSlots;
/*  65 */     this.slotTable = initializeSlotTable(this.slotNames);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Layout(LispObject lispClass, LispObject[] instanceSlotNames, LispObject sharedSlots) {
/*  71 */     this.lispClass = lispClass;
/*  72 */     this.slotNames = instanceSlotNames;
/*  73 */     this.sharedSlots = sharedSlots;
/*  74 */     this.slotTable = initializeSlotTable(this.slotNames);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   Layout(Layout oldLayout) {
/*  80 */     this.lispClass = oldLayout.getLispClass();
/*  81 */     this.slotNames = oldLayout.slotNames;
/*  82 */     this.sharedSlots = oldLayout.sharedSlots;
/*  83 */     this.slotTable = initializeSlotTable(this.slotNames);
/*     */   }
/*     */ 
/*     */   
/*     */   private ConcurrentHashMap initializeSlotTable(LispObject[] slotNames) {
/*  88 */     ConcurrentHashMap<Object, Object> ht = new ConcurrentHashMap<>(slotNames.length);
/*  89 */     for (int i = slotNames.length; i-- > 0;)
/*  90 */       ht.put(slotNames[i], Fixnum.getInstance(i)); 
/*  91 */     return ht;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/*  97 */     LispObject result = Lisp.NIL;
/*  98 */     result = result.push(new Cons("class", getLispClass()));
/*  99 */     for (int i = 0; i < this.slotNames.length; i++)
/*     */     {
/* 101 */       result = result.push(new Cons("slot " + i, this.slotNames[i]));
/*     */     }
/* 103 */     result = result.push(new Cons("shared slots", this.sharedSlots));
/* 104 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getLispClass() {
/* 109 */     return this.lispClass;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isInvalid() {
/* 114 */     return this.invalid;
/*     */   }
/*     */ 
/*     */   
/*     */   public void invalidate() {
/* 119 */     this.invalid = true;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject[] getSlotNames() {
/* 124 */     return this.slotNames;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getLength() {
/* 129 */     return this.slotNames.length;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getSharedSlots() {
/* 134 */     return this.sharedSlots;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 140 */     return unreadableString("LAYOUT");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected LispObject generateSlotDefinitions() {
/* 146 */     LispObject list = Lisp.NIL;
/* 147 */     for (int i = this.slotNames.length; i-- > 0;) {
/* 148 */       list = list.push(new SlotDefinition(this.slotNames[i], Lisp.NIL));
/*     */     }
/* 150 */     return list;
/*     */   }
/*     */ 
/*     */   
/* 154 */   private static final Primitive MAKE_LAYOUT = new Primitive("make-layout", Lisp.PACKAGE_SYS, true, "class instance-slots class-slots")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 163 */         return new Layout(first, Lisp.checkList(second), Lisp.checkList(third));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 169 */   private static final Primitive LAYOUT_CLASS = new Primitive("layout-class", Lisp.PACKAGE_SYS, true, "layout")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 175 */         return Lisp.checkLayout(arg).getLispClass();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 180 */   private static final Primitive LAYOUT_LENGTH = new Primitive("layout-length", Lisp.PACKAGE_SYS, true, "layout")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 186 */         return Fixnum.getInstance((Lisp.checkLayout(arg)).slotNames.length);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*     */   public int getSlotIndex(LispObject slotName) {
/* 192 */     LispObject index = this.slotTable.get(slotName);
/* 193 */     if (index != null)
/* 194 */       return ((Fixnum)index).value; 
/* 195 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getSharedSlotLocation(LispObject slotName) {
/* 201 */     LispObject rest = this.sharedSlots;
/* 202 */     while (rest != Lisp.NIL) {
/*     */       
/* 204 */       LispObject location = rest.car();
/* 205 */       if (location.car() == slotName)
/* 206 */         return location; 
/* 207 */       rest = rest.cdr();
/*     */     } 
/* 209 */     return null;
/*     */   }
/*     */ 
/*     */   
/* 213 */   private static final Primitive LAYOUT_SLOT_INDEX = new Primitive("layout-slot-index", Lisp.PACKAGE_SYS, true)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 220 */         LispObject[] slotNames = (Lisp.checkLayout(first)).slotNames;
/* 221 */         for (int i = slotNames.length; i-- > 0;) {
/*     */           
/* 223 */           if (slotNames[i] == second)
/* 224 */             return Fixnum.getInstance(i); 
/*     */         } 
/* 226 */         return Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 231 */   private static final Primitive LAYOUT_SLOT_LOCATION = new Primitive("layout-slot-location", Lisp.PACKAGE_SYS, true, "layout slot-name")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 238 */         Layout layOutFirst = Lisp.checkLayout(first);
/* 239 */         LispObject[] slotNames = layOutFirst.slotNames;
/* 240 */         int limit = slotNames.length;
/* 241 */         for (int i = 0; i < limit; i++) {
/*     */           
/* 243 */           if (slotNames[i] == second) {
/* 244 */             return Fixnum.getInstance(i);
/*     */           }
/*     */         } 
/* 247 */         LispObject rest = layOutFirst.sharedSlots;
/* 248 */         while (rest != Lisp.NIL) {
/*     */           
/* 250 */           LispObject location = rest.car();
/* 251 */           if (location.car() == second)
/* 252 */             return location; 
/* 253 */           rest = rest.cdr();
/*     */         } 
/* 255 */         return Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 260 */   private static final Primitive _MAKE_INSTANCES_OBSOLETE = new Primitive("%make-instances-obsolete", Lisp.PACKAGE_SYS, true, "class")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 266 */         LispObject oldLayout, lispClass = arg;
/*     */ 
/*     */ 
/*     */         
/* 270 */         if (lispClass instanceof LispClass) {
/* 271 */           if (!((LispClass)lispClass).isFinalized())
/* 272 */             return arg; 
/* 273 */           oldLayout = ((LispClass)lispClass).getClassLayout();
/* 274 */         } else if (lispClass instanceof StandardObject) {
/* 275 */           if (((StandardObject)arg)
/* 276 */             .getInstanceSlotValue(StandardClass.symFinalizedP) == Lisp.NIL)
/* 277 */             return arg; 
/* 278 */           oldLayout = Symbol.CLASS_LAYOUT.execute(lispClass);
/*     */         } else {
/* 280 */           return Lisp.type_error(arg, Symbol.CLASS);
/*     */         } 
/*     */         
/* 283 */         Layout newLayout = new Layout((Layout)oldLayout);
/* 284 */         if (lispClass instanceof LispClass) {
/* 285 */           ((LispClass)lispClass).setClassLayout(newLayout);
/*     */         } else {
/* 287 */           Symbol.CLASS_LAYOUT.getSymbolSetfFunction()
/* 288 */             .execute(newLayout, lispClass);
/* 289 */         }  ((Layout)oldLayout).invalidate();
/* 290 */         return arg;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Layout.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */