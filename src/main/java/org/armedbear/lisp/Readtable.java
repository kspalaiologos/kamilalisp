/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.Iterator;
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
/*     */ public class Readtable
/*     */   extends LispObject
/*     */ {
/*     */   public static final byte SYNTAX_TYPE_CONSTITUENT = 0;
/*     */   public static final byte SYNTAX_TYPE_WHITESPACE = 1;
/*     */   public static final byte SYNTAX_TYPE_TERMINATING_MACRO = 2;
/*     */   public static final byte SYNTAX_TYPE_NON_TERMINATING_MACRO = 3;
/*     */   public static final byte SYNTAX_TYPE_SINGLE_ESCAPE = 4;
/*     */   public static final byte SYNTAX_TYPE_MULTIPLE_ESCAPE = 5;
/*     */   protected final CharHashMap<Byte> syntax;
/*     */   protected final CharHashMap<LispObject> readerMacroFunctions;
/*     */   protected final CharHashMap<DispatchTable> dispatchTables;
/*     */   protected LispObject readtableCase;
/*     */   
/*     */   public Readtable() {
/*  48 */     this.syntax = new CharHashMap<>(Byte.class, Byte.valueOf((byte)0));
/*  49 */     this.readerMacroFunctions = new CharHashMap<>(LispObject.class, null);
/*  50 */     this.dispatchTables = new CharHashMap<>(DispatchTable.class, null);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*  56 */     initialize();
/*     */   }
/*     */ 
/*     */   
/*     */   protected void initialize() {
/*  61 */     Byte[] syntax = (Byte[])this.syntax.constants;
/*  62 */     syntax[9] = Byte.valueOf((byte)1);
/*  63 */     syntax[10] = Byte.valueOf((byte)1);
/*  64 */     syntax[12] = Byte.valueOf((byte)1);
/*  65 */     syntax[13] = Byte.valueOf((byte)1);
/*  66 */     syntax[32] = Byte.valueOf((byte)1);
/*     */     
/*  68 */     syntax[34] = Byte.valueOf((byte)2);
/*  69 */     syntax[39] = Byte.valueOf((byte)2);
/*  70 */     syntax[40] = Byte.valueOf((byte)2);
/*  71 */     syntax[41] = Byte.valueOf((byte)2);
/*  72 */     syntax[44] = Byte.valueOf((byte)2);
/*  73 */     syntax[59] = Byte.valueOf((byte)2);
/*  74 */     syntax[96] = Byte.valueOf((byte)2);
/*     */     
/*  76 */     syntax[35] = Byte.valueOf((byte)3);
/*     */     
/*  78 */     syntax[92] = Byte.valueOf((byte)4);
/*  79 */     syntax[124] = Byte.valueOf((byte)5);
/*     */     
/*  81 */     LispObject[] readerMacroFunctions = (LispObject[])this.readerMacroFunctions.constants;
/*  82 */     readerMacroFunctions[59] = LispReader.READ_COMMENT;
/*  83 */     readerMacroFunctions[34] = LispReader.READ_STRING;
/*  84 */     readerMacroFunctions[40] = LispReader.READ_LIST;
/*  85 */     readerMacroFunctions[41] = LispReader.READ_RIGHT_PAREN;
/*  86 */     readerMacroFunctions[39] = LispReader.READ_QUOTE;
/*  87 */     readerMacroFunctions[35] = LispReader.READ_DISPATCH_CHAR;
/*     */ 
/*     */     
/*  90 */     readerMacroFunctions[96] = Symbol.BACKQUOTE_MACRO;
/*  91 */     readerMacroFunctions[44] = Symbol.COMMA_MACRO;
/*     */     
/*  93 */     DispatchTable dt = new DispatchTable();
/*  94 */     LispObject[] dtfunctions = (LispObject[])dt.functions.constants;
/*  95 */     dtfunctions[40] = LispReader.SHARP_LEFT_PAREN;
/*  96 */     dtfunctions[42] = LispReader.SHARP_STAR;
/*  97 */     dtfunctions[46] = LispReader.SHARP_DOT;
/*  98 */     dtfunctions[58] = LispReader.SHARP_COLON;
/*  99 */     dtfunctions[65] = LispReader.SHARP_A;
/* 100 */     dtfunctions[66] = LispReader.SHARP_B;
/* 101 */     dtfunctions[67] = LispReader.SHARP_C;
/* 102 */     dtfunctions[79] = LispReader.SHARP_O;
/* 103 */     dtfunctions[80] = LispReader.SHARP_P;
/* 104 */     dtfunctions[82] = LispReader.SHARP_R;
/* 105 */     dtfunctions[83] = LispReader.SHARP_S;
/* 106 */     dtfunctions[88] = LispReader.SHARP_X;
/* 107 */     dtfunctions[39] = LispReader.SHARP_QUOTE;
/* 108 */     dtfunctions[92] = LispReader.SHARP_BACKSLASH;
/* 109 */     dtfunctions[124] = LispReader.SHARP_VERTICAL_BAR;
/* 110 */     dtfunctions[41] = LispReader.SHARP_ILLEGAL;
/* 111 */     dtfunctions[60] = LispReader.SHARP_ILLEGAL;
/* 112 */     dtfunctions[32] = LispReader.SHARP_ILLEGAL;
/* 113 */     dtfunctions[8] = LispReader.SHARP_ILLEGAL;
/* 114 */     dtfunctions[9] = LispReader.SHARP_ILLEGAL;
/* 115 */     dtfunctions[10] = LispReader.SHARP_ILLEGAL;
/* 116 */     dtfunctions[12] = LispReader.SHARP_ILLEGAL;
/* 117 */     dtfunctions[13] = LispReader.SHARP_ILLEGAL;
/*     */     
/* 119 */     ((DispatchTable[])this.dispatchTables.constants)[35] = dt;
/*     */     
/* 121 */     this.readtableCase = Keyword.UPCASE;
/*     */   } public Readtable(LispObject obj) {
/*     */     Readtable rt;
/*     */     this.syntax = new CharHashMap<>(Byte.class, Byte.valueOf((byte)0));
/*     */     this.readerMacroFunctions = new CharHashMap<>(LispObject.class, null);
/*     */     this.dispatchTables = new CharHashMap<>(DispatchTable.class, null);
/* 127 */     if (obj == Lisp.NIL) {
/* 128 */       rt = Lisp.checkReadtable(Lisp.STANDARD_READTABLE.symbolValue());
/*     */     } else {
/* 130 */       rt = Lisp.checkReadtable(obj);
/* 131 */     }  synchronized (rt) {
/*     */       
/* 133 */       copyReadtable(rt, this);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   static void copyReadtable(Readtable from, Readtable to) {
/* 140 */     Iterator<Character> charIterator = from.syntax.getCharIterator();
/* 141 */     while (charIterator.hasNext()) {
/* 142 */       char c = ((Character)charIterator.next()).charValue();
/* 143 */       Byte dt = from.syntax.get(c);
/* 144 */       if (dt != null) {
/* 145 */         to.syntax.put(c, dt); continue;
/*     */       } 
/* 147 */       to.syntax.put(c, null);
/*     */     } 
/*     */     
/* 150 */     charIterator = from.readerMacroFunctions.getCharIterator();
/* 151 */     while (charIterator.hasNext()) {
/* 152 */       char c = ((Character)charIterator.next()).charValue();
/* 153 */       LispObject dt = from.readerMacroFunctions.get(c);
/* 154 */       if (dt != null) {
/* 155 */         to.readerMacroFunctions.put(c, dt); continue;
/*     */       } 
/* 157 */       to.readerMacroFunctions.put(c, null);
/*     */     } 
/*     */     
/* 160 */     charIterator = from.dispatchTables.getCharIterator();
/* 161 */     while (charIterator.hasNext()) {
/* 162 */       char c = ((Character)charIterator.next()).charValue();
/* 163 */       DispatchTable dt = from.dispatchTables.get(c);
/* 164 */       if (dt != null) {
/* 165 */         to.dispatchTables.put(c, new DispatchTable(dt)); continue;
/*     */       } 
/* 167 */       to.dispatchTables.put(c, null);
/*     */     } 
/*     */     
/* 170 */     to.readtableCase = from.readtableCase;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject typeOf() {
/* 176 */     return Symbol.READTABLE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject classOf() {
/* 182 */     return BuiltInClass.READTABLE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject typep(LispObject type) {
/* 188 */     if (type == Symbol.READTABLE)
/* 189 */       return Lisp.T; 
/* 190 */     if (type == BuiltInClass.READTABLE)
/* 191 */       return Lisp.T; 
/* 192 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getReadtableCase() {
/* 197 */     return this.readtableCase;
/*     */   }
/*     */ 
/*     */   
/*     */   public final boolean isWhitespace(char c) {
/* 202 */     return (getSyntaxType(c) == 1);
/*     */   }
/*     */ 
/*     */   
/*     */   public final byte getSyntaxType(char c) {
/* 207 */     return ((Byte)this.syntax.get(c)).byteValue();
/*     */   }
/*     */ 
/*     */   
/*     */   public final boolean isInvalid(char c) {
/* 212 */     switch (c) {
/*     */       
/*     */       case '\b':
/*     */       case '\t':
/*     */       case '\n':
/*     */       case '\f':
/*     */       case '\r':
/*     */       case ' ':
/*     */       case '':
/* 221 */         return true;
/*     */     } 
/* 223 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final void checkInvalid(char c, Stream stream) {
/* 231 */     if (isInvalid(c)) {
/*     */       
/* 233 */       String name = LispCharacter.charToName(c);
/* 234 */       StringBuilder sb = new StringBuilder("Invalid character");
/* 235 */       if (name != null) {
/*     */         
/* 237 */         sb.append(" #\\");
/* 238 */         sb.append(name);
/*     */       } 
/* 240 */       Lisp.error(new ReaderError(sb.toString(), stream));
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject getReaderMacroFunction(char c) {
/* 246 */     return this.readerMacroFunctions.get(c);
/*     */   }
/*     */ 
/*     */   
/*     */   final LispObject getMacroCharacter(char c) {
/* 251 */     LispObject non_terminating_p, function = getReaderMacroFunction(c);
/*     */     
/* 253 */     if (function != null) {
/*     */       
/* 255 */       if (((Byte)this.syntax.get(c)).byteValue() == 3) {
/* 256 */         non_terminating_p = Lisp.T;
/*     */       } else {
/* 258 */         non_terminating_p = Lisp.NIL;
/*     */       } 
/*     */     } else {
/*     */       
/* 262 */       function = Lisp.NIL;
/* 263 */       non_terminating_p = Lisp.NIL;
/*     */     } 
/* 265 */     return LispThread.currentThread().setValues(function, non_terminating_p);
/*     */   }
/*     */ 
/*     */   
/*     */   final void makeDispatchMacroCharacter(char dispChar, LispObject non_terminating_p) {
/*     */     byte syntaxType;
/* 271 */     if (non_terminating_p != Lisp.NIL) {
/* 272 */       syntaxType = 3;
/*     */     } else {
/* 274 */       syntaxType = 2;
/*     */     } 
/* 276 */     this.syntax.put(dispChar, Byte.valueOf(syntaxType));
/* 277 */     this.readerMacroFunctions.put(dispChar, LispReader.READ_DISPATCH_CHAR);
/* 278 */     this.dispatchTables.put(dispChar, new DispatchTable());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getDispatchMacroCharacter(char dispChar, char subChar) {
/* 284 */     DispatchTable dispatchTable = this.dispatchTables.get(dispChar);
/* 285 */     if (dispatchTable == null) {
/*     */       
/* 287 */       LispCharacter c = LispCharacter.getInstance(dispChar);
/* 288 */       return Lisp.error(new LispError(c.princToString() + " is not a dispatch character."));
/*     */     } 
/*     */ 
/*     */     
/* 292 */     LispObject function = dispatchTable.functions.get(LispCharacter.toUpperCase(subChar));
/* 293 */     return (function != null) ? function : Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setDispatchMacroCharacter(char dispChar, char subChar, LispObject function) {
/* 300 */     DispatchTable dispatchTable = this.dispatchTables.get(dispChar);
/* 301 */     if (dispatchTable == null) {
/*     */       
/* 303 */       LispCharacter c = LispCharacter.getInstance(dispChar);
/* 304 */       Lisp.error(new LispError(c.princToString() + " is not a dispatch character."));
/*     */     } 
/*     */     
/* 307 */     dispatchTable.functions.put(LispCharacter.toUpperCase(subChar), function);
/*     */   }
/*     */ 
/*     */   
/*     */   protected static class DispatchTable
/*     */   {
/*     */     protected final CharHashMap<LispObject> functions;
/*     */     
/*     */     public DispatchTable() {
/* 316 */       this.functions = new CharHashMap<>(LispObject.class, null);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public DispatchTable(DispatchTable dt) {
/* 322 */       this.functions = (CharHashMap<LispObject>)dt.functions.clone();
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 327 */   private static final Primitive READTABLEP = new Primitive("readtablep", "object")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 333 */         return (arg instanceof Readtable) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 338 */   private static final Primitive COPY_READTABLE = new Primitive("copy-readtable", "&optional from-readtable to-readtable")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 344 */         return new Readtable(Lisp.currentReadtable());
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 350 */         return new Readtable(arg);
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 357 */         Readtable from = Lisp.designator_readtable(first);
/* 358 */         if (second == Lisp.NIL)
/* 359 */           return new Readtable(from); 
/* 360 */         Readtable to = Lisp.checkReadtable(second);
/* 361 */         Readtable.copyReadtable(from, to);
/* 362 */         return to;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 368 */   private static final Primitive GET_MACRO_CHARACTER = new Primitive("get-macro-character", "char &optional readtable")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 374 */         char c = LispCharacter.getValue(arg);
/* 375 */         Readtable rt = Lisp.currentReadtable();
/* 376 */         return rt.getMacroCharacter(c);
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second) {
/* 383 */         char c = LispCharacter.getValue(first);
/* 384 */         Readtable rt = Lisp.designator_readtable(second);
/* 385 */         return rt.getMacroCharacter(c);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 391 */   private static final Primitive SET_MACRO_CHARACTER = new Primitive("set-macro-character", "char new-function &optional non-terminating-p readtable")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 399 */         return execute(first, second, Lisp.NIL, Lisp.currentReadtable());
/*     */       }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 407 */         return execute(first, second, third, Lisp.currentReadtable());
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*     */         LispObject designator;
/*     */         byte syntaxType;
/* 415 */         char c = LispCharacter.getValue(first);
/*     */         
/* 417 */         if (second instanceof Function || second instanceof FuncallableStandardObject) {
/*     */           
/* 419 */           designator = second;
/* 420 */         } else if (second instanceof Symbol) {
/* 421 */           designator = second;
/*     */         } else {
/* 423 */           return Lisp.error(new LispError(second.princToString() + " does not designate a function."));
/*     */         } 
/*     */         
/* 426 */         if (third != Lisp.NIL) {
/* 427 */           syntaxType = 3;
/*     */         } else {
/* 429 */           syntaxType = 2;
/* 430 */         }  Readtable rt = Lisp.designator_readtable(fourth);
/*     */         
/* 432 */         rt.syntax.put(c, Byte.valueOf(syntaxType));
/* 433 */         rt.readerMacroFunctions.put(c, designator);
/* 434 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 440 */   private static final Primitive MAKE_DISPATCH_MACRO_CHARACTER = new Primitive("make-dispatch-macro-character", "char &optional non-terminating-p readtable")
/*     */     {
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*     */         LispObject non_terminating_p;
/*     */         
/*     */         Readtable readtable;
/* 447 */         if (args.length < 1 || args.length > 3)
/* 448 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 3)); 
/* 449 */         char dispChar = LispCharacter.getValue(args[0]);
/*     */         
/* 451 */         if (args.length > 1) {
/* 452 */           non_terminating_p = args[1];
/*     */         } else {
/* 454 */           non_terminating_p = Lisp.NIL;
/*     */         } 
/* 456 */         if (args.length == 3) {
/* 457 */           readtable = Lisp.checkReadtable(args[2]);
/*     */         } else {
/* 459 */           readtable = Lisp.currentReadtable();
/* 460 */         }  readtable.makeDispatchMacroCharacter(dispChar, non_terminating_p);
/* 461 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 467 */   private static final Primitive GET_DISPATCH_MACRO_CHARACTER = new Primitive("get-dispatch-macro-character", "disp-char sub-char &optional readtable")
/*     */     {
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*     */         Readtable readtable;
/*     */ 
/*     */         
/* 474 */         if (args.length < 2 || args.length > 3)
/* 475 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 3)); 
/* 476 */         char dispChar = LispCharacter.getValue(args[0]);
/* 477 */         char subChar = LispCharacter.getValue(args[1]);
/*     */         
/* 479 */         if (args.length == 3) {
/* 480 */           readtable = Lisp.designator_readtable(args[2]);
/*     */         } else {
/* 482 */           readtable = Lisp.currentReadtable();
/* 483 */         }  return readtable.getDispatchMacroCharacter(dispChar, subChar);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 489 */   private static final Primitive SET_DISPATCH_MACRO_CHARACTER = new Primitive("set-dispatch-macro-character", "disp-char sub-char new-function &optional readtable")
/*     */     {
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*     */         Readtable readtable;
/*     */ 
/*     */         
/* 496 */         if (args.length < 3 || args.length > 4)
/* 497 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 3, 4)); 
/* 498 */         char dispChar = LispCharacter.getValue(args[0]);
/* 499 */         char subChar = LispCharacter.getValue(args[1]);
/* 500 */         LispObject function = Lisp.coerceToFunction(args[2]);
/*     */         
/* 502 */         if (args.length == 4) {
/* 503 */           readtable = Lisp.designator_readtable(args[3]);
/*     */         } else {
/* 505 */           readtable = Lisp.currentReadtable();
/* 506 */         }  readtable.setDispatchMacroCharacter(dispChar, subChar, function);
/* 507 */         return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 513 */   private static final Primitive SET_SYNTAX_FROM_CHAR = new Primitive("set-syntax-from-char", "to-char from-char &optional to-readtable from-readtable")
/*     */     {
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*     */         Readtable toReadtable, fromReadtable;
/*     */ 
/*     */         
/* 520 */         if (args.length < 2 || args.length > 4)
/* 521 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 2, 4)); 
/* 522 */         char toChar = LispCharacter.getValue(args[0]);
/* 523 */         char fromChar = LispCharacter.getValue(args[1]);
/*     */         
/* 525 */         if (args.length > 2) {
/* 526 */           toReadtable = Lisp.checkReadtable(args[2]);
/*     */         } else {
/* 528 */           toReadtable = Lisp.currentReadtable();
/*     */         } 
/* 530 */         if (args.length > 3) {
/* 531 */           fromReadtable = Lisp.designator_readtable(args[3]);
/*     */         } else {
/* 533 */           fromReadtable = Lisp.checkReadtable(Lisp.STANDARD_READTABLE.symbolValue());
/*     */         } 
/* 535 */         toReadtable.syntax.put(toChar, fromReadtable.syntax.get(fromChar));
/* 536 */         toReadtable.readerMacroFunctions.put(toChar, fromReadtable.readerMacroFunctions
/* 537 */             .get(fromChar));
/*     */ 
/*     */         
/* 540 */         Readtable.DispatchTable found = fromReadtable.dispatchTables.get(fromChar);
/* 541 */         if (found != null) {
/* 542 */           toReadtable.dispatchTables.put(toChar, new Readtable.DispatchTable(found));
/*     */         }
/*     */         else {
/*     */           
/* 546 */           toReadtable.dispatchTables.put(toChar, null);
/* 547 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 552 */   private static final Primitive READTABLE_CASE = new Primitive("readtable-case", "readtable")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 558 */         return (Lisp.checkReadtable(arg)).readtableCase;
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 563 */   private static final Primitive _SET_READTABLE_CASE = new Primitive("%set-readtable-case", Lisp.PACKAGE_SYS, false, "readtable new-mode")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 571 */         Readtable readtable = Lisp.checkReadtable(first);
/* 572 */         if (second == Keyword.UPCASE || second == Keyword.DOWNCASE || second == Keyword.INVERT || second == Keyword.PRESERVE) {
/*     */ 
/*     */           
/* 575 */           readtable.readtableCase = second;
/* 576 */           return second;
/*     */         } 
/* 578 */         return Lisp.type_error(second, Lisp.list(Symbol.MEMBER, new LispObject[] { Keyword.INVERT, Keyword.PRESERVE, Keyword.DOWNCASE, Keyword.UPCASE }));
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Readtable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */