/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.InputStream;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Iterator;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import java.util.zip.ZipEntry;
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
/*     */ public class JarPathname
/*     */   extends URLPathname
/*     */ {
/*     */   public static final String JAR_URI_SUFFIX = "!/";
/*     */   public static final String JAR_URI_PREFIX = "jar:";
/*     */   
/*     */   public static JarPathname create() {
/*  61 */     return new JarPathname();
/*     */   }
/*     */   
/*     */   public static JarPathname create(JarPathname p) {
/*  65 */     JarPathname result = new JarPathname();
/*  66 */     result.copyFrom(p);
/*  67 */     return result;
/*     */   }
/*     */   
/*     */   public static JarPathname createFromPathname(Pathname p) {
/*  71 */     JarPathname result = new JarPathname();
/*  72 */     URLPathname rootDevice = new URLPathname();
/*     */     
/*  74 */     if (p instanceof URLPathname) {
/*  75 */       rootDevice.copyFrom(p);
/*  76 */     } else if (p instanceof Pathname) {
/*  77 */       rootDevice = URLPathname.create(p);
/*     */     } else {
/*  79 */       Lisp.simple_error("Argument is already a JAR-PATHNAME: ~a", new Object[] { p });
/*     */     } 
/*     */     
/*  82 */     result.setDevice(new Cons(rootDevice, Lisp.NIL));
/*     */     
/*  84 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public static JarPathname archiveAsEntry(JarPathname p) {
/*  89 */     JarPathname result = new JarPathname();
/*  90 */     result = (JarPathname)result.copyFrom(p);
/*     */     
/*  92 */     LispObject jars = result.getJars();
/*  93 */     jars = jars.nreverse();
/*  94 */     Pathname entry = (Pathname)jars.car();
/*  95 */     jars = jars.cdr().nreverse();
/*     */     
/*  97 */     result
/*  98 */       .setDevice(jars)
/*  99 */       .setDirectory(entry.getDirectory())
/* 100 */       .setName(entry.getName())
/* 101 */       .setType(entry.getType());
/*     */     
/* 103 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public static JarPathname createFromEntry(JarPathname p) {
/* 109 */     JarPathname result = new JarPathname();
/* 110 */     result
/* 111 */       .copyFrom(p)
/* 112 */       .setDirectory(Lisp.NIL)
/* 113 */       .setName(Lisp.NIL)
/* 114 */       .setType(Lisp.NIL)
/* 115 */       .setVersion(Keyword.NEWEST);
/* 116 */     Pathname entryPath = p.getEntryPath();
/* 117 */     LispObject device = result.getDevice();
/* 118 */     device = device.reverse().push(entryPath).reverse();
/* 119 */     result.setDevice(device);
/* 120 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "as-jar-pathname-archive", args = "pathname", returns = "jar-pathname", doc = "Returns PATHNAME as a reference to a JAR-PATHNAME archive\nIf PATHNAME names an ordinary file, the resulting JAR-PATHNAME addresses thefile as an archive.  If PATHNAME names an entry in an archive, the resultingJAR-PATHNAME addresses that entry as a zip archive within that archive.")
/* 131 */   private static final Primitive AS_JAR_PATHNAME_ARCHIVE = new pf_as_jar_pathname_archive();
/*     */   
/*     */   private static class pf_as_jar_pathname_archive extends Primitive { pf_as_jar_pathname_archive() {
/* 134 */       super("as-jar-pathname-archive", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 138 */       if (arg instanceof AbstractString) {
/* 139 */         arg = Lisp.coerceToPathname(arg);
/*     */       }
/* 141 */       if (arg instanceof JarPathname)
/* 142 */         return JarPathname.createFromEntry((JarPathname)arg); 
/* 143 */       if (arg instanceof Pathname) {
/* 144 */         return JarPathname.createFromPathname((Pathname)arg);
/*     */       }
/* 146 */       Lisp.type_error(arg, 
/* 147 */           Lisp.list(Symbol.OR, new LispObject[] { Symbol.PATHNAME, Symbol.URL_PATHNAME, Symbol.JAR_PATHNAME }));
/*     */ 
/*     */       
/* 150 */       return (LispObject)Lisp.UNREACHED;
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*     */   public static JarPathname createFromFile(String s) {
/* 156 */     JarPathname result = create("jar:file:" + s + "!/");
/* 157 */     result.setVersion(Keyword.NEWEST);
/* 158 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public static JarPathname createEntryFromFile(String jar, String entry) {
/* 163 */     JarPathname result = create("jar:file:" + jar + "!/" + entry);
/* 164 */     result.setVersion(Keyword.NEWEST);
/* 165 */     return result;
/*     */   }
/*     */   
/*     */   public static JarPathname createEntryFromJar(JarPathname jar, String entry) {
/* 169 */     if (jar.isArchiveEntry()) {
/* 170 */       Lisp.simple_error("Failed to create the entry ~a in ~a", new Object[] { entry, jar });
/* 171 */       return (JarPathname)Lisp.UNREACHED;
/*     */     } 
/* 173 */     JarPathname result = new JarPathname();
/* 174 */     result.copyFrom(jar);
/* 175 */     String path = new String(entry);
/* 176 */     if (!path.startsWith("/")) {
/* 177 */       path = "/" + path;
/*     */     }
/* 179 */     Pathname p = Pathname.create(path);
/* 180 */     result
/* 181 */       .setDirectory(p.getDirectory())
/* 182 */       .setName(p.getName())
/* 183 */       .setType(p.getType())
/* 184 */       .setVersion(Keyword.NEWEST);
/*     */     
/* 186 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   static List<String> enumerate(String s) {
/* 192 */     ArrayList<String> result = new ArrayList<>();
/*     */     
/* 194 */     int i = s.lastIndexOf("jar:");
/* 195 */     if (i == -1) {
/* 196 */       Lisp.parse_error("Failed to find any occurence of 'jar:' prefixes:" + s);
/* 197 */       return null;
/*     */     } 
/* 199 */     i += "jar:".length();
/* 200 */     if (i % "jar:".length() != 0) {
/* 201 */       Lisp.parse_error("Failed to parse 'jar:' prefixes:" + s);
/* 202 */       return null;
/*     */     } 
/* 204 */     int prefixCount = i / "jar:".length();
/* 205 */     String withoutPrefixes = s.substring(i);
/*     */     
/* 207 */     String[] parts = withoutPrefixes.split("!/");
/*     */ 
/*     */     
/* 210 */     String notEndingInSuffix = withoutPrefixes + "nonce";
/* 211 */     String[] suffixParts = notEndingInSuffix.split("!/");
/* 212 */     int suffixCount = suffixParts.length - 1;
/* 213 */     if (suffixCount != prefixCount) {
/* 214 */       Lisp.parse_error("Mismatched 'jar:' prefix and '/!' suffixes in jar: " + s);
/* 215 */       return null;
/*     */     } 
/*     */     
/* 218 */     if (parts.length == 1) {
/* 219 */       if (!s.endsWith("!/")) {
/* 220 */         Lisp.error(new SimpleError("No trailing jar uri suffix: " + s));
/* 221 */         return null;
/*     */       } 
/* 223 */       if (!isValidURL(parts[0])) {
/* 224 */         Lisp.error(new SimpleError("Not a valid URI: " + parts[0]));
/* 225 */         return null;
/*     */       } 
/*     */       
/* 228 */       result.add(parts[0]);
/* 229 */       return result;
/*     */     } 
/*     */ 
/*     */ 
/*     */     
/* 234 */     result.add(parts[0]);
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 239 */     for (int j = 1; j < prefixCount; j++) {
/* 240 */       String ns = parts[j] + "!/";
/* 241 */       result.add(ns);
/*     */     } 
/*     */ 
/*     */     
/* 245 */     if (parts.length == prefixCount + 1) {
/* 246 */       result.add("/" + parts[parts.length - 1]);
/*     */     }
/*     */     
/* 249 */     return result;
/*     */   }
/*     */   public static JarPathname create(String s) {
/*     */     URLPathname rootPathname;
/* 253 */     if (!s.startsWith("jar:")) {
/* 254 */       Lisp.parse_error("Cannot create a PATHNAME-JAR from namestring: " + s);
/* 255 */       return (JarPathname)Lisp.UNREACHED;
/*     */     } 
/*     */     
/* 258 */     List<String> contents = enumerate(s);
/*     */     
/* 260 */     if (contents == null) {
/* 261 */       Lisp.parse_error("Couldn't parse PATHNAME-JAR from namestring: " + s);
/* 262 */       return (JarPathname)Lisp.UNREACHED;
/*     */     } 
/*     */     
/* 265 */     JarPathname result = new JarPathname();
/*     */ 
/*     */ 
/*     */     
/* 269 */     String rootNamestring = contents.get(0);
/* 270 */     if (!isValidURL(rootNamestring)) {
/* 271 */       Pathname root = Pathname.create(rootNamestring);
/* 272 */       rootPathname = URLPathname.createFromFile(root);
/*     */     } else {
/* 274 */       rootPathname = URLPathname.create(rootNamestring);
/*     */     } 
/*     */     
/* 277 */     LispObject jars = Lisp.NIL;
/* 278 */     jars = jars.push(rootPathname);
/*     */     
/* 280 */     if (contents.size() == 1) {
/* 281 */       result.setDevice(jars);
/* 282 */       return result;
/*     */     } 
/*     */     
/* 285 */     for (int i = 1; i < contents.size(); i++) {
/* 286 */       String ns = contents.get(i);
/* 287 */       if (ns.endsWith("!/")) {
/* 288 */         String nsWithoutSuffix = ns.substring(0, ns.length() - "!/".length());
/* 289 */         Pathname pathname = Pathname.create(nsWithoutSuffix);
/* 290 */         Pathname jar = new Pathname();
/* 291 */         jar.copyFrom(pathname);
/* 292 */         jars = jars.push(jar);
/*     */       } else {
/* 294 */         Pathname p = Pathname.create(contents.get(i));
/* 295 */         result.copyFrom(p);
/*     */       } 
/*     */     } 
/* 298 */     jars = jars.nreverse();
/* 299 */     result.setDevice(jars);
/* 300 */     result.validateComponents();
/* 301 */     return result;
/*     */   }
/*     */   
/*     */   public LispObject validateComponents() {
/* 305 */     if (!(getDevice() instanceof Cons)) {
/* 306 */       return Lisp.type_error("Invalid DEVICE for JAR-PATHNAME", getDevice(), Symbol.CONS);
/*     */     }
/*     */     
/* 309 */     LispObject jars = getDevice();
/*     */     
/* 311 */     LispObject rootJar = getRootJar();
/* 312 */     if (!(rootJar instanceof URLPathname)) {
/* 313 */       return Lisp.type_error("The first element in the DEVICE component of a JAR-PATHNAME is not of expected type", rootJar, Symbol.URL_PATHNAME);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/* 318 */     jars = jars.cdr();
/*     */     
/* 320 */     while (!jars.car().equals(Lisp.NIL)) {
/* 321 */       LispObject jar = jars.car();
/* 322 */       if (!(jar instanceof Pathname) && !(jar instanceof URLPathname))
/*     */       {
/* 324 */         return Lisp.type_error("The value in DEVICE component of a JAR-PATHNAME is not of expected type", jar, 
/*     */             
/* 326 */             Lisp.list(Symbol.OR, new LispObject[] { Symbol.PATHNAME, Symbol.URL_PATHNAME }));
/*     */       }
/*     */       
/* 329 */       jars = jars.cdr();
/*     */     } 
/*     */     
/* 332 */     return Lisp.T;
/*     */   }
/*     */   
/*     */   public String getNamestring() {
/* 336 */     StringBuffer sb = new StringBuffer();
/*     */     
/* 338 */     LispObject jars = getJars();
/*     */     
/* 340 */     if (jars.equals(Lisp.NIL) || jars.equals(Keyword.UNSPECIFIC))
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 347 */       return null;
/*     */     }
/*     */     
/* 350 */     for (int i = 0; i < jars.length() - 1; i++) {
/* 351 */       sb.append("jar:");
/*     */     }
/*     */     
/* 354 */     LispObject root = getRootJar();
/*     */     
/* 356 */     if (root instanceof URLPathname) {
/* 357 */       String ns = ((URLPathname)root).getNamestringAsURL();
/* 358 */       sb.append("jar:")
/* 359 */         .append(ns)
/* 360 */         .append("!/");
/* 361 */     } else if (root instanceof Pathname) {
/* 362 */       String ns = ((Pathname)root).getNamestring();
/* 363 */       sb.append("jar:")
/* 364 */         .append("file:")
/* 365 */         .append(ns)
/* 366 */         .append("!/");
/*     */     } else {
/* 368 */       Lisp.simple_error("Unable to generate namestring for jar with root pathname ~a", new Object[] { root });
/*     */     } 
/*     */     
/* 371 */     LispObject innerJars = jars.cdr();
/* 372 */     while (innerJars.car() != Lisp.NIL) {
/* 373 */       Pathname jar = (Pathname)innerJars.car();
/* 374 */       Pathname p = new Pathname();
/* 375 */       p.copyFrom(jar)
/* 376 */         .setDevice(Lisp.NIL);
/* 377 */       String ns = p.getNamestring();
/* 378 */       sb.append(ns)
/* 379 */         .append("!/");
/* 380 */       innerJars = innerJars.cdr();
/*     */     } 
/*     */     
/* 383 */     if (getDirectory() != Lisp.NIL || 
/* 384 */       getName() != Lisp.NIL || 
/* 385 */       getType() != Lisp.NIL) {
/*     */       
/* 387 */       Pathname withoutDevice = new Pathname();
/* 388 */       withoutDevice
/* 389 */         .copyFrom(this)
/* 390 */         .setDevice(Lisp.NIL);
/*     */       
/* 392 */       String withoutDeviceNamestring = withoutDevice.getNamestring();
/* 393 */       if (withoutDeviceNamestring.startsWith("/")) {
/* 394 */         sb.append(withoutDeviceNamestring.substring(1));
/*     */       } else {
/* 396 */         sb.append(withoutDeviceNamestring);
/*     */       } 
/*     */     } 
/*     */     
/* 400 */     return sb.toString();
/*     */   }
/*     */   
/*     */   LispObject getRootJar() {
/* 404 */     LispObject jars = getJars();
/* 405 */     if (!(jars instanceof Cons)) {
/* 406 */       Lisp.type_error("JAR-PATHNAME device is not a cons", jars, Symbol.CONS);
/*     */       
/* 408 */       return (LispObject)Lisp.UNREACHED;
/*     */     } 
/*     */     
/* 411 */     return jars.car();
/*     */   }
/*     */   
/*     */   String getRootJarAsURLString() {
/* 415 */     return "jar:" + ((URLPathname)
/*     */       
/* 417 */       getRootJar()).getNamestring() + "!/";
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   LispObject getJars() {
/* 423 */     return getDevice();
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispObject truename(Pathname pathname, boolean errorIfDoesNotExist) {
/* 428 */     if (!(pathname instanceof JarPathname)) {
/* 429 */       return URLPathname.truename(pathname, errorIfDoesNotExist);
/*     */     }
/* 431 */     JarPathname p = new JarPathname();
/* 432 */     p.copyFrom(pathname);
/*     */ 
/*     */     
/* 435 */     if (p.isLocalFile()) {
/*     */       Pathname rootJar; URLPathname newRootJar;
/* 437 */       if (URLPathname.hasExplicitFile((Pathname)p.getRootJar())) {
/* 438 */         rootJar = new URLPathname();
/*     */       } else {
/* 440 */         rootJar = new Pathname();
/*     */       } 
/* 442 */       rootJar.copyFrom((Pathname)p.getRootJar());
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 448 */       if (rootJar.getDevice().equals(Lisp.NIL) && !Utilities.isPlatformWindows)
/*     */       {
/* 450 */         rootJar.setDevice(Keyword.UNSPECIFIC);
/*     */       }
/* 452 */       LispObject rootJarTruename = Pathname.truename(rootJar, errorIfDoesNotExist);
/* 453 */       if (rootJarTruename.equals(Lisp.NIL)) {
/* 454 */         return Pathname.doTruenameExit(rootJar, errorIfDoesNotExist);
/*     */       }
/* 456 */       LispObject otherJars = p.getJars().cdr();
/*     */       
/* 458 */       if (rootJarTruename instanceof Pathname) {
/* 459 */         newRootJar = URLPathname.createFromFile((Pathname)rootJarTruename);
/*     */       } else {
/* 461 */         newRootJar = (URLPathname)rootJarTruename;
/*     */       } 
/*     */       
/* 464 */       p.setDevice(new Cons(newRootJar, otherJars));
/*     */     } 
/*     */     
/* 467 */     if (!p.isArchiveEntry()) {
/* 468 */       ZipCache.Archive archive = ZipCache.getArchive(p);
/* 469 */       if (archive == null) {
/* 470 */         return Pathname.doTruenameExit(pathname, errorIfDoesNotExist);
/*     */       }
/* 472 */       return p;
/*     */     } 
/*     */     
/* 475 */     ZipEntry entry = ZipCache.getZipEntry(p);
/* 476 */     if (entry == null) {
/* 477 */       return Pathname.doTruenameExit(pathname, errorIfDoesNotExist);
/*     */     }
/* 479 */     return p;
/*     */   }
/*     */   
/*     */   public boolean isLocalFile() {
/* 483 */     Pathname p = (Pathname)getRootJar();
/* 484 */     if (p != null) {
/* 485 */       return p.isLocalFile();
/*     */     }
/* 487 */     return false;
/*     */   }
/*     */   
/*     */   public boolean isArchiveEntry() {
/* 491 */     return (!getDirectory().equals(Lisp.NIL) || 
/* 492 */       !getName().equals(Lisp.NIL) || 
/* 493 */       !getType().equals(Lisp.NIL));
/*     */   }
/*     */   
/*     */   public JarPathname getArchive() {
/* 497 */     if (!isArchiveEntry()) {
/* 498 */       return (JarPathname)Lisp.simple_error("Pathname already represents an archive.", new Object[0]);
/*     */     }
/* 500 */     JarPathname archive = new JarPathname();
/* 501 */     archive.copyFrom(this);
/* 502 */     archive
/* 503 */       .setDirectory(Lisp.NIL)
/* 504 */       .setName(Lisp.NIL)
/* 505 */       .setType(Lisp.NIL);
/* 506 */     return archive;
/*     */   }
/*     */   
/*     */   public LispObject classOf() {
/* 510 */     return BuiltInClass.JAR_PATHNAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 515 */     return Symbol.JAR_PATHNAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public InputStream getInputStream() {
/* 520 */     if (!isArchiveEntry()) {
/* 521 */       Lisp.simple_error("Can only get input stream for an entry in a JAR-PATHNAME.", new Object[] { this });
/*     */     }
/* 523 */     InputStream result = ZipCache.getEntryAsInputStream(this);
/* 524 */     if (result == null) {
/* 525 */       Lisp.error(new FileError("Failed to get InputStream", this));
/*     */     }
/* 527 */     return result;
/*     */   }
/*     */ 
/*     */   
/*     */   public static LispObject listDirectory(JarPathname pathname) {
/* 532 */     String directory = pathname.asEntryPath();
/*     */     
/* 534 */     if (pathname.getDirectory() == Lisp.NIL) {
/* 535 */       return Lisp.simple_error("Not a directory in a jar ~a", new Object[] { pathname });
/*     */     }
/*     */     
/* 538 */     if (directory.length() == 0) {
/* 539 */       directory = "/*";
/*     */     }
/* 541 */     else if (directory.endsWith("/")) {
/* 542 */       directory = "/" + directory + "*";
/*     */     } else {
/* 544 */       directory = "/" + directory + "/*";
/*     */     } 
/*     */ 
/*     */     
/* 548 */     Pathname wildcard = Pathname.create(directory);
/*     */     
/* 550 */     LispObject result = Lisp.NIL;
/*     */     
/* 552 */     Iterator<Map.Entry<JarPathname, ZipEntry>> iterator = ZipCache.getEntriesIterator(pathname);
/* 553 */     while (iterator.hasNext()) {
/* 554 */       Map.Entry<JarPathname, ZipEntry> e = iterator.next();
/* 555 */       JarPathname entry = e.getKey();
/* 556 */       if (!Symbol.PATHNAME_MATCH_P.execute(entry, wildcard).equals(Lisp.NIL)) {
/* 557 */         result = result.push(entry);
/*     */       }
/*     */     } 
/* 560 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "match-wild-jar-pathname", args = "wild-jar-pathname", returns = "pathnames", doc = "Returns the pathnames matching WILD-JAR-PATHNAME which must be both wild and a JAR-PATHNAME")
/* 567 */   static final Primitive MATCH_WILD_JAR_PATHNAME = new pf_match_wild_jar_pathname();
/*     */   
/*     */   private static class pf_match_wild_jar_pathname extends Primitive {
/*     */     pf_match_wild_jar_pathname() {
/* 571 */       super(Symbol.MATCH_WILD_JAR_PATHNAME, "wild-jar-pathname");
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 575 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 576 */       if (pathname instanceof LogicalPathname) {
/* 577 */         pathname = LogicalPathname.translateLogicalPathname((LogicalPathname)pathname);
/*     */       }
/* 579 */       if (!pathname.isJar()) {
/* 580 */         return new FileError("Not a jar pathname.", pathname);
/*     */       }
/* 582 */       if (!pathname.isWild()) {
/* 583 */         return new FileError("Not a wild pathname.", pathname);
/*     */       }
/*     */       
/* 586 */       JarPathname jarPathname = new JarPathname();
/* 587 */       jarPathname
/* 588 */         .copyFrom(pathname)
/* 589 */         .setDirectory(Lisp.NIL)
/* 590 */         .setName(Lisp.NIL)
/* 591 */         .setType(Lisp.NIL);
/* 592 */       JarPathname wildcard = (JarPathname)Symbol.TRUENAME.execute(jarPathname);
/*     */       
/* 594 */       Iterator<Map.Entry<JarPathname, ZipEntry>> iterator = ZipCache.getEntriesIterator(wildcard);
/* 595 */       wildcard
/* 596 */         .setDirectory(pathname.getDirectory())
/* 597 */         .setName(pathname.getName())
/* 598 */         .setType(pathname.getType());
/*     */       
/* 600 */       LispObject result = Lisp.NIL;
/* 601 */       while (iterator.hasNext()) {
/* 602 */         Map.Entry<JarPathname, ZipEntry> e = iterator.next();
/* 603 */         JarPathname entry = e.getKey();
/*     */         
/* 605 */         LispObject matches = Symbol.PATHNAME_MATCH_P.execute(entry, wildcard);
/*     */         
/* 607 */         if (!matches.equals(Lisp.NIL)) {
/* 608 */           result = new Cons(entry, result);
/*     */         }
/*     */       } 
/*     */       
/* 612 */       return result;
/*     */     }
/*     */   }
/*     */   
/*     */   public long getLastModified() {
/* 617 */     if (!isArchiveEntry()) {
/* 618 */       ZipCache.Archive archive = ZipCache.getArchive(this);
/* 619 */       if (archive != null) {
/* 620 */         return archive.lastModified;
/*     */       }
/*     */     } else {
/* 623 */       ZipEntry entry = ZipCache.getZipEntry(this);
/* 624 */       if (entry != null) {
/* 625 */         return entry.getTime();
/*     */       }
/*     */     } 
/* 628 */     return 0L;
/*     */   }
/*     */   
/*     */   static JarPathname joinEntry(JarPathname root, Pathname entry) {
/* 632 */     JarPathname result = new JarPathname();
/* 633 */     result
/* 634 */       .copyFrom(root)
/* 635 */       .setDirectory(entry.getDirectory())
/* 636 */       .setName(entry.getName())
/* 637 */       .setType(entry.getType());
/* 638 */     return result;
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JarPathname.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */