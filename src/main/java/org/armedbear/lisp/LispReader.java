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
/*     */ 
/*     */ public final class LispReader
/*     */ {
/*  41 */   public static final ReaderMacroFunction READ_COMMENT = new ReaderMacroFunction("read-comment", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/*     */         try {
/*     */           while (true) {
/*  52 */             int n = stream._readChar();
/*  53 */             if (n < 0)
/*  54 */               return LispThread.currentThread().setValues(); 
/*  55 */             if (n == 10) {
/*  56 */               return LispThread.currentThread().setValues();
/*     */             }
/*     */           } 
/*  59 */         } catch (IOException e) {
/*     */           
/*  61 */           return LispThread.currentThread().setValues();
/*     */         } 
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  67 */   public static final ReaderMacroFunction READ_STRING = new ReaderMacroFunction("read-string", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char terminator)
/*     */       {
/*  75 */         return stream.readString(terminator, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  80 */   public static final ReaderMacroFunction READ_LIST = new ReaderMacroFunction("read-list", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/*  88 */         return stream.readList(false, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/*  93 */   public static final ReaderMacroFunction READ_RIGHT_PAREN = new ReaderMacroFunction("read-right-paren", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/* 101 */         return Lisp.error(new ReaderError("Unmatched right parenthesis.", stream));
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 106 */   public static final ReaderMacroFunction READ_QUOTE = new ReaderMacroFunction("read-quote", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored)
/*     */       {
/* 114 */         return new Cons(Symbol.QUOTE, new Cons(stream
/* 115 */               .read(true, Lisp.NIL, true, 
/* 116 */                 LispThread.currentThread(), Stream.currentReadtable)));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 122 */   public static final ReaderMacroFunction READ_DISPATCH_CHAR = new ReaderMacroFunction("read-dispatch-char", Lisp.PACKAGE_SYS, false, "stream character")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c)
/*     */       {
/* 130 */         return stream.readDispatchChar(c, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 135 */   public static final DispatchMacroFunction SHARP_LEFT_PAREN = new DispatchMacroFunction("sharp-left-paren", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 143 */         return stream.readSharpLeftParen(c, n, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 148 */   public static final DispatchMacroFunction SHARP_STAR = new DispatchMacroFunction("sharp-star", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char ignored, int n)
/*     */       {
/* 156 */         return stream.readSharpStar(ignored, n, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 161 */   public static final DispatchMacroFunction SHARP_DOT = new DispatchMacroFunction("sharp-dot", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 169 */         return stream.readSharpDot(c, n, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 174 */   public static final DispatchMacroFunction SHARP_COLON = new DispatchMacroFunction("sharp-colon", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 182 */         return stream.readSymbol();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 187 */   public static final DispatchMacroFunction SHARP_A = new DispatchMacroFunction("sharp-a", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 195 */         return stream.readArray(n, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 200 */   public static final DispatchMacroFunction SHARP_B = new DispatchMacroFunction("sharp-b", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 208 */         return stream.readRadix(2, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 213 */   public static final DispatchMacroFunction SHARP_C = new DispatchMacroFunction("sharp-c", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 221 */         return stream.readComplex(Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 226 */   public static final DispatchMacroFunction SHARP_O = new DispatchMacroFunction("sharp-o", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 234 */         return stream.readRadix(8, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 239 */   public static final DispatchMacroFunction SHARP_P = new DispatchMacroFunction("sharp-p", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 247 */         return stream.readPathname(Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 252 */   public static final DispatchMacroFunction SHARP_R = new DispatchMacroFunction("sharp-r", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 260 */         return stream.readRadix(n, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 265 */   public static final DispatchMacroFunction SHARP_S = new DispatchMacroFunction("sharp-s", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 273 */         return stream.readStructure(Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 278 */   public static final DispatchMacroFunction SHARP_X = new DispatchMacroFunction("sharp-x", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 286 */         return stream.readRadix(16, Stream.currentReadtable);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 291 */   public static final DispatchMacroFunction SHARP_QUOTE = new DispatchMacroFunction("sharp-quote", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 299 */         return new Cons(Symbol.FUNCTION, new Cons(stream
/* 300 */               .read(true, Lisp.NIL, true, 
/* 301 */                 LispThread.currentThread(), Stream.currentReadtable)));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 307 */   public static final DispatchMacroFunction SHARP_BACKSLASH = new DispatchMacroFunction("sharp-backslash", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 315 */         LispThread thread = LispThread.currentThread();
/* 316 */         Readtable rt = (Readtable)Symbol.CURRENT_READTABLE.symbolValue(thread);
/* 317 */         return stream.readCharacterLiteral(rt, thread);
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 322 */   public static final DispatchMacroFunction SHARP_VERTICAL_BAR = new DispatchMacroFunction("sharp-vertical-bar", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 330 */         stream.skipBalancedComment();
/* 331 */         return LispThread.currentThread().setValues();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 336 */   public static final DispatchMacroFunction SHARP_ILLEGAL = new DispatchMacroFunction("sharp-illegal", Lisp.PACKAGE_SYS, false, "stream sub-char numarg")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(Stream stream, char c, int n)
/*     */       {
/* 344 */         StringBuilder sb = new StringBuilder("Illegal # macro character: #\\");
/* 345 */         String s = LispCharacter.charToName(c);
/* 346 */         if (s != null) {
/* 347 */           sb.append(s);
/*     */         } else {
/* 349 */           sb.append(c);
/* 350 */         }  return Lisp.error(new ReaderError(sb.toString(), stream));
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispReader.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */