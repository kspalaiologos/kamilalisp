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
/*    */ public final class UpcaseStream
/*    */   extends CaseFrobStream
/*    */ {
/*    */   public UpcaseStream(Stream target) {
/* 40 */     super(target);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeChar(char c) {
/* 46 */     this.target._writeChar(LispCharacter.toUpperCase(c));
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeString(String s) {
/* 52 */     this.target._writeString(s.toUpperCase());
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeLine(String s) {
/* 58 */     this.target._writeLine(s.toUpperCase());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/UpcaseStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */