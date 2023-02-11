/*    */ package org.armedbear.lisp.util;
/*    */ 
/*    */ import java.nio.charset.MalformedInputException;
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
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public class RACFMalformedInputException
/*    */   extends MalformedInputException
/*    */ {
/*    */   final int position;
/*    */   final char character;
/*    */   final String charsetName;
/*    */   
/*    */   public RACFMalformedInputException(int position, char character, String charsetName) {
/* 52 */     super(1);
/* 53 */     this.position = position;
/* 54 */     this.character = character;
/* 55 */     this.charsetName = charsetName;
/*    */   }
/*    */ 
/*    */   
/*    */   public String getMessage() {
/* 60 */     return "Input value 0x" + Integer.toHexString(this.character) + " is malformed while recoding with charset " + this.charsetName;
/*    */   }
/*    */ 
/*    */   
/*    */   public int getPosition() {
/* 65 */     return this.position;
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/util/RACFMalformedInputException.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */