/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.BufferedReader;
/*    */ import java.io.InputStream;
/*    */ import java.io.InputStreamReader;
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
/*    */ public final class Version
/*    */ {
/*    */   static final String baseVersion = "1.9.0";
/*    */   
/*    */   static void init() {
/*    */     try {
/* 48 */       InputStream input = Version.class.getResourceAsStream("version");
/* 49 */       BufferedReader reader = new BufferedReader(new InputStreamReader(input));
/* 50 */       String v = reader.readLine().trim();
/* 51 */       version = v;
/* 52 */     } catch (Throwable t) {
/* 53 */       version = "1.9.0";
/*    */     } 
/*    */   }
/*    */   
/* 57 */   static String version = "";
/*    */   
/*    */   public static synchronized String getVersion() {
/* 60 */     if ("".equals(version)) {
/* 61 */       init();
/*    */     }
/* 63 */     return version;
/*    */   }
/*    */   
/*    */   public static void main(String[] args) {
/* 67 */     System.out.println(getVersion());
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Version.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */