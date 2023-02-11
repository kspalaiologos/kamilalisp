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
/*     */ public final class FaslReader
/*     */ {
/*  41 */   public static final ReaderMacroFunction FASL_READ_STRING = new ReaderMacroFunction("fasl-read-string", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char terminator)
/*     */       {
/*  49 */         return stream.readString(terminator, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  54 */   public static final ReaderMacroFunction FASL_READ_LIST = new ReaderMacroFunction("fasl-read-list", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/*  62 */         return stream.readList(false, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  67 */   public static final ReaderMacroFunction FASL_READ_QUOTE = new ReaderMacroFunction("fasl-read-quote", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/*  75 */         return new Cons(Symbol.QUOTE, new Cons(stream
/*  76 */               .read(true, Lisp.NIL, true, 
/*  77 */                 LispThread.currentThread(), Stream.faslReadtable)));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  83 */   public static final ReaderMacroFunction FASL_READ_DISPATCH_CHAR = new ReaderMacroFunction("fasl-read-dispatch-char", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c)
/*     */       {
/*  91 */         return stream.readDispatchChar(c, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  96 */   public static final DispatchMacroFunction FASL_SHARP_LEFT_PAREN = new DispatchMacroFunction("fasl-sharp-left-paren", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 104 */         return stream.readSharpLeftParen(c, n, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 109 */   public static final DispatchMacroFunction FASL_SHARP_STAR = new DispatchMacroFunction("fasl-sharp-star", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored, int n)
/*     */       {
/* 117 */         return stream.readSharpStar(ignored, n, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 122 */   public static final DispatchMacroFunction FASL_SHARP_DOT = new DispatchMacroFunction("fasl-sharp-dot", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 130 */         return stream.readSharpDot(c, n, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 135 */   public static final DispatchMacroFunction FASL_SHARP_COLON = new DispatchMacroFunction("fasl-sharp-colon", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 143 */         LispThread thread = LispThread.currentThread();
/* 144 */         return stream.readSymbol(FaslReadtable.getInstance());
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 149 */   public static final DispatchMacroFunction FASL_SHARP_A = new DispatchMacroFunction("fasl-sharp-a", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 157 */         return stream.readArray(n, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 162 */   public static final DispatchMacroFunction FASL_SHARP_B = new DispatchMacroFunction("fasl-sharp-b", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 170 */         return stream.readRadix(2, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 175 */   public static final DispatchMacroFunction FASL_SHARP_C = new DispatchMacroFunction("fasl-sharp-c", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 183 */         return stream.readComplex(Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 188 */   public static final DispatchMacroFunction FASL_SHARP_O = new DispatchMacroFunction("fasl-sharp-o", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 196 */         return stream.readRadix(8, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 201 */   public static final DispatchMacroFunction FASL_SHARP_P = new DispatchMacroFunction("fasl-sharp-p", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 209 */         return stream.readPathname(Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 214 */   public static final DispatchMacroFunction FASL_SHARP_R = new DispatchMacroFunction("fasl-sharp-r", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 222 */         return stream.readRadix(n, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 227 */   public static final DispatchMacroFunction FASL_SHARP_S = new DispatchMacroFunction("fasl-sharp-s", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 235 */         return stream.readStructure(Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 240 */   public static final DispatchMacroFunction FASL_SHARP_X = new DispatchMacroFunction("fasl-sharp-x", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 248 */         return stream.readRadix(16, Stream.faslReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 253 */   public static final DispatchMacroFunction FASL_SHARP_QUOTE = new DispatchMacroFunction("fasl-sharp-quote", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 261 */         return new Cons(Symbol.FUNCTION, new Cons(stream
/* 262 */               .read(true, Lisp.NIL, true, 
/* 263 */                 LispThread.currentThread(), Stream.faslReadtable)));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 269 */   public static final DispatchMacroFunction FASL_SHARP_BACKSLASH = new DispatchMacroFunction("fasl-sharp-backslash", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 276 */         return stream.readCharacterLiteral(FaslReadtable.getInstance(), 
/* 277 */             LispThread.currentThread());
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 282 */   public static final DispatchMacroFunction FASL_SHARP_QUESTION_MARK = new DispatchMacroFunction("fasl-sharp-question-mark", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 289 */         return Load.getUninternedSymbol(n);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FaslReader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */