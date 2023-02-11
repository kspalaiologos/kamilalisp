/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class ByteArrayInputStream
/*    */   extends Stream
/*    */ {
/*    */   private final java.io.ByteArrayInputStream byteArrayInputStream;
/*    */   
/*    */   public ByteArrayInputStream(byte[] bytes) {
/* 44 */     this(bytes, Lisp.UNSIGNED_BYTE_8);
/*    */   }
/*    */ 
/*    */   
/*    */   ByteArrayInputStream(byte[] bytes, LispObject elementType) {
/* 49 */     super(Symbol.SYSTEM_STREAM);
/* 50 */     this.elementType = elementType;
/* 51 */     initAsBinaryInputStream(this.byteArrayInputStream = new java.io.ByteArrayInputStream(bytes));
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 57 */     return Symbol.STREAM;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 63 */     return BuiltInClass.STREAM;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 69 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/* 74 */   private static final Primitive MAKE_BYTE_ARRAY_INPUT_STREAM = new Primitive("%make-byte-array-input-stream", Lisp.PACKAGE_SYS, false, "bytes &optional element-type")
/*    */     {
/*    */ 
/*    */ 
/*    */       
/*    */       public LispObject execute(LispObject bytes)
/*    */       {
/* 81 */         return new ByteArrayInputStream((byte[])bytes.javaInstance(byte[].class));
/*    */       }
/*    */ 
/*    */ 
/*    */       
/*    */       public LispObject execute(LispObject bytes, LispObject elementType) {
/* 87 */         return new ByteArrayInputStream((byte[])bytes.javaInstance(byte[].class), elementType);
/*    */       }
/*    */     };
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ByteArrayInputStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */