/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.File;
/*      */ import java.io.FileInputStream;
/*      */ import java.io.IOException;
/*      */ import java.io.InputStream;
/*      */ import java.io.Serializable;
/*      */ import java.net.MalformedURLException;
/*      */ import java.net.URL;
/*      */ import java.util.StringTokenizer;
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public class Pathname
/*      */   extends LispObject
/*      */   implements Serializable
/*      */ {
/*      */   protected static Pathname create() {
/*   53 */     return new Pathname();
/*      */   }
/*      */   
/*      */   public static Pathname create(Pathname p) {
/*   57 */     if (p instanceof JarPathname)
/*   58 */       return JarPathname.create((JarPathname)p); 
/*   59 */     if (p instanceof URLPathname)
/*   60 */       return URLPathname.create(p); 
/*   61 */     if (p instanceof LogicalPathname) {
/*   62 */       return LogicalPathname.create((LogicalPathname)p);
/*      */     }
/*   64 */     return new Pathname(p);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static Pathname create(String s) {
/*   72 */     if (s.startsWith("jar:")) {
/*   73 */       return JarPathname.create(s);
/*      */     }
/*   75 */     if (isValidURL(s)) {
/*   76 */       return URLPathname.create(s);
/*      */     }
/*   78 */     if (LogicalPathname.isValidLogicalPathname(s)) {
/*   79 */       return LogicalPathname.create(s);
/*      */     }
/*      */     
/*   82 */     Pathname result = init(s);
/*      */     
/*   84 */     return result;
/*      */   }
/*      */   
/*      */   public static Pathname create(String s, String host) {
/*   88 */     return LogicalPathname.create(s, host);
/*      */   }
/*      */   
/*   91 */   protected LispObject host = Lisp.NIL;
/*      */   public LispObject getHost() {
/*   93 */     return this.host;
/*      */   }
/*      */   public Pathname setHost(LispObject host) {
/*   96 */     this.host = host;
/*   97 */     return this;
/*      */   }
/*      */   
/*  100 */   protected LispObject device = Lisp.NIL;
/*      */   public final LispObject getDevice() {
/*  102 */     return this.device;
/*      */   }
/*      */   public Pathname setDevice(LispObject device) {
/*  105 */     this.device = device;
/*  106 */     return this;
/*      */   }
/*      */   
/*  109 */   protected LispObject directory = Lisp.NIL;
/*      */   public LispObject getDirectory() {
/*  111 */     return this.directory;
/*      */   }
/*      */   public Pathname setDirectory(LispObject directory) {
/*  114 */     this.directory = directory;
/*  115 */     return this;
/*      */   }
/*      */   
/*  118 */   protected LispObject name = Lisp.NIL;
/*      */   public LispObject getName() {
/*  120 */     return this.name;
/*      */   }
/*      */   public Pathname setName(LispObject name) {
/*  123 */     this.name = name;
/*  124 */     return this;
/*      */   }
/*      */ 
/*      */   
/*  128 */   protected LispObject type = Lisp.NIL;
/*      */   public LispObject getType() {
/*  130 */     return this.type;
/*      */   }
/*      */   public Pathname setType(LispObject type) {
/*  133 */     this.type = type;
/*  134 */     return this;
/*      */   }
/*      */ 
/*      */   
/*  138 */   protected LispObject version = Lisp.NIL;
/*      */   public LispObject getVersion() {
/*  140 */     return this.version;
/*      */   }
/*      */   public static final char directoryDelimiter = '/';
/*      */   public Pathname setVersion(LispObject version) {
/*  144 */     this.version = version;
/*  145 */     return this;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private Pathname(Pathname p) {
/*  161 */     copyFrom(p);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static LispObject ncoerce(Pathname orig, Pathname dest) {
/*  168 */     return dest.copyFrom(orig);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   Pathname copyFrom(Pathname p) {
/*  175 */     if (p.host != Lisp.NIL) {
/*  176 */       LispObject pHost = p.getHost();
/*  177 */       if (pHost instanceof SimpleString) {
/*  178 */         setHost(new SimpleString(pHost.getStringValue()));
/*  179 */       } else if (pHost instanceof Symbol) {
/*  180 */         setHost(pHost);
/*  181 */       } else if (pHost instanceof Cons) {
/*  182 */         LispObject newHost = Lisp.NIL;
/*  183 */         LispObject components = pHost.reverse();
/*  184 */         while (!components.car().equals(Lisp.NIL)) {
/*  185 */           LispObject copy = components.car();
/*  186 */           newHost = newHost.push(copy);
/*  187 */           components = components.cdr();
/*      */         } 
/*  189 */         setHost(newHost);
/*      */       } else {
/*  191 */         Lisp.simple_error("Failed to copy host in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     } 
/*  194 */     if (p.device != Lisp.NIL) {
/*  195 */       if (p.device instanceof SimpleString) {
/*  196 */         this.device = new SimpleString(((SimpleString)p.getDevice()).getStringValue());
/*  197 */       } else if (p.getDevice() instanceof Cons) {
/*  198 */         LispObject jars = p.getDevice();
/*  199 */         setDevice(Lisp.NIL);
/*  200 */         URLPathname root = null;
/*  201 */         Pathname rootPathname = (Pathname)jars.car();
/*  202 */         if (rootPathname instanceof URLPathname) {
/*  203 */           root = URLPathname.create(rootPathname);
/*      */         } else {
/*  205 */           root = URLPathname.create(rootPathname);
/*      */         } 
/*  207 */         this.device = this.device.push(root);
/*  208 */         jars = jars.cdr();
/*  209 */         while (jars.car() != Lisp.NIL) {
/*      */           
/*  211 */           Pathname jar = create(((Pathname)jars.car()).getNamestring());
/*  212 */           this.device = this.device.push(jar);
/*  213 */           jars = jars.cdr();
/*      */         } 
/*  215 */         this.device.nreverse();
/*  216 */       } else if (p.device instanceof Symbol) {
/*  217 */         this.device = p.device;
/*      */       } else {
/*  219 */         Lisp.simple_error("Failed to copy device in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     }
/*  222 */     if (p.directory != Lisp.NIL) {
/*  223 */       if (p.directory instanceof Cons) {
/*  224 */         this.directory = Lisp.NIL;
/*  225 */         for (LispObject list = p.directory; list != Lisp.NIL; list = list.cdr()) {
/*  226 */           LispObject o = list.car();
/*  227 */           if (o instanceof Symbol) {
/*  228 */             this.directory = this.directory.push(o);
/*  229 */           } else if (o instanceof SimpleString) {
/*  230 */             this.directory = this.directory.push(new SimpleString(((SimpleString)o).getStringValue()));
/*      */           } else {
/*  232 */             Debug.assertTrue(false);
/*      */           } 
/*      */         } 
/*  235 */         this.directory.nreverse();
/*      */       } else {
/*  237 */         Lisp.simple_error("Failed to copy directory in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     }
/*  240 */     if (p.name != Lisp.NIL) {
/*  241 */       if (p.name instanceof SimpleString) {
/*  242 */         this.name = new SimpleString(((SimpleString)p.getName()).getStringValue());
/*  243 */       } else if (p.name instanceof Symbol) {
/*  244 */         this.name = p.name;
/*      */       } else {
/*  246 */         Lisp.simple_error("Failed to copy name in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     }
/*  249 */     if (p.type != Lisp.NIL) {
/*  250 */       if (p.type instanceof SimpleString) {
/*  251 */         this.type = new SimpleString(((SimpleString)p.getType()).getStringValue());
/*  252 */       } else if (p.type instanceof Symbol) {
/*  253 */         this.type = p.type;
/*      */       } else {
/*  255 */         Lisp.simple_error("Failed to copy type in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     }
/*  258 */     if (p.version != Lisp.NIL) {
/*  259 */       if (p.version instanceof Symbol) {
/*  260 */         this.version = p.version;
/*  261 */       } else if (p.version instanceof LispInteger) {
/*  262 */         this.version = p.version;
/*      */       } else {
/*  264 */         Lisp.simple_error("Failed to copy version in pathname ~a", new Object[] { p });
/*      */       } 
/*      */     }
/*  267 */     return this;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static boolean isSupportedProtocol(String protocol) {
/*  273 */     if ("jar".equals(protocol) || "file"
/*  274 */       .equals(protocol))
/*      */     {
/*      */       
/*  277 */       return true;
/*      */     }
/*      */ 
/*      */     
/*      */     try {
/*  282 */       new URL(protocol, "example.org", "foo");
/*  283 */       return true;
/*  284 */     } catch (MalformedURLException e) {
/*  285 */       return false;
/*      */     } 
/*      */   }
/*      */   
/*      */   private static final Pathname init(String s) {
/*  290 */     Pathname result = new Pathname();
/*  291 */     if (s == null) {
/*  292 */       return (Pathname)Lisp.parse_error("Refusing to create a PATHNAME for the null reference.");
/*      */     }
/*  294 */     if (s.equals(".") || s.equals("./") || (Utilities.isPlatformWindows && s
/*  295 */       .equals(".\\"))) {
/*  296 */       result.setDirectory(new Cons(Keyword.RELATIVE));
/*  297 */       return result;
/*      */     } 
/*  299 */     if (s.startsWith("./"))
/*  300 */       s = s.substring(2); 
/*  301 */     if (s.equals("..") || s.equals("../")) {
/*  302 */       result.setDirectory(Lisp.list(Keyword.RELATIVE, new LispObject[] { Keyword.UP }));
/*  303 */       return result;
/*      */     } 
/*      */     
/*  306 */     if (Utilities.isPlatformWindows && (
/*  307 */       s.startsWith("\\\\") || s.startsWith("//"))) {
/*      */       int shareIndex, dirIndex;
/*      */ 
/*      */ 
/*      */       
/*  312 */       if (s.startsWith("\\\\")) {
/*  313 */         shareIndex = s.indexOf('\\', 2);
/*  314 */         dirIndex = s.indexOf('\\', shareIndex + 1);
/*      */       } else {
/*      */         
/*  317 */         shareIndex = s.indexOf('/', 2);
/*  318 */         dirIndex = s.indexOf('/', shareIndex + 1);
/*      */       } 
/*  320 */       if (shareIndex == -1 || dirIndex == -1) {
/*  321 */         return (Pathname)Lisp.parse_error("Unsupported UNC path format: \"" + s + '"');
/*      */       }
/*      */       
/*  324 */       result
/*  325 */         .setHost(new SimpleString(s.substring(2, shareIndex)))
/*  326 */         .setDevice(new SimpleString(s.substring(shareIndex + 1, dirIndex)));
/*      */       
/*  328 */       Pathname p = create(s.substring(dirIndex));
/*  329 */       result
/*  330 */         .setDirectory(p.getDirectory())
/*  331 */         .setName(p.getName())
/*  332 */         .setType(p.getType())
/*  333 */         .setVersion(p.getVersion());
/*  334 */       return result;
/*      */     } 
/*      */ 
/*      */ 
/*      */     
/*  339 */     if (s.startsWith("jar:") && s
/*  340 */       .endsWith("!/")) {
/*  341 */       return JarPathname.create(s);
/*      */     }
/*      */ 
/*      */     
/*  345 */     int separatorIndex = s.lastIndexOf("!/");
/*  346 */     if (separatorIndex > 0 && s.startsWith("jar:")) {
/*  347 */       return JarPathname.create(s);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*  352 */     if (isValidURL(s)) {
/*  353 */       return URLPathname.create(s);
/*      */     }
/*      */ 
/*      */     
/*  357 */     if (Utilities.isPlatformWindows && 
/*  358 */       s.contains("\\")) {
/*  359 */       s = s.replace("\\", "/");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*  364 */     if (Utilities.isPlatformUnix) {
/*  365 */       if (s.equals("~")) {
/*  366 */         s = System.getProperty("user.home").concat("/");
/*  367 */       } else if (s.startsWith("~/")) {
/*  368 */         s = System.getProperty("user.home").concat(s.substring(1));
/*      */       } 
/*      */     }
/*      */ 
/*      */     
/*  373 */     if (Utilities.isPlatformWindows && 
/*  374 */       s.length() >= 2 && s.charAt(1) == ':') {
/*  375 */       result.setDevice(new SimpleString(s.charAt(0)));
/*  376 */       s = s.substring(2);
/*      */     } 
/*      */ 
/*      */     
/*  380 */     String d = null;
/*      */     
/*  382 */     for (int i = s.length(); i-- > 0;) {
/*  383 */       if (s.charAt(i) == '/') {
/*  384 */         d = s.substring(0, i + 1);
/*  385 */         s = s.substring(i + 1);
/*      */         
/*      */         break;
/*      */       } 
/*      */     } 
/*  390 */     if (d != null) {
/*  391 */       if (s.equals("..")) {
/*  392 */         d = d.concat(s);
/*  393 */         s = "";
/*      */       } 
/*  395 */       result.setDirectory(parseDirectory(d));
/*      */     } 
/*      */     
/*  398 */     int index = s.lastIndexOf('.');
/*  399 */     String name = null;
/*  400 */     String type = null;
/*  401 */     if (index > 0) {
/*  402 */       name = s.substring(0, index);
/*  403 */       type = s.substring(index + 1);
/*  404 */     } else if (s.length() > 0) {
/*  405 */       name = s;
/*      */     } 
/*  407 */     if (name != null) {
/*  408 */       if (name.equals("*")) {
/*  409 */         result.setName(Keyword.WILD);
/*      */       } else {
/*  411 */         result.setName(new SimpleString(name));
/*      */       } 
/*      */     }
/*  414 */     if (type != null) {
/*  415 */       if (type.equals("*")) {
/*  416 */         result.setType(Keyword.WILD);
/*      */       } else {
/*  418 */         result.setType(new SimpleString(type));
/*      */       } 
/*      */     }
/*  421 */     return result;
/*      */   }
/*      */   private static final LispObject parseDirectory(String d) {
/*      */     LispObject result;
/*  425 */     if (d.equals("/") || (Utilities.isPlatformWindows && d.equals("\\"))) {
/*  426 */       return new Cons(Keyword.ABSOLUTE);
/*      */     }
/*      */     
/*  429 */     if (d.startsWith("/") || (Utilities.isPlatformWindows && d.startsWith("\\"))) {
/*  430 */       result = new Cons(Keyword.ABSOLUTE);
/*      */     } else {
/*  432 */       result = new Cons(Keyword.RELATIVE);
/*      */     } 
/*  434 */     StringTokenizer st = new StringTokenizer(d, "/\\");
/*  435 */     while (st.hasMoreTokens()) {
/*  436 */       LispObject obj; String token = st.nextToken();
/*      */       
/*  438 */       if (token.equals("*")) {
/*  439 */         obj = Keyword.WILD;
/*  440 */       } else if (token.equals("**")) {
/*  441 */         obj = Keyword.WILD_INFERIORS;
/*  442 */       } else if (token.equals("..")) {
/*  443 */         if (result.car() instanceof AbstractString) {
/*  444 */           result = result.cdr();
/*      */           continue;
/*      */         } 
/*  447 */         obj = Keyword.UP;
/*      */       } else {
/*  449 */         obj = new SimpleString(token);
/*      */       } 
/*  451 */       result = new Cons(obj, result);
/*      */     } 
/*  453 */     return result.nreverse();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject getParts() {
/*  459 */     LispObject parts = Lisp.list(new Cons("HOST", getHost()), new LispObject[] { new Cons("DEVICE", 
/*  460 */             getDevice()), new Cons("DIRECTORY", 
/*  461 */             getDirectory()), new Cons("NAME", 
/*  462 */             getName()), new Cons("TYPE", 
/*  463 */             getType()), new Cons("VERSION", 
/*  464 */             getVersion()) });
/*  465 */     return parts;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typeOf() {
/*  470 */     if (isJar()) {
/*  471 */       return Symbol.JAR_PATHNAME;
/*      */     }
/*  473 */     if (isURL()) {
/*  474 */       return Symbol.URL_PATHNAME;
/*      */     }
/*  476 */     return Symbol.PATHNAME;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject classOf() {
/*  481 */     if (isJar()) {
/*  482 */       return BuiltInClass.JAR_PATHNAME;
/*      */     }
/*  484 */     if (isURL()) {
/*  485 */       return BuiltInClass.URL_PATHNAME;
/*      */     }
/*  487 */     return BuiltInClass.PATHNAME;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typep(LispObject type) {
/*  492 */     if (type == Symbol.PATHNAME) {
/*  493 */       return Lisp.T;
/*      */     }
/*  495 */     if (type == Symbol.JAR_PATHNAME && isJar()) {
/*  496 */       return Lisp.T;
/*      */     }
/*  498 */     if (type == Symbol.URL_PATHNAME && isURL()) {
/*  499 */       return Lisp.T;
/*      */     }
/*  501 */     if (type == BuiltInClass.PATHNAME) {
/*  502 */       return Lisp.T;
/*      */     }
/*  504 */     if (type == BuiltInClass.JAR_PATHNAME && isJar()) {
/*  505 */       return Lisp.T;
/*      */     }
/*  507 */     if (type == BuiltInClass.URL_PATHNAME && isURL()) {
/*  508 */       return Lisp.T;
/*      */     }
/*  510 */     return super.typep(type);
/*      */   }
/*      */   
/*      */   public String getNamestring() {
/*  514 */     if (getDirectory() instanceof AbstractString) {
/*  515 */       Debug.assertTrue(false);
/*      */     }
/*  517 */     StringBuilder sb = new StringBuilder();
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  522 */     if (getHost() != Lisp.NIL) {
/*  523 */       Debug.assertTrue((getHost() instanceof AbstractString || 
/*  524 */           isURL()));
/*  525 */       if (isURL()) {
/*  526 */         LispObject scheme = Symbol.GETF.execute(getHost(), URLPathname.SCHEME, Lisp.NIL);
/*  527 */         LispObject authority = Symbol.GETF.execute(getHost(), URLPathname.AUTHORITY, Lisp.NIL);
/*  528 */         Debug.assertTrue((scheme != Lisp.NIL));
/*  529 */         sb.append(scheme.getStringValue());
/*  530 */         sb.append(":");
/*  531 */         if (authority != Lisp.NIL) {
/*  532 */           sb.append("//");
/*  533 */           sb.append(authority.getStringValue());
/*      */         } 
/*  535 */       } else if (this instanceof LogicalPathname) {
/*  536 */         sb.append(getHost().getStringValue());
/*  537 */         sb.append(':');
/*      */       } else {
/*      */         
/*  540 */         sb.append("//").append(getHost().getStringValue()).append("/");
/*      */       } 
/*      */     } 
/*      */     
/*  544 */     if (!getDevice().equals(Lisp.NIL) && 
/*  545 */       !getDevice().equals(Keyword.UNSPECIFIC))
/*      */     {
/*  547 */       if (getDevice() instanceof AbstractString) {
/*  548 */         sb.append(getDevice().getStringValue());
/*  549 */         if (this instanceof LogicalPathname || 
/*  550 */           getHost() == Lisp.NIL) {
/*  551 */           sb.append(':');
/*      */         }
/*      */       } else {
/*  554 */         Lisp.simple_error("Transitional error in pathname: should be a JAR-PATHNAME", new Object[] { this });
/*      */       } 
/*      */     }
/*  557 */     String directoryNamestring = getDirectoryNamestring();
/*  558 */     sb.append(directoryNamestring);
/*      */     
/*  560 */     if (getName() instanceof AbstractString) {
/*  561 */       String n = getName().getStringValue();
/*  562 */       if (n.indexOf('/') >= 0) {
/*  563 */         return null;
/*      */       }
/*  565 */       sb.append(n);
/*  566 */     } else if (getName() == Keyword.WILD) {
/*  567 */       sb.append('*');
/*      */     } 
/*      */     
/*  570 */     if (getType() != Lisp.NIL && getType() != Keyword.UNSPECIFIC) {
/*  571 */       sb.append('.');
/*  572 */       if (getType() instanceof AbstractString) {
/*  573 */         String t = getType().getStringValue();
/*      */         
/*  575 */         if ((!t.endsWith(".lnk") || !Utilities.isPlatformWindows) && 
/*  576 */           t.indexOf('.') >= 0) {
/*  577 */           return null;
/*      */         }
/*      */         
/*  580 */         sb.append(t);
/*  581 */       } else if (getType() == Keyword.WILD) {
/*  582 */         sb.append('*');
/*      */       } else {
/*  584 */         Debug.assertTrue(false);
/*      */       } 
/*      */     } 
/*      */     
/*  588 */     if (this instanceof LogicalPathname) {
/*  589 */       if (getVersion().integerp()) {
/*  590 */         sb.append('.');
/*  591 */         int base = Fixnum.getValue(Symbol.PRINT_BASE.symbolValue());
/*  592 */         if (getVersion() instanceof Fixnum) {
/*  593 */           sb.append(Integer.toString(((Fixnum)getVersion()).value, base).toUpperCase());
/*  594 */         } else if (getVersion() instanceof Bignum) {
/*  595 */           sb.append(((Bignum)getVersion()).value.toString(base).toUpperCase());
/*      */         } 
/*  597 */       } else if (getVersion() == Keyword.WILD) {
/*  598 */         sb.append(".*");
/*  599 */       } else if (getVersion() == Keyword.NEWEST) {
/*  600 */         sb.append(".NEWEST");
/*      */       } 
/*      */     }
/*  603 */     return sb.toString();
/*      */   }
/*      */   
/*      */   protected String getDirectoryNamestring() {
/*  607 */     validateDirectory(true);
/*  608 */     StringBuilder sb = new StringBuilder();
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*  613 */     if (getDirectory() != Lisp.NIL && getDirectory() != Keyword.UNSPECIFIC) {
/*  614 */       LispObject temp = getDirectory();
/*  615 */       LispObject part = temp.car();
/*  616 */       temp = temp.cdr();
/*  617 */       if (part == Keyword.ABSOLUTE) {
/*  618 */         sb.append('/');
/*  619 */       } else if (part == Keyword.RELATIVE) {
/*  620 */         if (temp == Lisp.NIL) {
/*      */           
/*  622 */           sb.append('.');
/*  623 */           sb.append('/');
/*      */         } 
/*      */       } else {
/*      */         
/*  627 */         Lisp.error(new FileError("Unsupported directory component " + part
/*  628 */               .printObject() + ".", this));
/*      */       } 
/*      */       
/*  631 */       while (temp != Lisp.NIL) {
/*  632 */         part = temp.car();
/*  633 */         if (part instanceof AbstractString) {
/*  634 */           sb.append(part.getStringValue());
/*  635 */         } else if (part == Keyword.WILD) {
/*  636 */           sb.append('*');
/*  637 */         } else if (part == Keyword.WILD_INFERIORS) {
/*  638 */           sb.append("**");
/*  639 */         } else if (part == Keyword.UP) {
/*  640 */           sb.append("..");
/*      */         } 
/*  642 */         sb.append('/');
/*  643 */         temp = temp.cdr();
/*      */       } 
/*      */     } 
/*  646 */     return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public boolean equal(LispObject obj) {
/*  652 */     if (this == obj) {
/*  653 */       return true;
/*      */     }
/*  655 */     if (obj instanceof Pathname) {
/*  656 */       Pathname p = (Pathname)obj;
/*  657 */       if (Utilities.isPlatformWindows) {
/*  658 */         if (!this.host.equalp(p.host)) {
/*  659 */           return false;
/*      */         }
/*  661 */         if (!this.device.equalp(p.device)) {
/*  662 */           return false;
/*      */         }
/*  664 */         if (!this.directory.equalp(p.directory)) {
/*  665 */           return false;
/*      */         }
/*  667 */         if (!this.name.equalp(p.name)) {
/*  668 */           return false;
/*      */         }
/*  670 */         if (!this.type.equalp(p.type)) {
/*  671 */           return false;
/*      */         
/*      */         }
/*      */       
/*      */       }
/*      */       else {
/*      */         
/*  678 */         if (!this.host.equal(p.host)) {
/*  679 */           return false;
/*      */         }
/*  681 */         if (!this.device.equal(p.device)) {
/*  682 */           return false;
/*      */         }
/*  684 */         if (!this.directory.equal(p.directory)) {
/*  685 */           return false;
/*      */         }
/*  687 */         if (!this.name.equal(p.name)) {
/*  688 */           return false;
/*      */         }
/*  690 */         if (!this.type.equal(p.type)) {
/*  691 */           return false;
/*      */         }
/*      */       } 
/*      */ 
/*      */ 
/*      */       
/*  697 */       return true;
/*      */     } 
/*  699 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean equalp(LispObject obj) {
/*  704 */     return equal(obj);
/*      */   }
/*      */   
/*      */   public boolean equals(Object o) {
/*  708 */     if (!getClass().isAssignableFrom(o.getClass())) {
/*  709 */       return super.equals(o);
/*      */     }
/*  711 */     return equal((Pathname)o);
/*      */   }
/*      */   
/*      */   public int hashCode() {
/*  715 */     return sxhash();
/*      */   }
/*      */ 
/*      */   
/*      */   public int sxhash() {
/*  720 */     return (getHost().sxhash() ^ 
/*  721 */       getDevice().sxhash() ^ 
/*  722 */       getDirectory().sxhash() ^ 
/*  723 */       getName().sxhash() ^ 
/*  724 */       getType().sxhash()) & Integer.MAX_VALUE;
/*      */   }
/*      */   
/*      */   public String printObject() {
/*      */     boolean useNamestring;
/*  729 */     LispThread thread = LispThread.currentThread();
/*  730 */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/*  731 */     boolean printEscape = (Symbol.PRINT_ESCAPE.symbolValue(thread) != Lisp.NIL);
/*      */     
/*  733 */     String s = null;
/*  734 */     s = getNamestring();
/*  735 */     if (s != null) {
/*  736 */       useNamestring = true;
/*  737 */       if (printReadably)
/*      */       {
/*      */         
/*  740 */         if ((getHost() != Lisp.NIL && !isURL()) || 
/*  741 */           getVersion() != Lisp.NIL) {
/*      */           
/*  743 */           useNamestring = false;
/*  744 */         } else if (getName() instanceof AbstractString) {
/*  745 */           String n = getName().getStringValue();
/*  746 */           if (n.equals(".") || n.equals("..")) {
/*  747 */             useNamestring = false;
/*      */           }
/*  749 */           else if (n.indexOf(File.separatorChar) >= 0) {
/*  750 */             useNamestring = false;
/*      */           } 
/*      */         } 
/*      */       }
/*      */     } else {
/*  755 */       useNamestring = false;
/*      */     } 
/*  757 */     StringBuilder sb = new StringBuilder();
/*      */     
/*  759 */     if (useNamestring) {
/*  760 */       if (printReadably || printEscape) {
/*  761 */         sb.append("#P\"");
/*      */       }
/*  763 */       int limit = s.length();
/*  764 */       for (int i = 0; i < limit; i++) {
/*  765 */         char c = s.charAt(i);
/*  766 */         if ((printReadably || printEscape) && (
/*  767 */           c == '"' || c == '\\')) {
/*  768 */           sb.append('\\');
/*      */         }
/*      */         
/*  771 */         sb.append(c);
/*      */       } 
/*  773 */       if (printReadably || printEscape) {
/*  774 */         sb.append('"');
/*      */       }
/*  776 */       return sb.toString();
/*      */     } 
/*      */     
/*  779 */     sb.append("PATHNAME (with no namestring) ");
/*  780 */     if (getHost() != Lisp.NIL) {
/*  781 */       sb.append(":HOST ")
/*  782 */         .append(getHost().printObject())
/*  783 */         .append(" ");
/*      */     }
/*  785 */     if (getDevice() != Lisp.NIL) {
/*  786 */       sb.append(":DEVICE ")
/*  787 */         .append(getDevice().printObject())
/*  788 */         .append(" ");
/*      */     }
/*  790 */     if (getDirectory() != Lisp.NIL) {
/*  791 */       sb.append(":DIRECTORY ")
/*  792 */         .append(getDirectory().printObject())
/*  793 */         .append(" ");
/*      */     }
/*  795 */     if (getName() != Lisp.NIL) {
/*  796 */       sb.append(":NAME ")
/*  797 */         .append(getName().printObject())
/*  798 */         .append(" ");
/*      */     }
/*  800 */     if (getType() != Lisp.NIL) {
/*  801 */       sb.append(":TYPE ")
/*  802 */         .append(getType().printObject())
/*  803 */         .append(" ");
/*      */     }
/*  805 */     if (getVersion() != Lisp.NIL) {
/*  806 */       sb.append(":VERSION ")
/*  807 */         .append(getVersion().printObject())
/*  808 */         .append(" ");
/*      */     }
/*  810 */     if (sb.charAt(sb.length() - 1) == ' ') {
/*  811 */       sb.setLength(sb.length() - 1);
/*      */     }
/*      */     
/*  814 */     return unreadableString(sb.toString());
/*      */   }
/*      */   
/*      */   public static Pathname parseNamestring(String s) {
/*  818 */     return create(s);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static boolean isValidURL(String s) {
/*  824 */     if (Utilities.isPlatformWindows && s.length() >= 2 && s.charAt(1) == ':') {
/*  825 */       char c = s.charAt(0);
/*  826 */       if (('A' <= s.charAt(0) && s.charAt(0) <= 'Z') || ('a' <= s
/*  827 */         .charAt(0) && s.charAt(0) <= 'z')) {
/*  828 */         return false;
/*      */       }
/*      */     } 
/*  831 */     if (s.indexOf(':') == -1) {
/*  832 */       return false;
/*      */     }
/*      */     try {
/*  835 */       URL uRL = new URL(s);
/*  836 */     } catch (MalformedURLException e) {
/*  837 */       return false;
/*      */     } 
/*  839 */     return true;
/*      */   }
/*      */ 
/*      */   
/*      */   public static LispObject parseNamestring(AbstractString namestring) {
/*  844 */     String s = namestring.getStringValue();
/*  845 */     if (!isValidURL(s)) {
/*  846 */       String h = LogicalPathname.getHostString(s);
/*  847 */       if (h != null && LogicalPathname.TRANSLATIONS
/*  848 */         .get(new SimpleString(h)) != null)
/*      */       {
/*  850 */         return LogicalPathname.create(h, s.substring(s.indexOf(':') + 1));
/*      */       }
/*      */     } 
/*  853 */     return create(s);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public static LogicalPathname parseNamestring(AbstractString namestring, AbstractString host) {
/*  859 */     String s = namestring.getStringValue();
/*      */ 
/*      */     
/*  862 */     String h = LogicalPathname.getHostString(s);
/*  863 */     if (h != null) {
/*  864 */       if (!h.equals(host.getStringValue())) {
/*  865 */         Lisp.error(new LispError("Host in " + s + " does not match requested host " + host
/*      */               
/*  867 */               .getStringValue()));
/*      */         
/*  869 */         return null;
/*      */       } 
/*      */       
/*  872 */       s = s.substring(s.indexOf(':') + 1);
/*      */     } 
/*  874 */     if (LogicalPathname.TRANSLATIONS.get(host) != null)
/*      */     {
/*  876 */       return LogicalPathname.create(host.getStringValue(), s);
/*      */     }
/*  878 */     Lisp.error(new LispError(host.princToString() + " is not defined as a logical pathname host."));
/*      */     
/*  880 */     return null;
/*      */   }
/*      */   
/*      */   static final void checkCaseArgument(LispObject arg) {
/*  884 */     if (arg != Keyword.COMMON && arg != Keyword.LOCAL) {
/*  885 */       Lisp.type_error(arg, Lisp.list(Symbol.MEMBER, new LispObject[] { Keyword.COMMON, Keyword.LOCAL }));
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*  890 */   private static final Primitive _PATHNAME_HOST = new pf_pathname_host();
/*      */   
/*      */   @DocString(name = "%pathname-host")
/*      */   private static class pf_pathname_host extends Primitive { pf_pathname_host() {
/*  894 */       super("%pathname-host", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  898 */       Pathname.checkCaseArgument(second);
/*  899 */       return Lisp.coerceToPathname(first).getHost();
/*      */     } }
/*      */   
/*  902 */   private static final Primitive _PATHNAME_DEVICE = new pf_pathname_device();
/*      */   
/*      */   @DocString(name = "%pathname-device")
/*      */   private static class pf_pathname_device extends Primitive { pf_pathname_device() {
/*  906 */       super("%pathname-device", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  910 */       Pathname.checkCaseArgument(second);
/*  911 */       return Lisp.coerceToPathname(first).getDevice();
/*      */     } }
/*      */   
/*  914 */   private static final Primitive _PATHNAME_DIRECTORY = new pf_pathname_directory();
/*      */   
/*      */   @DocString(name = "%pathname-directory")
/*      */   private static class pf_pathname_directory extends Primitive { pf_pathname_directory() {
/*  918 */       super("%pathname-directory", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  922 */       Pathname.checkCaseArgument(second);
/*  923 */       return Lisp.coerceToPathname(first).getDirectory();
/*      */     } }
/*      */   
/*  926 */   private static final Primitive _PATHNAME_NAME = new pf_pathname_name();
/*      */   
/*      */   @DocString(name = "%pathname-name")
/*      */   private static class pf_pathname_name extends Primitive { pf_pathname_name() {
/*  930 */       super("%pathname-name", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  934 */       Pathname.checkCaseArgument(second);
/*  935 */       return Lisp.coerceToPathname(first).getName();
/*      */     } }
/*      */   
/*  938 */   private static final Primitive _PATHNAME_TYPE = new pf_pathname_type();
/*      */   
/*      */   @DocString(name = "%pathname-type")
/*      */   private static class pf_pathname_type extends Primitive { pf_pathname_type() {
/*  942 */       super("%pathname-type", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  946 */       Pathname.checkCaseArgument(second);
/*  947 */       return Lisp.coerceToPathname(first).getType();
/*      */     } }
/*      */ 
/*      */   
/*  951 */   private static final Primitive PATHNAME_VERSION = new pf_pathname_version();
/*      */   
/*      */   @DocString(name = "pathname-version", args = "pathname", returns = "version", doc = "Return the version component of PATHNAME.")
/*      */   private static class pf_pathname_version
/*      */     extends Primitive
/*      */   {
/*      */     pf_pathname_version() {
/*  958 */       super("pathname-version", "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  962 */       return Lisp.coerceToPathname(arg).getVersion();
/*      */     } }
/*      */   
/*  965 */   private static final Primitive NAMESTRING = new pf_namestring();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "namestring", args = "pathname", returns = "namestring", doc = "Returns the NAMESTRING of PATHNAME if it has one.\n\nIf PATHNAME is of type url-pathname or jar-pathname the NAMESTRING is encoded\naccording to the uri percent escape rules.\n\nSignals an error if PATHNAME lacks a printable NAMESTRING representation.\n")
/*      */   private static class pf_namestring
/*      */     extends Primitive
/*      */   {
/*      */     pf_namestring() {
/*  977 */       super("namestring", "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  981 */       Pathname pathname = Lisp.coerceToPathname(arg);
/*  982 */       String namestring = pathname.getNamestring();
/*  983 */       if (namestring == null) {
/*  984 */         Lisp.error(new SimpleError("Pathname has no namestring: " + pathname
/*  985 */               .princToString()));
/*      */       }
/*  987 */       return new SimpleString(namestring);
/*      */     }
/*      */   }
/*      */   
/*  991 */   private static final Primitive DIRECTORY_NAMESTRING = new pf_directory_namestring();
/*      */ 
/*      */   
/*      */   @DocString(name = "directory-namestring", args = "pathname", returns = "namestring", doc = "Returns the NAMESTRING of directory porition of PATHNAME if it has one.")
/*      */   private static class pf_directory_namestring
/*      */     extends Primitive
/*      */   {
/*      */     pf_directory_namestring() {
/*  999 */       super("directory-namestring", "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1003 */       return new SimpleString(Lisp.coerceToPathname(arg).getDirectoryNamestring());
/*      */     } }
/*      */   
/* 1006 */   private static final Primitive PATHNAME = new pf_pathname();
/*      */   
/*      */   @DocString(name = "pathname", args = "pathspec", returns = "pathname", doc = "Returns the PATHNAME denoted by PATHSPEC.")
/*      */   private static class pf_pathname
/*      */     extends Primitive
/*      */   {
/*      */     pf_pathname() {
/* 1013 */       super("pathname", "pathspec");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1017 */       return Lisp.coerceToPathname(arg);
/*      */     } }
/*      */   
/* 1020 */   private static final Primitive _PARSE_NAMESTRING = new pf_parse_namestring();
/*      */   
/*      */   @DocString(name = "%parse-namestring", args = "namestring host default-pathname", returns = "pathname, position")
/*      */   private static class pf_parse_namestring
/*      */     extends Primitive {
/*      */     pf_parse_namestring() {
/* 1026 */       super("%parse-namestring", Lisp.PACKAGE_SYS, false, "namestring host default-pathname");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1031 */       LispThread thread = LispThread.currentThread();
/* 1032 */       AbstractString namestring = Lisp.checkString(first);
/*      */       
/* 1034 */       if (second == Lisp.NIL) {
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */         
/* 1040 */         third = Lisp.coerceToPathname(third);
/* 1041 */         if (third instanceof LogicalPathname) {
/* 1042 */           second = ((LogicalPathname)third).getHost();
/*      */         } else {
/* 1044 */           return thread.setValues(Pathname.parseNamestring(namestring), namestring
/* 1045 */               .LENGTH());
/*      */         } 
/*      */       } 
/* 1048 */       Debug.assertTrue((second != Lisp.NIL));
/* 1049 */       AbstractString host = Lisp.checkString(second);
/* 1050 */       return thread.setValues(Pathname.parseNamestring(namestring, host), namestring
/* 1051 */           .LENGTH());
/*      */     } }
/*      */   
/* 1054 */   private static final Primitive MAKE_PATHNAME = new pf_make_pathname();
/*      */   
/*      */   @DocString(name = "make-pathname", args = "&key host device directory name type version defaults case", returns = "pathname", doc = "Constructs and returns a pathname from the supplied keyword arguments.")
/*      */   private static class pf_make_pathname
/*      */     extends Primitive
/*      */   {
/*      */     pf_make_pathname() {
/* 1061 */       super("make-pathname", "&key host device directory name type version defaults case");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1066 */       LispObject result = Pathname._makePathname(args);
/* 1067 */       return result;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   public static final Pathname makePathname(LispObject args) {
/* 1073 */     return (Pathname)_makePathname(args.copyToArray());
/*      */   }
/*      */   
/*      */   public static final Pathname makePathname(File file) {
/* 1077 */     String namestring = null;
/*      */     try {
/* 1079 */       namestring = file.getCanonicalPath();
/* 1080 */     } catch (IOException e) {
/* 1081 */       Debug.trace("Failed to make a Pathname from ." + file + "'");
/*      */       
/* 1083 */       return null;
/*      */     } 
/* 1085 */     return create(namestring);
/*      */   }
/*      */   static final LispObject _makePathname(LispObject[] args) {
/*      */     Pathname p;
/* 1089 */     if (args.length % 2 != 0) {
/* 1090 */       Lisp.program_error("Odd number of keyword arguments.");
/*      */     }
/* 1092 */     LispObject host = Lisp.NIL;
/* 1093 */     LispObject device = Lisp.NIL;
/* 1094 */     LispObject directory = Lisp.NIL;
/* 1095 */     LispObject name = Lisp.NIL;
/* 1096 */     LispObject type = Lisp.NIL;
/* 1097 */     LispObject version = Lisp.NIL;
/* 1098 */     Pathname defaults = null;
/* 1099 */     boolean hostSupplied = false;
/* 1100 */     boolean deviceSupplied = false;
/* 1101 */     boolean nameSupplied = false;
/* 1102 */     boolean typeSupplied = false;
/* 1103 */     boolean directorySupplied = false;
/* 1104 */     boolean versionSupplied = false;
/* 1105 */     for (int i = 0; i < args.length; i += 2) {
/* 1106 */       LispObject key = args[i];
/* 1107 */       LispObject value = args[i + 1];
/* 1108 */       if (key == Keyword.HOST) {
/* 1109 */         host = value;
/* 1110 */         hostSupplied = true;
/* 1111 */       } else if (key == Keyword.DEVICE) {
/* 1112 */         device = value;
/* 1113 */         deviceSupplied = true;
/* 1114 */         if (!(value instanceof AbstractString) && 
/* 1115 */           !value.equals(Keyword.UNSPECIFIC) && 
/* 1116 */           !value.equals(Lisp.NIL) && !(value instanceof Cons))
/*      */         {
/* 1118 */           return Lisp.type_error("DEVICE is not a string, :UNSPECIFIC, NIL, or a list.", value, 
/*      */               
/* 1120 */               Lisp.list(Symbol.OR, new LispObject[] { Symbol.STRING, Keyword.UNSPECIFIC, Lisp.NIL, Symbol.CONS }));
/*      */         }
/*      */       }
/* 1123 */       else if (key == Keyword.DIRECTORY) {
/* 1124 */         directorySupplied = true;
/* 1125 */         if (value instanceof AbstractString) {
/* 1126 */           directory = Lisp.list(Keyword.ABSOLUTE, new LispObject[] { value });
/* 1127 */         } else if (value == Keyword.WILD) {
/* 1128 */           directory = Lisp.list(Keyword.ABSOLUTE, new LispObject[] { Keyword.WILD });
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */         
/*      */         }
/* 1136 */         else if (value instanceof Cons || value == Keyword.UNSPECIFIC || value
/*      */ 
/*      */           
/* 1139 */           .equals(Lisp.NIL)) {
/* 1140 */           directory = value;
/*      */         } else {
/* 1142 */           return 
/* 1143 */             Lisp.type_error("DIRECTORY argument not a string, list of strings, nil, :WILD, or :UNSPECIFIC.", value, 
/*      */               
/* 1145 */               Lisp.list(Symbol.OR, new LispObject[] { Lisp.NIL, Symbol.STRING, Symbol.CONS, Keyword.WILD, Keyword.UNSPECIFIC }));
/*      */         }
/*      */       
/*      */       }
/* 1149 */       else if (key == Keyword.NAME) {
/* 1150 */         name = value;
/* 1151 */         nameSupplied = true;
/* 1152 */       } else if (key == Keyword.TYPE) {
/* 1153 */         type = value;
/* 1154 */         typeSupplied = true;
/* 1155 */       } else if (key == Keyword.VERSION) {
/* 1156 */         version = value;
/* 1157 */         versionSupplied = true;
/* 1158 */       } else if (key == Keyword.DEFAULTS) {
/* 1159 */         defaults = Lisp.coerceToPathname(value);
/* 1160 */       } else if (key == Keyword.CASE) {
/*      */       
/*      */       } 
/*      */     } 
/* 1164 */     if (defaults != null) {
/* 1165 */       if (!hostSupplied) {
/* 1166 */         host = defaults.getHost();
/*      */       }
/* 1168 */       if (!directorySupplied) {
/* 1169 */         directory = defaults.getDirectory();
/*      */       }
/* 1171 */       if (!deviceSupplied) {
/* 1172 */         device = defaults.getDevice();
/*      */       }
/* 1174 */       if (!nameSupplied) {
/* 1175 */         name = defaults.getName();
/*      */       }
/* 1177 */       if (!typeSupplied) {
/* 1178 */         type = defaults.getType();
/*      */       }
/* 1180 */       if (!versionSupplied) {
/* 1181 */         version = defaults.getVersion();
/*      */       }
/*      */     } 
/*      */ 
/*      */     
/* 1186 */     LispObject logicalHost = Lisp.NIL;
/* 1187 */     if (host != Lisp.NIL) {
/* 1188 */       if (host instanceof AbstractString) {
/* 1189 */         logicalHost = LogicalPathname.canonicalizeStringComponent((AbstractString)host);
/*      */       }
/* 1191 */       if (LogicalPathname.TRANSLATIONS.get(logicalHost) == null) {
/*      */ 
/*      */         
/* 1194 */         p = create();
/* 1195 */         p.setHost(host);
/*      */       } else {
/* 1197 */         p = LogicalPathname.create();
/* 1198 */         p.setHost(logicalHost);
/*      */       } 
/* 1200 */       if (!Utilities.isPlatformWindows) {
/* 1201 */         p.setDevice(Keyword.UNSPECIFIC);
/*      */       }
/*      */     } else {
/* 1204 */       p = create();
/*      */     } 
/*      */     
/* 1207 */     if (device != Lisp.NIL) {
/* 1208 */       if (p instanceof LogicalPathname) {
/*      */         
/* 1210 */         if (device != Keyword.UNSPECIFIC) {
/* 1211 */           return Lisp.type_error("The device component of a logical pathname must be :UNSPECIFIC.", p
/* 1212 */               .getDevice(), Keyword.UNSPECIFIC);
/*      */         }
/*      */       }
/* 1215 */       else if (device instanceof Cons) {
/* 1216 */         LispObject normalizedDevice = Lisp.NIL;
/* 1217 */         if (device.car() instanceof SimpleString) {
/* 1218 */           String rootNamestring = device.car().getStringValue();
/* 1219 */           URLPathname root = new URLPathname();
/* 1220 */           if (!isValidURL(rootNamestring)) {
/* 1221 */             Pathname rootPathname = create(rootNamestring);
/* 1222 */             root = URLPathname.createFromFile(rootPathname);
/*      */           } else {
/* 1224 */             root = URLPathname.create(rootNamestring);
/*      */           } 
/* 1226 */           normalizedDevice = normalizedDevice.push(root);
/*      */         } else {
/* 1228 */           normalizedDevice = normalizedDevice.push(device.car());
/*      */         } 
/* 1230 */         LispObject o = device.cdr();
/* 1231 */         while (!o.car().equals(Lisp.NIL)) {
/* 1232 */           Pathname next = Lisp.coerceToPathname(o.car());
/* 1233 */           normalizedDevice = normalizedDevice.push(next);
/* 1234 */           o = o.cdr();
/*      */         } 
/* 1236 */         normalizedDevice = normalizedDevice.nreverse();
/* 1237 */         p.setDevice(normalizedDevice);
/*      */       } else {
/* 1239 */         p.setDevice(device);
/*      */       } 
/*      */     }
/*      */     
/* 1243 */     if (directory != Lisp.NIL) {
/* 1244 */       if (p instanceof LogicalPathname) {
/* 1245 */         if (directory.listp()) {
/* 1246 */           LispObject d = Lisp.NIL;
/* 1247 */           while (directory != Lisp.NIL) {
/* 1248 */             LispObject component = directory.car();
/* 1249 */             if (component instanceof AbstractString) {
/* 1250 */               d = d.push(LogicalPathname.canonicalizeStringComponent((AbstractString)component));
/*      */             } else {
/* 1252 */               d = d.push(component);
/*      */             } 
/* 1254 */             directory = directory.cdr();
/*      */           } 
/* 1256 */           p.setDirectory(d.nreverse());
/* 1257 */         } else if (directory == Keyword.WILD || directory == Keyword.WILD_INFERIORS) {
/* 1258 */           p.setDirectory(directory);
/*      */         } else {
/* 1260 */           Lisp.error(new LispError("Invalid directory component for logical pathname: " + directory.princToString()));
/*      */         } 
/*      */       } else {
/* 1263 */         p.setDirectory(directory);
/*      */       } 
/*      */     }
/* 1266 */     if (name != Lisp.NIL) {
/* 1267 */       if (p instanceof LogicalPathname && name instanceof AbstractString) {
/* 1268 */         p.setName(LogicalPathname.canonicalizeStringComponent((AbstractString)name));
/* 1269 */       } else if (name instanceof AbstractString) {
/* 1270 */         p.setName(validateStringComponent((AbstractString)name));
/*      */       } else {
/* 1272 */         p.setName(name);
/*      */       } 
/*      */     }
/* 1275 */     if (type != Lisp.NIL) {
/* 1276 */       if (p instanceof LogicalPathname && type instanceof AbstractString) {
/* 1277 */         p.setType(LogicalPathname.canonicalizeStringComponent((AbstractString)type));
/*      */       } else {
/* 1279 */         p.setType(type);
/*      */       } 
/*      */     }
/*      */     
/* 1283 */     p.setVersion(version);
/* 1284 */     p.validateDirectory(true);
/*      */ 
/*      */     
/* 1287 */     if (p.getDevice() instanceof Cons) {
/* 1288 */       JarPathname result = new JarPathname();
/* 1289 */       result.copyFrom(p);
/* 1290 */       Pathname root = (Pathname)result.getDevice().car();
/* 1291 */       URLPathname rootDevice = null;
/* 1292 */       if (root instanceof URLPathname) {
/* 1293 */         rootDevice = URLPathname.create(root);
/*      */       } else {
/* 1295 */         rootDevice = URLPathname.create(root);
/*      */       } 
/* 1297 */       result.setDevice(new Cons(rootDevice, result.getDevice().cdr()));
/*      */       
/* 1299 */       if (result.getDirectory().equals(Lisp.NIL) && (
/* 1300 */         !result.getName().equals(Lisp.NIL) || 
/* 1301 */         !result.getType().equals(Lisp.NIL))) {
/* 1302 */         result.setDirectory(Lisp.NIL.push(Keyword.ABSOLUTE));
/*      */       }
/*      */ 
/*      */       
/* 1306 */       result.validateComponents();
/* 1307 */       return result;
/*      */     } 
/*      */ 
/*      */     
/* 1311 */     if (p.isURL()) {
/* 1312 */       URLPathname result = new URLPathname();
/* 1313 */       result.copyFrom(p);
/*      */       
/* 1315 */       return result;
/*      */     } 
/*      */     
/* 1318 */     return p;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private static final AbstractString validateStringComponent(AbstractString s) {
/* 1324 */     int limit = s.length();
/* 1325 */     for (int i = 0; i < limit; i++) {
/* 1326 */       char c = s.charAt(i);
/*      */       
/* 1328 */       if (c == '/' || (c == '\\' && Utilities.isPlatformWindows)) {
/* 1329 */         Lisp.error(new LispError("Invalid character #\\" + c + " in pathname component \"" + s + '"'));
/*      */ 
/*      */ 
/*      */         
/* 1333 */         return null;
/*      */       } 
/*      */     } 
/* 1336 */     return s;
/*      */   }
/*      */   
/*      */   private final boolean validateDirectory(boolean signalError) {
/* 1340 */     LispObject temp = getDirectory();
/* 1341 */     if (temp == Keyword.UNSPECIFIC) {
/* 1342 */       return true;
/*      */     }
/* 1344 */     while (temp != Lisp.NIL) {
/* 1345 */       LispObject first = temp.car();
/* 1346 */       temp = temp.cdr();
/* 1347 */       if (first == Keyword.ABSOLUTE || first == Keyword.WILD_INFERIORS) {
/* 1348 */         LispObject second = temp.car();
/* 1349 */         if (second == Keyword.UP || second == Keyword.BACK) {
/* 1350 */           if (signalError) {
/* 1351 */             StringBuilder sb = new StringBuilder();
/* 1352 */             sb.append(first.printObject());
/* 1353 */             sb.append(" may not be followed immediately by ");
/* 1354 */             sb.append(second.printObject());
/* 1355 */             sb.append('.');
/* 1356 */             Lisp.error(new FileError(sb.toString(), this));
/*      */           } 
/* 1358 */           return false;
/*      */         }  continue;
/* 1360 */       }  if (first != Keyword.RELATIVE && first != Keyword.WILD && first != Keyword.UP && first != Keyword.BACK && !(first instanceof AbstractString)) {
/*      */ 
/*      */ 
/*      */ 
/*      */         
/* 1365 */         if (signalError) {
/* 1366 */           Lisp.error(new FileError("Unsupported directory component " + first.princToString() + ".", this));
/*      */         }
/*      */         
/* 1369 */         return false;
/*      */       } 
/*      */     } 
/* 1372 */     return true;
/*      */   }
/* 1374 */   private static final Primitive PATHNAMEP = new pf_pathnamep();
/*      */   
/*      */   @DocString(name = "pathnamep", args = "object", returns = "generalized-boolean", doc = "Returns true if OBJECT is of type pathname; otherwise, returns false.")
/*      */   private static class pf_pathnamep
/*      */     extends Primitive
/*      */   {
/*      */     pf_pathnamep() {
/* 1381 */       super("pathnamep", "object");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1385 */       return (arg instanceof Pathname) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */   
/* 1388 */   private static final Primitive LOGICAL_PATHNAME_P = new pf_logical_pathname_p();
/*      */ 
/*      */   
/*      */   @DocString(name = "logical-pathname-p", args = "object", returns = "generalized-boolean", doc = "Returns true if OBJECT is of type logical-pathname; otherwise, returns false.")
/*      */   private static class pf_logical_pathname_p
/*      */     extends Primitive
/*      */   {
/*      */     pf_logical_pathname_p() {
/* 1396 */       super("logical-pathname-p", Lisp.PACKAGE_SYS, true, "object");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1400 */       return (arg instanceof LogicalPathname) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/* 1404 */   private static final Primitive USER_HOMEDIR_PATHNAME = new pf_user_homedir_pathname();
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "user-homedir-pathname", args = "&optional host", returns = "pathname", doc = "Determines the pathname that corresponds to the user's home directory.\nThe value returned is obtained from the JVM system propoerty 'user.home'.\nIf HOST is specified, returns NIL.")
/*      */   private static class pf_user_homedir_pathname
/*      */     extends Primitive
/*      */   {
/*      */     pf_user_homedir_pathname() {
/* 1413 */       super("user-homedir-pathname", "&optional host");
/*      */     }
/*      */     public LispObject execute(LispObject[] args) {
/*      */       String s;
/* 1417 */       switch (args.length) {
/*      */         case 0:
/* 1419 */           s = System.getProperty("user.home");
/* 1420 */           if (!s.endsWith(File.separator)) {
/* 1421 */             s = s.concat(File.separator);
/*      */           }
/* 1423 */           return Pathname.create(s);
/*      */         
/*      */         case 1:
/* 1426 */           return Lisp.NIL;
/*      */       } 
/* 1428 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 0, 1));
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 1433 */   private static final Primitive LIST_DIRECTORY = new pf_list_directory();
/*      */   
/*      */   @DocString(name = "list-directory", args = "directory &optional (resolve-symlinks nil)", returns = "pathnames", doc = "Lists the contents of DIRECTORY, optionally resolving symbolic links.")
/*      */   private static class pf_list_directory
/*      */     extends Primitive
/*      */   {
/*      */     pf_list_directory() {
/* 1440 */       super("list-directory", Lisp.PACKAGE_SYS, true, "directory &optional (resolve-symlinks t)");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1444 */       return execute(arg, Lisp.T);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg, LispObject resolveSymlinks) {
/* 1448 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 1449 */       if (pathname instanceof LogicalPathname) {
/* 1450 */         pathname = LogicalPathname.translateLogicalPathname((LogicalPathname)pathname);
/*      */       }
/*      */       
/* 1453 */       LispObject result = Lisp.NIL;
/* 1454 */       if (pathname.isJar()) {
/* 1455 */         return JarPathname.listDirectory((JarPathname)pathname);
/*      */       }
/*      */       
/* 1458 */       File f = pathname.getFile();
/* 1459 */       if (f.isDirectory()) {
/*      */         try {
/* 1461 */           File[] files = f.listFiles();
/* 1462 */           if (files == null) {
/* 1463 */             return Lisp.error(new FileError("Unable to list directory " + pathname
/* 1464 */                   .princToString() + ".", pathname));
/*      */           }
/*      */           
/* 1467 */           for (int i = files.length; i-- > 0; ) {
/* 1468 */             String path; File file = files[i];
/*      */             
/* 1470 */             if (resolveSymlinks == Lisp.NIL) {
/* 1471 */               path = file.getAbsolutePath();
/*      */             } else {
/* 1473 */               path = file.getCanonicalPath();
/*      */             } 
/* 1475 */             if (file.isDirectory() && 
/* 1476 */               !path.endsWith("/")) {
/* 1477 */               path = path + "/";
/*      */             }
/*      */             
/* 1480 */             Pathname p = Pathname.create(path);
/* 1481 */             result = new Cons(p, result);
/*      */           } 
/* 1483 */         } catch (IOException e) {
/* 1484 */           return Lisp.error(new FileError("Unable to list directory " + pathname
/* 1485 */                 .princToString() + ".", pathname));
/*      */         }
/* 1487 */         catch (SecurityException e) {
/* 1488 */           return Lisp.error(new FileError("Unable to list directory: " + e, pathname));
/*      */         } 
/*      */       }
/* 1491 */       return result;
/*      */     }
/*      */   }
/*      */   
/*      */   public boolean isAbsolute() {
/* 1496 */     if ((!this.directory.equals(Lisp.NIL) || this.directory != null) && 
/* 1497 */       getDirectory() instanceof Cons && (
/* 1498 */       (Cons)getDirectory()).car().equals(Keyword.ABSOLUTE)) {
/* 1499 */       return true;
/*      */     }
/*      */ 
/*      */     
/* 1503 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "pathname-jar-p", args = "pathname", returns = "generalized-boolean", doc = "Predicate functionfor whether PATHNAME references a jar.")
/* 1511 */   private static final Primitive PATHNAME_JAR_P = new pf_pathname_jar_p();
/*      */   
/*      */   private static class pf_pathname_jar_p extends Primitive { pf_pathname_jar_p() {
/* 1514 */       super("pathname-jar-p", Lisp.PACKAGE_EXT, true);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1518 */       if (arg instanceof Pathname) {
/* 1519 */         Pathname p = Lisp.coerceToPathname(arg);
/* 1520 */         return p.isJar() ? Lisp.T : Lisp.NIL;
/*      */       } 
/* 1522 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*      */   public boolean isJar() {
/* 1528 */     return getDevice() instanceof Cons;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "pathname-url-p", args = "pathname", returns = "generalized-boolean", doc = "Predicate function for whether PATHNAME references a jaurl.")
/* 1536 */   private static final Primitive PATHNAME_URL_P = new pf_pathname_url_p();
/*      */   
/*      */   private static class pf_pathname_url_p extends Primitive { pf_pathname_url_p() {
/* 1539 */       super("pathname-url-p", Lisp.PACKAGE_EXT, true, "pathname", "Predicate for whether PATHNAME references a URL.");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1544 */       if (arg instanceof Pathname) {
/* 1545 */         Pathname p = Lisp.coerceToPathname(arg);
/* 1546 */         return p.isURL() ? Lisp.T : Lisp.NIL;
/*      */       } 
/* 1548 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*      */   public boolean isURL() {
/* 1554 */     return getHost() instanceof Cons;
/*      */   }
/*      */   
/*      */   public boolean isWild() {
/* 1558 */     if (getHost() == Keyword.WILD || getHost() == Keyword.WILD_INFERIORS) {
/* 1559 */       return true;
/*      */     }
/* 1561 */     if (getDevice() == Keyword.WILD || getDevice() == Keyword.WILD_INFERIORS) {
/* 1562 */       return true;
/*      */     }
/* 1564 */     if (getDirectory() instanceof Cons) {
/* 1565 */       if (Lisp.memq(Keyword.WILD, getDirectory())) {
/* 1566 */         return true;
/*      */       }
/* 1568 */       if (Lisp.memq(Keyword.WILD_INFERIORS, getDirectory())) {
/* 1569 */         return true;
/*      */       }
/* 1571 */       Cons d = (Cons)getDirectory();
/*      */       while (true) {
/* 1573 */         if (d.car() instanceof AbstractString) {
/* 1574 */           String s = d.car().printObject();
/* 1575 */           if (s.contains("*")) {
/* 1576 */             return true;
/*      */           }
/*      */         } 
/* 1579 */         if (d.cdr() == Lisp.NIL || !(d.cdr() instanceof Cons)) {
/*      */           break;
/*      */         }
/* 1582 */         d = (Cons)d.cdr();
/*      */       } 
/*      */     } 
/* 1585 */     if (getName() == Keyword.WILD || getName() == Keyword.WILD_INFERIORS) {
/* 1586 */       return true;
/*      */     }
/* 1588 */     if (getName() instanceof AbstractString && 
/* 1589 */       getName().printObject().contains("*")) {
/* 1590 */       return true;
/*      */     }
/*      */     
/* 1593 */     if (getType() == Keyword.WILD || getType() == Keyword.WILD_INFERIORS) {
/* 1594 */       return true;
/*      */     }
/* 1596 */     if (getType() instanceof AbstractString && 
/* 1597 */       getType().printObject().contains("*")) {
/* 1598 */       return true;
/*      */     }
/*      */     
/* 1601 */     if (getVersion() == Keyword.WILD || getVersion() == Keyword.WILD_INFERIORS) {
/* 1602 */       return true;
/*      */     }
/* 1604 */     return false;
/*      */   }
/*      */   
/* 1607 */   private static final Primitive _WILD_PATHNAME_P = new pf_wild_pathname_p();
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "%wild-pathname-p", args = "pathname keyword", returns = "generalized-boolean", doc = "Predicate for determing whether PATHNAME contains wild components.\nKEYWORD, if non-nil, should be one of :directory, :host, :device,\n:name, :type, or :version indicating that only the specified component\nshould be checked for wildness.")
/*      */   static final class pf_wild_pathname_p
/*      */     extends Primitive
/*      */   {
/*      */     pf_wild_pathname_p() {
/* 1617 */       super("%wild-pathname-p", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       LispObject value;
/* 1621 */       Pathname pathname = Lisp.coerceToPathname(first);
/* 1622 */       if (second == Lisp.NIL) {
/* 1623 */         return pathname.isWild() ? Lisp.T : Lisp.NIL;
/*      */       }
/* 1625 */       if (second == Keyword.DIRECTORY) {
/* 1626 */         if (pathname.getDirectory() instanceof Cons) {
/* 1627 */           if (Lisp.memq(Keyword.WILD, pathname.getDirectory())) {
/* 1628 */             return Lisp.T;
/*      */           }
/* 1630 */           if (Lisp.memq(Keyword.WILD_INFERIORS, pathname.getDirectory())) {
/* 1631 */             return Lisp.T;
/*      */           }
/*      */         } 
/* 1634 */         return Lisp.NIL;
/*      */       } 
/*      */       
/* 1637 */       if (second == Keyword.HOST) {
/* 1638 */         value = pathname.getHost();
/* 1639 */       } else if (second == Keyword.DEVICE) {
/* 1640 */         value = pathname.getDevice();
/* 1641 */       } else if (second == Keyword.NAME) {
/* 1642 */         value = pathname.getName();
/* 1643 */       } else if (second == Keyword.TYPE) {
/* 1644 */         value = pathname.getType();
/* 1645 */       } else if (second == Keyword.VERSION) {
/* 1646 */         value = pathname.getVersion();
/*      */       } else {
/* 1648 */         return Lisp.program_error("Unrecognized keyword " + second
/* 1649 */             .princToString() + ".");
/*      */       } 
/* 1651 */       if (value == Keyword.WILD || value == Keyword.WILD_INFERIORS) {
/* 1652 */         return Lisp.T;
/*      */       }
/* 1654 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 1659 */   static final Primitive MERGE_PATHNAMES = new pf_merge_pathnames();
/*      */ 
/*      */   
/*      */   @DocString(name = "merge-pathnames", args = "pathname &optional default-pathname default-version", returns = "pathname", doc = "Constructs a pathname from PATHNAME by filling in any unsupplied components\nwith the corresponding values from DEFAULT-PATHNAME and DEFAULT-VERSION.")
/*      */   static final class pf_merge_pathnames
/*      */     extends Primitive
/*      */   {
/*      */     pf_merge_pathnames() {
/* 1667 */       super(Symbol.MERGE_PATHNAMES, "pathname &optional default-pathname default-version");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1671 */       Pathname pathname = Lisp.coerceToPathname(arg);
/*      */       
/* 1673 */       Pathname defaultPathname = Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue());
/* 1674 */       LispObject defaultVersion = Keyword.NEWEST;
/* 1675 */       return Pathname.mergePathnames(pathname, defaultPathname, defaultVersion);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1679 */       Pathname pathname = Lisp.coerceToPathname(first);
/* 1680 */       Pathname defaultPathname = Lisp.coerceToPathname(second);
/* 1681 */       LispObject defaultVersion = Keyword.NEWEST;
/* 1682 */       return Pathname.mergePathnames(pathname, defaultPathname, defaultVersion);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1687 */       Pathname pathname = Lisp.coerceToPathname(first);
/* 1688 */       Pathname defaultPathname = Lisp.coerceToPathname(second);
/* 1689 */       LispObject defaultVersion = third;
/* 1690 */       return Pathname.mergePathnames(pathname, defaultPathname, defaultVersion);
/*      */     }
/*      */   }
/*      */   
/*      */   public static final Pathname mergePathnames(Pathname pathname, Pathname defaultPathname) {
/* 1695 */     return mergePathnames(pathname, defaultPathname, Keyword.NEWEST);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static final Pathname mergePathnames(Pathname pathname, Pathname defaultPathname, LispObject defaultVersion) {
/* 1702 */     Pathname result, d, p = create(pathname);
/*      */ 
/*      */     
/* 1705 */     if (pathname instanceof LogicalPathname) {
/* 1706 */       result = LogicalPathname.create();
/* 1707 */       d = create(defaultPathname);
/*      */     } else {
/* 1709 */       if (pathname instanceof JarPathname || (defaultPathname instanceof JarPathname && !(pathname instanceof JarPathname) && pathname
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */         
/* 1716 */         .getHost().equals(Lisp.NIL) && pathname
/* 1717 */         .getDevice().equals(Lisp.NIL) && (pathname
/* 1718 */         .getDirectory().equals(Lisp.NIL) || pathname
/* 1719 */         .getDirectory().car().equals(Keyword.RELATIVE)))) {
/* 1720 */         result = JarPathname.create();
/* 1721 */       } else if (pathname instanceof URLPathname) {
/* 1722 */         result = URLPathname.create();
/*      */       } else {
/* 1724 */         result = create();
/*      */       } 
/*      */       
/* 1727 */       if (defaultPathname instanceof LogicalPathname) {
/* 1728 */         d = LogicalPathname.translateLogicalPathname((LogicalPathname)defaultPathname);
/*      */       }
/* 1730 */       else if (defaultPathname instanceof JarPathname) {
/* 1731 */         d = JarPathname.create((JarPathname)defaultPathname);
/* 1732 */       } else if (defaultPathname instanceof URLPathname) {
/* 1733 */         d = URLPathname.create(defaultPathname);
/*      */       } else {
/* 1735 */         d = create(defaultPathname);
/*      */       } 
/*      */     } 
/*      */ 
/*      */     
/* 1740 */     if (pathname.getHost().equals(Lisp.NIL)) {
/* 1741 */       result.setHost(d.getHost());
/*      */     } else {
/* 1743 */       result.setHost(p.getHost());
/*      */     } 
/*      */     
/* 1746 */     if (!pathname.getDevice().equals(Lisp.NIL)) {
/* 1747 */       if (!Utilities.isPlatformWindows) {
/* 1748 */         result.setDevice(p.getDevice());
/*      */       }
/* 1750 */       else if (d instanceof JarPathname && p instanceof JarPathname) {
/*      */         
/* 1752 */         result.setDevice(d.getDevice());
/*      */       } else {
/* 1754 */         result.setDevice(p.getDevice());
/*      */ 
/*      */ 
/*      */       
/*      */       }
/*      */ 
/*      */ 
/*      */     
/*      */     }
/* 1763 */     else if (d instanceof JarPathname && !(result instanceof JarPathname)) {
/*      */       
/* 1765 */       if (!Utilities.isPlatformWindows) {
/* 1766 */         result.setDevice(Keyword.UNSPECIFIC);
/*      */       } else {
/* 1768 */         result.setDevice(d.getDevice());
/*      */       }
/*      */     
/* 1771 */     } else if (p.isLocalFile()) {
/* 1772 */       result.setDevice(d.getDevice());
/*      */     } else {
/* 1774 */       result.setDevice(p.getDevice());
/*      */     } 
/*      */ 
/*      */ 
/*      */     
/* 1779 */     if (pathname.isJar()) {
/* 1780 */       result.setDirectory(p.getDirectory());
/*      */     } else {
/* 1782 */       result.setDirectory(mergeDirectories(p.getDirectory(), d.getDirectory()));
/*      */       
/* 1784 */       if (result instanceof JarPathname) {
/* 1785 */         LispObject directories = result.getDirectory();
/* 1786 */         if (!directories.car().equals(Lisp.NIL) && directories
/* 1787 */           .car().equals(Keyword.RELATIVE)) {
/* 1788 */           directories = directories.cdr().push(Keyword.ABSOLUTE);
/* 1789 */           result.setDirectory(directories);
/*      */         } 
/*      */       } 
/*      */     } 
/*      */     
/* 1794 */     if (pathname.getName() != Lisp.NIL) {
/* 1795 */       result.setName(p.getName());
/*      */     } else {
/* 1797 */       result.setName(d.getName());
/*      */     } 
/* 1799 */     if (pathname.getType() != Lisp.NIL) {
/* 1800 */       result.setType(p.getType());
/*      */     } else {
/* 1802 */       result.setType(d.getType());
/*      */     } 
/*      */ 
/*      */     
/* 1806 */     if (result instanceof JarPathname && (
/* 1807 */       !result.getName().equals(Lisp.NIL) || 
/* 1808 */       !result.getType().equals(Lisp.NIL)) && result
/* 1809 */       .getDirectory().equals(Lisp.NIL)) {
/* 1810 */       result.setDirectory(Lisp.NIL.push(Keyword.ABSOLUTE));
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/* 1829 */     if (p.getVersion() != Lisp.NIL) {
/* 1830 */       result.setVersion(p.getVersion());
/* 1831 */     } else if (p.getName() == Lisp.NIL) {
/* 1832 */       if (defaultPathname.getVersion() == Lisp.NIL) {
/* 1833 */         result.setVersion(defaultVersion);
/*      */       } else {
/* 1835 */         result.setVersion(defaultPathname.getVersion());
/*      */       } 
/* 1837 */     } else if (defaultVersion == Lisp.NIL) {
/* 1838 */       result.setVersion(p.getVersion());
/*      */     } 
/* 1840 */     if (result.getVersion() == Lisp.NIL) {
/* 1841 */       result.setVersion(defaultVersion);
/*      */     }
/*      */     
/* 1844 */     if (pathname instanceof LogicalPathname) {
/*      */       
/* 1846 */       result.setDevice(Keyword.UNSPECIFIC);
/* 1847 */       if (result.getDirectory().listp()) {
/* 1848 */         LispObject original = result.getDirectory();
/* 1849 */         LispObject canonical = Lisp.NIL;
/* 1850 */         while (original != Lisp.NIL) {
/* 1851 */           LispObject component = original.car();
/* 1852 */           if (component instanceof AbstractString) {
/* 1853 */             component = LogicalPathname.canonicalizeStringComponent((AbstractString)component);
/*      */           }
/* 1855 */           canonical = canonical.push(component);
/* 1856 */           original = original.cdr();
/*      */         } 
/* 1858 */         result.setDirectory(canonical.nreverse());
/*      */       } 
/* 1860 */       if (result.getName() instanceof AbstractString) {
/* 1861 */         result.setName(LogicalPathname.canonicalizeStringComponent((AbstractString)result.getName()));
/*      */       }
/* 1863 */       if (result.getType() instanceof AbstractString) {
/* 1864 */         result.setType(LogicalPathname.canonicalizeStringComponent((AbstractString)result.getType()));
/*      */       }
/*      */     } 
/*      */     
/* 1868 */     if (result instanceof Pathname && 
/* 1869 */       URLPathname.hasExplicitFile(result)) {
/* 1870 */       URLPathname downcastResult = new URLPathname();
/* 1871 */       downcastResult.copyFrom(result);
/* 1872 */       result = downcastResult;
/*      */     } 
/*      */     
/* 1875 */     return result;
/*      */   }
/*      */ 
/*      */   
/*      */   private static final LispObject mergeDirectories(LispObject dir, LispObject defaultDir) {
/* 1880 */     if (dir == Lisp.NIL) {
/* 1881 */       return defaultDir;
/*      */     }
/* 1883 */     if (dir.car() == Keyword.RELATIVE && defaultDir != Lisp.NIL) {
/* 1884 */       LispObject result = Lisp.NIL;
/* 1885 */       while (defaultDir != Lisp.NIL) {
/* 1886 */         result = new Cons(defaultDir.car(), result);
/* 1887 */         defaultDir = defaultDir.cdr();
/*      */       } 
/* 1889 */       dir = dir.cdr();
/* 1890 */       while (dir != Lisp.NIL) {
/* 1891 */         result = new Cons(dir.car(), result);
/* 1892 */         dir = dir.cdr();
/*      */       } 
/* 1894 */       LispObject[] array = result.copyToArray(); int i;
/* 1895 */       for (i = 0; i < array.length - 1; i++) {
/* 1896 */         if (array[i] == Keyword.BACK && (
/* 1897 */           array[i + 1] instanceof AbstractString || array[i + 1] == Keyword.WILD)) {
/* 1898 */           array[i] = null;
/* 1899 */           array[i + 1] = null;
/*      */         } 
/*      */       } 
/*      */       
/* 1903 */       result = Lisp.NIL;
/* 1904 */       for (i = 0; i < array.length; i++) {
/* 1905 */         if (array[i] != null) {
/* 1906 */           result = new Cons(array[i], result);
/*      */         }
/*      */       } 
/* 1909 */       return result;
/*      */     } 
/* 1911 */     return dir;
/*      */   }
/*      */   
/*      */   public static LispObject truename(Pathname pathname) {
/* 1915 */     return truename(pathname, false);
/*      */   }
/*      */   
/*      */   public static LispObject truename(LispObject arg) {
/* 1919 */     return truename(arg, false);
/*      */   }
/*      */   
/*      */   public static LispObject truename(LispObject arg, boolean errorIfDoesNotExist) {
/* 1923 */     Pathname pathname = Lisp.coerceToPathname(arg);
/* 1924 */     return truename(pathname, errorIfDoesNotExist);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public static LispObject truename(Pathname pathname, boolean errorIfDoesNotExist) {
/* 1933 */     if (pathname == null || pathname.equals(Lisp.NIL)) {
/* 1934 */       return doTruenameExit(pathname, errorIfDoesNotExist);
/*      */     }
/* 1936 */     if (pathname instanceof LogicalPathname) {
/* 1937 */       pathname = LogicalPathname.translateLogicalPathname((LogicalPathname)pathname);
/*      */     }
/* 1939 */     if (pathname.isWild()) {
/* 1940 */       return Lisp.error(new FileError("Fundamentally unable to find a truename for any wild pathname.", pathname));
/*      */     }
/*      */ 
/*      */     
/* 1944 */     Pathname result = mergePathnames(pathname, 
/* 1945 */         Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue()), Lisp.NIL);
/*      */     
/* 1947 */     File file = result.getFile();
/* 1948 */     if (file != null && file
/* 1949 */       .exists()) {
/* 1950 */       if (file.isDirectory()) {
/* 1951 */         result = getDirectoryPathname(file);
/*      */       } else {
/*      */         try {
/* 1954 */           result = create(file.getCanonicalPath());
/* 1955 */         } catch (IOException e) {
/* 1956 */           return Lisp.error(new FileError(e.getMessage(), pathname));
/*      */         } 
/*      */       } 
/* 1959 */       if (Utilities.isPlatformUnix) {
/* 1960 */         result.setDevice(Keyword.UNSPECIFIC);
/*      */       }
/* 1962 */       return result;
/*      */     } 
/* 1964 */     return doTruenameExit(pathname, errorIfDoesNotExist);
/*      */   }
/*      */   
/*      */   static LispObject doTruenameExit(Pathname pathname, boolean errorIfDoesNotExist) {
/* 1968 */     if (errorIfDoesNotExist) {
/* 1969 */       StringBuilder sb = new StringBuilder("The file ");
/* 1970 */       sb.append(pathname.princToString());
/* 1971 */       sb.append(" does not exist.");
/* 1972 */       return Lisp.error(new FileError(sb.toString(), pathname));
/*      */     } 
/* 1974 */     return Lisp.NIL;
/*      */   }
/*      */   
/* 1977 */   public static final Primitive GET_INPUT_STREAM = new pf_get_input_stream();
/*      */   
/*      */   @DocString(name = "get-input-stream", args = "pathname", doc = "Returns a java.io.InputStream for resource denoted by PATHNAME.")
/*      */   private static final class pf_get_input_stream
/*      */     extends Primitive {
/*      */     pf_get_input_stream() {
/* 1983 */       super(Symbol.GET_INPUT_STREAM, "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject pathname) {
/* 1987 */       Pathname p = Lisp.coerceToPathname(pathname);
/* 1988 */       return new JavaObject(p.getInputStream());
/*      */     }
/*      */   }
/*      */   
/*      */   public InputStream getInputStream() {
/* 1993 */     InputStream result = null;
/* 1994 */     File file = getFile();
/*      */     try {
/* 1996 */       result = new FileInputStream(file);
/* 1997 */     } catch (IOException e) {
/* 1998 */       Lisp.simple_error("Failed to get InputStream from ~a because ~a", new Object[] { this, e });
/*      */     } 
/* 2000 */     return result;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public long getLastModified() {
/* 2007 */     File f = getFile();
/* 2008 */     return f.lastModified();
/*      */   }
/*      */   
/* 2011 */   private static final Primitive MKDIR = new pf_mkdir();
/*      */   
/*      */   @DocString(name = "mkdir", args = "pathname", returns = "generalized-boolean", doc = "Attempts to create directory at PATHNAME returning the success or failure.")
/*      */   private static class pf_mkdir
/*      */     extends Primitive
/*      */   {
/*      */     pf_mkdir() {
/* 2018 */       super("mkdir", Lisp.PACKAGE_SYS, false, "pathname");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2023 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 2024 */       if (pathname.isWild()) {
/* 2025 */         Lisp.error(new FileError("Bad place for a wild pathname.", pathname));
/*      */       }
/*      */       
/* 2028 */       Pathname defaultedPathname = Pathname.mergePathnames(pathname, 
/* 2029 */           Lisp.coerceToPathname(Symbol.DEFAULT_PATHNAME_DEFAULTS.symbolValue()), Lisp.NIL);
/*      */       
/* 2031 */       if (defaultedPathname.isURL() || defaultedPathname.isJar()) {
/* 2032 */         return new FileError("Cannot mkdir with a " + (
/* 2033 */             defaultedPathname.isURL() ? "URL" : "jar") + " Pathname.", defaultedPathname);
/*      */       }
/*      */ 
/*      */ 
/*      */       
/* 2038 */       File file = defaultedPathname.getFile();
/* 2039 */       return file.mkdir() ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/* 2043 */   private static final Primitive RENAME_FILE = new pf_rename_file();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "rename-file", args = "filespec new-name", returns = "defaulted-new-name, old-truename, new-truename", doc = "Modifies the file system in such a way that the file indicated by FILESPEC is renamed to DEFAULTED-NEW-NAME.\n\nReturns three values if successful. The primary value, DEFAULTED-NEW-NAME, is \nthe resulting name which is composed of NEW-NAME with any missing components filled in by \nperforming a merge-pathnames operation using filespec as the defaults. The secondary \nvalue, OLD-TRUENAME, is the truename of the file before it was renamed. The tertiary \nvalue, NEW-TRUENAME, is the truename of the file after it was renamed.\n")
/*      */   private static class pf_rename_file
/*      */     extends Primitive
/*      */   {
/*      */     pf_rename_file() {
/* 2056 */       super("rename-file", "filespec new-name");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2060 */       Pathname oldPathname = Lisp.coerceToPathname(first);
/* 2061 */       Pathname oldTruename = (Pathname)Symbol.TRUENAME.execute(oldPathname);
/* 2062 */       Pathname newName = Lisp.coerceToPathname(second);
/* 2063 */       if (newName.isWild()) {
/* 2064 */         Lisp.error(new FileError("Bad place for a wild pathname.", newName));
/*      */       }
/* 2066 */       if (oldTruename.isJar()) {
/* 2067 */         Lisp.error(new FileError("Bad place for a jar pathname.", oldTruename));
/*      */       }
/* 2069 */       if (newName.isJar()) {
/* 2070 */         Lisp.error(new FileError("Bad place for a jar pathname.", newName));
/*      */       }
/* 2072 */       if (oldTruename.isURL()) {
/* 2073 */         Lisp.error(new FileError("Bad place for a URL pathname.", oldTruename));
/*      */       }
/* 2075 */       if (newName.isURL()) {
/* 2076 */         Lisp.error(new FileError("Bad place for a jar pathname.", newName));
/*      */       }
/*      */       
/* 2079 */       Pathname defaultedNewName = Pathname.mergePathnames(newName, oldTruename, Lisp.NIL);
/*      */       
/* 2081 */       File source = oldTruename.getFile();
/* 2082 */       File destination = null;
/* 2083 */       if (defaultedNewName instanceof LogicalPathname) {
/*      */         
/* 2085 */         destination = LogicalPathname.translateLogicalPathname((LogicalPathname)defaultedNewName).getFile();
/*      */       } else {
/* 2087 */         destination = defaultedNewName.getFile();
/*      */       } 
/* 2089 */       if (Utilities.isPlatformWindows && 
/* 2090 */         destination.isFile())
/*      */       {
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */         
/* 2097 */         destination.delete();
/*      */       }
/*      */       
/* 2100 */       if (source.renameTo(destination)) {
/* 2101 */         Pathname newTruename = (Pathname)Pathname.truename(defaultedNewName, true);
/* 2102 */         return LispThread.currentThread().setValues(defaultedNewName, oldTruename, newTruename);
/*      */       } 
/*      */ 
/*      */       
/* 2106 */       return Lisp.error(new FileError("Unable to rename " + oldTruename
/* 2107 */             .princToString() + " to " + newName
/* 2108 */             .princToString() + ".", oldTruename));
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2115 */   private static final Primitive FILE_NAMESTRING = new pf_file_namestring();
/*      */   
/*      */   @DocString(name = "file-namestring", args = "pathname", returns = "namestring", doc = "Returns just the name, type, and version components of PATHNAME.")
/*      */   private static class pf_file_namestring
/*      */     extends Primitive
/*      */   {
/*      */     pf_file_namestring() {
/* 2122 */       super(Symbol.FILE_NAMESTRING, "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2126 */       Pathname p = Lisp.coerceToPathname(arg);
/* 2127 */       StringBuilder sb = new StringBuilder();
/* 2128 */       if (p.getName() instanceof AbstractString) {
/* 2129 */         sb.append(p.getName().getStringValue());
/* 2130 */       } else if (p.getName() == Keyword.WILD) {
/* 2131 */         sb.append('*');
/*      */       } else {
/* 2133 */         return Lisp.NIL;
/*      */       } 
/* 2135 */       if (p.getType() instanceof AbstractString) {
/* 2136 */         sb.append('.');
/* 2137 */         sb.append(p.getType().getStringValue());
/* 2138 */       } else if (p.getType() == Keyword.WILD) {
/* 2139 */         sb.append(".*");
/*      */       } 
/* 2141 */       return new SimpleString(sb);
/*      */     }
/*      */   }
/*      */   
/* 2145 */   private static final Primitive HOST_NAMESTRING = new pf_host_namestring();
/*      */   
/*      */   @DocString(name = "host-namestring", args = "pathname", returns = "namestring", doc = "Returns the host name of PATHNAME.")
/*      */   private static class pf_host_namestring
/*      */     extends Primitive
/*      */   {
/*      */     pf_host_namestring() {
/* 2152 */       super("host-namestring", "pathname");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2156 */       return Lisp.coerceToPathname(arg).getHost();
/*      */     }
/*      */   }
/*      */   
/*      */   static {
/* 2161 */     LispObject obj = Symbol.DEFAULT_PATHNAME_DEFAULTS.getSymbolValue();
/* 2162 */     Symbol.DEFAULT_PATHNAME_DEFAULTS.setSymbolValue(Lisp.coerceToPathname(obj));
/*      */   }
/*      */ 
/*      */   
/*      */   File getFile() {
/* 2167 */     String namestring = getNamestring();
/* 2168 */     if (namestring != null) {
/* 2169 */       return new File(namestring);
/*      */     }
/* 2171 */     Lisp.error(new FileError("Pathname has no namestring: " + princToString(), this));
/*      */     
/* 2173 */     return (File)Lisp.UNREACHED;
/*      */   }
/*      */   
/*      */   public static Pathname getDirectoryPathname(File file) {
/*      */     try {
/* 2178 */       String namestring = file.getCanonicalPath();
/* 2179 */       if (namestring != null && namestring.length() > 0)
/*      */       {
/* 2181 */         if (namestring.charAt(namestring.length() - 1) != File.separatorChar) {
/* 2182 */           namestring = namestring.concat(File.separator);
/*      */         }
/*      */       }
/* 2185 */       return create(namestring);
/* 2186 */     } catch (IOException e) {
/* 2187 */       Lisp.error(new LispError(e.getMessage()));
/*      */       
/* 2189 */       return null;
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public boolean isLocalFile() {
/* 2196 */     if (getHost().equals(Lisp.NIL) || Symbol.GETF
/* 2197 */       .execute(getHost(), URLPathname.SCHEME, Lisp.NIL).equals(URLPathname.FILE)) {
/* 2198 */       return true;
/*      */     }
/* 2200 */     return false;
/*      */   }
/*      */   
/*      */   Pathname getEntryPath() {
/* 2204 */     return create(asEntryPath());
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   String asEntryPath() {
/* 2213 */     Pathname p = create();
/* 2214 */     p.setDirectory(getDirectory())
/* 2215 */       .setName(getName())
/* 2216 */       .setType(getType());
/* 2217 */     String path = p.getNamestring();
/*      */     
/* 2219 */     StringBuilder result = new StringBuilder();
/* 2220 */     result.append(path);
/*      */ 
/*      */     
/* 2223 */     if (result.length() > 1 && result
/* 2224 */       .substring(0, 1).equals("/")) {
/* 2225 */       return result.substring(1);
/*      */     }
/* 2227 */     return result.toString();
/*      */   }
/*      */   
/*      */   boolean isRemote() {
/* 2231 */     if (this instanceof URLPathname) {
/* 2232 */       URLPathname p = (URLPathname)this;
/* 2233 */       LispObject scheme = Symbol.GETF.execute(p.getHost(), URLPathname.SCHEME, Lisp.NIL);
/* 2234 */       if (scheme.equals(Lisp.NIL) || p
/* 2235 */         .getHost().getStringValue().equals("file")) {
/* 2236 */         return false;
/*      */       }
/* 2238 */       return true;
/* 2239 */     }  if (this instanceof JarPathname) {
/* 2240 */       Pathname root = (Pathname)((JarPathname)this).getRootJar();
/* 2241 */       return root.isRemote();
/*      */     } 
/* 2243 */     return false;
/*      */   }
/*      */   
/*      */   protected Pathname() {}
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Pathname.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */