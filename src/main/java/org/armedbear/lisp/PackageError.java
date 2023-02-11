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
/*     */ public final class PackageError
/*     */   extends LispError
/*     */ {
/*     */   public PackageError(LispObject initArgs) {
/*  42 */     super(StandardClass.PACKAGE_ERROR);
/*  43 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  49 */     super.initialize(initArgs);
/*     */     
/*  51 */     if (initArgs.listp() && initArgs.car().stringp()) {
/*  52 */       setFormatControl(initArgs.car().getStringValue());
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*  60 */       for (LispObject arg = initArgs.cdr(); arg != Lisp.NIL; arg = arg.cdr()) {
/*  61 */         if (arg.car() instanceof Symbol)
/*  62 */           arg.setCar(new SimpleString(((Symbol)arg.car()).getQualifiedName())); 
/*     */       } 
/*  64 */       setFormatArguments(initArgs.cdr());
/*  65 */       setPackage(Lisp.NIL);
/*     */       
/*     */       return;
/*     */     } 
/*     */     
/*  70 */     LispObject pkg = Lisp.NIL;
/*     */     
/*  72 */     while (initArgs != Lisp.NIL) {
/*  73 */       LispObject first = initArgs.car();
/*  74 */       initArgs = initArgs.cdr();
/*  75 */       LispObject second = initArgs.car();
/*  76 */       initArgs = initArgs.cdr();
/*  77 */       if (first == Keyword.PACKAGE)
/*  78 */         pkg = second; 
/*     */     } 
/*  80 */     setPackage(pkg);
/*     */   }
/*     */ 
/*     */   
/*     */   public PackageError(String message) {
/*  85 */     super(StandardClass.PACKAGE_ERROR);
/*  86 */     setFormatControl(message);
/*  87 */     setPackage(Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public PackageError(String message, LispObject pkg) {
/*  92 */     super(StandardClass.PACKAGE_ERROR);
/*  93 */     setFormatControl(message);
/*  94 */     setPackage(pkg);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 100 */     return Symbol.PACKAGE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 106 */     return StandardClass.PACKAGE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 112 */     if (type == Symbol.PACKAGE_ERROR)
/* 113 */       return Lisp.T; 
/* 114 */     if (type == StandardClass.PACKAGE_ERROR)
/* 115 */       return Lisp.T; 
/* 116 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getPackage() {
/* 121 */     return getInstanceSlotValue(Symbol.PACKAGE);
/*     */   }
/*     */ 
/*     */   
/*     */   public void setPackage(LispObject pkg) {
/* 126 */     setInstanceSlotValue(Symbol.PACKAGE, pkg);
/*     */   }
/*     */ 
/*     */   
/* 130 */   private static final Primitive PACKAGE_ERROR_PACKAGE = new Primitive("package-error-package", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 136 */         if (arg.typep(Symbol.PACKAGE_ERROR) == Lisp.NIL) {
/* 137 */           return Lisp.type_error(arg, Symbol.PACKAGE_ERROR);
/*     */         }
/*     */         
/* 140 */         StandardObject obj = (StandardObject)arg;
/* 141 */         return obj.getInstanceSlotValue(Symbol.PACKAGE);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/PackageError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */