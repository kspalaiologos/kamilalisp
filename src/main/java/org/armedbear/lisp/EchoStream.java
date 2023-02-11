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
/*     */ public final class EchoStream
/*     */   extends Stream
/*     */ {
/*     */   private final Stream in;
/*     */   private final Stream out;
/*  43 */   private int unreadChar = -1;
/*     */ 
/*     */   
/*     */   public EchoStream(Stream in, Stream out) {
/*  47 */     super(Symbol.ECHO_STREAM);
/*  48 */     this.in = in;
/*  49 */     this.out = out;
/*     */   }
/*     */ 
/*     */   
/*     */   public EchoStream(Stream in, Stream out, boolean interactive) {
/*  54 */     super(Symbol.ECHO_STREAM);
/*  55 */     this.in = in;
/*  56 */     this.out = out;
/*  57 */     setInteractive(interactive);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  63 */     LispObject itype = this.in.getElementType();
/*  64 */     LispObject otype = this.out.getElementType();
/*  65 */     if (itype.equal(otype))
/*  66 */       return itype; 
/*  67 */     return Symbol.NULL;
/*     */   }
/*     */ 
/*     */   
/*     */   public Stream getInputStream() {
/*  72 */     return this.in;
/*     */   }
/*     */ 
/*     */   
/*     */   public Stream getOutputStream() {
/*  77 */     return this.out;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  83 */     return Symbol.ECHO_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  89 */     return BuiltInClass.ECHO_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  95 */     if (type == Symbol.ECHO_STREAM)
/*  96 */       return Lisp.T; 
/*  97 */     if (type == BuiltInClass.ECHO_STREAM)
/*  98 */       return Lisp.T; 
/*  99 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isInputStream() {
/* 105 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isOutputStream() {
/* 111 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterInputStream() {
/* 117 */     return this.in.isCharacterInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryInputStream() {
/* 123 */     return this.in.isBinaryInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterOutputStream() {
/* 129 */     return this.out.isCharacterOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryOutputStream() {
/* 135 */     return this.out.isBinaryOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() throws IOException {
/* 142 */     int n = this.in._readChar();
/* 143 */     if (n >= 0)
/*     */     {
/* 145 */       if (this.unreadChar < 0) {
/* 146 */         this.out._writeChar((char)n);
/*     */       } else {
/* 148 */         this.unreadChar = -1;
/*     */       }  } 
/* 150 */     return n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) throws IOException {
/* 156 */     this.in._unreadChar(n);
/* 157 */     this.unreadChar = n;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() throws IOException {
/* 163 */     return this.in._charReady();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/* 169 */     this.out._writeChar(c);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 176 */     this.out._writeChars(chars, start, end);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 182 */     this.out._writeString(s);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 188 */     this.out._writeLine(s);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 195 */     int n = this.in._readByte();
/* 196 */     if (n >= 0)
/* 197 */       this.out._writeByte(n); 
/* 198 */     return n;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 205 */     this.out._writeByte(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 211 */     this.out._finishOutput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 217 */     this.in._clearInput();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject close(LispObject abort) {
/* 226 */     setOpen(false);
/* 227 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/* 233 */     return this.in.listen();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject freshLine() {
/* 239 */     return this.out.freshLine();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 244 */   private static final Primitive MAKE_ECHO_STREAM = new Primitive("make-echo-stream", "input-stream output-stream")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 251 */         if (!(first instanceof Stream))
/* 252 */           return Lisp.type_error(first, Symbol.STREAM); 
/* 253 */         if (!(second instanceof Stream))
/* 254 */           return Lisp.type_error(second, Symbol.STREAM); 
/* 255 */         return new EchoStream((Stream)first, (Stream)second);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 261 */   private static final Primitive ECHO_STREAM_INPUT_STREAM = new Primitive("echo-stream-input-stream", "echo-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 267 */         if (arg instanceof EchoStream)
/* 268 */           return ((EchoStream)arg).getInputStream(); 
/* 269 */         return Lisp.type_error(arg, Symbol.ECHO_STREAM);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 275 */   private static final Primitive ECHO_STREAM_OUTPUT_STREAM = new Primitive("echo-stream-output-stream", "echo-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 281 */         if (arg instanceof EchoStream)
/* 282 */           return ((EchoStream)arg).getOutputStream(); 
/* 283 */         return Lisp.type_error(arg, Symbol.ECHO_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/EchoStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */