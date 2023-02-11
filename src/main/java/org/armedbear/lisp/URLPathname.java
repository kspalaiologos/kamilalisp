/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.net.MalformedURLException;
/*     */ import java.net.URI;
/*     */ import java.net.URISyntaxException;
/*     */ import java.net.URL;
/*     */ import java.net.URLConnection;
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
/*     */ public class URLPathname
/*     */   extends Pathname
/*     */ {
/*  50 */   public static final Symbol SCHEME = Lisp.internKeyword("SCHEME");
/*  51 */   public static final Symbol AUTHORITY = Lisp.internKeyword("AUTHORITY");
/*  52 */   public static final Symbol QUERY = Lisp.internKeyword("QUERY");
/*  53 */   public static final Symbol FRAGMENT = Lisp.internKeyword("FRAGMENT");
/*     */ 
/*     */ 
/*     */   
/*     */   public static URLPathname create() {
/*  58 */     return new URLPathname();
/*     */   }
/*     */   
/*     */   public static URLPathname create(Pathname p) {
/*  62 */     if (p instanceof URLPathname) {
/*  63 */       URLPathname result = new URLPathname();
/*  64 */       result.copyFrom(p);
/*  65 */       return result;
/*     */     } 
/*  67 */     return createFromFile(p);
/*     */   }
/*     */   
/*     */   public static URLPathname create(URL url) {
/*  71 */     return create(url.toString());
/*     */   }
/*     */   
/*     */   public static URLPathname create(URI uri) {
/*  75 */     return create(uri.toString());
/*     */   }
/*     */   
/*  78 */   public static final LispObject FILE = new SimpleString("file");
/*     */   public static URLPathname createFromFile(Pathname p) {
/*  80 */     URLPathname result = new URLPathname();
/*  81 */     result.copyFrom(p);
/*  82 */     LispObject scheme = Lisp.NIL;
/*  83 */     scheme = scheme.push(FILE).push(SCHEME);
/*  84 */     result.setHost(scheme);
/*  85 */     return result;
/*     */   }
/*     */   
/*     */   public static URLPathname create(String s) {
/*  89 */     if (!isValidURL(s)) {
/*  90 */       Lisp.parse_error("Cannot form a PATHNAME-URL from " + s);
/*     */     }
/*  92 */     if (s.startsWith("jar:")) {
/*  93 */       return JarPathname.create(s);
/*     */     }
/*     */     
/*  96 */     URLPathname result = new URLPathname();
/*  97 */     URL url = null;
/*     */     try {
/*  99 */       url = new URL(s);
/* 100 */     } catch (MalformedURLException e) {
/* 101 */       Lisp.parse_error("Malformed URL in namestring '" + s + "': " + e.toString());
/* 102 */       return (URLPathname)Lisp.UNREACHED;
/*     */     } 
/* 104 */     String scheme = url.getProtocol();
/* 105 */     if (scheme.equals("file")) {
/* 106 */       URI uRI = null;
/*     */       try {
/* 108 */         uRI = new URI(s);
/* 109 */       } catch (URISyntaxException ex) {
/* 110 */         Lisp.parse_error("Improper URI syntax for '" + url
/* 111 */             .toString() + "': " + ex
/* 112 */             .toString());
/* 113 */         return (URLPathname)Lisp.UNREACHED;
/*     */       } 
/*     */       
/* 116 */       String uriPath = uRI.getPath();
/* 117 */       if (null == uriPath) {
/*     */ 
/*     */         
/* 120 */         uriPath = uRI.getSchemeSpecificPart();
/* 121 */         if (uriPath == null || uriPath.equals("")) {
/* 122 */           Lisp.parse_error("The namestring URI has no path: " + uRI);
/* 123 */           return (URLPathname)Lisp.UNREACHED;
/*     */         } 
/*     */       } 
/* 126 */       File file = new File(uriPath);
/* 127 */       String str1 = file.getPath();
/* 128 */       if (uRI.toString().endsWith("/") && !str1.endsWith("/")) {
/* 129 */         str1 = str1 + "/";
/*     */       }
/* 131 */       Pathname pathname = Pathname.create(str1);
/* 132 */       LispObject lispObject = Lisp.NIL.push(FILE).push(SCHEME);
/* 133 */       result
/* 134 */         .setHost(lispObject)
/* 135 */         .setDevice(pathname.getDevice())
/* 136 */         .setDirectory(pathname.getDirectory())
/* 137 */         .setName(pathname.getName())
/* 138 */         .setType(pathname.getType())
/* 139 */         .setVersion(pathname.getVersion());
/* 140 */       return result;
/*     */     } 
/* 142 */     Debug.assertTrue((scheme != null));
/* 143 */     URI uri = null;
/*     */     try {
/* 145 */       uri = url.toURI().normalize();
/* 146 */     } catch (URISyntaxException e) {
/* 147 */       Lisp.parse_error("Couldn't form URI from '" + url + "' because: " + e);
/*     */ 
/*     */       
/* 150 */       return (URLPathname)Lisp.UNREACHED;
/*     */     } 
/* 152 */     String authority = uri.getAuthority();
/* 153 */     if (authority == null) {
/* 154 */       authority = url.getAuthority();
/*     */     }
/*     */     
/* 157 */     LispObject host = Lisp.NIL;
/* 158 */     host = host.push(SCHEME).push(new SimpleString(scheme));
/* 159 */     if (authority != null) {
/* 160 */       host = host.push(AUTHORITY).push(new SimpleString(authority));
/*     */     }
/* 162 */     String query = uri.getRawQuery();
/* 163 */     if (query != null) {
/* 164 */       host = host.push(QUERY).push(new SimpleString(query));
/*     */     }
/* 166 */     String fragment = uri.getRawFragment();
/* 167 */     if (fragment != null) {
/* 168 */       host = host.push(FRAGMENT).push(new SimpleString(fragment));
/*     */     }
/* 170 */     host = host.nreverse();
/* 171 */     result.setHost(host);
/*     */ 
/*     */     
/* 174 */     String path = uri.getRawPath();
/* 175 */     if (path == null) {
/* 176 */       path = "";
/*     */     }
/*     */     
/* 179 */     Pathname p = Pathname.create((path != null) ? path : "");
/* 180 */     result
/* 181 */       .setDirectory(p.getDirectory())
/* 182 */       .setName(p.getName())
/* 183 */       .setType(p.getType());
/*     */     
/* 185 */     return result;
/*     */   }
/*     */   
/*     */   public URI toURI() {
/* 189 */     String uriString = getNamestringAsURL();
/*     */     try {
/* 191 */       URI uri = new URI(uriString);
/* 192 */       return uri;
/* 193 */     } catch (URISyntaxException eo) {
/* 194 */       return null;
/*     */     } 
/*     */   }
/*     */   
/*     */   public URL toURL() {
/* 199 */     URI uri = toURI();
/*     */     try {
/* 201 */       if (uri != null) {
/* 202 */         return uri.toURL();
/*     */       }
/* 204 */     } catch (MalformedURLException malformedURLException) {}
/*     */     
/* 206 */     return null;
/*     */   }
/*     */   
/*     */   public File getFile() {
/* 210 */     if (!hasExplicitFile(this)) {
/* 211 */       return null;
/*     */     }
/* 213 */     URI uri = toURI();
/* 214 */     if (uri == null) {
/* 215 */       return null;
/*     */     }
/* 217 */     File result = new File(uri);
/* 218 */     return result;
/*     */   }
/*     */   
/*     */   public static boolean isFile(Pathname p) {
/* 222 */     LispObject scheme = Symbol.GETF.execute(p.getHost(), SCHEME, Lisp.NIL);
/* 223 */     if (scheme.equals(Lisp.NIL) || 
/* 224 */       hasExplicitFile(p)) {
/* 225 */       return true;
/*     */     }
/* 227 */     return false;
/*     */   }
/*     */   
/*     */   public static boolean hasExplicitFile(Pathname p) {
/* 231 */     if (!p.getHost().listp()) {
/* 232 */       return false;
/*     */     }
/* 234 */     LispObject scheme = Symbol.GETF.execute(p.getHost(), SCHEME, Lisp.NIL);
/* 235 */     return scheme.equalp(FILE);
/*     */   }
/*     */   
/*     */   public String getNamestring() {
/* 239 */     StringBuilder sb = new StringBuilder();
/* 240 */     return getNamestring(sb);
/*     */   }
/*     */   
/*     */   public String getNamestring(StringBuilder sb) {
/* 244 */     LispObject scheme = Symbol.GETF.execute(getHost(), SCHEME, Lisp.NIL);
/* 245 */     LispObject authority = Symbol.GETF.execute(getHost(), AUTHORITY, Lisp.NIL);
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 250 */     boolean percentEncode = true;
/* 251 */     if (scheme.equals(Lisp.NIL)) {
/* 252 */       percentEncode = false;
/*     */     } else {
/* 254 */       sb.append(scheme.getStringValue());
/* 255 */       sb.append(":");
/* 256 */       if (authority != Lisp.NIL) {
/* 257 */         sb.append("//");
/* 258 */         sb.append(authority.getStringValue());
/* 259 */       } else if (scheme.equalp(FILE)) {
/* 260 */         sb.append("//");
/*     */       } 
/*     */     } 
/*     */     
/* 264 */     if (Utilities.isPlatformWindows && 
/* 265 */       getDevice() instanceof SimpleString) {
/* 266 */       sb.append("/")
/* 267 */         .append(getDevice().getStringValue())
/* 268 */         .append(":");
/*     */     }
/* 270 */     String directoryNamestring = getDirectoryNamestring();
/* 271 */     if (percentEncode) {
/* 272 */       directoryNamestring = uriEncode(directoryNamestring);
/*     */     }
/* 274 */     sb.append(directoryNamestring);
/*     */ 
/*     */     
/* 277 */     Pathname p = new Pathname();
/* 278 */     p.copyFrom(this)
/* 279 */       .setHost(Lisp.NIL)
/* 280 */       .setDevice(Lisp.NIL)
/* 281 */       .setDirectory(Lisp.NIL);
/* 282 */     String nameTypeVersion = p.getNamestring();
/* 283 */     if (percentEncode) {
/* 284 */       nameTypeVersion = uriEncode(nameTypeVersion);
/*     */     }
/* 286 */     sb.append(nameTypeVersion);
/*     */     
/* 288 */     LispObject o = Symbol.GETF.execute(getHost(), QUERY, Lisp.NIL);
/* 289 */     if (o != Lisp.NIL) {
/* 290 */       sb.append("?")
/* 291 */         .append(uriEncode(o.getStringValue()));
/*     */     }
/* 293 */     o = Symbol.GETF.execute(getHost(), FRAGMENT, Lisp.NIL);
/* 294 */     if (o != Lisp.NIL) {
/* 295 */       sb.append("#")
/* 296 */         .append(uriEncode(o.getStringValue()));
/*     */     }
/*     */     
/* 299 */     return sb.toString();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String getNamestringAsURL() {
/*     */     String scheme;
/* 306 */     LispObject schemeProperty = Symbol.GETF.execute(getHost(), SCHEME, Lisp.NIL);
/* 307 */     LispObject authorityProperty = Symbol.GETF.execute(getHost(), AUTHORITY, Lisp.NIL);
/* 308 */     LispObject queryProperty = Symbol.GETF.execute(getHost(), QUERY, Lisp.NIL);
/* 309 */     LispObject fragmentProperty = Symbol.GETF.execute(getHost(), FRAGMENT, Lisp.NIL);
/*     */ 
/*     */     
/* 312 */     String authority = null;
/* 313 */     if (!schemeProperty.equals(Lisp.NIL)) {
/* 314 */       scheme = schemeProperty.getStringValue();
/* 315 */       if (!authorityProperty.equals(Lisp.NIL)) {
/* 316 */         authority = authorityProperty.getStringValue();
/*     */       }
/*     */     } else {
/* 319 */       scheme = "file";
/*     */     } 
/*     */     
/* 322 */     String directory = getDirectoryNamestring();
/* 323 */     String file = "";
/* 324 */     LispObject fileNamestring = Symbol.FILE_NAMESTRING.execute(this);
/* 325 */     if (!fileNamestring.equals(Lisp.NIL)) {
/* 326 */       file = fileNamestring.getStringValue();
/*     */     }
/* 328 */     String path = "";
/*     */     
/* 330 */     if (!directory.equals("")) {
/* 331 */       if (Utilities.isPlatformWindows && 
/* 332 */         getDevice() instanceof SimpleString) {
/* 333 */         path = getDevice().getStringValue() + ":" + directory + file;
/*     */       } else {
/* 335 */         path = directory + file;
/*     */       } 
/*     */     } else {
/* 338 */       path = file;
/*     */     } 
/*     */     
/* 341 */     path = uriEncode(path);
/*     */     
/* 343 */     String query = null;
/* 344 */     if (!queryProperty.equals(Lisp.NIL)) {
/* 345 */       query = queryProperty.getStringValue();
/*     */     }
/*     */     
/* 348 */     String fragment = null;
/* 349 */     if (!fragmentProperty.equals(Lisp.NIL)) {
/* 350 */       fragment = fragmentProperty.getStringValue();
/*     */     }
/*     */     
/* 353 */     StringBuffer result = new StringBuffer(scheme);
/* 354 */     result.append(":");
/* 355 */     result.append("//");
/* 356 */     if (authority != null) {
/* 357 */       result.append(authority);
/*     */     }
/* 359 */     if (!path.startsWith("/")) {
/* 360 */       result.append("/");
/*     */     }
/* 362 */     result.append(path);
/*     */     
/* 364 */     if (query != null) {
/* 365 */       result.append("?").append(query);
/*     */     }
/*     */     
/* 368 */     if (fragment != null) {
/* 369 */       result.append("#").append(fragment);
/*     */     }
/* 371 */     return result.toString();
/*     */   }
/*     */   
/*     */   public LispObject typeOf() {
/* 375 */     return Symbol.URL_PATHNAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 380 */     return BuiltInClass.URL_PATHNAME;
/*     */   }
/*     */   
/*     */   public static LispObject truename(Pathname p, boolean errorIfDoesNotExist) {
/* 384 */     URLPathname pathnameURL = createFromFile(p);
/* 385 */     return truename(pathnameURL, errorIfDoesNotExist);
/*     */   }
/*     */   
/*     */   public static LispObject truename(URLPathname p, boolean errorIfDoesNotExist) {
/* 389 */     if (p.getHost().equals(Lisp.NIL) || 
/* 390 */       hasExplicitFile(p)) {
/* 391 */       LispObject fileTruename = Pathname.truename(p, errorIfDoesNotExist);
/* 392 */       if (fileTruename.equals(Lisp.NIL)) {
/* 393 */         return Lisp.NIL;
/*     */       }
/* 395 */       if (!(fileTruename instanceof URLPathname)) {
/* 396 */         URLPathname urlTruename = createFromFile((Pathname)fileTruename);
/* 397 */         return urlTruename;
/*     */       } 
/* 399 */       return fileTruename;
/*     */     } 
/*     */     
/* 402 */     if (p.getInputStream() != null) {
/*     */ 
/*     */       
/* 405 */       if (p.getName() != Lisp.NIL && p
/* 406 */         .getType() == Lisp.NIL && Symbol.GETF
/* 407 */         .execute(p.getHost(), QUERY, Lisp.NIL) == Lisp.NIL && Symbol.GETF
/* 408 */         .execute(p.getHost(), FRAGMENT, Lisp.NIL) == Lisp.NIL && 
/* 409 */         p.getInputStream() != null) {
/* 410 */         return p;
/*     */       }
/*     */       
/* 413 */       return p;
/*     */     } 
/* 415 */     return Pathname.doTruenameExit(p, errorIfDoesNotExist);
/*     */   }
/*     */   
/*     */   public InputStream getInputStream() {
/* 419 */     InputStream result = null;
/*     */     
/* 421 */     if (isFile(this)) {
/* 422 */       Pathname p = new Pathname();
/* 423 */       p.copyFrom(this)
/* 424 */         .setHost(Lisp.NIL);
/* 425 */       return p.getInputStream();
/*     */     } 
/*     */     
/* 428 */     if (isFile(this)) {
/* 429 */       Pathname p = new Pathname();
/* 430 */       p.copyFrom(this)
/* 431 */         .setHost(Lisp.NIL);
/* 432 */       return p.getInputStream();
/*     */     } 
/*     */     
/* 435 */     URL url = toURL();
/*     */     try {
/* 437 */       result = url.openStream();
/* 438 */     } catch (IOException e) {
/* 439 */       Debug.warn("Failed to get InputStream from '" + 
/* 440 */           getNamestring() + "': " + e);
/*     */     } 
/*     */     
/* 443 */     return result;
/*     */   }
/*     */   
/*     */   URLConnection getURLConnection() {
/* 447 */     Debug.assertTrue(isURL());
/* 448 */     URL url = toURL();
/* 449 */     URLConnection result = null;
/*     */     try {
/* 451 */       result = url.openConnection();
/* 452 */     } catch (IOException e) {
/* 453 */       Lisp.error(new FileError("Failed to open URL connection.", this));
/*     */     } 
/*     */     
/* 456 */     return result;
/*     */   }
/*     */   
/*     */   public long getLastModified() {
/* 460 */     return getURLConnection().getLastModified();
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "uri-decode", args = "string", returns = "string", doc = "Decode STRING percent escape sequences in the manner of URI encodings.")
/* 467 */   private static final Primitive URI_DECODE = new pf_uri_decode();
/*     */   
/*     */   private static final class pf_uri_decode extends Primitive { pf_uri_decode() {
/* 470 */       super("uri-decode", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 474 */       if (!(arg instanceof AbstractString)) {
/* 475 */         return Lisp.type_error(arg, Symbol.STRING);
/*     */       }
/* 477 */       String result = URLPathname.uriDecode(((AbstractString)arg).toString());
/* 478 */       return new SimpleString(result);
/*     */     } }
/*     */ 
/*     */   
/*     */   static String uriDecode(String s) {
/*     */     try {
/* 484 */       URI uri = new URI("file://foo?" + s);
/* 485 */       return uri.getQuery();
/* 486 */     } catch (URISyntaxException uRISyntaxException) {
/* 487 */       return null;
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   @DocString(name = "uri-encode", args = "string", returns = "string", doc = "Encode percent escape sequences in the manner of URI encodings.")
/* 494 */   private static final Primitive URI_ENCODE = new pf_uri_encode();
/*     */   
/*     */   private static final class pf_uri_encode extends Primitive { pf_uri_encode() {
/* 497 */       super("uri-encode", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 501 */       if (!(arg instanceof AbstractString)) {
/* 502 */         return Lisp.type_error(arg, Symbol.STRING);
/*     */       }
/* 504 */       String result = URLPathname.uriEncode(((AbstractString)arg).toString());
/* 505 */       return new SimpleString(result);
/*     */     } }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   static String uriEncode(String s) {
/*     */     String u;
/* 513 */     if (!s.startsWith("/")) {
/* 514 */       u = "/" + s;
/*     */     } else {
/* 516 */       u = new String(s);
/*     */     } 
/*     */     try {
/* 519 */       URI uri = new URI("file", "", u, "");
/* 520 */       String result = uri.getRawPath();
/* 521 */       if (!s.startsWith("/")) {
/* 522 */         return result.substring(1);
/*     */       }
/* 524 */       return result;
/* 525 */     } catch (URISyntaxException e) {
/* 526 */       Debug.assertTrue(false);
/*     */       
/* 528 */       return null;
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/URLPathname.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */