/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.util.Arrays;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class StringFunctions
/*     */ {
/*     */   static final class StringIndicesAndChars
/*     */   {
/*     */     public AbstractString string1;
/*     */     public boolean convertCase = false;
/*     */     public char[] array1;
/*     */     public char[] array2;
/*  45 */     public int start1 = 0;
/*  46 */     public int end1 = 0;
/*  47 */     public int start2 = 0;
/*  48 */     public int end2 = 0;
/*     */   }
/*     */   
/*     */   private static final void checkParams(StringIndicesAndChars indicesAndChars) {
/*  52 */     if (indicesAndChars.start1 < 0 || indicesAndChars.start1 > indicesAndChars.array1.length)
/*     */     {
/*  54 */       Lisp.error(new TypeError("Invalid start position " + indicesAndChars.start1 + "."));
/*     */     }
/*  56 */     if (indicesAndChars.end1 < 0 || indicesAndChars.end1 > indicesAndChars.array1.length)
/*     */     {
/*  58 */       Lisp.error(new TypeError("Invalid end position " + indicesAndChars.end1 + "."));
/*     */     }
/*     */     
/*  61 */     if (indicesAndChars.start1 > indicesAndChars.end1) {
/*  62 */       Lisp.error(new TypeError("Start (" + indicesAndChars.start1 + ") is greater than end (" + indicesAndChars.end1 + ")."));
/*     */     }
/*     */ 
/*     */     
/*  66 */     if (indicesAndChars.array2 != null) {
/*  67 */       if (indicesAndChars.start2 < 0 || indicesAndChars.start2 > indicesAndChars.array2.length)
/*     */       {
/*  69 */         Lisp.error(new TypeError("Invalid start2 position " + indicesAndChars.start2 + "."));
/*     */       }
/*  71 */       if (indicesAndChars.end2 < 0 || indicesAndChars.end2 > indicesAndChars.array2.length)
/*     */       {
/*  73 */         Lisp.error(new TypeError("Invalid end2 position " + indicesAndChars.end2 + "."));
/*     */       }
/*  75 */       if (indicesAndChars.start2 > indicesAndChars.end2) {
/*  76 */         Lisp.error(new TypeError("Start2 (" + indicesAndChars.start2 + ") is greater than end2 (" + indicesAndChars.end2 + ")."));
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   private static final char upcaseIfNeeded(char c, boolean convert) {
/*  85 */     return convert ? LispCharacter.toUpperCase(c) : c;
/*     */   }
/*     */ 
/*     */   
/*     */   static final StringIndicesAndChars stringIndicesAndChars(LispObject... params) {
/*  90 */     StringIndicesAndChars retVal = new StringIndicesAndChars();
/*  91 */     retVal.string1 = Lisp.checkString(params[0].STRING());
/*  92 */     retVal.array1 = retVal.string1.getStringChars();
/*  93 */     retVal.end1 = retVal.array1.length;
/*  94 */     if (params.length == 3) {
/*  95 */       if (params[1] != Lisp.NIL) {
/*  96 */         retVal.start1 = Fixnum.getValue(params[1]);
/*     */       }
/*  98 */       if (params[2] != Lisp.NIL) {
/*  99 */         retVal.end1 = Fixnum.getValue(params[2]);
/*     */       }
/*     */     } else {
/* 102 */       retVal.array2 = params[1].STRING().getStringChars();
/* 103 */       retVal.end2 = retVal.array2.length;
/* 104 */       if (params.length > 2) {
/* 105 */         if (params[2] != Lisp.NIL) {
/* 106 */           retVal.start1 = Fixnum.getValue(params[2]);
/*     */         }
/* 108 */         if (params[3] != Lisp.NIL) {
/* 109 */           retVal.end1 = Fixnum.getValue(params[3]);
/*     */         }
/* 111 */         if (params[4] != Lisp.NIL) {
/* 112 */           retVal.start2 = Fixnum.getValue(params[4]);
/*     */         }
/* 114 */         if (params[5] != Lisp.NIL) {
/* 115 */           retVal.end2 = Fixnum.getValue(params[5]);
/*     */         }
/*     */       } 
/*     */     } 
/* 119 */     checkParams(retVal);
/* 120 */     return retVal;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 125 */   private static final Primitive __STRING_EQUAL = new pf___string_equal();
/*     */   
/*     */   private static final class pf___string_equal extends Primitive { pf___string_equal() {
/* 128 */       super("%%string=", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2) {
/* 136 */       StringFunctions.StringIndicesAndChars chars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2 });
/* 137 */       return Arrays.equals(chars.array1, chars.array2) ? Lisp.T : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 144 */   private static final Primitive _STRING_EQUAL = new pf__string_equal();
/*     */   
/*     */   private static final class pf__string_equal extends Primitive { pf__string_equal() {
/* 147 */       super("%string=", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 156 */       return 
/* 157 */         (StringFunctions._STRING_NOT_EQUAL.execute(string1, string2, start1, end1, start2, end2) == Lisp.NIL) ? Lisp.T : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static final int notEqual(StringIndicesAndChars indicesAndChars) {
/* 166 */     int i = indicesAndChars.start1;
/* 167 */     int j = indicesAndChars.start2;
/*     */     while (true) {
/* 169 */       if (i == indicesAndChars.end1) {
/*     */         
/* 171 */         if (j == indicesAndChars.end2)
/* 172 */           return -1; 
/* 173 */         return i;
/*     */       } 
/* 175 */       if (j == indicesAndChars.end2)
/*     */       {
/* 177 */         return i;
/*     */       }
/* 179 */       if (upcaseIfNeeded(indicesAndChars.array1[i], indicesAndChars.convertCase) != 
/*     */         
/* 181 */         upcaseIfNeeded(indicesAndChars.array2[j], indicesAndChars.convertCase))
/*     */       {
/* 183 */         return i; } 
/* 184 */       i++;
/* 185 */       j++;
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/* 190 */   static final Primitive _STRING_NOT_EQUAL = new pf__string_not_equal();
/*     */   
/*     */   private static final class pf__string_not_equal extends Primitive { pf__string_not_equal() {
/* 193 */       super("%string/=", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 201 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */       
/* 203 */       int tmp = StringFunctions.notEqual(indicesAndChars);
/* 204 */       return (tmp >= 0) ? Fixnum.getInstance(tmp) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 210 */   private static final Primitive _STRING_EQUAL_IGNORE_CASE = new pf__string_equal_ignore_case();
/*     */   
/*     */   private static final class pf__string_equal_ignore_case extends Primitive { pf__string_equal_ignore_case() {
/* 213 */       super("%string-equal", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 222 */       return (StringFunctions._STRING_NOT_EQUAL_IGNORE_CASE.execute(string1, string2, start1, end1, start2, end2) == Lisp.NIL) ? Lisp.T : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 231 */   static final Primitive _STRING_NOT_EQUAL_IGNORE_CASE = new pf__string_not_equal_ignore_case();
/*     */   
/*     */   private static final class pf__string_not_equal_ignore_case extends Primitive { pf__string_not_equal_ignore_case() {
/* 234 */       super("%string-not-equal", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 242 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */       
/* 244 */       indicesAndChars.convertCase = true;
/* 245 */       int tmp = StringFunctions.notEqual(indicesAndChars);
/* 246 */       return (tmp >= 0) ? Fixnum.getInstance(tmp) : Lisp.NIL;
/*     */     } }
/*     */   
/*     */   static final int lessThan(StringIndicesAndChars indicesAndChars) {
/*     */     char c1, c2;
/* 251 */     int i = indicesAndChars.start1;
/* 252 */     int j = indicesAndChars.start2;
/*     */     while (true) {
/* 254 */       if (i == indicesAndChars.end1) {
/*     */         
/* 256 */         if (j == indicesAndChars.end2)
/* 257 */           return -1; 
/* 258 */         return i;
/*     */       } 
/* 260 */       if (j == indicesAndChars.end2)
/*     */       {
/* 262 */         return -1;
/*     */       }
/* 264 */       c1 = upcaseIfNeeded(indicesAndChars.array1[i], indicesAndChars.convertCase);
/*     */       
/* 266 */       c2 = upcaseIfNeeded(indicesAndChars.array2[j], indicesAndChars.convertCase);
/*     */       
/* 268 */       if (c1 == c2) {
/* 269 */         i++;
/* 270 */         j++; continue;
/*     */       }  break;
/*     */     } 
/* 273 */     if (c1 < c2) {
/* 274 */       return i;
/*     */     }
/* 276 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 282 */   private static final Primitive _STRING_LESS_THAN = new pf__string_less_than();
/*     */   
/*     */   private static final class pf__string_less_than extends Primitive { pf__string_less_than() {
/* 285 */       super("%string<", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 293 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */       
/* 295 */       int retVal = StringFunctions.lessThan(indicesAndChars);
/* 296 */       return (retVal >= 0) ? Fixnum.getInstance(retVal) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static LispObject swapReturnValue(int original, StringIndicesAndChars indicesAndChars) {
/* 303 */     if (original < 0) {
/* 304 */       return Lisp.NIL;
/*     */     }
/* 306 */     int delta = original - indicesAndChars.start1;
/* 307 */     int retVal = indicesAndChars.start2 + delta;
/* 308 */     return Fixnum.getInstance(retVal);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 313 */   private static final Primitive _STRING_GREATER_THAN = new pf__string_greater_than();
/*     */   
/*     */   private static final class pf__string_greater_than extends Primitive { pf__string_greater_than() {
/* 316 */       super("%string>", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 325 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string2, string1, start2, end2, start1, end1 });
/*     */ 
/*     */       
/* 328 */       int tmp = StringFunctions.lessThan(indicesAndChars);
/* 329 */       return StringFunctions.swapReturnValue(tmp, indicesAndChars);
/*     */     } }
/*     */   
/*     */   static final int lessThanOrEqual(StringIndicesAndChars indicesAndChars) {
/*     */     char c1, c2;
/* 334 */     int i = indicesAndChars.start1;
/* 335 */     int j = indicesAndChars.start2;
/*     */     while (true) {
/* 337 */       if (i == indicesAndChars.end1)
/*     */       {
/* 339 */         return i;
/*     */       }
/* 341 */       if (j == indicesAndChars.end2)
/*     */       {
/* 343 */         return -1;
/*     */       }
/* 345 */       c1 = upcaseIfNeeded(indicesAndChars.array1[i], indicesAndChars.convertCase);
/*     */       
/* 347 */       c2 = upcaseIfNeeded(indicesAndChars.array2[j], indicesAndChars.convertCase);
/*     */       
/* 349 */       if (c1 == c2) {
/* 350 */         i++;
/* 351 */         j++; continue;
/*     */       }  break;
/*     */     } 
/* 354 */     if (c1 > c2) {
/* 355 */       return -1;
/*     */     }
/* 357 */     return i;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 362 */   private static final Primitive _STRING_LE = new pf__string_le();
/*     */   
/*     */   private static final class pf__string_le extends Primitive { pf__string_le() {
/* 365 */       super("%string<=", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 374 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */       
/* 376 */       int retVal = StringFunctions.lessThanOrEqual(indicesAndChars);
/* 377 */       return (retVal >= 0) ? Fixnum.getInstance(retVal) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 383 */   private static final Primitive _STRING_GE = new pf__string_ge();
/*     */   
/*     */   private static final class pf__string_ge extends Primitive { pf__string_ge() {
/* 386 */       super("%string>=", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 395 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string2, string1, start2, end2, start1, end1 });
/*     */ 
/*     */       
/* 398 */       int tmp = StringFunctions.lessThanOrEqual(indicesAndChars);
/* 399 */       return StringFunctions.swapReturnValue(tmp, indicesAndChars);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 406 */   private static final Primitive _STRING_LESSP = new pf__string_lessp();
/*     */   
/*     */   private static final class pf__string_lessp extends Primitive { pf__string_lessp() {
/* 409 */       super("%string-lessp", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 417 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */       
/* 419 */       indicesAndChars.convertCase = true;
/* 420 */       int retVal = StringFunctions.lessThan(indicesAndChars);
/* 421 */       return (retVal >= 0) ? Fixnum.getInstance(retVal) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 427 */   private static final Primitive _STRING_GREATERP = new pf__string_greaterp();
/*     */   
/*     */   private static final class pf__string_greaterp extends Primitive { pf__string_greaterp() {
/* 430 */       super("%string-greaterp", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 439 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string2, string1, start2, end2, start1, end1 });
/*     */ 
/*     */       
/* 442 */       indicesAndChars.convertCase = true;
/* 443 */       int tmp = StringFunctions.lessThan(indicesAndChars);
/* 444 */       return StringFunctions.swapReturnValue(tmp, indicesAndChars);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 449 */   private static final Primitive _STRING_NOT_LESSP = new pf__string_not_lessp();
/*     */   
/*     */   private static final class pf__string_not_lessp extends Primitive { pf__string_not_lessp() {
/* 452 */       super("%string-not-lessp", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 461 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string2, string1, start2, end2, start1, end1 });
/*     */ 
/*     */       
/* 464 */       indicesAndChars.convertCase = true;
/* 465 */       int tmp = StringFunctions.lessThanOrEqual(indicesAndChars);
/* 466 */       return StringFunctions.swapReturnValue(tmp, indicesAndChars);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 472 */   private static final Primitive _STRING_NOT_GREATERP = new pf__string_not_greaterp();
/*     */   
/*     */   private static final class pf__string_not_greaterp extends Primitive { pf__string_not_greaterp() {
/* 475 */       super("%string-not-greaterp", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string1, LispObject string2, LispObject start1, LispObject end1, LispObject start2, LispObject end2) {
/* 483 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string1, string2, start1, end1, start2, end2 });
/*     */ 
/*     */       
/* 486 */       indicesAndChars.convertCase = true;
/* 487 */       int tmp = StringFunctions.lessThanOrEqual(indicesAndChars);
/* 488 */       return (tmp >= 0) ? Fixnum.getInstance(tmp) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 493 */   private static final Primitive _STRING_UPCASE = new pf__string_upcase();
/*     */   
/*     */   private static final class pf__string_upcase extends Primitive { pf__string_upcase() {
/* 496 */       super("%string-upcase", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 505 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 506 */       char[] array = new char[indicesAndChars.array1.length];
/* 507 */       System.arraycopy(indicesAndChars.array1, 0, array, 0, indicesAndChars.start1);
/*     */ 
/*     */       
/* 510 */       for (int i = indicesAndChars.start1; i < indicesAndChars.end1; i++)
/* 511 */         array[i] = LispCharacter.toUpperCase(indicesAndChars.array1[i]); 
/* 512 */       System.arraycopy(indicesAndChars.array1, indicesAndChars.end1, array, indicesAndChars.end1, indicesAndChars.array1.length - indicesAndChars.end1);
/*     */ 
/*     */ 
/*     */       
/* 516 */       return new SimpleString(array);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 521 */   private static final Primitive _STRING_DOWNCASE = new pf__string_downcase();
/*     */   
/*     */   private static final class pf__string_downcase extends Primitive { pf__string_downcase() {
/* 524 */       super("%string-downcase", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 531 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 532 */       char[] array = new char[indicesAndChars.array1.length];
/* 533 */       System.arraycopy(indicesAndChars.array1, 0, array, 0, indicesAndChars.start1);
/*     */ 
/*     */       
/* 536 */       for (int i = indicesAndChars.start1; i < indicesAndChars.end1; i++)
/* 537 */         array[i] = LispCharacter.toLowerCase(indicesAndChars.array1[i]); 
/* 538 */       System.arraycopy(indicesAndChars.array1, indicesAndChars.end1, array, indicesAndChars.end1, indicesAndChars.array1.length - indicesAndChars.end1);
/*     */ 
/*     */ 
/*     */       
/* 542 */       return new SimpleString(array);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 547 */   private static final Primitive _STRING_CAPITALIZE = new pf__string_capitalize();
/*     */   
/*     */   private static final class pf__string_capitalize extends Primitive { pf__string_capitalize() {
/* 550 */       super("%string-capitalize", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 559 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 560 */       char[] array = new char[indicesAndChars.array1.length];
/* 561 */       boolean lastCharWasAlphanumeric = false;
/* 562 */       System.arraycopy(indicesAndChars.array1, 0, array, 0, indicesAndChars.start1);
/*     */ 
/*     */       
/* 565 */       int i = indicesAndChars.start1;
/* 566 */       for (; i < indicesAndChars.end1; i++) {
/* 567 */         char c = indicesAndChars.array1[i];
/* 568 */         if (Character.isLowerCase(c)) {
/* 569 */           array[i] = lastCharWasAlphanumeric ? c : 
/* 570 */             LispCharacter.toUpperCase(c);
/* 571 */           lastCharWasAlphanumeric = true;
/* 572 */         } else if (Character.isUpperCase(c)) {
/* 573 */           array[i] = lastCharWasAlphanumeric ? 
/* 574 */             LispCharacter.toLowerCase(c) : c;
/* 575 */           lastCharWasAlphanumeric = true;
/*     */         } else {
/* 577 */           array[i] = c;
/* 578 */           lastCharWasAlphanumeric = Character.isDigit(c);
/*     */         } 
/*     */       } 
/* 581 */       System.arraycopy(indicesAndChars.array1, indicesAndChars.end1, array, indicesAndChars.end1, indicesAndChars.array1.length - indicesAndChars.end1);
/*     */ 
/*     */ 
/*     */       
/* 585 */       return new SimpleString(array);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 590 */   private static final Primitive _NSTRING_UPCASE = new pf__nstring_upcase();
/*     */   
/*     */   private static final class pf__nstring_upcase extends Primitive { pf__nstring_upcase() {
/* 593 */       super("%nstring-upcase", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 602 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 603 */       AbstractString retString = indicesAndChars.string1;
/* 604 */       for (int i = indicesAndChars.start1; i < indicesAndChars.end1; i++)
/* 605 */         retString.setCharAt(i, 
/*     */             
/* 607 */             LispCharacter.toUpperCase(retString
/* 608 */               .charAt(i))); 
/* 609 */       return retString;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 614 */   private static final Primitive _NSTRING_DOWNCASE = new pf__nstring_downcase();
/*     */   
/*     */   private static final class pf__nstring_downcase extends Primitive { pf__nstring_downcase() {
/* 617 */       super("%nstring-downcase", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 626 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 627 */       AbstractString retString = indicesAndChars.string1;
/* 628 */       for (int i = indicesAndChars.start1; i < indicesAndChars.end1; i++)
/* 629 */         retString.setCharAt(i, 
/*     */             
/* 631 */             LispCharacter.toLowerCase(retString.charAt(i))); 
/* 632 */       return retString;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 637 */   private static final Primitive _NSTRING_CAPITALIZE = new pf__nstring_capitalize();
/*     */   
/*     */   private static final class pf__nstring_capitalize extends Primitive { pf__nstring_capitalize() {
/* 640 */       super("%nstring-capitalize", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject string, LispObject start, LispObject end) {
/* 649 */       StringFunctions.StringIndicesAndChars indicesAndChars = StringFunctions.stringIndicesAndChars(new LispObject[] { string, start, end });
/* 650 */       boolean lastCharWasAlphanumeric = false;
/* 651 */       AbstractString retString = indicesAndChars.string1;
/* 652 */       int i = indicesAndChars.start1;
/* 653 */       for (; i < indicesAndChars.end1; i++) {
/* 654 */         char c = retString.charAt(i);
/* 655 */         if (Character.isLowerCase(c)) {
/* 656 */           if (!lastCharWasAlphanumeric)
/* 657 */             retString.setCharAt(i, 
/* 658 */                 LispCharacter.toUpperCase(c)); 
/* 659 */           lastCharWasAlphanumeric = true;
/* 660 */         } else if (Character.isUpperCase(c)) {
/* 661 */           if (lastCharWasAlphanumeric)
/* 662 */             retString.setCharAt(i, 
/* 663 */                 LispCharacter.toLowerCase(c)); 
/* 664 */           lastCharWasAlphanumeric = true;
/*     */         } else {
/* 666 */           lastCharWasAlphanumeric = Character.isDigit(c);
/*     */         } 
/* 668 */       }  return retString;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 673 */   public static final Primitive STRINGP = new pf_stringp();
/*     */   
/*     */   private static final class pf_stringp extends Primitive { pf_stringp() {
/* 676 */       super("stringp", "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 681 */       return arg.STRINGP();
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 686 */   public static final Primitive SIMPLE_STRING_P = new pf_simple_string_p();
/*     */   
/*     */   private static final class pf_simple_string_p extends Primitive { pf_simple_string_p() {
/* 689 */       super("simple-string-p", "object");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 694 */       return arg.SIMPLE_STRING_P();
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 701 */   private static final Primitive _MAKE_STRING = new pf__make_string();
/*     */   
/*     */   private static final class pf__make_string extends Primitive { pf__make_string() {
/* 704 */       super("%make-string", Lisp.PACKAGE_SYS, false);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject size, LispObject initialElement, LispObject elementType) {
/* 712 */       int n = Fixnum.getValue(size);
/* 713 */       if (n < 0 || n >= Integer.MAX_VALUE) {
/* 714 */         StringBuilder sb = new StringBuilder();
/* 715 */         sb.append("The size specified for this string (");
/* 716 */         sb.append(n);
/* 717 */         sb.append(')');
/* 718 */         if (n >= Integer.MAX_VALUE) {
/* 719 */           sb.append(" is >= ARRAY-DIMENSION-LIMIT (");
/* 720 */           sb.append(2147483647);
/* 721 */           sb.append(").");
/*     */         } else {
/* 723 */           sb.append(" is negative.");
/* 724 */         }  return Lisp.error(new LispError(sb.toString()));
/*     */       } 
/*     */       
/* 727 */       SimpleString string = new SimpleString(n);
/* 728 */       if (initialElement != Lisp.NIL) {
/*     */         
/* 730 */         char c = Lisp.checkCharacter(initialElement).getValue();
/* 731 */         string.fill(c);
/*     */       } 
/* 733 */       return string;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 738 */   private static final Primitive CHAR = new pf_char();
/*     */   
/*     */   private static final class pf_char extends Primitive { pf_char() {
/* 741 */       super(Symbol.CHAR, "string index");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 748 */       return first.CHAR(Fixnum.getValue(second));
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 753 */   private static final Primitive SCHAR = new pf_schar();
/*     */   
/*     */   private static final class pf_schar extends Primitive { pf_schar() {
/* 756 */       super(Symbol.SCHAR, "string index");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 763 */       return first.SCHAR(Fixnum.getValue(second));
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 768 */   private static final Primitive SET_CHAR = new pf_set_char();
/*     */   
/*     */   private static final class pf_set_char extends Primitive { pf_set_char() {
/* 771 */       super(Symbol.SET_CHAR, "string index character");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 779 */       Lisp.checkString(first).setCharAt(Fixnum.getValue(second), 
/* 780 */           LispCharacter.getValue(third));
/* 781 */       return third;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 786 */   private static final Primitive SET_SCHAR = new pf_set_schar();
/*     */   
/*     */   private static final class pf_set_schar extends Primitive { pf_set_schar() {
/* 789 */       super(Symbol.SET_SCHAR, "string index character");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 797 */       if (first instanceof SimpleString) {
/* 798 */         ((SimpleString)first).setCharAt(Fixnum.getValue(second), 
/* 799 */             LispCharacter.getValue(third));
/* 800 */         return third;
/*     */       } 
/* 802 */       return Lisp.type_error(first, Symbol.SIMPLE_STRING);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 807 */   private static final Primitive STRING_POSITION = new pf_string_position();
/*     */   
/*     */   private static final class pf_string_position extends Primitive { pf_string_position() {
/* 810 */       super("string-position", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 818 */       char c = LispCharacter.getValue(first);
/* 819 */       AbstractString string = Lisp.checkString(second);
/* 820 */       int start = Fixnum.getValue(third);
/* 821 */       for (int i = start, limit = string.length(); i < limit; i++) {
/* 822 */         if (string.charAt(i) == c)
/* 823 */           return Lisp.number(i); 
/*     */       } 
/* 825 */       return Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 830 */   private static final Primitive STRING_FIND = new pf_string_find();
/*     */   
/*     */   private static final class pf_string_find extends Primitive { pf_string_find() {
/* 833 */       super("string-find", Lisp.PACKAGE_EXT, true, "char string");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 840 */       if (first instanceof LispCharacter) {
/* 841 */         char c = ((LispCharacter)first).value;
/* 842 */         AbstractString string = Lisp.checkString(second);
/* 843 */         int limit = string.length();
/* 844 */         for (int i = 0; i < limit; i++) {
/* 845 */           if (string.charAt(i) == c)
/* 846 */             return first; 
/*     */         } 
/*     */       } 
/* 849 */       return Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 855 */   private static final Primitive SIMPLE_STRING_SEARCH = new pf_simple_string_search();
/*     */   
/*     */   private static final class pf_simple_string_search extends Primitive { pf_simple_string_search() {
/* 858 */       super("simple-string-search", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 866 */       int index = second.getStringValue().indexOf(first.getStringValue());
/* 867 */       return (index >= 0) ? Fixnum.getInstance(index) : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 872 */   private static final Primitive STRING_FILL = new pf_string_fill();
/*     */   
/*     */   private static final class pf_string_fill extends Primitive { pf_string_fill() {
/* 875 */       super("simple-string-fill", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second) {
/* 882 */       if (first instanceof AbstractString) {
/* 883 */         AbstractString s = (AbstractString)first;
/* 884 */         s.fill(LispCharacter.getValue(second));
/* 885 */         return first;
/*     */       } 
/* 887 */       return Lisp.type_error(first, Symbol.SIMPLE_STRING);
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/StringFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */