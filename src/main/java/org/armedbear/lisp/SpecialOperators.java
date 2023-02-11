/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.LinkedList;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class SpecialOperators
/*     */ {
/*  42 */   private static final SpecialOperator QUOTE = new sf_quote();
/*     */   
/*     */   private static final class sf_quote extends SpecialOperator { sf_quote() {
/*  45 */       super(Symbol.QUOTE, "thing");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  52 */       if (args.cdr() != Lisp.NIL)
/*  53 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1)); 
/*  54 */       return args.car();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  59 */   private static final SpecialOperator IF = new sf_if();
/*     */   
/*     */   private static final class sf_if extends SpecialOperator { sf_if() {
/*  62 */       super(Symbol.IF, "test then &optional else");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  69 */       LispThread thread = LispThread.currentThread();
/*  70 */       switch (args.length()) {
/*     */         case 2:
/*  72 */           if (Lisp.eval(((Cons)args).car, env, thread) != Lisp.NIL)
/*  73 */             return Lisp.eval(args.cadr(), env, thread); 
/*  74 */           thread.clearValues();
/*  75 */           return Lisp.NIL;
/*     */         
/*     */         case 3:
/*  78 */           if (Lisp.eval(((Cons)args).car, env, thread) != Lisp.NIL)
/*  79 */             return Lisp.eval(args.cadr(), env, thread); 
/*  80 */           return Lisp.eval(((Cons)args).cdr.cadr(), env, thread);
/*     */       } 
/*     */       
/*  83 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 2, 3));
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  89 */   private static final SpecialOperator LET = new sf_let();
/*     */   
/*     */   private static final class sf_let extends SpecialOperator { sf_let() {
/*  92 */       super(Symbol.LET, "bindings &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  99 */       if (args == Lisp.NIL)
/* 100 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 101 */       return SpecialOperators._let(args, env, false);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 106 */   private static final SpecialOperator LET_STAR = new sf_let_star();
/*     */   
/*     */   private static final class sf_let_star extends SpecialOperator { sf_let_star() {
/* 109 */       super(Symbol.LET_STAR, "bindings &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 116 */       if (args == Lisp.NIL)
/* 117 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 118 */       return SpecialOperators._let(args, env, true);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject _let(LispObject args, Environment env, boolean sequential) {
/* 126 */     LispThread thread = LispThread.currentThread();
/* 127 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 128 */     Environment ext = new Environment(env);
/* 129 */     thread.envStack.push(ext);
/*     */     try {
/* 131 */       LispObject varList = Lisp.checkList(args.car());
/* 132 */       LispObject bodyAndDecls = Lisp.parseBody(args.cdr(), false);
/* 133 */       LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/* 134 */       LispObject body = bodyAndDecls.car();
/*     */       
/* 136 */       LinkedList<Cons> nonSequentialVars = new LinkedList<>();
/* 137 */       while (varList != Lisp.NIL) {
/*     */         Symbol symbol;
/*     */         
/* 140 */         LispObject value, obj = varList.car();
/* 141 */         if (obj instanceof Cons) {
/* 142 */           if (obj.length() > 2)
/* 143 */             return Lisp.error(new LispError("The " + (sequential ? "LET*" : "LET") + " binding specification " + obj
/*     */                   
/* 145 */                   .princToString() + " is invalid.")); 
/* 146 */           symbol = Lisp.checkSymbol(((Cons)obj).car);
/* 147 */           value = Lisp.eval(obj.cadr(), sequential ? ext : env, thread);
/*     */         } else {
/* 149 */           symbol = Lisp.checkSymbol(obj);
/* 150 */           value = Lisp.NIL;
/*     */         } 
/* 152 */         if (sequential) {
/* 153 */           ext = new Environment(ext);
/* 154 */           thread.envStack.push(ext);
/* 155 */           Lisp.bindArg(specials, symbol, value, ext, thread);
/*     */         } else {
/* 157 */           nonSequentialVars.add(new Cons(symbol, value));
/* 158 */         }  varList = ((Cons)varList).cdr;
/*     */       } 
/* 160 */       if (!sequential) {
/* 161 */         for (Cons x : nonSequentialVars) {
/* 162 */           Lisp.bindArg(specials, (Symbol)x.car(), x.cdr(), ext, thread);
/*     */         }
/*     */       }
/*     */ 
/*     */ 
/*     */       
/* 168 */       for (; specials != Lisp.NIL; specials = specials.cdr()) {
/* 169 */         ext.declareSpecial((Symbol)specials.car());
/*     */       }
/* 171 */       return Lisp.progn(body, ext, thread);
/*     */     } finally {
/*     */       
/* 174 */       thread.resetSpecialBindings(mark);
/* 175 */       while (thread.envStack.pop() != ext);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/* 180 */   private static final SpecialOperator SYMBOL_MACROLET = new sf_symbol_macrolet();
/*     */   
/*     */   private static final class sf_symbol_macrolet extends SpecialOperator { sf_symbol_macrolet() {
/* 183 */       super(Symbol.SYMBOL_MACROLET, "macrobindings &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 190 */       LispObject varList = Lisp.checkList(args.car());
/* 191 */       LispThread thread = LispThread.currentThread();
/* 192 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/* 193 */       Environment ext = new Environment(env);
/*     */       try {
/* 195 */         thread.envStack.push(ext);
/*     */         
/* 197 */         LispObject body = ext.processDeclarations(args.cdr());
/*     */         
/* 199 */         for (int i = varList.length(); i-- > 0; ) {
/* 200 */           LispObject obj = varList.car();
/* 201 */           varList = varList.cdr();
/* 202 */           if (obj instanceof Cons && obj.length() == 2) {
/* 203 */             Symbol symbol = Lisp.checkSymbol(obj.car());
/* 204 */             if (symbol.isSpecialVariable() || ext
/* 205 */               .isDeclaredSpecial(symbol)) {
/* 206 */               return Lisp.program_error("Attempt to bind the special variable " + symbol
/* 207 */                   .princToString() + " with SYMBOL-MACROLET.");
/*     */             }
/*     */             
/* 210 */             ext.bind(symbol, new SymbolMacro(obj.cadr())); continue;
/*     */           } 
/* 212 */           return Lisp.program_error("Malformed symbol-expansion pair in SYMBOL-MACROLET: " + obj
/* 213 */               .princToString() + ".");
/*     */         } 
/*     */         
/* 216 */         return Lisp.progn(body, ext, thread);
/*     */       } finally {
/*     */         
/* 219 */         thread.resetSpecialBindings(mark);
/* 220 */         while (thread.envStack.pop() != ext);
/*     */       } 
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 226 */   private static final SpecialOperator LOAD_TIME_VALUE = new sf_load_time_value();
/*     */   
/*     */   private static final class sf_load_time_value extends SpecialOperator { sf_load_time_value() {
/* 229 */       super(Symbol.LOAD_TIME_VALUE, "form &optional read-only-p");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 237 */       switch (args.length()) {
/*     */         case 1:
/*     */         case 2:
/* 240 */           return Lisp.eval(args.car(), new Environment(), 
/* 241 */               LispThread.currentThread());
/*     */       } 
/* 243 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2));
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 249 */   private static final SpecialOperator LOCALLY = new sf_locally();
/*     */   
/*     */   private static final class sf_locally extends SpecialOperator { sf_locally() {
/* 252 */       super(Symbol.LOCALLY, "&body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 259 */       LispThread thread = LispThread.currentThread();
/* 260 */       Environment ext = new Environment(env);
/*     */       try {
/* 262 */         thread.envStack.push(ext);
/* 263 */         args = ext.processDeclarations(args);
/* 264 */         return Lisp.progn(args, ext, thread);
/*     */       } finally {
/*     */         
/* 267 */         while (thread.envStack.pop() != ext);
/*     */       } 
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 273 */   private static final SpecialOperator PROGN = new sf_progn();
/*     */   
/*     */   private static final class sf_progn extends SpecialOperator { sf_progn() {
/* 276 */       super(Symbol.PROGN, "&rest forms");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 283 */       LispThread thread = LispThread.currentThread();
/* 284 */       return Lisp.progn(args, env, thread);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 289 */   private static final SpecialOperator FLET = new sf_flet();
/*     */   
/*     */   private static final class sf_flet extends SpecialOperator { sf_flet() {
/* 292 */       super(Symbol.FLET, "definitions &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 299 */       return SpecialOperators._flet(args, env, false);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 304 */   private static final SpecialOperator LABELS = new sf_labels();
/*     */   
/*     */   private static final class sf_labels extends SpecialOperator { sf_labels() {
/* 307 */       super(Symbol.LABELS, "definitions &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 314 */       return SpecialOperators._flet(args, env, true);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject _flet(LispObject args, Environment env, boolean recursive) {
/* 323 */     LispObject defs = Lisp.checkList(args.car());
/* 324 */     LispThread thread = LispThread.currentThread();
/* 325 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 326 */     Environment funEnv = new Environment(env);
/* 327 */     while (defs != Lisp.NIL) {
/* 328 */       Symbol symbol; LispObject def = Lisp.checkList(defs.car());
/* 329 */       LispObject name = def.car();
/*     */       
/* 331 */       if (name instanceof Symbol) {
/* 332 */         symbol = Lisp.checkSymbol(name);
/* 333 */         if (symbol.getSymbolFunction() instanceof SpecialOperator) {
/* 334 */           return Lisp.program_error(symbol.getName() + " is a special operator and may not be redefined.");
/*     */         }
/*     */       }
/* 337 */       else if (Lisp.isValidSetfFunctionName(name)) {
/* 338 */         symbol = Lisp.checkSymbol(name.cadr());
/*     */       } else {
/* 340 */         return Lisp.type_error(name, Lisp.FUNCTION_NAME);
/* 341 */       }  LispObject rest = def.cdr();
/* 342 */       LispObject parameters = rest.car();
/* 343 */       LispObject body = rest.cdr();
/* 344 */       LispObject decls = Lisp.NIL;
/* 345 */       while (body.car() instanceof Cons && body.car().car() == Symbol.DECLARE) {
/* 346 */         decls = new Cons(body.car(), decls);
/* 347 */         body = body.cdr();
/*     */       } 
/* 349 */       body = new Cons(symbol, body);
/* 350 */       body = new Cons(Symbol.BLOCK, body);
/* 351 */       body = new Cons(body, Lisp.NIL);
/* 352 */       while (decls != Lisp.NIL) {
/* 353 */         body = new Cons(decls.car(), body);
/* 354 */         decls = decls.cdr();
/*     */       } 
/* 356 */       LispObject lambda_expression = new Cons(Symbol.LAMBDA, new Cons(parameters, body));
/*     */ 
/*     */       
/* 359 */       LispObject lambda_name = Lisp.list(recursive ? Symbol.LABELS : Symbol.FLET, new LispObject[] { name });
/* 360 */       Closure closure = new Closure(lambda_name, lambda_expression, recursive ? funEnv : env);
/*     */ 
/*     */       
/* 363 */       funEnv.addFunctionBinding(name, closure);
/* 364 */       defs = defs.cdr();
/*     */     } 
/*     */     try {
/* 367 */       Environment ext = new Environment(funEnv);
/* 368 */       LispObject body = args.cdr();
/* 369 */       body = ext.processDeclarations(body);
/* 370 */       return Lisp.progn(body, ext, thread);
/*     */     } finally {
/*     */       
/* 373 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/* 378 */   private static final SpecialOperator THE = new sf_the();
/*     */   
/*     */   private static final class sf_the extends SpecialOperator { sf_the() {
/* 381 */       super(Symbol.THE, "type value");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 388 */       if (args.length() != 2)
/* 389 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2)); 
/* 390 */       LispObject rv = Lisp.eval(args.cadr(), env, LispThread.currentThread());
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 404 */       LispObject type = args.car();
/* 405 */       if ((type instanceof Symbol && 
/* 406 */         Lisp.get(type, Symbol.DEFTYPE_DEFINITION) == Lisp.NIL) || type instanceof BuiltInClass)
/*     */       {
/* 408 */         if (rv.typep(type) == Lisp.NIL)
/* 409 */           Lisp.type_error(rv, type); 
/*     */       }
/* 411 */       return rv;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 416 */   private static final SpecialOperator PROGV = new sf_progv();
/*     */   
/*     */   private static final class sf_progv extends SpecialOperator { sf_progv() {
/* 419 */       super(Symbol.PROGV, "symbols values &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 426 */       if (args.length() < 2)
/* 427 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/* 428 */       LispThread thread = LispThread.currentThread();
/* 429 */       LispObject symbols = Lisp.checkList(Lisp.eval(args.car(), env, thread));
/* 430 */       LispObject values = Lisp.checkList(Lisp.eval(args.cadr(), env, thread));
/* 431 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */       
/*     */       try {
/* 434 */         Lisp.progvBindVars(symbols, values, thread);
/*     */         
/* 436 */         return Lisp.progn(args.cdr().cdr(), env, thread);
/*     */       } finally {
/*     */         
/* 439 */         thread.resetSpecialBindings(mark);
/*     */       } 
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 445 */   private static final SpecialOperator DECLARE = new sf_declare();
/*     */   
/*     */   private static final class sf_declare extends SpecialOperator { sf_declare() {
/* 448 */       super(Symbol.DECLARE, "&rest declaration-specifiers");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 455 */       return Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 460 */   private static final SpecialOperator FUNCTION = new sf_function();
/*     */   
/*     */   private static final class sf_function extends SpecialOperator { sf_function() {
/* 463 */       super(Symbol.FUNCTION, "thing");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 470 */       LispObject arg = args.car();
/* 471 */       if (arg instanceof Symbol) {
/* 472 */         LispObject operator = env.lookupFunction(arg);
/* 473 */         if (operator instanceof Autoload) {
/* 474 */           Autoload autoload = (Autoload)operator;
/* 475 */           autoload.load();
/* 476 */           operator = autoload.getSymbol().getSymbolFunction();
/*     */         } 
/* 478 */         if (operator instanceof Function)
/* 479 */           return operator; 
/* 480 */         if (operator instanceof FuncallableStandardObject)
/* 481 */           return operator; 
/* 482 */         return Lisp.error(new UndefinedFunction(arg));
/*     */       } 
/* 484 */       if (arg instanceof Cons) {
/* 485 */         LispObject car = ((Cons)arg).car;
/* 486 */         if (car == Symbol.SETF) {
/* 487 */           LispObject f = env.lookupFunction(arg);
/* 488 */           if (f != null)
/* 489 */             return f; 
/* 490 */           Symbol symbol = Lisp.checkSymbol(arg.cadr());
/* 491 */           f = Lisp.get(symbol, Symbol.SETF_FUNCTION, null);
/* 492 */           if (f != null)
/* 493 */             return f; 
/* 494 */           f = Lisp.get(symbol, Symbol.SETF_INVERSE, null);
/* 495 */           if (f != null)
/* 496 */             return f; 
/*     */         } 
/* 498 */         if (car == Symbol.LAMBDA)
/* 499 */           return new Closure(arg, env); 
/* 500 */         if (car == Symbol.NAMED_LAMBDA) {
/* 501 */           LispObject name = arg.cadr();
/* 502 */           if (name instanceof Symbol || Lisp.isValidSetfFunctionName(name)) {
/* 503 */             return new Closure(name, new Cons(Symbol.LAMBDA, arg
/* 504 */                   .cddr()), env);
/*     */           }
/*     */           
/* 507 */           return Lisp.type_error(name, Lisp.FUNCTION_NAME);
/*     */         } 
/* 509 */         if (car == Symbol.MACRO_FUNCTION)
/* 510 */           return new Closure(arg, env); 
/*     */       } 
/* 512 */       return Lisp.error(new UndefinedFunction(Lisp.list(Keyword.NAME, new LispObject[] { arg })));
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 517 */   private static final SpecialOperator SETQ = new sf_setq();
/*     */   
/*     */   private static final class sf_setq extends SpecialOperator { sf_setq() {
/* 520 */       super(Symbol.SETQ, "&rest vars-and-values");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/* 527 */       LispObject value = Nil.NIL;
/* 528 */       LispThread thread = LispThread.currentThread();
/* 529 */       while (args != Lisp.NIL) {
/* 530 */         Symbol symbol = Lisp.checkSymbol(args.car());
/* 531 */         if (symbol.isConstant()) {
/* 532 */           return Lisp.program_error(symbol.princToString() + " is a constant and thus cannot be set.");
/*     */         }
/*     */         
/* 535 */         args = args.cdr();
/* 536 */         if (symbol.isSpecialVariable() || env.isDeclaredSpecial(symbol)) {
/* 537 */           SpecialBinding binding = thread.getSpecialBinding(symbol);
/* 538 */           value = Lisp.eval(args.car(), env, thread);
/* 539 */           if (binding != null) {
/* 540 */             binding.value = value;
/*     */           } else {
/* 542 */             symbol.setSymbolValue(value);
/*     */           } 
/*     */         } else {
/*     */           
/* 546 */           Binding binding = env.getBinding(symbol);
/* 547 */           if (binding != null) {
/* 548 */             if (binding.value instanceof SymbolMacro) {
/*     */               
/* 550 */               LispObject expansion = ((SymbolMacro)binding.value).getExpansion();
/* 551 */               LispObject form = Lisp.list(Symbol.SETF, new LispObject[] { expansion, args.car() });
/* 552 */               value = Lisp.eval(form, env, thread);
/*     */             } else {
/* 554 */               value = Lisp.eval(args.car(), env, thread);
/* 555 */               binding.value = value;
/*     */             }
/*     */           
/* 558 */           } else if (symbol.getSymbolMacro() != null) {
/*     */             
/* 560 */             LispObject expansion = symbol.getSymbolMacro().getExpansion();
/* 561 */             LispObject form = Lisp.list(Symbol.SETF, new LispObject[] { expansion, args.car() });
/* 562 */             value = Lisp.eval(form, env, thread);
/*     */           } else {
/* 564 */             value = Lisp.eval(args.car(), env, thread);
/* 565 */             symbol.setSymbolValue(value);
/*     */           } 
/*     */         } 
/*     */         
/* 569 */         args = args.cdr();
/*     */       } 
/*     */       
/* 572 */       thread._values = null;
/* 573 */       return value;
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SpecialOperators.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */