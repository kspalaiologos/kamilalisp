/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.BufferedReader;
/*    */ import java.io.FileInputStream;
/*    */ import java.io.IOException;
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
/*    */ 
/*    */ public final class machine_version
/*    */   extends Primitive
/*    */ {
/*    */   private machine_version() {
/* 48 */     super("machine-version");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 54 */     String osName = System.getProperty("os.name");
/* 55 */     if (osName != null && osName.toLowerCase().startsWith("linux")) {
/*    */       try {
/* 57 */         FileInputStream in = new FileInputStream("/proc/cpuinfo");
/* 58 */         if (in != null) {
/* 59 */           BufferedReader reader = new BufferedReader(new InputStreamReader(in));
/*    */           
/*    */           try {
/*    */             String s;
/* 63 */             while ((s = reader.readLine()) != null) {
/* 64 */               int start = s.indexOf("model name");
/* 65 */               if (start >= 0) {
/* 66 */                 start = s.indexOf(':', start);
/* 67 */                 if (start >= 0) {
/* 68 */                   return new SimpleString(s.substring(start + 1).trim());
/*    */                 }
/*    */               } 
/*    */             } 
/*    */           } finally {
/*    */             
/* 74 */             reader.close();
/*    */           }
/*    */         
/*    */         } 
/* 78 */       } catch (IOException iOException) {}
/*    */     }
/* 80 */     return Lisp.NIL;
/*    */   }
/*    */   
/* 83 */   private static final Primitive MACHINE_VERSION = new machine_version();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/machine_version.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */