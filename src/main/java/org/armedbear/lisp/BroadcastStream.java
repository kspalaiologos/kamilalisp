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
/*     */ public final class BroadcastStream
/*     */   extends Stream
/*     */ {
/*     */   final Stream[] streams;
/*     */   
/*     */   BroadcastStream(Stream[] streams) {
/*  44 */     super(Symbol.BROADCAST_STREAM);
/*  45 */     this.streams = streams;
/*  46 */     this.isOutputStream = true;
/*  47 */     if (streams.length == 0) {
/*  48 */       this.elementType = Lisp.T;
/*  49 */       this.isBinaryStream = true;
/*  50 */       this.isCharacterStream = true;
/*     */     } else {
/*  52 */       this.elementType = streams[streams.length - 1].getElementType();
/*  53 */       if (this.elementType == Symbol.CHARACTER || this.elementType == Symbol.BASE_CHAR) {
/*  54 */         this.isCharacterStream = true;
/*     */       } else {
/*  56 */         this.isBinaryStream = true;
/*     */       } 
/*     */     } 
/*     */   }
/*     */   
/*     */   public Stream[] getStreams() {
/*  62 */     return this.streams;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  68 */     return Symbol.BROADCAST_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  74 */     return BuiltInClass.BROADCAST_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/*  80 */     if (typeSpecifier == Symbol.BROADCAST_STREAM)
/*  81 */       return Lisp.T; 
/*  82 */     if (typeSpecifier == BuiltInClass.BROADCAST_STREAM)
/*  83 */       return Lisp.T; 
/*  84 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/*  90 */     notSupported();
/*     */     
/*  92 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject fileLength() {
/*  98 */     if (this.streams.length > 0) {
/*  99 */       return this.streams[this.streams.length - 1].fileLength();
/*     */     }
/* 101 */     return Fixnum.ZERO;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject fileStringLength(LispObject arg) {
/* 107 */     if (this.streams.length > 0) {
/* 108 */       return this.streams[this.streams.length - 1].fileStringLength(arg);
/*     */     }
/* 110 */     return Fixnum.ONE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() {
/* 117 */     notSupported();
/*     */     
/* 119 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) {
/* 125 */     notSupported();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() {
/* 131 */     notSupported();
/*     */     
/* 133 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChar(char c) {
/* 139 */     for (int i = 0; i < this.streams.length; i++) {
/* 140 */       this.streams[i]._writeChar(c);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 147 */     for (int i = 0; i < this.streams.length; i++) {
/* 148 */       this.streams[i]._writeChars(chars, start, end);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void _writeString(String s) {
/* 154 */     for (int i = 0; i < this.streams.length; i++) {
/* 155 */       this.streams[i]._writeString(s);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void _writeLine(String s) {
/* 161 */     for (int i = 0; i < this.streams.length; i++) {
/* 162 */       this.streams[i]._writeLine(s);
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 169 */     notSupported();
/*     */     
/* 171 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 178 */     for (int i = 0; i < this.streams.length; i++) {
/* 179 */       this.streams[i]._writeByte(n);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 185 */     for (int i = 0; i < this.streams.length; i++) {
/* 186 */       this.streams[i]._finishOutput();
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 192 */     notSupported();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/* 198 */     if (this.streams.length == 0) {
/* 199 */       return 0L;
/*     */     }
/* 201 */     return this.streams[this.streams.length - 1]._getFilePosition();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _setFilePosition(LispObject arg) {
/* 207 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _close() {
/* 213 */     setOpen(false);
/*     */   }
/*     */ 
/*     */   
/*     */   private void notSupported() {
/* 218 */     Lisp.error(new TypeError("Operation is not supported for streams of type BROADCAST-STREAM."));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 224 */     return unreadableString("BROADCAST-STREAM");
/*     */   }
/*     */ 
/*     */   
/* 228 */   private static final Primitive MAKE_BROADCAST_STREAM = new Primitive("make-broadcast-stream", "&rest streams")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 234 */         return new BroadcastStream(new Stream[0]);
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args) {
/* 239 */         Stream[] streams = new Stream[args.length];
/* 240 */         for (int i = 0; i < args.length; i++) {
/* 241 */           if (args[i] instanceof Stream)
/* 242 */           { if (((Stream)args[i]).isOutputStream()) {
/* 243 */               streams[i] = (Stream)args[i];
/*     */             } else {
/*     */               
/* 246 */               return Lisp.type_error(args[i], 
/* 247 */                   Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.OUTPUT_STREAM_P }));
/*     */             }  }
/* 249 */           else { return Lisp.type_error(args[i], Symbol.STREAM); }
/*     */         
/*     */         } 
/* 252 */         return new BroadcastStream(streams);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 257 */   private static final Primitive BROADCAST_STREAM_STREAMS = new Primitive("broadcast-stream-streams", "broadcast-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 263 */         if (arg instanceof BroadcastStream) {
/* 264 */           BroadcastStream stream = (BroadcastStream)arg;
/* 265 */           Stream[] streams = stream.streams;
/* 266 */           LispObject result = Lisp.NIL;
/* 267 */           for (int i = streams.length; i-- > 0;)
/* 268 */             result = new Cons(streams[i], result); 
/* 269 */           return result;
/*     */         } 
/* 271 */         return Lisp.type_error(arg, Symbol.BROADCAST_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/BroadcastStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */