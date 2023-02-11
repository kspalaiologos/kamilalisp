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
/*     */ public final class probe_file
/*     */ {
/*  42 */   public static final Primitive PROBE_FILE = new pf_probe_file();
/*     */   
/*     */   @DocString(name = "probe-file", args = "pathspec", returns = "truename")
/*     */   private static final class pf_probe_file
/*     */     extends Primitive
/*     */   {
/*     */     pf_probe_file() {
/*  49 */       super(Symbol.PROBE_FILE, "pathspec");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*  54 */       if (arg == null || arg.equals(Lisp.NIL)) {
/*  55 */         return Lisp.NIL;
/*     */       }
/*  57 */       Pathname p = Lisp.coerceToPathname(arg);
/*  58 */       if (p.isWild()) {
/*  59 */         return Lisp.error(new FileError("Cannot find the TRUENAME for a wild pathname.", p));
/*     */       }
/*     */ 
/*     */       
/*  63 */       if (p instanceof JarPathname)
/*  64 */         return JarPathname.truename(p, false); 
/*  65 */       if (p instanceof URLPathname) {
/*  66 */         return URLPathname.truename((URLPathname)p, false);
/*     */       }
/*  68 */       return Pathname.truename(p, false);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*  73 */   public static final Primitive TRUENAME = new pf_truename();
/*     */   
/*     */   @DocString(name = "truename", args = "pathspec", returns = "pathname")
/*     */   private static class pf_truename
/*     */     extends Primitive
/*     */   {
/*     */     pf_truename() {
/*  80 */       super(Symbol.TRUENAME, "filespec");
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/*  85 */       Pathname p = Lisp.coerceToPathname(arg);
/*  86 */       if (p.isWild()) {
/*  87 */         return Lisp.error(new FileError("Cannot find the TRUENAME for a wild pathname.", p));
/*     */       }
/*     */ 
/*     */ 
/*     */       
/*  92 */       if (p instanceof JarPathname)
/*  93 */         return JarPathname.truename(p, true); 
/*  94 */       if (p instanceof URLPathname) {
/*  95 */         return URLPathname.truename((URLPathname)p, true);
/*     */       }
/*  97 */       return Pathname.truename(p, true);
/*     */     }
/*     */   }
/*     */ 
/*     */   
/* 102 */   public static final Primitive PROBE_DIRECTORY = new pf_probe_directory();
/*     */   
/*     */   @DocString(name = "probe-directory", args = "pathspec", returns = "truename")
/*     */   private static final class pf_probe_directory
/*     */     extends Primitive
/*     */   {
/*     */     pf_probe_directory() {
/* 109 */       super("probe-directory", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 114 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 115 */       if (pathname.isWild()) {
/* 116 */         Lisp.error(new FileError("Cannot probe a wild pathname as a directory.", pathname));
/*     */       }
/* 118 */       Pathname defaultedPathname = (Pathname)Pathname.MERGE_PATHNAMES.execute(pathname);
/* 119 */       if (defaultedPathname instanceof JarPathname) {
/* 120 */         if (defaultedPathname.getName().equals(Lisp.NIL) && defaultedPathname
/* 121 */           .getType().equals(Lisp.NIL)) {
/* 122 */           return Symbol.PROBE_FILE.execute(defaultedPathname);
/*     */         }
/* 124 */         SimpleString simpleString = (SimpleString)Symbol.FILE_NAMESTRING.execute(defaultedPathname);
/*     */         
/* 126 */         LispObject lispObject = defaultedPathname.getDirectory().reverse().push(simpleString).reverse();
/* 127 */         defaultedPathname.setDirectory(lispObject);
/* 128 */         return Symbol.PROBE_FILE.execute(defaultedPathname);
/*     */       } 
/*     */       
/* 131 */       File file = defaultedPathname.getFile();
/* 132 */       if (file == null || !file.isDirectory()) {
/* 133 */         return Lisp.NIL;
/*     */       }
/*     */       
/* 136 */       if (defaultedPathname.getName().equals(Lisp.NIL) && defaultedPathname
/* 137 */         .getType().equals(Lisp.NIL)) {
/* 138 */         return Symbol.PROBE_FILE.execute(defaultedPathname);
/*     */       }
/* 140 */       SimpleString lastDirectory = (SimpleString)Symbol.FILE_NAMESTRING.execute(defaultedPathname);
/*     */       
/* 142 */       LispObject appendedDirectory = defaultedPathname.getDirectory().reverse().push(lastDirectory).reverse();
/* 143 */       defaultedPathname.setDirectory(appendedDirectory);
/* 144 */       return Symbol.PROBE_FILE.execute(defaultedPathname);
/*     */     }
/*     */   }
/*     */   
/* 148 */   public static final Primitive FILE_DIRECTORY_P = new pf_file_directory_p();
/*     */   
/*     */   @DocString(name = "file-directory-p", args = "pathspec &key (wild-error-p t)", returns = "generalized-boolean")
/*     */   private static final class pf_file_directory_p
/*     */     extends Primitive
/*     */   {
/*     */     pf_file_directory_p() {
/* 155 */       super("file-directory-p", Lisp.PACKAGE_EXT, true);
/*     */     }
/*     */     
/*     */     private LispObject isDirectory(Pathname p) {
/* 159 */       LispObject result = probe_file.PROBE_DIRECTORY.execute(p);
/* 160 */       return result.equals(Lisp.NIL) ? Lisp.NIL : Lisp.T;
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg) {
/* 166 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 167 */       if (pathname.isWild()) {
/* 168 */         Lisp.error(new FileError("Fundamentally unable to determine whether a wild pathname is a directory.", pathname));
/*     */       }
/*     */       
/* 171 */       return isDirectory(pathname);
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject arg, LispObject wildErrorPKeyword, LispObject wildErrorP) {
/* 177 */       if (!wildErrorPKeyword.equals(Keyword.WILD_ERROR_P)) {
/* 178 */         Lisp.type_error(wildErrorPKeyword, Keyword.WILD_ERROR_P);
/*     */       }
/* 180 */       Pathname pathname = Lisp.coerceToPathname(arg);
/* 181 */       if (wildErrorP != Lisp.NIL && 
/* 182 */         pathname.isWild()) {
/* 183 */         Lisp.error(new FileError("Fundamentally to determine whether a wild pathname is a directory.", pathname));
/*     */       }
/*     */ 
/*     */       
/* 187 */       return isDirectory(pathname);
/*     */     }
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/probe_file.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */