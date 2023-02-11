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
/*     */ public class ArithmeticError
/*     */   extends LispError
/*     */ {
/*     */   protected ArithmeticError(LispClass cls) {
/*  42 */     super(cls);
/*     */   }
/*     */ 
/*     */   
/*     */   public ArithmeticError(LispObject initArgs) {
/*  47 */     super(StandardClass.ARITHMETIC_ERROR);
/*  48 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  54 */     super.initialize(initArgs);
/*  55 */     LispObject operation = Lisp.NIL;
/*  56 */     LispObject operands = Lisp.NIL;
/*     */     
/*  58 */     while (initArgs != Lisp.NIL) {
/*  59 */       LispObject first = initArgs.car();
/*  60 */       initArgs = initArgs.cdr();
/*  61 */       LispObject second = initArgs.car();
/*  62 */       initArgs = initArgs.cdr();
/*  63 */       if (first == Keyword.OPERATION) {
/*  64 */         operation = second; continue;
/*  65 */       }  if (first == Keyword.OPERANDS)
/*  66 */         operands = second; 
/*     */     } 
/*  68 */     setOperation(operation);
/*  69 */     setOperands(operands);
/*     */   }
/*     */ 
/*     */   
/*     */   public ArithmeticError(String message) {
/*  74 */     super(StandardClass.ARITHMETIC_ERROR);
/*  75 */     setFormatControl(message.replaceAll("~", "~~"));
/*  76 */     setFormatArguments(Lisp.NIL);
/*  77 */     setOperation(Lisp.NIL);
/*  78 */     setOperands(Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  84 */     return Symbol.ARITHMETIC_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  90 */     return StandardClass.ARITHMETIC_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  96 */     if (type == Symbol.ARITHMETIC_ERROR)
/*  97 */       return Lisp.T; 
/*  98 */     if (type == StandardClass.ARITHMETIC_ERROR)
/*  99 */       return Lisp.T; 
/* 100 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   final LispObject getOperation() {
/* 105 */     return getInstanceSlotValue(Symbol.OPERATION);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private final void setOperation(LispObject operation) {
/* 111 */     setInstanceSlotValue(Symbol.OPERATION, operation);
/*     */   }
/*     */ 
/*     */   
/*     */   final LispObject getOperands() {
/* 116 */     return getInstanceSlotValue(Symbol.OPERANDS);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private final void setOperands(LispObject operands) {
/* 122 */     setInstanceSlotValue(Symbol.OPERANDS, operands);
/*     */   }
/*     */ 
/*     */   
/* 126 */   private static final Primitive ARITHMETIC_ERROR_OPERATION = new Primitive("arithmetic-error-operation", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 132 */         if (arg.typep(Symbol.ARITHMETIC_ERROR) == Lisp.NIL) {
/* 133 */           return Lisp.type_error(arg, Symbol.ARITHMETIC_ERROR);
/*     */         }
/*     */         
/* 136 */         StandardObject obj = (StandardObject)arg;
/* 137 */         return obj.getInstanceSlotValue(Symbol.OPERATION);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 142 */   private static final Primitive ARITHMETIC_ERROR_OPERANDS = new Primitive("arithmetic-error-operands", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 148 */         if (arg.typep(Symbol.ARITHMETIC_ERROR) == Lisp.NIL) {
/* 149 */           return Lisp.type_error(arg, Symbol.ARITHMETIC_ERROR);
/*     */         }
/*     */         
/* 152 */         StandardObject obj = (StandardObject)arg;
/* 153 */         return obj.getInstanceSlotValue(Symbol.OPERANDS);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ArithmeticError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */