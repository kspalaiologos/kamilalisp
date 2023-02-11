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
/*     */ public final class arglist
/*     */ {
/*     */   static final Operator getOperator(LispObject obj) {
/*  43 */     if (obj instanceof Operator)
/*  44 */       return (Operator)obj; 
/*  45 */     if (obj instanceof Symbol) {
/*  46 */       LispObject function = obj.getSymbolFunction();
/*  47 */       if (function instanceof Autoload) {
/*  48 */         Autoload autoload = (Autoload)function;
/*  49 */         autoload.load();
/*  50 */         function = autoload.getSymbol().getSymbolFunction();
/*     */       } 
/*  52 */       if (function instanceof Operator) {
/*  53 */         Operator operator = (Operator)function;
/*  54 */         if (operator.getLambdaList() != null)
/*  55 */           return operator; 
/*  56 */         LispObject other = Lisp.get(obj, Symbol.MACROEXPAND_MACRO, null);
/*  57 */         if (other != null) {
/*  58 */           return getOperator(other);
/*     */         }
/*  60 */         return null;
/*     */       } 
/*  62 */     } else if (obj instanceof Cons && obj.car() == Symbol.LAMBDA) {
/*  63 */       return new Closure(obj, new Environment());
/*  64 */     }  return null;
/*     */   }
/*     */ 
/*     */   
/*  68 */   private static final Primitive ARGLIST = new Primitive("arglist", Lisp.PACKAGE_EXT, true, "extended-function-designator")
/*     */     {
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*     */         LispObject value1, value2;
/*     */         
/*  74 */         LispThread thread = LispThread.currentThread();
/*  75 */         Operator operator = arglist.getOperator(arg);
/*  76 */         LispObject arglist = null;
/*  77 */         if (operator != null) {
/*  78 */           arglist = operator.getLambdaList();
/*     */         }
/*  80 */         if (arglist instanceof AbstractString) {
/*  81 */           String s = arglist.getStringValue();
/*     */           
/*  83 */           s = "(" + s + ")";
/*     */ 
/*     */           
/*  86 */           SpecialBindingsMark mark = thread.markSpecialBindings();
/*  87 */           thread.bindSpecial(Symbol._PACKAGE_, Lisp.PACKAGE_EXT);
/*     */           try {
/*  89 */             arglist = Lisp.readObjectFromString(s);
/*     */           } finally {
/*     */             
/*  92 */             thread.resetSpecialBindings(mark);
/*     */           } 
/*  94 */           operator.setLambdaList(arglist);
/*     */         } 
/*  96 */         if (arglist != null) {
/*  97 */           value1 = arglist;
/*  98 */           value2 = Lisp.T;
/*     */         } else {
/* 100 */           value1 = Lisp.NIL;
/* 101 */           value2 = Lisp.NIL;
/*     */         } 
/* 103 */         return thread.setValues(value1, value2);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 108 */   private static final Primitive _SET_ARGLIST = new Primitive("%set-arglist", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 115 */         Operator operator = null;
/* 116 */         if (first instanceof Operator) {
/* 117 */           operator = (Operator)first;
/* 118 */         } else if (first instanceof Symbol) {
/* 119 */           LispObject function = first.getSymbolFunction();
/* 120 */           if (function instanceof Operator)
/* 121 */             operator = (Operator)function; 
/*     */         } 
/* 123 */         if (operator != null)
/* 124 */           operator.setLambdaList(second); 
/* 125 */         return second;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/arglist.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */