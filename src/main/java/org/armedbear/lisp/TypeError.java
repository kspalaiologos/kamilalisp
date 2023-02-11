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
/*     */ public class TypeError
/*     */   extends LispError
/*     */ {
/*     */   public TypeError() {
/*  42 */     super(StandardClass.TYPE_ERROR);
/*     */   }
/*     */ 
/*     */   
/*     */   protected TypeError(LispClass cls) {
/*  47 */     super(cls);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public TypeError(LispObject datum, LispObject expectedType) {
/*  53 */     super(StandardClass.TYPE_ERROR);
/*  54 */     setDatum(datum);
/*  55 */     setExpectedType(expectedType);
/*     */   }
/*     */ 
/*     */   
/*     */   public TypeError(LispObject initArgs) {
/*  60 */     super(StandardClass.TYPE_ERROR);
/*  61 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  67 */     super.initialize(initArgs);
/*  68 */     LispObject datum = null;
/*  69 */     LispObject expectedType = null;
/*     */     
/*  71 */     while (initArgs != Lisp.NIL) {
/*  72 */       LispObject first = initArgs.car();
/*  73 */       initArgs = initArgs.cdr();
/*  74 */       LispObject second = initArgs.car();
/*  75 */       initArgs = initArgs.cdr();
/*  76 */       if (first == Keyword.DATUM) {
/*  77 */         if (datum == null)
/*  78 */           datum = second;  continue;
/*  79 */       }  if (first == Keyword.EXPECTED_TYPE && 
/*  80 */         expectedType == null) {
/*  81 */         expectedType = second;
/*     */       }
/*     */     } 
/*  84 */     if (datum != null)
/*  85 */       setDatum(datum); 
/*  86 */     if (expectedType != null) {
/*  87 */       setExpectedType(expectedType);
/*     */     }
/*     */   }
/*     */   
/*     */   public TypeError(String message) {
/*  92 */     super(StandardClass.TYPE_ERROR);
/*  93 */     setFormatControl(message);
/*  94 */     setDatum(Lisp.NIL);
/*  95 */     setExpectedType(Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public TypeError(String message, LispObject datum, LispObject expectedType) {
/* 101 */     super(StandardClass.TYPE_ERROR);
/* 102 */     setFormatControl(message);
/* 103 */     setDatum(datum);
/* 104 */     setExpectedType(expectedType);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 110 */     return Symbol.TYPE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 116 */     return StandardClass.TYPE_ERROR;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 122 */     if (type == Symbol.TYPE_ERROR)
/* 123 */       return Lisp.T; 
/* 124 */     if (type == StandardClass.TYPE_ERROR)
/* 125 */       return Lisp.T; 
/* 126 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/* 132 */     LispThread thread = LispThread.currentThread();
/* 133 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 134 */     thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.T);
/*     */     try {
/* 136 */       String s = super.getMessage();
/* 137 */       if (s != null)
/* 138 */         return s; 
/* 139 */       LispObject datum = getDatum();
/* 140 */       LispObject expectedType = getExpectedType();
/* 141 */       StringBuilder sb = new StringBuilder();
/* 142 */       String name = (datum != null) ? datum.princToString() : null;
/* 143 */       String type = null;
/* 144 */       if (expectedType != null)
/* 145 */         type = expectedType.princToString(); 
/* 146 */       if (type != null) {
/* 147 */         if (name != null) {
/* 148 */           sb.append("The value ");
/* 149 */           sb.append(name);
/*     */         } else {
/* 151 */           sb.append("Value");
/* 152 */         }  sb.append(" is not of type ");
/* 153 */         sb.append(type);
/* 154 */       } else if (name != null) {
/* 155 */         sb.append("Wrong type: ");
/* 156 */         sb.append(name);
/*     */       } 
/* 158 */       sb.append('.');
/* 159 */       return sb.toString();
/*     */     } finally {
/*     */       
/* 162 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getDatum() {
/* 168 */     return getInstanceSlotValue(Symbol.DATUM);
/*     */   }
/*     */ 
/*     */   
/*     */   private final void setDatum(LispObject datum) {
/* 173 */     setInstanceSlotValue(Symbol.DATUM, datum);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getExpectedType() {
/* 178 */     return getInstanceSlotValue(Symbol.EXPECTED_TYPE);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private final void setExpectedType(LispObject expectedType) {
/* 184 */     setInstanceSlotValue(Symbol.EXPECTED_TYPE, expectedType);
/*     */   }
/*     */ 
/*     */   
/* 188 */   private static final Primitive TYPE_ERROR_DATUM = new Primitive(Symbol.TYPE_ERROR_DATUM, "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 194 */         if (arg.typep(Symbol.TYPE_ERROR) == Lisp.NIL) {
/* 195 */           return Lisp.type_error(arg, Symbol.TYPE_ERROR);
/*     */         }
/*     */         
/* 198 */         StandardObject obj = (StandardObject)arg;
/* 199 */         return obj.getInstanceSlotValue(Symbol.DATUM);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 204 */   private static final Primitive TYPE_ERROR_EXPECTED_TYPE = new Primitive(Symbol.TYPE_ERROR_EXPECTED_TYPE, "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 210 */         if (arg.typep(Symbol.TYPE_ERROR) == Lisp.NIL) {
/* 211 */           return Lisp.type_error(arg, Symbol.TYPE_ERROR);
/*     */         }
/*     */         
/* 214 */         StandardObject obj = (StandardObject)arg;
/* 215 */         return obj.getInstanceSlotValue(Symbol.EXPECTED_TYPE);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/TypeError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */