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
/*    */ public final class CapitalizeFirstStream
/*    */   extends CaseFrobStream
/*    */ {
/*    */   boolean virgin = true;
/*    */   
/*    */   public CapitalizeFirstStream(Stream target) {
/* 42 */     super(target);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeChar(char c) {
/* 48 */     if (this.virgin) {
/* 49 */       if (Character.isLetterOrDigit(c)) {
/* 50 */         c = LispCharacter.toUpperCase(c);
/* 51 */         this.virgin = false;
/*    */       } 
/*    */     } else {
/* 54 */       c = LispCharacter.toLowerCase(c);
/* 55 */     }  this.target._writeChar(c);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeString(String s) {
/* 61 */     int length = s.length();
/* 62 */     for (int i = 0; i < length; i++) {
/* 63 */       _writeChar(s.charAt(i));
/*    */     }
/*    */   }
/*    */ 
/*    */   
/*    */   public void _writeLine(String s) {
/* 69 */     _writeString(s);
/* 70 */     _writeChar('\n');
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CapitalizeFirstStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */