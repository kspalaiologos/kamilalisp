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
/*     */ public class LispStackFrame
/*     */   extends StackFrame
/*     */ {
/*     */   public final LispObject operator;
/*     */   private final LispObject[] args;
/*     */   public LispThread thread;
/*     */   
/*     */   private static final class UnavailableArgument
/*     */     extends LispObject
/*     */   {
/*     */     public String printObject() {
/*  49 */       return unreadableString("unavailable arg", false);
/*     */     }
/*     */   }
/*     */   
/*  53 */   private static final LispObject UNAVAILABLE_ARG = new UnavailableArgument();
/*     */ 
/*     */   
/*     */   public LispStackFrame(Object[] stack, int framePos, int numArgs) {
/*  57 */     this.operator = (LispObject)stack[framePos];
/*  58 */     this.args = new LispObject[numArgs];
/*  59 */     for (int i = 0; i < numArgs; i++)
/*     */     {
/*  61 */       this.args[i] = (LispObject)stack[framePos + 1 + i];
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  67 */     return Symbol.LISP_STACK_FRAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  72 */     return BuiltInClass.LISP_STACK_FRAME;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/*  78 */     String result = "";
/*  79 */     String LISP_STACK_FRAME = "LISP-STACK-FRAME";
/*     */     try {
/*  81 */       result = unreadableString("LISP-STACK-FRAME " + toLispList().printObject());
/*  82 */     } catch (Throwable t) {
/*  83 */       Debug.trace("Serious printing error: ");
/*  84 */       Debug.trace(t);
/*  85 */       result = unreadableString("LISP-STACK-FRAME");
/*     */     } 
/*  87 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  94 */     if (typeSpecifier == Symbol.LISP_STACK_FRAME)
/*  95 */       return Lisp.T; 
/*  96 */     if (typeSpecifier == BuiltInClass.LISP_STACK_FRAME)
/*  97 */       return Lisp.T; 
/*  98 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject toLispList() {
/* 104 */     LispObject result = argsToLispList();
/* 105 */     if (this.operator instanceof Operator) {
/* 106 */       LispObject lambdaName = ((Operator)this.operator).getLambdaName();
/* 107 */       if (lambdaName != null && lambdaName != Lisp.NIL)
/* 108 */         return result.push(lambdaName); 
/*     */     } 
/* 110 */     return result.push(this.operator);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private LispObject argsToLispList() {
/* 116 */     LispObject result = Lisp.NIL;
/* 117 */     for (int i = 0; i < this.args.length; i++) {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 123 */       if (this.args[i] == null)
/* 124 */       { result = result.push(UNAVAILABLE_ARG); }
/*     */       else
/* 126 */       { result = result.push(this.args[i]); } 
/* 127 */     }  return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleString toLispString() {
/*     */     String result;
/*     */     try {
/* 135 */       result = toLispList().printObject();
/* 136 */     } catch (Throwable t) {
/* 137 */       Debug.trace("Serious printing error: ");
/* 138 */       Debug.trace(t);
/* 139 */       result = unreadableString("LISP-STACK-FRAME");
/*     */     } 
/* 141 */     return new SimpleString(result);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getNumArgs() {
/* 146 */     return this.args.length;
/*     */   }
/*     */   
/*     */   public LispObject getOperator() {
/* 150 */     return this.operator;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getParts() {
/* 157 */     LispObject result = Lisp.NIL;
/* 158 */     result = result.push(new Cons("OPERATOR", getOperator()));
/* 159 */     LispObject args = argsToLispList();
/* 160 */     if (args != Lisp.NIL) {
/* 161 */       result = result.push(new Cons("ARGS", args));
/*     */     }
/*     */     
/* 164 */     return result.nreverse();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispStackFrame.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */