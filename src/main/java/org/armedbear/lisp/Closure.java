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
/*     */ public class Closure
/*     */   extends Function
/*     */ {
/*     */   public static final int REQUIRED = 0;
/*     */   public static final int OPTIONAL = 1;
/*     */   public static final int KEYWORD = 2;
/*     */   public static final int REST = 3;
/*     */   public static final int AUX = 4;
/*     */   private final LispObject body;
/*     */   private final LispObject executionBody;
/*     */   private final Environment environment;
/*     */   private final Symbol[] freeSpecials;
/*     */   private final ArgumentListProcessor arglist;
/*     */   
/*     */   public Closure(ArgumentListProcessor arglist) {
/*  68 */     this.body = null;
/*  69 */     this.executionBody = null;
/*  70 */     this.environment = null;
/*  71 */     this.arglist = arglist;
/*  72 */     this.freeSpecials = new Symbol[0];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Closure(LispObject lambdaExpression, Environment env) {
/*  78 */     this(null, lambdaExpression, env);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Closure(LispObject name, LispObject lambdaExpression, Environment env) {
/*  85 */     super(name, lambdaExpression.cadr());
/*  86 */     LispObject lambdaList = lambdaExpression.cadr();
/*  87 */     setLambdaList(lambdaList);
/*  88 */     if (lambdaList != Lisp.NIL && !(lambdaList instanceof Cons)) {
/*  89 */       Lisp.program_error("The lambda list " + lambdaList.princToString() + " is invalid.");
/*     */     }
/*  91 */     this.body = lambdaExpression.cddr();
/*  92 */     LispObject bodyAndDecls = Lisp.parseBody(this.body, false);
/*  93 */     this.executionBody = bodyAndDecls.car();
/*  94 */     LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/*     */     
/*  96 */     this.environment = env;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 104 */     this
/* 105 */       .arglist = new ArgumentListProcessor(this, lambdaList, specials, (lambdaExpression.car() == Symbol.MACRO_FUNCTION) ? ArgumentListProcessor.LambdaListType.MACRO : ArgumentListProcessor.LambdaListType.ORDINARY);
/*     */ 
/*     */     
/* 108 */     this.freeSpecials = this.arglist.freeSpecials(specials);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 114 */     if (typeSpecifier == Symbol.COMPILED_FUNCTION)
/* 115 */       return Lisp.NIL; 
/* 116 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getVariableList() {
/* 121 */     Symbol[] variables = this.arglist.getVariables();
/* 122 */     LispObject result = Lisp.NIL;
/* 123 */     for (int i = variables.length; i-- > 0;)
/* 124 */       result = new Cons(variables[i], result); 
/* 125 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getBody() {
/* 131 */     return this.body;
/*     */   }
/*     */ 
/*     */   
/*     */   public final Environment getEnvironment() {
/* 136 */     return this.environment;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/* 142 */     return execute(new LispObject[0]);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/* 148 */     return execute(new LispObject[] { arg });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 154 */     return execute(new LispObject[] { first, second });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 161 */     return execute(new LispObject[] { first, second, third });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 168 */     return execute(new LispObject[] { first, second, third, fourth });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 176 */     return execute(new LispObject[] { first, second, third, fourth, fifth });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 184 */     return execute(new LispObject[] { first, second, third, fourth, fifth, sixth });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 194 */     return execute(new LispObject[] { first, second, third, fourth, fifth, sixth, seventh });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/* 204 */     return execute(new LispObject[] { first, second, third, fourth, fifth, sixth, seventh, eighth });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 211 */     LispThread thread = LispThread.currentThread();
/* 212 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 213 */     Environment ext = new Environment(this.environment);
/* 214 */     args = this.arglist.match(args, this.environment, ext, thread);
/* 215 */     this.arglist.bindVars(args, ext, thread);
/* 216 */     for (Symbol special : this.freeSpecials) {
/* 217 */       ext.declareSpecial(special);
/*     */     }
/*     */     try {
/* 220 */       return Lisp.progn(this.executionBody, ext, thread);
/*     */     }
/*     */     finally {
/*     */       
/* 224 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   protected final LispObject[] processArgs(LispObject[] args, LispThread thread) {
/* 230 */     return this.arglist.match(args, this.environment, this.environment, thread);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean shouldSerializeByName() {
/* 237 */     return false;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Closure.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */