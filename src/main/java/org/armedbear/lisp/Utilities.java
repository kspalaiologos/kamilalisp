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
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class Utilities
/*    */ {
/*    */   public static final boolean isPlatformUnix;
/*    */   public static final boolean isPlatformWindows;
/*    */   
/*    */   static {
/* 56 */     String osName = System.getProperty("os.name");
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */     
/* 62 */     isPlatformUnix = (osName.startsWith("Linux") || osName.startsWith("Mac OS X") || osName.startsWith("Darwin") || osName.startsWith("Solaris") || osName.startsWith("SunOS") || osName.startsWith("AIX") || osName.startsWith("FreeBSD") || osName.startsWith("OpenBSD") || osName.startsWith("NetBSD"));
/* 63 */     isPlatformWindows = osName.startsWith("Windows");
/*    */   }
/*    */ 
/*    */   
/*    */   public static boolean isFilenameAbsolute(String filename) {
/* 68 */     int length = filename.length();
/* 69 */     if (length > 0) {
/* 70 */       char c0 = filename.charAt(0);
/* 71 */       if (c0 == '\\' || c0 == '/')
/* 72 */         return true; 
/* 73 */       if (length > 2) {
/* 74 */         if (isPlatformWindows) {
/*    */           
/* 76 */           char c1 = filename.charAt(1);
/* 77 */           if (c1 == ':') {
/* 78 */             if (c0 >= 'a' && c0 <= 'z')
/* 79 */               return true; 
/* 80 */             if (c0 >= 'A' && c0 <= 'Z') {
/* 81 */               return true;
/*    */             }
/*    */           }
/*    */         
/* 85 */         } else if (filename.equals("~") || filename.startsWith("~/")) {
/* 86 */           return true;
/*    */         } 
/*    */       }
/*    */     } 
/* 90 */     return false;
/*    */   }
/*    */ 
/*    */   
/*    */   static String escapeFormat(String s) {
/* 95 */     return s.replace("~", "~~");
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Utilities.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */