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
/*     */ 
/*     */ public final class ZeroRankArray
/*     */   extends AbstractArray
/*     */ {
/*     */   private final LispObject elementType;
/*     */   private final boolean adjustable;
/*     */   private LispObject data;
/*     */   
/*     */   public ZeroRankArray(LispObject elementType, LispObject data, boolean adjustable) {
/*  48 */     this.elementType = elementType;
/*  49 */     this.data = data;
/*  50 */     this.adjustable = adjustable;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  56 */     if (this.adjustable) {
/*  57 */       return Lisp.list(Symbol.ARRAY, new LispObject[] { this.elementType, Lisp.NIL });
/*     */     }
/*  59 */     return Lisp.list(Symbol.SIMPLE_ARRAY, new LispObject[] { this.elementType, Lisp.NIL });
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  65 */     return BuiltInClass.ARRAY;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  71 */     if (type == Symbol.SIMPLE_ARRAY)
/*  72 */       return this.adjustable ? Lisp.NIL : Lisp.T; 
/*  73 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getRank() {
/*  79 */     return 0;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDimensions() {
/*  85 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getDimension(int n) {
/*  91 */     Lisp.error(new TypeError("Bad array dimension (" + n + ") for array of rank 0."));
/*     */     
/*  93 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  99 */     return this.elementType;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getTotalSize() {
/* 105 */     return 1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject AREF(int index) {
/* 111 */     if (index == 0) {
/* 112 */       return this.data;
/*     */     }
/* 114 */     return Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void aset(int index, LispObject obj) {
/* 120 */     if (obj.typep(this.elementType) == Lisp.NIL)
/* 121 */       Lisp.type_error(obj, this.elementType); 
/* 122 */     if (index == 0) {
/* 123 */       this.data = obj;
/*     */     } else {
/* 125 */       Lisp.error(new TypeError("Bad row major index " + index + "."));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void fill(LispObject obj) {
/* 131 */     if (obj.typep(this.elementType) == Lisp.NIL)
/* 132 */       Lisp.type_error(obj, this.elementType); 
/* 133 */     this.data = obj;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 139 */     LispThread thread = LispThread.currentThread();
/* 140 */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/* 141 */     if (printReadably && 
/* 142 */       this.elementType != Lisp.T) {
/* 143 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*     */       
/* 145 */       return null;
/*     */     } 
/*     */     
/* 148 */     if (printReadably || Symbol.PRINT_ARRAY.symbolValue(thread) != Lisp.NIL) {
/* 149 */       StringBuffer stringBuffer = new StringBuffer("#0A");
/* 150 */       if (this.data == this && Symbol.PRINT_CIRCLE.symbolValue(thread) != Lisp.NIL) {
/* 151 */         StringOutputStream stream = new StringOutputStream();
/* 152 */         thread.execute(Symbol.OUTPUT_OBJECT.getSymbolFunction(), this.data, stream);
/*     */         
/* 154 */         stringBuffer.append(stream.getString().getStringValue());
/*     */       } else {
/* 156 */         stringBuffer.append(this.data.printObject());
/* 157 */       }  return stringBuffer.toString();
/*     */     } 
/* 159 */     StringBuffer sb = new StringBuffer();
/* 160 */     if (!this.adjustable)
/* 161 */       sb.append("SIMPLE-"); 
/* 162 */     sb.append("ARRAY ");
/* 163 */     sb.append(this.elementType.printObject());
/* 164 */     sb.append(" NIL");
/* 165 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, LispObject initialElement, LispObject initialContents) {
/* 173 */     if (isAdjustable()) {
/*     */ 
/*     */       
/* 176 */       if (initialContents != null)
/* 177 */         this.data = initialContents; 
/* 178 */       return this;
/*     */     } 
/* 180 */     return new ZeroRankArray(this.elementType, (initialContents != null) ? initialContents : ((initialElement != null) ? initialElement : this.data), false);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public AbstractArray adjustArray(int[] dims, AbstractArray displacedTo, int displacement) {
/* 191 */     Lisp.error(new TypeError("Displacement not supported for array of rank 0."));
/* 192 */     return null;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ZeroRankArray.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */