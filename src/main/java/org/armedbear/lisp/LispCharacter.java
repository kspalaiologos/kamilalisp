/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.HashMap;
/*     */ import java.util.Map;
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
/*     */ public final class LispCharacter
/*     */   extends LispObject
/*     */ {
/*     */   public static final LispCharacter[] constants;
/*     */   
/*  47 */   public static final CharHashMap<LispCharacter> lispChars = new CharHashMap<LispCharacter>(LispCharacter.class, null) {
/*     */       public LispCharacter get(char c) {
/*  49 */         LispCharacter lc = super.get(c);
/*  50 */         if (lc == null) {
/*  51 */           lc = new LispCharacter(c);
/*  52 */           put(c, lc);
/*     */         } 
/*  54 */         return lc;
/*     */       }
/*     */     }; static {
/*  57 */     constants = (LispCharacter[])lispChars.constants; int i;
/*  58 */     for (i = constants.length; i-- > 0;) {
/*  59 */       constants[i] = new LispCharacter((char)i);
/*     */     }
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
/* 288 */     CHARACTER = new Primitive(Symbol.CHARACTER, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 294 */           if (arg instanceof LispCharacter)
/* 295 */             return arg; 
/* 296 */           if (arg instanceof AbstractString) {
/*     */             
/* 298 */             if (arg.length() == 1) {
/* 299 */               return ((AbstractString)arg).AREF(0);
/*     */             }
/* 301 */           } else if (arg instanceof Symbol) {
/*     */             
/* 303 */             String name = ((Symbol)arg).getName();
/* 304 */             if (name.length() == 1)
/* 305 */               return LispCharacter.getInstance(name.charAt(0)); 
/*     */           } 
/* 307 */           return Lisp.type_error(arg, Symbol.CHARACTER_DESIGNATOR);
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 312 */     WHITESPACEP = new Primitive("whitespacep", Lisp.PACKAGE_SYS, true)
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 318 */           return Character.isWhitespace(LispCharacter.getValue(arg)) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 323 */     CHAR_CODE = new Primitive(Symbol.CHAR_CODE, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 329 */           int n = LispCharacter.getValue(arg);
/* 330 */           return Fixnum.getInstance(n);
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 335 */     CHAR_INT = new Primitive(Symbol.CHAR_INT, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 341 */           int n = LispCharacter.getValue(arg);
/* 342 */           return Fixnum.getInstance(n);
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 347 */     CODE_CHAR = new Primitive(Symbol.CODE_CHAR, "code")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 353 */           int n = Fixnum.getValue(arg);
/* 354 */           if (Character.isValidCodePoint(n))
/* 355 */             return LispCharacter.getInstance((char)n); 
/* 356 */           return Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 361 */     CHARACTERP = new Primitive(Symbol.CHARACTERP, "object")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 367 */           return (arg instanceof LispCharacter) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 372 */     BOTH_CASE_P = new Primitive(Symbol.BOTH_CASE_P, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 378 */           char c = LispCharacter.getValue(arg);
/* 379 */           if (Character.isLowerCase(c) || Character.isUpperCase(c))
/* 380 */             return Lisp.T; 
/* 381 */           return Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 386 */     LOWER_CASE_P = new Primitive(Symbol.LOWER_CASE_P, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 392 */           return Character.isLowerCase(LispCharacter.getValue(arg)) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 397 */     UPPER_CASE_P = new Primitive(Symbol.UPPER_CASE_P, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 403 */           return Character.isUpperCase(LispCharacter.getValue(arg)) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 408 */     CHAR_DOWNCASE = new Primitive(Symbol.CHAR_DOWNCASE, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 414 */           char c = LispCharacter.getValue(arg);
/* 415 */           if (c < '')
/* 416 */             return LispCharacter.constants[LispCharacter.LOWER_CASE_CHARS[c]]; 
/* 417 */           return LispCharacter.getInstance(LispCharacter.toLowerCase(c));
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 422 */     CHAR_UPCASE = new Primitive(Symbol.CHAR_UPCASE, "character")
/*     */       {
/*     */ 
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 429 */           char c = LispCharacter.getValue(arg);
/* 430 */           if (c < '')
/* 431 */             return LispCharacter.constants[LispCharacter.UPPER_CASE_CHARS[c]]; 
/* 432 */           return LispCharacter.getInstance(LispCharacter.toUpperCase(c));
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 437 */     DIGIT_CHAR = new Primitive(Symbol.DIGIT_CHAR, "weight &optional radix")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 443 */           if (arg instanceof Bignum) {
/* 444 */             return Lisp.NIL;
/*     */           }
/* 446 */           int weight = Fixnum.getValue(arg);
/* 447 */           if (weight < 10)
/* 448 */             return LispCharacter.constants[48 + weight]; 
/* 449 */           return Lisp.NIL;
/*     */         }
/*     */ 
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject first, LispObject second) {
/*     */           int radix;
/* 456 */           if (second instanceof Fixnum) {
/* 457 */             radix = ((Fixnum)second).value;
/*     */           } else {
/* 459 */             radix = -1;
/*     */           } 
/* 461 */           if (radix < 2 || radix > 36) {
/* 462 */             return Lisp.type_error(second, 
/* 463 */                 Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.TWO, Fixnum.constants[36] }));
/*     */           }
/* 465 */           if (first instanceof Bignum)
/* 466 */             return Lisp.NIL; 
/* 467 */           int weight = Fixnum.getValue(first);
/* 468 */           if (weight >= radix)
/* 469 */             return Lisp.NIL; 
/* 470 */           if (weight < 10)
/* 471 */             return LispCharacter.constants[48 + weight]; 
/* 472 */           return LispCharacter.constants[65 + weight - 10];
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 477 */     DIGIT_CHAR_P = new Primitive(Symbol.DIGIT_CHAR_P, "char &optional radix")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 483 */           int n = Character.digit(LispCharacter.getValue(arg), 10);
/* 484 */           return (n < 0) ? Lisp.NIL : Fixnum.getInstance(n);
/*     */         }
/*     */ 
/*     */ 
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject first, LispObject second) {
/* 491 */           char c = LispCharacter.getValue(first);
/* 492 */           if (second instanceof Fixnum) {
/*     */             
/* 494 */             int radix = ((Fixnum)second).value;
/* 495 */             if (radix >= 2 && radix <= 36) {
/*     */               
/* 497 */               int n = Character.digit(c, radix);
/* 498 */               return (n < 0) ? Lisp.NIL : Fixnum.constants[n];
/*     */             } 
/*     */           } 
/* 501 */           return Lisp.type_error(second, 
/* 502 */               Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.TWO, Fixnum.constants[36] }));
/*     */         }
/*     */       };
/*     */ 
/*     */ 
/*     */     
/* 508 */     STANDARD_CHAR_P = new Primitive(Symbol.STANDARD_CHAR_P, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 514 */           return Lisp.checkCharacter(arg).isStandardChar() ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 519 */     GRAPHIC_CHAR_P = new Primitive(Symbol.GRAPHIC_CHAR_P, "char")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 525 */           char c = LispCharacter.getValue(arg);
/* 526 */           if (c >= ' ' && c < '')
/* 527 */             return Lisp.T; 
/* 528 */           return Character.isISOControl(c) ? Lisp.NIL : Lisp.T;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 533 */     ALPHA_CHAR_P = new Primitive(Symbol.ALPHA_CHAR_P, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 539 */           return Character.isLetter(LispCharacter.getValue(arg)) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */     
/* 544 */     ALPHANUMERICP = new Primitive(Symbol.ALPHANUMERICP, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 550 */           return Character.isLetterOrDigit(LispCharacter.getValue(arg)) ? Lisp.T : Lisp.NIL;
/*     */         }
/*     */       };
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
/* 604 */     NAME_CHAR = new Primitive(Symbol.NAME_CHAR, "name")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 610 */           String s = arg.STRING().getStringValue();
/* 611 */           int n = LispCharacter.nameToChar(s);
/* 612 */           return (n >= 0) ? LispCharacter.getInstance((char)n) : Lisp.NIL;
/*     */         }
/*     */       };
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
/* 649 */     CHAR_NAME = new Primitive(Symbol.CHAR_NAME, "character")
/*     */       {
/*     */ 
/*     */         
/*     */         public LispObject execute(LispObject arg)
/*     */         {
/* 655 */           String name = LispCharacter.charToName(LispCharacter.getValue(arg));
/* 656 */           return (name != null) ? new SimpleString(name) : Lisp.NIL;
/*     */         }
/*     */       };
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 667 */     maxNamedChar = 0;
/* 668 */     namedToChar = new HashMap<>();
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
/* 689 */     new CharNameMaker0();
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 699 */     UPPER_CASE_CHARS = new char[128];
/*     */ 
/*     */ 
/*     */     
/* 703 */     for (i = UPPER_CASE_CHARS.length; i-- > 0;) {
/* 704 */       UPPER_CASE_CHARS[i] = Character.toUpperCase((char)i);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 714 */     LOWER_CASE_CHARS = new char[128];
/*     */ 
/*     */ 
/*     */     
/* 718 */     for (i = LOWER_CASE_CHARS.length; i-- > 0;)
/* 719 */       LOWER_CASE_CHARS[i] = Character.toLowerCase((char)i); 
/*     */   }
/*     */   
/*     */   public final char value;
/*     */   private String name;
/*     */   private static final Primitive CHARACTER;
/*     */   private static final Primitive WHITESPACEP;
/*     */   private static final Primitive CHAR_CODE;
/*     */   private static final Primitive CHAR_INT;
/*     */   private static final Primitive CODE_CHAR;
/*     */   private static final Primitive CHARACTERP;
/*     */   private static final Primitive BOTH_CASE_P;
/*     */   private static final Primitive LOWER_CASE_P;
/*     */   private static final Primitive UPPER_CASE_P;
/*     */   private static final Primitive CHAR_DOWNCASE;
/*     */   private static final Primitive CHAR_UPCASE;
/*     */   private static final Primitive DIGIT_CHAR;
/*     */   private static final Primitive DIGIT_CHAR_P;
/*     */   private static final Primitive STANDARD_CHAR_P;
/*     */   private static final Primitive GRAPHIC_CHAR_P;
/*     */   private static final Primitive ALPHA_CHAR_P;
/*     */   private static final Primitive ALPHANUMERICP;
/*     */   private static final Primitive NAME_CHAR;
/*     */   private static final Primitive CHAR_NAME;
/*     */   static int maxNamedChar;
/*     */   static Map<String, LispCharacter> namedToChar;
/*     */   static final char[] UPPER_CASE_CHARS;
/*     */   static final char[] LOWER_CASE_CHARS;
/*     */   
/*     */   public static LispCharacter getInstance(char c) {
/*     */     return lispChars.get(c);
/*     */   }
/*     */   
/*     */   private LispCharacter(char c) {
/*     */     this.value = c;
/*     */   }
/*     */   
/*     */   public LispObject typeOf() {
/*     */     if (isStandardChar())
/*     */       return Symbol.STANDARD_CHAR; 
/*     */     return Symbol.CHARACTER;
/*     */   }
/*     */   
/*     */   public LispObject classOf() {
/*     */     return BuiltInClass.CHARACTER;
/*     */   }
/*     */   
/*     */   public LispObject getDescription() {
/*     */     StringBuilder sb = new StringBuilder("character #\\");
/*     */     sb.append(this.value);
/*     */     sb.append(" char-code #x");
/*     */     sb.append(Integer.toHexString(this.value));
/*     */     return new SimpleString(sb);
/*     */   }
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*     */     if (type == Symbol.CHARACTER)
/*     */       return Lisp.T; 
/*     */     if (type == BuiltInClass.CHARACTER)
/*     */       return Lisp.T; 
/*     */     if (type == Symbol.BASE_CHAR)
/*     */       return Lisp.T; 
/*     */     if (type == Symbol.STANDARD_CHAR)
/*     */       return isStandardChar() ? Lisp.T : Lisp.NIL; 
/*     */     return super.typep(type);
/*     */   }
/*     */   
/*     */   public boolean characterp() {
/*     */     return true;
/*     */   }
/*     */   
/*     */   public LispObject STRING() {
/*     */     return new SimpleString(this.value);
/*     */   }
/*     */   
/*     */   boolean isStandardChar() {
/*     */     if (this.value >= ' ' && this.value < '')
/*     */       return true; 
/*     */     if (this.value == '\n')
/*     */       return true; 
/*     */     return false;
/*     */   }
/*     */   
/*     */   public boolean eql(char c) {
/*     */     return (this.value == c);
/*     */   }
/*     */   
/*     */   public boolean eql(LispObject obj) {
/*     */     if (this == obj)
/*     */       return true; 
/*     */     if (obj instanceof LispCharacter)
/*     */       if (this.value == ((LispCharacter)obj).value)
/*     */         return true;  
/*     */     return false;
/*     */   }
/*     */   
/*     */   public boolean equal(LispObject obj) {
/*     */     if (this == obj)
/*     */       return true; 
/*     */     if (obj instanceof LispCharacter)
/*     */       if (this.value == ((LispCharacter)obj).value)
/*     */         return true;  
/*     */     return false;
/*     */   }
/*     */   
/*     */   public boolean equalp(LispObject obj) {
/*     */     if (this == obj)
/*     */       return true; 
/*     */     if (obj instanceof LispCharacter) {
/*     */       if (this.value == ((LispCharacter)obj).value)
/*     */         return true; 
/*     */       return (toLowerCase(this.value) == toLowerCase(((LispCharacter)obj).value));
/*     */     } 
/*     */     return false;
/*     */   }
/*     */   
/*     */   public static char getValue(LispObject obj) {
/*     */     if (obj instanceof LispCharacter)
/*     */       return ((LispCharacter)obj).value; 
/*     */     Lisp.type_error(obj, Symbol.CHARACTER);
/*     */     return Character.MIN_VALUE;
/*     */   }
/*     */   
/*     */   public final char getValue() {
/*     */     return this.value;
/*     */   }
/*     */   
/*     */   public Object javaInstance() {
/*     */     return Character.valueOf(this.value);
/*     */   }
/*     */   
/*     */   public Object javaInstance(Class c) {
/*     */     return javaInstance();
/*     */   }
/*     */   
/*     */   public int sxhash() {
/*     */     return this.value;
/*     */   }
/*     */   
/*     */   public int psxhash() {
/*     */     return Character.toUpperCase(this.value);
/*     */   }
/*     */   
/*     */   public String getStringValue() {
/*     */     return String.valueOf(this.value);
/*     */   }
/*     */   
/*     */   public final String printObject() {
/*     */     LispThread thread = LispThread.currentThread();
/*     */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/*     */     boolean printEscape = (printReadably || Symbol.PRINT_ESCAPE.symbolValue(thread) != Lisp.NIL);
/*     */     StringBuilder sb = new StringBuilder();
/*     */     if (printEscape) {
/*     */       sb.append("#\\");
/*     */       switch (this.value) {
/*     */         case '\000':
/*     */           sb.append("Null");
/*     */           return sb.toString();
/*     */         case '\007':
/*     */           sb.append("Bell");
/*     */           return sb.toString();
/*     */         case '\b':
/*     */           sb.append("Backspace");
/*     */           return sb.toString();
/*     */         case '\t':
/*     */           sb.append("Tab");
/*     */           return sb.toString();
/*     */         case '\n':
/*     */           sb.append("Newline");
/*     */           return sb.toString();
/*     */         case '\f':
/*     */           sb.append("Page");
/*     */           return sb.toString();
/*     */         case '\r':
/*     */           sb.append("Return");
/*     */           return sb.toString();
/*     */         case '\033':
/*     */           sb.append("Escape");
/*     */           return sb.toString();
/*     */         case '':
/*     */           sb.append("Rubout");
/*     */           return sb.toString();
/*     */         case ' ':
/*     */           sb.append("No-break_space");
/*     */           return sb.toString();
/*     */       } 
/*     */       if (this.name != null) {
/*     */         sb.append(this.name);
/*     */       } else {
/*     */         sb.append(this.value);
/*     */       } 
/*     */     } else {
/*     */       sb.append(this.value);
/*     */     } 
/*     */     return sb.toString();
/*     */   }
/*     */   
/*     */   public static final int nameToChar(String s) {
/*     */     String lower = s.toLowerCase();
/*     */     LispCharacter lc = namedToChar.get(lower);
/*     */     if (lc != null)
/*     */       return lc.value; 
/*     */     if (lower.length() == 5 && lower.startsWith("u"))
/*     */       try {
/*     */         int i = Integer.parseInt(lower.substring(1, 5), 16);
/*     */         return i;
/*     */       } catch (NumberFormatException numberFormatException) {} 
/*     */     if (lower.equals("nul"))
/*     */       return 0; 
/*     */     if (lower.equals("bel"))
/*     */       return 7; 
/*     */     if (lower.equals("bs"))
/*     */       return 8; 
/*     */     if (lower.equals("ht"))
/*     */       return 9; 
/*     */     if (lower.equals("linefeed") || lower.equals("lf"))
/*     */       return 10; 
/*     */     if (lower.equals("ff"))
/*     */       return 12; 
/*     */     if (lower.equals("cr"))
/*     */       return 13; 
/*     */     if (lower.equals("esc"))
/*     */       return 27; 
/*     */     if (lower.equals("space") || lower.equals("sp"))
/*     */       return 32; 
/*     */     if (lower.equals("rubout") || lower.equals("del") || lower.equals("delete"))
/*     */       return 127; 
/*     */     if (lower.equals("no-break_space"))
/*     */       return 160; 
/*     */     if (lower.startsWith("u")) {
/*     */       int length = lower.length();
/*     */       if (length > 1 && length < 5)
/*     */         try {
/*     */           int i = Integer.parseInt(lower.substring(1), 16);
/*     */           return i;
/*     */         } catch (NumberFormatException numberFormatException) {} 
/*     */     } 
/*     */     return -1;
/*     */   }
/*     */   
/*     */   public static final String charToName(char c) {
/*     */     switch (c) {
/*     */       case '\000':
/*     */         return "Null";
/*     */       case '\007':
/*     */         return "Bell";
/*     */       case '\b':
/*     */         return "Backspace";
/*     */       case '\t':
/*     */         return "Tab";
/*     */       case '\n':
/*     */         return "Newline";
/*     */       case '\f':
/*     */         return "Page";
/*     */       case '\r':
/*     */         return "Return";
/*     */       case '\033':
/*     */         return "Escape";
/*     */       case ' ':
/*     */         return "Space";
/*     */       case '':
/*     */         return "Rubout";
/*     */       case ' ':
/*     */         return "No-break_space";
/*     */     } 
/*     */     if (c < '\000' || c > 'ÿ')
/*     */       return null; 
/*     */     return ((LispCharacter)lispChars.get(c)).name;
/*     */   }
/*     */   
/*     */   public static final char toUpperCase(char c) {
/*     */     if (c < '')
/*     */       return UPPER_CASE_CHARS[c]; 
/*     */     return Character.toUpperCase(c);
/*     */   }
/*     */   
/*     */   static void setCharNames(int i, String[] string) {
/*     */     int settingChar = i;
/*     */     int index = 0;
/*     */     int stringLen = string.length;
/*     */     while (stringLen-- > 0) {
/*     */       setCharName(settingChar, string[index]);
/*     */       index++;
/*     */       settingChar++;
/*     */     } 
/*     */     if (maxNamedChar < settingChar)
/*     */       maxNamedChar = settingChar; 
/*     */   }
/*     */   
/*     */   static void setCharName(int settingChar, String string) {
/*     */     LispCharacter c = lispChars.get((char)settingChar);
/*     */     c.name = string;
/*     */     namedToChar.put(string.toLowerCase(), c);
/*     */   }
/*     */   
/*     */   static class CharNameMaker0 {
/*     */     CharNameMaker0() {
/*     */       LispCharacter.setCharNames(0, new String[] { 
/*     */             "Null", "Soh", "Stx", "Etx", "Eot", "Enq", "Ack", "Bell", "Backspace", "Tab", 
/*     */             "Newline", "Vt", "Page", "Return", "So", "Si", "Dle", "Dc1", "Dc2", "Dc3", 
/*     */             "Dc4", "Nak", "Syn", "Etb", "Can", "Em", "Sub", "Escape", "Fs", "Gs", 
/*     */             "Rs", "Us" });
/*     */       LispCharacter.setCharNames(128, new String[] { 
/*     */             "U0080", "U0081", "U0082", "U0083", "U0084", "U0085", "U0086", "U0087", "U0088", "U0089", 
/*     */             "U008a", "U008b", "U008c", "U008d", "U008e", "U008f", "U0090", "U0091", "U0092", "U0093", 
/*     */             "U0094", "U0095", "U0096", "U0097", "U0098", "U0099", "U009a", "U009b", "U009c", "U009d", 
/*     */             "U009e", "U009f" });
/*     */     }
/*     */   }
/*     */   
/*     */   public static final char toLowerCase(char c) {
/*     */     if (c < '')
/*     */       return LOWER_CASE_CHARS[c]; 
/*     */     return Character.toLowerCase(c);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispCharacter.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */