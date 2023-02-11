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
/*     */ public class Condition
/*     */   extends StandardObject
/*     */ {
/*     */   protected String message;
/*     */   
/*     */   public Condition() {
/*  44 */     super(StandardClass.CONDITION);
/*  45 */     Debug.assertTrue((this.slots.length == 2));
/*  46 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   protected Condition(LispClass cls) {
/*  51 */     super(cls);
/*  52 */     Debug.assertTrue((this.slots.length >= 2));
/*  53 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public Condition(LispClass cls, int length) {
/*  58 */     super(cls, length);
/*     */   }
/*     */ 
/*     */   
/*     */   public Condition(LispObject initArgs) {
/*  63 */     super(StandardClass.CONDITION);
/*  64 */     Debug.assertTrue((this.slots.length == 2));
/*  65 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  70 */     LispObject control = null;
/*  71 */     LispObject arguments = null;
/*     */     
/*  73 */     while (initArgs instanceof Cons) {
/*     */       
/*  75 */       LispObject first = initArgs.car();
/*  76 */       initArgs = initArgs.cdr();
/*  77 */       LispObject second = initArgs.car();
/*  78 */       initArgs = initArgs.cdr();
/*  79 */       if (first == Keyword.FORMAT_CONTROL) {
/*     */         
/*  81 */         if (control == null)
/*  82 */           control = second;  continue;
/*     */       } 
/*  84 */       if (first == Keyword.FORMAT_ARGUMENTS)
/*     */       {
/*  86 */         if (arguments == null)
/*  87 */           arguments = second; 
/*     */       }
/*     */     } 
/*  90 */     if (control != null)
/*  91 */       setFormatControl(control); 
/*  92 */     if (arguments == null)
/*  93 */       arguments = Lisp.NIL; 
/*  94 */     setFormatArguments(arguments);
/*     */   }
/*     */ 
/*     */   
/*     */   public Condition(String message) {
/*  99 */     super(StandardClass.CONDITION);
/* 100 */     Debug.assertTrue((this.slots.length == 2));
/* 101 */     setFormatControl(message.replaceAll("~", "~~"));
/* 102 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getFormatControl() {
/* 107 */     return getInstanceSlotValue(Symbol.FORMAT_CONTROL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setFormatControl(LispObject formatControl) {
/* 113 */     setInstanceSlotValue(Symbol.FORMAT_CONTROL, formatControl);
/*     */   }
/*     */ 
/*     */   
/*     */   public final void setFormatControl(String s) {
/* 118 */     setFormatControl(new SimpleString(s));
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getFormatArguments() {
/* 123 */     return getInstanceSlotValue(Symbol.FORMAT_ARGUMENTS);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setFormatArguments(LispObject formatArguments) {
/* 129 */     setInstanceSlotValue(Symbol.FORMAT_ARGUMENTS, formatArguments);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/* 138 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 144 */     LispObject c = getLispClass();
/* 145 */     if (c instanceof LispClass)
/* 146 */       return ((LispClass)c).getName(); 
/* 147 */     if (c != null)
/* 148 */       return Symbol.CLASS_NAME.execute(c); 
/* 149 */     return Symbol.CONDITION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 155 */     LispObject c = getLispClass();
/* 156 */     if (c != null)
/* 157 */       return c; 
/* 158 */     return StandardClass.CONDITION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 164 */     if (type == Symbol.CONDITION)
/* 165 */       return Lisp.T; 
/* 166 */     if (type == StandardClass.CONDITION)
/* 167 */       return Lisp.T; 
/* 168 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public String getConditionReport() {
/* 173 */     String s = getMessage();
/* 174 */     if (s != null)
/* 175 */       return s; 
/* 176 */     LispObject formatControl = getFormatControl();
/* 177 */     if (formatControl != Lisp.NIL)
/*     */     {
/* 179 */       return Lisp.format(formatControl, getFormatArguments());
/*     */     }
/* 181 */     return unreadableString(typeOf().princToString());
/*     */   }
/*     */ 
/*     */   
/*     */   public final String printObject() {
/*     */     int maxLevel;
/* 187 */     LispThread thread = LispThread.currentThread();
/* 188 */     if (Symbol.PRINT_ESCAPE.symbolValue(thread) == Lisp.NIL) {
/*     */       
/* 190 */       String s = getMessage();
/* 191 */       if (s != null)
/* 192 */         return s; 
/* 193 */       LispObject formatControl = getFormatControl();
/* 194 */       if (formatControl instanceof Function) {
/*     */         
/* 196 */         StringOutputStream stream = new StringOutputStream();
/* 197 */         Symbol.APPLY.execute(formatControl, stream, getFormatArguments());
/* 198 */         return stream.getString().getStringValue();
/*     */       } 
/* 200 */       if (formatControl instanceof AbstractString) {
/*     */         
/* 202 */         LispObject f = Symbol.FORMAT.getSymbolFunction();
/* 203 */         if (f == null || f instanceof Autoload)
/* 204 */           return Lisp.format(formatControl, getFormatArguments()); 
/* 205 */         return Symbol.APPLY.execute(f, Lisp.NIL, formatControl, getFormatArguments()).getStringValue();
/*     */       } 
/*     */     } 
/*     */     
/* 209 */     LispObject printLevel = Symbol.PRINT_LEVEL.symbolValue(thread);
/* 210 */     if (printLevel instanceof Fixnum) {
/* 211 */       maxLevel = ((Fixnum)printLevel).value;
/*     */     } else {
/* 213 */       maxLevel = Integer.MAX_VALUE;
/*     */     } 
/* 215 */     LispObject currentPrintLevel = Lisp._CURRENT_PRINT_LEVEL_.symbolValue(thread);
/* 216 */     int currentLevel = ((Fixnum)currentPrintLevel).value;
/* 217 */     if (currentLevel >= maxLevel)
/* 218 */       return "#"; 
/* 219 */     return unreadableString(typeOf().princToString());
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Condition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */