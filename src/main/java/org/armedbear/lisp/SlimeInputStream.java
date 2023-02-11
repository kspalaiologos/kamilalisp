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
/*     */ public class SlimeInputStream
/*     */   extends Stream
/*     */ {
/*     */   String s;
/*     */   int length;
/*     */   final Function f;
/*     */   final Stream ostream;
/*     */   
/*     */   public SlimeInputStream(Function f, Stream ostream) {
/*  47 */     super(Symbol.SLIME_INPUT_STREAM);
/*  48 */     this.elementType = Symbol.CHARACTER;
/*  49 */     this.isInputStream = true;
/*  50 */     this.isOutputStream = false;
/*  51 */     this.isCharacterStream = true;
/*  52 */     this.isBinaryStream = false;
/*  53 */     this.eolStyle = Stream.EolStyle.LF;
/*  54 */     this.f = f;
/*  55 */     this.ostream = ostream;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  61 */     return Symbol.SLIME_INPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  67 */     return BuiltInClass.SLIME_INPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  73 */     if (type == Symbol.SLIME_INPUT_STREAM)
/*  74 */       return Lisp.T; 
/*  75 */     if (type == Symbol.STRING_STREAM)
/*  76 */       return Lisp.T; 
/*  77 */     if (type == BuiltInClass.SLIME_INPUT_STREAM)
/*  78 */       return Lisp.T; 
/*  79 */     if (type == BuiltInClass.STRING_STREAM)
/*  80 */       return Lisp.T; 
/*  81 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject close(LispObject abort) {
/*  87 */     setOpen(false);
/*  88 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/*  94 */     return (this.offset < this.length) ? Lisp.T : Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() {
/* 100 */     if (this.offset >= this.length) {
/* 101 */       this.ostream.finishOutput();
/* 102 */       this.s = LispThread.currentThread().execute(this.f).getStringValue();
/* 103 */       if (this.s.length() == 0)
/* 104 */         return -1; 
/* 105 */       this.offset = 0;
/* 106 */       this.length = this.s.length();
/*     */     } 
/* 108 */     int n = this.s.charAt(this.offset);
/* 109 */     this.offset++;
/* 110 */     if (n == 10)
/* 111 */       this.lineNumber++; 
/* 112 */     return n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) {
/* 118 */     if (this.offset > 0) {
/* 119 */       this.offset--;
/* 120 */       if (n == 10) {
/* 121 */         this.lineNumber--;
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   protected boolean _charReady() {
/* 128 */     return (this.offset < this.length);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 135 */     super._clearInput();
/* 136 */     this.s = "";
/* 137 */     this.offset = 0;
/* 138 */     this.length = 0;
/* 139 */     this.lineNumber = 0;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 144 */   private static final Primitive MAKE_SLIME_INPUT_STREAM = new Primitive("make-slime-input-stream", Lisp.PACKAGE_EXT, true, "function output-stream")
/*     */     {
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/*     */         Function fun;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 154 */         if (first instanceof Symbol) {
/* 155 */           fun = (Function)first.getSymbolFunction();
/*     */         } else {
/* 157 */           fun = (Function)first;
/* 158 */         }  Stream os = Lisp.checkCharacterOutputStream(second);
/* 159 */         return new SlimeInputStream(fun, os);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SlimeInputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */