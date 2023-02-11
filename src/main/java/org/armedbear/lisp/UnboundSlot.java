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
/*     */ public final class UnboundSlot
/*     */   extends CellError
/*     */ {
/*     */   public UnboundSlot(LispObject initArgs) {
/*  42 */     super(StandardClass.UNBOUND_SLOT);
/*  43 */     initialize(initArgs);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void initialize(LispObject initArgs) {
/*  49 */     super.initialize(initArgs);
/*  50 */     while (initArgs != Lisp.NIL) {
/*  51 */       LispObject first = initArgs.car();
/*  52 */       initArgs = initArgs.cdr();
/*  53 */       if (first == Keyword.INSTANCE) {
/*  54 */         setInstance(initArgs.car());
/*     */         break;
/*     */       } 
/*  57 */       initArgs = initArgs.cdr();
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getInstance() {
/*  63 */     return getInstanceSlotValue(Symbol.INSTANCE);
/*     */   }
/*     */ 
/*     */   
/*     */   private void setInstance(LispObject instance) {
/*  68 */     setInstanceSlotValue(Symbol.INSTANCE, instance);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/*  74 */     LispThread thread = LispThread.currentThread();
/*  75 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*  76 */     thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.T);
/*     */     try {
/*  78 */       StringBuilder sb = new StringBuilder("The slot ");
/*  79 */       sb.append(getCellName().princToString());
/*  80 */       sb.append(" is unbound in the object ");
/*  81 */       sb.append(getInstance().princToString());
/*  82 */       sb.append('.');
/*  83 */       return sb.toString();
/*     */     } finally {
/*     */       
/*  86 */       thread.resetSpecialBindings(mark);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  93 */     return Symbol.UNBOUND_SLOT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  99 */     return StandardClass.UNBOUND_SLOT;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 105 */     if (type == Symbol.UNBOUND_SLOT)
/* 106 */       return Lisp.T; 
/* 107 */     if (type == StandardClass.UNBOUND_SLOT)
/* 108 */       return Lisp.T; 
/* 109 */     return super.typep(type);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/UnboundSlot.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */