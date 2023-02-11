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
/*     */ public final class Do
/*     */ {
/*  40 */   private static final SpecialOperator DO = new sf_do();
/*     */   
/*     */   private static final class sf_do extends SpecialOperator { sf_do() {
/*  43 */       super(Symbol.DO, "varlist endlist &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  50 */       return Do._do(args, env, false);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*  55 */   private static final SpecialOperator DO_STAR = new sf_do_star();
/*     */   
/*     */   private static final class sf_do_star extends SpecialOperator { sf_do_star() {
/*  58 */       super(Symbol.DO_STAR, "varlist endlist &body body");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject args, Environment env) {
/*  65 */       return Do._do(args, env, true);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final LispObject _do(LispObject args, Environment env, boolean sequential) {
/*  73 */     LispObject varlist = args.car();
/*  74 */     LispObject second = args.cadr();
/*  75 */     LispObject end_test_form = second.car();
/*  76 */     LispObject result_forms = second.cdr();
/*  77 */     LispObject body = args.cddr();
/*     */     
/*  79 */     int numvars = varlist.length();
/*  80 */     Symbol[] vars = new Symbol[numvars];
/*  81 */     LispObject[] initforms = new LispObject[numvars];
/*  82 */     LispObject[] stepforms = new LispObject[numvars];
/*  83 */     for (int i = 0; i < numvars; i++) {
/*  84 */       LispObject varspec = varlist.car();
/*  85 */       if (varspec instanceof Cons) {
/*  86 */         vars[i] = Lisp.checkSymbol(varspec.car());
/*  87 */         initforms[i] = varspec.cadr();
/*     */         
/*  89 */         if (varspec.cddr() != Lisp.NIL) {
/*  90 */           stepforms[i] = varspec.caddr();
/*     */         }
/*     */       } else {
/*  93 */         vars[i] = Lisp.checkSymbol(varspec);
/*  94 */         initforms[i] = Lisp.NIL;
/*     */       } 
/*  96 */       varlist = varlist.cdr();
/*     */     } 
/*  98 */     LispThread thread = LispThread.currentThread();
/*  99 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*     */ 
/*     */     
/* 102 */     LispObject bodyAndDecls = Lisp.parseBody(body, false);
/* 103 */     LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/* 104 */     body = bodyAndDecls.car();
/*     */     
/* 106 */     Environment ext = new Environment(env);
/* 107 */     for (int j = 0; j < numvars; j++) {
/* 108 */       Symbol var = vars[j];
/* 109 */       LispObject value = Lisp.eval(initforms[j], sequential ? ext : env, thread);
/* 110 */       ext = new Environment(ext);
/* 111 */       if (specials != Lisp.NIL && Lisp.memq(var, specials)) {
/* 112 */         thread.bindSpecial(var, value);
/* 113 */       } else if (var.isSpecialVariable()) {
/* 114 */         thread.bindSpecial(var, value);
/*     */       } else {
/* 116 */         ext.bind(var, value);
/*     */       } 
/* 118 */     }  LispObject list = specials;
/* 119 */     while (list != Lisp.NIL) {
/* 120 */       ext.declareSpecial(Lisp.checkSymbol(list.car()));
/* 121 */       list = list.cdr();
/*     */     } 
/*     */     
/* 124 */     LispObject localTags = Lisp.preprocessTagBody(body, ext);
/* 125 */     LispObject blockId = new LispObject();
/*     */     try {
/* 127 */       thread.envStack.push(ext);
/*     */       
/* 129 */       ext.addBlock(Lisp.NIL, blockId);
/*     */ 
/*     */ 
/*     */       
/* 133 */       while (Lisp.eval(end_test_form, ext, thread) == Lisp.NIL) {
/*     */ 
/*     */         
/* 136 */         Lisp.processTagBody(body, localTags, ext);
/*     */ 
/*     */         
/* 139 */         if (sequential) {
/* 140 */           for (int k = 0; k < numvars; k++) {
/* 141 */             LispObject step = stepforms[k];
/* 142 */             if (step != null) {
/* 143 */               Symbol symbol = vars[k];
/* 144 */               LispObject value = Lisp.eval(step, ext, thread);
/* 145 */               if (symbol.isSpecialVariable() || ext
/* 146 */                 .isDeclaredSpecial(symbol)) {
/* 147 */                 thread.rebindSpecial(symbol, value);
/*     */               } else {
/* 149 */                 ext.rebind(symbol, value);
/*     */               } 
/*     */             } 
/*     */           } 
/*     */         } else {
/* 154 */           LispObject[] results = new LispObject[numvars]; int k;
/* 155 */           for (k = 0; k < numvars; k++) {
/* 156 */             LispObject step = stepforms[k];
/* 157 */             if (step != null) {
/* 158 */               LispObject lispObject = Lisp.eval(step, ext, thread);
/* 159 */               results[k] = lispObject;
/*     */             } 
/*     */           } 
/*     */           
/* 163 */           for (k = 0; k < numvars; k++) {
/* 164 */             if (results[k] != null) {
/* 165 */               Symbol symbol = vars[k];
/* 166 */               LispObject value = results[k];
/* 167 */               if (symbol.isSpecialVariable() || ext
/* 168 */                 .isDeclaredSpecial(symbol)) {
/* 169 */                 thread.rebindSpecial(symbol, value);
/*     */               } else {
/* 171 */                 ext.rebind(symbol, value);
/*     */               } 
/*     */             } 
/*     */           } 
/* 175 */         }  if (Lisp.interrupted)
/* 176 */           Lisp.handleInterrupt(); 
/*     */       } 
/* 178 */       LispObject result = Lisp.progn(result_forms, ext, thread);
/* 179 */       return result;
/* 180 */     } catch (Return ret) {
/* 181 */       if (ret.getBlock() == blockId) {
/* 182 */         return ret.getResult();
/*     */       }
/* 184 */       throw ret;
/*     */     } finally {
/*     */       
/* 187 */       while (thread.envStack.pop() != ext);
/* 188 */       thread.resetSpecialBindings(mark);
/* 189 */       ext.inactive = true;
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Do.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */