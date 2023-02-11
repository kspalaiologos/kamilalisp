/*     */ package org.armedbear.lisp;
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
/*     */ public final class PackageFunctions
/*     */ {
/*  42 */   private static final Primitive PACKAGEP = new Primitive("packagep", "object")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  47 */         return (arg instanceof Package) ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  53 */   private static final Primitive PACKAGE_NAME = new Primitive("package-name", "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  59 */         return Lisp.coerceToPackage(arg).NAME();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  65 */   private static final Primitive PACKAGE_NICKNAMES = new Primitive("package-nicknames", "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  71 */         return Lisp.coerceToPackage(arg).packageNicknames();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  77 */   private static final Primitive PACKAGE_USE_LIST = new Primitive("package-use-list", "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  83 */         return Lisp.coerceToPackage(arg).getUseList();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/*  89 */   private static final Primitive PACKAGE_USED_BY_LIST = new Primitive("package-used-by-list", "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/*  95 */         return Lisp.coerceToPackage(arg).getUsedByList();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 101 */   private static final Primitive _IMPORT = new Primitive("%import", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 107 */         if (args.length == 0 || args.length > 2)
/* 108 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2)); 
/* 109 */         LispObject symbols = args[0];
/*     */         
/* 111 */         Package pkg = (args.length == 2) ? Lisp.coerceToPackage(args[1]) : Lisp.getCurrentPackage();
/* 112 */         if (symbols.listp()) {
/* 113 */           while (symbols != Lisp.NIL) {
/* 114 */             pkg.importSymbol(Lisp.checkSymbol(symbols.car()));
/* 115 */             symbols = symbols.cdr();
/*     */           } 
/*     */         } else {
/* 118 */           pkg.importSymbol(Lisp.checkSymbol(symbols));
/* 119 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 125 */   private static final Primitive UNEXPORT = new Primitive("unexport", "symbols &optional package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 131 */         if (args.length == 0 || args.length > 2)
/* 132 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2)); 
/* 133 */         LispObject symbols = args[0];
/*     */         
/* 135 */         Package pkg = (args.length == 2) ? Lisp.coerceToPackage(args[1]) : Lisp.getCurrentPackage();
/* 136 */         if (symbols.listp()) {
/* 137 */           while (symbols != Lisp.NIL) {
/* 138 */             pkg.unexport(Lisp.checkSymbol(symbols.car()));
/* 139 */             symbols = symbols.cdr();
/*     */           } 
/*     */         } else {
/* 142 */           pkg.unexport(Lisp.checkSymbol(symbols));
/* 143 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 149 */   private static final Primitive SHADOW = new Primitive("shadow", "symbol-names &optional package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 155 */         if (args.length == 0 || args.length > 2)
/* 156 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2)); 
/* 157 */         LispObject symbols = args[0];
/*     */         
/* 159 */         Package pkg = (args.length == 2) ? Lisp.coerceToPackage(args[1]) : Lisp.getCurrentPackage();
/* 160 */         if (symbols.listp()) {
/* 161 */           while (symbols != Lisp.NIL) {
/* 162 */             pkg.shadow(Lisp.javaString(symbols.car()));
/* 163 */             symbols = symbols.cdr();
/*     */           } 
/*     */         } else {
/* 166 */           pkg.shadow(Lisp.javaString(symbols));
/* 167 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 173 */   private static final Primitive SHADOWING_IMPORT = new Primitive("shadowing-import", "symbols &optional package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 179 */         if (args.length == 0 || args.length > 2)
/* 180 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2)); 
/* 181 */         LispObject symbols = args[0];
/*     */         
/* 183 */         Package pkg = (args.length == 2) ? Lisp.coerceToPackage(args[1]) : Lisp.getCurrentPackage();
/* 184 */         if (symbols.listp()) {
/* 185 */           while (symbols != Lisp.NIL) {
/* 186 */             pkg.shadowingImport(Lisp.checkSymbol(symbols.car()));
/* 187 */             symbols = symbols.cdr();
/*     */           } 
/*     */         } else {
/* 190 */           pkg.shadowingImport(Lisp.checkSymbol(symbols));
/* 191 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 197 */   private static final Primitive PACKAGE_SHADOWING_SYMBOLS = new Primitive("package-shadowing-symbols", "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 203 */         return Lisp.coerceToPackage(arg).getShadowingSymbols();
/*     */       }
/*     */     };
/*     */ 
/*     */   
/* 208 */   private static final Primitive _DELETE_PACKAGE = new Primitive("%delete-package", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 214 */         return Lisp.coerceToPackage(arg).delete() ? Lisp.T : Lisp.NIL;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 220 */   private static final Primitive USE_PACKAGE = new Primitive("unuse-package", "packages-to-unuse &optional package")
/*     */     {
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*     */         Package pkg;
/*     */         
/* 226 */         if (args.length < 1 || args.length > 2) {
/* 227 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2));
/*     */         }
/* 229 */         if (args.length == 2) {
/* 230 */           pkg = Lisp.coerceToPackage(args[1]);
/*     */         } else {
/* 232 */           pkg = Lisp.getCurrentPackage();
/* 233 */         }  if (args[0] instanceof Cons) {
/* 234 */           LispObject list = args[0];
/* 235 */           while (list != Lisp.NIL) {
/* 236 */             pkg.unusePackage(Lisp.coerceToPackage(list.car()));
/* 237 */             list = list.cdr();
/*     */           } 
/*     */         } else {
/* 240 */           pkg.unusePackage(Lisp.coerceToPackage(args[0]));
/* 241 */         }  return Lisp.T;
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 247 */   private static final Primitive RENAME_PACKAGE = new Primitive("rename-package", "package new-name &optional new-nicknames")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 253 */         if (args.length < 2 || args.length > 3)
/* 254 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 2, 3)); 
/* 255 */         Package pkg = Lisp.coerceToPackage(args[0]);
/* 256 */         String newName = Lisp.javaString(args[1]);
/* 257 */         LispObject nicknames = (args.length == 3) ? Lisp.checkList(args[2]) : Lisp.NIL;
/* 258 */         pkg.rename(newName, nicknames);
/* 259 */         return pkg;
/*     */       }
/*     */     };
/*     */   
/* 263 */   private static final Primitive LIST_ALL_PACKAGES = new Primitive("list-all-packages", "")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute()
/*     */       {
/* 269 */         return Packages.listAllPackages();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 275 */   private static final Primitive PACKAGE_LOCAL_NICKNAMES = new Primitive("package-local-nicknames", Lisp.PACKAGE_EXT, true, "package")
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject arg)
/*     */       {
/* 281 */         return Lisp.coerceToPackage(arg).getLocalPackageNicknames();
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 287 */   private static final Primitive ADD_PACKAGE_LOCAL_NICKNAME = new Primitive("%add-package-local-nickname", Lisp.PACKAGE_SYS, false, "local-nickname package &optional package-designator")
/*     */     {
/*     */ 
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject nick, LispObject pack, LispObject target)
/*     */       {
/* 295 */         return Lisp.coerceToPackage(target).addLocalPackageNickname(nick.getStringValue(), Lisp.coerceToPackage(pack));
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject nick, LispObject pack) {
/* 300 */         return execute(nick, pack, Lisp.getCurrentPackage());
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 306 */   private static final Primitive REMOVE_PACKAGE_LOCAL_NICKNAME = new Primitive("remove-package-local-nickname", Lisp.PACKAGE_EXT, true, "old-nickname &optional package-designator")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject nick, LispObject target)
/*     */       {
/* 313 */         return Lisp.coerceToPackage(target).removeLocalPackageNickname(nick.getStringValue());
/*     */       }
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject nick) {
/* 318 */         return execute(nick, Lisp.getCurrentPackage());
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */   
/* 324 */   private static final Primitive PACKAGE_LOCALLY_NICKNAMED_BY_LIST = new Primitive("package-locally-nicknamed-by-list", Lisp.PACKAGE_EXT, true, "package")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject pack)
/*     */       {
/* 331 */         return Packages.getPackagesNicknamingPackage(Lisp.coerceToPackage(pack));
/*     */       }
/*     */     };
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 338 */   private static final Primitive _DEFPACKAGE = new Primitive("%defpackage", Lisp.PACKAGE_SYS, false)
/*     */     {
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 344 */         if (args.length != 11)
/* 345 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 11)); 
/* 346 */         String packageName = args[0].getStringValue();
/* 347 */         Package currentpkg = Lisp.getCurrentPackage();
/* 348 */         LispObject nicknames = Lisp.checkList(args[1]);
/*     */ 
/*     */         
/* 351 */         LispObject shadows = Lisp.checkList(args[3]);
/* 352 */         LispObject shadowingImports = Lisp.checkList(args[4]);
/* 353 */         LispObject use = Lisp.checkList(args[5]);
/* 354 */         LispObject imports = Lisp.checkList(args[6]);
/* 355 */         LispObject interns = Lisp.checkList(args[7]);
/* 356 */         LispObject exports = Lisp.checkList(args[8]);
/* 357 */         LispObject localNicknames = Lisp.checkList(args[9]);
/*     */ 
/*     */         
/* 360 */         Package pkg = currentpkg.findPackage(packageName);
/* 361 */         if (pkg != null)
/* 362 */           return pkg; 
/* 363 */         if (nicknames != Lisp.NIL) {
/* 364 */           LispObject list = nicknames;
/* 365 */           while (list != Lisp.NIL) {
/* 366 */             LispObject lispNick = list.car();
/* 367 */             String nick = Lisp.javaString(lispNick);
/* 368 */             if (currentpkg.findPackage(nick) != null) {
/* 369 */               return Lisp.error(new PackageError("A package named " + nick + " already exists.", lispNick));
/*     */             }
/*     */             
/* 372 */             list = list.cdr();
/*     */           } 
/*     */         } 
/* 375 */         pkg = Packages.createPackage(packageName);
/* 376 */         while (nicknames != Lisp.NIL) {
/* 377 */           LispObject string = nicknames.car().STRING();
/* 378 */           pkg.addNickname(string.getStringValue());
/* 379 */           nicknames = nicknames.cdr();
/*     */         } 
/* 381 */         while (shadows != Lisp.NIL) {
/* 382 */           String symbolName = shadows.car().getStringValue();
/* 383 */           pkg.shadow(symbolName);
/* 384 */           shadows = shadows.cdr();
/*     */         } 
/* 386 */         while (shadowingImports != Lisp.NIL) {
/* 387 */           LispObject si = shadowingImports.car();
/* 388 */           Package otherPkg = Lisp.coerceToPackage(si.car());
/* 389 */           LispObject symbolNames = si.cdr();
/* 390 */           while (symbolNames != Lisp.NIL) {
/* 391 */             String symbolName = symbolNames.car().getStringValue();
/* 392 */             Symbol sym = otherPkg.findAccessibleSymbol(symbolName);
/* 393 */             if (sym != null) {
/* 394 */               pkg.shadowingImport(sym);
/*     */             } else {
/* 396 */               return Lisp.error(new LispError(symbolName + " not found in package " + otherPkg
/*     */                     
/* 398 */                     .getName() + "."));
/* 399 */             }  symbolNames = symbolNames.cdr();
/*     */           } 
/* 401 */           shadowingImports = shadowingImports.cdr();
/*     */         } 
/* 403 */         while (use != Lisp.NIL) {
/* 404 */           LispObject obj = use.car();
/* 405 */           if (obj instanceof Package) {
/* 406 */             pkg.usePackage((Package)obj);
/*     */           } else {
/* 408 */             LispObject string = obj.STRING();
/* 409 */             Package p = currentpkg.findPackage(string.getStringValue());
/* 410 */             if (p == null) {
/* 411 */               return Lisp.error(new LispError(obj.princToString() + " is not the name of a package."));
/*     */             }
/* 413 */             pkg.usePackage(p);
/*     */           } 
/* 415 */           use = use.cdr();
/*     */         } 
/* 417 */         while (imports != Lisp.NIL) {
/* 418 */           LispObject si = imports.car();
/* 419 */           Package otherPkg = Lisp.coerceToPackage(si.car());
/* 420 */           LispObject symbolNames = si.cdr();
/* 421 */           while (symbolNames != Lisp.NIL) {
/* 422 */             String symbolName = symbolNames.car().getStringValue();
/* 423 */             Symbol sym = otherPkg.findAccessibleSymbol(symbolName);
/* 424 */             if (sym != null) {
/* 425 */               pkg.importSymbol(sym);
/*     */             } else {
/* 427 */               return Lisp.error(new LispError(symbolName + " not found in package " + otherPkg
/*     */                     
/* 429 */                     .getName() + "."));
/* 430 */             }  symbolNames = symbolNames.cdr();
/*     */           } 
/* 432 */           imports = imports.cdr();
/*     */         } 
/* 434 */         while (interns != Lisp.NIL) {
/* 435 */           String symbolName = interns.car().getStringValue();
/* 436 */           pkg.intern(symbolName);
/* 437 */           interns = interns.cdr();
/*     */         } 
/* 439 */         while (exports != Lisp.NIL) {
/* 440 */           String symbolName = exports.car().getStringValue();
/* 441 */           pkg.export(pkg.intern(symbolName));
/* 442 */           exports = exports.cdr();
/*     */         } 
/* 444 */         while (localNicknames != Lisp.NIL) {
/* 445 */           LispObject nickDecl = localNicknames.car();
/* 446 */           String name = nickDecl.car().getStringValue();
/* 447 */           Package pack = Lisp.coerceToPackage(nickDecl.cadr());
/* 448 */           pkg.addLocalPackageNickname(name, pack);
/* 449 */           localNicknames = localNicknames.cdr();
/*     */         } 
/* 451 */         return pkg;
/*     */       }
/*     */     };
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/PackageFunctions.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */