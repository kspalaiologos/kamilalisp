/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.StringWriter;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class SlimeOutputStream
/*     */   extends Stream
/*     */ {
/*     */   private final StringWriter stringWriter;
/*     */   final Function f;
/*     */   
/*     */   SlimeOutputStream(Function f) {
/*  47 */     super(Symbol.SLIME_OUTPUT_STREAM);
/*  48 */     this.elementType = Symbol.CHARACTER;
/*  49 */     this.isInputStream = false;
/*  50 */     this.isOutputStream = true;
/*  51 */     this.isCharacterStream = true;
/*  52 */     this.isBinaryStream = false;
/*  53 */     this.eolStyle = Stream.EolStyle.LF;
/*  54 */     setWriter(this.stringWriter = new StringWriter());
/*  55 */     this.f = f;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  61 */     return Symbol.SLIME_OUTPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  67 */     return BuiltInClass.SLIME_OUTPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  73 */     if (type == Symbol.SLIME_OUTPUT_STREAM)
/*  74 */       return Lisp.T; 
/*  75 */     if (type == Symbol.STRING_STREAM)
/*  76 */       return Lisp.T; 
/*  77 */     if (type == BuiltInClass.SLIME_OUTPUT_STREAM)
/*  78 */       return Lisp.T; 
/*  79 */     if (type == BuiltInClass.STRING_STREAM)
/*  80 */       return Lisp.T; 
/*  81 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/*  87 */     if (this.elementType == Lisp.NIL)
/*  88 */       writeError(); 
/*  89 */     super._writeChar(c);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/*  96 */     if (this.elementType == Lisp.NIL)
/*  97 */       writeError(); 
/*  98 */     super._writeChars(chars, start, end);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 104 */     if (this.elementType == Lisp.NIL)
/* 105 */       writeError(); 
/* 106 */     super._writeString(s);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 112 */     if (this.elementType == Lisp.NIL)
/* 113 */       writeError(); 
/* 114 */     super._writeLine(s);
/*     */   }
/*     */ 
/*     */   
/*     */   private void writeError() {
/* 119 */     Lisp.error(new TypeError("Attempt to write to a string output stream of element type NIL."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/* 125 */     if (this.elementType == Lisp.NIL)
/* 126 */       return 0L; 
/* 127 */     return this.stringWriter.toString().length();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 133 */     super._finishOutput();
/* 134 */     if (this.stringWriter.getBuffer().length() > 0) {
/* 135 */       String s = this.stringWriter.toString();
/* 136 */       this.stringWriter.getBuffer().setLength(0);
/* 137 */       LispThread.currentThread().execute(this.f, new SimpleString(s));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 143 */   private static final Primitive MAKE_SLIME_OUTPUT_STREAM = new Primitive("make-slime-output-stream", Lisp.PACKAGE_EXT, true, "function")
/*     */     {
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*     */         Function fun;
/*     */ 
/*     */         
/* 150 */         if (arg instanceof Symbol) {
/* 151 */           fun = (Function)arg.getSymbolFunction();
/*     */         } else {
/* 153 */           fun = (Function)arg;
/* 154 */         }  return new SlimeOutputStream(fun);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SlimeOutputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */