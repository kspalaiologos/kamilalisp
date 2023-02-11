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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class FuncallableStandardObject
/*     */   extends StandardObject
/*     */ {
/*     */   LispObject function;
/*  47 */   EMFCache cache = new EMFCache();
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected FuncallableStandardObject() {}
/*     */ 
/*     */ 
/*     */   
/*     */   protected FuncallableStandardObject(Layout layout) {
/*  57 */     this(layout, layout.getLength());
/*     */   }
/*     */ 
/*     */   
/*     */   protected FuncallableStandardObject(Layout layout, int length) {
/*  62 */     super(layout, length);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected FuncallableStandardObject(LispClass cls, int length) {
/*  68 */     super(cls, length);
/*     */   }
/*     */ 
/*     */   
/*     */   protected FuncallableStandardObject(LispClass cls) {
/*  73 */     super(cls);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  79 */     if (type == Symbol.COMPILED_FUNCTION) {
/*     */       
/*  81 */       if (this.function != null) {
/*  82 */         return this.function.typep(type);
/*     */       }
/*  84 */       return Lisp.NIL;
/*     */     } 
/*  86 */     if (type == Symbol.FUNCALLABLE_STANDARD_OBJECT)
/*  87 */       return Lisp.T; 
/*  88 */     if (type == StandardClass.FUNCALLABLE_STANDARD_OBJECT)
/*  89 */       return Lisp.T; 
/*  90 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/*  96 */     return this.function.execute();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 102 */     return this.function.execute(arg);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 109 */     return this.function.execute(first, second);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 117 */     return this.function.execute(first, second, third);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 125 */     return this.function.execute(first, second, third, fourth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 134 */     return this.function.execute(first, second, third, fourth, fifth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 144 */     return this.function.execute(first, second, third, fourth, fifth, sixth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 155 */     return this.function.execute(first, second, third, fourth, fifth, sixth, seventh);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 166 */     return this.function.execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 173 */     return this.function.execute(args);
/*     */   }
/*     */   
/* 176 */   private static final Primitive _ALLOCATE_FUNCALLABLE_INSTANCE = new pf__allocate_funcallable_instance();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "%allocate-funcallable-instance", args = "class", returns = "instance")
/*     */   private static final class pf__allocate_funcallable_instance
/*     */     extends Primitive
/*     */   {
/*     */     pf__allocate_funcallable_instance() {
/* 185 */       super("%allocate-funcallable-instance", Lisp.PACKAGE_SYS, true, "class");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 190 */       if (arg.typep(StandardClass.FUNCALLABLE_STANDARD_CLASS) != Lisp.NIL) {
/* 191 */         LispObject l = Symbol.CLASS_LAYOUT.execute(arg);
/* 192 */         if (!(l instanceof Layout)) {
/* 193 */           return Lisp.program_error("Invalid standard class layout for: " + arg
/* 194 */               .princToString() + ".");
/*     */         }
/* 196 */         return new FuncallableStandardObject((Layout)l);
/*     */       } 
/* 198 */       return Lisp.type_error(arg, Symbol.FUNCALLABLE_STANDARD_CLASS);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 203 */   private static final Primitive SET_FUNCALLABLE_INSTANCE_FUNCTION = new pf_set_funcallable_instance_function();
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "set-funcallable-instance-function", args = "funcallable-instance function", returns = "unspecified")
/*     */   private static final class pf_set_funcallable_instance_function
/*     */     extends Primitive
/*     */   {
/*     */     pf_set_funcallable_instance_function() {
/* 212 */       super("set-funcallable-instance-function", Lisp.PACKAGE_MOP, true, "funcallable-instance function");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 218 */       (FuncallableStandardObject.checkFuncallableStandardObject(first)).function = second;
/* 219 */       return second;
/*     */     }
/*     */   }
/*     */   
/* 223 */   private static final Primitive FUNCALLABLE_INSTANCE_FUNCTION = new pf_funcallable_instance_function();
/*     */   private int callCount;
/*     */   private int hotCount;
/*     */   
/*     */   @DocString(name = "funcallable-instance-function", args = "funcallable-instance", returns = "function")
/*     */   private static final class pf_funcallable_instance_function
/*     */     extends Primitive
/*     */   {
/*     */     pf_funcallable_instance_function() {
/* 232 */       super("funcallable-instance-function", Lisp.PACKAGE_MOP, false, "funcallable-instance");
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 238 */       return (FuncallableStandardObject.checkFuncallableStandardObject(arg)).function;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getCallCount() {
/* 250 */     return this.callCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCallCount(int n) {
/* 256 */     this.callCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementCallCount() {
/* 262 */     this.callCount++;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final int getHotCount() {
/* 268 */     return this.hotCount;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setHotCount(int n) {
/* 274 */     this.hotCount = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void incrementHotCount() {
/* 280 */     this.hotCount++;
/*     */   }
/*     */ 
/*     */   
/*     */   public static final FuncallableStandardObject checkFuncallableStandardObject(LispObject obj) {
/* 285 */     if (obj instanceof FuncallableStandardObject)
/* 286 */       return (FuncallableStandardObject)obj; 
/* 287 */     return 
/* 288 */       (FuncallableStandardObject)Lisp.type_error(obj, Symbol.FUNCALLABLE_STANDARD_OBJECT);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FuncallableStandardObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */