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
/*     */ 
/*     */ public final class FaslReadtable
/*     */   extends Readtable
/*     */ {
/*     */   protected void initialize() {
/*  46 */     Byte[] syntax = (Byte[])this.syntax.constants;
/*  47 */     syntax[9] = Byte.valueOf((byte)1);
/*  48 */     syntax[10] = Byte.valueOf((byte)1);
/*  49 */     syntax[12] = Byte.valueOf((byte)1);
/*  50 */     syntax[13] = Byte.valueOf((byte)1);
/*  51 */     syntax[32] = Byte.valueOf((byte)1);
/*     */     
/*  53 */     syntax[34] = Byte.valueOf((byte)2);
/*  54 */     syntax[39] = Byte.valueOf((byte)2);
/*  55 */     syntax[40] = Byte.valueOf((byte)2);
/*  56 */     syntax[41] = Byte.valueOf((byte)2);
/*  57 */     syntax[44] = Byte.valueOf((byte)2);
/*  58 */     syntax[59] = Byte.valueOf((byte)2);
/*  59 */     syntax[96] = Byte.valueOf((byte)2);
/*     */     
/*  61 */     syntax[35] = Byte.valueOf((byte)3);
/*     */     
/*  63 */     syntax[92] = Byte.valueOf((byte)4);
/*  64 */     syntax[124] = Byte.valueOf((byte)5);
/*     */     
/*  66 */     LispObject[] readerMacroFunctions = (LispObject[])this.readerMacroFunctions.constants;
/*  67 */     readerMacroFunctions[59] = LispReader.READ_COMMENT;
/*  68 */     readerMacroFunctions[34] = FaslReader.FASL_READ_STRING;
/*  69 */     readerMacroFunctions[40] = FaslReader.FASL_READ_LIST;
/*  70 */     readerMacroFunctions[41] = LispReader.READ_RIGHT_PAREN;
/*  71 */     readerMacroFunctions[39] = FaslReader.FASL_READ_QUOTE;
/*  72 */     readerMacroFunctions[35] = FaslReader.FASL_READ_DISPATCH_CHAR;
/*     */ 
/*     */     
/*  75 */     readerMacroFunctions[96] = Symbol.BACKQUOTE_MACRO;
/*  76 */     readerMacroFunctions[44] = Symbol.COMMA_MACRO;
/*     */     
/*  78 */     Readtable.DispatchTable dt = new Readtable.DispatchTable();
/*  79 */     LispObject[] dtfunctions = (LispObject[])dt.functions.constants;
/*  80 */     dtfunctions[40] = FaslReader.FASL_SHARP_LEFT_PAREN;
/*  81 */     dtfunctions[42] = FaslReader.FASL_SHARP_STAR;
/*  82 */     dtfunctions[46] = FaslReader.FASL_SHARP_DOT;
/*  83 */     dtfunctions[58] = FaslReader.FASL_SHARP_COLON;
/*  84 */     dtfunctions[65] = FaslReader.FASL_SHARP_A;
/*  85 */     dtfunctions[66] = FaslReader.FASL_SHARP_B;
/*  86 */     dtfunctions[67] = FaslReader.FASL_SHARP_C;
/*  87 */     dtfunctions[79] = FaslReader.FASL_SHARP_O;
/*  88 */     dtfunctions[80] = FaslReader.FASL_SHARP_P;
/*  89 */     dtfunctions[82] = FaslReader.FASL_SHARP_R;
/*  90 */     dtfunctions[83] = FaslReader.FASL_SHARP_S;
/*  91 */     dtfunctions[88] = FaslReader.FASL_SHARP_X;
/*  92 */     dtfunctions[39] = FaslReader.FASL_SHARP_QUOTE;
/*  93 */     dtfunctions[92] = FaslReader.FASL_SHARP_BACKSLASH;
/*  94 */     dtfunctions[124] = LispReader.SHARP_VERTICAL_BAR;
/*  95 */     dtfunctions[41] = LispReader.SHARP_ILLEGAL;
/*  96 */     dtfunctions[60] = LispReader.SHARP_ILLEGAL;
/*  97 */     dtfunctions[32] = LispReader.SHARP_ILLEGAL;
/*  98 */     dtfunctions[8] = LispReader.SHARP_ILLEGAL;
/*  99 */     dtfunctions[9] = LispReader.SHARP_ILLEGAL;
/* 100 */     dtfunctions[10] = LispReader.SHARP_ILLEGAL;
/* 101 */     dtfunctions[12] = LispReader.SHARP_ILLEGAL;
/* 102 */     dtfunctions[13] = LispReader.SHARP_ILLEGAL;
/* 103 */     dtfunctions[63] = FaslReader.FASL_SHARP_QUESTION_MARK;
/* 104 */     ((Readtable.DispatchTable[])this.dispatchTables.constants)[35] = dt;
/*     */     
/* 106 */     this.readtableCase = Keyword.PRESERVE;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 114 */   private static final FaslReadtable instance = new FaslReadtable();
/*     */ 
/*     */   
/*     */   public static final FaslReadtable getInstance() {
/* 118 */     return instance;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FaslReadtable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */