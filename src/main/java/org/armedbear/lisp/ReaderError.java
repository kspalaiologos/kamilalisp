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
/*    */ public final class ReaderError
/*    */   extends StreamError
/*    */ {
/*    */   public ReaderError(String message) {
/* 42 */     super(StandardClass.READER_ERROR);
/* 43 */     setFormatControl(message.replaceAll("~", "~~"));
/* 44 */     setFormatArguments(Lisp.NIL);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderError(String message, Stream stream) {
/* 49 */     super(StandardClass.READER_ERROR);
/* 50 */     setFormatControl(message.replaceAll("~", "~~"));
/* 51 */     setFormatArguments(Lisp.NIL);
/* 52 */     setStream(stream);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderError(String message, Stream stream, LispObject arg1, LispObject arg2) {
/* 57 */     super(StandardClass.READER_ERROR);
/* 58 */     setFormatControl(message);
/* 59 */     setFormatArguments(Lisp.list(arg1, new LispObject[] { arg2 }));
/* 60 */     setStream(stream);
/*    */   }
/*    */ 
/*    */   
/*    */   public ReaderError(LispObject initArgs) {
/* 65 */     super(StandardClass.READER_ERROR);
/* 66 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 72 */     return Symbol.READER_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 78 */     return StandardClass.READER_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 84 */     if (type == Symbol.READER_ERROR)
/* 85 */       return Lisp.T; 
/* 86 */     if (type == StandardClass.READER_ERROR)
/* 87 */       return Lisp.T; 
/* 88 */     if (type == Symbol.PARSE_ERROR)
/* 89 */       return Lisp.T; 
/* 90 */     if (type == StandardClass.PARSE_ERROR)
/* 91 */       return Lisp.T; 
/* 92 */     return super.typep(type);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public String getMessage() {
/* 98 */     return this.message;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ReaderError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */