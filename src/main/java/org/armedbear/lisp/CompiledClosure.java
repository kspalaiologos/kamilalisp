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
/*     */ public class CompiledClosure
/*     */   extends Closure
/*     */   implements Cloneable
/*     */ {
/*     */   public ClosureBinding[] ctx;
/*     */   
/*     */   public CompiledClosure(ArgumentListProcessor arglist) {
/*  46 */     super(arglist);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public CompiledClosure(LispObject lambdaList) {
/*  52 */     super(Lisp.list(Symbol.LAMBDA, new LispObject[] { lambdaList }), null);
/*     */   }
/*     */ 
/*     */   
/*     */   public final CompiledClosure setContext(ClosureBinding[] context) {
/*  57 */     this.ctx = context;
/*  58 */     return this;
/*     */   }
/*     */ 
/*     */   
/*     */   public final CompiledClosure dup() {
/*  63 */     CompiledClosure result = null;
/*     */     try {
/*  65 */       result = (CompiledClosure)clone();
/*  66 */     } catch (CloneNotSupportedException cloneNotSupportedException) {}
/*     */     
/*  68 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  74 */     if (typeSpecifier == Symbol.COMPILED_FUNCTION)
/*  75 */       return Lisp.T; 
/*  76 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   private final LispObject notImplemented() {
/*  81 */     return Lisp.error(new WrongNumberOfArgumentsException(this));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute() {
/*  88 */     LispObject[] args = new LispObject[0];
/*  89 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first) {
/*  96 */     LispObject[] args = new LispObject[1];
/*  97 */     args[0] = first;
/*  98 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/* 106 */     LispObject[] args = new LispObject[2];
/* 107 */     args[0] = first;
/* 108 */     args[1] = second;
/* 109 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 117 */     LispObject[] args = new LispObject[3];
/* 118 */     args[0] = first;
/* 119 */     args[1] = second;
/* 120 */     args[2] = third;
/* 121 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 130 */     LispObject[] args = new LispObject[4];
/* 131 */     args[0] = first;
/* 132 */     args[1] = second;
/* 133 */     args[2] = third;
/* 134 */     args[3] = fourth;
/* 135 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 144 */     LispObject[] args = new LispObject[5];
/* 145 */     args[0] = first;
/* 146 */     args[1] = second;
/* 147 */     args[2] = third;
/* 148 */     args[3] = fourth;
/* 149 */     args[4] = fifth;
/* 150 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 160 */     LispObject[] args = new LispObject[6];
/* 161 */     args[0] = first;
/* 162 */     args[1] = second;
/* 163 */     args[2] = third;
/* 164 */     args[3] = fourth;
/* 165 */     args[4] = fifth;
/* 166 */     args[5] = sixth;
/* 167 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 177 */     LispObject[] args = new LispObject[7];
/* 178 */     args[0] = first;
/* 179 */     args[1] = second;
/* 180 */     args[2] = third;
/* 181 */     args[3] = fourth;
/* 182 */     args[4] = fifth;
/* 183 */     args[5] = sixth;
/* 184 */     args[6] = seventh;
/* 185 */     return execute(args);
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
/* 196 */     LispObject[] args = new LispObject[8];
/* 197 */     args[0] = first;
/* 198 */     args[1] = second;
/* 199 */     args[2] = third;
/* 200 */     args[3] = fourth;
/* 201 */     args[4] = fifth;
/* 202 */     args[5] = sixth;
/* 203 */     args[6] = seventh;
/* 204 */     args[7] = eighth;
/* 205 */     return execute(args);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject[] args) {
/* 212 */     return notImplemented();
/*     */   }
/*     */ 
/*     */   
/* 216 */   private static final Primitive LOAD_COMPILED_FUNCTION = new Primitive("load-compiled-function", Lisp.PACKAGE_SYS, true, "source")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 222 */         String namestring = null;
/* 223 */         if (arg instanceof Pathname) {
/* 224 */           namestring = ((Pathname)arg).getNamestring();
/* 225 */         } else if (arg instanceof AbstractString) {
/* 226 */           namestring = arg.getStringValue();
/* 227 */         }  if (arg instanceof JavaObject) {
/*     */           try {
/* 229 */             return Lisp.loadClassBytes((byte[])arg.javaInstance(byte[].class));
/* 230 */           } catch (Throwable t) {
/* 231 */             Debug.trace(t);
/* 232 */             return Lisp.error(new LispError("Unable to load " + arg.princToString()));
/*     */           } 
/*     */         }
/* 235 */         return Lisp.error(new LispError("Unable to load " + arg.princToString()));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 240 */   private static final Primitive VARLIST = new Primitive("varlist", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 246 */         if (arg instanceof Closure)
/* 247 */           return ((Closure)arg).getVariableList(); 
/* 248 */         return Lisp.type_error(arg, Symbol.COMPILED_FUNCTION);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CompiledClosure.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */