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
/*     */ public class SimpleCondition
/*     */   extends Condition
/*     */ {
/*     */   public SimpleCondition() {
/*  42 */     setFormatControl(Lisp.NIL);
/*  43 */     setFormatArguments(Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public SimpleCondition(LispObject formatControl, LispObject formatArguments) {
/*  49 */     setFormatControl(formatControl);
/*  50 */     setFormatArguments(formatArguments);
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleCondition(LispObject initArgs) {
/*  55 */     super(initArgs);
/*     */   }
/*     */ 
/*     */   
/*     */   public SimpleCondition(String message) {
/*  60 */     super(message);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  66 */     return Symbol.SIMPLE_CONDITION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  72 */     return StandardClass.SIMPLE_CONDITION;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  78 */     if (type == Symbol.SIMPLE_CONDITION)
/*  79 */       return Lisp.T; 
/*  80 */     if (type == StandardClass.SIMPLE_CONDITION)
/*  81 */       return Lisp.T; 
/*  82 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*  86 */   private static final Primitive SIMPLE_CONDITION_FORMAT_CONTROL = new Primitive(Symbol.SIMPLE_CONDITION_FORMAT_CONTROL, "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  92 */         return Symbol.STD_SLOT_VALUE.execute(arg, Symbol.FORMAT_CONTROL);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  97 */   private static final Primitive SIMPLE_CONDITION_FORMAT_ARGUMENTS = new Primitive(Symbol.SIMPLE_CONDITION_FORMAT_ARGUMENTS, "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 103 */         return Symbol.STD_SLOT_VALUE.execute(arg, Symbol.FORMAT_ARGUMENTS);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SimpleCondition.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */