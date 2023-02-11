/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.IOException;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class SynonymStream
/*     */   extends Stream
/*     */ {
/*     */   final Symbol symbol;
/*     */   
/*     */   SynonymStream(Symbol symbol) {
/*  44 */     super(Symbol.SYNONYM_STREAM);
/*  45 */     this.symbol = symbol;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isInputStream() {
/*  51 */     return Lisp.checkStream(this.symbol.symbolValue()).isInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isOutputStream() {
/*  57 */     return Lisp.checkStream(this.symbol.symbolValue()).isOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterInputStream() {
/*  63 */     return Lisp.checkStream(this.symbol.symbolValue()).isCharacterInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryInputStream() {
/*  69 */     return Lisp.checkStream(this.symbol.symbolValue()).isBinaryInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterOutputStream() {
/*  75 */     return Lisp.checkStream(this.symbol.symbolValue()).isCharacterOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryOutputStream() {
/*  81 */     return Lisp.checkStream(this.symbol.symbolValue()).isBinaryOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  87 */     return Symbol.SYNONYM_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  93 */     return BuiltInClass.SYNONYM_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  99 */     if (typeSpecifier == Symbol.SYNONYM_STREAM)
/* 100 */       return Lisp.T; 
/* 101 */     if (typeSpecifier == BuiltInClass.SYNONYM_STREAM)
/* 102 */       return Lisp.T; 
/* 103 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 109 */     return Lisp.checkStream(this.symbol.symbolValue()).getElementType();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/* 115 */     return Lisp.checkStream(this.symbol.symbolValue()).listen();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject fileLength() {
/* 121 */     return Lisp.checkStream(this.symbol.symbolValue()).fileLength();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject fileStringLength(LispObject arg) {
/* 127 */     return Lisp.checkStream(this.symbol.symbolValue()).fileStringLength(arg);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() throws IOException {
/* 133 */     return Lisp.checkStream(this.symbol.symbolValue())._readChar();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) throws IOException {
/* 139 */     Lisp.checkStream(this.symbol.symbolValue())._unreadChar(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() throws IOException {
/* 145 */     return Lisp.checkStream(this.symbol.symbolValue())._charReady();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/* 151 */     Lisp.checkStream(this.symbol.symbolValue())._writeChar(c);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 158 */     Lisp.checkStream(this.symbol.symbolValue())._writeChars(chars, start, end);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 164 */     Lisp.checkStream(this.symbol.symbolValue())._writeString(s);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 170 */     Lisp.checkStream(this.symbol.symbolValue())._writeLine(s);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 177 */     return Lisp.checkStream(this.symbol.symbolValue())._readByte();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 184 */     Lisp.checkStream(this.symbol.symbolValue())._writeByte(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 190 */     Lisp.checkStream(this.symbol.symbolValue())._finishOutput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 196 */     Lisp.checkStream(this.symbol.symbolValue())._clearInput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/* 202 */     return Lisp.checkStream(this.symbol.symbolValue())._getFilePosition();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _setFilePosition(LispObject arg) {
/* 208 */     return Lisp.checkStream(this.symbol.symbolValue())._setFilePosition(arg);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _close() {
/* 214 */     Lisp.checkStream(this.symbol.symbolValue())._close();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 220 */     StringBuffer sb = new StringBuffer("SYNONYM-STREAM ");
/* 221 */     sb.append(this.symbol.printObject());
/* 222 */     return unreadableString(sb.toString());
/*     */   }
/*     */ 
/*     */   
/* 226 */   private static final Primitive MAKE_SYNONYM_STREAM = new Primitive("make-synonym-stream", "symbol")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 232 */         return new SynonymStream(Lisp.checkSymbol(arg));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 237 */   private static final Primitive SYNONYM_STREAM_STREAMS = new Primitive("synonym-stream-symbol", "synonym-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 243 */         if (arg instanceof SynonymStream)
/* 244 */           return ((SynonymStream)arg).symbol; 
/* 245 */         return Lisp.type_error(arg, Symbol.SYNONYM_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SynonymStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */