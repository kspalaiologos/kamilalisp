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
/*     */ public final class JarStream
/*     */   extends Stream
/*     */ {
/*     */   private final Pathname pathname;
/*     */   private final InputStream input;
/*     */   private final Reader reader;
/*     */   private final int bytesPerUnit;
/*     */   
/*     */   public JarStream(Pathname pathname, LispObject elementType, LispObject direction, LispObject ifExists, LispObject format) throws IOException {
/*  63 */     super(Symbol.JAR_STREAM);
/*  64 */     Debug.assertTrue((direction == Keyword.INPUT));
/*  65 */     Debug.assertTrue((pathname.getName() != Lisp.NIL));
/*  66 */     this.isInputStream = true;
/*     */     
/*  68 */     super.setExternalFormat(format);
/*     */     
/*  70 */     this.pathname = pathname;
/*  71 */     this.elementType = elementType;
/*     */     
/*  73 */     this.input = pathname.getInputStream();
/*  74 */     if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
/*  75 */       this.isCharacterStream = true;
/*  76 */       this.bytesPerUnit = 1;
/*  77 */       InputStreamReader isr = new InputStreamReader(this.input);
/*  78 */       this.reader = new BufferedReader(isr);
/*  79 */       initAsCharacterInputStream(this.reader);
/*     */     } else {
/*  81 */       this.isBinaryStream = true;
/*  82 */       int width = Fixnum.getValue(elementType.cadr());
/*  83 */       this.bytesPerUnit = width / 8;
/*  84 */       this.reader = null;
/*  85 */       initAsBinaryInputStream(this.input);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  92 */     return Symbol.JAR_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  98 */     return BuiltInClass.JAR_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 104 */     if (typeSpecifier == Symbol.JAR_STREAM)
/* 105 */       return Lisp.T; 
/* 106 */     if (typeSpecifier == BuiltInClass.JAR_STREAM)
/* 107 */       return Lisp.T; 
/* 108 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public void setExternalFormat(LispObject format) {
/* 113 */     super.setExternalFormat(format);
/*     */   }
/*     */ 
/*     */   
/*     */   public Pathname getPathname() {
/* 118 */     return this.pathname;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _close() {
/*     */     try {
/* 125 */       if (this.input != null) {
/* 126 */         this.input.close();
/*     */       }
/* 128 */       if (this.reader != null) {
/* 129 */         this.reader.close();
/*     */       }
/* 131 */       setOpen(false);
/*     */     }
/* 133 */     catch (IOException e) {
/* 134 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 141 */     StringBuffer sb = new StringBuffer();
/* 142 */     sb.append(Symbol.JAR_STREAM.princToString());
/* 143 */     String namestring = this.pathname.getNamestring();
/* 144 */     if (namestring != null) {
/* 145 */       sb.append(" ");
/* 146 */       sb.append(namestring);
/*     */     } 
/* 148 */     return unreadableString(sb.toString());
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JarStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */