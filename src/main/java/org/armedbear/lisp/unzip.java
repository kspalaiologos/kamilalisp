/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.FileOutputStream;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.util.Enumeration;
/*     */ import java.util.zip.ZipEntry;
/*     */ import java.util.zip.ZipFile;
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
/*     */ @DocString(name = "unzip", args = "pathname &optional directory => unzipped_pathnames", doc = "Unpack zip archive at PATHNAME returning a list of extracted pathnames.\nIf the optional DIRECTORY is specified, root the abstraction in that directory, otherwise use the current value of *DEFAULT-PATHNAME-DEFAULTS*.")
/*     */ public final class unzip
/*     */   extends Primitive
/*     */ {
/*     */   public unzip() {
/*  52 */     super("unzip", Lisp.PACKAGE_SYS, true, "pathname &optional directory => unzipped_pathnames");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first) {
/*  58 */     Pathname zipFile = Lisp.coerceToPathname(first);
/*  59 */     Pathname directory = Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue());
/*  60 */     return unzipToDirectory(zipFile, directory);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/*  65 */     Pathname zipFile = Lisp.coerceToPathname(first);
/*  66 */     Pathname directory = Lisp.coerceToPathname(second);
/*  67 */     directory.setName(Lisp.NIL);
/*  68 */     directory.setType(Lisp.NIL);
/*  69 */     return unzipToDirectory(zipFile, directory);
/*     */   }
/*     */   
/*     */   private LispObject unzipToDirectory(Pathname zipPath, Pathname dirPath) {
/*  73 */     if (!zipPath.isAbsolute()) {
/*  74 */       zipPath = Pathname.mergePathnames(zipPath, 
/*  75 */           Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue()));
/*     */     }
/*  77 */     LispObject o = Symbol.PROBE_FILE.execute(zipPath);
/*  78 */     if (!(o instanceof Pathname)) {
/*  79 */       return Lisp.error(new FileError("No file found: " + zipPath, zipPath));
/*     */     }
/*  81 */     String zip = ((Pathname)o).getNamestring();
/*  82 */     if (zip == null) {
/*  83 */       return Lisp.error(new FileError("Pathname has no namestring: " + zip, zipPath));
/*     */     }
/*  85 */     String dir = dirPath.getNamestring();
/*  86 */     if (dir == null) {
/*  87 */       return Lisp.error(new FileError("Could not parse diretory: " + dirPath, dirPath));
/*     */     }
/*  89 */     LispObject result = Lisp.NIL;
/*     */     try {
/*  91 */       ZipFile zipfile = new ZipFile(zip);
/*     */       
/*  93 */       byte[] buffer = new byte[4096];
/*  94 */       for (Enumeration<? extends ZipEntry> entries = zipfile.entries(); entries.hasMoreElements(); ) {
/*  95 */         ZipEntry entry = entries.nextElement();
/*  96 */         String name = entry.getName();
/*  97 */         String filename = dir + name;
/*  98 */         File file = new File(filename);
/*  99 */         if (entry.isDirectory()) {
/* 100 */           file.mkdirs();
/*     */           continue;
/*     */         } 
/* 103 */         FileOutputStream out = new FileOutputStream(file);
/* 104 */         InputStream in = zipfile.getInputStream(entry);
/*     */         int n;
/* 106 */         while ((n = in.read(buffer)) > 0) {
/* 107 */           out.write(buffer, 0, n);
/*     */         }
/* 109 */         out.close();
/* 110 */         in.close();
/* 111 */         result = result.push(Pathname.create(filename));
/*     */       } 
/* 113 */     } catch (IOException e) {
/* 114 */       return Lisp.error(new FileError("Failed to unzip '" + zipPath + "' into '" + dirPath + "': " + e, zipPath));
/*     */     } 
/*     */ 
/*     */ 
/*     */     
/* 119 */     return result;
/*     */   }
/*     */   
/* 122 */   private static final Primitive unzip = new unzip();
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/unzip.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */