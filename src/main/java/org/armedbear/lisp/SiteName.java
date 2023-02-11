/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.net.InetAddress;
/*    */ import java.net.UnknownHostException;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class SiteName
/*    */ {
/*    */   static LispObject getHostName() {
/*    */     InetAddress addr;
/* 45 */     String hostName = null;
/*    */     
/*    */     try {
/* 48 */       addr = InetAddress.getLocalHost();
/*    */     }
/* 50 */     catch (UnknownHostException e) {
/* 51 */       addr = null;
/*    */     } 
/* 53 */     if (addr != null) {
/* 54 */       hostName = addr.getHostName();
/*    */     }
/* 56 */     return (hostName != null) ? new SimpleString(hostName) : Lisp.NIL;
/*    */   }
/*    */   
/* 59 */   private static final Primitive MACHINE_INSTANCE = new Primitive("machine-instance")
/*    */     {
/*    */ 
/*    */       
/*    */       public LispObject execute()
/*    */       {
/* 65 */         return SiteName.getHostName();
/*    */       }
/*    */     };
/*    */   
/* 69 */   private static final Primitive LONG_SITE_NAME = new Primitive("long-site-name")
/*    */     {
/*    */ 
/*    */       
/*    */       public LispObject execute()
/*    */       {
/* 75 */         return SiteName.getHostName();
/*    */       }
/*    */     };
/*    */   
/* 79 */   private static final Primitive SHORT_SITE_NAME = new Primitive("short-site-name")
/*    */     {
/*    */ 
/*    */       
/*    */       public LispObject execute()
/*    */       {
/* 85 */         return SiteName.getHostName();
/*    */       }
/*    */     };
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SiteName.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */