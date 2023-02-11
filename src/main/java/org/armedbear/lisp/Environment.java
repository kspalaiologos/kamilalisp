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
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Environment
/*     */   extends LispObject
/*     */   implements Serializable
/*     */ {
/*     */   Binding vars;
/*     */   FunctionBinding lastFunctionBinding;
/*     */   private Binding blocks;
/*     */   private Binding tags;
/*     */   public boolean inactive;
/*     */   
/*     */   public Environment() {}
/*     */   
/*     */   public Environment(Environment parent) {
/*  52 */     if (parent != null) {
/*     */       
/*  54 */       this.vars = parent.vars;
/*  55 */       this.lastFunctionBinding = parent.lastFunctionBinding;
/*  56 */       this.blocks = parent.blocks;
/*  57 */       this.tags = parent.tags;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Environment(Environment parent, Symbol symbol, LispObject value) {
/*  65 */     this(parent);
/*  66 */     this.vars = new Binding(symbol, value, this.vars);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  72 */     return Symbol.ENVIRONMENT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  78 */     return BuiltInClass.ENVIRONMENT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  84 */     if (type == Symbol.ENVIRONMENT)
/*  85 */       return Lisp.T; 
/*  86 */     if (type == BuiltInClass.ENVIRONMENT)
/*  87 */       return Lisp.T; 
/*  88 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean isEmpty() {
/*  93 */     if (this.lastFunctionBinding != null)
/*  94 */       return false; 
/*  95 */     if (this.vars != null)
/*     */     {
/*  97 */       for (Binding binding = this.vars; binding != null; binding = binding.next) {
/*  98 */         if (!binding.specialp)
/*  99 */           return false; 
/*     */       }  } 
/* 101 */     return true;
/*     */   }
/*     */ 
/*     */   
/*     */   public void bind(Symbol symbol, LispObject value) {
/* 106 */     this.vars = new Binding(symbol, value, this.vars);
/*     */   }
/*     */ 
/*     */   
/*     */   public void rebind(Symbol symbol, LispObject value) {
/* 111 */     Binding binding = getBinding(symbol);
/* 112 */     binding.value = value;
/*     */   }
/*     */   
/*     */   public LispObject lookup(LispObject symbol, Binding binding) {
/* 116 */     while (binding != null) {
/* 117 */       if (binding.symbol == symbol)
/* 118 */         return binding.value; 
/* 119 */       binding = binding.next;
/*     */     } 
/* 121 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject lookup(LispObject symbol) {
/* 126 */     return lookup(symbol, this.vars);
/*     */   }
/*     */   
/*     */   public Binding getBinding(LispObject symbol) {
/* 130 */     return getBinding(symbol, this.vars);
/*     */   }
/*     */   
/*     */   public Binding getBinding(LispObject symbol, Binding binding) {
/* 134 */     while (binding != null) {
/* 135 */       if (binding.symbol == symbol)
/* 136 */         return binding; 
/* 137 */       binding = binding.next;
/*     */     } 
/* 139 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void addFunctionBinding(LispObject name, LispObject value) {
/* 145 */     this.lastFunctionBinding = new FunctionBinding(name, value, this.lastFunctionBinding);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject lookupFunction(LispObject name) {
/* 152 */     FunctionBinding binding = this.lastFunctionBinding;
/* 153 */     if (name instanceof Symbol) {
/*     */       
/* 155 */       while (binding != null) {
/*     */         
/* 157 */         if (binding.name == name)
/* 158 */           return binding.value; 
/* 159 */         binding = binding.next;
/*     */       } 
/*     */       
/* 162 */       return name.getSymbolFunction();
/*     */     } 
/* 164 */     if (name instanceof Cons)
/*     */     {
/* 166 */       while (binding != null) {
/*     */         
/* 168 */         if (binding.name.equal(name))
/* 169 */           return binding.value; 
/* 170 */         binding = binding.next;
/*     */       } 
/*     */     }
/* 173 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public void addBlock(LispObject symbol, LispObject block) {
/* 178 */     this.blocks = new Binding(symbol, this, block, this.blocks);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject lookupBlock(LispObject symbol) {
/* 183 */     Binding binding = this.blocks;
/* 184 */     while (binding != null) {
/*     */       
/* 186 */       if (binding.symbol == symbol)
/* 187 */         return binding.value; 
/* 188 */       binding = binding.next;
/*     */     } 
/* 190 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public Binding getBlockBinding(LispObject block) {
/* 195 */     Binding binding = this.blocks;
/* 196 */     while (binding != null) {
/*     */       
/* 198 */       if (binding.symbol == block)
/* 199 */         return binding; 
/* 200 */       binding = binding.next;
/*     */     } 
/* 202 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public void addTagBinding(LispObject tag, LispObject code) {
/* 207 */     this.tags = new Binding(tag, this, code, this.tags);
/*     */   }
/*     */ 
/*     */   
/*     */   public Binding getTagBinding(LispObject tag) {
/* 212 */     Binding binding = this.tags;
/* 213 */     while (binding != null) {
/*     */       
/* 215 */       if (binding.symbol.eql(tag))
/* 216 */         return binding; 
/* 217 */       binding = binding.next;
/*     */     } 
/* 219 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject processDeclarations(LispObject body) {
/* 226 */     LispObject bodyAndDecls = Lisp.parseBody(body, false);
/* 227 */     LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/* 228 */     for (; specials != Lisp.NIL; specials = specials.cdr()) {
/* 229 */       declareSpecial(Lisp.checkSymbol(specials.car()));
/*     */     }
/* 231 */     return bodyAndDecls.car();
/*     */   }
/*     */ 
/*     */   
/*     */   public void declareSpecial(Symbol var) {
/* 236 */     this.vars = new Binding(var, null, this.vars);
/* 237 */     this.vars.specialp = true;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isDeclaredSpecial(Symbol var) {
/* 247 */     Binding binding = getBinding(var);
/* 248 */     return (binding != null) ? binding.specialp : (
/* 249 */       (LispThread.currentThread().getSpecialBinding(var) != null));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 255 */     return unreadableString("ENVIRONMENT");
/*     */   }
/*     */ 
/*     */   
/* 259 */   public static final Primitive MAKE_ENVIRONMENT = new Primitive("make-environment", Lisp.PACKAGE_SYS, true, "&optional parent-environment")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 266 */         return new Environment();
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 271 */         if (arg == Lisp.NIL)
/* 272 */           return new Environment(); 
/* 273 */         return new Environment(Lisp.checkEnvironment(arg));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 278 */   public static final Primitive ENVIRONMENT_ADD_MACRO_DEFINITION = new Primitive("environment-add-macro-definition", Lisp.PACKAGE_SYS, true, "environment name expander")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 287 */         Environment env = Lisp.checkEnvironment(first);
/* 288 */         LispObject name = second;
/* 289 */         LispObject expander = third;
/* 290 */         env.addFunctionBinding(name, expander);
/* 291 */         return env;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 296 */   public static final Primitive ENVIRONMENT_ADD_FUNCTION_DEFINITION = new Primitive("environment-add-function-definition", Lisp.PACKAGE_SYS, true, "environment name lambda-expression")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 305 */         Lisp.checkEnvironment(first).addFunctionBinding(second, third);
/* 306 */         return first;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 311 */   public static final Primitive ENVIRONMENT_ADD_SYMBOL_BINDING = new Primitive("environment-add-symbol-binding", Lisp.PACKAGE_SYS, true, "environment symbol value")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*     */       {
/* 320 */         Lisp.checkEnvironment(first).bind(Lisp.checkSymbol(second), third);
/* 321 */         return first;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 326 */   private static final Primitive EMPTY_ENVIRONMENT_P = new Primitive("empty-environment-p", Lisp.PACKAGE_SYS, true, "environment")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 332 */         return Lisp.checkEnvironment(arg).isEmpty() ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 337 */   private static final Primitive ENVIRONMENT_VARS = new Primitive("environment-variables", Lisp.PACKAGE_SYS, true, "environment")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 343 */         Environment env = Lisp.checkEnvironment(arg);
/* 344 */         LispObject result = Lisp.NIL;
/* 345 */         for (Binding binding = env.vars; binding != null; binding = binding.next) {
/* 346 */           if (!binding.specialp)
/* 347 */             result = result.push(new Cons(binding.symbol, binding.value)); 
/* 348 */         }  return result.nreverse();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 353 */   private static final Primitive ENVIRONMENT_ALL_VARS = new Primitive("environment-all-variables", Lisp.PACKAGE_SYS, true, "environment")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 359 */         Environment env = Lisp.checkEnvironment(arg);
/* 360 */         LispObject result = Lisp.NIL;
/* 361 */         Binding binding = env.vars;
/* 362 */         for (; binding != null; binding = binding.next) {
/* 363 */           if (binding.specialp)
/* 364 */           { result = result.push(binding.symbol); }
/*     */           else
/* 366 */           { result = result.push(new Cons(binding.symbol, binding.value)); } 
/* 367 */         }  return result.nreverse();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 372 */   private static final Primitive ENVIRONMENT_ALL_FUNS = new Primitive("environment-all-functions", Lisp.PACKAGE_SYS, true, "environment")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 378 */         Environment env = Lisp.checkEnvironment(arg);
/* 379 */         LispObject result = Lisp.NIL;
/* 380 */         FunctionBinding binding = env.lastFunctionBinding;
/* 381 */         for (; binding != null; binding = binding.next)
/* 382 */           result = result.push(new Cons(binding.name, binding.value)); 
/* 383 */         return result.nreverse();
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Environment.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */