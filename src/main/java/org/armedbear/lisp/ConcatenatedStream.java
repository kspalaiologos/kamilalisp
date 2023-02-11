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
/*     */ public final class ConcatenatedStream
/*     */   extends Stream
/*     */ {
/*     */   LispObject streams;
/*     */   
/*     */   ConcatenatedStream(LispObject streams) {
/*  44 */     super(Symbol.CONCATENATED_STREAM);
/*  45 */     this.streams = streams;
/*  46 */     this.isInputStream = true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterInputStream() {
/*  52 */     if (this.streams == Lisp.NIL)
/*  53 */       return true; 
/*  54 */     return ((Stream)this.streams.car()).isCharacterInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryInputStream() {
/*  60 */     if (this.streams == Lisp.NIL)
/*  61 */       return true; 
/*  62 */     return ((Stream)this.streams.car()).isBinaryInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterOutputStream() {
/*  68 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryOutputStream() {
/*  74 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  80 */     return Symbol.CONCATENATED_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  86 */     return BuiltInClass.CONCATENATED_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  92 */     if (typeSpecifier == Symbol.CONCATENATED_STREAM)
/*  93 */       return Lisp.T; 
/*  94 */     if (typeSpecifier == BuiltInClass.CONCATENATED_STREAM)
/*  95 */       return Lisp.T; 
/*  96 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/* 102 */     if (this.streams == Lisp.NIL)
/* 103 */       return Lisp.NIL; 
/* 104 */     return ((Stream)this.streams.car()).getElementType();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject readCharNoHang(boolean eofError, LispObject eofValue) {
/* 111 */     if (this.streams == Lisp.NIL) {
/* 112 */       if (eofError) {
/* 113 */         return Lisp.error(new EndOfFile(this));
/*     */       }
/* 115 */       return eofValue;
/*     */     } 
/*     */     
/*     */     try {
/* 119 */       return _charReady() ? readChar(eofError, eofValue) : Lisp.NIL;
/*     */     }
/* 121 */     catch (IOException e) {
/*     */       
/* 123 */       return Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/* 130 */     if (this.streams == Lisp.NIL)
/* 131 */       return Lisp.NIL; 
/* 132 */     Stream stream = (Stream)this.streams.car();
/* 133 */     if (stream.listen() == Lisp.NIL) {
/* 134 */       this.streams = this.streams.cdr();
/* 135 */       return listen();
/*     */     } 
/* 137 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() throws IOException {
/* 145 */     if (this.streams == Lisp.NIL)
/* 146 */       return -1; 
/* 147 */     Stream stream = (Stream)this.streams.car();
/* 148 */     int n = stream._readChar();
/* 149 */     if (n >= 0)
/* 150 */       return n; 
/* 151 */     this.streams = this.streams.cdr();
/* 152 */     return _readChar();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) throws IOException {
/* 158 */     if (this.streams == Lisp.NIL)
/* 159 */       Lisp.error(new StreamError(this, "UNREAD-CHAR was invoked without a stream to unread into.")); 
/* 160 */     Stream stream = (Stream)this.streams.car();
/*     */     
/* 162 */     stream._unreadChar(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() throws IOException {
/* 168 */     if (this.streams == Lisp.NIL)
/* 169 */       return false; 
/* 170 */     Stream stream = (Stream)this.streams.car();
/* 171 */     if (stream._charReady())
/* 172 */       return true; 
/* 173 */     LispObject remainingStreams = this.streams.cdr();
/* 174 */     while (remainingStreams != Lisp.NIL) {
/* 175 */       stream = (Stream)remainingStreams.car();
/* 176 */       if (stream._charReady())
/* 177 */         return true; 
/* 178 */       remainingStreams = remainingStreams.cdr();
/*     */     } 
/* 180 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/* 186 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 193 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 199 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 205 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 212 */     if (this.streams == Lisp.NIL)
/* 213 */       return -1; 
/* 214 */     Stream stream = (Stream)this.streams.car();
/* 215 */     int n = stream._readByte();
/* 216 */     if (n >= 0)
/* 217 */       return n; 
/* 218 */     this.streams = this.streams.cdr();
/* 219 */     return _readByte();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 226 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 232 */     outputStreamError();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {}
/*     */ 
/*     */ 
/*     */   
/*     */   private void outputStreamError() {
/* 243 */     Lisp.error(new StreamError(this, 
/* 244 */           String.valueOf(this) + " is not an output stream."));
/*     */   }
/*     */ 
/*     */   
/* 248 */   private static final Primitive MAKE_CONCATENATED_STREAM = new Primitive("make-concatenated-stream", "&rest streams")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 254 */         LispObject streams = Lisp.NIL;
/* 255 */         for (int i = 0; i < args.length; i++) {
/* 256 */           if (args[i] instanceof Stream) {
/* 257 */             Stream stream = (Stream)args[i];
/* 258 */             if (stream.isInputStream()) {
/*     */               
/* 260 */               streams = new Cons(stream, streams);
/*     */               continue;
/*     */             } 
/*     */           } 
/* 264 */           Lisp.error(new TypeError(String.valueOf(args[i]) + " is not an input stream."));
/*     */           continue;
/*     */         } 
/* 267 */         return new ConcatenatedStream(streams.nreverse());
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 272 */   private static final Primitive CONCATENATED_STREAM_STREAMS = new Primitive("concatenated-stream-streams", "concatenated-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 278 */         if (arg instanceof ConcatenatedStream)
/* 279 */           return ((ConcatenatedStream)arg).streams; 
/* 280 */         return Lisp.type_error(arg, Symbol.CONCATENATED_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ConcatenatedStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */