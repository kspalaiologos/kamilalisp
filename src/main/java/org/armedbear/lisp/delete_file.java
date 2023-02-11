/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class delete_file
/*     */   extends Primitive
/*     */ {
/*     */   private delete_file() {
/*  45 */     super("delete-file", "filespec");
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject arg) {
/*     */     File file;
/*  54 */     Pathname pathname = Lisp.coerceToPathname(arg);
/*  55 */     if (arg instanceof Stream)
/*  56 */       ((Stream)arg)._close(); 
/*  57 */     if (pathname instanceof LogicalPathname)
/*  58 */       pathname = LogicalPathname.translateLogicalPathname((LogicalPathname)pathname); 
/*  59 */     if (pathname.isWild()) {
/*  60 */       return Lisp.error(new FileError("Bad place for a wild pathname.", pathname));
/*     */     }
/*     */     
/*  63 */     Pathname defaultedPathname = Pathname.mergePathnames(pathname, 
/*  64 */         Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue()), Lisp.NIL);
/*     */ 
/*     */ 
/*     */     
/*  68 */     if (defaultedPathname.isRemote())
/*  69 */       return Lisp.error(new FileError("Unable to delete remote pathnames", defaultedPathname)); 
/*  70 */     if (defaultedPathname instanceof JarPathname) {
/*  71 */       JarPathname jar = (JarPathname)defaultedPathname;
/*  72 */       Pathname root = (Pathname)jar.getRootJar();
/*  73 */       Cons jars = (Cons)jar.getJars();
/*     */       
/*  75 */       if (jar.isArchiveEntry() || jars
/*  76 */         .length() > 1) {
/*  77 */         return Lisp.error(new FileError("Unable to delete entries within JAR-PATHNAME", jar));
/*     */       }
/*  79 */       ZipCache.remove(jar);
/*  80 */       file = root.getFile();
/*     */     } else {
/*  82 */       file = defaultedPathname.getFile();
/*     */     } 
/*     */     
/*  85 */     if (file.exists()) {
/*     */       
/*  87 */       for (int i = 0; i < 2; i++) {
/*  88 */         if (file.delete()) {
/*  89 */           return Lisp.T;
/*     */         }
/*     */         
/*  92 */         ZipCache.remove(defaultedPathname);
/*  93 */         System.gc();
/*  94 */         Thread.yield();
/*     */       } 
/*  96 */       Pathname truename = Pathname.create(file.getAbsolutePath());
/*  97 */       StringBuilder sb = new StringBuilder("Unable to delete ");
/*  98 */       sb.append(file.isDirectory() ? "directory " : "file ");
/*  99 */       sb.append(truename.princToString());
/* 100 */       sb.append('.');
/* 101 */       return Lisp.error(new FileError(sb.toString(), truename));
/*     */     } 
/*     */     
/* 104 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */   
/* 108 */   private static final Primitive DELETE_FILE = new delete_file();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/delete_file.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */