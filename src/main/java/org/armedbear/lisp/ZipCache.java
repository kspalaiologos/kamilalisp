/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.ByteArrayInputStream;
/*     */ import java.io.ByteArrayOutputStream;
/*     */ import java.io.File;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.net.JarURLConnection;
/*     */ import java.net.MalformedURLException;
/*     */ import java.net.URL;
/*     */ import java.text.ParsePosition;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Date;
/*     */ import java.util.Enumeration;
/*     */ import java.util.HashMap;
/*     */ import java.util.Iterator;
/*     */ import java.util.LinkedHashMap;
/*     */ import java.util.Locale;
/*     */ import java.util.Map;
/*     */ import java.util.Set;
/*     */ import java.util.zip.ZipEntry;
/*     */ import java.util.zip.ZipException;
/*     */ import java.util.zip.ZipFile;
/*     */ import java.util.zip.ZipInputStream;
/*     */ import org.armedbear.lisp.util.HttpHead;
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
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public class ZipCache
/*     */ {
/*     */   public static final boolean checkZipFile(Pathname name) {
/*  75 */     InputStream input = name.getInputStream();
/*     */     try {
/*  77 */       byte[] bytes = new byte[4];
/*  78 */       int bytesRead = input.read(bytes);
/*  79 */       return (bytesRead == 4 && bytes[0] == 80 && bytes[1] == 75 && bytes[2] == 3 && bytes[3] == 4);
/*  80 */     } catch (Throwable t) {
/*     */       
/*  82 */       return false;
/*     */     } finally {
/*  84 */       if (input != null) {
/*     */         try {
/*  86 */           input.close();
/*  87 */         } catch (IOException iOException) {}
/*     */       }
/*     */     } 
/*     */   }
/*     */   
/*     */   static InputStream getInputStream(ZipFile jarFile, String entryPath) {
/*  93 */     ZipEntry entry = jarFile.getEntry(entryPath);
/*  94 */     if (entry == null) {
/*  95 */       Debug.trace("Failed to find entry '" + entryPath + "' in '" + jarFile.getName() + "'");
/*  96 */       return null;
/*     */     } 
/*  98 */     InputStream result = null;
/*     */     try {
/* 100 */       result = jarFile.getInputStream(entry);
/* 101 */     } catch (IOException e) {
/* 102 */       Debug.trace("Failed to open InputStream for '" + entryPath + "' in '" + jarFile.getName() + "'");
/* 103 */       return null;
/*     */     } 
/* 105 */     return result;
/*     */   }
/*     */   public static ZipInputStream getZipInputStream(ZipFile zipfile, String entryName) {
/* 108 */     return getZipInputStream(zipfile, entryName, false);
/*     */   }
/*     */   public static ZipInputStream getZipInputStream(ZipFile zipfile, String entryName, boolean errorOnFailure) {
/* 111 */     ZipEntry zipEntry = zipfile.getEntry(entryName);
/* 112 */     ZipInputStream stream = null;
/*     */     try {
/* 114 */       stream = new ZipInputStream(zipfile.getInputStream(zipEntry));
/* 115 */     } catch (IOException e) {
/* 116 */       if (errorOnFailure) {
/* 117 */         Lisp.simple_error("Failed to open '" + entryName + "' in zipfile '" + zipfile + "': " + e.getMessage(), new Object[0]);
/*     */       }
/* 119 */       return null;
/*     */     } 
/* 121 */     return stream;
/*     */   }
/*     */   public static ByteArrayOutputStream readEntry(ZipInputStream stream) {
/* 124 */     ByteArrayOutputStream result = new ByteArrayOutputStream();
/*     */     
/* 126 */     byte[] buf = new byte[1024]; try {
/*     */       int count;
/* 128 */       while ((count = stream.read(buf, 0, buf.length)) != -1) {
/* 129 */         result.write(buf, 0, count);
/*     */       }
/* 131 */     } catch (IOException e) {
/* 132 */       Debug.trace("Failed to read entry from " + stream + ": " + e);
/* 133 */       return null;
/*     */     } 
/* 135 */     return result;
/*     */   }
/*     */   public static ZipEntry getEntry(ZipInputStream zipInputStream, String entryName) {
/* 138 */     return getEntry(zipInputStream, entryName, false);
/*     */   }
/*     */   public static ZipEntry getEntry(ZipInputStream zipInputStream, String entryName, boolean errorOnFailure) {
/* 141 */     ZipEntry entry = null;
/*     */     do {
/*     */       try {
/* 144 */         entry = zipInputStream.getNextEntry();
/* 145 */       } catch (IOException e) {
/* 146 */         if (errorOnFailure) {
/* 147 */           Lisp.error(new FileError("Failed to seek for '" + entryName + "' in " + zipInputStream.toString()));
/*     */         }
/* 149 */         return null;
/*     */       } 
/* 151 */     } while (entry != null && !entry.getName().equals(entryName));
/* 152 */     if (entry != null) {
/* 153 */       return entry;
/*     */     }
/* 155 */     if (errorOnFailure) {
/* 156 */       Lisp.error(new FileError("Failed to find '" + entryName + "' in " + zipInputStream.toString()));
/*     */     }
/* 158 */     return null;
/*     */   }
/*     */   
/*     */   public static InputStream getEntryAsInputStream(ZipInputStream zipInputStream, String entryName) {
/* 162 */     ZipEntry entry = getEntry(zipInputStream, entryName);
/* 163 */     ByteArrayOutputStream bytes = readEntry(zipInputStream);
/* 164 */     return new ByteArrayInputStream(bytes.toByteArray());
/*     */   }
/*     */   
/*     */   public static InputStream getEntryAsInputStream(JarPathname archiveEntry) {
/* 168 */     JarPathname archiveJar = archiveEntry.getArchive();
/* 169 */     Archive archive = getArchive(archiveJar);
/* 170 */     InputStream result = archive.getEntryAsInputStream(archiveEntry);
/* 171 */     if (result == null) {
/* 172 */       Lisp.simple_error("Failed to get InputStream for ~a", new Object[] { archiveEntry });
/*     */     }
/* 174 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 184 */   static HashMap<JarPathname, Archive> cache = new HashMap<>();
/*     */   
/*     */   public static abstract class Archive {
/*     */     JarPathname root;
/* 188 */     LinkedHashMap<JarPathname, ZipEntry> entries = new LinkedHashMap<>();
/*     */     long lastModified;
/*     */     
/*     */     abstract InputStream getEntryAsInputStream(JarPathname param1JarPathname);
/*     */     
/*     */     abstract ZipEntry getEntry(JarPathname param1JarPathname);
/*     */     
/*     */     abstract void populateAllEntries();
/*     */     
/*     */     abstract void close();
/*     */     
/*     */     abstract long getLastModified(); }
/*     */   
/*     */   public static class ArchiveStream extends Archive {
/*     */     ZipInputStream source;
/*     */     ZipEntry rootEntry;
/*     */     
/*     */     public ArchiveStream(InputStream stream, JarPathname root, ZipEntry rootEntry) {
/* 206 */       if (!(stream instanceof ZipInputStream)) {
/* 207 */         this.source = new ZipInputStream(stream);
/*     */       } else {
/* 209 */         this.source = (ZipInputStream)stream;
/*     */       } 
/* 211 */       this.root = root;
/* 212 */       this.rootEntry = rootEntry;
/* 213 */       this.lastModified = rootEntry.getTime();
/*     */     }
/*     */ 
/*     */     
/* 217 */     LinkedHashMap<JarPathname, ByteArrayOutputStream> contents = new LinkedHashMap<>();
/*     */     
/*     */     boolean populated = false;
/*     */ 
/*     */     
/*     */     public InputStream getEntryAsInputStream(JarPathname entry) {
/* 223 */       if (!this.populated) {
/* 224 */         populateAllEntries();
/*     */       }
/*     */       
/* 227 */       entry.setVersion(Keyword.NEWEST);
/* 228 */       ByteArrayOutputStream bytes = this.contents.get(entry);
/* 229 */       if (bytes != null) {
/* 230 */         return new ByteArrayInputStream(bytes.toByteArray());
/*     */       }
/* 232 */       return null;
/*     */     }
/*     */     
/*     */     public ZipEntry getEntry(JarPathname entry) {
/* 236 */       if (!this.populated) {
/* 237 */         populateAllEntries();
/*     */       }
/* 239 */       entry.setVersion(Keyword.NEWEST);
/* 240 */       ZipEntry result = this.entries.get(entry);
/* 241 */       return result;
/*     */     }
/*     */     
/*     */     void populateAllEntries() {
/* 245 */       if (this.populated) {
/*     */         return;
/*     */       }
/*     */       try {
/*     */         ZipEntry entry;
/* 250 */         while ((entry = this.source.getNextEntry()) != null) {
/* 251 */           String name = entry.getName();
/*     */           
/* 253 */           JarPathname entryPathname = JarPathname.createEntryFromJar(this.root, name);
/* 254 */           this.entries.put(entryPathname, entry);
/*     */           
/* 256 */           ByteArrayOutputStream bytes = ZipCache.readEntry(this.source);
/* 257 */           this.contents.put(entryPathname, bytes);
/*     */         } 
/* 259 */         this.populated = true;
/* 260 */       } catch (IOException e) {
/* 261 */         Lisp.simple_error("Failed to read entries from zip archive", new Object[] { this.root });
/*     */       } 
/*     */     }
/*     */     
/*     */     void close() {
/* 266 */       if (this.source != null) {
/*     */         try {
/* 268 */           this.source.close();
/* 269 */         } catch (IOException iOException) {}
/*     */       }
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     long getLastModified() {
/* 276 */       return ((URLPathname)this.root.getRootJar()).getLastModified();
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   public static class ArchiveURL
/*     */     extends ArchiveFile
/*     */   {
/*     */     JarURLConnection connection;
/*     */ 
/*     */     
/*     */     public ArchiveURL(JarPathname jar) throws IOException {
/* 288 */       String rootJarURLString = jar.getRootJarAsURLString();
/* 289 */       URL rootJarURL = new URL(rootJarURLString);
/*     */       
/* 291 */       JarURLConnection jarConnection = (JarURLConnection)rootJarURL.openConnection();
/*     */       
/* 293 */       this.root = jar;
/* 294 */       this.connection = jarConnection;
/* 295 */       this.file = this.connection.getJarFile();
/* 296 */       this.lastModified = this.connection.getLastModified();
/*     */     }
/*     */     
/*     */     void close() {
/* 300 */       super.close();
/*     */     }
/*     */   }
/*     */   
/*     */   public static class ArchiveFile
/*     */     extends Archive
/*     */   {
/*     */     ZipFile file;
/*     */     
/*     */     ZipFile get() {
/* 310 */       return this.file;
/*     */     }
/*     */ 
/*     */     
/*     */     ArchiveFile() {}
/*     */     
/*     */     public ArchiveFile(JarPathname jar) throws ZipException, IOException {
/* 317 */       File f = ((Pathname)jar.getRootJar()).getFile();
/* 318 */       this.root = jar;
/* 319 */       this.file = new ZipFile(f);
/* 320 */       this.lastModified = f.lastModified();
/*     */     }
/*     */     
/*     */     long getLastModified() {
/* 324 */       long result = 0L;
/*     */       
/* 326 */       File f = ((Pathname)this.root.getRootJar()).getFile();
/* 327 */       if (f != null) {
/* 328 */         result = f.lastModified();
/*     */       }
/* 330 */       return result;
/*     */     }
/*     */     
/*     */     public ZipEntry getEntry(JarPathname entryPathname) {
/* 334 */       entryPathname.setVersion(Keyword.NEWEST);
/* 335 */       ZipEntry result = this.entries.get(entryPathname);
/* 336 */       if (result != null) {
/* 337 */         return result;
/*     */       }
/* 339 */       String entryPath = entryPathname.asEntryPath();
/* 340 */       result = this.file.getEntry(entryPath);
/*     */       
/* 342 */       if (result == null) {
/* 343 */         return null;
/*     */       }
/*     */ 
/*     */ 
/*     */       
/* 348 */       if (result.isDirectory() && (
/* 349 */         !entryPathname.getName().equals(Lisp.NIL) || 
/* 350 */         !entryPathname.getType().equals(Lisp.NIL))) {
/* 351 */         return null;
/*     */       }
/*     */       
/* 354 */       this.entries.put(entryPathname, result);
/* 355 */       return result;
/*     */     }
/*     */     
/*     */     void populateAllEntries() {
/* 359 */       ZipFile f = this.file;
/* 360 */       if (f.size() == this.entries.size()) {
/*     */         return;
/*     */       }
/*     */       
/* 364 */       Enumeration<? extends ZipEntry> e = f.entries();
/* 365 */       while (e.hasMoreElements()) {
/* 366 */         ZipEntry entry = e.nextElement();
/* 367 */         String name = entry.getName();
/*     */         
/* 369 */         JarPathname entryPathname = JarPathname.createEntryFromJar(this.root, name);
/* 370 */         this.entries.put(entryPathname, entry);
/*     */       } 
/*     */     }
/*     */     
/*     */     InputStream getEntryAsInputStream(JarPathname entry) {
/* 375 */       InputStream result = null;
/* 376 */       entry.setVersion(Keyword.NEWEST);
/* 377 */       ZipEntry zipEntry = getEntry(entry);
/*     */       
/*     */       try {
/* 380 */         result = this.file.getInputStream(zipEntry);
/* 381 */       } catch (IOException iOException) {}
/*     */       
/* 383 */       return result;
/*     */     }
/*     */     void close() {
/* 386 */       if (this.file != null) {
/*     */         try {
/* 388 */           this.file.close();
/* 389 */         } catch (IOException iOException) {}
/*     */       }
/*     */     }
/*     */   }
/*     */   
/*     */   static boolean cacheEnabled = true;
/*     */   
/* 396 */   private static final Primitive DISABLE_ZIP_CACHE = new disable_zip_cache();
/*     */   
/*     */   static final class disable_zip_cache extends Primitive { disable_zip_cache() {
/* 399 */       super("disable-zip-cache", Lisp.PACKAGE_SYS, true, "", "Not currently implemented");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute() {
/* 404 */       return Lisp.NIL;
/*     */     } }
/*     */   
/*     */   public static synchronized void disable() {
/* 408 */     cacheEnabled = false;
/* 409 */     cache.clear();
/*     */   }
/*     */   
/*     */   public static synchronized LinkedHashMap<JarPathname, ZipEntry> getEntries(JarPathname jar) {
/* 413 */     Archive archive = getArchive(jar);
/* 414 */     archive.populateAllEntries();
/* 415 */     return archive.entries;
/*     */   }
/*     */   
/*     */   public static synchronized Iterator<Map.Entry<JarPathname, ZipEntry>> getEntriesIterator(JarPathname jar) {
/* 419 */     LinkedHashMap<JarPathname, ZipEntry> entries = getEntries(jar);
/* 420 */     Set<Map.Entry<JarPathname, ZipEntry>> set = entries.entrySet();
/* 421 */     return set.iterator();
/*     */   }
/*     */   
/*     */   static ZipEntry getZipEntry(JarPathname archiveEntry) {
/* 425 */     JarPathname archiveJar = archiveEntry.getArchive();
/* 426 */     Archive zip = getArchive(archiveJar);
/* 427 */     ZipEntry entry = zip.getEntry(archiveEntry);
/* 428 */     return entry;
/*     */   }
/*     */ 
/*     */   
/*     */   public static synchronized Archive getArchive(JarPathname jar) {
/* 433 */     jar.setVersion(Keyword.NEWEST);
/* 434 */     Archive result = cache.get(jar);
/* 435 */     if (result != null) {
/* 436 */       long time = result.getLastModified();
/* 437 */       if (time != result.lastModified) {
/* 438 */         cache.remove(jar);
/* 439 */         return getArchive(jar);
/*     */       } 
/* 441 */       return result;
/*     */     } 
/* 443 */     Pathname rootJar = (Pathname)jar.getRootJar();
/* 444 */     LispObject innerJars = jar.getJars().cdr();
/*     */     
/* 446 */     if (!rootJar.isLocalFile()) {
/* 447 */       return getArchiveURL(jar);
/*     */     }
/*     */     
/* 450 */     if (innerJars.equals(Lisp.NIL)) {
/* 451 */       return getArchiveFile(jar);
/*     */     }
/*     */     
/* 454 */     result = getArchiveStreamFromFile(jar);
/* 455 */     cache.put(result.root, result);
/*     */     
/* 457 */     JarPathname nextArchive = new JarPathname();
/* 458 */     nextArchive
/* 459 */       .setDevice(new Cons(rootJar, new Cons(innerJars
/* 460 */             .car(), Lisp.NIL)))
/* 461 */       .setDirectory(Lisp.NIL)
/* 462 */       .setName(Lisp.NIL)
/* 463 */       .setType(Lisp.NIL)
/* 464 */       .setVersion(Keyword.NEWEST);
/*     */     
/* 466 */     innerJars = innerJars.cdr();
/* 467 */     while (innerJars.car() != Lisp.NIL) {
/* 468 */       Pathname nextJarArchive = (Pathname)innerJars.car();
/*     */       
/* 470 */       JarPathname nextAsEntry = new JarPathname();
/* 471 */       nextAsEntry
/* 472 */         .setDevice(nextArchive.getDevice())
/* 473 */         .setDirectory(nextJarArchive.getDirectory())
/* 474 */         .setName(nextJarArchive.getName())
/* 475 */         .setType(nextJarArchive.getType())
/* 476 */         .setVersion(Keyword.NEWEST);
/*     */ 
/*     */ 
/*     */       
/* 480 */       LispObject directories = nextAsEntry.getDirectory();
/* 481 */       if (!directories.equals(Lisp.NIL) && directories
/* 482 */         .car().equals(Keyword.RELATIVE)) {
/* 483 */         directories = directories.cdr().push(Keyword.ABSOLUTE);
/* 484 */         nextAsEntry.setDirectory(directories);
/*     */       } 
/*     */       
/* 487 */       nextArchive.setDevice(nextArchive.getDevice().reverse().push(nextJarArchive).reverse());
/* 488 */       ArchiveStream stream = (ArchiveStream)result;
/*     */       
/* 490 */       ZipEntry entry = stream.getEntry(nextAsEntry);
/* 491 */       if (entry == null) {
/* 492 */         return null;
/*     */       }
/*     */       
/* 495 */       InputStream inputStream = stream.getEntryAsInputStream(nextAsEntry);
/* 496 */       if (inputStream == null) {
/* 497 */         return null;
/*     */       }
/* 499 */       stream = new ArchiveStream(inputStream, nextArchive, entry);
/* 500 */       result = stream;
/* 501 */       cache.put(nextArchive, result);
/*     */       
/* 503 */       innerJars = innerJars.cdr();
/* 504 */       if (innerJars.cdr().equals(Lisp.NIL) && 
/* 505 */         !jar.getDirectory().equals(Lisp.NIL) && jar
/* 506 */         .getName().equals(Lisp.NIL) && jar
/* 507 */         .getType().equals(Lisp.NIL)) {
/* 508 */         Lisp.simple_error("Currently unimplemented retrieval of an entry in a nested pathnames", new Object[0]);
/* 509 */         return (Archive)Lisp.UNREACHED;
/*     */       } 
/*     */     } 
/* 512 */     return result;
/*     */   }
/*     */   
/*     */   static ArchiveStream getArchiveStreamFromFile(JarPathname p) {
/* 516 */     JarPathname innerArchiveAsEntry = JarPathname.archiveAsEntry(p);
/* 517 */     JarPathname root = new JarPathname();
/* 518 */     root = (JarPathname)root.copyFrom(innerArchiveAsEntry);
/* 519 */     root
/* 520 */       .setDirectory(Lisp.NIL)
/* 521 */       .setName(Lisp.NIL)
/* 522 */       .setType(Lisp.NIL)
/* 523 */       .setVersion(Keyword.NEWEST);
/*     */     
/* 525 */     ArchiveFile rootArchiveFile = (ArchiveFile)getArchiveFile(root);
/* 526 */     ZipEntry entry = rootArchiveFile.getEntry(innerArchiveAsEntry);
/* 527 */     if (entry == null) {
/* 528 */       return null;
/*     */     }
/* 530 */     InputStream inputStream = rootArchiveFile.getEntryAsInputStream(innerArchiveAsEntry);
/* 531 */     if (inputStream == null) {
/* 532 */       return null;
/*     */     }
/* 534 */     ArchiveStream result = new ArchiveStream(inputStream, p, entry);
/* 535 */     return result;
/*     */   }
/*     */   
/*     */   public static Archive getArchiveURL(JarPathname jar) {
/* 539 */     Pathname rootJar = (Pathname)jar.getRootJar();
/* 540 */     jar.setVersion(Keyword.NEWEST);
/*     */     
/* 542 */     URL rootJarURL = null;
/*     */     try {
/* 544 */       ArchiveURL result = new ArchiveURL(jar);
/* 545 */       cache.put(jar, result);
/* 546 */       return result;
/* 547 */     } catch (MalformedURLException e) {
/* 548 */       Lisp.simple_error("Failed to form root URL for ~a", new Object[] { jar });
/* 549 */       return (Archive)Lisp.UNREACHED;
/* 550 */     } catch (IOException e) {
/* 551 */       Lisp.simple_error("Failed to fetch ~a: ~a", new Object[] { jar, e });
/* 552 */       return (Archive)Lisp.UNREACHED;
/*     */     } 
/*     */   }
/*     */   
/*     */   public static Archive getArchiveFile(JarPathname jar) {
/* 557 */     jar.setVersion(Keyword.NEWEST);
/*     */     try {
/* 559 */       ArchiveFile result = new ArchiveFile(jar);
/* 560 */       cache.put(jar, result);
/* 561 */       return result;
/* 562 */     } catch (ZipException e) {
/* 563 */       Lisp.error(new FileError("Failed to open local zip archive because " + e, jar));
/*     */ 
/*     */       
/* 566 */       return (Archive)Lisp.UNREACHED;
/* 567 */     } catch (IOException e) {
/* 568 */       Lisp.error(new FileError("Failed to open local zip archive because " + e, jar));
/*     */       
/* 570 */       return (Archive)Lisp.UNREACHED;
/*     */     } 
/*     */   }
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
/*     */   static void checkRemoteLastModified(ArchiveURL archive) {
/* 584 */     String dateString = null;
/*     */     
/* 586 */     String url = archive.root.getRootJarAsURLString();
/*     */     
/*     */     try {
/* 589 */       dateString = HttpHead.get(url, "Last-Modified");
/* 590 */     } catch (IOException ex) {
/* 591 */       Debug.trace(ex);
/*     */     } 
/* 593 */     Date date = null;
/* 594 */     ParsePosition pos = new ParsePosition(0);
/*     */     
/* 596 */     SimpleDateFormat ASCTIME = new SimpleDateFormat("EEE MMM d HH:mm:ss yyyy", Locale.US);
/*     */     
/* 598 */     SimpleDateFormat RFC_1036 = new SimpleDateFormat("EEEE, dd-MMM-yy HH:mm:ss zzz", Locale.US);
/*     */     
/* 600 */     SimpleDateFormat RFC_1123 = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", Locale.US);
/*     */ 
/*     */     
/* 603 */     if (dateString != null) {
/* 604 */       date = RFC_1123.parse(dateString, pos);
/* 605 */       if (date == null) {
/* 606 */         date = RFC_1036.parse(dateString, pos);
/* 607 */         if (date == null) {
/* 608 */           date = ASCTIME.parse(dateString, pos);
/*     */         }
/*     */       } 
/*     */     } 
/*     */ 
/*     */     
/* 614 */     if (date == null || date.getTime() > archive.lastModified) {
/* 615 */       JarPathname root = archive.root;
/* 616 */       Archive entry = getArchiveURL(root);
/* 617 */       cache.put(root, entry);
/*     */     } 
/* 619 */     if (date == null) {
/* 620 */       if (dateString == null) {
/* 621 */         Debug.trace("Failed to retrieve request header: " + url
/* 622 */             .toString());
/*     */       } else {
/* 624 */         Debug.trace("Failed to parse Last-Modified date: " + dateString);
/*     */       } 
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 631 */   private static final Primitive CLEAR_ZIP_CACHE = new clear_zip_cache();
/*     */   
/*     */   private static class clear_zip_cache extends Primitive { clear_zip_cache() {
/* 634 */       super("clear-zip-cache", Lisp.PACKAGE_SYS, true);
/*     */     }
/*     */     
/*     */     public LispObject execute() {
/* 638 */       int size = ZipCache.cache.size();
/* 639 */       ZipCache.cache.clear();
/* 640 */       return (size == 0) ? Lisp.NIL : Lisp.T;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 645 */   private static final Primitive REMOVE_ZIP_CACHE_ENTRY = new remove_zip_cache_entry();
/*     */   
/*     */   private static class remove_zip_cache_entry extends Primitive { remove_zip_cache_entry() {
/* 648 */       super("remove-zip-cache-entry", Lisp.PACKAGE_SYS, true, "pathname");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 652 */       Pathname p = Lisp.coerceToPathname(arg);
/* 653 */       boolean result = false;
/* 654 */       if (p instanceof JarPathname) {
/* 655 */         result = ZipCache.remove((JarPathname)p);
/*     */       }
/* 657 */       return result ? Lisp.T : Lisp.NIL;
/*     */     } }
/*     */ 
/*     */   
/*     */   public static synchronized boolean remove(Pathname pathname) {
/* 662 */     JarPathname p = JarPathname.createFromPathname(pathname);
/* 663 */     return remove(p);
/*     */   }
/*     */   
/*     */   public static synchronized boolean remove(JarPathname p) {
/* 667 */     p.setVersion(Keyword.NEWEST);
/* 668 */     Archive archive = cache.get(p);
/* 669 */     if (archive != null) {
/* 670 */       archive.close();
/* 671 */       cache.remove(p);
/* 672 */       return true;
/*     */     } 
/* 674 */     return false;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ZipCache.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */