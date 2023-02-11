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
/*     */ public class TwoWayStream
/*     */   extends Stream
/*     */ {
/*     */   public final Stream in;
/*     */   public final Stream out;
/*     */   
/*     */   public TwoWayStream(Stream in, Stream out) {
/*  45 */     super(Symbol.TWO_WAY_STREAM);
/*  46 */     this.in = in;
/*  47 */     this.out = out;
/*  48 */     this.isInputStream = true;
/*  49 */     this.isOutputStream = true;
/*     */   }
/*     */ 
/*     */   
/*     */   public TwoWayStream(Stream in, Stream out, boolean interactive) {
/*  54 */     this(in, out);
/*  55 */     setInteractive(interactive);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  61 */     LispObject itype = this.in.getElementType();
/*  62 */     LispObject otype = this.out.getElementType();
/*  63 */     if (itype.equal(otype))
/*  64 */       return itype; 
/*  65 */     return Lisp.list(Symbol.AND, new LispObject[] { itype, otype });
/*     */   }
/*     */ 
/*     */   
/*     */   public Stream getInputStream() {
/*  70 */     return this.in;
/*     */   }
/*     */ 
/*     */   
/*     */   public Stream getOutputStream() {
/*  75 */     return this.out;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterInputStream() {
/*  81 */     return this.in.isCharacterInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryInputStream() {
/*  87 */     return this.in.isBinaryInputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterOutputStream() {
/*  93 */     return this.out.isCharacterOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryOutputStream() {
/*  99 */     return this.out.isBinaryOutputStream();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 105 */     return Symbol.TWO_WAY_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 111 */     return BuiltInClass.TWO_WAY_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 117 */     if (type == Symbol.TWO_WAY_STREAM)
/* 118 */       return Lisp.T; 
/* 119 */     if (type == BuiltInClass.TWO_WAY_STREAM)
/* 120 */       return Lisp.T; 
/* 121 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() throws IOException {
/* 128 */     return this.in._readChar();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) throws IOException {
/* 134 */     this.in._unreadChar(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() throws IOException {
/* 140 */     return this.in._charReady();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/* 146 */     this.out._writeChar(c);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 153 */     this.out._writeChars(chars, start, end);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 159 */     this.out._writeString(s);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 165 */     this.out._writeLine(s);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 172 */     return this.in._readByte();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 179 */     this.out._writeByte(n);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 185 */     this.out._finishOutput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 191 */     this.in._clearInput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/* 197 */     return this.in.listen();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject freshLine() {
/* 203 */     return this.out.freshLine();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject close(LispObject abort) {
/* 212 */     setOpen(false);
/* 213 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 219 */     return unreadableString("TWO-WAY-STREAM");
/*     */   }
/*     */ 
/*     */   
/* 223 */   private static final Primitive MAKE_TWO_WAY_STREAM = new Primitive(Symbol.MAKE_TWO_WAY_STREAM, "input-stream output-stream")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 230 */         Stream in = Lisp.checkStream(first);
/* 231 */         Stream out = Lisp.checkStream(second);
/* 232 */         if (!in.isInputStream()) {
/* 233 */           return Lisp.type_error(in, Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.INPUT_STREAM_P }));
/*     */         }
/* 235 */         if (!out.isOutputStream()) {
/* 236 */           return Lisp.type_error(out, Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.OUTPUT_STREAM_P }));
/*     */         }
/* 238 */         return new TwoWayStream(in, out);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 243 */   private static final Primitive TWO_WAY_STREAM_INPUT_STREAM = new Primitive(Symbol.TWO_WAY_STREAM_INPUT_STREAM, "two-way-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 249 */         if (arg instanceof TwoWayStream)
/* 250 */           return ((TwoWayStream)arg).in; 
/* 251 */         return Lisp.type_error(arg, Symbol.TWO_WAY_STREAM);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 256 */   private static final Primitive TWO_WAY_STREAM_OUTPUT_STREAM = new Primitive(Symbol.TWO_WAY_STREAM_OUTPUT_STREAM, "two-way-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 262 */         if (arg instanceof TwoWayStream)
/* 263 */           return ((TwoWayStream)arg).out; 
/* 264 */         return Lisp.type_error(arg, Symbol.TWO_WAY_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/TwoWayStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */