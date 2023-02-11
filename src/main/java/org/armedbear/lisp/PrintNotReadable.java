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
/*     */ public class PrintNotReadable
/*     */   extends LispError
/*     */ {
/*     */   public PrintNotReadable(LispObject initArgs) {
/*  42 */     super(StandardClass.PRINT_NOT_READABLE);
/*  43 */     initialize(initArgs);
/*  44 */     LispObject object = null;
/*  45 */     while (initArgs != Lisp.NIL) {
/*  46 */       LispObject first = initArgs.car();
/*  47 */       initArgs = initArgs.cdr();
/*  48 */       LispObject second = initArgs.car();
/*  49 */       initArgs = initArgs.cdr();
/*  50 */       if (first == Keyword.OBJECT) {
/*  51 */         object = second;
/*     */         break;
/*     */       } 
/*     */     } 
/*  55 */     if (object != null) {
/*  56 */       setInstanceSlotValue(Symbol.OBJECT, object);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  62 */     return Symbol.PRINT_NOT_READABLE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  68 */     return StandardClass.PRINT_NOT_READABLE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  74 */     if (type == Symbol.PRINT_NOT_READABLE)
/*  75 */       return Lisp.T; 
/*  76 */     if (type == StandardClass.PRINT_NOT_READABLE)
/*  77 */       return Lisp.T; 
/*  78 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getMessage() {
/*  84 */     StringBuilder sb = new StringBuilder();
/*  85 */     LispObject object = Lisp.UNBOUND_VALUE;
/*  86 */     object = getInstanceSlotValue(Symbol.OBJECT);
/*  87 */     if (object != Lisp.UNBOUND_VALUE) {
/*  88 */       sb.append(object.princToString());
/*     */     } else {
/*  90 */       sb.append("Object");
/*  91 */     }  sb.append(" cannot be printed readably.");
/*  92 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   
/*  96 */   private static final Primitive PRINT_NOT_READABLE_OBJECT = new Primitive("print-not-readable-object", "condition")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 102 */         if (arg instanceof PrintNotReadable) return ((PrintNotReadable)arg).getInstanceSlotValue(Symbol.OBJECT); 
/* 103 */         return Lisp.type_error(arg, Symbol.PRINT_NOT_READABLE);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/PrintNotReadable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */