/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.net.URL;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class Site
/*    */ {
/*    */   private static LispObject LISP_HOME;
/*    */   
/*    */   private static void init() {
/* 46 */     String s = System.getProperty("abcl.home");
/* 47 */     if (s != null) {
/* 48 */       String fileSeparator = System.getProperty("file.separator");
/* 49 */       if (!s.endsWith(fileSeparator)) {
/* 50 */         s = s + fileSeparator;
/*    */       }
/* 52 */       LISP_HOME = Pathname.create(s);
/*    */       return;
/*    */     } 
/* 55 */     URL url = Lisp.class.getResource("boot.lisp");
/* 56 */     if (url != null) {
/* 57 */       if (!Pathname.isSupportedProtocol(url.getProtocol())) {
/* 58 */         LISP_HOME = Lisp.NIL;
/*    */       } else {
/* 60 */         Pathname p = URLPathname.create(url);
/* 61 */         p.setName(Lisp.NIL).setType(Lisp.NIL);
/* 62 */         LISP_HOME = p;
/*    */       } 
/*    */       return;
/*    */     } 
/* 66 */     Lisp.simple_error("Unable to determine LISP_HOME.", new Object[0]);
/*    */   }
/*    */ 
/*    */   
/*    */   public static final LispObject getLispHome() {
/* 71 */     if (LISP_HOME == null) {
/* 72 */       init();
/*    */     }
/* 74 */     return LISP_HOME;
/*    */   }
/*    */ 
/*    */ 
/*    */   
/* 79 */   private static final Symbol _LISP_HOME_ = Lisp.exportSpecial("*LISP-HOME*", Lisp.PACKAGE_EXT, Lisp.NIL);
/*    */   
/*    */   static {
/* 82 */     LispObject p = getLispHome();
/* 83 */     if (p != null)
/* 84 */       _LISP_HOME_.setSymbolValue(p); 
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Site.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */