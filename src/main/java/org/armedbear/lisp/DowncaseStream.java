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
/*    */ public final class DowncaseStream
/*    */   extends CaseFrobStream
/*    */ {
/*    */   public DowncaseStream(Stream target) {
/* 40 */     super(target);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeChar(char c) {
/* 46 */     this.target._writeChar(LispCharacter.toLowerCase(c));
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeString(String s) {
/* 52 */     this.target._writeString(s.toLowerCase());
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeLine(String s) {
/* 58 */     this.target._writeLine(s.toLowerCase());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/DowncaseStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */