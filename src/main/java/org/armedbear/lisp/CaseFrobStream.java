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
/*     */ public abstract class CaseFrobStream
/*     */   extends Stream
/*     */ {
/*     */   protected final Stream target;
/*     */   
/*     */   protected CaseFrobStream(Stream target) {
/*  45 */     super(Symbol.CASE_FROB_STREAM);
/*  46 */     Debug.assertTrue(target.isCharacterOutputStream());
/*  47 */     this.target = target;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getElementType() {
/*  53 */     return this.target.getElementType();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  59 */     return Symbol.CASE_FROB_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  65 */     return BuiltInClass.CASE_FROB_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  71 */     if (type == Symbol.CASE_FROB_STREAM)
/*  72 */       return Lisp.T; 
/*  73 */     if (type == BuiltInClass.CASE_FROB_STREAM)
/*  74 */       return Lisp.T; 
/*  75 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isInputStream() {
/*  81 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isOutputStream() {
/*  87 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterInputStream() {
/*  93 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryInputStream() {
/*  99 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isCharacterOutputStream() {
/* 105 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public boolean isBinaryOutputStream() {
/* 111 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public int getCharPos() {
/* 117 */     return this.target.getCharPos();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void setCharPos(int n) {
/* 123 */     this.target.setCharPos(n);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   protected int _readChar() {
/* 130 */     notSupported();
/*     */     
/* 132 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected void _unreadChar(int n) {
/* 138 */     notSupported();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() {
/* 144 */     notSupported();
/*     */     
/* 146 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeChars(char[] chars, int start, int end) {
/* 153 */     _writeString(new String(chars, start, end));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public int _readByte() {
/* 160 */     notSupported();
/*     */     
/* 162 */     return -1;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void _writeByte(int n) {
/* 169 */     notSupported();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _finishOutput() {
/* 175 */     this.target._finishOutput();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/* 181 */     notSupported();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject close(LispObject abort) {
/* 187 */     setOpen(false);
/* 188 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject listen() {
/* 194 */     notSupported();
/*     */     
/* 196 */     return Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject terpri() {
/* 202 */     return this.target.terpri();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject freshLine() {
/* 208 */     return this.target.freshLine();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 214 */     return unreadableString("CASE-FROB-STREAM");
/*     */   }
/*     */ 
/*     */   
/*     */   private void notSupported() {
/* 219 */     Lisp.error(new TypeError("Operation is not supported for streams of type CASE-FROB-STREAM."));
/*     */   }
/*     */ 
/*     */   
/* 223 */   private static final Primitive MAKE_CASE_FROB_STREAM = new Primitive("make-case-frob-stream", Lisp.PACKAGE_SYS, false, "target kind")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject first, LispObject second)
/*     */       {
/* 230 */         Stream target = Lisp.checkCharacterOutputStream(first);
/* 231 */         if (second == Keyword.UPCASE)
/* 232 */           return new UpcaseStream(target); 
/* 233 */         if (second == Keyword.DOWNCASE)
/* 234 */           return new DowncaseStream(target); 
/* 235 */         if (second == Keyword.CAPITALIZE)
/* 236 */           return new CapitalizeStream(target); 
/* 237 */         if (second == Keyword.CAPITALIZE_FIRST)
/* 238 */           return new CapitalizeFirstStream(target); 
/* 239 */         return Lisp.error(new TypeError("Kind must be :UPCASE, :DOWNCASE, :CAPITALIZE or :CAPITALIZE-FIRST."));
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CaseFrobStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */