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
/*     */ public final class make_condition
/*     */   extends Primitive
/*     */ {
/*     */   private make_condition() {
/*  42 */     super("%make-condition", Lisp.PACKAGE_SYS, true);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject type, LispObject initArgs) {
/*     */     Symbol symbol;
/*  52 */     if (type instanceof Symbol) {
/*  53 */       symbol = (Symbol)type;
/*  54 */     } else if (type instanceof LispClass) {
/*  55 */       symbol = Lisp.checkSymbol(((LispClass)type).getName());
/*     */     } else {
/*     */       
/*  58 */       return Lisp.NIL;
/*     */     } 
/*     */     
/*  61 */     if (symbol == Symbol.ARITHMETIC_ERROR)
/*  62 */       return new ArithmeticError(initArgs); 
/*  63 */     if (symbol == Symbol.CELL_ERROR)
/*  64 */       return new CellError(initArgs); 
/*  65 */     if (symbol == Symbol.CONDITION)
/*  66 */       return new Condition(initArgs); 
/*  67 */     if (symbol == Symbol.CONTROL_ERROR)
/*  68 */       return new ControlError(initArgs); 
/*  69 */     if (symbol == Symbol.DIVISION_BY_ZERO)
/*  70 */       return new DivisionByZero(initArgs); 
/*  71 */     if (symbol == Symbol.END_OF_FILE)
/*  72 */       return new EndOfFile(initArgs); 
/*  73 */     if (symbol == Symbol.ERROR)
/*  74 */       return new LispError(initArgs); 
/*  75 */     if (symbol == Symbol.FILE_ERROR)
/*  76 */       return new FileError(initArgs); 
/*  77 */     if (symbol == Symbol.FLOATING_POINT_INEXACT)
/*  78 */       return new FloatingPointInexact(initArgs); 
/*  79 */     if (symbol == Symbol.FLOATING_POINT_INVALID_OPERATION)
/*  80 */       return new FloatingPointInvalidOperation(initArgs); 
/*  81 */     if (symbol == Symbol.FLOATING_POINT_OVERFLOW)
/*  82 */       return new FloatingPointOverflow(initArgs); 
/*  83 */     if (symbol == Symbol.FLOATING_POINT_UNDERFLOW)
/*  84 */       return new FloatingPointUnderflow(initArgs); 
/*  85 */     if (symbol == Symbol.PACKAGE_ERROR)
/*  86 */       return new PackageError(initArgs); 
/*  87 */     if (symbol == Symbol.PARSE_ERROR)
/*  88 */       return new ParseError(initArgs); 
/*  89 */     if (symbol == Symbol.PRINT_NOT_READABLE)
/*  90 */       return new PrintNotReadable(initArgs); 
/*  91 */     if (symbol == Symbol.PROGRAM_ERROR)
/*  92 */       return new ProgramError(initArgs); 
/*  93 */     if (symbol == Symbol.READER_ERROR)
/*  94 */       return new ReaderError(initArgs); 
/*  95 */     if (symbol == Symbol.SERIOUS_CONDITION)
/*  96 */       return new SeriousCondition(initArgs); 
/*  97 */     if (symbol == Symbol.SIMPLE_CONDITION)
/*  98 */       return new SimpleCondition(initArgs); 
/*  99 */     if (symbol == Symbol.SIMPLE_ERROR)
/* 100 */       return new SimpleError(initArgs); 
/* 101 */     if (symbol == Symbol.SIMPLE_TYPE_ERROR)
/* 102 */       return new SimpleTypeError(initArgs); 
/* 103 */     if (symbol == Symbol.SIMPLE_WARNING)
/* 104 */       return new SimpleWarning(initArgs); 
/* 105 */     if (symbol == Symbol.STORAGE_CONDITION)
/* 106 */       return new StorageCondition(initArgs); 
/* 107 */     if (symbol == Symbol.STREAM_ERROR)
/* 108 */       return new StreamError(initArgs); 
/* 109 */     if (symbol == Symbol.STYLE_WARNING)
/* 110 */       return new StyleWarning(initArgs); 
/* 111 */     if (symbol == Symbol.TYPE_ERROR)
/* 112 */       return new TypeError(initArgs); 
/* 113 */     if (symbol == Symbol.UNBOUND_SLOT)
/* 114 */       return new UnboundSlot(initArgs); 
/* 115 */     if (symbol == Symbol.UNBOUND_VARIABLE)
/* 116 */       return new UnboundVariable(initArgs); 
/* 117 */     if (symbol == Symbol.UNDEFINED_FUNCTION)
/* 118 */       return new UndefinedFunction(initArgs); 
/* 119 */     if (symbol == Symbol.WARNING) {
/* 120 */       return new Warning(initArgs);
/*     */     }
/* 122 */     return Lisp.NIL;
/*     */   }
/*     */   
/* 125 */   private static final Primitive MAKE_CONDITION = new make_condition();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/make_condition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */