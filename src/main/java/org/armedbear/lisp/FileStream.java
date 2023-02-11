/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.FileNotFoundException;
/*     */ import java.io.IOException;
/*     */ import java.io.RandomAccessFile;
/*     */ import org.armedbear.lisp.util.RandomAccessCharacterFile;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class FileStream
/*     */   extends Stream
/*     */ {
/*     */   private final RandomAccessCharacterFile racf;
/*     */   private final Pathname pathname;
/*     */   private final int bytesPerUnit;
/*     */   
/*     */   public FileStream(Pathname pathname, LispObject elementType, LispObject direction, LispObject ifExists, LispObject format) throws IOException {
/*  73 */     super(Symbol.FILE_STREAM);
/*  74 */     File file = pathname.getFile();
/*  75 */     String mode = null;
/*  76 */     if (direction == Keyword.INPUT) {
/*  77 */       mode = "r";
/*  78 */       this.isInputStream = true;
/*  79 */     } else if (direction == Keyword.OUTPUT) {
/*  80 */       mode = "rw";
/*  81 */       this.isOutputStream = true;
/*  82 */     } else if (direction == Keyword.IO) {
/*  83 */       mode = "rw";
/*  84 */       this.isInputStream = true;
/*  85 */       this.isOutputStream = true;
/*     */     } 
/*     */     
/*  88 */     Debug.assertTrue((mode != null));
/*  89 */     RandomAccessFile raf = new RandomAccessFile(file, mode);
/*     */ 
/*     */     
/*  92 */     if (this.isOutputStream) {
/*  93 */       long length = file.isFile() ? file.length() : 0L;
/*  94 */       if (length > 0L)
/*  95 */         if (ifExists == Keyword.OVERWRITE) {
/*  96 */           raf.seek(0L);
/*  97 */         } else if (ifExists == Keyword.APPEND) {
/*  98 */           raf.seek(raf.length());
/*     */         } else {
/* 100 */           raf.setLength(0L);
/*     */         }  
/*     */     } 
/* 103 */     setExternalFormat(format);
/*     */ 
/*     */ 
/*     */     
/* 107 */     this.racf = new RandomAccessCharacterFile(raf, this.encoding);
/*     */     
/* 109 */     this.pathname = pathname;
/* 110 */     this.elementType = elementType;
/* 111 */     if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
/* 112 */       this.isCharacterStream = true;
/* 113 */       this.bytesPerUnit = 1;
/* 114 */       if (this.isInputStream) {
/* 115 */         initAsCharacterInputStream(this.racf.getReader());
/*     */       }
/* 117 */       if (this.isOutputStream) {
/* 118 */         initAsCharacterOutputStream(this.racf.getWriter());
/*     */       }
/*     */     } else {
/* 121 */       this.isBinaryStream = true;
/* 122 */       int width = Fixnum.getValue(elementType.cadr());
/* 123 */       this.bytesPerUnit = width / 8;
/* 124 */       if (this.isInputStream) {
/* 125 */         initAsBinaryInputStream(this.racf.getInputStream());
/*     */       }
/* 127 */       if (this.isOutputStream) {
/* 128 */         initAsBinaryOutputStream(this.racf.getOutputStream());
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 136 */     return Symbol.FILE_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 142 */     return BuiltInClass.FILE_STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject typeSpecifier) {
/* 148 */     if (typeSpecifier == Symbol.FILE_STREAM)
/* 149 */       return Lisp.T; 
/* 150 */     if (typeSpecifier == BuiltInClass.FILE_STREAM)
/* 151 */       return Lisp.T; 
/* 152 */     return super.typep(typeSpecifier);
/*     */   }
/*     */ 
/*     */   
/*     */   public void setExternalFormat(LispObject format) {
/* 157 */     super.setExternalFormat(format);
/*     */     
/* 159 */     if (this.racf != null)
/*     */     {
/* 161 */       this.racf.setEncoding(this.encoding);
/*     */     }
/*     */   }
/*     */   
/*     */   public Pathname getPathname() {
/* 166 */     return this.pathname;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject fileLength() {
/*     */     long length;
/* 173 */     if (isOpen()) {
/*     */       try {
/* 175 */         length = this.racf.length();
/*     */       }
/* 177 */       catch (IOException e) {
/* 178 */         Lisp.error(new StreamError(this, e));
/*     */         
/* 180 */         return Lisp.NIL;
/*     */       } 
/*     */     } else {
/* 183 */       String namestring = this.pathname.getNamestring();
/* 184 */       if (namestring == null)
/* 185 */         return Lisp.error(new SimpleError("Pathname has no namestring: " + this.pathname
/* 186 */               .princToString())); 
/* 187 */       File file = new File(namestring);
/* 188 */       length = file.length();
/*     */     } 
/* 190 */     if (this.isCharacterStream) {
/* 191 */       return Lisp.number(length);
/*     */     }
/*     */     
/* 194 */     return Lisp.number(length / this.bytesPerUnit);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _charReady() {
/* 200 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _clearInput() {
/*     */     try {
/* 207 */       if (this.isInputStream) {
/* 208 */         this.racf.position(this.racf.length());
/*     */       } else {
/* 210 */         streamNotInputStream();
/*     */       }
/*     */     
/* 213 */     } catch (IOException e) {
/* 214 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/*     */     try {
/* 222 */       long pos = this.racf.position();
/* 223 */       return pos / this.bytesPerUnit;
/*     */     }
/* 225 */     catch (IOException e) {
/* 226 */       Lisp.error(new StreamError(this, e));
/*     */       
/* 228 */       return -1L;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected boolean _setFilePosition(LispObject arg) {
/*     */     try {
/* 236 */       long pos = 0L;
/* 237 */       if (arg == Keyword.START) {
/* 238 */         pos = 0L;
/* 239 */       } else if (arg == Keyword.END) {
/* 240 */         pos = this.racf.length();
/* 241 */       } else if (arg instanceof Fixnum) {
/* 242 */         pos = (((Fixnum)arg).value * this.bytesPerUnit);
/* 243 */       } else if (arg instanceof Bignum) {
/* 244 */         pos = ((Bignum)arg).longValue() * this.bytesPerUnit;
/*     */       } else {
/* 246 */         Lisp.type_error(arg, Symbol.INTEGER);
/* 247 */       }  this.racf.position(pos);
/*     */     }
/* 249 */     catch (IOException e) {
/* 250 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/* 252 */     return true;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void _close() {
/*     */     try {
/* 259 */       this.racf.close();
/* 260 */       setOpen(false);
/*     */     }
/* 262 */     catch (IOException e) {
/* 263 */       Lisp.error(new StreamError(this, e));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 270 */     return unreadableString("FILE-STREAM");
/*     */   }
/*     */ 
/*     */   
/* 274 */   private static final Primitive MAKE_FILE_STREAM = new Primitive("make-file-stream", Lisp.PACKAGE_SYS, true, "pathname element-type direction if-exists external-format")
/*     */     {
/*     */       public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth)
/*     */       {
/*     */         Pathname pathname;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */         
/* 285 */         if (first instanceof Pathname) {
/* 286 */           pathname = (Pathname)first;
/*     */         } else {
/*     */           
/* 289 */           return Lisp.type_error(first, Symbol.PATHNAME);
/*     */         } 
/* 291 */         LispObject elementType = second;
/* 292 */         LispObject direction = third;
/* 293 */         LispObject ifExists = fourth;
/* 294 */         LispObject externalFormat = fifth;
/*     */         
/* 296 */         if (direction != Keyword.INPUT && direction != Keyword.OUTPUT && direction != Keyword.IO)
/*     */         {
/* 298 */           Lisp.error(new LispError("Direction must be :INPUT, :OUTPUT, or :IO."));
/*     */         }
/* 300 */         if (pathname.isJar()) {
/* 301 */           if (direction != Keyword.INPUT) {
/* 302 */             Lisp.error(new FileError("Only direction :INPUT is supported for jar files.", pathname));
/*     */           }
/*     */           try {
/* 305 */             return new JarStream(pathname, elementType, direction, ifExists, externalFormat);
/*     */           
/*     */           }
/* 308 */           catch (IOException e) {
/* 309 */             return Lisp.error(new StreamError(null, e));
/*     */           } 
/* 311 */         }  if (pathname instanceof URLPathname && 
/* 312 */           !URLPathname.isFile(pathname)) {
/* 313 */           if (direction != Keyword.INPUT) {
/* 314 */             Lisp.error(new FileError("Only direction :INPUT is supported for URLs.", pathname));
/*     */           }
/*     */           try {
/* 317 */             return new URLStream(pathname, elementType, direction, ifExists, externalFormat);
/*     */           
/*     */           }
/* 320 */           catch (IOException e) {
/* 321 */             return Lisp.error(new StreamError(null, e));
/*     */           } 
/*     */         } 
/*     */         try {
/* 325 */           return new FileStream(pathname, elementType, direction, ifExists, externalFormat);
/*     */ 
/*     */         
/*     */         }
/* 329 */         catch (FileNotFoundException e) {
/* 330 */           return Lisp.NIL;
/*     */         }
/* 332 */         catch (IOException e) {
/* 333 */           return Lisp.error(new StreamError(null, e));
/*     */         } 
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/FileStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */