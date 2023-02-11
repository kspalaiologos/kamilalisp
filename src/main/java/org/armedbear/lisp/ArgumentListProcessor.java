/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.Serializable;
/*      */ import java.util.ArrayList;
/*      */ import java.util.List;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public class ArgumentListProcessor
/*      */   implements Serializable
/*      */ {
/*      */   private static final int STATE_REQUIRED = 0;
/*      */   private static final int STATE_OPTIONAL = 1;
/*      */   private static final int STATE_KEYWORD = 2;
/*      */   private static final int STATE_REST = 3;
/*      */   private static final int STATE_AUX = 4;
/*      */   
/*      */   public enum LambdaListType
/*      */   {
/*   50 */     ORDINARY,
/*   51 */     MACRO;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*   61 */   private Param[] requiredParameters = new Param[0];
/*   62 */   private Param[] optionalParameters = this.requiredParameters;
/*   63 */   private KeywordParam[] keywordParameters = new KeywordParam[0];
/*   64 */   private Param[] auxVars = this.requiredParameters;
/*   65 */   private Param[] positionalParameters = this.requiredParameters;
/*      */   
/*      */   private Symbol restVar;
/*      */   
/*      */   private Param restParam;
/*      */   
/*      */   private Symbol envVar;
/*      */   
/*      */   private Param envParam;
/*      */   private int arity;
/*      */   private int minArgs;
/*      */   private int maxArgs;
/*   77 */   private Symbol[] variables = new Symbol[0];
/*      */ 
/*      */ 
/*      */   
/*   81 */   private boolean[] specials = new boolean[0];
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private boolean andKey;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private boolean allowOtherKeys;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private final ArgumentMatcher matcher;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private boolean matcherNeedsEnv;
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private Operator function;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public ArgumentListProcessor(Operator fun, int requiredCount, OptionalParam[] optional, KeywordParam[] keyword, boolean key, boolean moreKeys, Symbol rest) {
/*  117 */     this.function = fun;
/*      */     
/*  119 */     this.requiredParameters = (Param[])new RequiredParam[requiredCount];
/*  120 */     this.positionalParameters = new Param[requiredCount + optional.length + ((rest != null) ? 1 : 0)];
/*      */ 
/*      */ 
/*      */     
/*  124 */     RequiredParam r = new RequiredParam();
/*  125 */     for (int i = 0; i < requiredCount; i++) {
/*  126 */       this.requiredParameters[i] = r;
/*  127 */       this.positionalParameters[i] = r;
/*      */     } 
/*      */     
/*  130 */     this.optionalParameters = (Param[])optional;
/*  131 */     System.arraycopy(optional, 0, this.positionalParameters, requiredCount, optional.length);
/*      */ 
/*      */     
/*  134 */     this.restVar = rest;
/*  135 */     if (this.restVar != null) {
/*  136 */       this.positionalParameters[requiredCount + optional.length] = this.restParam = new RestParam(rest, false);
/*      */     }
/*      */     
/*  139 */     this.andKey = key;
/*  140 */     this.allowOtherKeys = moreKeys;
/*  141 */     this.keywordParameters = keyword;
/*      */ 
/*      */     
/*  144 */     this.auxVars = new Param[0];
/*      */ 
/*      */     
/*  147 */     this.variables = extractVariables();
/*  148 */     this.specials = new boolean[this.variables.length];
/*      */     
/*  150 */     this.minArgs = this.requiredParameters.length;
/*  151 */     this.maxArgs = (rest == null && !this.allowOtherKeys) ? (this.minArgs + this.optionalParameters.length + 2 * this.keywordParameters.length) : -1;
/*      */     
/*  153 */     this.arity = (rest == null && !this.allowOtherKeys && !this.andKey && this.optionalParameters.length == 0) ? this.maxArgs : -1;
/*      */ 
/*      */     
/*  156 */     if (keyword.length == 0) {
/*  157 */       this.matcher = new FastMatcher();
/*      */     } else {
/*  159 */       this.matcher = new SlowMatcher();
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public ArgumentListProcessor(Operator fun, LispObject lambdaList, LispObject specials, LambdaListType type) {
/*  176 */     this.function = fun;
/*      */     
/*  178 */     boolean _andKey = false;
/*  179 */     boolean _allowOtherKeys = false;
/*  180 */     if (lambdaList instanceof Cons) {
/*      */       
/*  182 */       int length = lambdaList.length();
/*  183 */       ArrayList<Param> required = null;
/*  184 */       ArrayList<Param> optional = null;
/*  185 */       ArrayList<Param> keywords = null;
/*  186 */       ArrayList<Param> aux = null;
/*  187 */       int state = 0;
/*  188 */       LispObject remaining = lambdaList;
/*      */       
/*  190 */       if (remaining.car() == Symbol.AND_WHOLE) {
/*  191 */         if (type == LambdaListType.ORDINARY) {
/*  192 */           Lisp.program_error("&WHOLE not allowed in ordinary lambda lists.");
/*      */         } else {
/*      */           
/*  195 */           remaining = remaining.cdr().cdr();
/*      */         } 
/*      */       }
/*      */ 
/*      */       
/*  200 */       while (remaining != Lisp.NIL) {
/*      */         
/*  202 */         LispObject obj = remaining.car();
/*  203 */         if (obj instanceof Symbol) {
/*      */           
/*  205 */           if (obj == Symbol.AND_WHOLE)
/*  206 */             if (type == LambdaListType.ORDINARY) {
/*  207 */               Lisp.program_error("&WHOLE not allowed in ordinary lambda lists.");
/*      */             } else {
/*  209 */               Lisp.program_error("&WHOLE must appear first in macro lambda list.");
/*      */             }  
/*  211 */           if (state == 4) {
/*      */             
/*  213 */             if (aux == null)
/*  214 */               aux = new ArrayList<>(); 
/*  215 */             aux.add(new AuxParam((Symbol)obj, 
/*  216 */                   Lisp.isSpecial((Symbol)obj, specials), Lisp.NIL));
/*      */           }
/*  218 */           else if (obj == Symbol.AND_OPTIONAL) {
/*      */             
/*  220 */             state = 1;
/*  221 */             this.arity = -1;
/*      */           }
/*  223 */           else if (obj == Symbol.AND_REST || obj == Symbol.AND_BODY) {
/*      */             
/*  225 */             if (_andKey)
/*      */             {
/*  227 */               Lisp.program_error("&REST/&BODY must precede &KEY.");
/*      */             }
/*  229 */             if (type == LambdaListType.ORDINARY && obj == Symbol.AND_BODY)
/*  230 */               Lisp.program_error("&BODY not allowed in ordinary lambda lists."); 
/*  231 */             state = 3;
/*  232 */             this.arity = -1;
/*  233 */             this.maxArgs = -1;
/*  234 */             remaining = remaining.cdr();
/*  235 */             if (remaining == Lisp.NIL)
/*      */             {
/*  237 */               Lisp.program_error("&REST/&BODY must be followed by a variable.");
/*      */             }
/*  239 */             if (this.restVar != null)
/*      */             {
/*  241 */               Lisp.program_error("&REST/&BODY may occur only once.");
/*      */             }
/*  243 */             LispObject remainingcar = remaining.car();
/*  244 */             if (remainingcar instanceof Symbol)
/*      */             {
/*  246 */               this.restVar = (Symbol)remainingcar;
/*  247 */               this.restParam = new RestParam(this.restVar, Lisp.isSpecial(this.restVar, specials));
/*      */             }
/*      */             else
/*      */             {
/*  251 */               Lisp.program_error("&REST/&BODY must be followed by a variable.");
/*      */             }
/*      */           
/*  254 */           } else if (obj == Symbol.AND_ENVIRONMENT) {
/*      */             
/*  256 */             if (type == LambdaListType.ORDINARY)
/*  257 */               Lisp.program_error("&ENVIRONMENT not allowed in ordinary lambda lists."); 
/*  258 */             remaining = remaining.cdr();
/*  259 */             this.envVar = (Symbol)remaining.car();
/*  260 */             this.envParam = new EnvironmentParam(this.envVar, Lisp.isSpecial(this.envVar, specials));
/*  261 */             this.arity = -1;
/*      */           }
/*  263 */           else if (obj == Symbol.AND_KEY) {
/*      */             
/*  265 */             state = 2;
/*  266 */             _andKey = true;
/*  267 */             this.arity = -1;
/*      */           }
/*  269 */           else if (obj == Symbol.AND_ALLOW_OTHER_KEYS) {
/*      */             
/*  271 */             _allowOtherKeys = true;
/*  272 */             this.maxArgs = -1;
/*      */           }
/*  274 */           else if (obj == Symbol.AND_AUX) {
/*      */ 
/*      */             
/*  277 */             state = 4;
/*  278 */             this.arity = -1;
/*      */ 
/*      */           
/*      */           }
/*  282 */           else if (state == 1) {
/*      */             
/*  284 */             if (optional == null)
/*  285 */               optional = new ArrayList<>(); 
/*  286 */             optional.add(new OptionalParam((Symbol)obj, 
/*  287 */                   Lisp.isSpecial((Symbol)obj, specials), null, false, Lisp.NIL));
/*  288 */             if (this.maxArgs >= 0) {
/*  289 */               this.maxArgs++;
/*      */             }
/*  291 */           } else if (state == 2) {
/*      */             
/*  293 */             if (keywords == null)
/*  294 */               keywords = new ArrayList<>(); 
/*  295 */             keywords.add(new KeywordParam((Symbol)obj, 
/*  296 */                   Lisp.isSpecial((Symbol)obj, specials), null, false, Lisp.NIL, null));
/*  297 */             if (this.maxArgs >= 0) {
/*  298 */               this.maxArgs += 2;
/*      */             }
/*      */           } else {
/*      */             
/*  302 */             if (state != 0)
/*      */             {
/*  304 */               Lisp.program_error("required parameters cannot appear after &REST/&BODY.");
/*      */             }
/*  306 */             if (required == null)
/*  307 */               required = new ArrayList<>(); 
/*  308 */             required.add(new RequiredParam((Symbol)obj, 
/*  309 */                   Lisp.isSpecial((Symbol)obj, specials)));
/*  310 */             if (this.maxArgs >= 0) {
/*  311 */               this.maxArgs++;
/*      */             }
/*      */           }
/*      */         
/*  315 */         } else if (obj instanceof Cons) {
/*      */           
/*  317 */           if (state == 4) {
/*      */             
/*  319 */             Symbol sym = Lisp.checkSymbol(obj.car());
/*  320 */             LispObject initForm = obj.cadr();
/*  321 */             Debug.assertTrue((initForm != null));
/*  322 */             if (aux == null)
/*  323 */               aux = new ArrayList<>(); 
/*  324 */             aux.add(new AuxParam(sym, Lisp.isSpecial(sym, specials), initForm));
/*      */           }
/*  326 */           else if (state == 1) {
/*      */             
/*  328 */             Symbol sym = Lisp.checkSymbol(obj.car());
/*  329 */             LispObject initForm = obj.cadr();
/*  330 */             Symbol svar = Lisp.checkSymbol(obj.cdr().cdr().car());
/*  331 */             if (optional == null)
/*  332 */               optional = new ArrayList<>(); 
/*  333 */             optional.add(new OptionalParam(sym, Lisp.isSpecial(sym, specials), (svar == Lisp.NIL) ? null : svar, 
/*  334 */                   Lisp.isSpecial(svar, specials), initForm));
/*  335 */             if (this.maxArgs >= 0) {
/*  336 */               this.maxArgs++;
/*      */             }
/*  338 */           } else if (state == 2) {
/*      */             Symbol keyword, var;
/*      */ 
/*      */             
/*  342 */             LispObject initForm = Lisp.NIL;
/*  343 */             Symbol svar = Lisp.NIL;
/*  344 */             LispObject first = obj.car();
/*  345 */             if (first instanceof Cons) {
/*      */               
/*  347 */               keyword = Lisp.checkSymbol(first.car());
/*  348 */               var = Lisp.checkSymbol(first.cadr());
/*      */             }
/*      */             else {
/*      */               
/*  352 */               var = Lisp.checkSymbol(first);
/*      */               
/*  354 */               keyword = Lisp.PACKAGE_KEYWORD.intern(var.name);
/*      */             } 
/*  356 */             obj = obj.cdr();
/*  357 */             if (obj != Lisp.NIL) {
/*      */               
/*  359 */               initForm = obj.car();
/*  360 */               obj = obj.cdr();
/*  361 */               if (obj != Lisp.NIL)
/*  362 */                 svar = Lisp.checkSymbol(obj.car()); 
/*      */             } 
/*  364 */             if (keywords == null)
/*  365 */               keywords = new ArrayList<>(); 
/*  366 */             keywords.add(new KeywordParam(var, Lisp.isSpecial(var, specials), (svar == Lisp.NIL) ? null : svar, 
/*  367 */                   Lisp.isSpecial(svar, specials), initForm, keyword));
/*      */             
/*  369 */             if (this.maxArgs >= 0) {
/*  370 */               this.maxArgs += 2;
/*      */             }
/*      */           } else {
/*  373 */             invalidParameter(obj);
/*      */           } 
/*      */         } else {
/*  376 */           invalidParameter(obj);
/*  377 */         }  remaining = remaining.cdr();
/*      */       } 
/*  379 */       if (this.arity == 0)
/*  380 */         this.arity = length; 
/*  381 */       ArrayList<Param> positional = new ArrayList<>();
/*      */       
/*  383 */       if (this.envParam != null)
/*  384 */         positional.add(this.envParam); 
/*  385 */       if (required != null) {
/*      */         
/*  387 */         this.requiredParameters = new Param[required.size()];
/*  388 */         required.toArray(this.requiredParameters);
/*  389 */         positional.addAll(required);
/*      */       } 
/*  391 */       if (optional != null) {
/*      */         
/*  393 */         this.optionalParameters = new Param[optional.size()];
/*  394 */         optional.toArray(this.optionalParameters);
/*  395 */         positional.addAll(optional);
/*      */       } 
/*  397 */       if (this.restParam != null)
/*  398 */         positional.add(this.restParam); 
/*  399 */       if (keywords != null) {
/*      */         
/*  401 */         this.keywordParameters = new KeywordParam[keywords.size()];
/*  402 */         keywords.toArray(this.keywordParameters);
/*      */       } 
/*  404 */       if (aux != null) {
/*      */         
/*  406 */         this.auxVars = new Param[aux.size()];
/*  407 */         this.auxVars = aux.<Param>toArray(this.auxVars);
/*      */       } 
/*      */       
/*  410 */       this.positionalParameters = positional.<Param>toArray(this.positionalParameters);
/*      */     
/*      */     }
/*      */     else {
/*      */       
/*  415 */       Debug.assertTrue((lambdaList == Lisp.NIL));
/*  416 */       this.arity = 0;
/*  417 */       this.maxArgs = 0;
/*      */     } 
/*      */     
/*  420 */     this.andKey = _andKey;
/*  421 */     this.allowOtherKeys = _allowOtherKeys;
/*  422 */     this.minArgs = this.requiredParameters.length;
/*  423 */     if (this.arity >= 0)
/*  424 */       Debug.assertTrue((this.arity == this.minArgs)); 
/*  425 */     this.variables = extractVariables();
/*  426 */     this.specials = new boolean[this.variables.length];
/*  427 */     for (int i = 0; i < this.variables.length; i++) {
/*  428 */       this.specials[i] = Lisp.isSpecial(this.variables[i], specials);
/*      */     }
/*      */     
/*  431 */     for (Param p : this.positionalParameters) {
/*  432 */       if (p.needsEnvironment()) {
/*  433 */         this.matcherNeedsEnv = true; break;
/*      */       } 
/*      */     } 
/*  436 */     if (!this.matcherNeedsEnv)
/*  437 */       for (Param p : this.keywordParameters) {
/*  438 */         if (p.needsEnvironment()) {
/*  439 */           this.matcherNeedsEnv = true; break;
/*      */         } 
/*      */       }  
/*  442 */     if (!this.matcherNeedsEnv) {
/*  443 */       for (Param p : this.auxVars) {
/*  444 */         if (p.needsEnvironment()) {
/*  445 */           this.matcherNeedsEnv = true;
/*      */           break;
/*      */         } 
/*      */       } 
/*      */     }
/*  450 */     if (this.keywordParameters.length == 0) {
/*  451 */       this.matcher = new FastMatcher();
/*      */     } else {
/*  453 */       this.matcher = new SlowMatcher();
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void setFunction(Operator fun) {
/*  461 */     this.function = fun;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject[] match(LispObject[] args, Environment _environment, Environment env, LispThread thread) {
/*  478 */     if (this.matcherNeedsEnv) {
/*  479 */       if (thread == null) {
/*  480 */         thread = LispThread.currentThread();
/*      */       }
/*  482 */       env = new Environment((env == null) ? _environment : env);
/*      */     } 
/*  484 */     LispObject[] rv = this.matcher.match(args, _environment, env, thread);
/*  485 */     for (int i = 0; i < rv.length; i++)
/*  486 */       Debug.assertTrue((rv[i] != null)); 
/*  487 */     return rv;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void bindVars(LispObject[] values, Environment env, LispThread thread) {
/*  498 */     for (int i = 0; i < this.variables.length; i++) {
/*  499 */       Symbol var = this.variables[i];
/*      */ 
/*      */ 
/*      */       
/*  503 */       Lisp.bindArg((this.specials[i] || var.isSpecialVariable()), var, values[i], env, thread);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public Symbol[] freeSpecials(LispObject specials) {
/*  509 */     ArrayList<Symbol> list = new ArrayList<>();
/*      */ 
/*      */     
/*  512 */     label15: while (specials != Lisp.NIL) {
/*  513 */       Symbol special = (Symbol)specials.car();
/*  514 */       specials = specials.cdr();
/*      */       
/*  516 */       for (Symbol v : this.variables) {
/*  517 */         if (v == special)
/*      */           continue label15; 
/*      */       } 
/*  520 */       list.add(special);
/*      */     } 
/*      */     
/*  523 */     Symbol[] rv = new Symbol[list.size()];
/*  524 */     return list.<Symbol>toArray(rv);
/*      */   }
/*      */   
/*      */   public int getArity() {
/*  528 */     return this.arity;
/*      */   }
/*      */   
/*      */   public int getMinArgs() {
/*  532 */     return this.minArgs;
/*      */   }
/*      */   
/*      */   public int getMaxArgs() {
/*  536 */     return this.maxArgs;
/*      */   }
/*      */   
/*      */   public Symbol[] getVariables() {
/*  540 */     return this.variables;
/*      */   }
/*      */   
/*      */   private static void invalidParameter(LispObject obj) {
/*  544 */     Lisp.program_error(obj.princToString() + " may not be used as a variable in a lambda list.");
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private Symbol[] extractVariables() {
/*  550 */     ArrayList<Symbol> vars = new ArrayList<>();
/*  551 */     for (Param parameter : this.positionalParameters)
/*  552 */       parameter.addVars(vars); 
/*  553 */     for (Param parameter : this.keywordParameters)
/*  554 */       parameter.addVars(vars); 
/*  555 */     for (Param parameter : this.auxVars)
/*  556 */       parameter.addVars(vars); 
/*  557 */     Symbol[] array = new Symbol[vars.size()];
/*  558 */     vars.toArray(array);
/*  559 */     return array;
/*      */   }
/*      */   
/*      */   private static abstract class ArgumentMatcher
/*      */     implements Serializable
/*      */   {
/*      */     private ArgumentMatcher() {}
/*      */     
/*      */     abstract LispObject[] match(LispObject[] param1ArrayOfLispObject, Environment param1Environment1, Environment param1Environment2, LispThread param1LispThread);
/*      */   }
/*      */   
/*      */   private class SlowMatcher
/*      */     extends ArgumentMatcher {
/*      */     private SlowMatcher() {}
/*      */     
/*      */     private LispObject[] _match(LispObject[] args, Environment _environment, Environment env, LispThread thread) {
/*  575 */       ArgumentListProcessor.ArgList argslist = new ArgumentListProcessor.ArgList(_environment, args);
/*  576 */       LispObject[] array = new LispObject[ArgumentListProcessor.this.variables.length];
/*  577 */       int index = 0;
/*      */ 
/*      */       
/*  580 */       for (ArgumentListProcessor.Param p : ArgumentListProcessor.this.positionalParameters) {
/*  581 */         index = p.assign(index, array, argslist, env, thread);
/*      */       }
/*  583 */       if (ArgumentListProcessor.this.andKey) {
/*  584 */         argslist.assertRemainderKeywords();
/*      */         
/*  586 */         for (ArgumentListProcessor.Param p : ArgumentListProcessor.this.keywordParameters)
/*  587 */           index = p.assign(index, array, argslist, env, thread); 
/*      */       } 
/*  589 */       for (ArgumentListProcessor.Param p : ArgumentListProcessor.this.auxVars) {
/*  590 */         index = p.assign(index, array, argslist, env, thread);
/*      */       }
/*  592 */       if (ArgumentListProcessor.this.andKey) {
/*  593 */         if (ArgumentListProcessor.this.allowOtherKeys) {
/*  594 */           return array;
/*      */         }
/*  596 */         if (!argslist.consumed()) {
/*      */ 
/*      */           
/*  599 */           LispObject allowOtherKeysValue = argslist.findKeywordArg(Keyword.ALLOW_OTHER_KEYS, Lisp.NIL);
/*      */           
/*  601 */           if (allowOtherKeysValue != Lisp.NIL) {
/*  602 */             return array;
/*      */           }
/*      */ 
/*      */           
/*  606 */           label47: while (!argslist.consumed()) {
/*  607 */             LispObject key = argslist.consume();
/*  608 */             argslist.consume();
/*      */             
/*  610 */             if (key == Keyword.ALLOW_OTHER_KEYS) {
/*      */               continue;
/*      */             }
/*  613 */             for (ArgumentListProcessor.KeywordParam k : ArgumentListProcessor.this.keywordParameters) {
/*  614 */               if (k.keyword == key)
/*      */                 continue label47; 
/*      */             } 
/*  617 */             Lisp.program_error("Unrecognized keyword argument " + key
/*  618 */                 .printObject() + ".");
/*      */           } 
/*      */         } 
/*      */       } 
/*      */       
/*  623 */       if (ArgumentListProcessor.this.restVar == null && !argslist.consumed()) {
/*  624 */         Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function));
/*      */       }
/*  626 */       return array;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     LispObject[] match(LispObject[] args, Environment _environment, Environment env, LispThread thread) {
/*  633 */       if (ArgumentListProcessor.this.arity >= 0) {
/*      */ 
/*      */         
/*  636 */         if (args.length != ArgumentListProcessor.this.arity)
/*  637 */           Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function, Lisp.list(args), ArgumentListProcessor.this.arity)); 
/*  638 */         return args;
/*      */       } 
/*      */       
/*  641 */       if (args.length < ArgumentListProcessor.this.minArgs) {
/*  642 */         Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function, ArgumentListProcessor.this.minArgs, -1));
/*      */       }
/*  644 */       if (thread == null) {
/*  645 */         return _match(args, _environment, env, thread);
/*      */       }
/*  647 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/*      */       try {
/*  649 */         return _match(args, _environment, env, thread);
/*      */       } finally {
/*      */         
/*  652 */         thread.resetSpecialBindings(mark);
/*      */       } 
/*      */     }
/*      */   }
/*      */   
/*      */   private class FastMatcher
/*      */     extends ArgumentMatcher {
/*      */     private FastMatcher() {}
/*      */     
/*      */     LispObject[] match(LispObject[] args, Environment _environment, Environment env, LispThread thread) {
/*  662 */       int argsLength = args.length;
/*  663 */       if (ArgumentListProcessor.this.arity >= 0) {
/*      */ 
/*      */         
/*  666 */         if (argsLength != ArgumentListProcessor.this.arity)
/*  667 */           Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function, Lisp.list(args), ArgumentListProcessor.this.arity)); 
/*  668 */         return args;
/*      */       } 
/*      */       
/*  671 */       if (argsLength < ArgumentListProcessor.this.minArgs) {
/*  672 */         Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function, ArgumentListProcessor.this.minArgs, -1));
/*      */       }
/*  674 */       ArgumentListProcessor.ArgList arglist = new ArgumentListProcessor.ArgList(_environment, args);
/*  675 */       LispObject[] array = new LispObject[ArgumentListProcessor.this.variables.length];
/*  676 */       int index = 0;
/*      */ 
/*      */       
/*  679 */       for (ArgumentListProcessor.Param p : ArgumentListProcessor.this.positionalParameters)
/*  680 */         index = p.assign(index, array, arglist, env, thread); 
/*  681 */       for (ArgumentListProcessor.Param p : ArgumentListProcessor.this.auxVars) {
/*  682 */         index = p.assign(index, array, arglist, env, thread);
/*      */       }
/*  684 */       if (ArgumentListProcessor.this.andKey && !arglist.consumed()) {
/*      */ 
/*      */         
/*  687 */         arglist.assertRemainderKeywords();
/*      */         
/*  689 */         if (ArgumentListProcessor.this.allowOtherKeys) {
/*  690 */           return array;
/*      */         }
/*      */         
/*  693 */         LispObject allowOtherKeysValue = arglist.findKeywordArg(Keyword.ALLOW_OTHER_KEYS, null);
/*      */         
/*  695 */         if (allowOtherKeysValue == Lisp.NIL) {
/*      */           
/*  697 */           LispObject key = arglist.consume();
/*  698 */           arglist.consume();
/*      */           
/*  700 */           if (key != Keyword.ALLOW_OTHER_KEYS)
/*  701 */             Lisp.program_error("Invalid keyword argument " + key
/*  702 */                 .printObject() + "."); 
/*  703 */           allowOtherKeysValue = null;
/*      */         } 
/*      */         
/*  706 */         if (allowOtherKeysValue != null) {
/*  707 */           return array;
/*      */         }
/*      */       } 
/*  710 */       if (!arglist.consumed())
/*      */       {
/*  712 */         if (ArgumentListProcessor.this.restVar == null)
/*  713 */           Lisp.error(new WrongNumberOfArgumentsException(ArgumentListProcessor.this.function)); 
/*      */       }
/*  715 */       return array;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private static InitForm createInitForm(LispObject form) {
/*  725 */     if (form.constantp()) {
/*      */       
/*  727 */       if (form instanceof Symbol)
/*  728 */         return new ConstantInitForm(form.getSymbolValue()); 
/*  729 */       if (form instanceof Cons) {
/*      */         
/*  731 */         Debug.assertTrue((form.car() == Symbol.QUOTE));
/*  732 */         return new ConstantInitForm(form.cadr());
/*      */       } 
/*  734 */       return new ConstantInitForm(form);
/*      */     } 
/*  736 */     return new NonConstantInitForm(form);
/*      */   }
/*      */   
/*      */   private static final class ArgList
/*      */   {
/*      */     final LispObject[] args;
/*  742 */     int argsConsumed = 0;
/*      */     final int len;
/*      */     final Environment env;
/*      */     
/*      */     ArgList(Environment environment, LispObject[] args) {
/*  747 */       this.args = args;
/*  748 */       this.len = args.length;
/*  749 */       this.env = environment;
/*      */     }
/*      */ 
/*      */     
/*      */     void assertRemainderKeywords() {
/*  754 */       if ((this.len - this.argsConsumed & 0x1) == 1) {
/*  755 */         Lisp.program_error("Odd number of keyword arguments.");
/*      */       }
/*      */     }
/*      */ 
/*      */     
/*      */     LispObject consume() {
/*  761 */       return (this.argsConsumed < this.len) ? this.args[this.argsConsumed++] : null;
/*      */     }
/*      */ 
/*      */     
/*      */     boolean consumed() {
/*  766 */       return (this.len == this.argsConsumed);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     LispObject findKeywordArg(Symbol keyword, LispObject def) {
/*  772 */       int i = this.argsConsumed;
/*  773 */       while (i < this.len) {
/*      */         
/*  775 */         if (this.args[i] == keyword)
/*  776 */           return this.args[i + 1]; 
/*  777 */         i += 2;
/*      */       } 
/*  779 */       return def;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     Environment getEnvironment() {
/*  786 */       return this.env;
/*      */     }
/*      */ 
/*      */     
/*      */     LispObject rest() {
/*  791 */       LispObject rest = Lisp.NIL;
/*  792 */       for (int j = this.len; j-- > this.argsConsumed;) {
/*  793 */         rest = new Cons(this.args[j], rest);
/*      */       }
/*  795 */       return rest;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static abstract class Param
/*      */     implements Serializable
/*      */   {
/*      */     abstract int assign(int param1Int, LispObject[] param1ArrayOfLispObject, ArgumentListProcessor.ArgList param1ArgList, Environment param1Environment, LispThread param1LispThread);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     boolean needsEnvironment() {
/*  829 */       return false;
/*      */     }
/*      */     
/*      */     abstract void addVars(List param1List);
/*      */   }
/*      */   
/*      */   private static abstract class InitForm
/*      */   {
/*      */     private InitForm() {}
/*      */     
/*      */     boolean needsEnvironment() {
/*  840 */       return false;
/*      */     }
/*      */     
/*      */     abstract LispObject getValue(Environment param1Environment, LispThread param1LispThread);
/*      */   }
/*      */   
/*      */   private static class ConstantInitForm extends InitForm {
/*      */     ConstantInitForm(LispObject value) {
/*  848 */       this.value = value;
/*      */     }
/*      */     LispObject value;
/*      */     LispObject getValue(Environment ext, LispThread thread) {
/*  852 */       return this.value;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   private static class NonConstantInitForm
/*      */     extends InitForm
/*      */   {
/*      */     LispObject form;
/*      */     
/*      */     NonConstantInitForm(LispObject form) {
/*  863 */       this.form = form;
/*      */     }
/*      */     
/*      */     LispObject getValue(Environment ext, LispThread thread) {
/*  867 */       return Lisp.eval(this.form, ext, thread);
/*      */     }
/*      */     
/*      */     boolean needsEnvironment() {
/*  871 */       return true;
/*      */     }
/*      */   }
/*      */   
/*      */   private static class EnvironmentParam extends Param {
/*      */     Symbol var;
/*      */     boolean special;
/*      */     
/*      */     EnvironmentParam(Symbol var, boolean special) {
/*  880 */       this.var = var;
/*  881 */       this.special = special;
/*      */     }
/*      */ 
/*      */     
/*      */     void addVars(List<Symbol> vars) {
/*  886 */       vars.add(this.var);
/*      */     }
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/*  891 */       array[index++] = args.getEnvironment();
/*  892 */       if (ext != null) {
/*  893 */         Lisp.bindArg(this.special, this.var, args.getEnvironment(), ext, thread);
/*      */       }
/*  895 */       return index;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   public static class RequiredParam
/*      */     extends Param
/*      */   {
/*      */     Symbol var;
/*      */     boolean special;
/*      */     
/*      */     public RequiredParam() {
/*  907 */       this(Lisp.T, false);
/*      */     }
/*      */     
/*      */     public RequiredParam(Symbol var, boolean special) {
/*  911 */       this.var = var;
/*  912 */       this.special = special;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/*  918 */       LispObject value = args.consume();
/*  919 */       if (ext != null)
/*  920 */         Lisp.bindArg(this.special, this.var, value, ext, thread); 
/*  921 */       array[index++] = value;
/*  922 */       return index;
/*      */     }
/*      */     
/*      */     void addVars(List<Symbol> vars) {
/*  926 */       vars.add(this.var);
/*      */     }
/*      */   }
/*      */   
/*      */   public static class OptionalParam
/*      */     extends Param
/*      */   {
/*      */     Symbol var;
/*      */     boolean special;
/*      */     Symbol suppliedVar;
/*      */     boolean suppliedSpecial;
/*      */     ArgumentListProcessor.InitForm initForm;
/*      */     
/*      */     public OptionalParam(boolean suppliedVar, LispObject form) {
/*  940 */       this(Lisp.T, false, suppliedVar ? Lisp.T : null, false, form);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public OptionalParam(Symbol var, boolean special, Symbol suppliedVar, boolean suppliedSpecial, LispObject form) {
/*  946 */       this.var = var;
/*  947 */       this.special = special;
/*      */       
/*  949 */       this.suppliedVar = suppliedVar;
/*  950 */       this.suppliedSpecial = suppliedSpecial;
/*      */       
/*  952 */       this.initForm = ArgumentListProcessor.createInitForm(form);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/*  958 */       LispObject value = args.consume();
/*      */       
/*  960 */       return assign(index, array, value, ext, thread);
/*      */     }
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, LispObject value, Environment ext, LispThread thread) {
/*  965 */       if (value == null) {
/*  966 */         value = array[index++] = this.initForm.getValue(ext, thread);
/*  967 */         if (this.suppliedVar != null)
/*  968 */           array[index++] = Lisp.NIL; 
/*      */       } else {
/*  970 */         array[index++] = value;
/*  971 */         if (this.suppliedVar != null) {
/*  972 */           array[index++] = Lisp.T;
/*      */         }
/*      */       } 
/*  975 */       if (ext != null) {
/*  976 */         Lisp.bindArg(this.special, this.var, value, ext, thread);
/*  977 */         if (this.suppliedVar != null) {
/*  978 */           Lisp.bindArg(this.suppliedSpecial, this.suppliedVar, array[index - 1], ext, thread);
/*      */         }
/*      */       } 
/*  981 */       return index;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     boolean needsEnvironment() {
/*  987 */       return this.initForm.needsEnvironment();
/*      */     }
/*      */     
/*      */     void addVars(List<Symbol> vars) {
/*  991 */       vars.add(this.var);
/*  992 */       if (this.suppliedVar != null)
/*  993 */         vars.add(this.suppliedVar); 
/*      */     }
/*      */   }
/*      */   
/*      */   private static class RestParam
/*      */     extends Param
/*      */   {
/*      */     Symbol var;
/*      */     boolean special;
/*      */     
/*      */     RestParam(Symbol var, boolean special) {
/* 1004 */       this.var = var;
/* 1005 */       this.special = special;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/* 1011 */       array[index++] = args.rest();
/*      */       
/* 1013 */       if (ext != null) {
/* 1014 */         Lisp.bindArg(this.special, this.var, array[index - 1], ext, thread);
/*      */       }
/* 1016 */       return index;
/*      */     }
/*      */ 
/*      */     
/*      */     void addVars(List<Symbol> vars) {
/* 1021 */       vars.add(this.var);
/*      */     }
/*      */   }
/*      */   
/*      */   public static class KeywordParam
/*      */     extends OptionalParam {
/*      */     public Symbol keyword;
/*      */     
/*      */     public KeywordParam(boolean suppliedVar, LispObject form, Symbol keyword) {
/* 1030 */       this(Lisp.T, false, suppliedVar ? Lisp.T : null, false, form, keyword);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public KeywordParam(Symbol var, boolean special, Symbol suppliedVar, boolean suppliedSpecial, LispObject form, Symbol keyword) {
/* 1036 */       super(var, special, suppliedVar, suppliedSpecial, form);
/*      */       
/* 1038 */       this
/* 1039 */         .keyword = (keyword == null) ? Lisp.PACKAGE_KEYWORD.intern(var.getName()) : keyword;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/* 1045 */       return assign(index, array, args.findKeywordArg(this.keyword, null), ext, thread);
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   private static class AuxParam
/*      */     extends Param
/*      */   {
/*      */     Symbol var;
/*      */     boolean special;
/*      */     ArgumentListProcessor.InitForm initform;
/*      */     
/*      */     AuxParam(Symbol var, boolean special, LispObject form) {
/* 1058 */       this.var = var;
/* 1059 */       this.special = special;
/* 1060 */       this.initform = ArgumentListProcessor.createInitForm(form);
/*      */     }
/*      */ 
/*      */     
/*      */     void addVars(List<Symbol> vars) {
/* 1065 */       vars.add(this.var);
/*      */     }
/*      */ 
/*      */     
/*      */     int assign(int index, LispObject[] array, ArgumentListProcessor.ArgList args, Environment ext, LispThread thread) {
/* 1070 */       array[index++] = this.initform.getValue(ext, thread);
/*      */       
/* 1072 */       if (ext != null) {
/* 1073 */         Lisp.bindArg(this.special, this.var, array[index - 1], ext, thread);
/*      */       }
/* 1075 */       return index;
/*      */     }
/*      */ 
/*      */     
/*      */     boolean needsEnvironment() {
/* 1080 */       return this.initform.needsEnvironment();
/*      */     }
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ArgumentListProcessor.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */