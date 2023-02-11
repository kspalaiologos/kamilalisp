/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.StringReader;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class StringInputStream
/*     */   extends Stream
/*     */ {
/*     */   private final StringReader stringReader;
/*     */   private final int start;
/*     */   private final String subString;
/*     */   
/*     */   public StringInputStream(String s) {
/*  49 */     this(s, 0, s.length());
/*     */   }
/*     */ 
/*     */   
/*     */   public StringInputStream(String s, int start) {
/*  54 */     this(s, start, s.length());
/*     */   }
/*     */ 
/*     */   
/*     */   public StringInputStream(String s, int start, int end) {
/*  59 */     super(Symbol.STRING_INPUT_STREAM);
/*  60 */     this.elementType = Symbol.CHARACTER;
/*  61 */     setExternalFormat(keywordDefault);
/*  62 */     this.eolStyle = Stream.EolStyle.RAW;
/*     */     
/*  64 */     this.start = start;
/*     */     
/*  66 */     this.subString = s.substring(start, end);
/*  67 */     this.stringReader = new StringReader(this.subString);
/*  68 */     initAsCharacterInputStream(this.stringReader);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  74 */     return Symbol.STRING_INPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  80 */     return BuiltInClass.STRING_INPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  86 */     if (type == Symbol.STRING_INPUT_STREAM)
/*  87 */       return Lisp.T; 
/*  88 */     if (type == Symbol.STRING_STREAM)
/*  89 */       return Lisp.T; 
/*  90 */     if (type == BuiltInClass.STRING_INPUT_STREAM)
/*  91 */       return Lisp.T; 
/*  92 */     if (type == BuiltInClass.STRING_STREAM)
/*  93 */       return Lisp.T; 
/*  94 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public int getOffset() {
/*  99 */     return this.start + this.offset;
/*     */   }
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/* 104 */     return getOffset();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _setFilePosition(LispObject arg) {
/*     */     try {
/*     */       int offset;
/* 112 */       if (arg == Keyword.START) {
/* 113 */         offset = 0;
/* 114 */       } else if (arg == Keyword.END) {
/* 115 */         offset = this.subString.length();
/*     */       } else {
/* 117 */         long n = Fixnum.getValue(arg);
/* 118 */         if (n < 0L || n > this.subString.length())
/* 119 */           Lisp.error(new StreamError(this, "FILE-POSITION got out of bounds argument.")); 
/* 120 */         offset = (int)n;
/*     */       } 
/*     */       
/* 123 */       this.stringReader.reset();
/* 124 */       this.stringReader.skip(offset);
/* 125 */       initAsCharacterInputStream(this.stringReader);
/*     */       
/* 127 */       this.offset = offset;
/*     */     }
/* 129 */     catch (IOException e) {
/* 130 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */     
/* 133 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 138 */   private static final Primitive MAKE_STRING_INPUT_STREAM = new Primitive("make-string-input-stream", "string &optional start end")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 144 */         return new StringInputStream(arg.getStringValue());
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 151 */         String s = first.getStringValue();
/* 152 */         int start = Fixnum.getValue(second);
/* 153 */         return new StringInputStream(s, start);
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 161 */         String s = first.getStringValue();
/* 162 */         int start = Fixnum.getValue(second);
/* 163 */         if (third == Lisp.NIL)
/* 164 */           return new StringInputStream(s, start); 
/* 165 */         int end = Fixnum.getValue(third);
/* 166 */         return new StringInputStream(s, start, end);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 171 */   private static final Primitive STRING_INPUT_STREAM_CURRENT = new Primitive("string-input-stream-current", Lisp.PACKAGE_EXT, true, "stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 177 */         if (arg instanceof StringInputStream)
/* 178 */           return Fixnum.getInstance(((StringInputStream)arg).getOffset()); 
/* 179 */         return Lisp.error(new TypeError(String.valueOf(arg) + " is not a string input stream."));
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StringInputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */