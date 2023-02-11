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
/*     */ public final class ByteArrayOutputStream
/*     */   extends Stream
/*     */ {
/*     */   private final java.io.ByteArrayOutputStream byteArrayOutputStream;
/*     */   
/*     */   public ByteArrayOutputStream() {
/*  45 */     this(Lisp.UNSIGNED_BYTE_8);
/*     */   }
/*     */ 
/*     */   
/*     */   ByteArrayOutputStream(LispObject elementType) {
/*  50 */     super(Symbol.SYSTEM_STREAM);
/*  51 */     this.elementType = elementType;
/*  52 */     initAsBinaryOutputStream(this.byteArrayOutputStream = new java.io.ByteArrayOutputStream(2048));
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
/*     */   public LispObject typeOf() {
/*  64 */     return Symbol.STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  70 */     return BuiltInClass.STREAM;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/*  76 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   protected long _getFilePosition() {
/*  82 */     if (this.elementType == Lisp.NIL)
/*  83 */       return 0L; 
/*  84 */     return this.byteArrayOutputStream.size();
/*     */   }
/*     */ 
/*     */   
/*     */   public byte[] getByteArray() {
/*  89 */     if (this.elementType == Lisp.NIL) {
/*  90 */       return new byte[0];
/*     */     }
/*  92 */     return this.byteArrayOutputStream.toByteArray();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  98 */   private static final Primitive MAKE_BYTE_ARRAY_OUTPUT_STREAM = new Primitive("%make-byte-array-output-stream", Lisp.PACKAGE_SYS, false, "&optional element-type")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 105 */         return new ByteArrayOutputStream();
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg) {
/* 111 */         return new ByteArrayOutputStream(arg);
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 117 */   private static final Primitive GET_OUTPUT_STREAM_STRING = new Primitive("%get-output-stream-bytes", Lisp.PACKAGE_SYS, false, "byte-array-output-stream")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 124 */         if (arg instanceof ByteArrayOutputStream) {
/* 125 */           return JavaObject.getInstance(((ByteArrayOutputStream)arg).getByteArray());
/*     */         }
/* 127 */         return Lisp.type_error(this, Symbol.STREAM);
/*     */       }
/*     */     };
/*     */   
/* 131 */   private static final Primitive GET_OUTPUT_STREAM_ARRAY = new Primitive("%get-output-stream-array", Lisp.PACKAGE_SYS, false, "byte-array-output-stream")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 138 */         if (arg instanceof ByteArrayOutputStream) {
/* 139 */           byte[] array = ((ByteArrayOutputStream)arg).getByteArray();
/* 140 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.NIO))
/* 141 */             return new BasicVector_ByteBuffer(array, false); 
/* 142 */           if (Java.Buffers.active.equals(Java.Buffers.AllocationPolicy.PRIMITIVE_ARRAY)) {
/* 143 */             return new BasicVector_UnsignedByte8(array);
/*     */           }
/*     */         } 
/*     */         
/* 147 */         return Lisp.type_error(this, Symbol.STREAM);
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ByteArrayOutputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */