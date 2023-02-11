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
/*     */ public abstract class LispClass
/*     */   extends StandardObject
/*     */ {
/*  41 */   private static final ConcurrentHashMap<Symbol, LispObject> map = new ConcurrentHashMap<>();
/*     */   private final int sxhash;
/*     */   private LispObject name;
/*     */   
/*     */   public static <T extends LispClass> T addClass(Symbol symbol, T c) {
/*  46 */     map.put(symbol, (LispObject)c);
/*  47 */     return c;
/*     */   }
/*     */   private LispObject propertyList; private Layout classLayout;
/*     */   
/*     */   public static LispObject addClass(Symbol symbol, LispObject c) {
/*  52 */     map.put(symbol, c);
/*  53 */     return c;
/*     */   }
/*     */ 
/*     */   
/*     */   public static void removeClass(Symbol symbol) {
/*  58 */     map.remove(symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispClass findClass(Symbol symbol) {
/*  63 */     return (LispClass)map.get(symbol);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static LispObject findClass(LispObject name, boolean errorp) {
/*  69 */     Symbol symbol = Lisp.checkSymbol(name);
/*     */     
/*  71 */     LispObject c = map.get(symbol);
/*  72 */     if (c != null)
/*  73 */       return c; 
/*  74 */     if (errorp) {
/*     */       
/*  76 */       StringBuilder sb = new StringBuilder("There is no class named ");
/*     */       
/*  78 */       sb.append(name.princToString());
/*  79 */       sb.append('.');
/*  80 */       return Lisp.error(new LispError(sb.toString()));
/*     */     } 
/*  82 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  90 */   private LispObject directSuperclasses = Lisp.NIL;
/*  91 */   private LispObject directSubclasses = Lisp.NIL;
/*  92 */   private LispObject classPrecedenceList = Lisp.NIL;
/*  93 */   private LispObject directMethods = Lisp.NIL;
/*  94 */   private LispObject documentation = Lisp.NIL;
/*     */   
/*     */   private boolean finalized;
/*     */   
/*     */   protected LispClass(Layout layout) {
/*  99 */     super(layout, (layout == null) ? 0 : layout.getLength());
/* 100 */     this.sxhash = hashCode() & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */   
/*     */   protected LispClass(Symbol symbol) {
/* 105 */     this(null, symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   protected LispClass(Layout layout, Symbol symbol) {
/* 110 */     super(layout, (layout == null) ? 0 : layout.getLength());
/* 111 */     setName(symbol);
/* 112 */     this.sxhash = hashCode() & Integer.MAX_VALUE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected LispClass(Layout layout, Symbol symbol, LispObject directSuperclasses) {
/* 118 */     super(layout, (layout == null) ? 0 : layout.getLength());
/* 119 */     this.sxhash = hashCode() & Integer.MAX_VALUE;
/* 120 */     setName(symbol);
/* 121 */     setDirectSuperclasses(directSuperclasses);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 127 */     LispObject result = Lisp.NIL;
/* 128 */     result = result.push(new Cons("NAME", (this.name != null) ? this.name : Lisp.NIL));
/* 129 */     result = result.push(new Cons("LAYOUT", 
/* 130 */           (getClassLayout() != null) ? 
/* 131 */           getClassLayout() : Lisp.NIL));
/* 132 */     result = result.push(new Cons("DIRECT-SUPERCLASSES", 
/* 133 */           getDirectSuperclasses()));
/* 134 */     result = result.push(new Cons("DIRECT-SUBCLASSES", getDirectSubclasses()));
/* 135 */     result = result.push(new Cons("CLASS-PRECEDENCE-LIST", getCPL()));
/* 136 */     result = result.push(new Cons("DIRECT-METHODS", getDirectMethods()));
/* 137 */     result = result.push(new Cons("DOCUMENTATION", getDocumentation()));
/* 138 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int sxhash() {
/* 144 */     return this.sxhash;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getName() {
/* 149 */     return this.name;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setName(LispObject name) {
/* 154 */     this.name = name;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getPropertyList() {
/* 160 */     if (this.propertyList == null)
/* 161 */       this.propertyList = Lisp.NIL; 
/* 162 */     return this.propertyList;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setPropertyList(LispObject obj) {
/* 168 */     if (obj == null)
/* 169 */       throw new NullPointerException(); 
/* 170 */     this.propertyList = obj;
/*     */   }
/*     */ 
/*     */   
/*     */   public Layout getClassLayout() {
/* 175 */     return this.classLayout;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setClassLayout(LispObject layout) {
/* 180 */     this.classLayout = (layout == Lisp.NIL) ? null : (Layout)layout;
/*     */   }
/*     */ 
/*     */   
/*     */   public final int getLayoutLength() {
/* 185 */     if (this.layout == null)
/* 186 */       return 0; 
/* 187 */     return this.layout.getLength();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDirectSuperclasses() {
/* 192 */     return this.directSuperclasses;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDirectSuperclasses(LispObject directSuperclasses) {
/* 197 */     this.directSuperclasses = directSuperclasses;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isFinalized() {
/* 202 */     return this.finalized;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setFinalized(boolean b) {
/* 207 */     this.finalized = b;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setDirectSuperclass(LispObject superclass) {
/* 213 */     setDirectSuperclasses(new Cons(superclass));
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDirectSubclasses() {
/* 218 */     return this.directSubclasses;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDirectSubclasses(LispObject directSubclasses) {
/* 223 */     this.directSubclasses = directSubclasses;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getCPL() {
/* 228 */     return this.classPrecedenceList;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setCPL(LispObject... cpl) {
/* 233 */     LispObject obj1 = cpl[0];
/* 234 */     if (obj1 instanceof Cons && cpl.length == 1) {
/* 235 */       this.classPrecedenceList = obj1;
/*     */     } else {
/*     */       
/* 238 */       Debug.assertTrue((obj1 == this));
/* 239 */       LispObject l = Lisp.NIL;
/* 240 */       for (int i = cpl.length; i-- > 0;)
/* 241 */         l = new Cons(cpl[i], l); 
/* 242 */       this.classPrecedenceList = l;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDirectMethods() {
/* 248 */     return this.directMethods;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDirectMethods(LispObject methods) {
/* 253 */     this.directMethods = methods;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getDocumentation() {
/* 258 */     return this.documentation;
/*     */   }
/*     */ 
/*     */   
/*     */   public void setDocumentation(LispObject doc) {
/* 263 */     this.documentation = doc;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 269 */     return Symbol.CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 275 */     return StandardClass.CLASS;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 281 */     if (type == Symbol.CLASS)
/* 282 */       return Lisp.T; 
/* 283 */     if (type == StandardClass.CLASS)
/* 284 */       return Lisp.T; 
/* 285 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean subclassp(LispObject obj) {
/* 290 */     return subclassp(this, obj);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static boolean subclassp(LispObject cls, LispObject obj) {
/*     */     LispObject cpl;
/* 297 */     if (cls instanceof LispClass) {
/* 298 */       cpl = ((LispClass)cls).getCPL();
/*     */     } else {
/* 300 */       cpl = Symbol.CLASS_PRECEDENCE_LIST.execute(cls);
/*     */     } 
/* 302 */     while (cpl != Lisp.NIL) {
/*     */       
/* 304 */       if (cpl.car() == obj)
/* 305 */         return true; 
/* 306 */       cpl = ((Cons)cpl).cdr;
/*     */     } 
/* 308 */     return false;
/*     */   }
/*     */ 
/*     */   
/* 312 */   private static final Primitive FIND_CLASS = new Primitive(Symbol.FIND_CLASS, "symbol &optional errorp environment")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 318 */         return LispClass.findClass(arg, true);
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 324 */         return LispClass.findClass(first, (second != Lisp.NIL));
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 332 */         return LispClass.findClass(first, (second != Lisp.NIL));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 337 */   private static final Primitive _SET_FIND_CLASS = new Primitive("%set-find-class", Lisp.PACKAGE_SYS, true)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 344 */         Symbol name = Lisp.checkSymbol(first);
/* 345 */         if (second == Lisp.NIL) {
/*     */           
/* 347 */           LispClass.removeClass(name);
/* 348 */           return second;
/*     */         } 
/* 350 */         LispClass.addClass(name, second);
/* 351 */         return second;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 356 */   private static final Primitive SUBCLASSP = new Primitive(Symbol.SUBCLASSP, "class")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 363 */         return LispClass.subclassp(first, second) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */