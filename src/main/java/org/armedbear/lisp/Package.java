/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.ObjectStreamException;
/*     */ import java.io.Serializable;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Collection;
/*     */ import java.util.HashMap;
/*     */ import java.util.Iterator;
/*     */ import java.util.List;
/*     */ import java.util.Map;
/*     */ import java.util.concurrent.ConcurrentHashMap;
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ public final class Package
/*     */   extends LispObject
/*     */   implements Serializable
/*     */ {
/*     */   private String name;
/*     */   private transient SimpleString lispName;
/*     */   private transient LispObject propertyList;
/*  54 */   private final transient ConcurrentHashMap<String, Symbol> internalSymbols = new ConcurrentHashMap<>(16);
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*  60 */   private final transient ConcurrentHashMap<String, Symbol> externalSymbols = new ConcurrentHashMap<>(16);
/*     */   
/*     */   private transient HashMap<String, Symbol> shadowingSymbols;
/*     */   
/*     */   private transient ArrayList<String> nicknames;
/*  65 */   private transient LispObject useList = null;
/*  66 */   private transient ArrayList<Package> usedByList = null;
/*     */ 
/*     */   
/*     */   private transient ConcurrentHashMap<String, Package> localNicknames;
/*     */ 
/*     */   
/*     */   public Package() {}
/*     */ 
/*     */   
/*     */   public Package(String name) {
/*  76 */     this.name = name;
/*  77 */     this.lispName = new SimpleString(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Package(String name, int size) {
/*  82 */     this.name = name;
/*  83 */     this.lispName = new SimpleString(name);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typeOf() {
/*  89 */     return Symbol.PACKAGE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject classOf() {
/*  95 */     return BuiltInClass.PACKAGE;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject getDescription() {
/* 101 */     if (this.name != null) {
/* 102 */       StringBuilder sb = new StringBuilder("The ");
/* 103 */       sb.append(this.name);
/* 104 */       sb.append(" package");
/* 105 */       return new SimpleString(sb);
/*     */     } 
/* 107 */     return new SimpleString("PACKAGE");
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject typep(LispObject type) {
/* 113 */     if (type == Symbol.PACKAGE)
/* 114 */       return Lisp.T; 
/* 115 */     if (type == BuiltInClass.PACKAGE)
/* 116 */       return Lisp.T; 
/* 117 */     return super.typep(type);
/*     */   }
/*     */ 
/*     */   
/*     */   public final String getName() {
/* 122 */     return this.name;
/*     */   }
/*     */ 
/*     */   
/*     */   public final LispObject NAME() {
/* 127 */     return (this.lispName != null) ? this.lispName : Lisp.NIL;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final LispObject getPropertyList() {
/* 133 */     if (this.propertyList == null)
/* 134 */       this.propertyList = Lisp.NIL; 
/* 135 */     return this.propertyList;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final void setPropertyList(LispObject obj) {
/* 141 */     if (obj == null)
/* 142 */       throw new NullPointerException(); 
/* 143 */     this.propertyList = obj;
/*     */   }
/*     */ 
/*     */   
/*     */   public final List getNicknames() {
/* 148 */     return this.nicknames;
/*     */   }
/*     */ 
/*     */   
/*     */   private void makeSymbolsUninterned(ConcurrentHashMap symbolMap) {
/* 153 */     Iterator<Symbol> it = symbolMap.values().iterator();
/* 154 */     while (it.hasNext()) {
/* 155 */       Symbol sym = it.next();
/* 156 */       if (sym.getPackage() == this) {
/* 157 */         sym.setPackage(Lisp.NIL);
/*     */       }
/*     */     } 
/* 160 */     symbolMap.clear();
/*     */   }
/*     */ 
/*     */   
/*     */   public final synchronized boolean delete() {
/* 165 */     if (this.name != null) {
/* 166 */       if (this.useList instanceof Cons) {
/* 167 */         LispObject usedPackages = this.useList;
/* 168 */         while (usedPackages != Lisp.NIL) {
/* 169 */           Package pkg = (Package)usedPackages.car();
/* 170 */           unusePackage(pkg);
/* 171 */           usedPackages = usedPackages.cdr();
/*     */         } 
/*     */       } 
/*     */       
/* 175 */       if (this.usedByList != null) {
/* 176 */         while (!this.usedByList.isEmpty()) {
/* 177 */           ((Package)this.usedByList.get(0)).unusePackage(this);
/*     */         }
/*     */       }
/*     */       
/* 181 */       LispObject packages = Packages.getPackagesNicknamingPackage(this);
/* 182 */       while (packages != Lisp.NIL) {
/* 183 */         Package p = (Package)((Cons)packages).car();
/* 184 */         packages = ((Cons)packages).cdr();
/* 185 */         p.removeLocalPackageNicknamesForPackage(this);
/*     */       } 
/*     */       
/* 188 */       Packages.deletePackage(this);
/*     */       
/* 190 */       makeSymbolsUninterned(this.internalSymbols);
/* 191 */       makeSymbolsUninterned(this.externalSymbols);
/*     */       
/* 193 */       this.name = null;
/* 194 */       this.lispName = null;
/* 195 */       this.nicknames = null;
/*     */       
/* 197 */       return true;
/*     */     } 
/* 199 */     return false;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public final synchronized void rename(String newName, LispObject newNicks) {
/* 205 */     ArrayList<String> arrayList = null;
/* 206 */     while (newNicks != Lisp.NIL) {
/* 207 */       if (arrayList == null)
/* 208 */         arrayList = new ArrayList<>(); 
/* 209 */       arrayList.add(Lisp.javaString(newNicks.car()));
/* 210 */       newNicks = newNicks.cdr();
/*     */     } 
/*     */     
/* 213 */     Packages.deletePackage(this);
/*     */     
/* 215 */     this.name = newName;
/* 216 */     this.lispName = new SimpleString(newName);
/* 217 */     this.nicknames = arrayList;
/*     */     
/* 219 */     Packages.addPackage(this);
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol findInternalSymbol(SimpleString name) {
/* 224 */     return this.internalSymbols.get(name.toString());
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol findInternalSymbol(String name) {
/* 229 */     return this.internalSymbols.get(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol findExternalSymbol(SimpleString name) {
/* 234 */     return this.externalSymbols.get(name.toString());
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol findExternalSymbol(String name) {
/* 239 */     return this.externalSymbols.get(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol findExternalSymbol(SimpleString name, int hash) {
/* 244 */     return this.externalSymbols.get(name.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Symbol findAccessibleSymbol(String name) {
/* 251 */     return findAccessibleSymbol(new SimpleString(name));
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Symbol findAccessibleSymbol(SimpleString name) {
/* 259 */     Symbol symbol = this.externalSymbols.get(name.toString());
/* 260 */     if (symbol != null)
/* 261 */       return symbol; 
/* 262 */     symbol = this.internalSymbols.get(name.toString());
/* 263 */     if (symbol != null) {
/* 264 */       return symbol;
/*     */     }
/* 266 */     if (this.useList instanceof Cons) {
/* 267 */       LispObject usedPackages = this.useList;
/* 268 */       while (usedPackages != Lisp.NIL) {
/* 269 */         Package pkg = (Package)usedPackages.car();
/* 270 */         symbol = pkg.findExternalSymbol(name);
/* 271 */         if (symbol != null)
/* 272 */           return symbol; 
/* 273 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/*     */     
/* 277 */     return null;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject findSymbol(String name) {
/* 283 */     SimpleString s = new SimpleString(name);
/* 284 */     LispThread thread = LispThread.currentThread();
/*     */     
/* 286 */     Symbol symbol = this.externalSymbols.get(name);
/* 287 */     if (symbol != null)
/* 288 */       return thread.setValues(symbol, Keyword.EXTERNAL); 
/* 289 */     symbol = this.internalSymbols.get(name);
/* 290 */     if (symbol != null) {
/* 291 */       return thread.setValues(symbol, Keyword.INTERNAL);
/*     */     }
/* 293 */     if (this.useList instanceof Cons) {
/* 294 */       LispObject usedPackages = this.useList;
/* 295 */       while (usedPackages != Lisp.NIL) {
/* 296 */         Package pkg = (Package)usedPackages.car();
/* 297 */         symbol = pkg.findExternalSymbol(s);
/* 298 */         if (symbol != null)
/* 299 */           return thread.setValues(symbol, Keyword.INHERITED); 
/* 300 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/*     */     
/* 304 */     return thread.setValues(Lisp.NIL, Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void addSymbol(Symbol symbol) {
/* 310 */     Debug.assertTrue((symbol.getPackage() == this));
/* 311 */     Debug.assertTrue(symbol.getName().equals("NIL"));
/* 312 */     this.externalSymbols.put(symbol.name.toString(), symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   private Symbol addSymbol(String name) {
/* 317 */     Symbol symbol = new Symbol(name, this);
/* 318 */     if (this == Lisp.PACKAGE_KEYWORD) {
/* 319 */       symbol.initializeConstant(symbol);
/* 320 */       this.externalSymbols.put(name.toString(), symbol);
/*     */     } else {
/* 322 */       this.internalSymbols.put(name.toString(), symbol);
/*     */     } 
/* 324 */     return symbol;
/*     */   }
/*     */ 
/*     */   
/*     */   private Symbol addSymbol(SimpleString name) {
/* 329 */     return addSymbol(name.toString());
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol addInternalSymbol(String symbolName) {
/* 334 */     Symbol symbol = new Symbol(symbolName, this);
/* 335 */     this.internalSymbols.put(symbolName, symbol);
/* 336 */     return symbol;
/*     */   }
/*     */ 
/*     */   
/*     */   public Symbol addExternalSymbol(String symbolName) {
/* 341 */     Symbol symbol = new Symbol(symbolName, this);
/* 342 */     this.externalSymbols.put(symbolName, symbol);
/* 343 */     return symbol;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized Symbol intern(SimpleString symbolName) {
/* 348 */     return intern(symbolName.toString());
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public synchronized Symbol intern(String symbolName) {
/* 354 */     Symbol symbol = this.externalSymbols.get(symbolName);
/* 355 */     if (symbol != null)
/* 356 */       return symbol; 
/* 357 */     symbol = this.internalSymbols.get(symbolName);
/* 358 */     if (symbol != null) {
/* 359 */       return symbol;
/*     */     }
/* 361 */     if (this.useList instanceof Cons) {
/* 362 */       LispObject usedPackages = this.useList;
/* 363 */       while (usedPackages != Lisp.NIL) {
/* 364 */         Package pkg = (Package)usedPackages.car();
/* 365 */         symbol = pkg.externalSymbols.get(symbolName);
/* 366 */         if (symbol != null)
/* 367 */           return symbol; 
/* 368 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/*     */     
/* 372 */     return addSymbol(symbolName);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public synchronized Symbol intern(SimpleString s, LispThread thread) {
/* 379 */     Symbol symbol = this.externalSymbols.get(s.toString());
/* 380 */     if (symbol != null)
/* 381 */       return (Symbol)thread.setValues(symbol, Keyword.EXTERNAL); 
/* 382 */     symbol = this.internalSymbols.get(s.toString());
/* 383 */     if (symbol != null) {
/* 384 */       return (Symbol)thread.setValues(symbol, Keyword.INTERNAL);
/*     */     }
/* 386 */     if (this.useList instanceof Cons) {
/* 387 */       LispObject usedPackages = this.useList;
/* 388 */       while (usedPackages != Lisp.NIL) {
/* 389 */         Package pkg = (Package)usedPackages.car();
/* 390 */         symbol = pkg.findExternalSymbol(s);
/* 391 */         if (symbol != null)
/* 392 */           return (Symbol)thread.setValues(symbol, Keyword.INHERITED); 
/* 393 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/*     */     
/* 397 */     return (Symbol)thread.setValues(addSymbol(s), Lisp.NIL);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public synchronized Symbol internAndExport(String symbolName) {
/* 403 */     SimpleString s = new SimpleString(symbolName);
/*     */     
/* 405 */     Symbol symbol = this.externalSymbols.get(s.toString());
/* 406 */     if (symbol != null)
/* 407 */       return symbol; 
/* 408 */     symbol = this.internalSymbols.get(s.toString());
/* 409 */     if (symbol != null) {
/* 410 */       export(symbol);
/* 411 */       return symbol;
/*     */     } 
/* 413 */     if (this.useList instanceof Cons) {
/*     */       
/* 415 */       LispObject usedPackages = this.useList;
/* 416 */       while (usedPackages != Lisp.NIL) {
/* 417 */         Package pkg = (Package)usedPackages.car();
/* 418 */         symbol = pkg.findExternalSymbol(s);
/* 419 */         if (symbol != null) {
/* 420 */           export(symbol);
/* 421 */           return symbol;
/*     */         } 
/* 423 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/*     */     
/* 427 */     symbol = new Symbol(s, this);
/* 428 */     if (this == Lisp.PACKAGE_KEYWORD)
/* 429 */       symbol.initializeConstant(symbol); 
/* 430 */     this.externalSymbols.put(s.toString(), symbol);
/* 431 */     return symbol;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized LispObject unintern(Symbol symbol) {
/*     */     boolean shadow;
/* 437 */     String symbolName = symbol.getName();
/*     */     
/* 439 */     if (this.shadowingSymbols != null && this.shadowingSymbols.get(symbolName) == symbol) {
/* 440 */       shadow = true;
/*     */     } else {
/* 442 */       shadow = false;
/* 443 */     }  if (shadow) {
/*     */ 
/*     */       
/* 446 */       Symbol sym = null;
/* 447 */       if (this.useList instanceof Cons) {
/* 448 */         LispObject usedPackages = this.useList;
/* 449 */         while (usedPackages != Lisp.NIL) {
/* 450 */           Package pkg = (Package)usedPackages.car();
/* 451 */           Symbol s = pkg.findExternalSymbol(symbol.name);
/* 452 */           if (s != null) {
/* 453 */             if (sym == null) {
/* 454 */               sym = s;
/* 455 */             } else if (sym != s) {
/* 456 */               StringBuilder sb = new StringBuilder("Uninterning the symbol ");
/*     */               
/* 458 */               sb.append(symbol.getQualifiedName());
/* 459 */               sb.append(" causes a name conflict between ");
/* 460 */               sb.append(sym.getQualifiedName());
/* 461 */               sb.append(" and ");
/* 462 */               sb.append(s.getQualifiedName());
/* 463 */               return Lisp.error(new PackageError(sb.toString(), this));
/*     */             } 
/*     */           }
/* 466 */           usedPackages = usedPackages.cdr();
/*     */         } 
/*     */       } 
/*     */     } 
/*     */     
/* 471 */     boolean found = false;
/* 472 */     if (this.externalSymbols.get(symbol.name.toString()) == symbol) {
/* 473 */       this.externalSymbols.remove(symbol.name.toString());
/* 474 */       found = true;
/*     */     } 
/* 476 */     if (this.internalSymbols.get(symbol.name.toString()) == symbol) {
/* 477 */       this.internalSymbols.remove(symbol.name.toString());
/* 478 */       found = true;
/*     */     } 
/* 480 */     if (!found) {
/* 481 */       return Lisp.NIL;
/*     */     }
/* 483 */     if (shadow) {
/* 484 */       Debug.assertTrue((this.shadowingSymbols != null));
/* 485 */       this.shadowingSymbols.remove(symbolName);
/*     */     } 
/* 487 */     if (symbol.getPackage() == this)
/* 488 */       symbol.setPackage(Lisp.NIL); 
/* 489 */     return Lisp.T;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized void importSymbol(Symbol symbol) {
/* 494 */     if (symbol.getPackage() == this)
/*     */       return; 
/* 496 */     Symbol sym = findAccessibleSymbol(symbol.name);
/* 497 */     if (sym != null && sym != symbol) {
/* 498 */       StringBuilder sb = new StringBuilder("The symbol ");
/* 499 */       sb.append(sym.getQualifiedName());
/* 500 */       sb.append(" is already accessible in package ");
/* 501 */       sb.append(this.name);
/* 502 */       sb.append('.');
/* 503 */       Lisp.error(new PackageError(sb.toString(), this));
/*     */     } 
/* 505 */     this.internalSymbols.put(symbol.name.toString(), symbol);
/* 506 */     if (symbol.getPackage() == Lisp.NIL) {
/* 507 */       symbol.setPackage(this);
/*     */     }
/*     */   }
/*     */   
/*     */   public synchronized void export(Symbol symbol) {
/* 512 */     String symbolName = symbol.getName();
/* 513 */     boolean added = false;
/* 514 */     if (symbol.getPackage() != this) {
/* 515 */       Symbol sym = findAccessibleSymbol(symbol.name);
/* 516 */       if (sym != symbol) {
/* 517 */         StringBuilder stringBuilder = new StringBuilder("The symbol ");
/* 518 */         stringBuilder.append(symbol.getQualifiedName());
/* 519 */         stringBuilder.append(" is not accessible in package ");
/* 520 */         stringBuilder.append(this.name);
/* 521 */         stringBuilder.append('.');
/* 522 */         Lisp.error(new PackageError(stringBuilder.toString(), this));
/*     */         return;
/*     */       } 
/* 525 */       this.internalSymbols.put(symbol.name.toString(), symbol);
/* 526 */       added = true;
/*     */     } 
/* 528 */     if (added || this.internalSymbols.get(symbol.name.toString()) == symbol) {
/* 529 */       if (this.usedByList != null) {
/* 530 */         for (Iterator<Package> it = this.usedByList.iterator(); it.hasNext(); ) {
/* 531 */           Package pkg = it.next();
/* 532 */           Symbol sym = pkg.findAccessibleSymbol(symbol.name);
/* 533 */           if (sym == null || sym == symbol || (
/* 534 */             pkg.shadowingSymbols != null && pkg.shadowingSymbols
/* 535 */             .get(symbolName) == sym)) {
/*     */             continue;
/*     */           }
/* 538 */           StringBuilder stringBuilder = new StringBuilder("The symbol ");
/* 539 */           stringBuilder.append(sym.getQualifiedName());
/* 540 */           stringBuilder.append(" is already accessible in package ");
/* 541 */           stringBuilder.append(pkg.getName());
/* 542 */           stringBuilder.append('.');
/* 543 */           Lisp.error(new PackageError(stringBuilder.toString(), pkg));
/*     */ 
/*     */           
/*     */           return;
/*     */         } 
/*     */       }
/*     */       
/* 550 */       this.internalSymbols.remove(symbol.name.toString());
/* 551 */       this.externalSymbols.put(symbol.name.toString(), symbol);
/*     */       return;
/*     */     } 
/* 554 */     if (this.externalSymbols.get(symbol.name.toString()) == symbol) {
/*     */       return;
/*     */     }
/* 557 */     StringBuilder sb = new StringBuilder("The symbol ");
/* 558 */     sb.append(symbol.getQualifiedName());
/* 559 */     sb.append(" is not accessible in package ");
/* 560 */     sb.append(this.name);
/* 561 */     sb.append('.');
/* 562 */     Lisp.error(new PackageError(sb.toString(), this));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public synchronized void unexport(Symbol symbol) {
/* 568 */     if (this.externalSymbols.get(symbol.name.toString()) == symbol) {
/* 569 */       this.externalSymbols.remove(symbol.name.toString());
/* 570 */       this.internalSymbols.put(symbol.name.toString(), symbol);
/* 571 */     } else if (findAccessibleSymbol(symbol.name.toString()) != symbol) {
/* 572 */       StringBuilder sb = new StringBuilder("The symbol ");
/* 573 */       sb.append(symbol.getQualifiedName());
/* 574 */       sb.append(" is not accessible in package ");
/* 575 */       sb.append(this.name);
/* 576 */       Lisp.error(new PackageError(sb.toString(), this));
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public synchronized void shadow(String symbolName) {
/* 583 */     if (this.shadowingSymbols == null)
/* 584 */       this.shadowingSymbols = new HashMap<>(); 
/* 585 */     SimpleString s = new SimpleString(symbolName);
/* 586 */     Symbol symbol = this.externalSymbols.get(s.toString());
/* 587 */     if (symbol != null) {
/* 588 */       this.shadowingSymbols.put(symbolName, symbol);
/*     */       return;
/*     */     } 
/* 591 */     symbol = this.internalSymbols.get(s.toString());
/* 592 */     if (symbol != null) {
/* 593 */       this.shadowingSymbols.put(symbolName, symbol);
/*     */       return;
/*     */     } 
/* 596 */     if (this.shadowingSymbols.get(symbolName) != null)
/*     */       return; 
/* 598 */     symbol = new Symbol(s, this);
/* 599 */     this.internalSymbols.put(s.toString(), symbol);
/* 600 */     this.shadowingSymbols.put(symbolName, symbol);
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized void shadowingImport(Symbol symbol) {
/* 605 */     String symbolName = symbol.getName();
/* 606 */     Symbol sym = this.externalSymbols.get(symbolName);
/* 607 */     if (sym == null) {
/* 608 */       sym = this.internalSymbols.get(symbol.name.toString());
/*     */     }
/*     */ 
/*     */     
/* 612 */     if (sym != null && sym != symbol) {
/* 613 */       if (this.shadowingSymbols != null)
/* 614 */         this.shadowingSymbols.remove(symbolName); 
/* 615 */       unintern(sym);
/*     */     } 
/*     */     
/* 618 */     if (sym == null || sym != symbol)
/*     */     {
/*     */       
/* 621 */       this.internalSymbols.put(symbol.name.toString(), symbol);
/*     */     }
/*     */     
/* 624 */     if (this.shadowingSymbols == null)
/* 625 */       this.shadowingSymbols = new HashMap<>(); 
/* 626 */     this.shadowingSymbols.put(symbolName, symbol);
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public void usePackage(Package pkg) {
/* 634 */     if (this.useList == null)
/* 635 */       this.useList = Lisp.NIL; 
/* 636 */     if (!Lisp.memq(pkg, this.useList)) {
/*     */ 
/*     */       
/* 639 */       Collection<Symbol> symbols = pkg.getExternalSymbols();
/* 640 */       for (Iterator<Symbol> i = symbols.iterator(); i.hasNext(); ) {
/* 641 */         Symbol symbol = i.next();
/* 642 */         Symbol existing = findAccessibleSymbol(symbol.name);
/* 643 */         if (existing != null && existing != symbol && (
/* 644 */           this.shadowingSymbols == null || this.shadowingSymbols
/* 645 */           .get(symbol.getName()) == null)) {
/*     */           
/* 647 */           Lisp.error(new PackageError("A symbol named " + symbol.getName() + " is already accessible in package " + this.name + ".", this));
/*     */ 
/*     */           
/*     */           return;
/*     */         } 
/*     */       } 
/*     */       
/* 654 */       this.useList = this.useList.push(pkg);
/*     */       
/* 656 */       if (pkg.usedByList != null)
/* 657 */         Debug.assertTrue(!pkg.usedByList.contains(this)); 
/* 658 */       if (pkg.usedByList == null)
/* 659 */         pkg.usedByList = new ArrayList<>(); 
/* 660 */       pkg.usedByList.add(this);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public void unusePackage(Package pkg) {
/* 666 */     if (this.useList instanceof Cons && 
/* 667 */       Lisp.memq(pkg, this.useList)) {
/*     */       
/* 669 */       LispObject newList = Lisp.NIL;
/* 670 */       while (this.useList != Lisp.NIL) {
/* 671 */         if (this.useList.car() != pkg)
/* 672 */           newList = newList.push(this.useList.car()); 
/* 673 */         this.useList = this.useList.cdr();
/*     */       } 
/* 675 */       this.useList = newList.nreverse();
/* 676 */       Debug.assertTrue(!Lisp.memq(pkg, this.useList));
/* 677 */       Debug.assertTrue((pkg.usedByList != null));
/* 678 */       Debug.assertTrue(pkg.usedByList.contains(this));
/* 679 */       pkg.usedByList.remove(this);
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public final void addNickname(String s) {
/* 687 */     Packages.addNickname(this, s);
/*     */     
/* 689 */     if (this.nicknames != null) {
/* 690 */       if (this.nicknames.contains(s))
/*     */         return; 
/*     */     } else {
/* 693 */       this.nicknames = new ArrayList<>();
/*     */     } 
/* 695 */     this.nicknames.add(s);
/*     */   }
/*     */ 
/*     */   
/*     */   public String getNickname() {
/* 700 */     if (this.nicknames != null && this.nicknames.size() > 0)
/* 701 */       return this.nicknames.get(0); 
/* 702 */     return null;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject packageNicknames() {
/* 707 */     LispObject list = Lisp.NIL;
/* 708 */     if (this.nicknames != null) {
/* 709 */       for (int i = this.nicknames.size(); i-- > 0; ) {
/* 710 */         String nickname = this.nicknames.get(i);
/* 711 */         list = new Cons(new SimpleString(nickname), list);
/*     */       } 
/*     */     }
/* 714 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getUseList() {
/* 719 */     if (this.useList == null)
/* 720 */       this.useList = Lisp.NIL; 
/* 721 */     return this.useList;
/*     */   }
/*     */ 
/*     */   
/*     */   public boolean uses(LispObject pkg) {
/* 726 */     return (this.useList instanceof Cons && Lisp.memq(pkg, this.useList));
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getUsedByList() {
/* 731 */     LispObject list = Lisp.NIL;
/* 732 */     if (this.usedByList != null) {
/* 733 */       for (Iterator<Package> it = this.usedByList.iterator(); it.hasNext(); ) {
/* 734 */         Package pkg = it.next();
/* 735 */         list = new Cons(pkg, list);
/*     */       } 
/*     */     }
/* 738 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getLocalPackageNicknames() {
/* 743 */     LispObject list = Lisp.NIL;
/* 744 */     if (this.localNicknames != null) {
/* 745 */       for (Map.Entry<String, Package> entry : this.localNicknames.entrySet()) {
/* 746 */         list = new Cons(new Cons(entry.getKey(), entry.getValue()), list);
/*     */       }
/*     */     }
/* 749 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject addLocalPackageNickname(String name, Package pack) {
/* 754 */     if (this.localNicknames == null) {
/* 755 */       this.localNicknames = new ConcurrentHashMap<>();
/*     */     }
/* 757 */     if (this.localNicknames.containsKey(name)) {
/* 758 */       if (this.localNicknames.get(name) != pack) {
/* 759 */         return Lisp.error(new LispError(name + " is already a nickname for " + pack
/* 760 */               .getName()));
/*     */       }
/*     */       
/* 763 */       return this;
/*     */     } 
/*     */     
/* 766 */     this.localNicknames.put(name, pack);
/* 767 */     return this;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject removeLocalPackageNickname(String name) {
/* 773 */     if (this.localNicknames == null || !this.localNicknames.containsKey(name)) {
/* 774 */       return Lisp.NIL;
/*     */     }
/*     */     
/* 777 */     return this.localNicknames.remove(name);
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public void removeLocalPackageNicknamesForPackage(Package p) {
/* 783 */     if (this.localNicknames == null || !this.localNicknames.containsValue(p)) {
/*     */       return;
/*     */     }
/* 786 */     for (Map.Entry<String, Package> entry : this.localNicknames.entrySet()) {
/* 787 */       if (entry.getValue() == p) {
/* 788 */         this.localNicknames.remove(entry.getKey());
/*     */       }
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public Collection<Package> getLocallyNicknamedPackages() {
/* 797 */     if (this.localNicknames == null) return new ArrayList<>(); 
/* 798 */     return this.localNicknames.values();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Package findPackage(String name) {
/* 804 */     if (this.localNicknames != null) {
/* 805 */       Package pkg = this.localNicknames.get(name);
/* 806 */       if (pkg != null) return pkg; 
/*     */     } 
/* 808 */     return Packages.findPackageGlobally(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public LispObject getShadowingSymbols() {
/* 813 */     LispObject list = Lisp.NIL;
/* 814 */     if (this.shadowingSymbols != null) {
/* 815 */       for (Iterator<Symbol> it = this.shadowingSymbols.values().iterator(); it.hasNext(); ) {
/* 816 */         Symbol symbol = it.next();
/* 817 */         list = new Cons(symbol, list);
/*     */       } 
/*     */     }
/* 820 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized Collection getExternalSymbols() {
/* 825 */     return this.externalSymbols.values();
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized List<Symbol> getAccessibleSymbols() {
/* 830 */     ArrayList<Symbol> list = new ArrayList<>();
/* 831 */     list.addAll(this.internalSymbols.values());
/* 832 */     list.addAll(this.externalSymbols.values());
/* 833 */     if (this.useList instanceof Cons) {
/* 834 */       LispObject usedPackages = this.useList;
/* 835 */       while (usedPackages != Lisp.NIL) {
/* 836 */         Package pkg = (Package)usedPackages.car();
/* 837 */         list.addAll(pkg.externalSymbols.values());
/*     */         
/* 839 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/* 842 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized LispObject PACKAGE_INTERNAL_SYMBOLS() {
/* 847 */     LispObject list = Lisp.NIL;
/* 848 */     Collection<Symbol> symbols = this.internalSymbols.values();
/* 849 */     for (Iterator<Symbol> i = symbols.iterator(); i.hasNext();)
/* 850 */       list = new Cons(i.next(), list); 
/* 851 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized LispObject PACKAGE_EXTERNAL_SYMBOLS() {
/* 856 */     LispObject list = Lisp.NIL;
/* 857 */     Collection<Symbol> symbols = this.externalSymbols.values();
/* 858 */     for (Iterator<Symbol> i = symbols.iterator(); i.hasNext();)
/* 859 */       list = new Cons(i.next(), list); 
/* 860 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized LispObject PACKAGE_INHERITED_SYMBOLS() {
/* 865 */     LispObject list = Lisp.NIL;
/* 866 */     if (this.useList instanceof Cons) {
/* 867 */       LispObject usedPackages = this.useList;
/* 868 */       while (usedPackages != Lisp.NIL) {
/* 869 */         Package pkg = (Package)usedPackages.car();
/* 870 */         Collection<Symbol> externals = pkg.getExternalSymbols();
/* 871 */         for (Iterator<Symbol> i = externals.iterator(); i.hasNext(); ) {
/* 872 */           Symbol symbol = i.next();
/* 873 */           if (this.shadowingSymbols != null && this.shadowingSymbols.get(symbol.getName()) != null)
/*     */             continue; 
/* 875 */           if (this.externalSymbols.get(symbol.name.toString()) == symbol)
/*     */             continue; 
/* 877 */           list = new Cons(symbol, list);
/*     */         } 
/* 879 */         usedPackages = usedPackages.cdr();
/*     */       } 
/*     */     } 
/* 882 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized LispObject getSymbols() {
/* 887 */     LispObject list = Lisp.NIL;
/* 888 */     Collection<Symbol> internals = this.internalSymbols.values();
/* 889 */     for (Iterator<Symbol> i = internals.iterator(); i.hasNext();)
/* 890 */       list = new Cons(i.next(), list); 
/* 891 */     Collection<Symbol> externals = this.externalSymbols.values();
/* 892 */     for (Iterator<Symbol> iterator1 = externals.iterator(); iterator1.hasNext();)
/* 893 */       list = new Cons(iterator1.next(), list); 
/* 894 */     return list;
/*     */   }
/*     */ 
/*     */   
/*     */   public synchronized Symbol[] symbols() {
/* 899 */     Collection<Symbol> internals = this.internalSymbols.values();
/* 900 */     Collection<Symbol> externals = this.externalSymbols.values();
/* 901 */     Symbol[] array = new Symbol[internals.size() + externals.size()];
/* 902 */     int i = 0;
/* 903 */     for (Iterator<Symbol> iterator1 = internals.iterator(); iterator1.hasNext(); ) {
/* 904 */       Symbol symbol = iterator1.next();
/* 905 */       array[i++] = symbol;
/*     */     } 
/* 907 */     for (Iterator<Symbol> it = externals.iterator(); it.hasNext(); ) {
/* 908 */       Symbol symbol = it.next();
/* 909 */       array[i++] = symbol;
/*     */     } 
/* 911 */     return array;
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public String printObject() {
/* 917 */     if (Lisp._PRINT_FASL_.symbolValue() != Lisp.NIL && this.name != null) {
/* 918 */       StringBuilder sb = new StringBuilder("#.(CL:FIND-PACKAGE \"");
/* 919 */       sb.append(this.name);
/* 920 */       sb.append("\")");
/* 921 */       return sb.toString();
/*     */     } 
/* 923 */     if (this.name != null) {
/* 924 */       return unreadableString("PACKAGE " + this.name, false);
/*     */     }
/* 926 */     return unreadableString("PACKAGE");
/*     */   }
/*     */ 
/*     */   
/*     */   public Object readResolve() throws ObjectStreamException {
/* 931 */     Package pkg = findPackage(this.name);
/* 932 */     if (pkg != null) {
/* 933 */       return pkg;
/*     */     }
/* 935 */     return Lisp.error(new PackageError(this.name + " is not the name of a package.", new SimpleString(this.name)));
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Package.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */