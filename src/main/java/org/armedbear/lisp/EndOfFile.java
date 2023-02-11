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
/*    */ public final class EndOfFile
/*    */   extends StreamError
/*    */ {
/*    */   public EndOfFile(Stream stream) {
/* 42 */     super(StandardClass.END_OF_FILE);
/* 43 */     setStream(stream);
/*    */   }
/*    */ 
/*    */   
/*    */   public EndOfFile(LispObject initArgs) {
/* 48 */     super(StandardClass.END_OF_FILE);
/* 49 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 55 */     return Symbol.END_OF_FILE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 61 */     return StandardClass.END_OF_FILE;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 67 */     if (type == Symbol.END_OF_FILE)
/* 68 */       return Lisp.T; 
/* 69 */     if (type == StandardClass.END_OF_FILE)
/* 70 */       return Lisp.T; 
/* 71 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/EndOfFile.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */