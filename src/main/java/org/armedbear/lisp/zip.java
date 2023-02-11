/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.FileInputStream;
/*     */ import java.io.FileNotFoundException;
/*     */ import java.io.FileOutputStream;
/*     */ import java.io.IOException;
/*     */ import java.util.HashSet;
/*     */ import java.util.Set;
/*     */ import java.util.zip.ZipEntry;
/*     */ import java.util.zip.ZipOutputStream;
/*     */ import org.armedbear.lisp.protocol.Hashtable;
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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ @DocString(name = "zip", args = "pathname pathnames &optional topdir", doc = "Creates a zip archive at PATHNAME whose entries enumerated via the list of PATHNAMES.\nIf the optional TOPDIR argument is specified, the archive will preserve the hierarchy of PATHNAMES relative to TOPDIR.  Without TOPDIR, there will be no sub-directories in the archive, i.e. it will be flat.")
/*     */ public final class zip
/*     */   extends Primitive
/*     */ {
/*     */   private zip() {
/*  59 */     super("zip", Lisp.PACKAGE_SYS, true);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second) {
/*  66 */     Pathname zipfilePathname = Lisp.coerceToPathname(first);
/*  67 */     if (second instanceof Hashtable) {
/*  68 */       return execute(zipfilePathname, (Hashtable)second);
/*     */     }
/*  70 */     byte[] buffer = new byte[4096];
/*     */     try {
/*  72 */       String zipfileNamestring = zipfilePathname.getNamestring();
/*  73 */       if (zipfileNamestring == null)
/*  74 */         return Lisp.error(new SimpleError("Pathname has no namestring: " + zipfilePathname
/*  75 */               .princToString())); 
/*  76 */       ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipfileNamestring));
/*     */       
/*  78 */       LispObject list = second;
/*  79 */       while (list != Lisp.NIL) {
/*  80 */         Pathname pathname = Lisp.coerceToPathname(list.car());
/*  81 */         String namestring = pathname.getNamestring();
/*  82 */         if (namestring == null) {
/*     */           
/*  84 */           out.close();
/*  85 */           File zipfile = new File(zipfileNamestring);
/*  86 */           zipfile.delete();
/*  87 */           return Lisp.error(new SimpleError("Pathname has no namestring: " + pathname
/*  88 */                 .princToString()));
/*     */         } 
/*  90 */         File file = new File(namestring);
/*  91 */         makeEntry(out, file);
/*  92 */         list = list.cdr();
/*     */       } 
/*  94 */       out.close();
/*     */     }
/*  96 */     catch (IOException e) {
/*  97 */       return Lisp.error(new LispError(e.getMessage()));
/*     */     } 
/*  99 */     return zipfilePathname;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 107 */     Pathname zipfilePathname = Lisp.coerceToPathname(first);
/*     */     try {
/* 109 */       String zipfileNamestring = zipfilePathname.getNamestring();
/* 110 */       if (zipfileNamestring == null)
/* 111 */         return Lisp.error(new SimpleError("Pathname has no namestring: " + zipfilePathname
/* 112 */               .princToString())); 
/* 113 */       ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipfileNamestring));
/*     */       
/* 115 */       Pathname root = (Pathname)Symbol.PROBE_FILE.execute(third);
/* 116 */       String rootPath = root.getDirectoryNamestring();
/* 117 */       int rootPathLength = rootPath.length();
/* 118 */       Set<String> directories = new HashSet<>();
/* 119 */       LispObject list = second;
/* 120 */       while (list != Lisp.NIL) {
/* 121 */         Pathname pathname = (Pathname)Symbol.PROBE_FILE.execute(list.car());
/* 122 */         String namestring = pathname.getNamestring();
/* 123 */         if (namestring == null) {
/*     */           
/* 125 */           out.close();
/* 126 */           File zipfile = new File(zipfileNamestring);
/* 127 */           zipfile.delete();
/* 128 */           return Lisp.error(new SimpleError("Pathname has no namestring: " + pathname
/* 129 */                 .princToString()));
/*     */         } 
/* 131 */         String directory = "";
/* 132 */         String dir = pathname.getDirectoryNamestring();
/* 133 */         if (dir.length() > rootPathLength) {
/* 134 */           String d = dir.substring(rootPathLength);
/* 135 */           int i = 0;
/*     */           int j;
/* 137 */           while ((j = d.indexOf('/', i)) != -1) {
/* 138 */             i = j + 1;
/* 139 */             directory = d.substring(0, j) + '/';
/* 140 */             if (!directories.contains(directory)) {
/* 141 */               directories.add(directory);
/* 142 */               ZipEntry entry = new ZipEntry(directory);
/* 143 */               out.putNextEntry(entry);
/* 144 */               out.closeEntry();
/*     */             } 
/*     */           } 
/*     */         } 
/* 148 */         File file = new File(namestring);
/* 149 */         if (file.isDirectory()) {
/* 150 */           list = list.cdr();
/*     */           continue;
/*     */         } 
/* 153 */         makeEntry(out, file, directory + file.getName());
/* 154 */         list = list.cdr();
/*     */       } 
/* 156 */       out.close();
/*     */     }
/* 158 */     catch (IOException e) {
/* 159 */       return Lisp.error(new LispError(e.getMessage()));
/*     */     } 
/* 161 */     return zipfilePathname;
/*     */   }
/*     */   
/*     */   static class Directories
/*     */     extends HashSet<String> {
/*     */     ZipOutputStream out;
/*     */     
/*     */     private Directories() {}
/*     */     
/*     */     public Directories(ZipOutputStream out) {
/* 171 */       this.out = out;
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public void ensure(String path) throws IOException {
/* 177 */       int i = 0;
/*     */       int j;
/* 179 */       while ((j = path.indexOf('/', i)) != -1) {
/* 180 */         i = j + 1;
/* 181 */         String directory = path.substring(0, j) + '/';
/* 182 */         if (!contains(directory)) {
/* 183 */           add(directory);
/* 184 */           ZipEntry entry = new ZipEntry(directory);
/* 185 */           this.out.putNextEntry(entry);
/* 186 */           this.out.closeEntry();
/*     */         } 
/*     */       } 
/*     */     }
/*     */   }
/*     */   
/*     */   public LispObject execute(Pathname zipfilePathname, Hashtable table) {
/* 193 */     LispObject entriesObject = table.getEntries();
/* 194 */     if (!(entriesObject instanceof Cons)) {
/* 195 */       return Lisp.NIL;
/*     */     }
/* 197 */     Cons entries = (Cons)entriesObject;
/*     */     
/* 199 */     String zipfileNamestring = zipfilePathname.getNamestring();
/* 200 */     if (zipfileNamestring == null)
/* 201 */       return Lisp.error(new SimpleError("Pathname has no namestring: " + zipfilePathname
/* 202 */             .princToString())); 
/* 203 */     ZipOutputStream out = null;
/*     */     try {
/* 205 */       out = new ZipOutputStream(new FileOutputStream(zipfileNamestring));
/* 206 */     } catch (FileNotFoundException e) {
/* 207 */       return Lisp.error(new FileError("Failed to create file for writing zip archive", zipfilePathname));
/*     */     } 
/* 209 */     Directories directories = new Directories(out);
/*     */ 
/*     */     
/* 212 */     for (LispObject head = entries; head != Lisp.NIL; head = head.cdr()) {
/* 213 */       LispObject key = head.car().car();
/* 214 */       LispObject value = head.car().cdr();
/*     */       
/* 216 */       Pathname source = Lisp.coerceToPathname(key);
/* 217 */       Pathname destination = Lisp.coerceToPathname(value);
/* 218 */       File file = source.getFile();
/*     */       try {
/* 220 */         String jarEntry = destination.getNamestring();
/* 221 */         if (jarEntry.startsWith("/")) {
/* 222 */           jarEntry = jarEntry.substring(1);
/*     */         }
/* 224 */         directories.ensure(jarEntry);
/* 225 */         makeEntry(out, file, jarEntry);
/* 226 */       } catch (FileNotFoundException e) {
/* 227 */         return Lisp.error(new FileError("Failed to read file for incoporation in zip archive.", source));
/* 228 */       } catch (IOException e) {
/* 229 */         return Lisp.error(new FileError("Failed to add file to zip archive.", source));
/*     */       } 
/*     */     } 
/*     */     try {
/* 233 */       out.close();
/* 234 */     } catch (IOException ex) {
/* 235 */       return Lisp.error(new FileError("Failed to close zip archive.", zipfilePathname));
/*     */     } 
/* 237 */     return zipfilePathname;
/*     */   }
/*     */   
/* 240 */   private static final Primitive zip = new zip();
/*     */ 
/*     */ 
/*     */   
/*     */   private void makeEntry(ZipOutputStream zipOutputStream, File file) throws FileNotFoundException, IOException {
/* 245 */     makeEntry(zipOutputStream, file, file.getName());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private void makeEntry(ZipOutputStream zipOutputStream, File file, String name) throws FileNotFoundException, IOException {
/* 251 */     byte[] buffer = new byte[4096];
/* 252 */     long lastModified = file.lastModified();
/* 253 */     FileInputStream in = new FileInputStream(file);
/* 254 */     ZipEntry entry = new ZipEntry(name);
/* 255 */     if (lastModified > 0L) {
/* 256 */       entry.setTime(lastModified);
/*     */     }
/* 258 */     zipOutputStream.putNextEntry(entry);
/*     */     int n;
/* 260 */     while ((n = in.read(buffer)) > 0)
/* 261 */       zipOutputStream.write(buffer, 0, n); 
/* 262 */     zipOutputStream.closeEntry();
/* 263 */     in.close();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/zip.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */