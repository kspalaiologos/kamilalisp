/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.text.MessageFormat;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class lisp_implementation_version
/*    */   extends Primitive
/*    */ {
/*    */   private lisp_implementation_version() {
/* 45 */     super("lisp-implementation-version", "");
/*    */   }
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute() {
/* 55 */     String jdkVersion = MessageFormat.format("{0}-{1}-{2}", new Object[] { System.getProperty("java.vm.name"), System.getProperty("java.vm.vendor"), System.getProperty("java.runtime.version") }).replace(" ", "_");
/*    */ 
/*    */ 
/*    */ 
/*    */     
/* 60 */     String osVersion = MessageFormat.format("{0}-{1}-{2}", new Object[] { System.getProperty("os.arch"), System.getProperty("os.name"), System.getProperty("os.version") }).replace(" ", "_");
/*    */     
/* 62 */     return Primitives.VALUES.execute(new SimpleString(Version.getVersion()), new SimpleString(jdkVersion), new SimpleString(osVersion));
/*    */   }
/*    */ 
/*    */ 
/*    */   
/* 67 */   private static final lisp_implementation_version LISP_IMPLEMENTATION_VERSION = new lisp_implementation_version();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/lisp_implementation_version.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */