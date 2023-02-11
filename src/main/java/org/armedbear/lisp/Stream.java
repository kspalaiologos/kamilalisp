/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.BufferedInputStream;
/*      */ import java.io.BufferedOutputStream;
/*      */ import java.io.IOException;
/*      */ import java.io.InputStream;
/*      */ import java.io.OutputStream;
/*      */ import java.io.OutputStreamWriter;
/*      */ import java.io.PrintWriter;
/*      */ import java.io.PushbackReader;
/*      */ import java.io.Reader;
/*      */ import java.io.StringWriter;
/*      */ import java.io.Writer;
/*      */ import java.math.BigInteger;
/*      */ import java.nio.charset.Charset;
/*      */ import java.util.BitSet;
/*      */ import java.util.LinkedList;
/*      */ import java.util.List;
/*      */ import java.util.Set;
/*      */ import java.util.SortedMap;
/*      */ import org.armedbear.lisp.util.DecodingReader;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public class Stream
/*      */   extends StructureObject
/*      */ {
/*      */   protected LispObject elementType;
/*      */   protected boolean isInputStream;
/*      */   protected boolean isOutputStream;
/*      */   protected boolean isCharacterStream;
/*      */   protected boolean isBinaryStream;
/*      */   private boolean pastEnd = false;
/*      */   private boolean interactive;
/*      */   private boolean open = true;
/*      */   protected PushbackReader reader;
/*      */   protected int offset;
/*      */   protected int lineNumber;
/*      */   private Writer writer;
/*      */   protected int charPos;
/*      */   
/*      */   public enum EolStyle
/*      */   {
/*   92 */     RAW,
/*   93 */     CR,
/*   94 */     CRLF,
/*   95 */     LF;
/*      */   }
/*      */   
/*   98 */   protected static final Symbol keywordDefault = Lisp.internKeyword("DEFAULT");
/*      */   
/*  100 */   private static final Symbol keywordCodePage = Lisp.internKeyword("CODE-PAGE");
/*  101 */   private static final Symbol keywordID = Lisp.internKeyword("ID");
/*      */   
/*  103 */   private static final Symbol keywordEolStyle = Lisp.internKeyword("EOL-STYLE");
/*  104 */   private static final Symbol keywordCR = Lisp.internKeyword("CR");
/*  105 */   private static final Symbol keywordLF = Lisp.internKeyword("LF");
/*  106 */   private static final Symbol keywordCRLF = Lisp.internKeyword("CRLF");
/*  107 */   private static final Symbol keywordRAW = Lisp.internKeyword("RAW");
/*      */   
/*  109 */   public static final EolStyle platformEolStyle = Utilities.isPlatformWindows ? EolStyle.CRLF : EolStyle.LF;
/*      */   
/*  111 */   protected EolStyle eolStyle = platformEolStyle;
/*  112 */   protected char eolChar = (this.eolStyle == EolStyle.CR) ? '\r' : '\n';
/*  113 */   protected LispObject externalFormat = keywordDefault;
/*  114 */   protected String encoding = null;
/*  115 */   protected char lastChar = Character.MIN_VALUE;
/*      */ 
/*      */   
/*      */   private InputStream in;
/*      */   
/*      */   private OutputStream out;
/*      */ 
/*      */   
/*      */   protected Stream(Symbol structureClass) {
/*  124 */     super(structureClass);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, InputStream stream) {
/*  128 */     this(structureClass);
/*  129 */     initAsBinaryInputStream(stream);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, Reader r) {
/*  133 */     this(structureClass);
/*  134 */     initAsCharacterInputStream(r);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, OutputStream stream) {
/*  138 */     this(structureClass);
/*  139 */     initAsBinaryOutputStream(stream);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, Writer w) {
/*  143 */     this(structureClass);
/*  144 */     initAsCharacterOutputStream(w);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, InputStream inputStream, LispObject elementType) {
/*  148 */     this(structureClass, inputStream, elementType, keywordDefault);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public Stream(Symbol structureClass, InputStream inputStream, LispObject elementType, LispObject format) {
/*  156 */     this(structureClass);
/*  157 */     this.elementType = elementType;
/*  158 */     setExternalFormat(format);
/*      */     
/*  160 */     if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*  165 */       DecodingReader decodingReader = new DecodingReader(inputStream, 4096, (this.encoding == null) ? Charset.defaultCharset() : Charset.forName(this.encoding));
/*  166 */       initAsCharacterInputStream((Reader)decodingReader);
/*      */     } else {
/*  168 */       this.isBinaryStream = true;
/*  169 */       InputStream stream = new BufferedInputStream(inputStream);
/*  170 */       initAsBinaryInputStream(stream);
/*      */     } 
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, InputStream inputStream, LispObject elementType, boolean interactive) {
/*  175 */     this(structureClass, inputStream, elementType);
/*  176 */     setInteractive(interactive);
/*      */   }
/*      */   
/*      */   public Stream(Symbol structureClass, OutputStream outputStream, LispObject elementType) {
/*  180 */     this(structureClass, outputStream, elementType, keywordDefault);
/*      */   }
/*      */ 
/*      */   
/*      */   public Stream(Symbol structureClass, OutputStream outputStream, LispObject elementType, LispObject format) {
/*  185 */     this(structureClass);
/*  186 */     this.elementType = elementType;
/*  187 */     setExternalFormat(format);
/*  188 */     if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*  193 */       Writer w = (this.encoding == null) ? new OutputStreamWriter(outputStream) : new OutputStreamWriter(outputStream, Charset.forName(this.encoding).newEncoder());
/*  194 */       initAsCharacterOutputStream(w);
/*      */     } else {
/*  196 */       OutputStream stream = new BufferedOutputStream(outputStream);
/*  197 */       initAsBinaryOutputStream(stream);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public Stream(Symbol structureClass, OutputStream outputStream, LispObject elementType, boolean interactive) {
/*  204 */     this(structureClass, outputStream, elementType);
/*  205 */     setInteractive(interactive);
/*      */   }
/*      */   
/*      */   protected void initAsCharacterInputStream(Reader reader) {
/*  209 */     if (!(reader instanceof PushbackReader)) {
/*  210 */       this.reader = new PushbackReader(reader, 5);
/*      */     } else {
/*  212 */       this.reader = (PushbackReader)reader;
/*      */     } 
/*  214 */     this.isInputStream = true;
/*  215 */     this.isCharacterStream = true;
/*      */   }
/*      */   
/*      */   protected void initAsBinaryInputStream(InputStream in) {
/*  219 */     this.in = in;
/*  220 */     this.isInputStream = true;
/*  221 */     this.isBinaryStream = true;
/*      */   }
/*      */   
/*      */   protected void initAsCharacterOutputStream(Writer writer) {
/*  225 */     this.writer = writer;
/*  226 */     this.isOutputStream = true;
/*  227 */     this.isCharacterStream = true;
/*      */   }
/*      */   
/*      */   protected void initAsBinaryOutputStream(OutputStream out) {
/*  231 */     this.out = out;
/*  232 */     this.isOutputStream = true;
/*  233 */     this.isBinaryStream = true;
/*      */   }
/*      */   
/*      */   public boolean isInputStream() {
/*  237 */     return this.isInputStream;
/*      */   }
/*      */   
/*      */   public boolean isOutputStream() {
/*  241 */     return this.isOutputStream;
/*      */   }
/*      */   
/*      */   public boolean isCharacterInputStream() {
/*  245 */     return (this.isCharacterStream && this.isInputStream);
/*      */   }
/*      */   
/*      */   public boolean isBinaryInputStream() {
/*  249 */     return (this.isBinaryStream && this.isInputStream);
/*      */   }
/*      */   
/*      */   public boolean isCharacterOutputStream() {
/*  253 */     return (this.isCharacterStream && this.isOutputStream);
/*      */   }
/*      */   
/*      */   public boolean isBinaryOutputStream() {
/*  257 */     return (this.isBinaryStream && this.isOutputStream);
/*      */   }
/*      */   
/*      */   public boolean isInteractive() {
/*  261 */     return this.interactive;
/*      */   }
/*      */   
/*      */   public void setInteractive(boolean b) {
/*  265 */     this.interactive = b;
/*      */   }
/*      */   
/*      */   public LispObject getExternalFormat() {
/*  269 */     return this.externalFormat;
/*      */   }
/*      */   
/*      */   public String getEncoding() {
/*  273 */     return this.encoding;
/*      */   }
/*      */   
/*      */   public void setExternalFormat(LispObject format) {
/*      */     LispObject enc;
/*  278 */     finishOutput();
/*      */     
/*  280 */     if (format == keywordDefault) {
/*  281 */       this.encoding = null;
/*  282 */       this.eolStyle = platformEolStyle;
/*  283 */       this.eolChar = (this.eolStyle == EolStyle.CR) ? '\r' : '\n';
/*  284 */       this.externalFormat = format;
/*      */       
/*      */       return;
/*      */     } 
/*      */     
/*  289 */     boolean encIsCp = false;
/*      */     
/*  291 */     if (format instanceof Cons) {
/*      */       
/*  293 */       enc = format.car();
/*  294 */       if (enc == keywordCodePage) {
/*  295 */         encIsCp = true;
/*      */         
/*  297 */         enc = Lisp.getf(format.cdr(), keywordID, null);
/*      */       } 
/*      */       
/*  300 */       LispObject eol = Lisp.getf(format.cdr(), keywordEolStyle, keywordRAW);
/*  301 */       if (eol == keywordCR) {
/*  302 */         this.eolStyle = EolStyle.CR;
/*  303 */       } else if (eol == keywordLF) {
/*  304 */         this.eolStyle = EolStyle.LF;
/*  305 */       } else if (eol == keywordCRLF) {
/*  306 */         this.eolStyle = EolStyle.CRLF;
/*  307 */       } else if (eol != keywordRAW) {
/*      */       
/*      */       } 
/*      */     } else {
/*  311 */       enc = format;
/*      */     } 
/*  313 */     if (enc.numberp()) {
/*  314 */       this.encoding = enc.toString();
/*  315 */     } else if (enc instanceof AbstractString) {
/*  316 */       this.encoding = enc.getStringValue();
/*  317 */     } else if (enc == keywordDefault) {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*  322 */       this.encoding = null;
/*  323 */     } else if (enc instanceof Symbol) {
/*  324 */       this.encoding = ((Symbol)enc).getName();
/*      */     } 
/*      */ 
/*      */     
/*  328 */     if (encIsCp) {
/*  329 */       this.encoding = "Cp" + this.encoding;
/*      */     }
/*  331 */     this.eolChar = (this.eolStyle == EolStyle.CR) ? '\r' : '\n';
/*  332 */     this.externalFormat = format;
/*      */     
/*  334 */     if (this.reader != null && this.reader instanceof DecodingReader)
/*      */     {
/*  336 */       ((DecodingReader)this.reader).setCharset(Charset.forName(this.encoding)); } 
/*      */   }
/*      */   
/*  339 */   public static final Primitive STREAM_EXTERNAL_FORMAT = new pf_stream_external_format();
/*      */ 
/*      */   
/*      */   @DocString(name = "stream-external-format", args = "stream", doc = "Returns the external format of STREAM.")
/*      */   private static final class pf_stream_external_format
/*      */     extends Primitive
/*      */   {
/*      */     pf_stream_external_format() {
/*  347 */       super("stream-external-format", "stream");
/*      */     }
/*      */     public LispObject execute(LispObject arg) {
/*  350 */       if (arg instanceof Stream) {
/*  351 */         return ((Stream)arg).getExternalFormat();
/*      */       }
/*  353 */       return Lisp.type_error(arg, Symbol.STREAM);
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*  359 */   public static final Primitive SET_STREAM_EXTERNAL_FORMAT = new pf__set_stream_external_format();
/*      */   
/*      */   @DocString(name = "%set-stream-external-format", args = "stream format")
/*      */   private static final class pf__set_stream_external_format
/*      */     extends Primitive
/*      */   {
/*      */     pf__set_stream_external_format() {
/*  366 */       super("%set-stream-external-format", Lisp.PACKAGE_SYS, false, "stream external-format");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject stream, LispObject format) {
/*  370 */       Stream s = Lisp.checkStream(stream);
/*  371 */       s.setExternalFormat(format);
/*  372 */       return format;
/*      */     }
/*      */   }
/*      */   
/*  376 */   public static final Primitive AVAILABLE_ENCODINGS = new pf_available_encodings();
/*      */   
/*      */   @DocString(name = "available-encodings", returns = "encodings", doc = "Returns all charset encodings suitable for passing to a stream constructor available at runtime.")
/*      */   private static final class pf_available_encodings
/*      */     extends Primitive {
/*      */     pf_available_encodings() {
/*  382 */       super("available-encodings", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */     public LispObject execute() {
/*  385 */       LispObject result = Lisp.NIL;
/*  386 */       for (Symbol encoding : Stream.availableEncodings()) {
/*  387 */         result = result.push(encoding);
/*      */       }
/*  389 */       return result.nreverse();
/*      */     }
/*      */   }
/*      */   
/*      */   public static List<Symbol> availableEncodings() {
/*  394 */     List<Symbol> result = new LinkedList<>();
/*      */     
/*  396 */     SortedMap<String, Charset> available = Charset.availableCharsets();
/*  397 */     Set<String> encodings = available.keySet();
/*  398 */     for (String charset : encodings) {
/*  399 */       result.add(Lisp.PACKAGE_KEYWORD.intern(charset));
/*      */     }
/*  401 */     return result;
/*      */   }
/*      */   
/*      */   public boolean isOpen() {
/*  405 */     return this.open;
/*      */   }
/*      */   
/*      */   public void setOpen(boolean b) {
/*  409 */     this.open = b;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typeOf() {
/*  414 */     return Symbol.SYSTEM_STREAM;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject classOf() {
/*  419 */     return BuiltInClass.SYSTEM_STREAM;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typep(LispObject typeSpecifier) {
/*  424 */     if (typeSpecifier == Symbol.SYSTEM_STREAM)
/*  425 */       return Lisp.T; 
/*  426 */     if (typeSpecifier == Symbol.STREAM)
/*  427 */       return Lisp.T; 
/*  428 */     if (typeSpecifier == BuiltInClass.STREAM)
/*  429 */       return Lisp.T; 
/*  430 */     return super.typep(typeSpecifier);
/*      */   }
/*      */   
/*      */   public LispObject getElementType() {
/*  434 */     return this.elementType;
/*      */   }
/*      */ 
/*      */   
/*      */   public int getOffset() {
/*  439 */     return this.offset;
/*      */   }
/*      */ 
/*      */   
/*      */   public final int getLineNumber() {
/*  444 */     return this.lineNumber;
/*      */   }
/*      */   
/*      */   protected void setWriter(Writer writer) {
/*  448 */     this.writer = writer;
/*      */   }
/*      */ 
/*      */   
/*      */   public int getCharPos() {
/*  453 */     return this.charPos;
/*      */   }
/*      */ 
/*      */   
/*      */   public void setCharPos(int n) {
/*  458 */     this.charPos = n;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static abstract class ReadtableAccessor
/*      */   {
/*      */     public abstract Readtable rt(LispThread param1LispThread);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  476 */   public static ReadtableAccessor currentReadtable = new ReadtableAccessor()
/*      */     {
/*      */       
/*      */       public Readtable rt(LispThread thread)
/*      */       {
/*  481 */         return (Readtable)Symbol.CURRENT_READTABLE
/*  482 */           .symbolValue(thread);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/*  487 */   public static ReadtableAccessor faslReadtable = new ReadtableAccessor()
/*      */     {
/*      */       
/*      */       public Readtable rt(LispThread thread)
/*      */       {
/*  492 */         return FaslReadtable.getInstance();
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject read(boolean eofError, LispObject eofValue, boolean recursive, LispThread thread, ReadtableAccessor rta) {
/*  501 */     LispObject result = readPreservingWhitespace(eofError, eofValue, recursive, thread, rta);
/*      */     
/*  503 */     if (result != eofValue && !recursive) {
/*      */       try {
/*  505 */         if (_charReady()) {
/*  506 */           int n = _readChar();
/*  507 */           if (n >= 0) {
/*  508 */             char c = (char)n;
/*  509 */             Readtable rt = rta.rt(thread);
/*  510 */             if (!rt.isWhitespace(c))
/*  511 */               _unreadChar(c); 
/*      */           } 
/*      */         } 
/*  514 */       } catch (IOException e) {
/*  515 */         return Lisp.error(new StreamError(this, e));
/*      */       } 
/*      */     }
/*  518 */     if (!eofError && result == eofValue) return result; 
/*  519 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL) {
/*  520 */       return Lisp.NIL;
/*      */     }
/*  522 */     return result;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  528 */   private static final Symbol _SHARP_EQUAL_ALIST_ = Lisp.internSpecial("*SHARP-EQUAL-ALIST*", Lisp.PACKAGE_SYS, Lisp.NIL);
/*      */   
/*  530 */   private static final Symbol _SHARP_SHARP_ALIST_ = Lisp.internSpecial("*SHARP-SHARP-ALIST*", Lisp.PACKAGE_SYS, Lisp.NIL);
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readPreservingWhitespace(boolean eofError, LispObject eofValue, boolean recursive, LispThread thread, ReadtableAccessor rta) {
/*  539 */     if (recursive) {
/*  540 */       Readtable rt = rta.rt(thread);
/*      */       while (true) {
/*  542 */         int n = -1;
/*      */         try {
/*  544 */           n = _readChar();
/*  545 */         } catch (IOException e) {
/*  546 */           Debug.trace(e);
/*  547 */           Lisp.error(new StreamError(this, e));
/*      */         } 
/*  549 */         if (n < 0) {
/*  550 */           if (eofError) {
/*  551 */             return Lisp.error(new EndOfFile(this));
/*      */           }
/*  553 */           return eofValue;
/*      */         } 
/*  555 */         char c = (char)n;
/*  556 */         if (rt.isWhitespace(c))
/*      */           continue; 
/*  558 */         LispObject result = processChar(thread, c, rt);
/*  559 */         if (result != null)
/*  560 */           return result; 
/*      */       } 
/*      */     } 
/*  563 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*  564 */     thread.bindSpecial(_SHARP_EQUAL_ALIST_, Lisp.NIL);
/*  565 */     thread.bindSpecial(_SHARP_SHARP_ALIST_, Lisp.NIL);
/*      */     try {
/*  567 */       return readPreservingWhitespace(eofError, eofValue, true, thread, rta);
/*      */     } finally {
/*      */       
/*  570 */       thread.resetSpecialBindings(mark);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private final LispObject processChar(LispThread thread, char c, Readtable rt) {
/*  584 */     LispObject value, handler = rt.getReaderMacroFunction(c);
/*      */ 
/*      */     
/*  587 */     if (handler instanceof ReaderMacroFunction) {
/*  588 */       thread._values = null;
/*  589 */       value = ((ReaderMacroFunction)handler).execute(this, c);
/*      */     }
/*  591 */     else if (handler != null && handler != Lisp.NIL) {
/*  592 */       thread._values = null;
/*  593 */       value = handler.execute(this, LispCharacter.getInstance(c));
/*      */     } else {
/*      */       
/*  596 */       return readToken(c, rt);
/*      */     } 
/*      */     
/*  599 */     if (value == Lisp.NIL) {
/*  600 */       LispObject[] values = thread._values;
/*  601 */       if (values != null && values.length == 0) {
/*  602 */         value = null;
/*  603 */         thread._values = null;
/*      */       } 
/*      */     } 
/*  606 */     return value;
/*      */   }
/*      */   
/*      */   public LispObject readPathname(ReadtableAccessor rta) {
/*  610 */     LispObject obj = read(true, Lisp.NIL, false, 
/*  611 */         LispThread.currentThread(), rta);
/*  612 */     if (obj instanceof AbstractString) {
/*  613 */       return Pathname.parseNamestring((AbstractString)obj);
/*      */     }
/*  615 */     if (obj.listp())
/*  616 */       return Pathname.makePathname(obj); 
/*  617 */     return Lisp.error(new TypeError("#p requires a string argument."));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject readSymbol() {
/*  622 */     Readtable rt = (Readtable)Symbol.CURRENT_READTABLE.symbolValue(LispThread.currentThread());
/*  623 */     return readSymbol(rt);
/*      */   }
/*      */   
/*      */   public LispObject readSymbol(Readtable rt) {
/*  627 */     StringBuilder sb = new StringBuilder();
/*  628 */     BitSet flags = _readToken(sb, rt);
/*  629 */     return new Symbol((rt.getReadtableCase() == Keyword.INVERT) ? 
/*  630 */         invert(sb.toString(), flags) : sb
/*  631 */         .toString());
/*      */   }
/*      */   
/*      */   public LispObject readStructure(ReadtableAccessor rta) {
/*  635 */     LispThread thread = LispThread.currentThread();
/*  636 */     LispObject obj = read(true, Lisp.NIL, true, thread, rta);
/*  637 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/*  638 */       return Lisp.NIL; 
/*  639 */     if (obj.listp()) {
/*  640 */       Symbol structure = Lisp.checkSymbol(obj.car());
/*  641 */       LispClass c = LispClass.findClass(structure);
/*  642 */       if (!(c instanceof StructureClass)) {
/*  643 */         return Lisp.error(new ReaderError(structure.getName() + " is not a defined structure type.", this));
/*      */       }
/*      */       
/*  646 */       LispObject args = obj.cdr();
/*      */       
/*  648 */       Symbol DEFSTRUCT_DEFAULT_CONSTRUCTOR = Lisp.PACKAGE_SYS.intern("DEFSTRUCT-DEFAULT-CONSTRUCTOR");
/*      */       
/*  650 */       LispObject constructor = DEFSTRUCT_DEFAULT_CONSTRUCTOR.getSymbolFunctionOrDie().execute(structure);
/*  651 */       int length = args.length();
/*  652 */       if (length % 2 != 0) {
/*  653 */         return Lisp.error(new ReaderError("Odd number of keyword arguments following #S: " + obj
/*  654 */               .princToString(), this));
/*      */       }
/*  656 */       LispObject[] array = new LispObject[length];
/*  657 */       LispObject rest = args;
/*  658 */       for (int i = 0; i < length; i += 2) {
/*  659 */         LispObject key = rest.car();
/*  660 */         if (key instanceof Symbol && ((Symbol)key).getPackage() == Lisp.PACKAGE_KEYWORD) {
/*  661 */           array[i] = key;
/*      */         } else {
/*  663 */           array[i] = Lisp.PACKAGE_KEYWORD.intern(Lisp.javaString(key));
/*      */         } 
/*  665 */         array[i + 1] = rest.cadr();
/*  666 */         rest = rest.cddr();
/*      */       } 
/*  668 */       return Lisp.funcall(constructor.getSymbolFunctionOrDie(), array, thread);
/*      */     } 
/*      */     
/*  671 */     return Lisp.error(new ReaderError("Non-list following #S: " + obj
/*  672 */           .princToString(), this));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readString(char terminator, ReadtableAccessor rta) {
/*  678 */     LispThread thread = LispThread.currentThread();
/*  679 */     Readtable rt = rta.rt(thread);
/*  680 */     StringBuilder sb = new StringBuilder();
/*      */     
/*      */     try {
/*      */       while (true) {
/*  684 */         int n = _readChar();
/*  685 */         if (n < 0) {
/*  686 */           return Lisp.error(new EndOfFile(this));
/*      */         }
/*  688 */         char c = (char)n;
/*  689 */         if (rt.getSyntaxType(c) == 4) {
/*      */           
/*  691 */           n = _readChar();
/*  692 */           if (n < 0) {
/*  693 */             return Lisp.error(new EndOfFile(this));
/*      */           }
/*  695 */           sb.append((char)n);
/*      */           continue;
/*      */         } 
/*  698 */         if (c == terminator) {
/*      */           break;
/*      */         }
/*  701 */         sb.append(c);
/*      */       }
/*      */     
/*  704 */     } catch (IOException e) {
/*      */ 
/*      */       
/*  707 */       return new SimpleString(sb);
/*      */     } 
/*  709 */     return new SimpleString(sb);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readList(boolean requireProperList, ReadtableAccessor rta) {
/*  715 */     LispThread thread = LispThread.currentThread();
/*  716 */     Cons first = null;
/*  717 */     Cons last = null;
/*      */     
/*      */     try {
/*      */       while (true) {
/*  721 */         Readtable rt = rta.rt(thread);
/*  722 */         char c = flushWhitespace(rt);
/*  723 */         if (c == ')') {
/*  724 */           return (first == null) ? Lisp.NIL : first;
/*      */         }
/*  726 */         if (c == '.') {
/*  727 */           int n = _readChar();
/*  728 */           if (n < 0)
/*  729 */             return Lisp.error(new EndOfFile(this)); 
/*  730 */           char nextChar = (char)n;
/*  731 */           if (isTokenDelimiter(nextChar, rt)) {
/*  732 */             if (last == null) {
/*  733 */               if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL) {
/*  734 */                 return Lisp.NIL;
/*      */               }
/*  736 */               return Lisp.error(new ReaderError("Nothing appears before . in list.", this));
/*      */             } 
/*      */             
/*  739 */             _unreadChar(nextChar);
/*  740 */             LispObject lispObject = read(true, Lisp.NIL, true, thread, rta);
/*  741 */             if (requireProperList && 
/*  742 */               !lispObject.listp()) {
/*  743 */               Lisp.error(new ReaderError("The value " + lispObject
/*  744 */                     .princToString() + " is not of type " + Symbol.LIST
/*      */                     
/*  746 */                     .princToString() + ".", this));
/*      */             }
/*      */             
/*  749 */             last.cdr = lispObject;
/*      */             
/*      */             continue;
/*      */           } 
/*  753 */           _unreadChar(nextChar);
/*      */         } 
/*      */         
/*  756 */         LispObject obj = processChar(thread, c, rt);
/*  757 */         if (obj == null) {
/*      */           continue;
/*      */         }
/*      */         
/*  761 */         if (first == null) {
/*  762 */           first = new Cons(obj);
/*  763 */           last = first; continue;
/*      */         } 
/*  765 */         Cons newCons = new Cons(obj);
/*  766 */         last.cdr = newCons;
/*  767 */         last = newCons;
/*      */       }
/*      */     
/*  770 */     } catch (IOException e) {
/*  771 */       Lisp.error(new StreamError(this, e));
/*  772 */       return null;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private static final boolean isTokenDelimiter(char c, Readtable rt) {
/*  779 */     byte type = rt.getSyntaxType(c);
/*      */     
/*  781 */     return (type == 2 || type == 1);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readDispatchChar(char dispChar, ReadtableAccessor rta) {
/*  789 */     int numArg = -1;
/*  790 */     char c = Character.MIN_VALUE;
/*      */     try {
/*      */       while (true) {
/*  793 */         int n = _readChar();
/*  794 */         if (n < 0)
/*  795 */           return Lisp.error(new EndOfFile(this)); 
/*  796 */         c = (char)n;
/*  797 */         if (c < '0' || c > '9')
/*      */           break; 
/*  799 */         if (numArg < 0)
/*  800 */           numArg = 0; 
/*  801 */         numArg = numArg * 10 + c - 48;
/*      */       } 
/*  803 */     } catch (IOException e) {
/*  804 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*  806 */     LispThread thread = LispThread.currentThread();
/*  807 */     Readtable rt = rta.rt(thread);
/*  808 */     LispObject fun = rt.getDispatchMacroCharacter(dispChar, c);
/*  809 */     if (fun != Lisp.NIL) {
/*      */ 
/*      */       
/*  812 */       thread._values = null;
/*  813 */       if (fun instanceof DispatchMacroFunction) {
/*  814 */         return ((DispatchMacroFunction)fun).execute(this, c, numArg);
/*      */       }
/*  816 */       return thread
/*  817 */         .execute(fun, this, LispCharacter.getInstance(c), (numArg < 0) ? Lisp.NIL : 
/*  818 */           Fixnum.getInstance(numArg));
/*      */     } 
/*      */     
/*  821 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL) {
/*  822 */       return null;
/*      */     }
/*  824 */     return Lisp.error(new ReaderError("No dispatch function defined for #\\" + c, this));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readSharpLeftParen(char c, int n, ReadtableAccessor rta) {
/*  831 */     LispThread thread = LispThread.currentThread();
/*  832 */     LispObject list = readList(true, rta);
/*  833 */     if (Lisp._BACKQUOTE_COUNT_.symbolValue(thread).zerop()) {
/*  834 */       if (n >= 0) {
/*  835 */         LispObject[] array = new LispObject[n];
/*  836 */         for (int i = 0; i < n; i++) {
/*  837 */           array[i] = list.car();
/*  838 */           if (list.cdr() != Lisp.NIL)
/*  839 */             list = list.cdr(); 
/*      */         } 
/*  841 */         return new SimpleVector(array);
/*      */       } 
/*  843 */       return new SimpleVector(list);
/*      */     } 
/*  845 */     return new Cons(Lisp._BQ_VECTOR_FLAG_.symbolValue(thread), list);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readSharpStar(char ignored, int n, ReadtableAccessor rta) {
/*  851 */     LispThread thread = LispThread.currentThread();
/*  852 */     Readtable rt = rta.rt(thread);
/*      */ 
/*      */     
/*  855 */     boolean suppress = (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL);
/*  856 */     StringBuilder sb = new StringBuilder();
/*      */     
/*      */     try {
/*      */       while (true) {
/*  860 */         int ch = _readChar();
/*  861 */         if (ch < 0)
/*      */           break; 
/*  863 */         char c = (char)ch;
/*  864 */         if (c == '0' || c == '1') {
/*  865 */           sb.append(c); continue;
/*      */         } 
/*  867 */         int syntaxType = rt.getSyntaxType(c);
/*  868 */         if (syntaxType == 1 || syntaxType == 2) {
/*      */           
/*  870 */           _unreadChar(c); break;
/*      */         } 
/*  872 */         if (!suppress) {
/*  873 */           String name = LispCharacter.charToName(c);
/*  874 */           if (name == null)
/*  875 */             name = "#\\" + c; 
/*  876 */           Lisp.error(new ReaderError("Illegal element for bit-vector: " + name, this));
/*      */         }
/*      */       
/*      */       }
/*      */     
/*      */     }
/*  882 */     catch (IOException e) {
/*      */       
/*  884 */       Lisp.error(new ReaderError("IO error: ", this));
/*      */       
/*  886 */       return Lisp.NIL;
/*      */     } 
/*      */     
/*  889 */     if (suppress)
/*  890 */       return Lisp.NIL; 
/*  891 */     if (n >= 0) {
/*      */       
/*  893 */       int length = sb.length();
/*  894 */       if (length == 0 && 
/*  895 */         n > 0) {
/*  896 */         return Lisp.error(new ReaderError("No element specified for bit vector of length " + n + '.', this));
/*      */       }
/*      */ 
/*      */       
/*  900 */       if (n > length) {
/*  901 */         char c = sb.charAt(length - 1);
/*  902 */         for (int i = length; i < n; i++)
/*  903 */           sb.append(c); 
/*  904 */       } else if (n < length) {
/*  905 */         return Lisp.error(new ReaderError("Bit vector is longer than specified length: #" + n + '*' + sb
/*  906 */               .toString(), this));
/*      */       } 
/*      */     } 
/*      */     
/*  910 */     return new SimpleBitVector(sb.toString());
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readSharpDot(char c, int n, ReadtableAccessor rta) {
/*  917 */     LispThread thread = LispThread.currentThread();
/*  918 */     if (Symbol.READ_EVAL.symbolValue(thread) == Lisp.NIL) {
/*  919 */       return Lisp.error(new ReaderError("Can't read #. when *READ-EVAL* is NIL.", this));
/*      */     }
/*      */     
/*  922 */     return Lisp.eval(read(true, Lisp.NIL, true, thread, rta), new Environment(), thread);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readCharacterLiteral(Readtable rt, LispThread thread) {
/*      */     try {
/*  930 */       int n = _readChar();
/*  931 */       if (n < 0)
/*  932 */         return Lisp.error(new EndOfFile(this)); 
/*  933 */       char c = (char)n;
/*  934 */       StringBuilder sb = new StringBuilder(String.valueOf(c));
/*      */       while (true) {
/*  936 */         n = _readChar();
/*  937 */         if (n < 0)
/*      */           break; 
/*  939 */         c = (char)n;
/*  940 */         if (rt.isWhitespace(c))
/*      */           break; 
/*  942 */         if (rt.getSyntaxType(c) == 2) {
/*      */           
/*  944 */           _unreadChar(c);
/*      */           break;
/*      */         } 
/*  947 */         sb.append(c);
/*      */       } 
/*  949 */       if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/*  950 */         return Lisp.NIL; 
/*  951 */       if (sb.length() == 1)
/*  952 */         return LispCharacter.getInstance(sb.charAt(0)); 
/*  953 */       String token = sb.toString();
/*  954 */       n = LispCharacter.nameToChar(token);
/*  955 */       if (n >= 0)
/*  956 */         return LispCharacter.getInstance((char)n); 
/*  957 */       return Lisp.error(new LispError("Unrecognized character name: \"" + token + '"'));
/*  958 */     } catch (IOException e) {
/*  959 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */   
/*      */   public void skipBalancedComment() {
/*      */     try {
/*      */       while (true) {
/*  966 */         int n = _readChar();
/*  967 */         if (n < 0)
/*      */           return; 
/*  969 */         if (n == 124) {
/*  970 */           n = _readChar();
/*  971 */           if (n == 35) {
/*      */             return;
/*      */           }
/*  974 */           _unreadChar(n); continue;
/*  975 */         }  if (n == 35) {
/*  976 */           n = _readChar();
/*  977 */           if (n == 124) {
/*  978 */             skipBalancedComment(); continue;
/*      */           } 
/*  980 */           _unreadChar(n);
/*      */         } 
/*      */       } 
/*  983 */     } catch (IOException e) {
/*  984 */       Lisp.error(new StreamError(this, e));
/*      */       return;
/*      */     } 
/*      */   }
/*      */   public LispObject readArray(int rank, ReadtableAccessor rta) {
/*  989 */     LispThread thread = LispThread.currentThread();
/*  990 */     LispObject obj = read(true, Lisp.NIL, true, thread, rta);
/*  991 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/*  992 */       return Lisp.NIL; 
/*  993 */     switch (rank) {
/*      */       case -1:
/*  995 */         return Lisp.error(new ReaderError("No dimensions argument to #A.", this));
/*      */       case 0:
/*  997 */         return new ZeroRankArray(Lisp.T, obj, false);
/*      */       case 1:
/*  999 */         if (obj.listp() || obj instanceof AbstractVector)
/* 1000 */           return new SimpleVector(obj); 
/* 1001 */         return Lisp.error(new ReaderError(obj.princToString() + " is not a sequence.", this));
/*      */     } 
/*      */ 
/*      */     
/* 1005 */     return new SimpleArray_T(rank, obj);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject readComplex(ReadtableAccessor rta) {
/* 1010 */     LispThread thread = LispThread.currentThread();
/* 1011 */     LispObject obj = read(true, Lisp.NIL, true, thread, rta);
/* 1012 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/* 1013 */       return Lisp.NIL; 
/* 1014 */     if (obj instanceof Cons && obj.length() == 2) {
/* 1015 */       return Complex.getInstance(obj.car(), obj.cadr());
/*      */     }
/* 1017 */     StringBuilder sb = new StringBuilder("Invalid complex number format");
/* 1018 */     if (this instanceof FileStream) {
/* 1019 */       Pathname p = ((FileStream)this).getPathname();
/* 1020 */       if (p != null) {
/* 1021 */         String namestring = p.getNamestring();
/* 1022 */         if (namestring != null) {
/* 1023 */           sb.append(" in #P\"");
/* 1024 */           sb.append(namestring);
/* 1025 */           sb.append('"');
/*      */         } 
/*      */       } 
/* 1028 */       sb.append(" at offset ");
/* 1029 */       sb.append(_getFilePosition());
/*      */     } 
/* 1031 */     sb.append(": #C");
/* 1032 */     sb.append(obj.printObject());
/* 1033 */     return Lisp.error(new ReaderError(sb.toString(), this));
/*      */   }
/*      */   
/*      */   private String readMultipleEscape(Readtable rt) {
/* 1037 */     StringBuilder sb = new StringBuilder();
/*      */     try {
/*      */       while (true) {
/* 1040 */         int n = _readChar();
/* 1041 */         if (n < 0) {
/* 1042 */           return Lisp.serror(new EndOfFile(this));
/*      */         }
/* 1044 */         char c = (char)n;
/* 1045 */         byte syntaxType = rt.getSyntaxType(c);
/* 1046 */         if (syntaxType == 4) {
/* 1047 */           n = _readChar();
/* 1048 */           if (n < 0) {
/* 1049 */             return Lisp.serror(new EndOfFile(this));
/*      */           }
/* 1051 */           sb.append((char)n);
/*      */           continue;
/*      */         } 
/* 1054 */         if (syntaxType == 5)
/*      */           break; 
/* 1056 */         sb.append(c);
/*      */       } 
/* 1058 */     } catch (IOException e) {
/* 1059 */       return Lisp.serror(new StreamError(this, e));
/*      */     } 
/* 1061 */     return sb.toString();
/*      */   }
/*      */   
/*      */   private static final int findUnescapedSingleColon(String s, BitSet flags) {
/* 1065 */     if (flags == null)
/* 1066 */       return s.indexOf(':'); 
/* 1067 */     int limit = s.length();
/* 1068 */     for (int i = 0; i < limit; i++) {
/* 1069 */       if (s.charAt(i) == ':' && !flags.get(i)) {
/* 1070 */         return i;
/*      */       }
/*      */     } 
/* 1073 */     return -1;
/*      */   }
/*      */   
/*      */   private static final int findUnescapedDoubleColon(String s, BitSet flags) {
/* 1077 */     if (flags == null)
/* 1078 */       return s.indexOf("::"); 
/* 1079 */     int limit = s.length() - 1;
/* 1080 */     for (int i = 0; i < limit; i++) {
/* 1081 */       if (s.charAt(i) == ':' && !flags.get(i) && 
/* 1082 */         s.charAt(i + 1) == ':' && !flags.get(i + 1)) {
/* 1083 */         return i;
/*      */       }
/*      */     } 
/*      */     
/* 1087 */     return -1;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private final LispObject readToken(char c, Readtable rt) {
/* 1093 */     StringBuilder sb = new StringBuilder(String.valueOf(c));
/* 1094 */     LispThread thread = LispThread.currentThread();
/* 1095 */     BitSet flags = _readToken(sb, rt);
/* 1096 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/* 1097 */       return Lisp.NIL; 
/* 1098 */     LispObject readtableCase = rt.getReadtableCase();
/* 1099 */     String token = sb.toString();
/* 1100 */     boolean invert = (readtableCase == Keyword.INVERT);
/* 1101 */     int length = token.length();
/* 1102 */     if (length > 0) {
/* 1103 */       String symbolName; BitSet symbolFlags; char firstChar = token.charAt(0);
/* 1104 */       if (flags == null) {
/* 1105 */         if (firstChar == '.') {
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */           
/* 1112 */           boolean ok = false;
/* 1113 */           for (int i = length; i-- > 1;) {
/* 1114 */             if (token.charAt(i) != '.') {
/* 1115 */               ok = true;
/*      */               break;
/*      */             } 
/*      */           } 
/* 1119 */           if (!ok) {
/*      */             String message;
/* 1121 */             if (length > 1) {
/* 1122 */               message = "Too many dots.";
/*      */             } else {
/* 1124 */               message = "Dot context error.";
/* 1125 */             }  return Lisp.error(new ReaderError(message, this));
/*      */           } 
/*      */         } 
/* 1128 */         int radix = getReadBase(thread);
/* 1129 */         if ("+-.0123456789".indexOf(firstChar) >= 0) {
/* 1130 */           LispObject number = makeNumber(token, length, radix);
/* 1131 */           if (number != null)
/* 1132 */             return number; 
/* 1133 */         } else if (Character.digit(firstChar, radix) >= 0) {
/* 1134 */           LispObject number = makeNumber(token, length, radix);
/* 1135 */           if (number != null) {
/* 1136 */             return number;
/*      */           }
/*      */         } 
/*      */       } 
/*      */       
/* 1141 */       String packageName = null;
/*      */       
/* 1143 */       BitSet packageFlags = null;
/* 1144 */       Package package_ = null;
/* 1145 */       boolean internSymbol = true;
/* 1146 */       if (firstChar == ':' && (flags == null || !flags.get(0)))
/* 1147 */       { symbolName = token.substring(1);
/* 1148 */         package_ = Lisp.PACKAGE_KEYWORD;
/* 1149 */         if (flags != null) {
/* 1150 */           symbolFlags = flags.get(1, flags.size());
/*      */         } else {
/* 1152 */           symbolFlags = null;
/*      */         }  }
/* 1154 */       else { int index = findUnescapedDoubleColon(token, flags);
/* 1155 */         if (index > 0) {
/* 1156 */           packageName = token.substring(0, index);
/* 1157 */           packageFlags = (flags != null) ? flags.get(0, index) : null;
/* 1158 */           symbolName = token.substring(index + 2);
/* 1159 */           symbolFlags = (flags != null) ? flags.get(index + 2, flags.size()) : null;
/*      */         } else {
/* 1161 */           index = findUnescapedSingleColon(token, flags);
/* 1162 */           if (index > 0) {
/* 1163 */             packageName = token.substring(0, index);
/* 1164 */             packageFlags = (flags != null) ? flags.get(0, index) : null;
/* 1165 */             symbolName = token.substring(index + 1);
/* 1166 */             symbolFlags = (flags != null) ? flags.get(index + 2, flags.size()) : null;
/* 1167 */             internSymbol = false;
/*      */           } else {
/* 1169 */             package_ = (Package)Symbol._PACKAGE_.symbolValue(thread);
/* 1170 */             symbolName = token;
/* 1171 */             symbolFlags = flags;
/*      */           } 
/*      */         }  }
/*      */       
/* 1175 */       if (package_ == null) {
/* 1176 */         if (invert) {
/* 1177 */           packageName = invert(packageName, packageFlags);
/*      */         }
/* 1179 */         package_ = Lisp.getCurrentPackage().findPackage(packageName);
/* 1180 */         if (package_ == null)
/* 1181 */           return Lisp.error(new ReaderError("The package \"" + packageName + "\" can't be found.", this)); 
/*      */       } 
/* 1183 */       if (invert) {
/* 1184 */         symbolName = invert(symbolName, symbolFlags);
/*      */       }
/* 1186 */       if (internSymbol) {
/* 1187 */         return package_.intern(symbolName);
/*      */       }
/* 1189 */       Symbol symbol = package_.findExternalSymbol(symbolName);
/* 1190 */       if (symbol != null) {
/* 1191 */         return symbol;
/*      */       }
/*      */       
/* 1194 */       if (package_.findInternalSymbol(symbolName) != null) {
/* 1195 */         return Lisp.error(new ReaderError("The symbol \"~A\" is not external in package ~A.", this, new SimpleString(symbolName), new SimpleString(packageName)));
/*      */       }
/*      */ 
/*      */ 
/*      */       
/* 1200 */       return Lisp.error(new ReaderError("The symbol \"~A\" was not found in package ~A.", this, new SimpleString(symbolName), new SimpleString(packageName)));
/*      */     } 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 1207 */     Package pkg = (Package)Symbol._PACKAGE_.symbolValue(thread);
/* 1208 */     return pkg.intern("");
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private final BitSet _readToken(StringBuilder sb, Readtable rt) {
/*      */     // Byte code:
/*      */     //   0: aconst_null
/*      */     //   1: astore_3
/*      */     //   2: aload_2
/*      */     //   3: invokevirtual getReadtableCase : ()Lorg/armedbear/lisp/LispObject;
/*      */     //   6: astore #4
/*      */     //   8: aload_1
/*      */     //   9: invokevirtual length : ()I
/*      */     //   12: ifle -> 229
/*      */     //   15: aload_1
/*      */     //   16: invokevirtual length : ()I
/*      */     //   19: iconst_1
/*      */     //   20: if_icmpne -> 27
/*      */     //   23: iconst_1
/*      */     //   24: goto -> 28
/*      */     //   27: iconst_0
/*      */     //   28: invokestatic assertTrue : (Z)V
/*      */     //   31: aload_1
/*      */     //   32: iconst_0
/*      */     //   33: invokevirtual charAt : (I)C
/*      */     //   36: istore #5
/*      */     //   38: aload_2
/*      */     //   39: iload #5
/*      */     //   41: invokevirtual getSyntaxType : (C)B
/*      */     //   44: istore #6
/*      */     //   46: iload #6
/*      */     //   48: iconst_4
/*      */     //   49: if_icmpne -> 126
/*      */     //   52: iconst_m1
/*      */     //   53: istore #7
/*      */     //   55: aload_0
/*      */     //   56: invokevirtual _readChar : ()I
/*      */     //   59: istore #7
/*      */     //   61: goto -> 82
/*      */     //   64: astore #8
/*      */     //   66: new org/armedbear/lisp/StreamError
/*      */     //   69: dup
/*      */     //   70: aload_0
/*      */     //   71: aload #8
/*      */     //   73: invokespecial <init> : (Lorg/armedbear/lisp/Stream;Ljava/lang/Throwable;)V
/*      */     //   76: invokestatic error : (Lorg/armedbear/lisp/LispObject;)Lorg/armedbear/lisp/LispObject;
/*      */     //   79: pop
/*      */     //   80: aload_3
/*      */     //   81: areturn
/*      */     //   82: iload #7
/*      */     //   84: ifge -> 101
/*      */     //   87: new org/armedbear/lisp/EndOfFile
/*      */     //   90: dup
/*      */     //   91: aload_0
/*      */     //   92: invokespecial <init> : (Lorg/armedbear/lisp/Stream;)V
/*      */     //   95: invokestatic error : (Lorg/armedbear/lisp/LispObject;)Lorg/armedbear/lisp/LispObject;
/*      */     //   98: pop
/*      */     //   99: aconst_null
/*      */     //   100: areturn
/*      */     //   101: aload_1
/*      */     //   102: iconst_0
/*      */     //   103: iload #7
/*      */     //   105: i2c
/*      */     //   106: invokevirtual setCharAt : (IC)V
/*      */     //   109: new java/util/BitSet
/*      */     //   112: dup
/*      */     //   113: iconst_1
/*      */     //   114: invokespecial <init> : (I)V
/*      */     //   117: astore_3
/*      */     //   118: aload_3
/*      */     //   119: iconst_0
/*      */     //   120: invokevirtual set : (I)V
/*      */     //   123: goto -> 229
/*      */     //   126: iload #6
/*      */     //   128: iconst_5
/*      */     //   129: if_icmpne -> 171
/*      */     //   132: aload_1
/*      */     //   133: iconst_0
/*      */     //   134: invokevirtual setLength : (I)V
/*      */     //   137: aload_1
/*      */     //   138: aload_0
/*      */     //   139: aload_2
/*      */     //   140: invokespecial readMultipleEscape : (Lorg/armedbear/lisp/Readtable;)Ljava/lang/String;
/*      */     //   143: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
/*      */     //   146: pop
/*      */     //   147: new java/util/BitSet
/*      */     //   150: dup
/*      */     //   151: aload_1
/*      */     //   152: invokevirtual length : ()I
/*      */     //   155: invokespecial <init> : (I)V
/*      */     //   158: astore_3
/*      */     //   159: aload_3
/*      */     //   160: iconst_0
/*      */     //   161: aload_1
/*      */     //   162: invokevirtual length : ()I
/*      */     //   165: invokevirtual set : (II)V
/*      */     //   168: goto -> 229
/*      */     //   171: aload_2
/*      */     //   172: iload #5
/*      */     //   174: invokevirtual isInvalid : (C)Z
/*      */     //   177: ifeq -> 190
/*      */     //   180: aload_2
/*      */     //   181: iload #5
/*      */     //   183: aload_0
/*      */     //   184: invokevirtual checkInvalid : (CLorg/armedbear/lisp/Stream;)V
/*      */     //   187: goto -> 229
/*      */     //   190: aload #4
/*      */     //   192: getstatic org/armedbear/lisp/Keyword.UPCASE : Lorg/armedbear/lisp/Symbol;
/*      */     //   195: if_acmpne -> 211
/*      */     //   198: aload_1
/*      */     //   199: iconst_0
/*      */     //   200: iload #5
/*      */     //   202: invokestatic toUpperCase : (C)C
/*      */     //   205: invokevirtual setCharAt : (IC)V
/*      */     //   208: goto -> 229
/*      */     //   211: aload #4
/*      */     //   213: getstatic org/armedbear/lisp/Keyword.DOWNCASE : Lorg/armedbear/lisp/Symbol;
/*      */     //   216: if_acmpne -> 229
/*      */     //   219: aload_1
/*      */     //   220: iconst_0
/*      */     //   221: iload #5
/*      */     //   223: invokestatic toLowerCase : (C)C
/*      */     //   226: invokevirtual setCharAt : (IC)V
/*      */     //   229: aload_0
/*      */     //   230: invokevirtual _readChar : ()I
/*      */     //   233: istore #5
/*      */     //   235: iload #5
/*      */     //   237: ifge -> 243
/*      */     //   240: goto -> 451
/*      */     //   243: iload #5
/*      */     //   245: i2c
/*      */     //   246: istore #6
/*      */     //   248: aload_2
/*      */     //   249: iload #6
/*      */     //   251: invokevirtual isWhitespace : (C)Z
/*      */     //   254: ifeq -> 266
/*      */     //   257: aload_0
/*      */     //   258: iload #5
/*      */     //   260: invokevirtual _unreadChar : (I)V
/*      */     //   263: goto -> 451
/*      */     //   266: aload_2
/*      */     //   267: iload #6
/*      */     //   269: invokevirtual getSyntaxType : (C)B
/*      */     //   272: istore #7
/*      */     //   274: iload #7
/*      */     //   276: iconst_2
/*      */     //   277: if_icmpne -> 289
/*      */     //   280: aload_0
/*      */     //   281: iload #6
/*      */     //   283: invokevirtual _unreadChar : (I)V
/*      */     //   286: goto -> 451
/*      */     //   289: aload_2
/*      */     //   290: iload #6
/*      */     //   292: aload_0
/*      */     //   293: invokevirtual checkInvalid : (CLorg/armedbear/lisp/Stream;)V
/*      */     //   296: iload #7
/*      */     //   298: iconst_4
/*      */     //   299: if_icmpne -> 353
/*      */     //   302: aload_0
/*      */     //   303: invokevirtual _readChar : ()I
/*      */     //   306: istore #5
/*      */     //   308: iload #5
/*      */     //   310: ifge -> 316
/*      */     //   313: goto -> 451
/*      */     //   316: aload_1
/*      */     //   317: iload #5
/*      */     //   319: i2c
/*      */     //   320: invokevirtual append : (C)Ljava/lang/StringBuilder;
/*      */     //   323: pop
/*      */     //   324: aload_3
/*      */     //   325: ifnonnull -> 340
/*      */     //   328: new java/util/BitSet
/*      */     //   331: dup
/*      */     //   332: aload_1
/*      */     //   333: invokevirtual length : ()I
/*      */     //   336: invokespecial <init> : (I)V
/*      */     //   339: astore_3
/*      */     //   340: aload_3
/*      */     //   341: aload_1
/*      */     //   342: invokevirtual length : ()I
/*      */     //   345: iconst_1
/*      */     //   346: isub
/*      */     //   347: invokevirtual set : (I)V
/*      */     //   350: goto -> 229
/*      */     //   353: iload #7
/*      */     //   355: iconst_5
/*      */     //   356: if_icmpne -> 408
/*      */     //   359: aload_1
/*      */     //   360: invokevirtual length : ()I
/*      */     //   363: istore #8
/*      */     //   365: aload_1
/*      */     //   366: aload_0
/*      */     //   367: aload_2
/*      */     //   368: invokespecial readMultipleEscape : (Lorg/armedbear/lisp/Readtable;)Ljava/lang/String;
/*      */     //   371: invokevirtual append : (Ljava/lang/String;)Ljava/lang/StringBuilder;
/*      */     //   374: pop
/*      */     //   375: aload_1
/*      */     //   376: invokevirtual length : ()I
/*      */     //   379: istore #9
/*      */     //   381: aload_3
/*      */     //   382: ifnonnull -> 397
/*      */     //   385: new java/util/BitSet
/*      */     //   388: dup
/*      */     //   389: aload_1
/*      */     //   390: invokevirtual length : ()I
/*      */     //   393: invokespecial <init> : (I)V
/*      */     //   396: astore_3
/*      */     //   397: aload_3
/*      */     //   398: iload #8
/*      */     //   400: iload #9
/*      */     //   402: invokevirtual set : (II)V
/*      */     //   405: goto -> 229
/*      */     //   408: aload #4
/*      */     //   410: getstatic org/armedbear/lisp/Keyword.UPCASE : Lorg/armedbear/lisp/Symbol;
/*      */     //   413: if_acmpne -> 426
/*      */     //   416: iload #6
/*      */     //   418: invokestatic toUpperCase : (C)C
/*      */     //   421: istore #6
/*      */     //   423: goto -> 441
/*      */     //   426: aload #4
/*      */     //   428: getstatic org/armedbear/lisp/Keyword.DOWNCASE : Lorg/armedbear/lisp/Symbol;
/*      */     //   431: if_acmpne -> 441
/*      */     //   434: iload #6
/*      */     //   436: invokestatic toLowerCase : (C)C
/*      */     //   439: istore #6
/*      */     //   441: aload_1
/*      */     //   442: iload #6
/*      */     //   444: invokevirtual append : (C)Ljava/lang/StringBuilder;
/*      */     //   447: pop
/*      */     //   448: goto -> 229
/*      */     //   451: goto -> 472
/*      */     //   454: astore #5
/*      */     //   456: new org/armedbear/lisp/StreamError
/*      */     //   459: dup
/*      */     //   460: aload_0
/*      */     //   461: aload #5
/*      */     //   463: invokespecial <init> : (Lorg/armedbear/lisp/Stream;Ljava/lang/Throwable;)V
/*      */     //   466: invokestatic error : (Lorg/armedbear/lisp/LispObject;)Lorg/armedbear/lisp/LispObject;
/*      */     //   469: pop
/*      */     //   470: aload_3
/*      */     //   471: areturn
/*      */     //   472: aload_3
/*      */     //   473: areturn
/*      */     // Line number table:
/*      */     //   Java source line number -> byte code offset
/*      */     //   #1215	-> 0
/*      */     //   #1216	-> 2
/*      */     //   #1217	-> 8
/*      */     //   #1218	-> 15
/*      */     //   #1219	-> 31
/*      */     //   #1220	-> 38
/*      */     //   #1221	-> 46
/*      */     //   #1222	-> 52
/*      */     //   #1224	-> 55
/*      */     //   #1228	-> 61
/*      */     //   #1225	-> 64
/*      */     //   #1226	-> 66
/*      */     //   #1227	-> 80
/*      */     //   #1229	-> 82
/*      */     //   #1230	-> 87
/*      */     //   #1231	-> 99
/*      */     //   #1234	-> 101
/*      */     //   #1235	-> 109
/*      */     //   #1236	-> 118
/*      */     //   #1237	-> 123
/*      */     //   #1238	-> 132
/*      */     //   #1239	-> 137
/*      */     //   #1240	-> 147
/*      */     //   #1241	-> 159
/*      */     //   #1242	-> 171
/*      */     //   #1243	-> 180
/*      */     //   #1244	-> 190
/*      */     //   #1245	-> 198
/*      */     //   #1246	-> 211
/*      */     //   #1247	-> 219
/*      */     //   #1252	-> 229
/*      */     //   #1253	-> 235
/*      */     //   #1254	-> 240
/*      */     //   #1255	-> 243
/*      */     //   #1256	-> 248
/*      */     //   #1257	-> 257
/*      */     //   #1258	-> 263
/*      */     //   #1260	-> 266
/*      */     //   #1261	-> 274
/*      */     //   #1262	-> 280
/*      */     //   #1263	-> 286
/*      */     //   #1265	-> 289
/*      */     //   #1266	-> 296
/*      */     //   #1267	-> 302
/*      */     //   #1268	-> 308
/*      */     //   #1269	-> 313
/*      */     //   #1270	-> 316
/*      */     //   #1271	-> 324
/*      */     //   #1272	-> 328
/*      */     //   #1273	-> 340
/*      */     //   #1274	-> 350
/*      */     //   #1276	-> 353
/*      */     //   #1277	-> 359
/*      */     //   #1278	-> 365
/*      */     //   #1279	-> 375
/*      */     //   #1280	-> 381
/*      */     //   #1281	-> 385
/*      */     //   #1282	-> 397
/*      */     //   #1283	-> 405
/*      */     //   #1285	-> 408
/*      */     //   #1286	-> 416
/*      */     //   #1287	-> 426
/*      */     //   #1288	-> 434
/*      */     //   #1289	-> 441
/*      */     //   #1290	-> 448
/*      */     //   #1294	-> 451
/*      */     //   #1291	-> 454
/*      */     //   #1292	-> 456
/*      */     //   #1293	-> 470
/*      */     //   #1296	-> 472
/*      */     // Local variable table:
/*      */     //   start	length	slot	name	descriptor
/*      */     //   66	16	8	e	Ljava/io/IOException;
/*      */     //   55	68	7	n	I
/*      */     //   38	191	5	c	C
/*      */     //   46	183	6	syntaxType	B
/*      */     //   365	43	8	begin	I
/*      */     //   381	27	9	end	I
/*      */     //   235	213	5	n	I
/*      */     //   248	200	6	c	C
/*      */     //   274	174	7	syntaxType	B
/*      */     //   456	16	5	e	Ljava/io/IOException;
/*      */     //   0	474	0	this	Lorg/armedbear/lisp/Stream;
/*      */     //   0	474	1	sb	Ljava/lang/StringBuilder;
/*      */     //   0	474	2	rt	Lorg/armedbear/lisp/Readtable;
/*      */     //   2	472	3	flags	Ljava/util/BitSet;
/*      */     //   8	466	4	readtableCase	Lorg/armedbear/lisp/LispObject;
/*      */     // Exception table:
/*      */     //   from	to	target	type
/*      */     //   55	61	64	java/io/IOException
/*      */     //   229	451	454	java/io/IOException
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final String invert(String s, BitSet flags) {
/* 1303 */     int limit = s.length();
/* 1304 */     int LOWER = 1;
/* 1305 */     int UPPER = 2;
/* 1306 */     int state = 0;
/* 1307 */     for (int i = 0; i < limit; i++) {
/*      */       
/* 1309 */       if (flags == null || !flags.get(i)) {
/*      */         
/* 1311 */         char c = s.charAt(i);
/* 1312 */         if (Character.isUpperCase(c)) {
/* 1313 */           if (state == 1)
/* 1314 */             return s; 
/* 1315 */           state = 2;
/*      */         } 
/* 1317 */         if (Character.isLowerCase(c)) {
/* 1318 */           if (state == 2)
/* 1319 */             return s; 
/* 1320 */           state = 1;
/*      */         } 
/*      */       } 
/* 1323 */     }  StringBuilder sb = new StringBuilder(limit);
/* 1324 */     for (int j = 0; j < limit; j++) {
/* 1325 */       char c = s.charAt(j);
/* 1326 */       if (flags != null && flags.get(j)) {
/* 1327 */         sb.append(c);
/* 1328 */       } else if (Character.isUpperCase(c)) {
/* 1329 */         sb.append(Character.toLowerCase(c));
/* 1330 */       } else if (Character.isLowerCase(c)) {
/* 1331 */         sb.append(Character.toUpperCase(c));
/*      */       } else {
/* 1333 */         sb.append(c);
/*      */       } 
/* 1335 */     }  return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private static final int getReadBase(LispThread thread) {
/*      */     int readBase;
/* 1342 */     LispObject readBaseObject = Symbol.READ_BASE.symbolValue(thread);
/* 1343 */     if (readBaseObject instanceof Fixnum) {
/* 1344 */       readBase = ((Fixnum)readBaseObject).value;
/*      */     } else {
/*      */       
/* 1347 */       return Lisp.ierror(new LispError("The value of *READ-BASE* is not of type '(INTEGER 2 36)."));
/*      */     } 
/*      */     
/* 1350 */     if (readBase < 2 || readBase > 36) {
/* 1351 */       return Lisp.ierror(new LispError("The value of *READ-BASE* is not of type '(INTEGER 2 36)."));
/*      */     }
/*      */     
/* 1354 */     return readBase;
/*      */   }
/*      */ 
/*      */   
/*      */   private final LispObject makeNumber(String token, int length, int radix) {
/* 1359 */     if (length == 0)
/* 1360 */       return null; 
/* 1361 */     if (token.indexOf('/') >= 0)
/* 1362 */       return makeRatio(token, radix); 
/* 1363 */     if (token.charAt(length - 1) == '.') {
/* 1364 */       radix = 10;
/* 1365 */       token = token.substring(0, --length);
/*      */     } 
/* 1367 */     boolean numeric = true;
/* 1368 */     if (radix == 10) {
/* 1369 */       for (int i = length; i-- > 0; ) {
/* 1370 */         char c = token.charAt(i);
/* 1371 */         if ((c < '0' || c > '9') && (
/* 1372 */           i > 0 || (c != '-' && c != '+'))) {
/* 1373 */           numeric = false;
/*      */           
/*      */           break;
/*      */         } 
/*      */       } 
/*      */     } else {
/* 1379 */       for (int i = length; i-- > 0; ) {
/* 1380 */         char c = token.charAt(i);
/* 1381 */         if (Character.digit(c, radix) < 0 && (
/* 1382 */           i > 0 || (c != '-' && c != '+'))) {
/* 1383 */           numeric = false;
/*      */           
/*      */           break;
/*      */         } 
/*      */       } 
/*      */     } 
/* 1389 */     if (!numeric)
/* 1390 */       return makeFloat(token, length); 
/* 1391 */     if (token.charAt(0) == '+')
/* 1392 */       token = token.substring(1); 
/*      */     try {
/* 1394 */       int n = Integer.parseInt(token, radix);
/* 1395 */       return (n >= 0 && n <= 255) ? Fixnum.constants[n] : Fixnum.getInstance(n);
/* 1396 */     } catch (NumberFormatException numberFormatException) {
/*      */       
/*      */       try {
/* 1399 */         return Bignum.getInstance(token, radix);
/* 1400 */       } catch (NumberFormatException numberFormatException1) {
/*      */         
/* 1402 */         return null;
/*      */       } 
/*      */     } 
/*      */   }
/*      */   
/*      */   private final LispObject makeRatio(String token, int radix) {
/* 1408 */     int index = token.indexOf('/');
/* 1409 */     if (index < 0) {
/* 1410 */       return null;
/*      */     }
/*      */     try {
/* 1413 */       BigInteger numerator = new BigInteger(token.substring(0, index), radix);
/*      */       
/* 1415 */       BigInteger denominator = new BigInteger(token.substring(index + 1), radix);
/*      */ 
/*      */ 
/*      */       
/* 1419 */       if (denominator.signum() == 0)
/* 1420 */         Lisp.error(new ReaderError("Division by zero.", this)); 
/* 1421 */       return Lisp.number(numerator, denominator);
/* 1422 */     } catch (NumberFormatException e) {
/* 1423 */       return null;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private static final LispObject makeFloat(String token, int length) {
/* 1430 */     if (length == 0)
/* 1431 */       return null; 
/* 1432 */     StringBuilder sb = new StringBuilder();
/* 1433 */     int i = 0;
/* 1434 */     boolean maybe = false;
/* 1435 */     char marker = Character.MIN_VALUE;
/* 1436 */     char c = token.charAt(i);
/* 1437 */     if (c == '-' || c == '+') {
/* 1438 */       sb.append(c);
/* 1439 */       i++;
/*      */     } 
/* 1441 */     while (i < length) {
/* 1442 */       c = token.charAt(i);
/* 1443 */       if (c == '.' || (c >= '0' && c <= '9')) {
/* 1444 */         if (c == '.')
/* 1445 */           maybe = true; 
/* 1446 */         sb.append(c);
/* 1447 */         i++;
/*      */       } 
/*      */     } 
/*      */     
/* 1451 */     if (i < length) {
/* 1452 */       c = token.charAt(i);
/* 1453 */       if ("esfdlESFDL".indexOf(c) >= 0) {
/*      */         
/* 1455 */         maybe = true;
/* 1456 */         marker = LispCharacter.toUpperCase(c);
/* 1457 */         if (marker == 'S') {
/* 1458 */           marker = 'F';
/* 1459 */         } else if (marker == 'L') {
/* 1460 */           marker = 'D';
/* 1461 */         } else if (marker == 'E') {
/* 1462 */           LispObject format = Symbol.READ_DEFAULT_FLOAT_FORMAT.symbolValue();
/* 1463 */           if (format == Symbol.SINGLE_FLOAT || format == Symbol.SHORT_FLOAT) {
/* 1464 */             marker = 'F';
/*      */           } else {
/* 1466 */             marker = 'D';
/*      */           } 
/* 1468 */         }  sb.append('E');
/* 1469 */         i++;
/*      */       } 
/*      */     } 
/* 1472 */     if (!maybe) {
/* 1473 */       return null;
/*      */     }
/* 1475 */     sb.append(token.substring(i));
/* 1476 */     c = sb.charAt(sb.length() - 1);
/* 1477 */     if ('0' > c || c > '9')
/*      */     {
/*      */ 
/*      */ 
/*      */       
/* 1482 */       return null; } 
/*      */     try {
/* 1484 */       if (marker == '\000') {
/* 1485 */         LispObject format = Symbol.READ_DEFAULT_FLOAT_FORMAT.symbolValue();
/* 1486 */         if (format == Symbol.SINGLE_FLOAT || format == Symbol.SHORT_FLOAT) {
/* 1487 */           marker = 'F';
/*      */         } else {
/* 1489 */           marker = 'D';
/*      */         } 
/* 1491 */       }  if (marker == 'D') {
/* 1492 */         return new DoubleFloat(Double.parseDouble(sb.toString()));
/*      */       }
/* 1494 */       return new SingleFloat(Float.parseFloat(sb.toString()));
/* 1495 */     } catch (NumberFormatException e) {
/* 1496 */       return null;
/*      */     } 
/*      */   }
/*      */   
/*      */   public LispObject readRadix(int radix, ReadtableAccessor rta) {
/* 1501 */     StringBuilder sb = new StringBuilder();
/* 1502 */     LispThread thread = LispThread.currentThread();
/* 1503 */     Readtable rt = rta.rt(thread);
/* 1504 */     boolean escaped = (_readToken(sb, rt) != null);
/* 1505 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL)
/* 1506 */       return Lisp.NIL; 
/* 1507 */     if (escaped)
/* 1508 */       return Lisp.error(new ReaderError("Illegal syntax for number.", this)); 
/* 1509 */     String s = sb.toString();
/* 1510 */     if (s.indexOf('/') >= 0) {
/* 1511 */       return makeRatio(s, radix);
/*      */     }
/*      */     
/* 1514 */     if (s.charAt(0) == '+')
/* 1515 */       s = s.substring(1); 
/*      */     try {
/* 1517 */       int n = Integer.parseInt(s, radix);
/* 1518 */       return (n >= 0 && n <= 255) ? Fixnum.constants[n] : Fixnum.getInstance(n);
/* 1519 */     } catch (NumberFormatException numberFormatException) {
/*      */       
/*      */       try {
/* 1522 */         return Bignum.getInstance(s, radix);
/* 1523 */       } catch (NumberFormatException numberFormatException1) {
/*      */         
/* 1525 */         return Lisp.error(new LispError());
/*      */       } 
/*      */     } 
/*      */   } private char flushWhitespace(Readtable rt) {
/*      */     try {
/*      */       while (true) {
/* 1531 */         int n = _readChar();
/* 1532 */         if (n < 0) {
/* 1533 */           return (char)Lisp.ierror(new EndOfFile(this));
/*      */         }
/* 1535 */         char c = (char)n;
/* 1536 */         if (!rt.isWhitespace(c))
/* 1537 */           return c; 
/*      */       } 
/* 1539 */     } catch (IOException e) {
/* 1540 */       Lisp.error(new StreamError(this, e));
/* 1541 */       return Character.MIN_VALUE;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readDelimitedList(char delimiter) {
/* 1548 */     LispThread thread = LispThread.currentThread();
/* 1549 */     LispObject result = Lisp.NIL;
/*      */     while (true) {
/* 1551 */       Readtable rt = (Readtable)Symbol.CURRENT_READTABLE.symbolValue(thread);
/* 1552 */       char c = flushWhitespace(rt);
/* 1553 */       if (c == delimiter) {
/*      */         break;
/*      */       }
/* 1556 */       LispObject obj = processChar(thread, c, rt);
/* 1557 */       if (obj != null)
/* 1558 */         result = new Cons(obj, result); 
/*      */     } 
/* 1560 */     if (Symbol.READ_SUPPRESS.symbolValue(thread) != Lisp.NIL) {
/* 1561 */       return Lisp.NIL;
/*      */     }
/* 1563 */     return result.nreverse();
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readLine(boolean eofError, LispObject eofValue) {
/* 1572 */     LispThread thread = LispThread.currentThread();
/* 1573 */     StringBuilder sb = new StringBuilder();
/*      */     try {
/*      */       while (true) {
/* 1576 */         int n = _readChar();
/* 1577 */         if (n < 0) {
/* 1578 */           if (sb.length() == 0) {
/* 1579 */             if (eofError)
/* 1580 */               return Lisp.error(new EndOfFile(this)); 
/* 1581 */             return thread.setValues(eofValue, Lisp.T);
/*      */           } 
/* 1583 */           return thread.setValues(new SimpleString(sb), Lisp.T);
/*      */         } 
/* 1585 */         if (n == 10) {
/* 1586 */           return thread.setValues(new SimpleString(sb), Lisp.NIL);
/*      */         }
/* 1588 */         sb.append((char)n);
/*      */       } 
/* 1590 */     } catch (IOException e) {
/* 1591 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readChar() {
/*      */     try {
/* 1599 */       int n = _readChar();
/* 1600 */       if (n < 0)
/* 1601 */         return Lisp.error(new EndOfFile(this)); 
/* 1602 */       return LispCharacter.getInstance((char)n);
/* 1603 */     } catch (IOException e) {
/* 1604 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readChar(boolean eofError, LispObject eofValue) {
/*      */     try {
/* 1613 */       int n = _readChar();
/* 1614 */       if (n < 0) {
/* 1615 */         if (eofError) {
/* 1616 */           return Lisp.error(new EndOfFile(this));
/*      */         }
/* 1618 */         return eofValue;
/*      */       } 
/* 1620 */       return LispCharacter.getInstance((char)n);
/* 1621 */     } catch (IOException e) {
/* 1622 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readCharNoHang(boolean eofError, LispObject eofValue) {
/*      */     try {
/* 1632 */       return _charReady() ? readChar(eofError, eofValue) : Lisp.NIL;
/* 1633 */     } catch (IOException e) {
/* 1634 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject unreadChar(LispCharacter c) {
/*      */     try {
/* 1642 */       _unreadChar(c.value);
/* 1643 */       return Lisp.NIL;
/* 1644 */     } catch (IOException e) {
/* 1645 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */   
/*      */   public LispObject finishOutput() {
/* 1650 */     _finishOutput();
/* 1651 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject clearInput() {
/* 1656 */     _clearInput();
/* 1657 */     return Lisp.NIL;
/*      */   }
/*      */   
/*      */   public LispObject getFilePosition() {
/* 1661 */     long pos = _getFilePosition();
/* 1662 */     return (pos >= 0L) ? Lisp.number(pos) : Lisp.NIL;
/*      */   }
/*      */   
/*      */   public LispObject setFilePosition(LispObject arg) {
/* 1666 */     return _setFilePosition(arg) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject close(LispObject abort) {
/* 1672 */     _close();
/* 1673 */     return Lisp.T;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject readByte(boolean eofError, LispObject eofValue) {
/* 1681 */     int n = _readByte();
/* 1682 */     if (n < 0) {
/* 1683 */       if (eofError) {
/* 1684 */         return Lisp.error(new EndOfFile(this));
/*      */       }
/* 1686 */       return eofValue;
/*      */     } 
/* 1688 */     return Fixnum.constants[n];
/*      */   }
/*      */   
/*      */   public LispObject terpri() {
/* 1692 */     _writeChar('\n');
/* 1693 */     return Lisp.NIL;
/*      */   }
/*      */   
/*      */   public LispObject freshLine() {
/* 1697 */     if (this.charPos == 0)
/* 1698 */       return Lisp.NIL; 
/* 1699 */     _writeChar('\n');
/* 1700 */     return Lisp.T;
/*      */   }
/*      */   
/*      */   public void print(char c) {
/* 1704 */     _writeChar(c);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void prin1(LispObject obj) {
/* 1710 */     LispThread thread = LispThread.currentThread();
/* 1711 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/* 1712 */     thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.T);
/*      */     try {
/* 1714 */       _writeString(obj.printObject());
/*      */     } finally {
/* 1716 */       thread.resetSpecialBindings(mark);
/*      */     } 
/*      */   }
/*      */   
/*      */   public LispObject listen() {
/* 1721 */     if (this.pastEnd)
/* 1722 */       return Lisp.NIL; 
/*      */     try {
/* 1724 */       if (isCharacterInputStream()) {
/* 1725 */         if (!_charReady()) {
/* 1726 */           return Lisp.NIL;
/*      */         }
/* 1728 */         int n = _readChar();
/* 1729 */         if (n < 0) {
/* 1730 */           return Lisp.NIL;
/*      */         }
/* 1732 */         _unreadChar(n);
/*      */         
/* 1734 */         return Lisp.T;
/* 1735 */       }  if (isInputStream()) {
/* 1736 */         if (!_byteReady()) {
/* 1737 */           return Lisp.NIL;
/*      */         }
/* 1739 */         return Lisp.T;
/*      */       } 
/* 1741 */       return Lisp.error(new StreamError(this, "Not an input stream"));
/* 1742 */     } catch (IOException e) {
/* 1743 */       return Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */   
/*      */   public LispObject fileLength() {
/* 1748 */     return Lisp.type_error(this, Symbol.FILE_STREAM);
/*      */   }
/*      */   
/*      */   public LispObject fileStringLength(LispObject arg) {
/* 1752 */     if (arg instanceof LispCharacter) {
/* 1753 */       if (Utilities.isPlatformWindows && 
/* 1754 */         ((LispCharacter)arg).value == '\n') {
/* 1755 */         return Fixnum.TWO;
/*      */       }
/* 1757 */       return Fixnum.ONE;
/*      */     } 
/* 1759 */     if (arg instanceof AbstractString) {
/* 1760 */       if (Utilities.isPlatformWindows) {
/* 1761 */         int fileStringLength = 0;
/* 1762 */         char[] chars = ((AbstractString)arg).getStringChars();
/* 1763 */         for (int i = chars.length; i-- > 0; ) {
/* 1764 */           if (chars[i] == '\n') {
/* 1765 */             fileStringLength += 2; continue;
/*      */           } 
/* 1767 */           fileStringLength++;
/*      */         } 
/* 1769 */         return Lisp.number(fileStringLength);
/*      */       } 
/*      */       
/* 1772 */       return Lisp.number(arg.length());
/*      */     } 
/* 1774 */     return Lisp.error(new TypeError(arg.princToString() + " is neither a string nor a character."));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   protected int _readChar() throws IOException {
/* 1783 */     if (this.reader == null) {
/* 1784 */       streamNotCharacterInputStream();
/*      */     }
/* 1786 */     int n = this.reader.read();
/*      */     
/* 1788 */     if (n < 0) {
/* 1789 */       this.pastEnd = true;
/* 1790 */       return -1;
/*      */     } 
/*      */     
/* 1793 */     this.offset++;
/* 1794 */     if (n == 13 && this.eolStyle == EolStyle.CRLF) {
/* 1795 */       n = _readChar();
/* 1796 */       if (n != 10) {
/* 1797 */         _unreadChar(n);
/* 1798 */         return 13;
/*      */       } 
/* 1800 */       return 10;
/*      */     } 
/*      */     
/* 1803 */     if (n == this.eolChar) {
/* 1804 */       this.lineNumber++;
/* 1805 */       return 10;
/*      */     } 
/*      */     
/* 1808 */     return n;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   protected void _unreadChar(int n) throws IOException {
/* 1816 */     if (this.reader == null) {
/* 1817 */       streamNotCharacterInputStream();
/*      */     }
/* 1819 */     this.offset--;
/* 1820 */     if (n == 10) {
/* 1821 */       n = this.eolChar;
/* 1822 */       this.lineNumber--;
/*      */     } 
/*      */     
/* 1825 */     this.reader.unread(n);
/* 1826 */     this.pastEnd = false;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   protected boolean _charReady() throws IOException {
/* 1835 */     if (this.reader == null)
/* 1836 */       streamNotCharacterInputStream(); 
/* 1837 */     return this.reader.ready();
/*      */   }
/*      */   
/*      */   protected boolean _byteReady() throws IOException {
/* 1841 */     if (this.in == null)
/* 1842 */       streamNotInputStream(); 
/* 1843 */     return (this.in.available() != 0);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _writeChar(char c) {
/*      */     try {
/* 1853 */       if (c == '\n') {
/* 1854 */         if (this.eolStyle == EolStyle.CRLF && this.lastChar != '\r') {
/* 1855 */           this.writer.write(13);
/*      */         }
/* 1857 */         this.writer.write(this.eolChar);
/* 1858 */         this.lastChar = this.eolChar;
/* 1859 */         this.writer.flush();
/* 1860 */         this.charPos = 0;
/*      */       } else {
/* 1862 */         this.writer.write(c);
/* 1863 */         this.lastChar = c;
/* 1864 */         this.charPos++;
/*      */       } 
/* 1866 */     } catch (NullPointerException e) {
/*      */       
/* 1868 */       streamNotCharacterOutputStream();
/* 1869 */     } catch (IOException e) {
/* 1870 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _writeChars(char[] chars, int start, int end) {
/*      */     try {
/* 1885 */       if (this.eolStyle != EolStyle.RAW) {
/* 1886 */         for (int j = start; j < end; j++)
/*      */         {
/*      */           
/* 1889 */           _writeChar(chars[j]);
/*      */         }
/*      */         return;
/*      */       } 
/* 1893 */       this.writer.write(chars, start, end - start);
/* 1894 */       if (start < end) {
/* 1895 */         this.lastChar = chars[end - 1];
/*      */       }
/* 1897 */       int index = -1;
/* 1898 */       for (int i = end; i-- > start;) {
/* 1899 */         if (chars[i] == '\n') {
/* 1900 */           index = i;
/*      */           break;
/*      */         } 
/*      */       } 
/* 1904 */       if (index < 0) {
/*      */         
/* 1906 */         this.charPos += end - start;
/*      */       } else {
/* 1908 */         this.charPos = end - index + 1;
/* 1909 */         this.writer.flush();
/*      */       } 
/* 1911 */     } catch (NullPointerException e) {
/* 1912 */       if (this.writer == null)
/* 1913 */       { streamNotCharacterOutputStream(); }
/*      */       else
/* 1915 */       { throw e; } 
/* 1916 */     } catch (IOException e) {
/* 1917 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _writeString(String s) {
/*      */     try {
/* 1928 */       _writeChars(s.toCharArray(), 0, s.length());
/* 1929 */     } catch (NullPointerException e) {
/* 1930 */       if (this.writer == null) {
/* 1931 */         streamNotCharacterOutputStream();
/*      */       } else {
/* 1933 */         throw e;
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _writeLine(String s) {
/*      */     try {
/* 1944 */       _writeString(s);
/* 1945 */       _writeChar('\n');
/* 1946 */     } catch (NullPointerException e) {
/*      */       
/* 1948 */       streamNotCharacterOutputStream();
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public int _readByte() {
/*      */     try {
/* 1959 */       int n = this.in.read();
/* 1960 */       if (n < 0) {
/* 1961 */         this.pastEnd = true;
/*      */       }
/* 1963 */       return n;
/* 1964 */     } catch (IOException e) {
/* 1965 */       return Lisp.ierror(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _writeByte(int n) {
/*      */     try {
/* 1976 */       this.out.write(n);
/* 1977 */     } catch (NullPointerException e) {
/*      */       
/* 1979 */       streamNotBinaryOutputStream();
/* 1980 */     } catch (IOException e) {
/* 1981 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _finishOutput() {
/*      */     try {
/* 1990 */       if (this.writer != null)
/* 1991 */         this.writer.flush(); 
/* 1992 */       if (this.out != null)
/* 1993 */         this.out.flush(); 
/* 1994 */     } catch (IOException e) {
/* 1995 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _clearInput() {
/* 2004 */     if (this.reader != null) {
/* 2005 */       int c = 0;
/*      */       try {
/* 2007 */         while (_charReady() && c >= 0)
/* 2008 */           c = _readChar(); 
/* 2009 */       } catch (IOException e) {
/* 2010 */         Lisp.error(new StreamError(this, e));
/*      */       } 
/* 2012 */     } else if (this.in != null) {
/*      */       try {
/* 2014 */         int n = 0;
/* 2015 */         while (this.in.available() > 0) {
/* 2016 */           n = this.in.read();
/*      */         }
/* 2018 */         if (n < 0)
/* 2019 */           this.pastEnd = true; 
/* 2020 */       } catch (IOException e) {
/* 2021 */         Lisp.error(new StreamError(this, e));
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   protected long _getFilePosition() {
/* 2033 */     return -1L;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   protected boolean _setFilePosition(LispObject arg) {
/* 2042 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void _close() {
/*      */     try {
/* 2050 */       if (this.reader != null)
/* 2051 */         this.reader.close(); 
/* 2052 */       if (this.in != null)
/* 2053 */         this.in.close(); 
/* 2054 */       if (this.writer != null)
/* 2055 */         this.writer.close(); 
/* 2056 */       if (this.out != null)
/* 2057 */         this.out.close(); 
/* 2058 */       setOpen(false);
/* 2059 */     } catch (IOException e) {
/* 2060 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */   
/*      */   public void printStackTrace(Throwable t) {
/* 2065 */     StringWriter sw = new StringWriter();
/* 2066 */     PrintWriter pw = new PrintWriter(sw);
/* 2067 */     t.printStackTrace(pw);
/*      */     try {
/* 2069 */       this.writer.write(sw.toString());
/* 2070 */       this.writer.write(10);
/* 2071 */       this.lastChar = '\n';
/* 2072 */       this.writer.flush();
/* 2073 */       this.charPos = 0;
/* 2074 */     } catch (IOException e) {
/* 2075 */       Lisp.error(new StreamError(this, e));
/*      */     } 
/*      */   }
/*      */   
/*      */   protected LispObject streamNotInputStream() {
/* 2080 */     return Lisp.error(new StreamError(this, princToString() + " is not an input stream."));
/*      */   }
/*      */   
/*      */   protected LispObject streamNotCharacterInputStream() {
/* 2084 */     return Lisp.error(new StreamError(this, princToString() + " is not a character input stream."));
/*      */   }
/*      */   
/*      */   protected LispObject streamNotOutputStream() {
/* 2088 */     return Lisp.error(new StreamError(this, princToString() + " is not an output stream."));
/*      */   }
/*      */   
/*      */   protected LispObject streamNotBinaryOutputStream() {
/* 2092 */     return Lisp.error(new StreamError(this, princToString() + " is not a binary output stream."));
/*      */   }
/*      */   
/*      */   protected LispObject streamNotCharacterOutputStream() {
/* 2096 */     return Lisp.error(new StreamError(this, princToString() + " is not a character output stream."));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/* 2101 */   private static final Primitive _WRITE_CHAR = new Primitive("%stream-write-char", Lisp.PACKAGE_SYS, true, "character output-stream")
/*      */     {
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second)
/*      */       {
/* 2108 */         Lisp.checkStream(second)._writeChar(LispCharacter.getValue(first));
/* 2109 */         return first;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2114 */   private static final Primitive _STREAM_WRITE_CHAR = new Primitive("%write-char", Lisp.PACKAGE_SYS, false, "character output-stream")
/*      */     {
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second)
/*      */       {
/* 2121 */         char c = LispCharacter.getValue(first);
/* 2122 */         if (second == Lisp.T) {
/* 2123 */           second = Symbol.TERMINAL_IO.symbolValue();
/* 2124 */         } else if (second == Lisp.NIL) {
/* 2125 */           second = Symbol.STANDARD_OUTPUT.symbolValue();
/* 2126 */         }  Stream stream = Lisp.checkStream(second);
/* 2127 */         stream._writeChar(c);
/* 2128 */         return first;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2133 */   private static final Primitive _WRITE_STRING = new Primitive("%write-string", Lisp.PACKAGE_SYS, false, "string output-stream start end")
/*      */     {
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth)
/*      */       {
/*      */         int end;
/*      */ 
/*      */ 
/*      */         
/* 2141 */         AbstractString s = Lisp.checkString(first);
/* 2142 */         char[] chars = s.chars();
/* 2143 */         Stream out = Lisp.outSynonymOf(second);
/* 2144 */         int start = Fixnum.getValue(third);
/*      */         
/* 2146 */         if (fourth == Lisp.NIL) {
/* 2147 */           end = chars.length;
/*      */         } else {
/* 2149 */           end = Fixnum.getValue(fourth);
/*      */         } 
/* 2151 */         Lisp.checkBounds(start, end, chars.length);
/* 2152 */         out._writeChars(chars, start, end);
/* 2153 */         return first;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2158 */   private static final Primitive _FINISH_OUTPUT = new Primitive("%finish-output", Lisp.PACKAGE_SYS, false, "output-stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2162 */         return Stream.finishOutput(arg);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2167 */   private static final Primitive _FORCE_OUTPUT = new Primitive("%force-output", Lisp.PACKAGE_SYS, false, "output-stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2171 */         return Stream.finishOutput(arg);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject finishOutput(LispObject arg) {
/*      */     LispObject out;
/* 2179 */     if (arg == Lisp.T) {
/* 2180 */       out = Symbol.TERMINAL_IO.symbolValue();
/* 2181 */     } else if (arg == Lisp.NIL) {
/* 2182 */       out = Symbol.STANDARD_OUTPUT.symbolValue();
/*      */     } else {
/* 2184 */       out = arg;
/* 2185 */     }  return Lisp.checkStream(out).finishOutput();
/*      */   }
/*      */ 
/*      */   
/* 2189 */   private static final Primitive CLEAR_INPUT = new Primitive(Symbol.CLEAR_INPUT, "&optional input-stream")
/*      */     {
/*      */       public LispObject execute(LispObject[] args) {
/*      */         Stream in;
/* 2193 */         if (args.length > 1) {
/* 2194 */           return Lisp.error(new WrongNumberOfArgumentsException(this, -1, 1));
/*      */         }
/* 2196 */         if (args.length == 0) {
/* 2197 */           in = Lisp.checkCharacterInputStream(Symbol.STANDARD_INPUT.symbolValue());
/*      */         } else {
/* 2199 */           in = Lisp.inSynonymOf(args[0]);
/* 2200 */         }  in.clearInput();
/* 2201 */         return Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2208 */   private static final Primitive _CLEAR_OUTPUT = new Primitive("%clear-output", Lisp.PACKAGE_SYS, false, "output-stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2212 */         if (arg == Lisp.T)
/* 2213 */           return Lisp.NIL; 
/* 2214 */         if (arg == Lisp.NIL)
/* 2215 */           return Lisp.NIL; 
/* 2216 */         if (arg instanceof Stream)
/* 2217 */           return Lisp.NIL; 
/* 2218 */         return Lisp.type_error(arg, Symbol.STREAM);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2223 */   private static final Primitive CLOSE = new Primitive(Symbol.CLOSE, "stream &key abort")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2227 */         return Lisp.checkStream(arg).close(Lisp.NIL);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2235 */         Stream stream = Lisp.checkStream(first);
/* 2236 */         if (second == Keyword.ABORT)
/* 2237 */           return stream.close(third); 
/* 2238 */         return Lisp.program_error("Unrecognized keyword argument " + second
/* 2239 */             .princToString() + ".");
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2244 */   private static final Primitive OUT_SYNONYM_OF = new Primitive("out-synonym-of", Lisp.PACKAGE_SYS, true, "stream-designator")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2248 */         if (arg instanceof Stream)
/* 2249 */           return arg; 
/* 2250 */         if (arg == Lisp.T)
/* 2251 */           return Symbol.TERMINAL_IO.symbolValue(); 
/* 2252 */         if (arg == Lisp.NIL)
/* 2253 */           return Symbol.STANDARD_OUTPUT.symbolValue(); 
/* 2254 */         return arg;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2260 */   private static final Primitive WRITE_8_BITS = new Primitive("write-8-bits", Lisp.PACKAGE_SYS, true, "byte stream")
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second)
/*      */       {
/* 2266 */         int n = Fixnum.getValue(first);
/* 2267 */         if (n < 0 || n > 255)
/* 2268 */           return Lisp.type_error(first, Lisp.UNSIGNED_BYTE_8); 
/* 2269 */         Lisp.checkStream(second)._writeByte(n);
/* 2270 */         return Lisp.NIL;
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2276 */   private static final Primitive READ_8_BITS = new Primitive("read-8-bits", Lisp.PACKAGE_SYS, true, "stream &optional eof-error-p eof-value")
/*      */     {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third)
/*      */       {
/* 2284 */         return Lisp.checkBinaryInputStream(first).readByte((second != Lisp.NIL), third);
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject[] args) {
/* 2290 */         int length = args.length;
/* 2291 */         if (length < 1 || length > 3)
/* 2292 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 3)); 
/* 2293 */         Stream in = Lisp.checkBinaryInputStream(args[0]);
/* 2294 */         boolean eofError = (length > 1) ? ((args[1] != Lisp.NIL)) : true;
/* 2295 */         LispObject eofValue = (length > 2) ? args[2] : Lisp.NIL;
/* 2296 */         return in.readByte(eofError, eofValue);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2302 */   private static final Primitive READ_LINE = new Primitive(Symbol.READ_LINE, "&optional input-stream eof-error-p eof-value recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute()
/*      */       {
/* 2307 */         LispObject obj = Symbol.STANDARD_INPUT.symbolValue();
/* 2308 */         Stream stream = Lisp.checkStream(obj);
/* 2309 */         return stream.readLine(true, Lisp.NIL);
/*      */       }
/*      */       
/*      */       public LispObject execute(LispObject arg) {
/* 2313 */         if (arg == Lisp.T) {
/* 2314 */           arg = Symbol.TERMINAL_IO.symbolValue();
/* 2315 */         } else if (arg == Lisp.NIL) {
/* 2316 */           arg = Symbol.STANDARD_INPUT.symbolValue();
/* 2317 */         }  Stream stream = Lisp.checkStream(arg);
/* 2318 */         return stream.readLine(true, Lisp.NIL);
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second) {
/* 2324 */         if (first == Lisp.T) {
/* 2325 */           first = Symbol.TERMINAL_IO.symbolValue();
/* 2326 */         } else if (first == Lisp.NIL) {
/* 2327 */           first = Symbol.STANDARD_INPUT.symbolValue();
/* 2328 */         }  Stream stream = Lisp.checkStream(first);
/* 2329 */         return stream.readLine((second != Lisp.NIL), Lisp.NIL);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2336 */         if (first == Lisp.T) {
/* 2337 */           first = Symbol.TERMINAL_IO.symbolValue();
/* 2338 */         } else if (first == Lisp.NIL) {
/* 2339 */           first = Symbol.STANDARD_INPUT.symbolValue();
/* 2340 */         }  Stream stream = Lisp.checkStream(first);
/* 2341 */         return stream.readLine((second != Lisp.NIL), third);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 2349 */         if (first == Lisp.T) {
/* 2350 */           first = Symbol.TERMINAL_IO.symbolValue();
/* 2351 */         } else if (first == Lisp.NIL) {
/* 2352 */           first = Symbol.STANDARD_INPUT.symbolValue();
/* 2353 */         }  Stream stream = Lisp.checkStream(first);
/* 2354 */         return stream.readLine((second != Lisp.NIL), third);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2360 */   private static final Primitive _READ_FROM_STRING = new Primitive("%read-from-string", Lisp.PACKAGE_SYS, false)
/*      */     {
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth)
/*      */       {
/*      */         int startIndex, endIndex;
/*      */         
/*      */         LispObject result;
/*      */         
/* 2368 */         String s = first.getStringValue();
/* 2369 */         boolean eofError = (second != Lisp.NIL);
/* 2370 */         boolean preserveWhitespace = (sixth != Lisp.NIL);
/*      */         
/* 2372 */         if (fourth != Lisp.NIL) {
/* 2373 */           startIndex = Fixnum.getValue(fourth);
/*      */         } else {
/* 2375 */           startIndex = 0;
/*      */         } 
/* 2377 */         if (fifth != Lisp.NIL) {
/* 2378 */           endIndex = Fixnum.getValue(fifth);
/*      */         } else {
/* 2380 */           endIndex = s.length();
/* 2381 */         }  StringInputStream in = new StringInputStream(s, startIndex, endIndex);
/*      */         
/* 2383 */         LispThread thread = LispThread.currentThread();
/*      */         
/* 2385 */         if (preserveWhitespace) {
/* 2386 */           result = in.readPreservingWhitespace(eofError, third, false, thread, Stream.currentReadtable);
/*      */         } else {
/*      */           
/* 2389 */           result = in.read(eofError, third, false, thread, Stream.currentReadtable);
/* 2390 */         }  return thread.setValues(result, Fixnum.getInstance(in.getOffset()));
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2395 */   private static final Primitive READ = new Primitive(Symbol.READ, "&optional input-stream eof-error-p eof-value recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute()
/*      */       {
/* 2400 */         LispThread thread = LispThread.currentThread();
/* 2401 */         LispObject obj = Symbol.STANDARD_INPUT.symbolValue(thread);
/* 2402 */         Stream stream = Lisp.checkStream(obj);
/* 2403 */         return stream.read(true, Lisp.NIL, false, thread, Stream.currentReadtable);
/*      */       }
/*      */       
/*      */       public LispObject execute(LispObject arg) {
/* 2407 */         LispThread thread = LispThread.currentThread();
/* 2408 */         if (arg == Lisp.T) {
/* 2409 */           arg = Symbol.TERMINAL_IO.symbolValue(thread);
/* 2410 */         } else if (arg == Lisp.NIL) {
/* 2411 */           arg = Symbol.STANDARD_INPUT.symbolValue(thread);
/* 2412 */         }  Stream stream = Lisp.checkStream(arg);
/* 2413 */         return stream.read(true, Lisp.NIL, false, thread, Stream.currentReadtable);
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second) {
/* 2419 */         LispThread thread = LispThread.currentThread();
/* 2420 */         if (first == Lisp.T) {
/* 2421 */           first = Symbol.TERMINAL_IO.symbolValue(thread);
/* 2422 */         } else if (first == Lisp.NIL) {
/* 2423 */           first = Symbol.STANDARD_INPUT.symbolValue(thread);
/* 2424 */         }  Stream stream = Lisp.checkStream(first);
/* 2425 */         return stream.read((second != Lisp.NIL), Lisp.NIL, false, thread, Stream.currentReadtable);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2432 */         LispThread thread = LispThread.currentThread();
/* 2433 */         if (first == Lisp.T) {
/* 2434 */           first = Symbol.TERMINAL_IO.symbolValue(thread);
/* 2435 */         } else if (first == Lisp.NIL) {
/* 2436 */           first = Symbol.STANDARD_INPUT.symbolValue(thread);
/* 2437 */         }  Stream stream = Lisp.checkStream(first);
/* 2438 */         return stream.read((second != Lisp.NIL), third, false, thread, Stream.currentReadtable);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 2445 */         LispThread thread = LispThread.currentThread();
/* 2446 */         if (first == Lisp.T) {
/* 2447 */           first = Symbol.TERMINAL_IO.symbolValue(thread);
/* 2448 */         } else if (first == Lisp.NIL) {
/* 2449 */           first = Symbol.STANDARD_INPUT.symbolValue(thread);
/* 2450 */         }  Stream stream = Lisp.checkStream(first);
/* 2451 */         return stream.read((second != Lisp.NIL), third, (fourth != Lisp.NIL), thread, Stream.currentReadtable);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2458 */   private static final Primitive READ_PRESERVING_WHITESPACE = new Primitive(Symbol.READ_PRESERVING_WHITESPACE, "&optional input-stream eof-error-p eof-value recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute(LispObject[] args)
/*      */       {
/* 2463 */         int length = args.length;
/* 2464 */         if (length > 4) {
/* 2465 */           return Lisp.error(new WrongNumberOfArgumentsException(this, -1, 4));
/*      */         }
/* 2467 */         Stream stream = (length > 0) ? Lisp.inSynonymOf(args[0]) : Lisp.getStandardInput();
/* 2468 */         boolean eofError = (length > 1) ? ((args[1] != Lisp.NIL)) : true;
/* 2469 */         LispObject eofValue = (length > 2) ? args[2] : Lisp.NIL;
/* 2470 */         boolean recursive = (length > 3) ? ((args[3] != Lisp.NIL)) : false;
/* 2471 */         return stream.readPreservingWhitespace(eofError, eofValue, recursive, 
/*      */             
/* 2473 */             LispThread.currentThread(), Stream.currentReadtable);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2480 */   private static final Primitive READ_CHAR = new Primitive(Symbol.READ_CHAR, "&optional input-stream eof-error-p eof-value recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute()
/*      */       {
/* 2485 */         return Lisp.checkCharacterInputStream(Symbol.STANDARD_INPUT.symbolValue()).readChar();
/*      */       }
/*      */       
/*      */       public LispObject execute(LispObject arg) {
/* 2489 */         return Lisp.inSynonymOf(arg).readChar();
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second) {
/* 2495 */         return Lisp.inSynonymOf(first).readChar((second != Lisp.NIL), Lisp.NIL);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2502 */         return Lisp.inSynonymOf(first).readChar((second != Lisp.NIL), third);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 2509 */         return Lisp.inSynonymOf(first).readChar((second != Lisp.NIL), third);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2515 */   private static final Primitive READ_CHAR_NO_HANG = new Primitive("read-char-no-hang", "&optional input-stream eof-error-p eof-value recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute(LispObject[] args)
/*      */       {
/* 2520 */         int length = args.length;
/* 2521 */         if (length > 4) {
/* 2522 */           Lisp.error(new WrongNumberOfArgumentsException(this, -1, 4));
/*      */         }
/* 2524 */         Stream stream = (length > 0) ? Lisp.inSynonymOf(args[0]) : Lisp.getStandardInput();
/* 2525 */         boolean eofError = (length > 1) ? ((args[1] != Lisp.NIL)) : true;
/* 2526 */         LispObject eofValue = (length > 2) ? args[2] : Lisp.NIL;
/*      */ 
/*      */         
/* 2529 */         return stream.readCharNoHang(eofError, eofValue);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2534 */   private static final Primitive READ_DELIMITED_LIST = new Primitive("read-delimited-list", "char &optional input-stream recursive-p")
/*      */     {
/*      */       
/*      */       public LispObject execute(LispObject[] args)
/*      */       {
/* 2539 */         int length = args.length;
/* 2540 */         if (length < 1 || length > 3)
/* 2541 */           Lisp.error(new WrongNumberOfArgumentsException(this, 1, 3)); 
/* 2542 */         char c = LispCharacter.getValue(args[0]);
/*      */         
/* 2544 */         Stream stream = (length > 1) ? Lisp.inSynonymOf(args[1]) : Lisp.getStandardInput();
/* 2545 */         return stream.readDelimitedList(c);
/*      */       }
/*      */     };
/*      */ 
/*      */ 
/*      */   
/* 2551 */   private static final Primitive UNREAD_CHAR = new Primitive(Symbol.UNREAD_CHAR, "character &optional input-stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2555 */         return Lisp.getStandardInput().unreadChar(Lisp.checkCharacter(arg));
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second) {
/* 2561 */         Stream stream = Lisp.inSynonymOf(second);
/* 2562 */         return stream.unreadChar(Lisp.checkCharacter(first));
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2567 */   private static final Primitive WRITE_VECTOR_UNSIGNED_BYTE_8 = new Primitive("write-vector-unsigned-byte-8", Lisp.PACKAGE_SYS, true, "vector stream start end")
/*      */     {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth)
/*      */       {
/* 2575 */         AbstractVector v = Lisp.checkVector(first);
/* 2576 */         Stream stream = Lisp.checkStream(second);
/* 2577 */         int start = Fixnum.getValue(third);
/* 2578 */         int end = Fixnum.getValue(fourth);
/* 2579 */         for (int i = start; i < end; i++)
/* 2580 */           stream._writeByte(v.aref(i)); 
/* 2581 */         return v;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2586 */   private static final Primitive READ_VECTOR_UNSIGNED_BYTE_8 = new Primitive("read-vector-unsigned-byte-8", Lisp.PACKAGE_SYS, true, "vector stream start end")
/*      */     {
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth)
/*      */       {
/* 2594 */         AbstractVector v = Lisp.checkVector(first);
/* 2595 */         Stream stream = Lisp.checkBinaryInputStream(second);
/* 2596 */         int start = Fixnum.getValue(third);
/* 2597 */         int end = Fixnum.getValue(fourth);
/* 2598 */         if (!v.getElementType().equal(Lisp.UNSIGNED_BYTE_8)) {
/* 2599 */           return Lisp.type_error(first, Lisp.list(Symbol.VECTOR, new LispObject[] { Lisp.UNSIGNED_BYTE_8 }));
/*      */         }
/* 2601 */         for (int i = start; i < end; i++) {
/* 2602 */           int n = stream._readByte();
/* 2603 */           if (n < 0)
/*      */           {
/* 2605 */             return Fixnum.getInstance(i);
/*      */           }
/* 2607 */           v.aset(i, n);
/*      */         } 
/* 2609 */         return fourth;
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2614 */   private static final Primitive FILE_POSITION = new Primitive("file-position", "stream &optional position-spec")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2618 */         return Lisp.checkStream(arg).getFilePosition();
/*      */       }
/*      */ 
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second) {
/* 2624 */         return Lisp.checkStream(first).setFilePosition(second);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2629 */   private static final Primitive STREAM_LINE_NUMBER = new Primitive("stream-line-number", Lisp.PACKAGE_SYS, false, "stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2633 */         return Fixnum.getInstance(Lisp.checkStream(arg).getLineNumber() + 1);
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2638 */   private static final Primitive STREAM_OFFSET = new Primitive("stream-offset", Lisp.PACKAGE_SYS, false, "stream")
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2642 */         return Lisp.number(Lisp.checkStream(arg).getOffset());
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2647 */   private static final Primitive STREAM_CHARPOS = new Primitive("stream-charpos", Lisp.PACKAGE_SYS, false)
/*      */     {
/*      */       public LispObject execute(LispObject arg)
/*      */       {
/* 2651 */         Stream stream = Lisp.checkCharacterOutputStream(arg);
/* 2652 */         return Fixnum.getInstance(stream.getCharPos());
/*      */       }
/*      */     };
/*      */ 
/*      */   
/* 2657 */   private static final Primitive STREAM_SET_CHARPOS = new Primitive("stream-%set-charpos", Lisp.PACKAGE_SYS, false)
/*      */     {
/*      */ 
/*      */       
/*      */       public LispObject execute(LispObject first, LispObject second)
/*      */       {
/* 2663 */         Stream stream = Lisp.checkCharacterOutputStream(first);
/* 2664 */         stream.setCharPos(Fixnum.getValue(second));
/* 2665 */         return second;
/*      */       }
/*      */     };
/*      */   
/*      */   public InputStream getWrappedInputStream() {
/* 2670 */     return this.in;
/*      */   }
/*      */   
/*      */   public OutputStream getWrappedOutputStream() {
/* 2674 */     return this.out;
/*      */   }
/*      */   
/*      */   public Writer getWrappedWriter() {
/* 2678 */     return this.writer;
/*      */   }
/*      */   
/*      */   public PushbackReader getWrappedReader() {
/* 2682 */     return this.reader;
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Stream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */