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
/*     */ public class CellError
/*     */   extends LispError
/*     */ {
/*     */   protected CellError(LispClass cls) {
/*  42 */     super(cls);
/*     */   }
/*     */ 
/*     */   
/*     */   public CellError(LispObject initArgs) {
/*  47 */     super(StandardClass.CELL_ERROR);
/*  48 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  54 */     super.initialize(initArgs);
/*  55 */     LispObject name = Lisp.NIL;
/*  56 */     while (initArgs != Lisp.NIL) {
/*  57 */       LispObject first = initArgs.car();
/*  58 */       initArgs = initArgs.cdr();
/*  59 */       if (first == Keyword.NAME) {
/*  60 */         name = initArgs.car();
/*     */         break;
/*     */       } 
/*  63 */       initArgs = initArgs.cdr();
/*     */     } 
/*  65 */     setCellName(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getCellName() {
/*  70 */     return getInstanceSlotValue(Symbol.NAME);
/*     */   }
/*     */ 
/*     */   
/*     */   protected final void setCellName(LispObject name) {
/*  75 */     setInstanceSlotValue(Symbol.NAME, name);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  81 */     return Symbol.CELL_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  87 */     return StandardClass.CELL_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  93 */     if (type == Symbol.CELL_ERROR)
/*  94 */       return Lisp.T; 
/*  95 */     if (type == StandardClass.CELL_ERROR)
/*  96 */       return Lisp.T; 
/*  97 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/* 103 */     if (Symbol.PRINT_ESCAPE.symbolValue() == Lisp.NIL)
/* 104 */       return super.getMessage(); 
/* 105 */     StringBuffer sb = new StringBuffer(typeOf().princToString());
/* 106 */     sb.append(' ');
/* 107 */     sb.append(getCellName().princToString());
/* 108 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */   
/* 112 */   private static final Primitive CELL_ERROR_NAME = new Primitive("cell-error-name", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 118 */         if (arg.typep(Symbol.CELL_ERROR) == Lisp.NIL) {
/* 119 */           return Lisp.type_error(arg, Symbol.CELL_ERROR);
/*     */         }
/*     */         
/* 122 */         StandardObject obj = (StandardObject)arg;
/* 123 */         return obj.getInstanceSlotValue(Symbol.NAME);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CellError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */