/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.text.MessageFormat;
/*     */ import java.util.HashMap;
/*     */ import java.util.StringTokenizer;
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
/*     */ public final class LogicalPathname
/*     */   extends Pathname
/*     */ {
/*     */   public static final String LOGICAL_PATHNAME_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-;*.";
/*  46 */   private static final HashMap map = new HashMap<>();
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  52 */   public static HashTable TRANSLATIONS = HashTable.newEqualHashTable("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-;*.".length(), Lisp.NIL, Lisp.NIL);
/*     */   
/*  54 */   private static final Symbol _TRANSLATIONS_ = Lisp.exportSpecial("*LOGICAL-PATHNAME-TRANSLATIONS*", Lisp.PACKAGE_SYS, TRANSLATIONS);
/*     */   
/*     */   public static boolean isValidLogicalPathname(String namestring) {
/*  57 */     if (!isValidURL(namestring)) {
/*  58 */       String host = getHostString(namestring);
/*  59 */       if (host != null && TRANSLATIONS
/*  60 */         .get(new SimpleString(host)) != null) {
/*  61 */         return true;
/*     */       }
/*     */     } 
/*  64 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static LogicalPathname create() {
/*  72 */     return new LogicalPathname();
/*     */   }
/*     */   
/*     */   public static LogicalPathname create(LogicalPathname p) {
/*  76 */     Pathname pathname = new Pathname();
/*  77 */     pathname.copyFrom(p);
/*  78 */     LogicalPathname result = new LogicalPathname();
/*  79 */     Pathname.ncoerce(pathname, result);
/*  80 */     return result;
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public static LogicalPathname create(String namestring) {
/*  87 */     LogicalPathname result = null;
/*  88 */     if (isValidLogicalPathname(namestring)) {
/*  89 */       String h = getHostString(namestring);
/*     */       
/*  91 */       result = create(h, namestring.substring(namestring.indexOf(':') + 1));
/*  92 */       return result;
/*     */     } 
/*  94 */     Lisp.error(new FileError("Failed to find a valid logical Pathname host in '" + namestring + "'", Lisp.NIL));
/*     */ 
/*     */ 
/*     */     
/*  98 */     return (LogicalPathname)Lisp.UNREACHED;
/*     */   }
/*     */ 
/*     */   
/*     */   public static LogicalPathname create(String host, String rest) {
/* 103 */     SimpleString h = new SimpleString(host);
/* 104 */     if (TRANSLATIONS.get(h) == null) {
/*     */       
/* 106 */       String message = MessageFormat.format("'{0}' is not a defined logical host", new Object[] { host });
/* 107 */       Lisp.error(new SimpleError(message));
/*     */     } 
/* 109 */     LogicalPathname result = new LogicalPathname();
/* 110 */     int limit = rest.length();
/* 111 */     for (int i = 0; i < limit; i++) {
/* 112 */       char c = rest.charAt(i);
/* 113 */       if ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-;*.".indexOf(c) < 0) {
/* 114 */         Lisp.error(new ParseError("The character #\\" + c + " is not valid in a logical pathname."));
/*     */       }
/*     */     } 
/*     */ 
/*     */     
/* 119 */     result.setHost(h);
/*     */ 
/*     */ 
/*     */     
/* 123 */     result.setDevice(Keyword.UNSPECIFIC);
/*     */     
/* 125 */     int semi = rest.lastIndexOf(';');
/* 126 */     if (semi >= 0) {
/*     */       
/* 128 */       String d = rest.substring(0, semi + 1);
/* 129 */       result.setDirectory(parseDirectory(d));
/* 130 */       rest = rest.substring(semi + 1);
/*     */     
/*     */     }
/*     */     else {
/*     */       
/* 135 */       result.setDirectory(new Cons(Keyword.ABSOLUTE));
/*     */     } 
/*     */     
/* 138 */     int dot = rest.indexOf('.');
/* 139 */     if (dot >= 0) {
/* 140 */       String n = rest.substring(0, dot);
/* 141 */       if (n.equals("*")) {
/* 142 */         result.setName(Keyword.WILD);
/*     */       } else {
/* 144 */         result.setName(new SimpleString(n.toUpperCase()));
/*     */       } 
/* 146 */       rest = rest.substring(dot + 1);
/* 147 */       dot = rest.indexOf('.');
/* 148 */       if (dot >= 0) {
/* 149 */         String t = rest.substring(0, dot);
/* 150 */         if (t.equals("*")) {
/* 151 */           result.setType(Keyword.WILD);
/*     */         } else {
/* 153 */           result.setType(new SimpleString(t.toUpperCase()));
/*     */         } 
/*     */         
/* 156 */         String v = rest.substring(dot + 1);
/* 157 */         if (v.equals("*")) {
/* 158 */           result.setVersion(Keyword.WILD);
/* 159 */         } else if (v.equals("NEWEST") || v.equals("newest")) {
/* 160 */           result.setVersion(Keyword.NEWEST);
/*     */         } else {
/* 162 */           result.setVersion(Lisp.PACKAGE_CL.intern("PARSE-INTEGER").execute(new SimpleString(v)));
/*     */         } 
/*     */       } else {
/* 165 */         String t = rest;
/* 166 */         if (t.equals("*")) {
/* 167 */           result.setType(Keyword.WILD);
/*     */         } else {
/* 169 */           result.setType(new SimpleString(t.toUpperCase()));
/*     */         } 
/*     */       } 
/*     */     } else {
/* 173 */       String n = rest;
/* 174 */       if (n.equals("*")) {
/* 175 */         result.setName(Keyword.WILD);
/* 176 */       } else if (n.length() > 0) {
/* 177 */         result.setName(new SimpleString(n.toUpperCase()));
/*     */       } 
/*     */     } 
/* 180 */     return result;
/*     */   }
/*     */   
/*     */   public static final SimpleString canonicalizeStringComponent(AbstractString s) {
/* 184 */     int limit = s.length();
/* 185 */     for (int i = 0; i < limit; i++) {
/* 186 */       char c = s.charAt(i);
/* 187 */       if ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-;*.".indexOf(c) < 0) {
/* 188 */         Lisp.error(new ParseError("Invalid character #\\" + c + " in logical pathname component \"" + s + '"'));
/*     */ 
/*     */ 
/*     */         
/* 192 */         return null;
/*     */       } 
/*     */     } 
/* 195 */     return new SimpleString(s.getStringValue().toUpperCase());
/*     */   }
/*     */   
/*     */   public static Pathname translateLogicalPathname(LogicalPathname pathname) {
/* 199 */     return (Pathname)Symbol.TRANSLATE_LOGICAL_PATHNAME.execute(pathname);
/*     */   }
/*     */   
/*     */   private static final LispObject parseDirectory(String s) {
/*     */     LispObject result;
/* 204 */     if (s.charAt(0) == ';') {
/* 205 */       result = new Cons(Keyword.RELATIVE);
/* 206 */       s = s.substring(1);
/*     */     } else {
/* 208 */       result = new Cons(Keyword.ABSOLUTE);
/* 209 */     }  StringTokenizer st = new StringTokenizer(s, ";");
/* 210 */     while (st.hasMoreTokens()) {
/* 211 */       LispObject obj; String token = st.nextToken();
/*     */       
/* 213 */       if (token.equals("*")) {
/* 214 */         obj = Keyword.WILD;
/* 215 */       } else if (token.equals("**")) {
/* 216 */         obj = Keyword.WILD_INFERIORS;
/* 217 */       } else if (token.equals("..")) {
/* 218 */         if (result.car() instanceof AbstractString) {
/* 219 */           result = result.cdr();
/*     */           continue;
/*     */         } 
/* 222 */         obj = Keyword.UP;
/*     */       } else {
/* 224 */         obj = new SimpleString(token.toUpperCase());
/* 225 */       }  result = new Cons(obj, result);
/*     */     } 
/* 227 */     return result.nreverse();
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/* 232 */     return Symbol.LOGICAL_PATHNAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/* 237 */     return BuiltInClass.LOGICAL_PATHNAME;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 242 */     if (type == Symbol.LOGICAL_PATHNAME)
/* 243 */       return Lisp.T; 
/* 244 */     if (type == BuiltInClass.LOGICAL_PATHNAME)
/* 245 */       return Lisp.T; 
/* 246 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   protected String getDirectoryNamestring() {
/* 251 */     StringBuilder sb = new StringBuilder();
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 256 */     if (getDirectory() != Lisp.NIL) {
/* 257 */       LispObject temp = getDirectory();
/* 258 */       LispObject part = temp.car();
/* 259 */       if (part != Keyword.ABSOLUTE)
/* 260 */         if (part == Keyword.RELATIVE) {
/* 261 */           sb.append(';');
/*     */         } else {
/* 263 */           Lisp.error(new FileError("Unsupported directory component " + part.princToString() + ".", this));
/*     */         }  
/* 265 */       temp = temp.cdr();
/* 266 */       while (temp != Lisp.NIL) {
/* 267 */         part = temp.car();
/* 268 */         if (part instanceof AbstractString) {
/* 269 */           sb.append(part.getStringValue());
/* 270 */         } else if (part == Keyword.WILD) {
/* 271 */           sb.append('*');
/* 272 */         } else if (part == Keyword.WILD_INFERIORS) {
/* 273 */           sb.append("**");
/* 274 */         } else if (part == Keyword.UP) {
/* 275 */           sb.append("..");
/*     */         } else {
/* 277 */           Lisp.error(new FileError("Unsupported directory component " + part.princToString() + ".", this));
/*     */         } 
/* 279 */         sb.append(';');
/* 280 */         temp = temp.cdr();
/*     */       } 
/*     */     } 
/* 283 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 288 */     LispThread thread = LispThread.currentThread();
/* 289 */     boolean printReadably = (Symbol.PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/* 290 */     boolean printEscape = (Symbol.PRINT_ESCAPE.symbolValue(thread) != Lisp.NIL);
/* 291 */     StringBuilder sb = new StringBuilder();
/* 292 */     if (printReadably || printEscape)
/* 293 */       sb.append("#P\""); 
/* 294 */     sb.append(getHost().getStringValue());
/* 295 */     sb.append(':');
/* 296 */     if (getDirectory() != Lisp.NIL)
/* 297 */       sb.append(getDirectoryNamestring()); 
/* 298 */     if (getName() != Lisp.NIL)
/* 299 */       if (getName() == Keyword.WILD) {
/* 300 */         sb.append('*');
/*     */       } else {
/* 302 */         sb.append(getName().getStringValue());
/*     */       }  
/* 304 */     if (getType() != Lisp.NIL) {
/* 305 */       sb.append('.');
/* 306 */       if (getType() == Keyword.WILD) {
/* 307 */         sb.append('*');
/*     */       } else {
/* 309 */         sb.append(getType().getStringValue());
/*     */       } 
/* 311 */     }  if (getVersion().integerp()) {
/* 312 */       sb.append('.');
/* 313 */       int base = Fixnum.getValue(Symbol.PRINT_BASE.symbolValue(thread));
/* 314 */       if (getVersion() instanceof Fixnum)
/* 315 */       { sb.append(Integer.toString(((Fixnum)getVersion()).value, base).toUpperCase()); }
/* 316 */       else if (getVersion() instanceof Bignum)
/* 317 */       { sb.append(((Bignum)getVersion()).value.toString(base).toUpperCase()); } 
/* 318 */     } else if (getVersion() == Keyword.WILD) {
/* 319 */       sb.append(".*");
/* 320 */     } else if (getVersion() == Keyword.NEWEST) {
/* 321 */       sb.append(".NEWEST");
/*     */     } 
/* 323 */     if (printReadably || printEscape)
/* 324 */       sb.append('"'); 
/* 325 */     return sb.toString();
/*     */   }
/*     */ 
/*     */   
/* 329 */   private static final Primitive CANONICALIZE_LOGICAL_HOST = new canonicalize_logical_host();
/*     */   
/*     */   private static class canonicalize_logical_host extends Primitive { canonicalize_logical_host() {
/* 332 */       super("canonicalize-logical-host", Lisp.PACKAGE_SYS, true, "host");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 337 */       AbstractString s = Lisp.checkString(arg);
/* 338 */       if (s.length() == 0)
/*     */       {
/*     */         
/* 341 */         return Lisp.error(new LispError("Invalid logical host name: \"" + s
/* 342 */               .getStringValue() + '"'));
/*     */       }
/* 344 */       return LogicalPathname.canonicalizeStringComponent(s);
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/* 349 */   private static final Primitive _MAKE_LOGICAL_PATHNAME = new _make_logical_pathname();
/*     */   
/*     */   private static class _make_logical_pathname extends Primitive { _make_logical_pathname() {
/* 352 */       super("%make-logical-pathname", Lisp.PACKAGE_SYS, true, "namestring");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 359 */       String s = arg.getStringValue();
/* 360 */       String h = LogicalPathname.getHostString(s);
/* 361 */       if (h != null) {
/* 362 */         if (h.length() == 0)
/*     */         {
/*     */           
/* 365 */           return Lisp.error(new LispError("Invalid logical host name: \"" + h + '"'));
/*     */         }
/*     */         
/* 368 */         if (LogicalPathname.TRANSLATIONS.get(new SimpleString(h)) != null)
/*     */         {
/* 370 */           return LogicalPathname.create(h, s.substring(s.indexOf(':') + 1));
/*     */         }
/*     */       } 
/* 373 */       return Lisp.error(new TypeError("Logical namestring does not specify a host: \"" + s + '"'));
/*     */     } }
/*     */ 
/*     */ 
/*     */   
/*     */   protected static String getHostString(String s) {
/* 379 */     int colon = s.indexOf(':');
/* 380 */     if (colon >= 0) {
/* 381 */       return s.substring(0, colon).toUpperCase();
/*     */     }
/* 383 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public long getLastModified() {
/* 388 */     Pathname p = translateLogicalPathname(this);
/* 389 */     return p.getLastModified();
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LogicalPathname.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */