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
/*     */ 
/*     */ public final class StringOutputStream
/*     */   extends Stream
/*     */ {
/*     */   private final SeekableStringWriter stringWriter;
/*     */   
/*     */   public StringOutputStream() {
/*  47 */     this(Symbol.CHARACTER);
/*     */   }
/*     */ 
/*     */   
/*     */   StringOutputStream(LispObject elementType) {
/*  52 */     super(Symbol.STRING_OUTPUT_STREAM);
/*  53 */     this.elementType = elementType;
/*  54 */     this.eolStyle = Stream.EolStyle.RAW;
/*  55 */     initAsCharacterOutputStream(this.stringWriter = new SeekableStringWriter());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  61 */     return Symbol.STRING_OUTPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  67 */     return BuiltInClass.STRING_OUTPUT_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  73 */     if (type == Symbol.STRING_OUTPUT_STREAM)
/*  74 */       return Lisp.T; 
/*  75 */     if (type == Symbol.STRING_STREAM)
/*  76 */       return Lisp.T; 
/*  77 */     if (type == BuiltInClass.STRING_OUTPUT_STREAM)
/*  78 */       return Lisp.T; 
/*  79 */     if (type == BuiltInClass.STRING_STREAM)
/*  80 */       return Lisp.T; 
/*  81 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/*  87 */     if (this.elementType == Lisp.NIL)
/*  88 */       return 0L; 
/*  89 */     return this.stringWriter.getOffset();
/*     */   }
/*     */ 
/*     */   
/*     */   protected boolean _setFilePosition(LispObject arg) {
/*  94 */     if (this.elementType == Lisp.NIL) {
/*  95 */       return false;
/*     */     }
/*     */     
/*     */     try {
/*     */       int offset;
/* 100 */       if (arg == Keyword.START) {
/* 101 */         offset = 0;
/* 102 */       } else if (arg == Keyword.END) {
/* 103 */         offset = this.stringWriter.getBuffer().length();
/*     */       } else {
/* 105 */         long n = Fixnum.getValue(arg);
/* 106 */         offset = (int)n;
/*     */       } 
/*     */       
/* 109 */       this.stringWriter.seek(offset);
/*     */ 
/*     */       
/* 112 */       this.offset = offset;
/*     */     }
/* 114 */     catch (IllegalArgumentException e) {
/* 115 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */     
/* 118 */     return true;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getString() {
/* 123 */     if (this.elementType == Lisp.NIL) {
/* 124 */       return new NilVector(0);
/*     */     }
/*     */     
/* 127 */     StringBuffer sb = this.stringWriter.getBuffer();
/* 128 */     SimpleString s = new SimpleString(sb);
/* 129 */     sb.setLength(0);
/* 130 */     return s;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getSimpleStringAndClear() {
/* 135 */     if (this.elementType == Lisp.NIL)
/* 136 */       return new NilVector(0); 
/* 137 */     String contents = this.stringWriter.toStringAndClear();
/*     */     
/* 139 */     return new SimpleString(contents);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 144 */   private static final Primitive MAKE_STRING_OUTPUT_STREAM = new Primitive("%make-string-output-stream", Lisp.PACKAGE_SYS, false, "element-type")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 151 */         return new StringOutputStream(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 157 */   private static final Primitive GET_OUTPUT_STREAM_STRING = new Primitive("get-output-stream-string", "string-output-stream")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 163 */         if (arg instanceof StringOutputStream) {
/* 164 */           return ((StringOutputStream)arg).getSimpleStringAndClear();
/*     */         }
/* 166 */         return Lisp.type_error(this, Symbol.STRING_OUTPUT_STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StringOutputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */