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
/*    */ public final class CapitalizeStream
/*    */   extends CaseFrobStream
/*    */ {
/*    */   private boolean inWord;
/*    */   
/*    */   public CapitalizeStream(Stream target) {
/* 42 */     super(target);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeChar(char c) {
/* 48 */     if (this.inWord) {
/* 49 */       if (Character.isUpperCase(c)) {
/* 50 */         c = LispCharacter.toLowerCase(c);
/* 51 */       } else if (!Character.isLowerCase(c) && !Character.isDigit(c)) {
/* 52 */         this.inWord = false;
/*    */       }
/*    */     
/*    */     }
/* 56 */     else if (Character.isUpperCase(c)) {
/* 57 */       this.inWord = true;
/* 58 */     } else if (Character.isLowerCase(c)) {
/* 59 */       c = LispCharacter.toUpperCase(c);
/* 60 */       this.inWord = true;
/* 61 */     } else if (Character.isDigit(c)) {
/* 62 */       this.inWord = true;
/*    */     } 
/*    */     
/* 65 */     this.target._writeChar(c);
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public void _writeString(String s) {
/* 71 */     int limit = s.length();
/* 72 */     for (int i = 0; i < limit; i++) {
/* 73 */       _writeChar(s.charAt(i));
/*    */     }
/*    */   }
/*    */ 
/*    */   
/*    */   public void _writeLine(String s) {
/* 79 */     this.target._writeString(s);
/* 80 */     this.target._writeChar('\n');
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CapitalizeStream.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */