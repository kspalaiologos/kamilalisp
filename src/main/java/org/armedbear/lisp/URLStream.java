/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.InputStreamReader;
/*     */ import java.io.Reader;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class URLStream
/*     */   extends Stream
/*     */ {
/*     */   private final Pathname pathname;
/*     */   private final InputStream input;
/*     */   private final Reader reader;
/*     */   private final int bytesPerUnit;
/*     */   
/*     */   public URLStream(Pathname pathname, LispObject elementType, LispObject direction, LispObject ifExists, LispObject format) throws IOException {
/*  63 */     super(Symbol.URL_STREAM);
/*  64 */     Debug.assertTrue((direction == Keyword.INPUT));
/*  65 */     this.isInputStream = true;
/*     */     
/*  67 */     super.setExternalFormat(format);
/*     */     
/*  69 */     this.pathname = pathname;
/*  70 */     this.elementType = elementType;
/*     */     
/*  72 */     this.input = pathname.getInputStream();
/*  73 */     if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
/*  74 */       this.isCharacterStream = true;
/*  75 */       this.bytesPerUnit = 1;
/*  76 */       InputStreamReader isr = new InputStreamReader(this.input);
/*  77 */       this.reader = new BufferedReader(isr);
/*  78 */       initAsCharacterInputStream(this.reader);
/*     */     } else {
/*  80 */       this.isBinaryStream = true;
/*  81 */       int width = Fixnum.getValue(elementType.cadr());
/*  82 */       this.bytesPerUnit = width / 8;
/*  83 */       this.reader = null;
/*  84 */       initAsBinaryInputStream(this.input);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  91 */     return Symbol.URL_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  97 */     return BuiltInClass.URL_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 103 */     if (typeSpecifier == Symbol.URL_STREAM)
/* 104 */       return Lisp.T; 
/* 105 */     if (typeSpecifier == BuiltInClass.URL_STREAM)
/* 106 */       return Lisp.T; 
/* 107 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public void setExternalFormat(LispObject format) {
/* 112 */     super.setExternalFormat(format);
/*     */   }
/*     */ 
/*     */   
/*     */   public Pathname getPathname() {
/* 117 */     return this.pathname;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Reader getReader() {
/* 123 */     return this.reader;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public InputStream getInputStream() {
/* 136 */     return this.input;
/*     */   }
/*     */ 
/*     */   
/*     */   public int getBytesPerUnit() {
/* 141 */     return this.bytesPerUnit;
/*     */   }
/*     */ 
/*     */   
/*     */   public void _close() {
/*     */     try {
/* 147 */       if (this.input != null) {
/* 148 */         this.input.close();
/*     */       }
/* 150 */       if (this.reader != null) {
/* 151 */         this.reader.close();
/*     */       }
/* 153 */       setOpen(false);
/*     */     }
/* 155 */     catch (IOException e) {
/* 156 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 163 */     StringBuffer sb = new StringBuffer();
/* 164 */     sb.append(Symbol.URL_STREAM.printObject());
/* 165 */     String namestring = this.pathname.getNamestring();
/* 166 */     if (namestring != null) {
/* 167 */       sb.append(" ");
/* 168 */       sb.append(namestring);
/*     */     } 
/* 170 */     return unreadableString(sb.toString());
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/URLStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */