/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.ObjectStreamException;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Nil
/*     */   extends Symbol
/*     */ {
/*  40 */   public static final Symbol NIL = new Nil(Lisp.PACKAGE_CL);
/*     */ 
/*     */   
/*     */   public Nil(Package pkg) {
/*  44 */     super("NIL", pkg);
/*  45 */     pkg.addSymbol(this);
/*  46 */     initializeConstant(this);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance() {
/*  52 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Object javaInstance(Class<Boolean> c) {
/*  58 */     if (c == Boolean.class || c == boolean.class)
/*  59 */       return Boolean.FALSE; 
/*  60 */     return javaInstance();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  66 */     return Symbol.NULL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  72 */     return BuiltInClass.NULL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/*  78 */     return new SimpleString("The symbol NIL");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean getBooleanValue() {
/*  84 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  90 */     if (typeSpecifier == Symbol.NULL)
/*  91 */       return T; 
/*  92 */     if (typeSpecifier == Symbol.LIST)
/*  93 */       return T; 
/*  94 */     if (typeSpecifier == Symbol.SEQUENCE)
/*  95 */       return T; 
/*  96 */     if (typeSpecifier == Symbol.SYMBOL)
/*  97 */       return T; 
/*  98 */     if (typeSpecifier == Symbol.BOOLEAN)
/*  99 */       return T; 
/* 100 */     if (typeSpecifier == BuiltInClass.NULL)
/* 101 */       return T; 
/* 102 */     if (typeSpecifier == BuiltInClass.LIST)
/* 103 */       return T; 
/* 104 */     if (typeSpecifier == BuiltInClass.SEQUENCE)
/* 105 */       return T; 
/* 106 */     if (typeSpecifier == BuiltInClass.SYMBOL)
/* 107 */       return T; 
/* 108 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean constantp() {
/* 114 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getSymbolValue() {
/* 120 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int length() {
/* 126 */     return 0;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NTH(int index) {
/* 132 */     if (index < 0) {
/* 133 */       Lisp.error(new TypeError(String.valueOf(index) + " is not of type UNSIGNED-BYTE."));
/*     */     }
/* 135 */     return NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject elt(int index) {
/* 141 */     return Lisp.error(new TypeError("ELT: invalid index " + index + " for " + this + "."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject reverse() {
/* 147 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject nreverse() {
/* 153 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject[] copyToArray() {
/* 159 */     return new LispObject[0];
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject NOT() {
/* 165 */     return T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getSymbolFunction() {
/* 171 */     return null;
/*     */   }
/*     */   
/*     */   public Object readResolve() throws ObjectStreamException {
/* 175 */     return NIL;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Nil.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */