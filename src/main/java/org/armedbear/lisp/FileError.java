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
/*     */ public final class FileError
/*     */   extends LispError
/*     */ {
/*     */   public FileError(LispObject initArgs) {
/*  43 */     super(StandardClass.FILE_ERROR);
/*  44 */     if (initArgs instanceof Cons) {
/*  45 */       initialize(initArgs);
/*     */     } else {
/*  47 */       setPathname(initArgs);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  53 */     super.initialize(initArgs);
/*  54 */     LispObject pathname = Lisp.NIL;
/*  55 */     while (initArgs != Lisp.NIL) {
/*  56 */       LispObject first = initArgs.car();
/*  57 */       initArgs = initArgs.cdr();
/*  58 */       if (first == Keyword.PATHNAME) {
/*  59 */         pathname = initArgs.car();
/*     */         break;
/*     */       } 
/*  62 */       initArgs = initArgs.cdr();
/*     */     } 
/*  64 */     setPathname(pathname);
/*     */   }
/*     */ 
/*     */   
/*     */   public FileError(String message) {
/*  69 */     super(StandardClass.FILE_ERROR);
/*  70 */     setFormatControl(message.replaceAll("~", "~~"));
/*  71 */     setFormatArguments(Lisp.NIL);
/*  72 */     setPathname(Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public FileError(String message, LispObject pathname) {
/*  78 */     super(StandardClass.FILE_ERROR);
/*  79 */     setFormatControl(message.replaceAll("~", "~~"));
/*  80 */     setFormatArguments(Lisp.NIL);
/*  81 */     setPathname(pathname);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getPathname() {
/*  86 */     return getInstanceSlotValue(Symbol.PATHNAME);
/*     */   }
/*     */ 
/*     */   
/*     */   private void setPathname(LispObject pathname) {
/*  91 */     setInstanceSlotValue(Symbol.PATHNAME, pathname);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  97 */     return Symbol.FILE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 103 */     return StandardClass.FILE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 109 */     if (type == Symbol.FILE_ERROR)
/* 110 */       return Lisp.T; 
/* 111 */     if (type == StandardClass.FILE_ERROR)
/* 112 */       return Lisp.T; 
/* 113 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/* 117 */   private static final Primitive FILE_ERROR_PATHNAME = new Primitive("file-error-pathname", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 123 */         if (arg.typep(Symbol.FILE_ERROR) == Lisp.NIL) {
/* 124 */           return Lisp.type_error(arg, Symbol.FILE_ERROR);
/*     */         }
/*     */         
/* 127 */         StandardObject obj = (StandardObject)arg;
/* 128 */         return obj.getInstanceSlotValue(Symbol.PATHNAME);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FileError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */