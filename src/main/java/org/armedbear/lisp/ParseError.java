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
/*    */ public final class ParseError
/*    */   extends LispError
/*    */ {
/*    */   public ParseError(String message) {
/* 42 */     super(StandardClass.PARSE_ERROR);
/* 43 */     setFormatControl(message.replaceAll("~", "~~"));
/* 44 */     setFormatArguments(Lisp.NIL);
/*    */   }
/*    */ 
/*    */   
/*    */   public ParseError(LispObject initArgs) {
/* 49 */     super(StandardClass.PARSE_ERROR);
/* 50 */     initialize(initArgs);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typeOf() {
/* 56 */     return Symbol.PARSE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject classOf() {
/* 62 */     return StandardClass.PARSE_ERROR;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject typep(LispObject type) {
/* 68 */     if (type == Symbol.PARSE_ERROR)
/* 69 */       return Lisp.T; 
/* 70 */     if (type == StandardClass.PARSE_ERROR)
/* 71 */       return Lisp.T; 
/* 72 */     return super.typep(type);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ParseError.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */