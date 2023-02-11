/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.ObjectStreamException;
/*      */ import java.io.Serializable;
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
/*      */ public class Symbol
/*      */   extends LispObject
/*      */   implements Serializable
/*      */ {
/*      */   private static final int FLAG_SPECIAL = 1;
/*      */   private static final int FLAG_CONSTANT = 2;
/*      */   private static final int FLAG_BUILT_IN_FUNCTION = 4;
/*      */   public final SimpleString name;
/*      */   
/*      */   public static final Symbol addFunction(String name, LispObject obj) {
/*   47 */     Symbol symbol = Lisp.PACKAGE_CL.internAndExport(name);
/*   48 */     symbol.function = obj;
/*   49 */     return symbol;
/*      */   }
/*      */ 
/*      */   
/*   53 */   private int hash = -1;
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*   58 */   transient int specialIndex = 0;
/*      */   
/*      */   private LispObject pkg;
/*      */   
/*      */   private transient LispObject value;
/*      */   private transient LispObject function;
/*      */   private transient LispObject propertyList;
/*      */   private int flags;
/*      */   
/*      */   public Symbol(String s) {
/*   68 */     this.name = new SimpleString(s);
/*   69 */     this.pkg = Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public Symbol(SimpleString string) {
/*   74 */     this.name = string;
/*   75 */     this.pkg = Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public Symbol(String s, Package pkg) {
/*   80 */     this.name = new SimpleString(s);
/*   81 */     this.pkg = pkg;
/*      */   }
/*      */ 
/*      */   
/*      */   public Symbol(SimpleString string, Package pkg) {
/*   86 */     this.name = string;
/*   87 */     this.pkg = pkg;
/*      */   }
/*      */ 
/*      */   
/*      */   public Symbol(SimpleString string, int hash, Package pkg) {
/*   92 */     this.name = string;
/*   93 */     this.hash = hash;
/*   94 */     this.pkg = pkg;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   protected void finalize() throws Throwable {
/*      */     try {
/*  101 */       if (this.specialIndex != 0)
/*  102 */         LispThread.releaseSpecialIndex(this); 
/*      */     } finally {
/*  104 */       super.finalize();
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject typeOf() {
/*  111 */     if (this.pkg == Lisp.PACKAGE_KEYWORD)
/*  112 */       return KEYWORD; 
/*  113 */     if (this == T)
/*  114 */       return BOOLEAN; 
/*  115 */     return SYMBOL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject classOf() {
/*  121 */     return BuiltInClass.SYMBOL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject getDescription() {
/*  127 */     LispThread thread = LispThread.currentThread();
/*  128 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*  129 */     thread.bindSpecial(PRINT_ESCAPE, Lisp.NIL);
/*      */     
/*      */     try {
/*  132 */       StringBuilder sb = new StringBuilder("The symbol ");
/*  133 */       sb.append(this.name.princToString());
/*  134 */       sb.append(" at #x");
/*  135 */       sb.append(Integer.toHexString(System.identityHashCode(this)).toUpperCase());
/*  136 */       if (this.pkg instanceof Package) {
/*      */         
/*  138 */         sb.append(", an ");
/*  139 */         Symbol sym = ((Package)this.pkg).findExternalSymbol(this.name);
/*  140 */         sb.append((sym == this) ? "external" : "internal");
/*  141 */         sb.append(" symbol in the ");
/*  142 */         sb.append(((Package)this.pkg).getName());
/*  143 */         sb.append(" package");
/*      */       } 
/*  145 */       return new SimpleString(sb);
/*      */     }
/*      */     finally {
/*      */       
/*  149 */       thread.resetSpecialBindings(mark);
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject getParts() {
/*  156 */     LispObject parts = Lisp.NIL;
/*  157 */     parts = parts.push(new Cons("name", this.name));
/*  158 */     parts = parts.push(new Cons("package", this.pkg));
/*  159 */     parts = parts.push(new Cons("value", this.value));
/*  160 */     parts = parts.push(new Cons("function", this.function));
/*  161 */     parts = parts.push(new Cons("plist", this.propertyList));
/*  162 */     parts = parts.push(new Cons("flags", Fixnum.getInstance(this.flags)));
/*  163 */     parts = parts.push(new Cons("hash", Fixnum.getInstance(this.hash)));
/*  164 */     return parts.nreverse();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject typep(LispObject type) {
/*  170 */     if (type == SYMBOL)
/*  171 */       return T; 
/*  172 */     if (type == BuiltInClass.SYMBOL)
/*  173 */       return T; 
/*  174 */     if (type == KEYWORD)
/*  175 */       return (this.pkg == Lisp.PACKAGE_KEYWORD) ? T : Lisp.NIL; 
/*  176 */     if (type == BOOLEAN)
/*  177 */       return (this == T) ? T : Lisp.NIL; 
/*  178 */     return super.typep(type);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public boolean constantp() {
/*  184 */     return ((this.flags & 0x2) != 0);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject STRING() {
/*  190 */     return this.name;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject getPackage() {
/*  195 */     return this.pkg;
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setPackage(LispObject obj) {
/*  200 */     this.pkg = obj;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final boolean isSpecialOperator() {
/*  206 */     return this.function instanceof SpecialOperator;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final boolean isSpecialVariable() {
/*  212 */     return ((this.flags & 0x1) != 0);
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setSpecial(boolean b) {
/*  217 */     if (b) {
/*  218 */       this.flags |= 0x1;
/*      */     } else {
/*  220 */       this.flags &= 0xFFFFFFFE;
/*      */     } 
/*      */   }
/*      */   
/*      */   public final void initializeSpecial(LispObject value) {
/*  225 */     this.flags |= 0x1;
/*  226 */     this.value = value;
/*      */   }
/*      */ 
/*      */   
/*      */   public final boolean isConstant() {
/*  231 */     return ((this.flags & 0x2) != 0);
/*      */   }
/*      */ 
/*      */   
/*      */   public final void initializeConstant(LispObject value) {
/*  236 */     this.flags |= 0x3;
/*  237 */     this.value = value;
/*      */   }
/*      */ 
/*      */   
/*      */   public final boolean isBuiltInFunction() {
/*  242 */     return ((this.flags & 0x4) != 0);
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setBuiltInFunction(boolean b) {
/*  247 */     if (b) {
/*  248 */       this.flags |= 0x4;
/*      */     } else {
/*  250 */       this.flags &= 0xFFFFFFFB;
/*      */     } 
/*      */   }
/*      */   
/*      */   public final String getName() {
/*  255 */     return this.name.getStringValue();
/*      */   }
/*      */ 
/*      */   
/*      */   public final String getQualifiedName() {
/*  260 */     String n = this.name.getStringValue();
/*  261 */     if (this.pkg == Lisp.NIL)
/*  262 */       return "#:".concat(n); 
/*  263 */     if (this.pkg == Lisp.PACKAGE_KEYWORD)
/*  264 */       return ":".concat(n); 
/*  265 */     StringBuilder sb = new StringBuilder(((Package)this.pkg).getName());
/*  266 */     if (((Package)this.pkg).findExternalSymbol(this.name) != null) {
/*  267 */       sb.append(':');
/*      */     } else {
/*  269 */       sb.append("::");
/*  270 */     }  sb.append(n);
/*  271 */     return sb.toString();
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
/*      */   public LispObject getSymbolValue() {
/*  284 */     return this.value;
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
/*      */   public final void setSymbolValue(LispObject value) {
/*  296 */     if (isConstant())
/*      */     {
/*  298 */       Lisp.program_error("Can't change value of constant symbol " + 
/*  299 */           princToString() + "."); } 
/*  300 */     this.value = value;
/*      */   }
/*      */   
/*      */   public SymbolMacro getSymbolMacro() {
/*  304 */     LispObject symbolMacro = Lisp.get(this, SYMBOL_MACRO, null);
/*  305 */     if (symbolMacro instanceof SymbolMacro)
/*  306 */       return (SymbolMacro)symbolMacro; 
/*  307 */     if (symbolMacro != null) {
/*  308 */       Lisp.error(new TypeError("The object " + symbolMacro + " is not a symbol macro"));
/*      */     }
/*  310 */     return null;
/*      */   }
/*      */   
/*      */   public void setSymbolMacro(SymbolMacro symbolMacro) {
/*  314 */     if (isSpecialVariable()) {
/*  315 */       Lisp.program_error("Symbol " + princToString() + " names a special variable; can't install symbol macro.");
/*      */     }
/*  317 */     Lisp.put(this, SYMBOL_MACRO, symbolMacro);
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
/*      */   public final LispObject symbolValue() {
/*  333 */     return symbolValue(LispThread.currentThread());
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
/*      */   public final LispObject symbolValue(LispThread thread) {
/*  349 */     LispObject val = thread.lookupSpecial(this);
/*  350 */     if (val != null)
/*  351 */       return val; 
/*  352 */     if (this.value != null)
/*  353 */       return this.value; 
/*  354 */     return Lisp.error(new UnboundVariable(this));
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
/*      */   public final LispObject symbolValueNoThrow() {
/*  370 */     return symbolValueNoThrow(LispThread.currentThread());
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
/*      */   public final LispObject symbolValueNoThrow(LispThread thread) {
/*  386 */     if ((this.flags & 0x1) != 0) {
/*      */       
/*  388 */       LispObject val = thread.lookupSpecial(this);
/*  389 */       if (val != null)
/*  390 */         return val; 
/*      */     } 
/*  392 */     return this.value;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject getSymbolFunction() {
/*  398 */     return this.function;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject getSymbolFunctionOrDie() {
/*  404 */     if (this.function == null)
/*  405 */       return Lisp.error(new UndefinedFunction(this)); 
/*  406 */     if (this.function instanceof Autoload) {
/*      */       
/*  408 */       Autoload autoload = (Autoload)this.function;
/*  409 */       autoload.load();
/*      */     } 
/*  411 */     return this.function;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject getSymbolSetfFunction() {
/*  417 */     return Lisp.get(this, SETF_FUNCTION, Lisp.NIL);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject getSymbolSetfFunctionOrDie() {
/*  424 */     LispObject obj = Lisp.get(this, SETF_FUNCTION, null);
/*  425 */     if (obj == null)
/*  426 */       Lisp.error(new UndefinedFunction(Lisp.list(Keyword.NAME, new LispObject[] {
/*  427 */                 Lisp.list(SETF, new LispObject[] { this })
/*      */               }))); 
/*  429 */     return obj;
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setSymbolFunction(LispObject obj) {
/*  434 */     this.function = obj;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public String getStringValue() {
/*  441 */     return this.name.getStringValue();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject getPropertyList() {
/*  447 */     if (this.propertyList == null)
/*  448 */       this.propertyList = Lisp.NIL; 
/*  449 */     return this.propertyList;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final void setPropertyList(LispObject obj) {
/*  455 */     if (obj == null)
/*  456 */       throw new NullPointerException(); 
/*  457 */     this.propertyList = obj;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public String printObject() {
/*  463 */     String n = this.name.getStringValue();
/*  464 */     LispThread thread = LispThread.currentThread();
/*  465 */     boolean printEscape = (PRINT_ESCAPE.symbolValue(thread) != Lisp.NIL);
/*  466 */     LispObject printCase = PRINT_CASE.symbolValue(thread);
/*      */     
/*  468 */     LispObject readtableCase = ((Readtable)CURRENT_READTABLE.symbolValue(thread)).getReadtableCase();
/*  469 */     boolean printReadably = (PRINT_READABLY.symbolValue(thread) != Lisp.NIL);
/*      */     
/*  471 */     if (printReadably) {
/*  472 */       if (readtableCase != Keyword.UPCASE || printCase != Keyword.UPCASE) {
/*  473 */         StringBuilder stringBuilder = new StringBuilder();
/*  474 */         if (this.pkg == Lisp.PACKAGE_KEYWORD) {
/*  475 */           stringBuilder.append(':');
/*  476 */         } else if (this.pkg instanceof Package) {
/*  477 */           stringBuilder.append(multipleEscape(((Package)this.pkg).getName()));
/*  478 */           stringBuilder.append("::");
/*      */         } else {
/*  480 */           stringBuilder.append("#:");
/*      */         } 
/*  482 */         stringBuilder.append(multipleEscape(n));
/*  483 */         return stringBuilder.toString();
/*      */       } 
/*      */       
/*  486 */       printEscape = true;
/*      */     } 
/*      */     
/*  489 */     if (!printEscape) {
/*  490 */       if (this.pkg == Lisp.PACKAGE_KEYWORD) {
/*  491 */         if (printCase == Keyword.DOWNCASE)
/*  492 */           return n.toLowerCase(); 
/*  493 */         if (printCase == Keyword.CAPITALIZE)
/*  494 */           return capitalize(n, readtableCase); 
/*  495 */         return n;
/*      */       } 
/*      */       
/*  498 */       if (readtableCase == Keyword.UPCASE) {
/*  499 */         if (printCase == Keyword.DOWNCASE)
/*  500 */           return n.toLowerCase(); 
/*  501 */         if (printCase == Keyword.CAPITALIZE)
/*  502 */           return capitalize(n, readtableCase); 
/*  503 */         return n;
/*  504 */       }  if (readtableCase == Keyword.DOWNCASE) {
/*      */ 
/*      */ 
/*      */         
/*  508 */         if (printCase == Keyword.DOWNCASE)
/*  509 */           return n; 
/*  510 */         if (printCase == Keyword.UPCASE)
/*  511 */           return n.toUpperCase(); 
/*  512 */         if (printCase == Keyword.CAPITALIZE)
/*  513 */           return capitalize(n, readtableCase); 
/*  514 */         return n;
/*  515 */       }  if (readtableCase == Keyword.PRESERVE) {
/*  516 */         return n;
/*      */       }
/*  518 */       return invert(n);
/*      */     } 
/*      */     
/*  521 */     boolean escapeSymbolName = needsEscape(n, readtableCase, thread);
/*  522 */     String symbolName = escapeSymbolName ? multipleEscape(n) : n;
/*  523 */     if (!escapeSymbolName && 
/*  524 */       readtableCase != Keyword.PRESERVE)
/*      */     {
/*  526 */       if (readtableCase == Keyword.INVERT) {
/*  527 */         symbolName = invert(symbolName);
/*  528 */       } else if (printCase == Keyword.DOWNCASE) {
/*  529 */         symbolName = symbolName.toLowerCase();
/*  530 */       } else if (printCase == Keyword.UPCASE) {
/*  531 */         symbolName = symbolName.toUpperCase();
/*  532 */       } else if (printCase == Keyword.CAPITALIZE) {
/*  533 */         symbolName = capitalize(symbolName, readtableCase);
/*      */       } 
/*      */     }
/*  536 */     if (this.pkg == Lisp.NIL) {
/*  537 */       if (printReadably || PRINT_GENSYM.symbolValue(thread) != Lisp.NIL) {
/*  538 */         return "#:".concat(symbolName);
/*      */       }
/*  540 */       return symbolName;
/*      */     } 
/*      */     
/*  543 */     if (this.pkg == Lisp.PACKAGE_KEYWORD) {
/*  544 */       return ":".concat(symbolName);
/*      */     }
/*      */ 
/*      */     
/*  548 */     Package currentPackage = (Package)_PACKAGE_.symbolValue(thread);
/*  549 */     if (this.pkg == currentPackage) {
/*  550 */       return symbolName;
/*      */     }
/*  552 */     if (currentPackage != null && currentPackage.uses(this.pkg))
/*      */     {
/*  554 */       if (currentPackage.findExternalSymbol(this.name) == null && 
/*  555 */         currentPackage.findInternalSymbol(this.name) == null && (
/*  556 */         (Package)this.pkg).findExternalSymbol(this.name) != null) {
/*  557 */         return symbolName;
/*      */       }
/*      */     }
/*  560 */     if (currentPackage.findExternalSymbol(this.name) == this)
/*  561 */       return symbolName; 
/*  562 */     if (currentPackage.findInternalSymbol(this.name) == this)
/*  563 */       return symbolName; 
/*  564 */     if (currentPackage.findAccessibleSymbol(this.name) == this) {
/*  565 */       return symbolName;
/*      */     }
/*  567 */     String packageName = ((Package)this.pkg).getName();
/*  568 */     if (currentPackage.getLocallyNicknamedPackages().contains(this.pkg)) {
/*  569 */       LispObject nicknames = currentPackage.getLocalPackageNicknames();
/*  570 */       while (nicknames != Lisp.NIL) {
/*  571 */         if (nicknames.car().cdr() == this.pkg) {
/*  572 */           packageName = Lisp.javaString(nicknames.car().car());
/*  573 */           nicknames = Lisp.NIL; continue;
/*      */         } 
/*  575 */         nicknames = nicknames.cdr();
/*      */       } 
/*      */     } 
/*      */     
/*  579 */     boolean escapePackageName = needsEscape(packageName, readtableCase, thread);
/*  580 */     if (escapePackageName) {
/*      */       
/*  582 */       packageName = multipleEscape(packageName);
/*      */ 
/*      */     
/*      */     }
/*  586 */     else if (readtableCase == Keyword.UPCASE) {
/*      */       
/*  588 */       if (printCase == Keyword.DOWNCASE) {
/*  589 */         packageName = packageName.toLowerCase();
/*  590 */       } else if (printCase == Keyword.CAPITALIZE) {
/*  591 */         packageName = capitalize(packageName, readtableCase);
/*      */       } 
/*  593 */     } else if (readtableCase == Keyword.DOWNCASE) {
/*      */       
/*  595 */       if (printCase == Keyword.UPCASE) {
/*  596 */         packageName = packageName.toUpperCase();
/*  597 */       } else if (printCase == Keyword.CAPITALIZE) {
/*  598 */         packageName = capitalize(packageName, readtableCase);
/*      */       } 
/*  600 */     } else if (readtableCase == Keyword.INVERT) {
/*      */       
/*  602 */       packageName = invert(packageName);
/*      */     } 
/*      */     
/*  605 */     StringBuilder sb = new StringBuilder(packageName);
/*  606 */     if (((Package)this.pkg).findExternalSymbol(this.name) != null && Lisp.DOUBLE_COLON_PACKAGE_SEPARATORS
/*  607 */       .symbolValue(thread) == Lisp.NIL) {
/*  608 */       sb.append(':');
/*      */     } else {
/*  610 */       sb.append("::");
/*  611 */     }  sb.append(symbolName);
/*  612 */     return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private static final String invert(String s) {
/*  620 */     int limit = s.length();
/*  621 */     int LOWER = 1;
/*  622 */     int UPPER = 2;
/*  623 */     int state = 0;
/*  624 */     for (int i = 0; i < limit; i++) {
/*      */       
/*  626 */       char c = s.charAt(i);
/*  627 */       if (Character.isUpperCase(c)) {
/*      */         
/*  629 */         if (state == 1)
/*  630 */           return s; 
/*  631 */         state = 2;
/*      */       } 
/*  633 */       if (Character.isLowerCase(c)) {
/*      */         
/*  635 */         if (state == 2)
/*  636 */           return s; 
/*  637 */         state = 1;
/*      */       } 
/*      */     } 
/*  640 */     StringBuilder sb = new StringBuilder(limit);
/*  641 */     for (int j = 0; j < limit; j++) {
/*      */       
/*  643 */       char c = s.charAt(j);
/*  644 */       if (Character.isUpperCase(c)) {
/*  645 */         sb.append(Character.toLowerCase(c));
/*  646 */       } else if (Character.isLowerCase(c)) {
/*  647 */         sb.append(Character.toUpperCase(c));
/*      */       } else {
/*  649 */         sb.append(c);
/*      */       } 
/*  651 */     }  return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   private static final boolean needsEscape(String s, LispObject readtableCase, LispThread thread) {
/*      */     int radix;
/*  659 */     boolean escape = false;
/*  660 */     int length = s.length();
/*  661 */     if (length == 0)
/*  662 */       return true; 
/*  663 */     if (s.charAt(0) == '#') {
/*  664 */       return true;
/*      */     }
/*  666 */     LispObject printBaseBinding = PRINT_BASE.symbolValue(thread);
/*  667 */     if (printBaseBinding instanceof Fixnum) {
/*      */       
/*  669 */       radix = ((Fixnum)printBaseBinding).value;
/*      */     }
/*      */     else {
/*      */       
/*  673 */       Lisp.error(new TypeError("The value of *PRINT-BASE* is not of type (INTEGER 2 36)."));
/*      */       
/*  675 */       return false;
/*      */     } 
/*  677 */     if (radix < 2 || radix > 36) {
/*      */       
/*  679 */       Lisp.error(new TypeError("The value of *PRINT-BASE* is not of type (INTEGER 2 36)."));
/*      */       
/*  681 */       return false;
/*      */     } 
/*  683 */     boolean seenNonDigit = false;
/*  684 */     for (int i = length; i-- > 0; ) {
/*      */       
/*  686 */       char c = s.charAt(i);
/*  687 */       if ("(),|\\`'\";:".indexOf(c) >= 0)
/*  688 */         return true; 
/*  689 */       if (Character.isWhitespace(c))
/*  690 */         return true; 
/*  691 */       if (readtableCase == Keyword.UPCASE) {
/*      */         
/*  693 */         if (Character.isLowerCase(c)) {
/*  694 */           return true;
/*      */         }
/*  696 */       } else if (readtableCase == Keyword.DOWNCASE) {
/*      */         
/*  698 */         if (Character.isUpperCase(c))
/*  699 */           return true; 
/*      */       } 
/*  701 */       if (!escape && !seenNonDigit)
/*      */       {
/*  703 */         if (Character.digit(c, radix) < 0)
/*  704 */           seenNonDigit = true; 
/*      */       }
/*      */     } 
/*  707 */     if (!seenNonDigit)
/*  708 */       return true; 
/*  709 */     if (s.charAt(0) == '.') {
/*      */       
/*  711 */       boolean allDots = true;
/*  712 */       for (int j = length; j-- > 1;) {
/*      */         
/*  714 */         if (s.charAt(j) != '.') {
/*      */           
/*  716 */           allDots = false;
/*      */           break;
/*      */         } 
/*      */       } 
/*  720 */       if (allDots)
/*  721 */         return true; 
/*      */     } 
/*  723 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   private static final String multipleEscape(String s) {
/*  728 */     StringBuilder sb = new StringBuilder("|");
/*  729 */     int limit = s.length();
/*  730 */     for (int i = 0; i < limit; i++) {
/*      */       
/*  732 */       char c = s.charAt(i);
/*  733 */       if (c == '|' || c == '\\')
/*  734 */         sb.append('\\'); 
/*  735 */       sb.append(c);
/*      */     } 
/*  737 */     sb.append('|');
/*  738 */     return sb.toString();
/*      */   }
/*      */ 
/*      */   
/*      */   private static final String capitalize(String s, LispObject readtableCase) {
/*  743 */     if (readtableCase == Keyword.INVERT || readtableCase == Keyword.PRESERVE)
/*  744 */       return s; 
/*  745 */     int limit = s.length();
/*  746 */     StringBuilder sb = new StringBuilder(limit);
/*  747 */     boolean lastCharWasAlphanumeric = false;
/*  748 */     for (int i = 0; i < limit; i++) {
/*      */       
/*  750 */       char c = s.charAt(i);
/*  751 */       if (Character.isLowerCase(c)) {
/*      */         
/*  753 */         if (readtableCase == Keyword.UPCASE) {
/*  754 */           sb.append(c);
/*      */         } else {
/*  756 */           sb.append(lastCharWasAlphanumeric ? c : LispCharacter.toUpperCase(c));
/*  757 */         }  lastCharWasAlphanumeric = true;
/*      */       }
/*  759 */       else if (Character.isUpperCase(c)) {
/*      */         
/*  761 */         if (readtableCase == Keyword.UPCASE) {
/*  762 */           sb.append(lastCharWasAlphanumeric ? LispCharacter.toLowerCase(c) : c);
/*      */         } else {
/*  764 */           sb.append(c);
/*  765 */         }  lastCharWasAlphanumeric = true;
/*      */       }
/*      */       else {
/*      */         
/*  769 */         sb.append(c);
/*  770 */         lastCharWasAlphanumeric = Character.isDigit(c);
/*      */       } 
/*      */     } 
/*  773 */     return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final int sxhash() {
/*  779 */     int h = this.hash;
/*  780 */     if (h < 0) {
/*      */       
/*  782 */       h = this.name.sxhash();
/*  783 */       this.hash = h;
/*      */     } 
/*  785 */     return h;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute() {
/*      */     LispObject fun;
/*  792 */     if ((fun = this.function) == null) {
/*  793 */       return undefinedFunction(Lisp.NIL);
/*      */     }
/*  795 */     return fun.execute();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject arg) {
/*      */     LispObject fun;
/*  802 */     if ((fun = this.function) == null) {
/*  803 */       return undefinedFunction(Lisp.list(arg, new LispObject[0]));
/*      */     }
/*  805 */     return fun.execute(arg);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second) {
/*      */     LispObject fun;
/*  813 */     if ((fun = this.function) == null) {
/*  814 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second }));
/*      */     }
/*  816 */     return fun.execute(first, second);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third) {
/*      */     LispObject fun;
/*  825 */     if ((fun = this.function) == null) {
/*  826 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third }));
/*      */     }
/*  828 */     return fun.execute(first, second, third);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*      */     LispObject fun;
/*  837 */     if ((fun = this.function) == null) {
/*  838 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third, fourth }));
/*      */     }
/*  840 */     return fun.execute(first, second, third, fourth);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/*      */     LispObject fun;
/*  850 */     if ((fun = this.function) == null) {
/*  851 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third, fourth, fifth }));
/*      */     }
/*      */     
/*  854 */     return fun.execute(first, second, third, fourth, fifth);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/*      */     LispObject fun;
/*  865 */     if ((fun = this.function) == null) {
/*  866 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third, fourth, fifth, sixth }));
/*      */     }
/*      */     
/*  869 */     return fun.execute(first, second, third, fourth, fifth, sixth);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/*      */     LispObject fun;
/*  881 */     if ((fun = this.function) == null) {
/*  882 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third, fourth, fifth, sixth, seventh }));
/*      */     }
/*      */     
/*  885 */     return fun.execute(first, second, third, fourth, fifth, sixth, seventh);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/*      */     LispObject fun;
/*  897 */     if ((fun = this.function) == null) {
/*  898 */       return undefinedFunction(Lisp.list(first, new LispObject[] { second, third, fourth, fifth, sixth, seventh, eighth }));
/*      */     }
/*      */     
/*  901 */     return fun.execute(first, second, third, fourth, fifth, sixth, seventh, eighth);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject execute(LispObject[] args) {
/*      */     LispObject fun;
/*  909 */     if ((fun = this.function) == null) {
/*  910 */       LispObject list = Lisp.NIL;
/*  911 */       for (int i = args.length; i-- > 0;)
/*  912 */         list = new Cons(args[i], list); 
/*  913 */       return undefinedFunction(list);
/*      */     } 
/*      */     
/*  916 */     return fun.execute(args);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   private final LispObject undefinedFunction(LispObject args) {
/*  922 */     return LispThread.currentThread().execute(UNDEFINED_FUNCTION_CALLED, this, args);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public void incrementCallCount() {
/*  929 */     if (this.function != null) {
/*  930 */       this.function.incrementCallCount();
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   public void incrementHotCount() {
/*  936 */     if (this.function != null)
/*  937 */       this.function.incrementHotCount(); 
/*      */   }
/*      */   
/*      */   public Object readResolve() throws ObjectStreamException {
/*  941 */     if (this.pkg instanceof Package) {
/*  942 */       Symbol s = ((Package)this.pkg).intern(this.name.getStringValue());
/*  943 */       return s;
/*      */     } 
/*  945 */     return this;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public String toString() {
/*  951 */     StringBuilder sb = new StringBuilder();
/*  952 */     if (this.pkg instanceof Package) {
/*  953 */       sb.append(((Package)this.pkg).getName());
/*  954 */       sb.append(":");
/*      */     } else {
/*  956 */       sb.append("#:");
/*      */     } 
/*  958 */     sb.append(this.name);
/*  959 */     return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*  964 */   public static final Symbol AND_ALLOW_OTHER_KEYS = Lisp.PACKAGE_CL
/*  965 */     .addExternalSymbol("&ALLOW-OTHER-KEYS");
/*  966 */   public static final Symbol AND_AUX = Lisp.PACKAGE_CL
/*  967 */     .addExternalSymbol("&AUX");
/*  968 */   public static final Symbol AND_BODY = Lisp.PACKAGE_CL
/*  969 */     .addExternalSymbol("&BODY");
/*  970 */   public static final Symbol AND_ENVIRONMENT = Lisp.PACKAGE_CL
/*  971 */     .addExternalSymbol("&ENVIRONMENT");
/*  972 */   public static final Symbol AND_KEY = Lisp.PACKAGE_CL
/*  973 */     .addExternalSymbol("&KEY");
/*  974 */   public static final Symbol AND_OPTIONAL = Lisp.PACKAGE_CL
/*  975 */     .addExternalSymbol("&OPTIONAL");
/*  976 */   public static final Symbol AND_REST = Lisp.PACKAGE_CL
/*  977 */     .addExternalSymbol("&REST");
/*  978 */   public static final Symbol AND_WHOLE = Lisp.PACKAGE_CL
/*  979 */     .addExternalSymbol("&WHOLE");
/*  980 */   public static final Symbol STAR = Lisp.PACKAGE_CL
/*  981 */     .addExternalSymbol("*");
/*  982 */   public static final Symbol STAR_STAR = Lisp.PACKAGE_CL
/*  983 */     .addExternalSymbol("**");
/*  984 */   public static final Symbol STAR_STAR_STAR = Lisp.PACKAGE_CL
/*  985 */     .addExternalSymbol("***");
/*  986 */   public static final Symbol BREAK_ON_SIGNALS = Lisp.PACKAGE_CL
/*  987 */     .addExternalSymbol("*BREAK-ON-SIGNALS*");
/*  988 */   public static final Symbol _COMPILE_FILE_PATHNAME_ = Lisp.PACKAGE_CL
/*  989 */     .addExternalSymbol("*COMPILE-FILE-PATHNAME*");
/*  990 */   public static final Symbol COMPILE_FILE_TRUENAME = Lisp.PACKAGE_CL
/*  991 */     .addExternalSymbol("*COMPILE-FILE-TRUENAME*");
/*  992 */   public static final Symbol COMPILE_PRINT = Lisp.PACKAGE_CL
/*  993 */     .addExternalSymbol("*COMPILE-PRINT*");
/*  994 */   public static final Symbol COMPILE_VERBOSE = Lisp.PACKAGE_CL
/*  995 */     .addExternalSymbol("*COMPILE-VERBOSE*");
/*  996 */   public static final Symbol DEBUG_IO = Lisp.PACKAGE_CL
/*  997 */     .addExternalSymbol("*DEBUG-IO*");
/*  998 */   public static final Symbol DEBUGGER_HOOK = Lisp.PACKAGE_CL
/*  999 */     .addExternalSymbol("*DEBUGGER-HOOK*");
/* 1000 */   public static final Symbol DEFAULT_PATHNAME_DEFAULTS = Lisp.PACKAGE_CL
/* 1001 */     .addExternalSymbol("*DEFAULT-PATHNAME-DEFAULTS*");
/* 1002 */   public static final Symbol ERROR_OUTPUT = Lisp.PACKAGE_CL
/* 1003 */     .addExternalSymbol("*ERROR-OUTPUT*");
/* 1004 */   public static final Symbol FEATURES = Lisp.PACKAGE_CL
/* 1005 */     .addExternalSymbol("*FEATURES*");
/* 1006 */   public static final Symbol GENSYM_COUNTER = Lisp.PACKAGE_CL
/* 1007 */     .addExternalSymbol("*GENSYM-COUNTER*");
/* 1008 */   public static final Symbol LOAD_PATHNAME = Lisp.PACKAGE_CL
/* 1009 */     .addExternalSymbol("*LOAD-PATHNAME*");
/* 1010 */   public static final Symbol LOAD_PRINT = Lisp.PACKAGE_CL
/* 1011 */     .addExternalSymbol("*LOAD-PRINT*");
/* 1012 */   public static final Symbol LOAD_TRUENAME = Lisp.PACKAGE_CL
/* 1013 */     .addExternalSymbol("*LOAD-TRUENAME*");
/* 1014 */   public static final Symbol LOAD_VERBOSE = Lisp.PACKAGE_CL
/* 1015 */     .addExternalSymbol("*LOAD-VERBOSE*");
/* 1016 */   public static final Symbol MACROEXPAND_HOOK = Lisp.PACKAGE_CL
/* 1017 */     .addExternalSymbol("*MACROEXPAND-HOOK*");
/* 1018 */   public static final Symbol MODULES = Lisp.PACKAGE_CL
/* 1019 */     .addExternalSymbol("*MODULES*");
/* 1020 */   public static final Symbol _PACKAGE_ = Lisp.PACKAGE_CL
/* 1021 */     .addExternalSymbol("*PACKAGE*");
/* 1022 */   public static final Symbol PRINT_ARRAY = Lisp.PACKAGE_CL
/* 1023 */     .addExternalSymbol("*PRINT-ARRAY*");
/* 1024 */   public static final Symbol PRINT_BASE = Lisp.PACKAGE_CL
/* 1025 */     .addExternalSymbol("*PRINT-BASE*");
/* 1026 */   public static final Symbol PRINT_CASE = Lisp.PACKAGE_CL
/* 1027 */     .addExternalSymbol("*PRINT-CASE*");
/* 1028 */   public static final Symbol PRINT_CIRCLE = Lisp.PACKAGE_CL
/* 1029 */     .addExternalSymbol("*PRINT-CIRCLE*");
/* 1030 */   public static final Symbol PRINT_ESCAPE = Lisp.PACKAGE_CL
/* 1031 */     .addExternalSymbol("*PRINT-ESCAPE*");
/* 1032 */   public static final Symbol PRINT_GENSYM = Lisp.PACKAGE_CL
/* 1033 */     .addExternalSymbol("*PRINT-GENSYM*");
/* 1034 */   public static final Symbol PRINT_LENGTH = Lisp.PACKAGE_CL
/* 1035 */     .addExternalSymbol("*PRINT-LENGTH*");
/* 1036 */   public static final Symbol PRINT_LEVEL = Lisp.PACKAGE_CL
/* 1037 */     .addExternalSymbol("*PRINT-LEVEL*");
/* 1038 */   public static final Symbol PRINT_LINES = Lisp.PACKAGE_CL
/* 1039 */     .addExternalSymbol("*PRINT-LINES*");
/* 1040 */   public static final Symbol PRINT_MISER_WIDTH = Lisp.PACKAGE_CL
/* 1041 */     .addExternalSymbol("*PRINT-MISER-WIDTH*");
/* 1042 */   public static final Symbol PRINT_PPRINT_DISPATCH = Lisp.PACKAGE_CL
/* 1043 */     .addExternalSymbol("*PRINT-PPRINT-DISPATCH*");
/* 1044 */   public static final Symbol PRINT_PRETTY = Lisp.PACKAGE_CL
/* 1045 */     .addExternalSymbol("*PRINT-PRETTY*");
/* 1046 */   public static final Symbol PRINT_RADIX = Lisp.PACKAGE_CL
/* 1047 */     .addExternalSymbol("*PRINT-RADIX*");
/* 1048 */   public static final Symbol PRINT_READABLY = Lisp.PACKAGE_CL
/* 1049 */     .addExternalSymbol("*PRINT-READABLY*");
/* 1050 */   public static final Symbol PRINT_RIGHT_MARGIN = Lisp.PACKAGE_CL
/* 1051 */     .addExternalSymbol("*PRINT-RIGHT-MARGIN*");
/* 1052 */   public static final Symbol QUERY_IO = Lisp.PACKAGE_CL
/* 1053 */     .addExternalSymbol("*QUERY-IO*");
/* 1054 */   public static final Symbol _RANDOM_STATE_ = Lisp.PACKAGE_CL
/* 1055 */     .addExternalSymbol("*RANDOM-STATE*");
/* 1056 */   public static final Symbol READ_BASE = Lisp.PACKAGE_CL
/* 1057 */     .addExternalSymbol("*READ-BASE*");
/* 1058 */   public static final Symbol READ_DEFAULT_FLOAT_FORMAT = Lisp.PACKAGE_CL
/* 1059 */     .addExternalSymbol("*READ-DEFAULT-FLOAT-FORMAT*");
/* 1060 */   public static final Symbol READ_EVAL = Lisp.PACKAGE_CL
/* 1061 */     .addExternalSymbol("*READ-EVAL*");
/* 1062 */   public static final Symbol READ_SUPPRESS = Lisp.PACKAGE_CL
/* 1063 */     .addExternalSymbol("*READ-SUPPRESS*");
/* 1064 */   public static final Symbol CURRENT_READTABLE = Lisp.PACKAGE_CL
/* 1065 */     .addExternalSymbol("*READTABLE*");
/* 1066 */   public static final Symbol STANDARD_INPUT = Lisp.PACKAGE_CL
/* 1067 */     .addExternalSymbol("*STANDARD-INPUT*");
/* 1068 */   public static final Symbol STANDARD_OUTPUT = Lisp.PACKAGE_CL
/* 1069 */     .addExternalSymbol("*STANDARD-OUTPUT*");
/* 1070 */   public static final Symbol TERMINAL_IO = Lisp.PACKAGE_CL
/* 1071 */     .addExternalSymbol("*TERMINAL-IO*");
/* 1072 */   public static final Symbol TRACE_OUTPUT = Lisp.PACKAGE_CL
/* 1073 */     .addExternalSymbol("*TRACE-OUTPUT*");
/* 1074 */   public static final Symbol PLUS = Lisp.PACKAGE_CL
/* 1075 */     .addExternalSymbol("+");
/* 1076 */   public static final Symbol PLUS_PLUS = Lisp.PACKAGE_CL
/* 1077 */     .addExternalSymbol("++");
/* 1078 */   public static final Symbol PLUS_PLUS_PLUS = Lisp.PACKAGE_CL
/* 1079 */     .addExternalSymbol("+++");
/* 1080 */   public static final Symbol MINUS = Lisp.PACKAGE_CL
/* 1081 */     .addExternalSymbol("-");
/* 1082 */   public static final Symbol SLASH = Lisp.PACKAGE_CL
/* 1083 */     .addExternalSymbol("/");
/* 1084 */   public static final Symbol SLASH_SLASH = Lisp.PACKAGE_CL
/* 1085 */     .addExternalSymbol("//");
/* 1086 */   public static final Symbol SLASH_SLASH_SLASH = Lisp.PACKAGE_CL
/* 1087 */     .addExternalSymbol("///");
/* 1088 */   public static final Symbol NOT_EQUALS = Lisp.PACKAGE_CL
/* 1089 */     .addExternalSymbol("/=");
/* 1090 */   public static final Symbol ONE_PLUS = Lisp.PACKAGE_CL
/* 1091 */     .addExternalSymbol("1+");
/* 1092 */   public static final Symbol ONE_MINUS = Lisp.PACKAGE_CL
/* 1093 */     .addExternalSymbol("1-");
/* 1094 */   public static final Symbol LT = Lisp.PACKAGE_CL
/* 1095 */     .addExternalSymbol("<");
/* 1096 */   public static final Symbol LE = Lisp.PACKAGE_CL
/* 1097 */     .addExternalSymbol("<=");
/* 1098 */   public static final Symbol EQUALS = Lisp.PACKAGE_CL
/* 1099 */     .addExternalSymbol("=");
/* 1100 */   public static final Symbol GT = Lisp.PACKAGE_CL
/* 1101 */     .addExternalSymbol(">");
/* 1102 */   public static final Symbol GE = Lisp.PACKAGE_CL
/* 1103 */     .addExternalSymbol(">=");
/* 1104 */   public static final Symbol ABORT = Lisp.PACKAGE_CL
/* 1105 */     .addExternalSymbol("ABORT");
/* 1106 */   public static final Symbol ABS = Lisp.PACKAGE_CL
/* 1107 */     .addExternalSymbol("ABS");
/* 1108 */   public static final Symbol ACONS = Lisp.PACKAGE_CL
/* 1109 */     .addExternalSymbol("ACONS");
/* 1110 */   public static final Symbol ACOS = Lisp.PACKAGE_CL
/* 1111 */     .addExternalSymbol("ACOS");
/* 1112 */   public static final Symbol ACOSH = Lisp.PACKAGE_CL
/* 1113 */     .addExternalSymbol("ACOSH");
/* 1114 */   public static final Symbol ADD_METHOD = Lisp.PACKAGE_CL
/* 1115 */     .addExternalSymbol("ADD-METHOD");
/* 1116 */   public static final Symbol ADJOIN = Lisp.PACKAGE_CL
/* 1117 */     .addExternalSymbol("ADJOIN");
/* 1118 */   public static final Symbol ADJUST_ARRAY = Lisp.PACKAGE_CL
/* 1119 */     .addExternalSymbol("ADJUST-ARRAY");
/* 1120 */   public static final Symbol ADJUSTABLE_ARRAY_P = Lisp.PACKAGE_CL
/* 1121 */     .addExternalSymbol("ADJUSTABLE-ARRAY-P");
/* 1122 */   public static final Symbol ALLOCATE_INSTANCE = Lisp.PACKAGE_CL
/* 1123 */     .addExternalSymbol("ALLOCATE-INSTANCE");
/* 1124 */   public static final Symbol ALPHA_CHAR_P = Lisp.PACKAGE_CL
/* 1125 */     .addExternalSymbol("ALPHA-CHAR-P");
/* 1126 */   public static final Symbol ALPHANUMERICP = Lisp.PACKAGE_CL
/* 1127 */     .addExternalSymbol("ALPHANUMERICP");
/* 1128 */   public static final Symbol AND = Lisp.PACKAGE_CL
/* 1129 */     .addExternalSymbol("AND");
/* 1130 */   public static final Symbol APPEND = Lisp.PACKAGE_CL
/* 1131 */     .addExternalSymbol("APPEND");
/* 1132 */   public static final Symbol APPLY = Lisp.PACKAGE_CL
/* 1133 */     .addExternalSymbol("APPLY");
/* 1134 */   public static final Symbol APROPOS = Lisp.PACKAGE_CL
/* 1135 */     .addExternalSymbol("APROPOS");
/* 1136 */   public static final Symbol APROPOS_LIST = Lisp.PACKAGE_CL
/* 1137 */     .addExternalSymbol("APROPOS-LIST");
/* 1138 */   public static final Symbol AREF = Lisp.PACKAGE_CL
/* 1139 */     .addExternalSymbol("AREF");
/* 1140 */   public static final Symbol ARITHMETIC_ERROR = Lisp.PACKAGE_CL
/* 1141 */     .addExternalSymbol("ARITHMETIC-ERROR");
/* 1142 */   public static final Symbol ARITHMETIC_ERROR_OPERANDS = Lisp.PACKAGE_CL
/* 1143 */     .addExternalSymbol("ARITHMETIC-ERROR-OPERANDS");
/* 1144 */   public static final Symbol ARITHMETIC_ERROR_OPERATION = Lisp.PACKAGE_CL
/* 1145 */     .addExternalSymbol("ARITHMETIC-ERROR-OPERATION");
/* 1146 */   public static final Symbol ARRAY = Lisp.PACKAGE_CL
/* 1147 */     .addExternalSymbol("ARRAY");
/* 1148 */   public static final Symbol ARRAY_DIMENSION = Lisp.PACKAGE_CL
/* 1149 */     .addExternalSymbol("ARRAY-DIMENSION");
/* 1150 */   public static final Symbol ARRAY_DIMENSION_LIMIT = Lisp.PACKAGE_CL
/* 1151 */     .addExternalSymbol("ARRAY-DIMENSION-LIMIT");
/* 1152 */   public static final Symbol ARRAY_DIMENSIONS = Lisp.PACKAGE_CL
/* 1153 */     .addExternalSymbol("ARRAY-DIMENSIONS");
/* 1154 */   public static final Symbol ARRAY_DISPLACEMENT = Lisp.PACKAGE_CL
/* 1155 */     .addExternalSymbol("ARRAY-DISPLACEMENT");
/* 1156 */   public static final Symbol ARRAY_ELEMENT_TYPE = Lisp.PACKAGE_CL
/* 1157 */     .addExternalSymbol("ARRAY-ELEMENT-TYPE");
/* 1158 */   public static final Symbol ARRAY_HAS_FILL_POINTER_P = Lisp.PACKAGE_CL
/* 1159 */     .addExternalSymbol("ARRAY-HAS-FILL-POINTER-P");
/* 1160 */   public static final Symbol ARRAY_IN_BOUNDS_P = Lisp.PACKAGE_CL
/* 1161 */     .addExternalSymbol("ARRAY-IN-BOUNDS-P");
/* 1162 */   public static final Symbol ARRAY_RANK = Lisp.PACKAGE_CL
/* 1163 */     .addExternalSymbol("ARRAY-RANK");
/* 1164 */   public static final Symbol ARRAY_RANK_LIMIT = Lisp.PACKAGE_CL
/* 1165 */     .addExternalSymbol("ARRAY-RANK-LIMIT");
/* 1166 */   public static final Symbol ARRAY_ROW_MAJOR_INDEX = Lisp.PACKAGE_CL
/* 1167 */     .addExternalSymbol("ARRAY-ROW-MAJOR-INDEX");
/* 1168 */   public static final Symbol ARRAY_TOTAL_SIZE = Lisp.PACKAGE_CL
/* 1169 */     .addExternalSymbol("ARRAY-TOTAL-SIZE");
/* 1170 */   public static final Symbol ARRAY_TOTAL_SIZE_LIMIT = Lisp.PACKAGE_CL
/* 1171 */     .addExternalSymbol("ARRAY-TOTAL-SIZE-LIMIT");
/* 1172 */   public static final Symbol ARRAYP = Lisp.PACKAGE_CL
/* 1173 */     .addExternalSymbol("ARRAYP");
/* 1174 */   public static final Symbol ASH = Lisp.PACKAGE_CL
/* 1175 */     .addExternalSymbol("ASH");
/* 1176 */   public static final Symbol ASIN = Lisp.PACKAGE_CL
/* 1177 */     .addExternalSymbol("ASIN");
/* 1178 */   public static final Symbol ASINH = Lisp.PACKAGE_CL
/* 1179 */     .addExternalSymbol("ASINH");
/* 1180 */   public static final Symbol ASSERT = Lisp.PACKAGE_CL
/* 1181 */     .addExternalSymbol("ASSERT");
/* 1182 */   public static final Symbol ASSOC = Lisp.PACKAGE_CL
/* 1183 */     .addExternalSymbol("ASSOC");
/* 1184 */   public static final Symbol ASSOC_IF = Lisp.PACKAGE_CL
/* 1185 */     .addExternalSymbol("ASSOC-IF");
/* 1186 */   public static final Symbol ASSOC_IF_NOT = Lisp.PACKAGE_CL
/* 1187 */     .addExternalSymbol("ASSOC-IF-NOT");
/* 1188 */   public static final Symbol ATAN = Lisp.PACKAGE_CL
/* 1189 */     .addExternalSymbol("ATAN");
/* 1190 */   public static final Symbol ATANH = Lisp.PACKAGE_CL
/* 1191 */     .addExternalSymbol("ATANH");
/* 1192 */   public static final Symbol ATOM = Lisp.PACKAGE_CL
/* 1193 */     .addExternalSymbol("ATOM");
/* 1194 */   public static final Symbol BASE_CHAR = Lisp.PACKAGE_CL
/* 1195 */     .addExternalSymbol("BASE-CHAR");
/* 1196 */   public static final Symbol BASE_STRING = Lisp.PACKAGE_CL
/* 1197 */     .addExternalSymbol("BASE-STRING");
/* 1198 */   public static final Symbol BIGNUM = Lisp.PACKAGE_CL
/* 1199 */     .addExternalSymbol("BIGNUM");
/* 1200 */   public static final Symbol BIT = Lisp.PACKAGE_CL
/* 1201 */     .addExternalSymbol("BIT");
/* 1202 */   public static final Symbol BIT_AND = Lisp.PACKAGE_CL
/* 1203 */     .addExternalSymbol("BIT-AND");
/* 1204 */   public static final Symbol BIT_ANDC1 = Lisp.PACKAGE_CL
/* 1205 */     .addExternalSymbol("BIT-ANDC1");
/* 1206 */   public static final Symbol BIT_ANDC2 = Lisp.PACKAGE_CL
/* 1207 */     .addExternalSymbol("BIT-ANDC2");
/* 1208 */   public static final Symbol BIT_EQV = Lisp.PACKAGE_CL
/* 1209 */     .addExternalSymbol("BIT-EQV");
/* 1210 */   public static final Symbol BIT_IOR = Lisp.PACKAGE_CL
/* 1211 */     .addExternalSymbol("BIT-IOR");
/* 1212 */   public static final Symbol BIT_NAND = Lisp.PACKAGE_CL
/* 1213 */     .addExternalSymbol("BIT-NAND");
/* 1214 */   public static final Symbol BIT_NOR = Lisp.PACKAGE_CL
/* 1215 */     .addExternalSymbol("BIT-NOR");
/* 1216 */   public static final Symbol BIT_NOT = Lisp.PACKAGE_CL
/* 1217 */     .addExternalSymbol("BIT-NOT");
/* 1218 */   public static final Symbol BIT_ORC1 = Lisp.PACKAGE_CL
/* 1219 */     .addExternalSymbol("BIT-ORC1");
/* 1220 */   public static final Symbol BIT_ORC2 = Lisp.PACKAGE_CL
/* 1221 */     .addExternalSymbol("BIT-ORC2");
/* 1222 */   public static final Symbol BIT_VECTOR = Lisp.PACKAGE_CL
/* 1223 */     .addExternalSymbol("BIT-VECTOR");
/* 1224 */   public static final Symbol BIT_VECTOR_P = Lisp.PACKAGE_CL
/* 1225 */     .addExternalSymbol("BIT-VECTOR-P");
/* 1226 */   public static final Symbol BIT_XOR = Lisp.PACKAGE_CL
/* 1227 */     .addExternalSymbol("BIT-XOR");
/* 1228 */   public static final Symbol BLOCK = Lisp.PACKAGE_CL
/* 1229 */     .addExternalSymbol("BLOCK");
/* 1230 */   public static final Symbol BOOLE = Lisp.PACKAGE_CL
/* 1231 */     .addExternalSymbol("BOOLE");
/* 1232 */   public static final Symbol BOOLE_1 = Lisp.PACKAGE_CL
/* 1233 */     .addExternalSymbol("BOOLE-1");
/* 1234 */   public static final Symbol BOOLE_2 = Lisp.PACKAGE_CL
/* 1235 */     .addExternalSymbol("BOOLE-2");
/* 1236 */   public static final Symbol BOOLE_AND = Lisp.PACKAGE_CL
/* 1237 */     .addExternalSymbol("BOOLE-AND");
/* 1238 */   public static final Symbol BOOLE_ANDC1 = Lisp.PACKAGE_CL
/* 1239 */     .addExternalSymbol("BOOLE-ANDC1");
/* 1240 */   public static final Symbol BOOLE_ANDC2 = Lisp.PACKAGE_CL
/* 1241 */     .addExternalSymbol("BOOLE-ANDC2");
/* 1242 */   public static final Symbol BOOLE_C1 = Lisp.PACKAGE_CL
/* 1243 */     .addExternalSymbol("BOOLE-C1");
/* 1244 */   public static final Symbol BOOLE_C2 = Lisp.PACKAGE_CL
/* 1245 */     .addExternalSymbol("BOOLE-C2");
/* 1246 */   public static final Symbol BOOLE_CLR = Lisp.PACKAGE_CL
/* 1247 */     .addExternalSymbol("BOOLE-CLR");
/* 1248 */   public static final Symbol BOOLE_EQV = Lisp.PACKAGE_CL
/* 1249 */     .addExternalSymbol("BOOLE-EQV");
/* 1250 */   public static final Symbol BOOLE_IOR = Lisp.PACKAGE_CL
/* 1251 */     .addExternalSymbol("BOOLE-IOR");
/* 1252 */   public static final Symbol BOOLE_NAND = Lisp.PACKAGE_CL
/* 1253 */     .addExternalSymbol("BOOLE-NAND");
/* 1254 */   public static final Symbol BOOLE_NOR = Lisp.PACKAGE_CL
/* 1255 */     .addExternalSymbol("BOOLE-NOR");
/* 1256 */   public static final Symbol BOOLE_ORC1 = Lisp.PACKAGE_CL
/* 1257 */     .addExternalSymbol("BOOLE-ORC1");
/* 1258 */   public static final Symbol BOOLE_ORC2 = Lisp.PACKAGE_CL
/* 1259 */     .addExternalSymbol("BOOLE-ORC2");
/* 1260 */   public static final Symbol BOOLE_SET = Lisp.PACKAGE_CL
/* 1261 */     .addExternalSymbol("BOOLE-SET");
/* 1262 */   public static final Symbol BOOLE_XOR = Lisp.PACKAGE_CL
/* 1263 */     .addExternalSymbol("BOOLE-XOR");
/* 1264 */   public static final Symbol BOOLEAN = Lisp.PACKAGE_CL
/* 1265 */     .addExternalSymbol("BOOLEAN");
/* 1266 */   public static final Symbol BOTH_CASE_P = Lisp.PACKAGE_CL
/* 1267 */     .addExternalSymbol("BOTH-CASE-P");
/* 1268 */   public static final Symbol BOUNDP = Lisp.PACKAGE_CL
/* 1269 */     .addExternalSymbol("BOUNDP");
/* 1270 */   public static final Symbol BREAK = Lisp.PACKAGE_CL
/* 1271 */     .addExternalSymbol("BREAK");
/* 1272 */   public static final Symbol BROADCAST_STREAM = Lisp.PACKAGE_CL
/* 1273 */     .addExternalSymbol("BROADCAST-STREAM");
/* 1274 */   public static final Symbol BROADCAST_STREAM_STREAMS = Lisp.PACKAGE_CL
/* 1275 */     .addExternalSymbol("BROADCAST-STREAM-STREAMS");
/* 1276 */   public static final Symbol BUILT_IN_CLASS = Lisp.PACKAGE_CL
/* 1277 */     .addExternalSymbol("BUILT-IN-CLASS");
/* 1278 */   public static final Symbol BUTLAST = Lisp.PACKAGE_CL
/* 1279 */     .addExternalSymbol("BUTLAST");
/* 1280 */   public static final Symbol BYTE = Lisp.PACKAGE_CL
/* 1281 */     .addExternalSymbol("BYTE");
/* 1282 */   public static final Symbol BYTE_POSITION = Lisp.PACKAGE_CL
/* 1283 */     .addExternalSymbol("BYTE-POSITION");
/* 1284 */   public static final Symbol BYTE_SIZE = Lisp.PACKAGE_CL
/* 1285 */     .addExternalSymbol("BYTE-SIZE");
/* 1286 */   public static final Symbol CAAAAR = Lisp.PACKAGE_CL
/* 1287 */     .addExternalSymbol("CAAAAR");
/* 1288 */   public static final Symbol CAAADR = Lisp.PACKAGE_CL
/* 1289 */     .addExternalSymbol("CAAADR");
/* 1290 */   public static final Symbol CAAAR = Lisp.PACKAGE_CL
/* 1291 */     .addExternalSymbol("CAAAR");
/* 1292 */   public static final Symbol CAADAR = Lisp.PACKAGE_CL
/* 1293 */     .addExternalSymbol("CAADAR");
/* 1294 */   public static final Symbol CAADDR = Lisp.PACKAGE_CL
/* 1295 */     .addExternalSymbol("CAADDR");
/* 1296 */   public static final Symbol CAADR = Lisp.PACKAGE_CL
/* 1297 */     .addExternalSymbol("CAADR");
/* 1298 */   public static final Symbol CAAR = Lisp.PACKAGE_CL
/* 1299 */     .addExternalSymbol("CAAR");
/* 1300 */   public static final Symbol CADAAR = Lisp.PACKAGE_CL
/* 1301 */     .addExternalSymbol("CADAAR");
/* 1302 */   public static final Symbol CADADR = Lisp.PACKAGE_CL
/* 1303 */     .addExternalSymbol("CADADR");
/* 1304 */   public static final Symbol CADAR = Lisp.PACKAGE_CL
/* 1305 */     .addExternalSymbol("CADAR");
/* 1306 */   public static final Symbol CADDAR = Lisp.PACKAGE_CL
/* 1307 */     .addExternalSymbol("CADDAR");
/* 1308 */   public static final Symbol CADDDR = Lisp.PACKAGE_CL
/* 1309 */     .addExternalSymbol("CADDDR");
/* 1310 */   public static final Symbol CADDR = Lisp.PACKAGE_CL
/* 1311 */     .addExternalSymbol("CADDR");
/* 1312 */   public static final Symbol CADR = Lisp.PACKAGE_CL
/* 1313 */     .addExternalSymbol("CADR");
/* 1314 */   public static final Symbol CALL_ARGUMENTS_LIMIT = Lisp.PACKAGE_CL
/* 1315 */     .addExternalSymbol("CALL-ARGUMENTS-LIMIT");
/* 1316 */   public static final Symbol CALL_METHOD = Lisp.PACKAGE_CL
/* 1317 */     .addExternalSymbol("CALL-METHOD");
/* 1318 */   public static final Symbol CALL_NEXT_METHOD = Lisp.PACKAGE_CL
/* 1319 */     .addExternalSymbol("CALL-NEXT-METHOD");
/* 1320 */   public static final Symbol CAR = Lisp.PACKAGE_CL
/* 1321 */     .addExternalSymbol("CAR");
/* 1322 */   public static final Symbol CASE = Lisp.PACKAGE_CL
/* 1323 */     .addExternalSymbol("CASE");
/* 1324 */   public static final Symbol CATCH = Lisp.PACKAGE_CL
/* 1325 */     .addExternalSymbol("CATCH");
/* 1326 */   public static final Symbol CCASE = Lisp.PACKAGE_CL
/* 1327 */     .addExternalSymbol("CCASE");
/* 1328 */   public static final Symbol CDAAAR = Lisp.PACKAGE_CL
/* 1329 */     .addExternalSymbol("CDAAAR");
/* 1330 */   public static final Symbol CDAADR = Lisp.PACKAGE_CL
/* 1331 */     .addExternalSymbol("CDAADR");
/* 1332 */   public static final Symbol CDAAR = Lisp.PACKAGE_CL
/* 1333 */     .addExternalSymbol("CDAAR");
/* 1334 */   public static final Symbol CDADAR = Lisp.PACKAGE_CL
/* 1335 */     .addExternalSymbol("CDADAR");
/* 1336 */   public static final Symbol CDADDR = Lisp.PACKAGE_CL
/* 1337 */     .addExternalSymbol("CDADDR");
/* 1338 */   public static final Symbol CDADR = Lisp.PACKAGE_CL
/* 1339 */     .addExternalSymbol("CDADR");
/* 1340 */   public static final Symbol CDAR = Lisp.PACKAGE_CL
/* 1341 */     .addExternalSymbol("CDAR");
/* 1342 */   public static final Symbol CDDAAR = Lisp.PACKAGE_CL
/* 1343 */     .addExternalSymbol("CDDAAR");
/* 1344 */   public static final Symbol CDDADR = Lisp.PACKAGE_CL
/* 1345 */     .addExternalSymbol("CDDADR");
/* 1346 */   public static final Symbol CDDAR = Lisp.PACKAGE_CL
/* 1347 */     .addExternalSymbol("CDDAR");
/* 1348 */   public static final Symbol CDDDAR = Lisp.PACKAGE_CL
/* 1349 */     .addExternalSymbol("CDDDAR");
/* 1350 */   public static final Symbol CDDDDR = Lisp.PACKAGE_CL
/* 1351 */     .addExternalSymbol("CDDDDR");
/* 1352 */   public static final Symbol CDDDR = Lisp.PACKAGE_CL
/* 1353 */     .addExternalSymbol("CDDDR");
/* 1354 */   public static final Symbol CDDR = Lisp.PACKAGE_CL
/* 1355 */     .addExternalSymbol("CDDR");
/* 1356 */   public static final Symbol CDR = Lisp.PACKAGE_CL
/* 1357 */     .addExternalSymbol("CDR");
/* 1358 */   public static final Symbol CEILING = Lisp.PACKAGE_CL
/* 1359 */     .addExternalSymbol("CEILING");
/* 1360 */   public static final Symbol CELL_ERROR = Lisp.PACKAGE_CL
/* 1361 */     .addExternalSymbol("CELL-ERROR");
/* 1362 */   public static final Symbol CELL_ERROR_NAME = Lisp.PACKAGE_CL
/* 1363 */     .addExternalSymbol("CELL-ERROR-NAME");
/* 1364 */   public static final Symbol CERROR = Lisp.PACKAGE_CL
/* 1365 */     .addExternalSymbol("CERROR");
/* 1366 */   public static final Symbol CHANGE_CLASS = Lisp.PACKAGE_CL
/* 1367 */     .addExternalSymbol("CHANGE-CLASS");
/* 1368 */   public static final Symbol CHAR = Lisp.PACKAGE_CL
/* 1369 */     .addExternalSymbol("CHAR");
/* 1370 */   public static final Symbol CHAR_CODE = Lisp.PACKAGE_CL
/* 1371 */     .addExternalSymbol("CHAR-CODE");
/* 1372 */   public static final Symbol CHAR_CODE_LIMIT = Lisp.PACKAGE_CL
/* 1373 */     .addExternalSymbol("CHAR-CODE-LIMIT");
/* 1374 */   public static final Symbol CHAR_DOWNCASE = Lisp.PACKAGE_CL
/* 1375 */     .addExternalSymbol("CHAR-DOWNCASE");
/* 1376 */   public static final Symbol CHAR_EQUAL = Lisp.PACKAGE_CL
/* 1377 */     .addExternalSymbol("CHAR-EQUAL");
/* 1378 */   public static final Symbol CHAR_GREATERP = Lisp.PACKAGE_CL
/* 1379 */     .addExternalSymbol("CHAR-GREATERP");
/* 1380 */   public static final Symbol CHAR_INT = Lisp.PACKAGE_CL
/* 1381 */     .addExternalSymbol("CHAR-INT");
/* 1382 */   public static final Symbol CHAR_LESSP = Lisp.PACKAGE_CL
/* 1383 */     .addExternalSymbol("CHAR-LESSP");
/* 1384 */   public static final Symbol CHAR_NAME = Lisp.PACKAGE_CL
/* 1385 */     .addExternalSymbol("CHAR-NAME");
/* 1386 */   public static final Symbol CHAR_NOT_EQUAL = Lisp.PACKAGE_CL
/* 1387 */     .addExternalSymbol("CHAR-NOT-EQUAL");
/* 1388 */   public static final Symbol CHAR_NOT_GREATERP = Lisp.PACKAGE_CL
/* 1389 */     .addExternalSymbol("CHAR-NOT-GREATERP");
/* 1390 */   public static final Symbol CHAR_NOT_LESSP = Lisp.PACKAGE_CL
/* 1391 */     .addExternalSymbol("CHAR-NOT-LESSP");
/* 1392 */   public static final Symbol CHAR_UPCASE = Lisp.PACKAGE_CL
/* 1393 */     .addExternalSymbol("CHAR-UPCASE");
/* 1394 */   public static final Symbol CHAR_NE = Lisp.PACKAGE_CL
/* 1395 */     .addExternalSymbol("CHAR/=");
/* 1396 */   public static final Symbol CHAR_LT = Lisp.PACKAGE_CL
/* 1397 */     .addExternalSymbol("CHAR<");
/* 1398 */   public static final Symbol CHAR_LE = Lisp.PACKAGE_CL
/* 1399 */     .addExternalSymbol("CHAR<=");
/* 1400 */   public static final Symbol CHAR_EQUALS = Lisp.PACKAGE_CL
/* 1401 */     .addExternalSymbol("CHAR=");
/* 1402 */   public static final Symbol CHAR_GT = Lisp.PACKAGE_CL
/* 1403 */     .addExternalSymbol("CHAR>");
/* 1404 */   public static final Symbol CHAR_GE = Lisp.PACKAGE_CL
/* 1405 */     .addExternalSymbol("CHAR>=");
/* 1406 */   public static final Symbol CHARACTER = Lisp.PACKAGE_CL
/* 1407 */     .addExternalSymbol("CHARACTER");
/* 1408 */   public static final Symbol CHARACTERP = Lisp.PACKAGE_CL
/* 1409 */     .addExternalSymbol("CHARACTERP");
/* 1410 */   public static final Symbol CHECK_TYPE = Lisp.PACKAGE_CL
/* 1411 */     .addExternalSymbol("CHECK-TYPE");
/* 1412 */   public static final Symbol CIS = Lisp.PACKAGE_CL
/* 1413 */     .addExternalSymbol("CIS");
/* 1414 */   public static final Symbol CLASS = Lisp.PACKAGE_CL
/* 1415 */     .addExternalSymbol("CLASS");
/* 1416 */   public static final Symbol CLASS_NAME = Lisp.PACKAGE_CL
/* 1417 */     .addExternalSymbol("CLASS-NAME");
/* 1418 */   public static final Symbol CLASS_OF = Lisp.PACKAGE_CL
/* 1419 */     .addExternalSymbol("CLASS-OF");
/* 1420 */   public static final Symbol CLEAR_INPUT = Lisp.PACKAGE_CL
/* 1421 */     .addExternalSymbol("CLEAR-INPUT");
/* 1422 */   public static final Symbol CLEAR_OUTPUT = Lisp.PACKAGE_CL
/* 1423 */     .addExternalSymbol("CLEAR-OUTPUT");
/* 1424 */   public static final Symbol CLOSE = Lisp.PACKAGE_CL
/* 1425 */     .addExternalSymbol("CLOSE");
/* 1426 */   public static final Symbol CLRHASH = Lisp.PACKAGE_CL
/* 1427 */     .addExternalSymbol("CLRHASH");
/* 1428 */   public static final Symbol CODE_CHAR = Lisp.PACKAGE_CL
/* 1429 */     .addExternalSymbol("CODE-CHAR");
/* 1430 */   public static final Symbol COERCE = Lisp.PACKAGE_CL
/* 1431 */     .addExternalSymbol("COERCE");
/* 1432 */   public static final Symbol COMPILATION_SPEED = Lisp.PACKAGE_CL
/* 1433 */     .addExternalSymbol("COMPILATION-SPEED");
/* 1434 */   public static final Symbol COMPILE = Lisp.PACKAGE_CL
/* 1435 */     .addExternalSymbol("COMPILE");
/* 1436 */   public static final Symbol COMPILE_FILE = Lisp.PACKAGE_CL
/* 1437 */     .addExternalSymbol("COMPILE-FILE");
/* 1438 */   public static final Symbol COMPILE_FILE_PATHNAME = Lisp.PACKAGE_CL
/* 1439 */     .addExternalSymbol("COMPILE-FILE-PATHNAME");
/* 1440 */   public static final Symbol COMPILED_FUNCTION = Lisp.PACKAGE_CL
/* 1441 */     .addExternalSymbol("COMPILED-FUNCTION");
/* 1442 */   public static final Symbol COMPILED_FUNCTION_P = Lisp.PACKAGE_CL
/* 1443 */     .addExternalSymbol("COMPILED-FUNCTION-P");
/* 1444 */   public static final Symbol COMPILER_MACRO = Lisp.PACKAGE_CL
/* 1445 */     .addExternalSymbol("COMPILER-MACRO");
/* 1446 */   public static final Symbol COMPILER_MACRO_FUNCTION = Lisp.PACKAGE_CL
/* 1447 */     .addExternalSymbol("COMPILER-MACRO-FUNCTION");
/* 1448 */   public static final Symbol COMPLEMENT = Lisp.PACKAGE_CL
/* 1449 */     .addExternalSymbol("COMPLEMENT");
/* 1450 */   public static final Symbol COMPLEX = Lisp.PACKAGE_CL
/* 1451 */     .addExternalSymbol("COMPLEX");
/* 1452 */   public static final Symbol COMPLEXP = Lisp.PACKAGE_CL
/* 1453 */     .addExternalSymbol("COMPLEXP");
/* 1454 */   public static final Symbol COMPUTE_APPLICABLE_METHODS = Lisp.PACKAGE_CL
/* 1455 */     .addExternalSymbol("COMPUTE-APPLICABLE-METHODS");
/* 1456 */   public static final Symbol COMPUTE_RESTARTS = Lisp.PACKAGE_CL
/* 1457 */     .addExternalSymbol("COMPUTE-RESTARTS");
/* 1458 */   public static final Symbol CONCATENATE = Lisp.PACKAGE_CL
/* 1459 */     .addExternalSymbol("CONCATENATE");
/* 1460 */   public static final Symbol CONCATENATED_STREAM = Lisp.PACKAGE_CL
/* 1461 */     .addExternalSymbol("CONCATENATED-STREAM");
/* 1462 */   public static final Symbol CONCATENATED_STREAM_STREAMS = Lisp.PACKAGE_CL
/* 1463 */     .addExternalSymbol("CONCATENATED-STREAM-STREAMS");
/* 1464 */   public static final Symbol COND = Lisp.PACKAGE_CL
/* 1465 */     .addExternalSymbol("COND");
/* 1466 */   public static final Symbol CONDITION = Lisp.PACKAGE_CL
/* 1467 */     .addExternalSymbol("CONDITION");
/* 1468 */   public static final Symbol CONJUGATE = Lisp.PACKAGE_CL
/* 1469 */     .addExternalSymbol("CONJUGATE");
/* 1470 */   public static final Symbol CONS = Lisp.PACKAGE_CL
/* 1471 */     .addExternalSymbol("CONS");
/* 1472 */   public static final Symbol CONSP = Lisp.PACKAGE_CL
/* 1473 */     .addExternalSymbol("CONSP");
/* 1474 */   public static final Symbol CONSTANTLY = Lisp.PACKAGE_CL
/* 1475 */     .addExternalSymbol("CONSTANTLY");
/* 1476 */   public static final Symbol CONSTANTP = Lisp.PACKAGE_CL
/* 1477 */     .addExternalSymbol("CONSTANTP");
/* 1478 */   public static final Symbol CONTINUE = Lisp.PACKAGE_CL
/* 1479 */     .addExternalSymbol("CONTINUE");
/* 1480 */   public static final Symbol CONTROL_ERROR = Lisp.PACKAGE_CL
/* 1481 */     .addExternalSymbol("CONTROL-ERROR");
/* 1482 */   public static final Symbol COPY_ALIST = Lisp.PACKAGE_CL
/* 1483 */     .addExternalSymbol("COPY-ALIST");
/* 1484 */   public static final Symbol COPY_LIST = Lisp.PACKAGE_CL
/* 1485 */     .addExternalSymbol("COPY-LIST");
/* 1486 */   public static final Symbol COPY_PPRINT_DISPATCH = Lisp.PACKAGE_CL
/* 1487 */     .addExternalSymbol("COPY-PPRINT-DISPATCH");
/* 1488 */   public static final Symbol COPY_READTABLE = Lisp.PACKAGE_CL
/* 1489 */     .addExternalSymbol("COPY-READTABLE");
/* 1490 */   public static final Symbol COPY_SEQ = Lisp.PACKAGE_CL
/* 1491 */     .addExternalSymbol("COPY-SEQ");
/* 1492 */   public static final Symbol COPY_STRUCTURE = Lisp.PACKAGE_CL
/* 1493 */     .addExternalSymbol("COPY-STRUCTURE");
/* 1494 */   public static final Symbol COPY_SYMBOL = Lisp.PACKAGE_CL
/* 1495 */     .addExternalSymbol("COPY-SYMBOL");
/* 1496 */   public static final Symbol COPY_TREE = Lisp.PACKAGE_CL
/* 1497 */     .addExternalSymbol("COPY-TREE");
/* 1498 */   public static final Symbol COS = Lisp.PACKAGE_CL
/* 1499 */     .addExternalSymbol("COS");
/* 1500 */   public static final Symbol COSH = Lisp.PACKAGE_CL
/* 1501 */     .addExternalSymbol("COSH");
/* 1502 */   public static final Symbol COUNT = Lisp.PACKAGE_CL
/* 1503 */     .addExternalSymbol("COUNT");
/* 1504 */   public static final Symbol COUNT_IF = Lisp.PACKAGE_CL
/* 1505 */     .addExternalSymbol("COUNT-IF");
/* 1506 */   public static final Symbol COUNT_IF_NOT = Lisp.PACKAGE_CL
/* 1507 */     .addExternalSymbol("COUNT-IF-NOT");
/* 1508 */   public static final Symbol CTYPECASE = Lisp.PACKAGE_CL
/* 1509 */     .addExternalSymbol("CTYPECASE");
/* 1510 */   public static final Symbol DEBUG = Lisp.PACKAGE_CL
/* 1511 */     .addExternalSymbol("DEBUG");
/* 1512 */   public static final Symbol DECF = Lisp.PACKAGE_CL
/* 1513 */     .addExternalSymbol("DECF");
/* 1514 */   public static final Symbol DECLAIM = Lisp.PACKAGE_CL
/* 1515 */     .addExternalSymbol("DECLAIM");
/* 1516 */   public static final Symbol DECLARATION = Lisp.PACKAGE_CL
/* 1517 */     .addExternalSymbol("DECLARATION");
/* 1518 */   public static final Symbol DECLARE = Lisp.PACKAGE_CL
/* 1519 */     .addExternalSymbol("DECLARE");
/* 1520 */   public static final Symbol DECODE_FLOAT = Lisp.PACKAGE_CL
/* 1521 */     .addExternalSymbol("DECODE-FLOAT");
/* 1522 */   public static final Symbol DECODE_UNIVERSAL_TIME = Lisp.PACKAGE_CL
/* 1523 */     .addExternalSymbol("DECODE-UNIVERSAL-TIME");
/* 1524 */   public static final Symbol DEFCLASS = Lisp.PACKAGE_CL
/* 1525 */     .addExternalSymbol("DEFCLASS");
/* 1526 */   public static final Symbol DEFCONSTANT = Lisp.PACKAGE_CL
/* 1527 */     .addExternalSymbol("DEFCONSTANT");
/* 1528 */   public static final Symbol DEFGENERIC = Lisp.PACKAGE_CL
/* 1529 */     .addExternalSymbol("DEFGENERIC");
/* 1530 */   public static final Symbol DEFINE_COMPILER_MACRO = Lisp.PACKAGE_CL
/* 1531 */     .addExternalSymbol("DEFINE-COMPILER-MACRO");
/* 1532 */   public static final Symbol DEFINE_CONDITION = Lisp.PACKAGE_CL
/* 1533 */     .addExternalSymbol("DEFINE-CONDITION");
/* 1534 */   public static final Symbol DEFINE_METHOD_COMBINATION = Lisp.PACKAGE_CL
/* 1535 */     .addExternalSymbol("DEFINE-METHOD-COMBINATION");
/* 1536 */   public static final Symbol DEFINE_MODIFY_MACRO = Lisp.PACKAGE_CL
/* 1537 */     .addExternalSymbol("DEFINE-MODIFY-MACRO");
/* 1538 */   public static final Symbol DEFINE_SETF_EXPANDER = Lisp.PACKAGE_CL
/* 1539 */     .addExternalSymbol("DEFINE-SETF-EXPANDER");
/* 1540 */   public static final Symbol DEFINE_SYMBOL_MACRO = Lisp.PACKAGE_CL
/* 1541 */     .addExternalSymbol("DEFINE-SYMBOL-MACRO");
/* 1542 */   public static final Symbol DEFMACRO = Lisp.PACKAGE_CL
/* 1543 */     .addExternalSymbol("DEFMACRO");
/* 1544 */   public static final Symbol DEFMETHOD = Lisp.PACKAGE_CL
/* 1545 */     .addExternalSymbol("DEFMETHOD");
/* 1546 */   public static final Symbol DEFPACKAGE = Lisp.PACKAGE_CL
/* 1547 */     .addExternalSymbol("DEFPACKAGE");
/* 1548 */   public static final Symbol DEFPARAMETER = Lisp.PACKAGE_CL
/* 1549 */     .addExternalSymbol("DEFPARAMETER");
/* 1550 */   public static final Symbol DEFSETF = Lisp.PACKAGE_CL
/* 1551 */     .addExternalSymbol("DEFSETF");
/* 1552 */   public static final Symbol DEFSTRUCT = Lisp.PACKAGE_CL
/* 1553 */     .addExternalSymbol("DEFSTRUCT");
/* 1554 */   public static final Symbol DEFTYPE = Lisp.PACKAGE_CL
/* 1555 */     .addExternalSymbol("DEFTYPE");
/* 1556 */   public static final Symbol DEFUN = Lisp.PACKAGE_CL
/* 1557 */     .addExternalSymbol("DEFUN");
/* 1558 */   public static final Symbol DEFVAR = Lisp.PACKAGE_CL
/* 1559 */     .addExternalSymbol("DEFVAR");
/* 1560 */   public static final Symbol DELETE = Lisp.PACKAGE_CL
/* 1561 */     .addExternalSymbol("DELETE");
/* 1562 */   public static final Symbol DELETE_DUPLICATES = Lisp.PACKAGE_CL
/* 1563 */     .addExternalSymbol("DELETE-DUPLICATES");
/* 1564 */   public static final Symbol DELETE_FILE = Lisp.PACKAGE_CL
/* 1565 */     .addExternalSymbol("DELETE-FILE");
/* 1566 */   public static final Symbol DELETE_IF = Lisp.PACKAGE_CL
/* 1567 */     .addExternalSymbol("DELETE-IF");
/* 1568 */   public static final Symbol DELETE_IF_NOT = Lisp.PACKAGE_CL
/* 1569 */     .addExternalSymbol("DELETE-IF-NOT");
/* 1570 */   public static final Symbol DELETE_PACKAGE = Lisp.PACKAGE_CL
/* 1571 */     .addExternalSymbol("DELETE-PACKAGE");
/* 1572 */   public static final Symbol DENOMINATOR = Lisp.PACKAGE_CL
/* 1573 */     .addExternalSymbol("DENOMINATOR");
/* 1574 */   public static final Symbol DEPOSIT_FIELD = Lisp.PACKAGE_CL
/* 1575 */     .addExternalSymbol("DEPOSIT-FIELD");
/* 1576 */   public static final Symbol DESCRIBE = Lisp.PACKAGE_CL
/* 1577 */     .addExternalSymbol("DESCRIBE");
/* 1578 */   public static final Symbol DESCRIBE_OBJECT = Lisp.PACKAGE_CL
/* 1579 */     .addExternalSymbol("DESCRIBE-OBJECT");
/* 1580 */   public static final Symbol DESTRUCTURING_BIND = Lisp.PACKAGE_CL
/* 1581 */     .addExternalSymbol("DESTRUCTURING-BIND");
/* 1582 */   public static final Symbol DIGIT_CHAR = Lisp.PACKAGE_CL
/* 1583 */     .addExternalSymbol("DIGIT-CHAR");
/* 1584 */   public static final Symbol DIGIT_CHAR_P = Lisp.PACKAGE_CL
/* 1585 */     .addExternalSymbol("DIGIT-CHAR-P");
/* 1586 */   public static final Symbol DIRECTORY = Lisp.PACKAGE_CL
/* 1587 */     .addExternalSymbol("DIRECTORY");
/* 1588 */   public static final Symbol DIRECTORY_NAMESTRING = Lisp.PACKAGE_CL
/* 1589 */     .addExternalSymbol("DIRECTORY-NAMESTRING");
/* 1590 */   public static final Symbol DISASSEMBLE = Lisp.PACKAGE_CL
/* 1591 */     .addExternalSymbol("DISASSEMBLE");
/* 1592 */   public static final Symbol DIVISION_BY_ZERO = Lisp.PACKAGE_CL
/* 1593 */     .addExternalSymbol("DIVISION-BY-ZERO");
/* 1594 */   public static final Symbol DO = Lisp.PACKAGE_CL
/* 1595 */     .addExternalSymbol("DO");
/* 1596 */   public static final Symbol DO_STAR = Lisp.PACKAGE_CL
/* 1597 */     .addExternalSymbol("DO*");
/* 1598 */   public static final Symbol DO_ALL_SYMBOLS = Lisp.PACKAGE_CL
/* 1599 */     .addExternalSymbol("DO-ALL-SYMBOLS");
/* 1600 */   public static final Symbol DO_EXTERNAL_SYMBOLS = Lisp.PACKAGE_CL
/* 1601 */     .addExternalSymbol("DO-EXTERNAL-SYMBOLS");
/* 1602 */   public static final Symbol DO_SYMBOLS = Lisp.PACKAGE_CL
/* 1603 */     .addExternalSymbol("DO-SYMBOLS");
/* 1604 */   public static final Symbol DOCUMENTATION = Lisp.PACKAGE_CL
/* 1605 */     .addExternalSymbol("DOCUMENTATION");
/* 1606 */   public static final Symbol DOLIST = Lisp.PACKAGE_CL
/* 1607 */     .addExternalSymbol("DOLIST");
/* 1608 */   public static final Symbol DOTIMES = Lisp.PACKAGE_CL
/* 1609 */     .addExternalSymbol("DOTIMES");
/* 1610 */   public static final Symbol DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 1611 */     .addExternalSymbol("DOUBLE-FLOAT");
/* 1612 */   public static final Symbol DOUBLE_FLOAT_EPSILON = Lisp.PACKAGE_CL
/* 1613 */     .addExternalSymbol("DOUBLE-FLOAT-EPSILON");
/* 1614 */   public static final Symbol DOUBLE_FLOAT_NEGATIVE_EPSILON = Lisp.PACKAGE_CL
/* 1615 */     .addExternalSymbol("DOUBLE-FLOAT-NEGATIVE-EPSILON");
/* 1616 */   public static final Symbol DPB = Lisp.PACKAGE_CL
/* 1617 */     .addExternalSymbol("DPB");
/* 1618 */   public static final Symbol DRIBBLE = Lisp.PACKAGE_CL
/* 1619 */     .addExternalSymbol("DRIBBLE");
/* 1620 */   public static final Symbol DYNAMIC_EXTENT = Lisp.PACKAGE_CL
/* 1621 */     .addExternalSymbol("DYNAMIC-EXTENT");
/* 1622 */   public static final Symbol ECASE = Lisp.PACKAGE_CL
/* 1623 */     .addExternalSymbol("ECASE");
/* 1624 */   public static final Symbol ECHO_STREAM = Lisp.PACKAGE_CL
/* 1625 */     .addExternalSymbol("ECHO-STREAM");
/* 1626 */   public static final Symbol ECHO_STREAM_INPUT_STREAM = Lisp.PACKAGE_CL
/* 1627 */     .addExternalSymbol("ECHO-STREAM-INPUT-STREAM");
/* 1628 */   public static final Symbol ECHO_STREAM_OUTPUT_STREAM = Lisp.PACKAGE_CL
/* 1629 */     .addExternalSymbol("ECHO-STREAM-OUTPUT-STREAM");
/* 1630 */   public static final Symbol ED = Lisp.PACKAGE_CL
/* 1631 */     .addExternalSymbol("ED");
/* 1632 */   public static final Symbol EIGHTH = Lisp.PACKAGE_CL
/* 1633 */     .addExternalSymbol("EIGHTH");
/* 1634 */   public static final Symbol ELT = Lisp.PACKAGE_CL
/* 1635 */     .addExternalSymbol("ELT");
/* 1636 */   public static final Symbol ENCODE_UNIVERSAL_TIME = Lisp.PACKAGE_CL
/* 1637 */     .addExternalSymbol("ENCODE-UNIVERSAL-TIME");
/* 1638 */   public static final Symbol END_OF_FILE = Lisp.PACKAGE_CL
/* 1639 */     .addExternalSymbol("END-OF-FILE");
/* 1640 */   public static final Symbol ENDP = Lisp.PACKAGE_CL
/* 1641 */     .addExternalSymbol("ENDP");
/* 1642 */   public static final Symbol ENOUGH_NAMESTRING = Lisp.PACKAGE_CL
/* 1643 */     .addExternalSymbol("ENOUGH-NAMESTRING");
/* 1644 */   public static final Symbol ENSURE_DIRECTORIES_EXIST = Lisp.PACKAGE_CL
/* 1645 */     .addExternalSymbol("ENSURE-DIRECTORIES-EXIST");
/* 1646 */   public static final Symbol ENSURE_GENERIC_FUNCTION = Lisp.PACKAGE_CL
/* 1647 */     .addExternalSymbol("ENSURE-GENERIC-FUNCTION");
/* 1648 */   public static final Symbol EQ = Lisp.PACKAGE_CL
/* 1649 */     .addExternalSymbol("EQ");
/* 1650 */   public static final Symbol EQL = Lisp.PACKAGE_CL
/* 1651 */     .addExternalSymbol("EQL");
/* 1652 */   public static final Symbol EQUAL = Lisp.PACKAGE_CL
/* 1653 */     .addExternalSymbol("EQUAL");
/* 1654 */   public static final Symbol EQUALP = Lisp.PACKAGE_CL
/* 1655 */     .addExternalSymbol("EQUALP");
/* 1656 */   public static final Symbol ERROR = Lisp.PACKAGE_CL
/* 1657 */     .addExternalSymbol("ERROR");
/* 1658 */   public static final Symbol ETYPECASE = Lisp.PACKAGE_CL
/* 1659 */     .addExternalSymbol("ETYPECASE");
/* 1660 */   public static final Symbol EVAL = Lisp.PACKAGE_CL
/* 1661 */     .addExternalSymbol("EVAL");
/* 1662 */   public static final Symbol EVAL_WHEN = Lisp.PACKAGE_CL
/* 1663 */     .addExternalSymbol("EVAL-WHEN");
/* 1664 */   public static final Symbol EVENP = Lisp.PACKAGE_CL
/* 1665 */     .addExternalSymbol("EVENP");
/* 1666 */   public static final Symbol EVERY = Lisp.PACKAGE_CL
/* 1667 */     .addExternalSymbol("EVERY");
/* 1668 */   public static final Symbol EXP = Lisp.PACKAGE_CL
/* 1669 */     .addExternalSymbol("EXP");
/* 1670 */   public static final Symbol EXPORT = Lisp.PACKAGE_CL
/* 1671 */     .addExternalSymbol("EXPORT");
/* 1672 */   public static final Symbol EXPT = Lisp.PACKAGE_CL
/* 1673 */     .addExternalSymbol("EXPT");
/* 1674 */   public static final Symbol EXTENDED_CHAR = Lisp.PACKAGE_CL
/* 1675 */     .addExternalSymbol("EXTENDED-CHAR");
/* 1676 */   public static final Symbol FBOUNDP = Lisp.PACKAGE_CL
/* 1677 */     .addExternalSymbol("FBOUNDP");
/* 1678 */   public static final Symbol FCEILING = Lisp.PACKAGE_CL
/* 1679 */     .addExternalSymbol("FCEILING");
/* 1680 */   public static final Symbol FDEFINITION = Lisp.PACKAGE_CL
/* 1681 */     .addExternalSymbol("FDEFINITION");
/* 1682 */   public static final Symbol FFLOOR = Lisp.PACKAGE_CL
/* 1683 */     .addExternalSymbol("FFLOOR");
/* 1684 */   public static final Symbol FIFTH = Lisp.PACKAGE_CL
/* 1685 */     .addExternalSymbol("FIFTH");
/* 1686 */   public static final Symbol FILE_AUTHOR = Lisp.PACKAGE_CL
/* 1687 */     .addExternalSymbol("FILE-AUTHOR");
/* 1688 */   public static final Symbol FILE_ERROR = Lisp.PACKAGE_CL
/* 1689 */     .addExternalSymbol("FILE-ERROR");
/* 1690 */   public static final Symbol FILE_ERROR_PATHNAME = Lisp.PACKAGE_CL
/* 1691 */     .addExternalSymbol("FILE-ERROR-PATHNAME");
/* 1692 */   public static final Symbol FILE_LENGTH = Lisp.PACKAGE_CL
/* 1693 */     .addExternalSymbol("FILE-LENGTH");
/* 1694 */   public static final Symbol FILE_NAMESTRING = Lisp.PACKAGE_CL
/* 1695 */     .addExternalSymbol("FILE-NAMESTRING");
/* 1696 */   public static final Symbol FILE_POSITION = Lisp.PACKAGE_CL
/* 1697 */     .addExternalSymbol("FILE-POSITION");
/* 1698 */   public static final Symbol FILE_STREAM = Lisp.PACKAGE_CL
/* 1699 */     .addExternalSymbol("FILE-STREAM");
/* 1700 */   public static final Symbol FILE_STRING_LENGTH = Lisp.PACKAGE_CL
/* 1701 */     .addExternalSymbol("FILE-STRING-LENGTH");
/* 1702 */   public static final Symbol FILE_WRITE_DATE = Lisp.PACKAGE_CL
/* 1703 */     .addExternalSymbol("FILE-WRITE-DATE");
/* 1704 */   public static final Symbol FILL = Lisp.PACKAGE_CL
/* 1705 */     .addExternalSymbol("FILL");
/* 1706 */   public static final Symbol FILL_POINTER = Lisp.PACKAGE_CL
/* 1707 */     .addExternalSymbol("FILL-POINTER");
/* 1708 */   public static final Symbol FIND = Lisp.PACKAGE_CL
/* 1709 */     .addExternalSymbol("FIND");
/* 1710 */   public static final Symbol FIND_ALL_SYMBOLS = Lisp.PACKAGE_CL
/* 1711 */     .addExternalSymbol("FIND-ALL-SYMBOLS");
/* 1712 */   public static final Symbol FIND_CLASS = Lisp.PACKAGE_CL
/* 1713 */     .addExternalSymbol("FIND-CLASS");
/* 1714 */   public static final Symbol FIND_IF = Lisp.PACKAGE_CL
/* 1715 */     .addExternalSymbol("FIND-IF");
/* 1716 */   public static final Symbol FIND_IF_NOT = Lisp.PACKAGE_CL
/* 1717 */     .addExternalSymbol("FIND-IF-NOT");
/* 1718 */   public static final Symbol FIND_METHOD = Lisp.PACKAGE_CL
/* 1719 */     .addExternalSymbol("FIND-METHOD");
/* 1720 */   public static final Symbol FIND_PACKAGE = Lisp.PACKAGE_CL
/* 1721 */     .addExternalSymbol("FIND-PACKAGE");
/* 1722 */   public static final Symbol FIND_RESTART = Lisp.PACKAGE_CL
/* 1723 */     .addExternalSymbol("FIND-RESTART");
/* 1724 */   public static final Symbol FIND_SYMBOL = Lisp.PACKAGE_CL
/* 1725 */     .addExternalSymbol("FIND-SYMBOL");
/* 1726 */   public static final Symbol FINISH_OUTPUT = Lisp.PACKAGE_CL
/* 1727 */     .addExternalSymbol("FINISH-OUTPUT");
/* 1728 */   public static final Symbol FIRST = Lisp.PACKAGE_CL
/* 1729 */     .addExternalSymbol("FIRST");
/* 1730 */   public static final Symbol FIXNUM = Lisp.PACKAGE_CL
/* 1731 */     .addExternalSymbol("FIXNUM");
/* 1732 */   public static final Symbol FLET = Lisp.PACKAGE_CL
/* 1733 */     .addExternalSymbol("FLET");
/* 1734 */   public static final Symbol FLOAT = Lisp.PACKAGE_CL
/* 1735 */     .addExternalSymbol("FLOAT");
/* 1736 */   public static final Symbol FLOAT_DIGITS = Lisp.PACKAGE_CL
/* 1737 */     .addExternalSymbol("FLOAT-DIGITS");
/* 1738 */   public static final Symbol FLOAT_PRECISION = Lisp.PACKAGE_CL
/* 1739 */     .addExternalSymbol("FLOAT-PRECISION");
/* 1740 */   public static final Symbol FLOAT_RADIX = Lisp.PACKAGE_CL
/* 1741 */     .addExternalSymbol("FLOAT-RADIX");
/* 1742 */   public static final Symbol FLOAT_SIGN = Lisp.PACKAGE_CL
/* 1743 */     .addExternalSymbol("FLOAT-SIGN");
/* 1744 */   public static final Symbol FLOATING_POINT_INEXACT = Lisp.PACKAGE_CL
/* 1745 */     .addExternalSymbol("FLOATING-POINT-INEXACT");
/* 1746 */   public static final Symbol FLOATING_POINT_INVALID_OPERATION = Lisp.PACKAGE_CL
/* 1747 */     .addExternalSymbol("FLOATING-POINT-INVALID-OPERATION");
/* 1748 */   public static final Symbol FLOATING_POINT_OVERFLOW = Lisp.PACKAGE_CL
/* 1749 */     .addExternalSymbol("FLOATING-POINT-OVERFLOW");
/* 1750 */   public static final Symbol FLOATING_POINT_UNDERFLOW = Lisp.PACKAGE_CL
/* 1751 */     .addExternalSymbol("FLOATING-POINT-UNDERFLOW");
/* 1752 */   public static final Symbol FLOATP = Lisp.PACKAGE_CL
/* 1753 */     .addExternalSymbol("FLOATP");
/* 1754 */   public static final Symbol FLOOR = Lisp.PACKAGE_CL
/* 1755 */     .addExternalSymbol("FLOOR");
/* 1756 */   public static final Symbol FMAKUNBOUND = Lisp.PACKAGE_CL
/* 1757 */     .addExternalSymbol("FMAKUNBOUND");
/* 1758 */   public static final Symbol FORCE_OUTPUT = Lisp.PACKAGE_CL
/* 1759 */     .addExternalSymbol("FORCE-OUTPUT");
/* 1760 */   public static final Symbol FORMAT = Lisp.PACKAGE_CL
/* 1761 */     .addExternalSymbol("FORMAT");
/* 1762 */   public static final Symbol FORMATTER = Lisp.PACKAGE_CL
/* 1763 */     .addExternalSymbol("FORMATTER");
/* 1764 */   public static final Symbol FOURTH = Lisp.PACKAGE_CL
/* 1765 */     .addExternalSymbol("FOURTH");
/* 1766 */   public static final Symbol FRESH_LINE = Lisp.PACKAGE_CL
/* 1767 */     .addExternalSymbol("FRESH-LINE");
/* 1768 */   public static final Symbol FROUND = Lisp.PACKAGE_CL
/* 1769 */     .addExternalSymbol("FROUND");
/* 1770 */   public static final Symbol FTRUNCATE = Lisp.PACKAGE_CL
/* 1771 */     .addExternalSymbol("FTRUNCATE");
/* 1772 */   public static final Symbol FTYPE = Lisp.PACKAGE_CL
/* 1773 */     .addExternalSymbol("FTYPE");
/* 1774 */   public static final Symbol FUNCALL = Lisp.PACKAGE_CL
/* 1775 */     .addExternalSymbol("FUNCALL");
/* 1776 */   public static final Symbol FUNCTION = Lisp.PACKAGE_CL
/* 1777 */     .addExternalSymbol("FUNCTION");
/* 1778 */   public static final Symbol FUNCTION_KEYWORDS = Lisp.PACKAGE_CL
/* 1779 */     .addExternalSymbol("FUNCTION-KEYWORDS");
/* 1780 */   public static final Symbol FUNCTION_LAMBDA_EXPRESSION = Lisp.PACKAGE_CL
/* 1781 */     .addExternalSymbol("FUNCTION-LAMBDA-EXPRESSION");
/* 1782 */   public static final Symbol FUNCTIONP = Lisp.PACKAGE_CL
/* 1783 */     .addExternalSymbol("FUNCTIONP");
/* 1784 */   public static final Symbol GCD = Lisp.PACKAGE_CL
/* 1785 */     .addExternalSymbol("GCD");
/* 1786 */   public static final Symbol GENERIC_FUNCTION = Lisp.PACKAGE_CL
/* 1787 */     .addExternalSymbol("GENERIC-FUNCTION");
/* 1788 */   public static final Symbol GENSYM = Lisp.PACKAGE_CL
/* 1789 */     .addExternalSymbol("GENSYM");
/* 1790 */   public static final Symbol GENTEMP = Lisp.PACKAGE_CL
/* 1791 */     .addExternalSymbol("GENTEMP");
/* 1792 */   public static final Symbol GET = Lisp.PACKAGE_CL
/* 1793 */     .addExternalSymbol("GET");
/* 1794 */   public static final Symbol GET_DECODED_TIME = Lisp.PACKAGE_CL
/* 1795 */     .addExternalSymbol("GET-DECODED-TIME");
/* 1796 */   public static final Symbol GET_DISPATCH_MACRO_CHARACTER = Lisp.PACKAGE_CL
/* 1797 */     .addExternalSymbol("GET-DISPATCH-MACRO-CHARACTER");
/* 1798 */   public static final Symbol GET_INTERNAL_REAL_TIME = Lisp.PACKAGE_CL
/* 1799 */     .addExternalSymbol("GET-INTERNAL-REAL-TIME");
/* 1800 */   public static final Symbol GET_INTERNAL_RUN_TIME = Lisp.PACKAGE_CL
/* 1801 */     .addExternalSymbol("GET-INTERNAL-RUN-TIME");
/* 1802 */   public static final Symbol GET_MACRO_CHARACTER = Lisp.PACKAGE_CL
/* 1803 */     .addExternalSymbol("GET-MACRO-CHARACTER");
/* 1804 */   public static final Symbol GET_OUTPUT_STREAM_STRING = Lisp.PACKAGE_CL
/* 1805 */     .addExternalSymbol("GET-OUTPUT-STREAM-STRING");
/* 1806 */   public static final Symbol GET_PROPERTIES = Lisp.PACKAGE_CL
/* 1807 */     .addExternalSymbol("GET-PROPERTIES");
/* 1808 */   public static final Symbol GET_SETF_EXPANSION = Lisp.PACKAGE_CL
/* 1809 */     .addExternalSymbol("GET-SETF-EXPANSION");
/* 1810 */   public static final Symbol GET_UNIVERSAL_TIME = Lisp.PACKAGE_CL
/* 1811 */     .addExternalSymbol("GET-UNIVERSAL-TIME");
/* 1812 */   public static final Symbol GETF = Lisp.PACKAGE_CL
/* 1813 */     .addExternalSymbol("GETF");
/* 1814 */   public static final Symbol GETHASH = Lisp.PACKAGE_CL
/* 1815 */     .addExternalSymbol("GETHASH");
/* 1816 */   public static final Symbol GO = Lisp.PACKAGE_CL
/* 1817 */     .addExternalSymbol("GO");
/* 1818 */   public static final Symbol GRAPHIC_CHAR_P = Lisp.PACKAGE_CL
/* 1819 */     .addExternalSymbol("GRAPHIC-CHAR-P");
/* 1820 */   public static final Symbol HANDLER_BIND = Lisp.PACKAGE_CL
/* 1821 */     .addExternalSymbol("HANDLER-BIND");
/* 1822 */   public static final Symbol HANDLER_CASE = Lisp.PACKAGE_CL
/* 1823 */     .addExternalSymbol("HANDLER-CASE");
/* 1824 */   public static final Symbol HASH_TABLE = Lisp.PACKAGE_CL
/* 1825 */     .addExternalSymbol("HASH-TABLE");
/* 1826 */   public static final Symbol HASH_TABLE_COUNT = Lisp.PACKAGE_CL
/* 1827 */     .addExternalSymbol("HASH-TABLE-COUNT");
/* 1828 */   public static final Symbol HASH_TABLE_P = Lisp.PACKAGE_CL
/* 1829 */     .addExternalSymbol("HASH-TABLE-P");
/* 1830 */   public static final Symbol HASH_TABLE_REHASH_SIZE = Lisp.PACKAGE_CL
/* 1831 */     .addExternalSymbol("HASH-TABLE-REHASH-SIZE");
/* 1832 */   public static final Symbol HASH_TABLE_REHASH_THRESHOLD = Lisp.PACKAGE_CL
/* 1833 */     .addExternalSymbol("HASH-TABLE-REHASH-THRESHOLD");
/* 1834 */   public static final Symbol HASH_TABLE_SIZE = Lisp.PACKAGE_CL
/* 1835 */     .addExternalSymbol("HASH-TABLE-SIZE");
/* 1836 */   public static final Symbol HASH_TABLE_TEST = Lisp.PACKAGE_CL
/* 1837 */     .addExternalSymbol("HASH-TABLE-TEST");
/* 1838 */   public static final Symbol HOST_NAMESTRING = Lisp.PACKAGE_CL
/* 1839 */     .addExternalSymbol("HOST-NAMESTRING");
/* 1840 */   public static final Symbol IDENTITY = Lisp.PACKAGE_CL
/* 1841 */     .addExternalSymbol("IDENTITY");
/* 1842 */   public static final Symbol IF = Lisp.PACKAGE_CL
/* 1843 */     .addExternalSymbol("IF");
/* 1844 */   public static final Symbol IGNORABLE = Lisp.PACKAGE_CL
/* 1845 */     .addExternalSymbol("IGNORABLE");
/* 1846 */   public static final Symbol IGNORE = Lisp.PACKAGE_CL
/* 1847 */     .addExternalSymbol("IGNORE");
/* 1848 */   public static final Symbol IGNORE_ERRORS = Lisp.PACKAGE_CL
/* 1849 */     .addExternalSymbol("IGNORE-ERRORS");
/* 1850 */   public static final Symbol IMAGPART = Lisp.PACKAGE_CL
/* 1851 */     .addExternalSymbol("IMAGPART");
/* 1852 */   public static final Symbol IMPORT = Lisp.PACKAGE_CL
/* 1853 */     .addExternalSymbol("IMPORT");
/* 1854 */   public static final Symbol IN_PACKAGE = Lisp.PACKAGE_CL
/* 1855 */     .addExternalSymbol("IN-PACKAGE");
/* 1856 */   public static final Symbol INCF = Lisp.PACKAGE_CL
/* 1857 */     .addExternalSymbol("INCF");
/* 1858 */   public static final Symbol INITIALIZE_INSTANCE = Lisp.PACKAGE_CL
/* 1859 */     .addExternalSymbol("INITIALIZE-INSTANCE");
/* 1860 */   public static final Symbol INLINE = Lisp.PACKAGE_CL
/* 1861 */     .addExternalSymbol("INLINE");
/* 1862 */   public static final Symbol INPUT_STREAM_P = Lisp.PACKAGE_CL
/* 1863 */     .addExternalSymbol("INPUT-STREAM-P");
/* 1864 */   public static final Symbol INSPECT = Lisp.PACKAGE_CL
/* 1865 */     .addExternalSymbol("INSPECT");
/* 1866 */   public static final Symbol INTEGER = Lisp.PACKAGE_CL
/* 1867 */     .addExternalSymbol("INTEGER");
/* 1868 */   public static final Symbol INTEGER_DECODE_FLOAT = Lisp.PACKAGE_CL
/* 1869 */     .addExternalSymbol("INTEGER-DECODE-FLOAT");
/* 1870 */   public static final Symbol INTEGER_LENGTH = Lisp.PACKAGE_CL
/* 1871 */     .addExternalSymbol("INTEGER-LENGTH");
/* 1872 */   public static final Symbol INTEGERP = Lisp.PACKAGE_CL
/* 1873 */     .addExternalSymbol("INTEGERP");
/* 1874 */   public static final Symbol INTERACTIVE_STREAM_P = Lisp.PACKAGE_CL
/* 1875 */     .addExternalSymbol("INTERACTIVE-STREAM-P");
/* 1876 */   public static final Symbol INTERN = Lisp.PACKAGE_CL
/* 1877 */     .addExternalSymbol("INTERN");
/* 1878 */   public static final Symbol INTERNAL_TIME_UNITS_PER_SECOND = Lisp.PACKAGE_CL
/* 1879 */     .addExternalSymbol("INTERNAL-TIME-UNITS-PER-SECOND");
/* 1880 */   public static final Symbol INTERSECTION = Lisp.PACKAGE_CL
/* 1881 */     .addExternalSymbol("INTERSECTION");
/* 1882 */   public static final Symbol INVALID_METHOD_ERROR = Lisp.PACKAGE_CL
/* 1883 */     .addExternalSymbol("INVALID-METHOD-ERROR");
/* 1884 */   public static final Symbol INVOKE_DEBUGGER = Lisp.PACKAGE_CL
/* 1885 */     .addExternalSymbol("INVOKE-DEBUGGER");
/* 1886 */   public static final Symbol INVOKE_RESTART = Lisp.PACKAGE_CL
/* 1887 */     .addExternalSymbol("INVOKE-RESTART");
/* 1888 */   public static final Symbol INVOKE_RESTART_INTERACTIVELY = Lisp.PACKAGE_CL
/* 1889 */     .addExternalSymbol("INVOKE-RESTART-INTERACTIVELY");
/* 1890 */   public static final Symbol ISQRT = Lisp.PACKAGE_CL
/* 1891 */     .addExternalSymbol("ISQRT");
/* 1892 */   public static final Symbol KEYWORD = Lisp.PACKAGE_CL
/* 1893 */     .addExternalSymbol("KEYWORD");
/* 1894 */   public static final Symbol KEYWORDP = Lisp.PACKAGE_CL
/* 1895 */     .addExternalSymbol("KEYWORDP");
/* 1896 */   public static final Symbol LABELS = Lisp.PACKAGE_CL
/* 1897 */     .addExternalSymbol("LABELS");
/* 1898 */   public static final Symbol LAMBDA = Lisp.PACKAGE_CL
/* 1899 */     .addExternalSymbol("LAMBDA");
/* 1900 */   public static final Symbol LAMBDA_LIST_KEYWORDS = Lisp.PACKAGE_CL
/* 1901 */     .addExternalSymbol("LAMBDA-LIST-KEYWORDS");
/* 1902 */   public static final Symbol LAMBDA_PARAMETERS_LIMIT = Lisp.PACKAGE_CL
/* 1903 */     .addExternalSymbol("LAMBDA-PARAMETERS-LIMIT");
/* 1904 */   public static final Symbol LAST = Lisp.PACKAGE_CL
/* 1905 */     .addExternalSymbol("LAST");
/* 1906 */   public static final Symbol LCM = Lisp.PACKAGE_CL
/* 1907 */     .addExternalSymbol("LCM");
/* 1908 */   public static final Symbol LDB = Lisp.PACKAGE_CL
/* 1909 */     .addExternalSymbol("LDB");
/* 1910 */   public static final Symbol LDB_TEST = Lisp.PACKAGE_CL
/* 1911 */     .addExternalSymbol("LDB-TEST");
/* 1912 */   public static final Symbol LDIFF = Lisp.PACKAGE_CL
/* 1913 */     .addExternalSymbol("LDIFF");
/* 1914 */   public static final Symbol LEAST_NEGATIVE_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 1915 */     .addExternalSymbol("LEAST-NEGATIVE-DOUBLE-FLOAT");
/* 1916 */   public static final Symbol LEAST_NEGATIVE_LONG_FLOAT = Lisp.PACKAGE_CL
/* 1917 */     .addExternalSymbol("LEAST-NEGATIVE-LONG-FLOAT");
/* 1918 */   public static final Symbol LEAST_NEGATIVE_NORMALIZED_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 1919 */     .addExternalSymbol("LEAST-NEGATIVE-NORMALIZED-DOUBLE-FLOAT");
/* 1920 */   public static final Symbol LEAST_NEGATIVE_NORMALIZED_LONG_FLOAT = Lisp.PACKAGE_CL
/* 1921 */     .addExternalSymbol("LEAST-NEGATIVE-NORMALIZED-LONG-FLOAT");
/* 1922 */   public static final Symbol LEAST_NEGATIVE_NORMALIZED_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 1923 */     .addExternalSymbol("LEAST-NEGATIVE-NORMALIZED-SHORT-FLOAT");
/* 1924 */   public static final Symbol LEAST_NEGATIVE_NORMALIZED_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 1925 */     .addExternalSymbol("LEAST-NEGATIVE-NORMALIZED-SINGLE-FLOAT");
/* 1926 */   public static final Symbol LEAST_NEGATIVE_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 1927 */     .addExternalSymbol("LEAST-NEGATIVE-SHORT-FLOAT");
/* 1928 */   public static final Symbol LEAST_NEGATIVE_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 1929 */     .addExternalSymbol("LEAST-NEGATIVE-SINGLE-FLOAT");
/* 1930 */   public static final Symbol LEAST_POSITIVE_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 1931 */     .addExternalSymbol("LEAST-POSITIVE-DOUBLE-FLOAT");
/* 1932 */   public static final Symbol LEAST_POSITIVE_LONG_FLOAT = Lisp.PACKAGE_CL
/* 1933 */     .addExternalSymbol("LEAST-POSITIVE-LONG-FLOAT");
/* 1934 */   public static final Symbol LEAST_POSITIVE_NORMALIZED_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 1935 */     .addExternalSymbol("LEAST-POSITIVE-NORMALIZED-DOUBLE-FLOAT");
/* 1936 */   public static final Symbol LEAST_POSITIVE_NORMALIZED_LONG_FLOAT = Lisp.PACKAGE_CL
/* 1937 */     .addExternalSymbol("LEAST-POSITIVE-NORMALIZED-LONG-FLOAT");
/* 1938 */   public static final Symbol LEAST_POSITIVE_NORMALIZED_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 1939 */     .addExternalSymbol("LEAST-POSITIVE-NORMALIZED-SHORT-FLOAT");
/* 1940 */   public static final Symbol LEAST_POSITIVE_NORMALIZED_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 1941 */     .addExternalSymbol("LEAST-POSITIVE-NORMALIZED-SINGLE-FLOAT");
/* 1942 */   public static final Symbol LEAST_POSITIVE_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 1943 */     .addExternalSymbol("LEAST-POSITIVE-SHORT-FLOAT");
/* 1944 */   public static final Symbol LEAST_POSITIVE_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 1945 */     .addExternalSymbol("LEAST-POSITIVE-SINGLE-FLOAT");
/* 1946 */   public static final Symbol LENGTH = Lisp.PACKAGE_CL
/* 1947 */     .addExternalSymbol("LENGTH");
/* 1948 */   public static final Symbol LET = Lisp.PACKAGE_CL
/* 1949 */     .addExternalSymbol("LET");
/* 1950 */   public static final Symbol LET_STAR = Lisp.PACKAGE_CL
/* 1951 */     .addExternalSymbol("LET*");
/* 1952 */   public static final Symbol LISP_IMPLEMENTATION_TYPE = Lisp.PACKAGE_CL
/* 1953 */     .addExternalSymbol("LISP-IMPLEMENTATION-TYPE");
/* 1954 */   public static final Symbol LISP_IMPLEMENTATION_VERSION = Lisp.PACKAGE_CL
/* 1955 */     .addExternalSymbol("LISP-IMPLEMENTATION-VERSION");
/* 1956 */   public static final Symbol LIST = Lisp.PACKAGE_CL
/* 1957 */     .addExternalSymbol("LIST");
/* 1958 */   public static final Symbol LIST_STAR = Lisp.PACKAGE_CL
/* 1959 */     .addExternalSymbol("LIST*");
/* 1960 */   public static final Symbol LIST_ALL_PACKAGES = Lisp.PACKAGE_CL
/* 1961 */     .addExternalSymbol("LIST-ALL-PACKAGES");
/* 1962 */   public static final Symbol LIST_LENGTH = Lisp.PACKAGE_CL
/* 1963 */     .addExternalSymbol("LIST-LENGTH");
/* 1964 */   public static final Symbol LISTEN = Lisp.PACKAGE_CL
/* 1965 */     .addExternalSymbol("LISTEN");
/* 1966 */   public static final Symbol LISTP = Lisp.PACKAGE_CL
/* 1967 */     .addExternalSymbol("LISTP");
/* 1968 */   public static final Symbol LOAD = Lisp.PACKAGE_CL
/* 1969 */     .addExternalSymbol("LOAD");
/* 1970 */   public static final Symbol LOAD_LOGICAL_PATHNAME_TRANSLATIONS = Lisp.PACKAGE_CL
/* 1971 */     .addExternalSymbol("LOAD-LOGICAL-PATHNAME-TRANSLATIONS");
/* 1972 */   public static final Symbol LOAD_TIME_VALUE = Lisp.PACKAGE_CL
/* 1973 */     .addExternalSymbol("LOAD-TIME-VALUE");
/* 1974 */   public static final Symbol LOCALLY = Lisp.PACKAGE_CL
/* 1975 */     .addExternalSymbol("LOCALLY");
/* 1976 */   public static final Symbol LOG = Lisp.PACKAGE_CL
/* 1977 */     .addExternalSymbol("LOG");
/* 1978 */   public static final Symbol LOGAND = Lisp.PACKAGE_CL
/* 1979 */     .addExternalSymbol("LOGAND");
/* 1980 */   public static final Symbol LOGANDC1 = Lisp.PACKAGE_CL
/* 1981 */     .addExternalSymbol("LOGANDC1");
/* 1982 */   public static final Symbol LOGANDC2 = Lisp.PACKAGE_CL
/* 1983 */     .addExternalSymbol("LOGANDC2");
/* 1984 */   public static final Symbol LOGBITP = Lisp.PACKAGE_CL
/* 1985 */     .addExternalSymbol("LOGBITP");
/* 1986 */   public static final Symbol LOGCOUNT = Lisp.PACKAGE_CL
/* 1987 */     .addExternalSymbol("LOGCOUNT");
/* 1988 */   public static final Symbol LOGEQV = Lisp.PACKAGE_CL
/* 1989 */     .addExternalSymbol("LOGEQV");
/* 1990 */   public static final Symbol LOGICAL_PATHNAME = Lisp.PACKAGE_CL
/* 1991 */     .addExternalSymbol("LOGICAL-PATHNAME");
/* 1992 */   public static final Symbol LOGICAL_PATHNAME_TRANSLATIONS = Lisp.PACKAGE_CL
/* 1993 */     .addExternalSymbol("LOGICAL-PATHNAME-TRANSLATIONS");
/* 1994 */   public static final Symbol LOGIOR = Lisp.PACKAGE_CL
/* 1995 */     .addExternalSymbol("LOGIOR");
/* 1996 */   public static final Symbol LOGNAND = Lisp.PACKAGE_CL
/* 1997 */     .addExternalSymbol("LOGNAND");
/* 1998 */   public static final Symbol LOGNOR = Lisp.PACKAGE_CL
/* 1999 */     .addExternalSymbol("LOGNOR");
/* 2000 */   public static final Symbol LOGNOT = Lisp.PACKAGE_CL
/* 2001 */     .addExternalSymbol("LOGNOT");
/* 2002 */   public static final Symbol LOGORC1 = Lisp.PACKAGE_CL
/* 2003 */     .addExternalSymbol("LOGORC1");
/* 2004 */   public static final Symbol LOGORC2 = Lisp.PACKAGE_CL
/* 2005 */     .addExternalSymbol("LOGORC2");
/* 2006 */   public static final Symbol LOGTEST = Lisp.PACKAGE_CL
/* 2007 */     .addExternalSymbol("LOGTEST");
/* 2008 */   public static final Symbol LOGXOR = Lisp.PACKAGE_CL
/* 2009 */     .addExternalSymbol("LOGXOR");
/* 2010 */   public static final Symbol LONG_FLOAT = Lisp.PACKAGE_CL
/* 2011 */     .addExternalSymbol("LONG-FLOAT");
/* 2012 */   public static final Symbol LONG_FLOAT_EPSILON = Lisp.PACKAGE_CL
/* 2013 */     .addExternalSymbol("LONG-FLOAT-EPSILON");
/* 2014 */   public static final Symbol LONG_FLOAT_NEGATIVE_EPSILON = Lisp.PACKAGE_CL
/* 2015 */     .addExternalSymbol("LONG-FLOAT-NEGATIVE-EPSILON");
/* 2016 */   public static final Symbol LONG_SITE_NAME = Lisp.PACKAGE_CL
/* 2017 */     .addExternalSymbol("LONG-SITE-NAME");
/* 2018 */   public static final Symbol LOOP = Lisp.PACKAGE_CL
/* 2019 */     .addExternalSymbol("LOOP");
/* 2020 */   public static final Symbol LOOP_FINISH = Lisp.PACKAGE_CL
/* 2021 */     .addExternalSymbol("LOOP-FINISH");
/* 2022 */   public static final Symbol LOWER_CASE_P = Lisp.PACKAGE_CL
/* 2023 */     .addExternalSymbol("LOWER-CASE-P");
/* 2024 */   public static final Symbol MACHINE_INSTANCE = Lisp.PACKAGE_CL
/* 2025 */     .addExternalSymbol("MACHINE-INSTANCE");
/* 2026 */   public static final Symbol MACHINE_TYPE = Lisp.PACKAGE_CL
/* 2027 */     .addExternalSymbol("MACHINE-TYPE");
/* 2028 */   public static final Symbol MACHINE_VERSION = Lisp.PACKAGE_CL
/* 2029 */     .addExternalSymbol("MACHINE-VERSION");
/* 2030 */   public static final Symbol MACRO_FUNCTION = Lisp.PACKAGE_CL
/* 2031 */     .addExternalSymbol("MACRO-FUNCTION");
/* 2032 */   public static final Symbol MACROEXPAND = Lisp.PACKAGE_CL
/* 2033 */     .addExternalSymbol("MACROEXPAND");
/* 2034 */   public static final Symbol MACROEXPAND_1 = Lisp.PACKAGE_CL
/* 2035 */     .addExternalSymbol("MACROEXPAND-1");
/* 2036 */   public static final Symbol MACROLET = Lisp.PACKAGE_CL
/* 2037 */     .addExternalSymbol("MACROLET");
/* 2038 */   public static final Symbol MAKE_ARRAY = Lisp.PACKAGE_CL
/* 2039 */     .addExternalSymbol("MAKE-ARRAY");
/* 2040 */   public static final Symbol MAKE_BROADCAST_STREAM = Lisp.PACKAGE_CL
/* 2041 */     .addExternalSymbol("MAKE-BROADCAST-STREAM");
/* 2042 */   public static final Symbol MAKE_CONCATENATED_STREAM = Lisp.PACKAGE_CL
/* 2043 */     .addExternalSymbol("MAKE-CONCATENATED-STREAM");
/* 2044 */   public static final Symbol MAKE_CONDITION = Lisp.PACKAGE_CL
/* 2045 */     .addExternalSymbol("MAKE-CONDITION");
/* 2046 */   public static final Symbol MAKE_DISPATCH_MACRO_CHARACTER = Lisp.PACKAGE_CL
/* 2047 */     .addExternalSymbol("MAKE-DISPATCH-MACRO-CHARACTER");
/* 2048 */   public static final Symbol MAKE_ECHO_STREAM = Lisp.PACKAGE_CL
/* 2049 */     .addExternalSymbol("MAKE-ECHO-STREAM");
/* 2050 */   public static final Symbol MAKE_HASH_TABLE = Lisp.PACKAGE_CL
/* 2051 */     .addExternalSymbol("MAKE-HASH-TABLE");
/* 2052 */   public static final Symbol MAKE_INSTANCE = Lisp.PACKAGE_CL
/* 2053 */     .addExternalSymbol("MAKE-INSTANCE");
/* 2054 */   public static final Symbol MAKE_INSTANCES_OBSOLETE = Lisp.PACKAGE_CL
/* 2055 */     .addExternalSymbol("MAKE-INSTANCES-OBSOLETE");
/* 2056 */   public static final Symbol MAKE_LIST = Lisp.PACKAGE_CL
/* 2057 */     .addExternalSymbol("MAKE-LIST");
/* 2058 */   public static final Symbol MAKE_LOAD_FORM = Lisp.PACKAGE_CL
/* 2059 */     .addExternalSymbol("MAKE-LOAD-FORM");
/* 2060 */   public static final Symbol MAKE_LOAD_FORM_SAVING_SLOTS = Lisp.PACKAGE_CL
/* 2061 */     .addExternalSymbol("MAKE-LOAD-FORM-SAVING-SLOTS");
/* 2062 */   public static final Symbol MAKE_METHOD = Lisp.PACKAGE_CL
/* 2063 */     .addExternalSymbol("MAKE-METHOD");
/* 2064 */   public static final Symbol MAKE_PACKAGE = Lisp.PACKAGE_CL
/* 2065 */     .addExternalSymbol("MAKE-PACKAGE");
/* 2066 */   public static final Symbol MAKE_PATHNAME = Lisp.PACKAGE_CL
/* 2067 */     .addExternalSymbol("MAKE-PATHNAME");
/* 2068 */   public static final Symbol MAKE_RANDOM_STATE = Lisp.PACKAGE_CL
/* 2069 */     .addExternalSymbol("MAKE-RANDOM-STATE");
/* 2070 */   public static final Symbol MAKE_SEQUENCE = Lisp.PACKAGE_CL
/* 2071 */     .addExternalSymbol("MAKE-SEQUENCE");
/* 2072 */   public static final Symbol MAKE_STRING = Lisp.PACKAGE_CL
/* 2073 */     .addExternalSymbol("MAKE-STRING");
/* 2074 */   public static final Symbol MAKE_STRING_INPUT_STREAM = Lisp.PACKAGE_CL
/* 2075 */     .addExternalSymbol("MAKE-STRING-INPUT-STREAM");
/* 2076 */   public static final Symbol MAKE_STRING_OUTPUT_STREAM = Lisp.PACKAGE_CL
/* 2077 */     .addExternalSymbol("MAKE-STRING-OUTPUT-STREAM");
/* 2078 */   public static final Symbol MAKE_SYMBOL = Lisp.PACKAGE_CL
/* 2079 */     .addExternalSymbol("MAKE-SYMBOL");
/* 2080 */   public static final Symbol MAKE_SYNONYM_STREAM = Lisp.PACKAGE_CL
/* 2081 */     .addExternalSymbol("MAKE-SYNONYM-STREAM");
/* 2082 */   public static final Symbol MAKE_TWO_WAY_STREAM = Lisp.PACKAGE_CL
/* 2083 */     .addExternalSymbol("MAKE-TWO-WAY-STREAM");
/* 2084 */   public static final Symbol MAKUNBOUND = Lisp.PACKAGE_CL
/* 2085 */     .addExternalSymbol("MAKUNBOUND");
/* 2086 */   public static final Symbol MAP = Lisp.PACKAGE_CL
/* 2087 */     .addExternalSymbol("MAP");
/* 2088 */   public static final Symbol MAP_INTO = Lisp.PACKAGE_CL
/* 2089 */     .addExternalSymbol("MAP-INTO");
/* 2090 */   public static final Symbol MAPC = Lisp.PACKAGE_CL
/* 2091 */     .addExternalSymbol("MAPC");
/* 2092 */   public static final Symbol MAPCAN = Lisp.PACKAGE_CL
/* 2093 */     .addExternalSymbol("MAPCAN");
/* 2094 */   public static final Symbol MAPCAR = Lisp.PACKAGE_CL
/* 2095 */     .addExternalSymbol("MAPCAR");
/* 2096 */   public static final Symbol MAPCON = Lisp.PACKAGE_CL
/* 2097 */     .addExternalSymbol("MAPCON");
/* 2098 */   public static final Symbol MAPHASH = Lisp.PACKAGE_CL
/* 2099 */     .addExternalSymbol("MAPHASH");
/* 2100 */   public static final Symbol MAPL = Lisp.PACKAGE_CL
/* 2101 */     .addExternalSymbol("MAPL");
/* 2102 */   public static final Symbol MAPLIST = Lisp.PACKAGE_CL
/* 2103 */     .addExternalSymbol("MAPLIST");
/* 2104 */   public static final Symbol MASK_FIELD = Lisp.PACKAGE_CL
/* 2105 */     .addExternalSymbol("MASK-FIELD");
/* 2106 */   public static final Symbol MAX = Lisp.PACKAGE_CL
/* 2107 */     .addExternalSymbol("MAX");
/* 2108 */   public static final Symbol MEMBER = Lisp.PACKAGE_CL
/* 2109 */     .addExternalSymbol("MEMBER");
/* 2110 */   public static final Symbol MEMBER_IF = Lisp.PACKAGE_CL
/* 2111 */     .addExternalSymbol("MEMBER-IF");
/* 2112 */   public static final Symbol MEMBER_IF_NOT = Lisp.PACKAGE_CL
/* 2113 */     .addExternalSymbol("MEMBER-IF-NOT");
/* 2114 */   public static final Symbol MERGE = Lisp.PACKAGE_CL
/* 2115 */     .addExternalSymbol("MERGE");
/* 2116 */   public static final Symbol MERGE_PATHNAMES = Lisp.PACKAGE_CL
/* 2117 */     .addExternalSymbol("MERGE-PATHNAMES");
/* 2118 */   public static final Symbol METHOD = Lisp.PACKAGE_CL
/* 2119 */     .addExternalSymbol("METHOD");
/* 2120 */   public static final Symbol METHOD_COMBINATION = Lisp.PACKAGE_CL
/* 2121 */     .addExternalSymbol("METHOD-COMBINATION");
/* 2122 */   public static final Symbol METHOD_COMBINATION_ERROR = Lisp.PACKAGE_CL
/* 2123 */     .addExternalSymbol("METHOD-COMBINATION-ERROR");
/* 2124 */   public static final Symbol METHOD_QUALIFIERS = Lisp.PACKAGE_CL
/* 2125 */     .addExternalSymbol("METHOD-QUALIFIERS");
/* 2126 */   public static final Symbol MIN = Lisp.PACKAGE_CL
/* 2127 */     .addExternalSymbol("MIN");
/* 2128 */   public static final Symbol MINUSP = Lisp.PACKAGE_CL
/* 2129 */     .addExternalSymbol("MINUSP");
/* 2130 */   public static final Symbol MISMATCH = Lisp.PACKAGE_CL
/* 2131 */     .addExternalSymbol("MISMATCH");
/* 2132 */   public static final Symbol MOD = Lisp.PACKAGE_CL
/* 2133 */     .addExternalSymbol("MOD");
/* 2134 */   public static final Symbol MOST_NEGATIVE_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 2135 */     .addExternalSymbol("MOST-NEGATIVE-DOUBLE-FLOAT");
/* 2136 */   public static final Symbol MOST_NEGATIVE_FIXNUM = Lisp.PACKAGE_CL
/* 2137 */     .addExternalSymbol("MOST-NEGATIVE-FIXNUM");
/* 2138 */   public static final Symbol MOST_NEGATIVE_LONG_FLOAT = Lisp.PACKAGE_CL
/* 2139 */     .addExternalSymbol("MOST-NEGATIVE-LONG-FLOAT");
/* 2140 */   public static final Symbol MOST_NEGATIVE_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 2141 */     .addExternalSymbol("MOST-NEGATIVE-SHORT-FLOAT");
/* 2142 */   public static final Symbol MOST_NEGATIVE_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 2143 */     .addExternalSymbol("MOST-NEGATIVE-SINGLE-FLOAT");
/* 2144 */   public static final Symbol MOST_POSITIVE_DOUBLE_FLOAT = Lisp.PACKAGE_CL
/* 2145 */     .addExternalSymbol("MOST-POSITIVE-DOUBLE-FLOAT");
/* 2146 */   public static final Symbol MOST_POSITIVE_FIXNUM = Lisp.PACKAGE_CL
/* 2147 */     .addExternalSymbol("MOST-POSITIVE-FIXNUM");
/* 2148 */   public static final Symbol MOST_POSITIVE_LONG_FLOAT = Lisp.PACKAGE_CL
/* 2149 */     .addExternalSymbol("MOST-POSITIVE-LONG-FLOAT");
/* 2150 */   public static final Symbol MOST_POSITIVE_SHORT_FLOAT = Lisp.PACKAGE_CL
/* 2151 */     .addExternalSymbol("MOST-POSITIVE-SHORT-FLOAT");
/* 2152 */   public static final Symbol MOST_POSITIVE_SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 2153 */     .addExternalSymbol("MOST-POSITIVE-SINGLE-FLOAT");
/* 2154 */   public static final Symbol MUFFLE_WARNING = Lisp.PACKAGE_CL
/* 2155 */     .addExternalSymbol("MUFFLE-WARNING");
/* 2156 */   public static final Symbol MULTIPLE_VALUE_BIND = Lisp.PACKAGE_CL
/* 2157 */     .addExternalSymbol("MULTIPLE-VALUE-BIND");
/* 2158 */   public static final Symbol MULTIPLE_VALUE_CALL = Lisp.PACKAGE_CL
/* 2159 */     .addExternalSymbol("MULTIPLE-VALUE-CALL");
/* 2160 */   public static final Symbol MULTIPLE_VALUE_LIST = Lisp.PACKAGE_CL
/* 2161 */     .addExternalSymbol("MULTIPLE-VALUE-LIST");
/* 2162 */   public static final Symbol MULTIPLE_VALUE_PROG1 = Lisp.PACKAGE_CL
/* 2163 */     .addExternalSymbol("MULTIPLE-VALUE-PROG1");
/* 2164 */   public static final Symbol MULTIPLE_VALUE_SETQ = Lisp.PACKAGE_CL
/* 2165 */     .addExternalSymbol("MULTIPLE-VALUE-SETQ");
/* 2166 */   public static final Symbol MULTIPLE_VALUES_LIMIT = Lisp.PACKAGE_CL
/* 2167 */     .addExternalSymbol("MULTIPLE-VALUES-LIMIT");
/* 2168 */   public static final Symbol NAME_CHAR = Lisp.PACKAGE_CL
/* 2169 */     .addExternalSymbol("NAME-CHAR");
/* 2170 */   public static final Symbol NAMESTRING = Lisp.PACKAGE_CL
/* 2171 */     .addExternalSymbol("NAMESTRING");
/* 2172 */   public static final Symbol NBUTLAST = Lisp.PACKAGE_CL
/* 2173 */     .addExternalSymbol("NBUTLAST");
/* 2174 */   public static final Symbol NCONC = Lisp.PACKAGE_CL
/* 2175 */     .addExternalSymbol("NCONC");
/* 2176 */   public static final Symbol NEXT_METHOD_P = Lisp.PACKAGE_CL
/* 2177 */     .addExternalSymbol("NEXT-METHOD-P");
/*      */ 
/*      */ 
/*      */   
/* 2181 */   public static final Symbol NINTERSECTION = Lisp.PACKAGE_CL
/* 2182 */     .addExternalSymbol("NINTERSECTION");
/* 2183 */   public static final Symbol NINTH = Lisp.PACKAGE_CL
/* 2184 */     .addExternalSymbol("NINTH");
/* 2185 */   public static final Symbol NO_APPLICABLE_METHOD = Lisp.PACKAGE_CL
/* 2186 */     .addExternalSymbol("NO-APPLICABLE-METHOD");
/* 2187 */   public static final Symbol NO_NEXT_METHOD = Lisp.PACKAGE_CL
/* 2188 */     .addExternalSymbol("NO-NEXT-METHOD");
/* 2189 */   public static final Symbol NOT = Lisp.PACKAGE_CL
/* 2190 */     .addExternalSymbol("NOT");
/* 2191 */   public static final Symbol NOTANY = Lisp.PACKAGE_CL
/* 2192 */     .addExternalSymbol("NOTANY");
/* 2193 */   public static final Symbol NOTEVERY = Lisp.PACKAGE_CL
/* 2194 */     .addExternalSymbol("NOTEVERY");
/* 2195 */   public static final Symbol NOTINLINE = Lisp.PACKAGE_CL
/* 2196 */     .addExternalSymbol("NOTINLINE");
/* 2197 */   public static final Symbol NRECONC = Lisp.PACKAGE_CL
/* 2198 */     .addExternalSymbol("NRECONC");
/* 2199 */   public static final Symbol NREVERSE = Lisp.PACKAGE_CL
/* 2200 */     .addExternalSymbol("NREVERSE");
/* 2201 */   public static final Symbol NSET_DIFFERENCE = Lisp.PACKAGE_CL
/* 2202 */     .addExternalSymbol("NSET-DIFFERENCE");
/* 2203 */   public static final Symbol NSET_EXCLUSIVE_OR = Lisp.PACKAGE_CL
/* 2204 */     .addExternalSymbol("NSET-EXCLUSIVE-OR");
/* 2205 */   public static final Symbol NSTRING_CAPITALIZE = Lisp.PACKAGE_CL
/* 2206 */     .addExternalSymbol("NSTRING-CAPITALIZE");
/* 2207 */   public static final Symbol NSTRING_DOWNCASE = Lisp.PACKAGE_CL
/* 2208 */     .addExternalSymbol("NSTRING-DOWNCASE");
/* 2209 */   public static final Symbol NSTRING_UPCASE = Lisp.PACKAGE_CL
/* 2210 */     .addExternalSymbol("NSTRING-UPCASE");
/* 2211 */   public static final Symbol NSUBLIS = Lisp.PACKAGE_CL
/* 2212 */     .addExternalSymbol("NSUBLIS");
/* 2213 */   public static final Symbol NSUBST = Lisp.PACKAGE_CL
/* 2214 */     .addExternalSymbol("NSUBST");
/* 2215 */   public static final Symbol NSUBST_IF = Lisp.PACKAGE_CL
/* 2216 */     .addExternalSymbol("NSUBST-IF");
/* 2217 */   public static final Symbol NSUBST_IF_NOT = Lisp.PACKAGE_CL
/* 2218 */     .addExternalSymbol("NSUBST-IF-NOT");
/* 2219 */   public static final Symbol NSUBSTITUTE = Lisp.PACKAGE_CL
/* 2220 */     .addExternalSymbol("NSUBSTITUTE");
/* 2221 */   public static final Symbol NSUBSTITUTE_IF = Lisp.PACKAGE_CL
/* 2222 */     .addExternalSymbol("NSUBSTITUTE-IF");
/* 2223 */   public static final Symbol NSUBSTITUTE_IF_NOT = Lisp.PACKAGE_CL
/* 2224 */     .addExternalSymbol("NSUBSTITUTE-IF-NOT");
/* 2225 */   public static final Symbol NTH = Lisp.PACKAGE_CL
/* 2226 */     .addExternalSymbol("NTH");
/* 2227 */   public static final Symbol NTH_VALUE = Lisp.PACKAGE_CL
/* 2228 */     .addExternalSymbol("NTH-VALUE");
/* 2229 */   public static final Symbol NTHCDR = Lisp.PACKAGE_CL
/* 2230 */     .addExternalSymbol("NTHCDR");
/* 2231 */   public static final Symbol NULL = Lisp.PACKAGE_CL
/* 2232 */     .addExternalSymbol("NULL");
/* 2233 */   public static final Symbol NUMBER = Lisp.PACKAGE_CL
/* 2234 */     .addExternalSymbol("NUMBER");
/* 2235 */   public static final Symbol NUMBERP = Lisp.PACKAGE_CL
/* 2236 */     .addExternalSymbol("NUMBERP");
/* 2237 */   public static final Symbol NUMERATOR = Lisp.PACKAGE_CL
/* 2238 */     .addExternalSymbol("NUMERATOR");
/* 2239 */   public static final Symbol NUNION = Lisp.PACKAGE_CL
/* 2240 */     .addExternalSymbol("NUNION");
/* 2241 */   public static final Symbol ODDP = Lisp.PACKAGE_CL
/* 2242 */     .addExternalSymbol("ODDP");
/* 2243 */   public static final Symbol OPEN = Lisp.PACKAGE_CL
/* 2244 */     .addExternalSymbol("OPEN");
/* 2245 */   public static final Symbol OPEN_STREAM_P = Lisp.PACKAGE_CL
/* 2246 */     .addExternalSymbol("OPEN-STREAM-P");
/* 2247 */   public static final Symbol OPTIMIZE = Lisp.PACKAGE_CL
/* 2248 */     .addExternalSymbol("OPTIMIZE");
/* 2249 */   public static final Symbol OR = Lisp.PACKAGE_CL
/* 2250 */     .addExternalSymbol("OR");
/* 2251 */   public static final Symbol OTHERWISE = Lisp.PACKAGE_CL
/* 2252 */     .addExternalSymbol("OTHERWISE");
/* 2253 */   public static final Symbol OUTPUT_STREAM_P = Lisp.PACKAGE_CL
/* 2254 */     .addExternalSymbol("OUTPUT-STREAM-P");
/* 2255 */   public static final Symbol PACKAGE = Lisp.PACKAGE_CL
/* 2256 */     .addExternalSymbol("PACKAGE");
/* 2257 */   public static final Symbol PACKAGE_ERROR = Lisp.PACKAGE_CL
/* 2258 */     .addExternalSymbol("PACKAGE-ERROR");
/* 2259 */   public static final Symbol PACKAGE_ERROR_PACKAGE = Lisp.PACKAGE_CL
/* 2260 */     .addExternalSymbol("PACKAGE-ERROR-PACKAGE");
/* 2261 */   public static final Symbol PACKAGE_NAME = Lisp.PACKAGE_CL
/* 2262 */     .addExternalSymbol("PACKAGE-NAME");
/* 2263 */   public static final Symbol PACKAGE_NICKNAMES = Lisp.PACKAGE_CL
/* 2264 */     .addExternalSymbol("PACKAGE-NICKNAMES");
/* 2265 */   public static final Symbol PACKAGE_SHADOWING_SYMBOLS = Lisp.PACKAGE_CL
/* 2266 */     .addExternalSymbol("PACKAGE-SHADOWING-SYMBOLS");
/* 2267 */   public static final Symbol PACKAGE_USE_LIST = Lisp.PACKAGE_CL
/* 2268 */     .addExternalSymbol("PACKAGE-USE-LIST");
/* 2269 */   public static final Symbol PACKAGE_USED_BY_LIST = Lisp.PACKAGE_CL
/* 2270 */     .addExternalSymbol("PACKAGE-USED-BY-LIST");
/* 2271 */   public static final Symbol PACKAGEP = Lisp.PACKAGE_CL
/* 2272 */     .addExternalSymbol("PACKAGEP");
/* 2273 */   public static final Symbol PAIRLIS = Lisp.PACKAGE_CL
/* 2274 */     .addExternalSymbol("PAIRLIS");
/* 2275 */   public static final Symbol PARSE_ERROR = Lisp.PACKAGE_CL
/* 2276 */     .addExternalSymbol("PARSE-ERROR");
/* 2277 */   public static final Symbol PARSE_INTEGER = Lisp.PACKAGE_CL
/* 2278 */     .addExternalSymbol("PARSE-INTEGER");
/* 2279 */   public static final Symbol PARSE_NAMESTRING = Lisp.PACKAGE_CL
/* 2280 */     .addExternalSymbol("PARSE-NAMESTRING");
/* 2281 */   public static final Symbol PATHNAME = Lisp.PACKAGE_CL
/* 2282 */     .addExternalSymbol("PATHNAME");
/* 2283 */   public static final Symbol PATHNAME_DEVICE = Lisp.PACKAGE_CL
/* 2284 */     .addExternalSymbol("PATHNAME-DEVICE");
/* 2285 */   public static final Symbol PATHNAME_DIRECTORY = Lisp.PACKAGE_CL
/* 2286 */     .addExternalSymbol("PATHNAME-DIRECTORY");
/* 2287 */   public static final Symbol PATHNAME_HOST = Lisp.PACKAGE_CL
/* 2288 */     .addExternalSymbol("PATHNAME-HOST");
/* 2289 */   public static final Symbol PATHNAME_MATCH_P = Lisp.PACKAGE_CL
/* 2290 */     .addExternalSymbol("PATHNAME-MATCH-P");
/* 2291 */   public static final Symbol PATHNAME_NAME = Lisp.PACKAGE_CL
/* 2292 */     .addExternalSymbol("PATHNAME-NAME");
/* 2293 */   public static final Symbol PATHNAME_TYPE = Lisp.PACKAGE_CL
/* 2294 */     .addExternalSymbol("PATHNAME-TYPE");
/* 2295 */   public static final Symbol PATHNAME_VERSION = Lisp.PACKAGE_CL
/* 2296 */     .addExternalSymbol("PATHNAME-VERSION");
/* 2297 */   public static final Symbol PATHNAMEP = Lisp.PACKAGE_CL
/* 2298 */     .addExternalSymbol("PATHNAMEP");
/* 2299 */   public static final Symbol PEEK_CHAR = Lisp.PACKAGE_CL
/* 2300 */     .addExternalSymbol("PEEK-CHAR");
/* 2301 */   public static final Symbol PHASE = Lisp.PACKAGE_CL
/* 2302 */     .addExternalSymbol("PHASE");
/* 2303 */   public static final Symbol PI = Lisp.PACKAGE_CL
/* 2304 */     .addExternalSymbol("PI");
/* 2305 */   public static final Symbol PLUSP = Lisp.PACKAGE_CL
/* 2306 */     .addExternalSymbol("PLUSP");
/* 2307 */   public static final Symbol POP = Lisp.PACKAGE_CL
/* 2308 */     .addExternalSymbol("POP");
/* 2309 */   public static final Symbol POSITION = Lisp.PACKAGE_CL
/* 2310 */     .addExternalSymbol("POSITION");
/* 2311 */   public static final Symbol POSITION_IF = Lisp.PACKAGE_CL
/* 2312 */     .addExternalSymbol("POSITION-IF");
/* 2313 */   public static final Symbol POSITION_IF_NOT = Lisp.PACKAGE_CL
/* 2314 */     .addExternalSymbol("POSITION-IF-NOT");
/* 2315 */   public static final Symbol PPRINT = Lisp.PACKAGE_CL
/* 2316 */     .addExternalSymbol("PPRINT");
/* 2317 */   public static final Symbol PPRINT_DISPATCH = Lisp.PACKAGE_CL
/* 2318 */     .addExternalSymbol("PPRINT-DISPATCH");
/* 2319 */   public static final Symbol PPRINT_EXIT_IF_LIST_EXHAUSTED = Lisp.PACKAGE_CL
/* 2320 */     .addExternalSymbol("PPRINT-EXIT-IF-LIST-EXHAUSTED");
/* 2321 */   public static final Symbol PPRINT_FILL = Lisp.PACKAGE_CL
/* 2322 */     .addExternalSymbol("PPRINT-FILL");
/* 2323 */   public static final Symbol PPRINT_INDENT = Lisp.PACKAGE_CL
/* 2324 */     .addExternalSymbol("PPRINT-INDENT");
/* 2325 */   public static final Symbol PPRINT_LINEAR = Lisp.PACKAGE_CL
/* 2326 */     .addExternalSymbol("PPRINT-LINEAR");
/* 2327 */   public static final Symbol PPRINT_LOGICAL_BLOCK = Lisp.PACKAGE_CL
/* 2328 */     .addExternalSymbol("PPRINT-LOGICAL-BLOCK");
/* 2329 */   public static final Symbol PPRINT_NEWLINE = Lisp.PACKAGE_CL
/* 2330 */     .addExternalSymbol("PPRINT-NEWLINE");
/* 2331 */   public static final Symbol PPRINT_POP = Lisp.PACKAGE_CL
/* 2332 */     .addExternalSymbol("PPRINT-POP");
/* 2333 */   public static final Symbol PPRINT_TAB = Lisp.PACKAGE_CL
/* 2334 */     .addExternalSymbol("PPRINT-TAB");
/* 2335 */   public static final Symbol PPRINT_TABULAR = Lisp.PACKAGE_CL
/* 2336 */     .addExternalSymbol("PPRINT-TABULAR");
/* 2337 */   public static final Symbol PRIN1 = Lisp.PACKAGE_CL
/* 2338 */     .addExternalSymbol("PRIN1");
/* 2339 */   public static final Symbol PRIN1_TO_STRING = Lisp.PACKAGE_CL
/* 2340 */     .addExternalSymbol("PRIN1-TO-STRING");
/* 2341 */   public static final Symbol PRINC = Lisp.PACKAGE_CL
/* 2342 */     .addExternalSymbol("PRINC");
/* 2343 */   public static final Symbol PRINC_TO_STRING = Lisp.PACKAGE_CL
/* 2344 */     .addExternalSymbol("PRINC-TO-STRING");
/* 2345 */   public static final Symbol PRINT = Lisp.PACKAGE_CL
/* 2346 */     .addExternalSymbol("PRINT");
/* 2347 */   public static final Symbol PRINT_NOT_READABLE = Lisp.PACKAGE_CL
/* 2348 */     .addExternalSymbol("PRINT-NOT-READABLE");
/* 2349 */   public static final Symbol PRINT_NOT_READABLE_OBJECT = Lisp.PACKAGE_CL
/* 2350 */     .addExternalSymbol("PRINT-NOT-READABLE-OBJECT");
/* 2351 */   public static final Symbol PRINT_OBJECT = Lisp.PACKAGE_CL
/* 2352 */     .addExternalSymbol("PRINT-OBJECT");
/* 2353 */   public static final Symbol PRINT_UNREADABLE_OBJECT = Lisp.PACKAGE_CL
/* 2354 */     .addExternalSymbol("PRINT-UNREADABLE-OBJECT");
/* 2355 */   public static final Symbol PROBE_FILE = Lisp.PACKAGE_CL
/* 2356 */     .addExternalSymbol("PROBE-FILE");
/* 2357 */   public static final Symbol PROCLAIM = Lisp.PACKAGE_CL
/* 2358 */     .addExternalSymbol("PROCLAIM");
/* 2359 */   public static final Symbol PROG = Lisp.PACKAGE_CL
/* 2360 */     .addExternalSymbol("PROG");
/* 2361 */   public static final Symbol PROG_STAR = Lisp.PACKAGE_CL
/* 2362 */     .addExternalSymbol("PROG*");
/* 2363 */   public static final Symbol PROG1 = Lisp.PACKAGE_CL
/* 2364 */     .addExternalSymbol("PROG1");
/* 2365 */   public static final Symbol PROG2 = Lisp.PACKAGE_CL
/* 2366 */     .addExternalSymbol("PROG2");
/* 2367 */   public static final Symbol PROGN = Lisp.PACKAGE_CL
/* 2368 */     .addExternalSymbol("PROGN");
/* 2369 */   public static final Symbol PROGRAM_ERROR = Lisp.PACKAGE_CL
/* 2370 */     .addExternalSymbol("PROGRAM-ERROR");
/* 2371 */   public static final Symbol PROGV = Lisp.PACKAGE_CL
/* 2372 */     .addExternalSymbol("PROGV");
/* 2373 */   public static final Symbol PROVIDE = Lisp.PACKAGE_CL
/* 2374 */     .addExternalSymbol("PROVIDE");
/* 2375 */   public static final Symbol PSETF = Lisp.PACKAGE_CL
/* 2376 */     .addExternalSymbol("PSETF");
/* 2377 */   public static final Symbol PSETQ = Lisp.PACKAGE_CL
/* 2378 */     .addExternalSymbol("PSETQ");
/* 2379 */   public static final Symbol PUSH = Lisp.PACKAGE_CL
/* 2380 */     .addExternalSymbol("PUSH");
/* 2381 */   public static final Symbol PUSHNEW = Lisp.PACKAGE_CL
/* 2382 */     .addExternalSymbol("PUSHNEW");
/* 2383 */   public static final Symbol QUOTE = Lisp.PACKAGE_CL
/* 2384 */     .addExternalSymbol("QUOTE");
/* 2385 */   public static final Symbol RANDOM = Lisp.PACKAGE_CL
/* 2386 */     .addExternalSymbol("RANDOM");
/* 2387 */   public static final Symbol RANDOM_STATE = Lisp.PACKAGE_CL
/* 2388 */     .addExternalSymbol("RANDOM-STATE");
/* 2389 */   public static final Symbol RANDOM_STATE_P = Lisp.PACKAGE_CL
/* 2390 */     .addExternalSymbol("RANDOM-STATE-P");
/* 2391 */   public static final Symbol RASSOC = Lisp.PACKAGE_CL
/* 2392 */     .addExternalSymbol("RASSOC");
/* 2393 */   public static final Symbol RASSOC_IF = Lisp.PACKAGE_CL
/* 2394 */     .addExternalSymbol("RASSOC-IF");
/* 2395 */   public static final Symbol RASSOC_IF_NOT = Lisp.PACKAGE_CL
/* 2396 */     .addExternalSymbol("RASSOC-IF-NOT");
/* 2397 */   public static final Symbol RATIO = Lisp.PACKAGE_CL
/* 2398 */     .addExternalSymbol("RATIO");
/* 2399 */   public static final Symbol RATIONAL = Lisp.PACKAGE_CL
/* 2400 */     .addExternalSymbol("RATIONAL");
/* 2401 */   public static final Symbol RATIONALIZE = Lisp.PACKAGE_CL
/* 2402 */     .addExternalSymbol("RATIONALIZE");
/* 2403 */   public static final Symbol RATIONALP = Lisp.PACKAGE_CL
/* 2404 */     .addExternalSymbol("RATIONALP");
/* 2405 */   public static final Symbol READ = Lisp.PACKAGE_CL
/* 2406 */     .addExternalSymbol("READ");
/* 2407 */   public static final Symbol READ_BYTE = Lisp.PACKAGE_CL
/* 2408 */     .addExternalSymbol("READ-BYTE");
/* 2409 */   public static final Symbol READ_CHAR = Lisp.PACKAGE_CL
/* 2410 */     .addExternalSymbol("READ-CHAR");
/* 2411 */   public static final Symbol READ_CHAR_NO_HANG = Lisp.PACKAGE_CL
/* 2412 */     .addExternalSymbol("READ-CHAR-NO-HANG");
/* 2413 */   public static final Symbol READ_DELIMITED_LIST = Lisp.PACKAGE_CL
/* 2414 */     .addExternalSymbol("READ-DELIMITED-LIST");
/* 2415 */   public static final Symbol READ_FROM_STRING = Lisp.PACKAGE_CL
/* 2416 */     .addExternalSymbol("READ-FROM-STRING");
/* 2417 */   public static final Symbol READ_LINE = Lisp.PACKAGE_CL
/* 2418 */     .addExternalSymbol("READ-LINE");
/* 2419 */   public static final Symbol READ_PRESERVING_WHITESPACE = Lisp.PACKAGE_CL
/* 2420 */     .addExternalSymbol("READ-PRESERVING-WHITESPACE");
/* 2421 */   public static final Symbol READ_SEQUENCE = Lisp.PACKAGE_CL
/* 2422 */     .addExternalSymbol("READ-SEQUENCE");
/* 2423 */   public static final Symbol READER_ERROR = Lisp.PACKAGE_CL
/* 2424 */     .addExternalSymbol("READER-ERROR");
/* 2425 */   public static final Symbol READTABLE = Lisp.PACKAGE_CL
/* 2426 */     .addExternalSymbol("READTABLE");
/* 2427 */   public static final Symbol READTABLE_CASE = Lisp.PACKAGE_CL
/* 2428 */     .addExternalSymbol("READTABLE-CASE");
/* 2429 */   public static final Symbol READTABLEP = Lisp.PACKAGE_CL
/* 2430 */     .addExternalSymbol("READTABLEP");
/* 2431 */   public static final Symbol REAL = Lisp.PACKAGE_CL
/* 2432 */     .addExternalSymbol("REAL");
/* 2433 */   public static final Symbol REALP = Lisp.PACKAGE_CL
/* 2434 */     .addExternalSymbol("REALP");
/* 2435 */   public static final Symbol REALPART = Lisp.PACKAGE_CL
/* 2436 */     .addExternalSymbol("REALPART");
/* 2437 */   public static final Symbol REDUCE = Lisp.PACKAGE_CL
/* 2438 */     .addExternalSymbol("REDUCE");
/* 2439 */   public static final Symbol REINITIALIZE_INSTANCE = Lisp.PACKAGE_CL
/* 2440 */     .addExternalSymbol("REINITIALIZE-INSTANCE");
/* 2441 */   public static final Symbol REM = Lisp.PACKAGE_CL
/* 2442 */     .addExternalSymbol("REM");
/* 2443 */   public static final Symbol REMF = Lisp.PACKAGE_CL
/* 2444 */     .addExternalSymbol("REMF");
/* 2445 */   public static final Symbol REMHASH = Lisp.PACKAGE_CL
/* 2446 */     .addExternalSymbol("REMHASH");
/* 2447 */   public static final Symbol REMOVE = Lisp.PACKAGE_CL
/* 2448 */     .addExternalSymbol("REMOVE");
/* 2449 */   public static final Symbol REMOVE_DUPLICATES = Lisp.PACKAGE_CL
/* 2450 */     .addExternalSymbol("REMOVE-DUPLICATES");
/* 2451 */   public static final Symbol REMOVE_IF = Lisp.PACKAGE_CL
/* 2452 */     .addExternalSymbol("REMOVE-IF");
/* 2453 */   public static final Symbol REMOVE_IF_NOT = Lisp.PACKAGE_CL
/* 2454 */     .addExternalSymbol("REMOVE-IF-NOT");
/* 2455 */   public static final Symbol REMOVE_METHOD = Lisp.PACKAGE_CL
/* 2456 */     .addExternalSymbol("REMOVE-METHOD");
/* 2457 */   public static final Symbol REMPROP = Lisp.PACKAGE_CL
/* 2458 */     .addExternalSymbol("REMPROP");
/* 2459 */   public static final Symbol RENAME_FILE = Lisp.PACKAGE_CL
/* 2460 */     .addExternalSymbol("RENAME-FILE");
/* 2461 */   public static final Symbol RENAME_PACKAGE = Lisp.PACKAGE_CL
/* 2462 */     .addExternalSymbol("RENAME-PACKAGE");
/* 2463 */   public static final Symbol REPLACE = Lisp.PACKAGE_CL
/* 2464 */     .addExternalSymbol("REPLACE");
/* 2465 */   public static final Symbol REQUIRE = Lisp.PACKAGE_CL
/* 2466 */     .addExternalSymbol("REQUIRE");
/* 2467 */   public static final Symbol REST = Lisp.PACKAGE_CL
/* 2468 */     .addExternalSymbol("REST");
/* 2469 */   public static final Symbol RESTART = Lisp.PACKAGE_CL
/* 2470 */     .addExternalSymbol("RESTART");
/* 2471 */   public static final Symbol RESTART_BIND = Lisp.PACKAGE_CL
/* 2472 */     .addExternalSymbol("RESTART-BIND");
/* 2473 */   public static final Symbol RESTART_CASE = Lisp.PACKAGE_CL
/* 2474 */     .addExternalSymbol("RESTART-CASE");
/* 2475 */   public static final Symbol RESTART_NAME = Lisp.PACKAGE_CL
/* 2476 */     .addExternalSymbol("RESTART-NAME");
/* 2477 */   public static final Symbol RETURN = Lisp.PACKAGE_CL
/* 2478 */     .addExternalSymbol("RETURN");
/* 2479 */   public static final Symbol RETURN_FROM = Lisp.PACKAGE_CL
/* 2480 */     .addExternalSymbol("RETURN-FROM");
/* 2481 */   public static final Symbol REVAPPEND = Lisp.PACKAGE_CL
/* 2482 */     .addExternalSymbol("REVAPPEND");
/* 2483 */   public static final Symbol REVERSE = Lisp.PACKAGE_CL
/* 2484 */     .addExternalSymbol("REVERSE");
/* 2485 */   public static final Symbol ROOM = Lisp.PACKAGE_CL
/* 2486 */     .addExternalSymbol("ROOM");
/* 2487 */   public static final Symbol ROTATEF = Lisp.PACKAGE_CL
/* 2488 */     .addExternalSymbol("ROTATEF");
/* 2489 */   public static final Symbol ROUND = Lisp.PACKAGE_CL
/* 2490 */     .addExternalSymbol("ROUND");
/* 2491 */   public static final Symbol ROW_MAJOR_AREF = Lisp.PACKAGE_CL
/* 2492 */     .addExternalSymbol("ROW-MAJOR-AREF");
/* 2493 */   public static final Symbol RPLACA = Lisp.PACKAGE_CL
/* 2494 */     .addExternalSymbol("RPLACA");
/* 2495 */   public static final Symbol RPLACD = Lisp.PACKAGE_CL
/* 2496 */     .addExternalSymbol("RPLACD");
/* 2497 */   public static final Symbol SAFETY = Lisp.PACKAGE_CL
/* 2498 */     .addExternalSymbol("SAFETY");
/* 2499 */   public static final Symbol SATISFIES = Lisp.PACKAGE_CL
/* 2500 */     .addExternalSymbol("SATISFIES");
/* 2501 */   public static final Symbol SBIT = Lisp.PACKAGE_CL
/* 2502 */     .addExternalSymbol("SBIT");
/* 2503 */   public static final Symbol SCALE_FLOAT = Lisp.PACKAGE_CL
/* 2504 */     .addExternalSymbol("SCALE-FLOAT");
/* 2505 */   public static final Symbol SCHAR = Lisp.PACKAGE_CL
/* 2506 */     .addExternalSymbol("SCHAR");
/* 2507 */   public static final Symbol SEARCH = Lisp.PACKAGE_CL
/* 2508 */     .addExternalSymbol("SEARCH");
/* 2509 */   public static final Symbol SECOND = Lisp.PACKAGE_CL
/* 2510 */     .addExternalSymbol("SECOND");
/* 2511 */   public static final Symbol SEQUENCE = Lisp.PACKAGE_CL
/* 2512 */     .addExternalSymbol("SEQUENCE");
/* 2513 */   public static final Symbol SERIOUS_CONDITION = Lisp.PACKAGE_CL
/* 2514 */     .addExternalSymbol("SERIOUS-CONDITION");
/* 2515 */   public static final Symbol SET = Lisp.PACKAGE_CL
/* 2516 */     .addExternalSymbol("SET");
/* 2517 */   public static final Symbol SET_DIFFERENCE = Lisp.PACKAGE_CL
/* 2518 */     .addExternalSymbol("SET-DIFFERENCE");
/* 2519 */   public static final Symbol SET_DISPATCH_MACRO_CHARACTER = Lisp.PACKAGE_CL
/* 2520 */     .addExternalSymbol("SET-DISPATCH-MACRO-CHARACTER");
/* 2521 */   public static final Symbol SET_EXCLUSIVE_OR = Lisp.PACKAGE_CL
/* 2522 */     .addExternalSymbol("SET-EXCLUSIVE-OR");
/* 2523 */   public static final Symbol SET_MACRO_CHARACTER = Lisp.PACKAGE_CL
/* 2524 */     .addExternalSymbol("SET-MACRO-CHARACTER");
/* 2525 */   public static final Symbol SET_PPRINT_DISPATCH = Lisp.PACKAGE_CL
/* 2526 */     .addExternalSymbol("SET-PPRINT-DISPATCH");
/* 2527 */   public static final Symbol SET_SYNTAX_FROM_CHAR = Lisp.PACKAGE_CL
/* 2528 */     .addExternalSymbol("SET-SYNTAX-FROM-CHAR");
/* 2529 */   public static final Symbol SETF = Lisp.PACKAGE_CL
/* 2530 */     .addExternalSymbol("SETF");
/* 2531 */   public static final Symbol SETQ = Lisp.PACKAGE_CL
/* 2532 */     .addExternalSymbol("SETQ");
/* 2533 */   public static final Symbol SEVENTH = Lisp.PACKAGE_CL
/* 2534 */     .addExternalSymbol("SEVENTH");
/* 2535 */   public static final Symbol SHADOW = Lisp.PACKAGE_CL
/* 2536 */     .addExternalSymbol("SHADOW");
/* 2537 */   public static final Symbol SHADOWING_IMPORT = Lisp.PACKAGE_CL
/* 2538 */     .addExternalSymbol("SHADOWING-IMPORT");
/* 2539 */   public static final Symbol SHARED_INITIALIZE = Lisp.PACKAGE_CL
/* 2540 */     .addExternalSymbol("SHARED-INITIALIZE");
/* 2541 */   public static final Symbol SHIFTF = Lisp.PACKAGE_CL
/* 2542 */     .addExternalSymbol("SHIFTF");
/* 2543 */   public static final Symbol SHORT_FLOAT = Lisp.PACKAGE_CL
/* 2544 */     .addExternalSymbol("SHORT-FLOAT");
/* 2545 */   public static final Symbol SHORT_FLOAT_EPSILON = Lisp.PACKAGE_CL
/* 2546 */     .addExternalSymbol("SHORT-FLOAT-EPSILON");
/* 2547 */   public static final Symbol SHORT_FLOAT_NEGATIVE_EPSILON = Lisp.PACKAGE_CL
/* 2548 */     .addExternalSymbol("SHORT-FLOAT-NEGATIVE-EPSILON");
/* 2549 */   public static final Symbol SHORT_SITE_NAME = Lisp.PACKAGE_CL
/* 2550 */     .addExternalSymbol("SHORT-SITE-NAME");
/* 2551 */   public static final Symbol SIGNAL = Lisp.PACKAGE_CL
/* 2552 */     .addExternalSymbol("SIGNAL");
/* 2553 */   public static final Symbol SIGNED_BYTE = Lisp.PACKAGE_CL
/* 2554 */     .addExternalSymbol("SIGNED-BYTE");
/* 2555 */   public static final Symbol SIGNUM = Lisp.PACKAGE_CL
/* 2556 */     .addExternalSymbol("SIGNUM");
/* 2557 */   public static final Symbol SIMPLE_ARRAY = Lisp.PACKAGE_CL
/* 2558 */     .addExternalSymbol("SIMPLE-ARRAY");
/* 2559 */   public static final Symbol SIMPLE_BASE_STRING = Lisp.PACKAGE_CL
/* 2560 */     .addExternalSymbol("SIMPLE-BASE-STRING");
/* 2561 */   public static final Symbol SIMPLE_BIT_VECTOR = Lisp.PACKAGE_CL
/* 2562 */     .addExternalSymbol("SIMPLE-BIT-VECTOR");
/* 2563 */   public static final Symbol SIMPLE_BIT_VECTOR_P = Lisp.PACKAGE_CL
/* 2564 */     .addExternalSymbol("SIMPLE-BIT-VECTOR-P");
/* 2565 */   public static final Symbol SIMPLE_CONDITION = Lisp.PACKAGE_CL
/* 2566 */     .addExternalSymbol("SIMPLE-CONDITION");
/* 2567 */   public static final Symbol SIMPLE_CONDITION_FORMAT_ARGUMENTS = Lisp.PACKAGE_CL
/* 2568 */     .addExternalSymbol("SIMPLE-CONDITION-FORMAT-ARGUMENTS");
/* 2569 */   public static final Symbol SIMPLE_CONDITION_FORMAT_CONTROL = Lisp.PACKAGE_CL
/* 2570 */     .addExternalSymbol("SIMPLE-CONDITION-FORMAT-CONTROL");
/* 2571 */   public static final Symbol SIMPLE_ERROR = Lisp.PACKAGE_CL
/* 2572 */     .addExternalSymbol("SIMPLE-ERROR");
/* 2573 */   public static final Symbol SIMPLE_STRING = Lisp.PACKAGE_CL
/* 2574 */     .addExternalSymbol("SIMPLE-STRING");
/* 2575 */   public static final Symbol SIMPLE_STRING_P = Lisp.PACKAGE_CL
/* 2576 */     .addExternalSymbol("SIMPLE-STRING-P");
/* 2577 */   public static final Symbol SIMPLE_TYPE_ERROR = Lisp.PACKAGE_CL
/* 2578 */     .addExternalSymbol("SIMPLE-TYPE-ERROR");
/* 2579 */   public static final Symbol SIMPLE_VECTOR = Lisp.PACKAGE_CL
/* 2580 */     .addExternalSymbol("SIMPLE-VECTOR");
/* 2581 */   public static final Symbol SIMPLE_VECTOR_P = Lisp.PACKAGE_CL
/* 2582 */     .addExternalSymbol("SIMPLE-VECTOR-P");
/* 2583 */   public static final Symbol SIMPLE_WARNING = Lisp.PACKAGE_CL
/* 2584 */     .addExternalSymbol("SIMPLE-WARNING");
/* 2585 */   public static final Symbol SIN = Lisp.PACKAGE_CL
/* 2586 */     .addExternalSymbol("SIN");
/* 2587 */   public static final Symbol SINGLE_FLOAT = Lisp.PACKAGE_CL
/* 2588 */     .addExternalSymbol("SINGLE-FLOAT");
/* 2589 */   public static final Symbol SINGLE_FLOAT_EPSILON = Lisp.PACKAGE_CL
/* 2590 */     .addExternalSymbol("SINGLE-FLOAT-EPSILON");
/* 2591 */   public static final Symbol SINGLE_FLOAT_NEGATIVE_EPSILON = Lisp.PACKAGE_CL
/* 2592 */     .addExternalSymbol("SINGLE-FLOAT-NEGATIVE-EPSILON");
/* 2593 */   public static final Symbol SINH = Lisp.PACKAGE_CL
/* 2594 */     .addExternalSymbol("SINH");
/* 2595 */   public static final Symbol SIXTH = Lisp.PACKAGE_CL
/* 2596 */     .addExternalSymbol("SIXTH");
/* 2597 */   public static final Symbol SLEEP = Lisp.PACKAGE_CL
/* 2598 */     .addExternalSymbol("SLEEP");
/* 2599 */   public static final Symbol SLOT_BOUNDP = Lisp.PACKAGE_CL
/* 2600 */     .addExternalSymbol("SLOT-BOUNDP");
/* 2601 */   public static final Symbol SLOT_EXISTS_P = Lisp.PACKAGE_CL
/* 2602 */     .addExternalSymbol("SLOT-EXISTS-P");
/* 2603 */   public static final Symbol SLOT_MAKUNBOUND = Lisp.PACKAGE_CL
/* 2604 */     .addExternalSymbol("SLOT-MAKUNBOUND");
/* 2605 */   public static final Symbol SLOT_MISSING = Lisp.PACKAGE_CL
/* 2606 */     .addExternalSymbol("SLOT-MISSING");
/* 2607 */   public static final Symbol SLOT_UNBOUND = Lisp.PACKAGE_CL
/* 2608 */     .addExternalSymbol("SLOT-UNBOUND");
/* 2609 */   public static final Symbol SLOT_VALUE = Lisp.PACKAGE_CL
/* 2610 */     .addExternalSymbol("SLOT-VALUE");
/* 2611 */   public static final Symbol SOFTWARE_TYPE = Lisp.PACKAGE_CL
/* 2612 */     .addExternalSymbol("SOFTWARE-TYPE");
/* 2613 */   public static final Symbol SOFTWARE_VERSION = Lisp.PACKAGE_CL
/* 2614 */     .addExternalSymbol("SOFTWARE-VERSION");
/* 2615 */   public static final Symbol SOME = Lisp.PACKAGE_CL
/* 2616 */     .addExternalSymbol("SOME");
/* 2617 */   public static final Symbol SORT = Lisp.PACKAGE_CL
/* 2618 */     .addExternalSymbol("SORT");
/* 2619 */   public static final Symbol SPACE = Lisp.PACKAGE_CL
/* 2620 */     .addExternalSymbol("SPACE");
/* 2621 */   public static final Symbol SPECIAL = Lisp.PACKAGE_CL
/* 2622 */     .addExternalSymbol("SPECIAL");
/* 2623 */   public static final Symbol SPECIAL_OPERATOR_P = Lisp.PACKAGE_CL
/* 2624 */     .addExternalSymbol("SPECIAL-OPERATOR-P");
/* 2625 */   public static final Symbol SPEED = Lisp.PACKAGE_CL
/* 2626 */     .addExternalSymbol("SPEED");
/* 2627 */   public static final Symbol SQRT = Lisp.PACKAGE_CL
/* 2628 */     .addExternalSymbol("SQRT");
/* 2629 */   public static final Symbol STABLE_SORT = Lisp.PACKAGE_CL
/* 2630 */     .addExternalSymbol("STABLE-SORT");
/* 2631 */   public static final Symbol STANDARD = Lisp.PACKAGE_CL
/* 2632 */     .addExternalSymbol("STANDARD");
/* 2633 */   public static final Symbol STANDARD_CHAR = Lisp.PACKAGE_CL
/* 2634 */     .addExternalSymbol("STANDARD-CHAR");
/* 2635 */   public static final Symbol STANDARD_CHAR_P = Lisp.PACKAGE_CL
/* 2636 */     .addExternalSymbol("STANDARD-CHAR-P");
/* 2637 */   public static final Symbol STANDARD_CLASS = Lisp.PACKAGE_CL
/* 2638 */     .addExternalSymbol("STANDARD-CLASS");
/* 2639 */   public static final Symbol STANDARD_GENERIC_FUNCTION = Lisp.PACKAGE_CL
/* 2640 */     .addExternalSymbol("STANDARD-GENERIC-FUNCTION");
/* 2641 */   public static final Symbol STANDARD_METHOD = Lisp.PACKAGE_CL
/* 2642 */     .addExternalSymbol("STANDARD-METHOD");
/* 2643 */   public static final Symbol STANDARD_OBJECT = Lisp.PACKAGE_CL
/* 2644 */     .addExternalSymbol("STANDARD-OBJECT");
/* 2645 */   public static final Symbol STEP = Lisp.PACKAGE_CL
/* 2646 */     .addExternalSymbol("STEP");
/* 2647 */   public static final Symbol STORAGE_CONDITION = Lisp.PACKAGE_CL
/* 2648 */     .addExternalSymbol("STORAGE-CONDITION");
/* 2649 */   public static final Symbol STORE_VALUE = Lisp.PACKAGE_CL
/* 2650 */     .addExternalSymbol("STORE-VALUE");
/* 2651 */   public static final Symbol STREAM = Lisp.PACKAGE_CL
/* 2652 */     .addExternalSymbol("STREAM");
/* 2653 */   public static final Symbol STREAM_ELEMENT_TYPE = Lisp.PACKAGE_CL
/* 2654 */     .addExternalSymbol("STREAM-ELEMENT-TYPE");
/* 2655 */   public static final Symbol STREAM_ERROR = Lisp.PACKAGE_CL
/* 2656 */     .addExternalSymbol("STREAM-ERROR");
/* 2657 */   public static final Symbol STREAM_ERROR_STREAM = Lisp.PACKAGE_CL
/* 2658 */     .addExternalSymbol("STREAM-ERROR-STREAM");
/* 2659 */   public static final Symbol STREAM_EXTERNAL_FORMAT = Lisp.PACKAGE_CL
/* 2660 */     .addExternalSymbol("STREAM-EXTERNAL-FORMAT");
/* 2661 */   public static final Symbol STREAMP = Lisp.PACKAGE_CL
/* 2662 */     .addExternalSymbol("STREAMP");
/* 2663 */   public static final Symbol STRING = Lisp.PACKAGE_CL
/* 2664 */     .addExternalSymbol("STRING");
/* 2665 */   public static final Symbol STRING_CAPITALIZE = Lisp.PACKAGE_CL
/* 2666 */     .addExternalSymbol("STRING-CAPITALIZE");
/* 2667 */   public static final Symbol STRING_DOWNCASE = Lisp.PACKAGE_CL
/* 2668 */     .addExternalSymbol("STRING-DOWNCASE");
/* 2669 */   public static final Symbol STRING_EQUAL = Lisp.PACKAGE_CL
/* 2670 */     .addExternalSymbol("STRING-EQUAL");
/* 2671 */   public static final Symbol STRING_GREATERP = Lisp.PACKAGE_CL
/* 2672 */     .addExternalSymbol("STRING-GREATERP");
/* 2673 */   public static final Symbol STRING_LEFT_TRIM = Lisp.PACKAGE_CL
/* 2674 */     .addExternalSymbol("STRING-LEFT-TRIM");
/* 2675 */   public static final Symbol STRING_LESSP = Lisp.PACKAGE_CL
/* 2676 */     .addExternalSymbol("STRING-LESSP");
/* 2677 */   public static final Symbol STRING_NOT_EQUAL = Lisp.PACKAGE_CL
/* 2678 */     .addExternalSymbol("STRING-NOT-EQUAL");
/* 2679 */   public static final Symbol STRING_NOT_GREATERP = Lisp.PACKAGE_CL
/* 2680 */     .addExternalSymbol("STRING-NOT-GREATERP");
/* 2681 */   public static final Symbol STRING_NOT_LESSP = Lisp.PACKAGE_CL
/* 2682 */     .addExternalSymbol("STRING-NOT-LESSP");
/* 2683 */   public static final Symbol STRING_RIGHT_TRIM = Lisp.PACKAGE_CL
/* 2684 */     .addExternalSymbol("STRING-RIGHT-TRIM");
/* 2685 */   public static final Symbol STRING_STREAM = Lisp.PACKAGE_CL
/* 2686 */     .addExternalSymbol("STRING-STREAM");
/* 2687 */   public static final Symbol STRING_TRIM = Lisp.PACKAGE_CL
/* 2688 */     .addExternalSymbol("STRING-TRIM");
/* 2689 */   public static final Symbol STRING_UPCASE = Lisp.PACKAGE_CL
/* 2690 */     .addExternalSymbol("STRING-UPCASE");
/* 2691 */   public static final Symbol STRING_NE = Lisp.PACKAGE_CL
/* 2692 */     .addExternalSymbol("STRING/=");
/* 2693 */   public static final Symbol STRING_LT = Lisp.PACKAGE_CL
/* 2694 */     .addExternalSymbol("STRING<");
/* 2695 */   public static final Symbol STRING_LE = Lisp.PACKAGE_CL
/* 2696 */     .addExternalSymbol("STRING<=");
/* 2697 */   public static final Symbol STRING_EQUALS = Lisp.PACKAGE_CL
/* 2698 */     .addExternalSymbol("STRING=");
/* 2699 */   public static final Symbol STRING_GT = Lisp.PACKAGE_CL
/* 2700 */     .addExternalSymbol("STRING>");
/* 2701 */   public static final Symbol STRING_GE = Lisp.PACKAGE_CL
/* 2702 */     .addExternalSymbol("STRING>=");
/* 2703 */   public static final Symbol STRINGP = Lisp.PACKAGE_CL
/* 2704 */     .addExternalSymbol("STRINGP");
/* 2705 */   public static final Symbol STRUCTURE = Lisp.PACKAGE_CL
/* 2706 */     .addExternalSymbol("STRUCTURE");
/* 2707 */   public static final Symbol STRUCTURE_CLASS = Lisp.PACKAGE_CL
/* 2708 */     .addExternalSymbol("STRUCTURE-CLASS");
/* 2709 */   public static final Symbol STRUCTURE_OBJECT = Lisp.PACKAGE_CL
/* 2710 */     .addExternalSymbol("STRUCTURE-OBJECT");
/* 2711 */   public static final Symbol STYLE_WARNING = Lisp.PACKAGE_CL
/* 2712 */     .addExternalSymbol("STYLE-WARNING");
/* 2713 */   public static final Symbol SUBLIS = Lisp.PACKAGE_CL
/* 2714 */     .addExternalSymbol("SUBLIS");
/* 2715 */   public static final Symbol SUBSEQ = Lisp.PACKAGE_CL
/* 2716 */     .addExternalSymbol("SUBSEQ");
/* 2717 */   public static final Symbol SUBSETP = Lisp.PACKAGE_CL
/* 2718 */     .addExternalSymbol("SUBSETP");
/* 2719 */   public static final Symbol SUBST = Lisp.PACKAGE_CL
/* 2720 */     .addExternalSymbol("SUBST");
/* 2721 */   public static final Symbol SUBST_IF = Lisp.PACKAGE_CL
/* 2722 */     .addExternalSymbol("SUBST-IF");
/* 2723 */   public static final Symbol SUBST_IF_NOT = Lisp.PACKAGE_CL
/* 2724 */     .addExternalSymbol("SUBST-IF-NOT");
/* 2725 */   public static final Symbol SUBSTITUTE = Lisp.PACKAGE_CL
/* 2726 */     .addExternalSymbol("SUBSTITUTE");
/* 2727 */   public static final Symbol SUBSTITUTE_IF = Lisp.PACKAGE_CL
/* 2728 */     .addExternalSymbol("SUBSTITUTE-IF");
/* 2729 */   public static final Symbol SUBSTITUTE_IF_NOT = Lisp.PACKAGE_CL
/* 2730 */     .addExternalSymbol("SUBSTITUTE-IF-NOT");
/* 2731 */   public static final Symbol SUBTYPEP = Lisp.PACKAGE_CL
/* 2732 */     .addExternalSymbol("SUBTYPEP");
/* 2733 */   public static final Symbol SVREF = Lisp.PACKAGE_CL
/* 2734 */     .addExternalSymbol("SVREF");
/* 2735 */   public static final Symbol SXHASH = Lisp.PACKAGE_CL
/* 2736 */     .addExternalSymbol("SXHASH");
/* 2737 */   public static final Symbol SYMBOL = Lisp.PACKAGE_CL
/* 2738 */     .addExternalSymbol("SYMBOL");
/* 2739 */   public static final Symbol SYMBOL_FUNCTION = Lisp.PACKAGE_CL
/* 2740 */     .addExternalSymbol("SYMBOL-FUNCTION");
/* 2741 */   public static final Symbol SYMBOL_MACROLET = Lisp.PACKAGE_CL
/* 2742 */     .addExternalSymbol("SYMBOL-MACROLET");
/* 2743 */   public static final Symbol SYMBOL_NAME = Lisp.PACKAGE_CL
/* 2744 */     .addExternalSymbol("SYMBOL-NAME");
/* 2745 */   public static final Symbol SYMBOL_PACKAGE = Lisp.PACKAGE_CL
/* 2746 */     .addExternalSymbol("SYMBOL-PACKAGE");
/* 2747 */   public static final Symbol SYMBOL_PLIST = Lisp.PACKAGE_CL
/* 2748 */     .addExternalSymbol("SYMBOL-PLIST");
/* 2749 */   public static final Symbol SYMBOL_VALUE = Lisp.PACKAGE_CL
/* 2750 */     .addExternalSymbol("SYMBOL-VALUE");
/* 2751 */   public static final Symbol SYMBOLP = Lisp.PACKAGE_CL
/* 2752 */     .addExternalSymbol("SYMBOLP");
/* 2753 */   public static final Symbol SYNONYM_STREAM = Lisp.PACKAGE_CL
/* 2754 */     .addExternalSymbol("SYNONYM-STREAM");
/* 2755 */   public static final Symbol SYNONYM_STREAM_SYMBOL = Lisp.PACKAGE_CL
/* 2756 */     .addExternalSymbol("SYNONYM-STREAM-SYMBOL");
/* 2757 */   public static final Symbol T = Lisp.PACKAGE_CL
/* 2758 */     .addExternalSymbol("T");
/* 2759 */   public static final Symbol TAGBODY = Lisp.PACKAGE_CL
/* 2760 */     .addExternalSymbol("TAGBODY");
/* 2761 */   public static final Symbol TAILP = Lisp.PACKAGE_CL
/* 2762 */     .addExternalSymbol("TAILP");
/* 2763 */   public static final Symbol TAN = Lisp.PACKAGE_CL
/* 2764 */     .addExternalSymbol("TAN");
/* 2765 */   public static final Symbol TANH = Lisp.PACKAGE_CL
/* 2766 */     .addExternalSymbol("TANH");
/* 2767 */   public static final Symbol TENTH = Lisp.PACKAGE_CL
/* 2768 */     .addExternalSymbol("TENTH");
/* 2769 */   public static final Symbol TERPRI = Lisp.PACKAGE_CL
/* 2770 */     .addExternalSymbol("TERPRI");
/* 2771 */   public static final Symbol THE = Lisp.PACKAGE_CL
/* 2772 */     .addExternalSymbol("THE");
/* 2773 */   public static final Symbol THIRD = Lisp.PACKAGE_CL
/* 2774 */     .addExternalSymbol("THIRD");
/* 2775 */   public static final Symbol THROW = Lisp.PACKAGE_CL
/* 2776 */     .addExternalSymbol("THROW");
/* 2777 */   public static final Symbol TIME = Lisp.PACKAGE_CL
/* 2778 */     .addExternalSymbol("TIME");
/* 2779 */   public static final Symbol TRACE = Lisp.PACKAGE_CL
/* 2780 */     .addExternalSymbol("TRACE");
/* 2781 */   public static final Symbol TRANSLATE_LOGICAL_PATHNAME = Lisp.PACKAGE_CL
/* 2782 */     .addExternalSymbol("TRANSLATE-LOGICAL-PATHNAME");
/* 2783 */   public static final Symbol TRANSLATE_PATHNAME = Lisp.PACKAGE_CL
/* 2784 */     .addExternalSymbol("TRANSLATE-PATHNAME");
/* 2785 */   public static final Symbol TREE_EQUAL = Lisp.PACKAGE_CL
/* 2786 */     .addExternalSymbol("TREE-EQUAL");
/* 2787 */   public static final Symbol TRUENAME = Lisp.PACKAGE_CL
/* 2788 */     .addExternalSymbol("TRUENAME");
/* 2789 */   public static final Symbol TRUNCATE = Lisp.PACKAGE_CL
/* 2790 */     .addExternalSymbol("TRUNCATE");
/* 2791 */   public static final Symbol TWO_WAY_STREAM = Lisp.PACKAGE_CL
/* 2792 */     .addExternalSymbol("TWO-WAY-STREAM");
/* 2793 */   public static final Symbol TWO_WAY_STREAM_INPUT_STREAM = Lisp.PACKAGE_CL
/* 2794 */     .addExternalSymbol("TWO-WAY-STREAM-INPUT-STREAM");
/* 2795 */   public static final Symbol TWO_WAY_STREAM_OUTPUT_STREAM = Lisp.PACKAGE_CL
/* 2796 */     .addExternalSymbol("TWO-WAY-STREAM-OUTPUT-STREAM");
/* 2797 */   public static final Symbol TYPE = Lisp.PACKAGE_CL
/* 2798 */     .addExternalSymbol("TYPE");
/* 2799 */   public static final Symbol TYPE_ERROR = Lisp.PACKAGE_CL
/* 2800 */     .addExternalSymbol("TYPE-ERROR");
/* 2801 */   public static final Symbol TYPE_ERROR_DATUM = Lisp.PACKAGE_CL
/* 2802 */     .addExternalSymbol("TYPE-ERROR-DATUM");
/* 2803 */   public static final Symbol TYPE_ERROR_EXPECTED_TYPE = Lisp.PACKAGE_CL
/* 2804 */     .addExternalSymbol("TYPE-ERROR-EXPECTED-TYPE");
/* 2805 */   public static final Symbol TYPE_OF = Lisp.PACKAGE_CL
/* 2806 */     .addExternalSymbol("TYPE-OF");
/* 2807 */   public static final Symbol TYPECASE = Lisp.PACKAGE_CL
/* 2808 */     .addExternalSymbol("TYPECASE");
/* 2809 */   public static final Symbol TYPEP = Lisp.PACKAGE_CL
/* 2810 */     .addExternalSymbol("TYPEP");
/* 2811 */   public static final Symbol UNBOUND_SLOT = Lisp.PACKAGE_CL
/* 2812 */     .addExternalSymbol("UNBOUND-SLOT");
/* 2813 */   public static final Symbol UNBOUND_SLOT_INSTANCE = Lisp.PACKAGE_CL
/* 2814 */     .addExternalSymbol("UNBOUND-SLOT-INSTANCE");
/* 2815 */   public static final Symbol UNBOUND_VARIABLE = Lisp.PACKAGE_CL
/* 2816 */     .addExternalSymbol("UNBOUND-VARIABLE");
/* 2817 */   public static final Symbol UNDEFINED_FUNCTION = Lisp.PACKAGE_CL
/* 2818 */     .addExternalSymbol("UNDEFINED-FUNCTION");
/* 2819 */   public static final Symbol UNEXPORT = Lisp.PACKAGE_CL
/* 2820 */     .addExternalSymbol("UNEXPORT");
/* 2821 */   public static final Symbol UNINTERN = Lisp.PACKAGE_CL
/* 2822 */     .addExternalSymbol("UNINTERN");
/* 2823 */   public static final Symbol UNION = Lisp.PACKAGE_CL
/* 2824 */     .addExternalSymbol("UNION");
/* 2825 */   public static final Symbol UNLESS = Lisp.PACKAGE_CL
/* 2826 */     .addExternalSymbol("UNLESS");
/* 2827 */   public static final Symbol UNREAD_CHAR = Lisp.PACKAGE_CL
/* 2828 */     .addExternalSymbol("UNREAD-CHAR");
/* 2829 */   public static final Symbol UNSIGNED_BYTE = Lisp.PACKAGE_CL
/* 2830 */     .addExternalSymbol("UNSIGNED-BYTE");
/* 2831 */   public static final Symbol UNTRACE = Lisp.PACKAGE_CL
/* 2832 */     .addExternalSymbol("UNTRACE");
/* 2833 */   public static final Symbol UNUSE_PACKAGE = Lisp.PACKAGE_CL
/* 2834 */     .addExternalSymbol("UNUSE-PACKAGE");
/* 2835 */   public static final Symbol UNWIND_PROTECT = Lisp.PACKAGE_CL
/* 2836 */     .addExternalSymbol("UNWIND-PROTECT");
/* 2837 */   public static final Symbol UPDATE_INSTANCE_FOR_DIFFERENT_CLASS = Lisp.PACKAGE_CL
/* 2838 */     .addExternalSymbol("UPDATE-INSTANCE-FOR-DIFFERENT-CLASS");
/* 2839 */   public static final Symbol UPDATE_INSTANCE_FOR_REDEFINED_CLASS = Lisp.PACKAGE_CL
/* 2840 */     .addExternalSymbol("UPDATE-INSTANCE-FOR-REDEFINED-CLASS");
/* 2841 */   public static final Symbol UPGRADED_ARRAY_ELEMENT_TYPE = Lisp.PACKAGE_CL
/* 2842 */     .addExternalSymbol("UPGRADED-ARRAY-ELEMENT-TYPE");
/* 2843 */   public static final Symbol UPGRADED_COMPLEX_PART_TYPE = Lisp.PACKAGE_CL
/* 2844 */     .addExternalSymbol("UPGRADED-COMPLEX-PART-TYPE");
/* 2845 */   public static final Symbol UPPER_CASE_P = Lisp.PACKAGE_CL
/* 2846 */     .addExternalSymbol("UPPER-CASE-P");
/* 2847 */   public static final Symbol USE_PACKAGE = Lisp.PACKAGE_CL
/* 2848 */     .addExternalSymbol("USE-PACKAGE");
/* 2849 */   public static final Symbol USE_VALUE = Lisp.PACKAGE_CL
/* 2850 */     .addExternalSymbol("USE-VALUE");
/* 2851 */   public static final Symbol USER_HOMEDIR_PATHNAME = Lisp.PACKAGE_CL
/* 2852 */     .addExternalSymbol("USER-HOMEDIR-PATHNAME");
/* 2853 */   public static final Symbol VALUES = Lisp.PACKAGE_CL
/* 2854 */     .addExternalSymbol("VALUES");
/* 2855 */   public static final Symbol VALUES_LIST = Lisp.PACKAGE_CL
/* 2856 */     .addExternalSymbol("VALUES-LIST");
/* 2857 */   public static final Symbol VARIABLE = Lisp.PACKAGE_CL
/* 2858 */     .addExternalSymbol("VARIABLE");
/* 2859 */   public static final Symbol VECTOR = Lisp.PACKAGE_CL
/* 2860 */     .addExternalSymbol("VECTOR");
/* 2861 */   public static final Symbol VECTOR_POP = Lisp.PACKAGE_CL
/* 2862 */     .addExternalSymbol("VECTOR-POP");
/* 2863 */   public static final Symbol VECTOR_PUSH = Lisp.PACKAGE_CL
/* 2864 */     .addExternalSymbol("VECTOR-PUSH");
/* 2865 */   public static final Symbol VECTOR_PUSH_EXTEND = Lisp.PACKAGE_CL
/* 2866 */     .addExternalSymbol("VECTOR-PUSH-EXTEND");
/* 2867 */   public static final Symbol VECTORP = Lisp.PACKAGE_CL
/* 2868 */     .addExternalSymbol("VECTORP");
/* 2869 */   public static final Symbol WARN = Lisp.PACKAGE_CL
/* 2870 */     .addExternalSymbol("WARN");
/* 2871 */   public static final Symbol WARNING = Lisp.PACKAGE_CL
/* 2872 */     .addExternalSymbol("WARNING");
/* 2873 */   public static final Symbol WHEN = Lisp.PACKAGE_CL
/* 2874 */     .addExternalSymbol("WHEN");
/* 2875 */   public static final Symbol WILD_PATHNAME_P = Lisp.PACKAGE_CL
/* 2876 */     .addExternalSymbol("WILD-PATHNAME-P");
/* 2877 */   public static final Symbol WITH_ACCESSORS = Lisp.PACKAGE_CL
/* 2878 */     .addExternalSymbol("WITH-ACCESSORS");
/* 2879 */   public static final Symbol WITH_COMPILATION_UNIT = Lisp.PACKAGE_CL
/* 2880 */     .addExternalSymbol("WITH-COMPILATION-UNIT");
/* 2881 */   public static final Symbol WITH_CONDITION_RESTARTS = Lisp.PACKAGE_CL
/* 2882 */     .addExternalSymbol("WITH-CONDITION-RESTARTS");
/* 2883 */   public static final Symbol WITH_HASH_TABLE_ITERATOR = Lisp.PACKAGE_CL
/* 2884 */     .addExternalSymbol("WITH-HASH-TABLE-ITERATOR");
/* 2885 */   public static final Symbol WITH_INPUT_FROM_STRING = Lisp.PACKAGE_CL
/* 2886 */     .addExternalSymbol("WITH-INPUT-FROM-STRING");
/* 2887 */   public static final Symbol WITH_OPEN_FILE = Lisp.PACKAGE_CL
/* 2888 */     .addExternalSymbol("WITH-OPEN-FILE");
/* 2889 */   public static final Symbol WITH_OPEN_STREAM = Lisp.PACKAGE_CL
/* 2890 */     .addExternalSymbol("WITH-OPEN-STREAM");
/* 2891 */   public static final Symbol WITH_OUTPUT_TO_STRING = Lisp.PACKAGE_CL
/* 2892 */     .addExternalSymbol("WITH-OUTPUT-TO-STRING");
/* 2893 */   public static final Symbol WITH_PACKAGE_ITERATOR = Lisp.PACKAGE_CL
/* 2894 */     .addExternalSymbol("WITH-PACKAGE-ITERATOR");
/* 2895 */   public static final Symbol WITH_SIMPLE_RESTART = Lisp.PACKAGE_CL
/* 2896 */     .addExternalSymbol("WITH-SIMPLE-RESTART");
/* 2897 */   public static final Symbol WITH_SLOTS = Lisp.PACKAGE_CL
/* 2898 */     .addExternalSymbol("WITH-SLOTS");
/* 2899 */   public static final Symbol WITH_STANDARD_IO_SYNTAX = Lisp.PACKAGE_CL
/* 2900 */     .addExternalSymbol("WITH-STANDARD-IO-SYNTAX");
/* 2901 */   public static final Symbol WRITE = Lisp.PACKAGE_CL
/* 2902 */     .addExternalSymbol("WRITE");
/* 2903 */   public static final Symbol WRITE_BYTE = Lisp.PACKAGE_CL
/* 2904 */     .addExternalSymbol("WRITE-BYTE");
/* 2905 */   public static final Symbol WRITE_CHAR = Lisp.PACKAGE_CL
/* 2906 */     .addExternalSymbol("WRITE-CHAR");
/* 2907 */   public static final Symbol WRITE_LINE = Lisp.PACKAGE_CL
/* 2908 */     .addExternalSymbol("WRITE-LINE");
/* 2909 */   public static final Symbol WRITE_SEQUENCE = Lisp.PACKAGE_CL
/* 2910 */     .addExternalSymbol("WRITE-SEQUENCE");
/* 2911 */   public static final Symbol WRITE_STRING = Lisp.PACKAGE_CL
/* 2912 */     .addExternalSymbol("WRITE-STRING");
/* 2913 */   public static final Symbol WRITE_TO_STRING = Lisp.PACKAGE_CL
/* 2914 */     .addExternalSymbol("WRITE-TO-STRING");
/* 2915 */   public static final Symbol Y_OR_N_P = Lisp.PACKAGE_CL
/* 2916 */     .addExternalSymbol("Y-OR-N-P");
/* 2917 */   public static final Symbol YES_OR_NO_P = Lisp.PACKAGE_CL
/* 2918 */     .addExternalSymbol("YES-OR-NO-P");
/* 2919 */   public static final Symbol ZEROP = Lisp.PACKAGE_CL
/* 2920 */     .addExternalSymbol("ZEROP");
/*      */ 
/*      */ 
/*      */   
/* 2924 */   public static final Symbol MOST_POSITIVE_JAVA_LONG = Lisp.PACKAGE_EXT
/* 2925 */     .addExternalSymbol("MOST-POSITIVE-JAVA-LONG");
/* 2926 */   public static final Symbol MOST_NEGATIVE_JAVA_LONG = Lisp.PACKAGE_EXT
/* 2927 */     .addExternalSymbol("MOST-NEGATIVE-JAVA-LONG");
/* 2928 */   public static final Symbol SINGLE_FLOAT_POSITIVE_INFINITY = Lisp.PACKAGE_EXT
/* 2929 */     .addExternalSymbol("SINGLE-FLOAT-POSITIVE-INFINITY");
/* 2930 */   public static final Symbol SINGLE_FLOAT_NEGATIVE_INFINITY = Lisp.PACKAGE_EXT
/* 2931 */     .addExternalSymbol("SINGLE-FLOAT-NEGATIVE-INFINITY");
/* 2932 */   public static final Symbol DOUBLE_FLOAT_POSITIVE_INFINITY = Lisp.PACKAGE_EXT
/* 2933 */     .addExternalSymbol("DOUBLE-FLOAT-POSITIVE-INFINITY");
/* 2934 */   public static final Symbol DOUBLE_FLOAT_NEGATIVE_INFINITY = Lisp.PACKAGE_EXT
/* 2935 */     .addExternalSymbol("DOUBLE-FLOAT-NEGATIVE-INFINITY");
/* 2936 */   public static final Symbol STYLE_WARN = Lisp.PACKAGE_EXT
/* 2937 */     .addExternalSymbol("STYLE-WARN");
/* 2938 */   public static final Symbol MEMQ = Lisp.PACKAGE_EXT
/* 2939 */     .addExternalSymbol("MEMQ");
/* 2940 */   public static final Symbol MEMQL = Lisp.PACKAGE_EXT
/* 2941 */     .addExternalSymbol("MEMQL");
/* 2942 */   public static final Symbol NIL_VECTOR = Lisp.PACKAGE_EXT
/* 2943 */     .addExternalSymbol("NIL-VECTOR");
/* 2944 */   public static final Symbol MAILBOX = Lisp.PACKAGE_EXT
/* 2945 */     .addExternalSymbol("MAILBOX");
/* 2946 */   public static final Symbol MUTEX = Lisp.PACKAGE_EXT
/* 2947 */     .addExternalSymbol("MUTEX");
/* 2948 */   public static final Symbol SUPPRESS_COMPILER_WARNINGS = Lisp.PACKAGE_EXT
/* 2949 */     .addExternalSymbol("*SUPPRESS-COMPILER-WARNINGS*");
/* 2950 */   public static final Symbol NEQ = Lisp.PACKAGE_EXT
/* 2951 */     .addExternalSymbol("NEQ");
/* 2952 */   public static final Symbol ADJOIN_EQL = Lisp.PACKAGE_EXT
/* 2953 */     .addExternalSymbol("ADJOIN-EQL");
/* 2954 */   public static final Symbol CHARACTER_DESIGNATOR = Lisp.PACKAGE_EXT
/* 2955 */     .addExternalSymbol("CHARACTER-DESIGNATOR");
/* 2956 */   public static final Symbol INTERRUPT_LISP = Lisp.PACKAGE_EXT
/* 2957 */     .addExternalSymbol("INTERRUPT-LISP");
/* 2958 */   public static final Symbol GETENV = Lisp.PACKAGE_EXT
/* 2959 */     .addExternalSymbol("GETENV");
/* 2960 */   public static final Symbol MACROEXPAND_ALL = Lisp.PACKAGE_EXT
/* 2961 */     .addExternalSymbol("MACROEXPAND-ALL");
/* 2962 */   public static final Symbol LOAD_TRUENAME_FASL = Lisp.PACKAGE_EXT
/* 2963 */     .addExternalSymbol("*LOAD-TRUENAME-FASL*");
/* 2964 */   public static final Symbol SLIME_INPUT_STREAM = Lisp.PACKAGE_EXT
/* 2965 */     .addExternalSymbol("SLIME-INPUT-STREAM");
/* 2966 */   public static final Symbol SLIME_OUTPUT_STREAM = Lisp.PACKAGE_EXT
/* 2967 */     .addExternalSymbol("SLIME-OUTPUT-STREAM");
/* 2968 */   public static final Symbol JAR_PATHNAME = Lisp.PACKAGE_EXT
/* 2969 */     .addExternalSymbol("JAR-PATHNAME");
/* 2970 */   public static final Symbol URL_PATHNAME = Lisp.PACKAGE_EXT
/* 2971 */     .addExternalSymbol("URL-PATHNAME");
/* 2972 */   public static final Symbol WEAK_REFERENCE = Lisp.PACKAGE_EXT
/* 2973 */     .addExternalSymbol("WEAK-REFERENCE");
/* 2974 */   public static final Symbol ADD_PACKAGE_LOCAL_NICKNAME = Lisp.PACKAGE_EXT
/* 2975 */     .addExternalSymbol("ADD-PACKAGE-LOCAL-NICKNAME");
/*      */ 
/*      */   
/* 2978 */   public static final Symbol CLASS_LAYOUT = Lisp.PACKAGE_MOP
/* 2979 */     .addInternalSymbol("CLASS-LAYOUT");
/* 2980 */   public static final Symbol CLASS_DEFAULT_INITARGS = Lisp.PACKAGE_MOP
/* 2981 */     .addExternalSymbol("CLASS-DEFAULT_INITARGS");
/* 2982 */   public static final Symbol CLASS_DIRECT_METHODS = Lisp.PACKAGE_MOP
/* 2983 */     .addExternalSymbol("CLASS-DIRECT-METHODS");
/* 2984 */   public static final Symbol CLASS_DIRECT_DEFAULT_INITARGS = Lisp.PACKAGE_MOP
/* 2985 */     .addExternalSymbol("CLASS-DIRECT-DEFAULT_INITARGS");
/* 2986 */   public static final Symbol CLASS_DIRECT_SLOTS = Lisp.PACKAGE_MOP
/* 2987 */     .addExternalSymbol("CLASS-DIRECT-SLOTS");
/* 2988 */   public static final Symbol CLASS_DIRECT_SUBCLASSES = Lisp.PACKAGE_MOP
/* 2989 */     .addExternalSymbol("CLASS-DIRECT-SUBCLASSES");
/* 2990 */   public static final Symbol CLASS_DIRECT_SUPERCLASSES = Lisp.PACKAGE_MOP
/* 2991 */     .addExternalSymbol("CLASS-DIRECT-SUPERCLASSES");
/* 2992 */   public static final Symbol CLASS_DOCUMENTATION = Lisp.PACKAGE_MOP
/* 2993 */     .addExternalSymbol("CLASS-DOCUMENTATION");
/* 2994 */   public static final Symbol CLASS_FINALIZED_P = Lisp.PACKAGE_MOP
/* 2995 */     .addExternalSymbol("CLASS-FINALIZED-P");
/* 2996 */   public static final Symbol CLASS_PRECEDENCE_LIST = Lisp.PACKAGE_MOP
/* 2997 */     .addExternalSymbol("CLASS-PRECEDENCE-LIST");
/* 2998 */   public static final Symbol CLASS_SLOTS = Lisp.PACKAGE_MOP
/* 2999 */     .addExternalSymbol("CLASS-SLOTS");
/* 3000 */   public static final Symbol EQL_SPECIALIZER = Lisp.PACKAGE_MOP
/* 3001 */     .addExternalSymbol("EQL-SPECIALIZER");
/* 3002 */   public static final Symbol EQL_SPECIALIZER_OBJECT = Lisp.PACKAGE_MOP
/* 3003 */     .addExternalSymbol("EQL-SPECIALIZER-OBJECT");
/* 3004 */   public static final Symbol FUNCALLABLE_STANDARD_OBJECT = Lisp.PACKAGE_MOP
/* 3005 */     .addExternalSymbol("FUNCALLABLE-STANDARD-OBJECT");
/* 3006 */   public static final Symbol FUNCALLABLE_STANDARD_CLASS = Lisp.PACKAGE_MOP
/* 3007 */     .addExternalSymbol("FUNCALLABLE-STANDARD-CLASS");
/* 3008 */   public static final Symbol GENERIC_FUNCTION_METHODS = Lisp.PACKAGE_MOP
/* 3009 */     .addExternalSymbol("GENERIC-FUNCTION-METHODS");
/* 3010 */   public static final Symbol GENERIC_FUNCTION_NAME = Lisp.PACKAGE_MOP
/* 3011 */     .addExternalSymbol("GENERIC-FUNCTION-NAME");
/* 3012 */   public static final Symbol METAOBJECT = Lisp.PACKAGE_MOP
/* 3013 */     .addExternalSymbol("METAOBJECT");
/* 3014 */   public static final Symbol METHOD_FUNCTION = Lisp.PACKAGE_MOP
/* 3015 */     .addExternalSymbol("METHOD-FUNCTION");
/* 3016 */   public static final Symbol SPECIALIZER = Lisp.PACKAGE_MOP
/* 3017 */     .addExternalSymbol("SPECIALIZER");
/* 3018 */   public static final Symbol STANDARD_ACCESSOR_METHOD = Lisp.PACKAGE_MOP
/* 3019 */     .addExternalSymbol("STANDARD-ACCESSOR-METHOD");
/* 3020 */   public static final Symbol STANDARD_READER_METHOD = Lisp.PACKAGE_MOP
/* 3021 */     .addExternalSymbol("STANDARD-READER-METHOD");
/* 3022 */   public static final Symbol STANDARD_WRITER_METHOD = Lisp.PACKAGE_MOP
/* 3023 */     .addExternalSymbol("STANDARD-WRITER-METHOD");
/* 3024 */   public static final Symbol DIRECT_SLOT_DEFINITION = Lisp.PACKAGE_MOP
/* 3025 */     .addExternalSymbol("DIRECT-SLOT-DEFINITION");
/* 3026 */   public static final Symbol EFFECTIVE_SLOT_DEFINITION = Lisp.PACKAGE_MOP
/* 3027 */     .addExternalSymbol("EFFECTIVE-SLOT-DEFINITION");
/* 3028 */   public static final Symbol STANDARD_SLOT_DEFINITION = Lisp.PACKAGE_MOP
/* 3029 */     .addExternalSymbol("STANDARD-SLOT-DEFINITION");
/* 3030 */   public static final Symbol STANDARD_DIRECT_SLOT_DEFINITION = Lisp.PACKAGE_MOP
/* 3031 */     .addExternalSymbol("STANDARD-DIRECT-SLOT-DEFINITION");
/* 3032 */   public static final Symbol STANDARD_EFFECTIVE_SLOT_DEFINITION = Lisp.PACKAGE_MOP
/* 3033 */     .addExternalSymbol("STANDARD-EFFECTIVE-SLOT-DEFINITION");
/*      */   
/* 3035 */   public static final Symbol METHOD_COMBINATION_NAME = Lisp.PACKAGE_MOP
/* 3036 */     .addInternalSymbol("METHOD-COMBINATION-NAME");
/* 3037 */   public static final Symbol METHOD_COMBINATION_DOCUMENTATION = Lisp.PACKAGE_MOP
/* 3038 */     .addInternalSymbol("METHOD-COMBINATION-DOCUMENTATION");
/*      */ 
/*      */   
/* 3041 */   public static final Symbol JAVA_EXCEPTION = Lisp.PACKAGE_JAVA
/* 3042 */     .addExternalSymbol("JAVA-EXCEPTION");
/* 3043 */   public static final Symbol JAVA_EXCEPTION_CAUSE = Lisp.PACKAGE_JAVA
/* 3044 */     .addExternalSymbol("JAVA-EXCEPTION-CAUSE");
/* 3045 */   public static final Symbol JAVA_OBJECT = Lisp.PACKAGE_JAVA
/* 3046 */     .addExternalSymbol("JAVA-OBJECT");
/* 3047 */   public static final Symbol JAVA_CLASS = Lisp.PACKAGE_JAVA
/* 3048 */     .addExternalSymbol("JAVA-CLASS");
/* 3049 */   public static final Symbol JCALL = Lisp.PACKAGE_JAVA
/* 3050 */     .addExternalSymbol("JCALL");
/* 3051 */   public static final Symbol JCALL_RAW = Lisp.PACKAGE_JAVA
/* 3052 */     .addExternalSymbol("JCALL-RAW");
/* 3053 */   public static final Symbol JCLASS = Lisp.PACKAGE_JAVA
/* 3054 */     .addExternalSymbol("JCLASS");
/* 3055 */   public static final Symbol JCLASS_NAME = Lisp.PACKAGE_JAVA
/* 3056 */     .addExternalSymbol("JCLASS-NAME");
/* 3057 */   public static final Symbol JCLASS_OF = Lisp.PACKAGE_JAVA
/* 3058 */     .addExternalSymbol("JCLASS-OF");
/* 3059 */   public static final Symbol JINPUT_STREAM = Lisp.PACKAGE_JAVA
/* 3060 */     .addExternalSymbol("JINPUT-STREAM");
/* 3061 */   public static final Symbol JMETHOD_RETURN_TYPE = Lisp.PACKAGE_JAVA
/* 3062 */     .addExternalSymbol("JMETHOD-RETURN-TYPE");
/* 3063 */   public static final Symbol JRESOLVE_METHOD = Lisp.PACKAGE_JAVA
/* 3064 */     .addExternalSymbol("JRESOLVE-METHOD");
/* 3065 */   public static final Symbol ADD_TO_CLASSPATH = Lisp.PACKAGE_JAVA
/* 3066 */     .addExternalSymbol("ADD-TO-CLASSPATH");
/*      */ 
/*      */   
/* 3069 */   public static final Symbol AUTOCOMPILE = Lisp.PACKAGE_SYS
/* 3070 */     .addExternalSymbol("AUTOCOMPILE");
/* 3071 */   public static final Symbol CLASS_BYTES = Lisp.PACKAGE_SYS
/* 3072 */     .addExternalSymbol("CLASS-BYTES");
/* 3073 */   public static final Symbol _CLASS_SLOTS = Lisp.PACKAGE_SYS
/* 3074 */     .addExternalSymbol("%CLASS-SLOTS");
/* 3075 */   public static final Symbol COMPILED_LISP_FUNCTION_P = Lisp.PACKAGE_SYS
/* 3076 */     .addExternalSymbol("COMPILED-LISP-FUNCTION-P");
/* 3077 */   public static final Symbol DEFAULT_INITARGS = Lisp.PACKAGE_SYS
/* 3078 */     .addExternalSymbol("DEFAULT-INITARGS");
/* 3079 */   public static final Symbol DIRECT_METHODS = Lisp.PACKAGE_SYS
/* 3080 */     .addExternalSymbol("DIRECT-METHODS");
/* 3081 */   public static final Symbol DIRECT_SLOTS = Lisp.PACKAGE_SYS
/* 3082 */     .addExternalSymbol("DIRECT-SLOTS");
/* 3083 */   public static final Symbol DIRECT_SUBCLASSES = Lisp.PACKAGE_SYS
/* 3084 */     .addExternalSymbol("DIRECT-SUBCLASSES");
/* 3085 */   public static final Symbol DIRECT_DEFAULT_INITARGS = Lisp.PACKAGE_SYS
/* 3086 */     .addExternalSymbol("DIRECT-DEFAULT-INITARGS");
/* 3087 */   public static final Symbol DIRECT_SUPERCLASSES = Lisp.PACKAGE_SYS
/* 3088 */     .addExternalSymbol("DIRECT-SUPERCLASSES");
/* 3089 */   public static final Symbol __DISASSEMBLERS__ = Lisp.PACKAGE_SYS
/* 3090 */     .addExternalSymbol("*DISASSEMBLERS*");
/* 3091 */   public static final Symbol CHOOSE_DISASSEMBLER = Lisp.PACKAGE_SYS
/* 3092 */     .addExternalSymbol("CHOOSE-DISASSEMBLER");
/* 3093 */   public static final Symbol _DOCUMENTATION = Lisp.PACKAGE_SYS
/* 3094 */     .addExternalSymbol("%DOCUMENTATION");
/* 3095 */   public static final Symbol _ENABLE_AUTOCOMPILE_ = Lisp.PACKAGE_SYS
/* 3096 */     .addExternalSymbol("*ENABLE-AUTOCOMPILE*");
/* 3097 */   public static final Symbol GET_INPUT_STREAM = Lisp.PACKAGE_SYS
/* 3098 */     .addExternalSymbol("GET-INPUT-STREAM");
/* 3099 */   public static final Symbol ENVIRONMENT = Lisp.PACKAGE_SYS
/* 3100 */     .addExternalSymbol("ENVIRONMENT");
/* 3101 */   public static final Symbol FINALIZED_P = Lisp.PACKAGE_SYS
/* 3102 */     .addExternalSymbol("FINALIZED-P");
/* 3103 */   public static final Symbol FLOAT_UNDERFLOW_MODE = Lisp.PACKAGE_SYS
/* 3104 */     .addExternalSymbol("FLOAT-UNDERFLOW-MODE");
/* 3105 */   public static final Symbol FLOAT_OVERFLOW_MODE = Lisp.PACKAGE_SYS
/* 3106 */     .addExternalSymbol("FLOAT-OVERFLOW-MODE");
/* 3107 */   public static final Symbol GETHASH1 = Lisp.PACKAGE_SYS
/* 3108 */     .addExternalSymbol("GETHASH1");
/* 3109 */   public static final Symbol HASH_TABLE_WEAKNESS = Lisp.PACKAGE_SYS
/* 3110 */     .addExternalSymbol("HASH-TABLE-WEAKNESS");
/* 3111 */   public static final Symbol JAR_STREAM = Lisp.PACKAGE_SYS
/* 3112 */     .addExternalSymbol("JAR-STREAM");
/* 3113 */   public static final Symbol LAYOUT = Lisp.PACKAGE_SYS
/* 3114 */     .addExternalSymbol("LAYOUT");
/* 3115 */   public static final Symbol MATCH_WILD_JAR_PATHNAME = Lisp.PACKAGE_SYS
/* 3116 */     .addExternalSymbol("MATCH-WILD-JAR-PATHNAME");
/* 3117 */   public static final Symbol NAME = Lisp.PACKAGE_SYS
/* 3118 */     .addExternalSymbol("NAME");
/* 3119 */   public static final Symbol NAMED_LAMBDA = Lisp.PACKAGE_SYS
/* 3120 */     .addExternalSymbol("NAMED-LAMBDA");
/* 3121 */   public static final Symbol OUTPUT_OBJECT = Lisp.PACKAGE_SYS
/* 3122 */     .addExternalSymbol("OUTPUT-OBJECT");
/* 3123 */   public static final Symbol PRECEDENCE_LIST = Lisp.PACKAGE_SYS
/* 3124 */     .addExternalSymbol("PRECEDENCE-LIST");
/* 3125 */   public static final Symbol PUTHASH = Lisp.PACKAGE_SYS
/* 3126 */     .addExternalSymbol("PUTHASH");
/* 3127 */   public static final Symbol RECORD_SOURCE_INFORMATION_FOR_TYPE = Lisp.PACKAGE_SYS
/* 3128 */     .addExternalSymbol("RECORD-SOURCE-INFORMATION-FOR-TYPE");
/* 3129 */   public static final Symbol SET_CHAR = Lisp.PACKAGE_SYS
/* 3130 */     .addExternalSymbol("SET-CHAR");
/* 3131 */   public static final Symbol _SET_CLASS_SLOTS = Lisp.PACKAGE_SYS
/* 3132 */     .addExternalSymbol("%SET-CLASS-SLOTS");
/* 3133 */   public static final Symbol SET_SCHAR = Lisp.PACKAGE_SYS
/* 3134 */     .addExternalSymbol("SET-SCHAR");
/* 3135 */   public static final Symbol SET_STD_SLOT_VALUE = Lisp.PACKAGE_SYS
/* 3136 */     .addExternalSymbol("SET-STD-SLOT-VALUE");
/* 3137 */   public static final Symbol SETF_FUNCTION = Lisp.PACKAGE_SYS
/* 3138 */     .addExternalSymbol("SETF-FUNCTION");
/* 3139 */   public static final Symbol SETF_INVERSE = Lisp.PACKAGE_SYS
/* 3140 */     .addExternalSymbol("SETF-INVERSE");
/* 3141 */   public static final Symbol SLOTS = Lisp.PACKAGE_SYS.addExternalSymbol("SLOTS");
/* 3142 */   public static final Symbol SLOT_DEFINITION = Lisp.PACKAGE_SYS
/* 3143 */     .addExternalSymbol("SLOT-DEFINITION");
/* 3144 */   public static final Symbol __SOURCE = Lisp.PACKAGE_SYS
/* 3145 */     .addInternalSymbol("SOURCE");
/* 3146 */   public static final Symbol STD_SLOT_BOUNDP = Lisp.PACKAGE_SYS
/* 3147 */     .addExternalSymbol("STD-SLOT-BOUNDP");
/* 3148 */   public static final Symbol STD_SLOT_VALUE = Lisp.PACKAGE_SYS
/* 3149 */     .addExternalSymbol("STD-SLOT-VALUE");
/* 3150 */   public static final Symbol SUBCLASSP = Lisp.PACKAGE_SYS
/* 3151 */     .addExternalSymbol("SUBCLASSP");
/* 3152 */   public static final Symbol SYMBOL_MACRO = Lisp.PACKAGE_SYS
/* 3153 */     .addExternalSymbol("SYMBOL-MACRO");
/* 3154 */   public static final Symbol UNDEFINED_FUNCTION_CALLED = Lisp.PACKAGE_SYS
/* 3155 */     .addExternalSymbol("UNDEFINED-FUNCTION-CALLED");
/* 3156 */   public static final Symbol URL_STREAM = Lisp.PACKAGE_SYS
/* 3157 */     .addExternalSymbol("URL-STREAM");
/*      */ 
/*      */ 
/*      */   
/* 3161 */   public static final Symbol ALLOCATION = Lisp.PACKAGE_SYS
/* 3162 */     .addInternalSymbol("ALLOCATION");
/* 3163 */   public static final Symbol ALLOCATION_CLASS = Lisp.PACKAGE_SYS
/* 3164 */     .addInternalSymbol("ALLOCATION-CLASS");
/* 3165 */   public static final Symbol ARGUMENT_PRECEDENCE_ORDER = Lisp.PACKAGE_SYS
/* 3166 */     .addInternalSymbol("ARGUMENT-PRECEDENCE-ORDER");
/* 3167 */   public static final Symbol BACKQUOTE_MACRO = Lisp.PACKAGE_SYS
/* 3168 */     .addInternalSymbol("BACKQUOTE-MACRO");
/* 3169 */   public static final Symbol CASE_FROB_STREAM = Lisp.PACKAGE_SYS
/* 3170 */     .addInternalSymbol("CASE-FROB-STREAM");
/* 3171 */   public static final Symbol CAUSE = Lisp.PACKAGE_SYS
/* 3172 */     .addInternalSymbol("CAUSE");
/* 3173 */   public static final Symbol COMMA_MACRO = Lisp.PACKAGE_SYS
/* 3174 */     .addInternalSymbol("COMMA-MACRO");
/* 3175 */   public static final Symbol DATUM = Lisp.PACKAGE_SYS
/* 3176 */     .addInternalSymbol("DATUM");
/* 3177 */   public static final Symbol DECLARATIONS = Lisp.PACKAGE_SYS
/* 3178 */     .addInternalSymbol("DECLARATIONS");
/* 3179 */   public static final Symbol DEFTYPE_DEFINITION = Lisp.PACKAGE_SYS
/* 3180 */     .addInternalSymbol("DEFTYPE-DEFINITION");
/* 3181 */   public static final Symbol EXPECTED_TYPE = Lisp.PACKAGE_SYS
/* 3182 */     .addInternalSymbol("EXPECTED-TYPE");
/* 3183 */   public static final Symbol FAST_FUNCTION = Lisp.PACKAGE_SYS
/* 3184 */     .addInternalSymbol("FAST-FUNCTION");
/* 3185 */   public static final Symbol FORMAT_ARGUMENTS = Lisp.PACKAGE_SYS
/* 3186 */     .addInternalSymbol("FORMAT-ARGUMENTS");
/* 3187 */   public static final Symbol FORMAT_CONTROL = Lisp.PACKAGE_SYS
/* 3188 */     .addInternalSymbol("FORMAT-CONTROL");
/* 3189 */   public static final Symbol FSET = Lisp.PACKAGE_SYS.addInternalSymbol("FSET");
/* 3190 */   public static final Symbol _FUNCTION = Lisp.PACKAGE_SYS
/* 3191 */     .addInternalSymbol("%FUNCTION");
/* 3192 */   public static final Symbol FUNCTION_PRELOAD = Lisp.PACKAGE_SYS
/* 3193 */     .addInternalSymbol("FUNCTION-PRELOAD");
/* 3194 */   public static final Symbol _GENERIC_FUNCTION = Lisp.PACKAGE_SYS
/* 3195 */     .addInternalSymbol("%GENERIC-FUNCTION");
/* 3196 */   public static final Symbol INITARGS = Lisp.PACKAGE_SYS
/* 3197 */     .addInternalSymbol("INITARGS");
/* 3198 */   public static final Symbol INITFORM = Lisp.PACKAGE_SYS
/* 3199 */     .addInternalSymbol("INITFORM");
/* 3200 */   public static final Symbol INITFUNCTION = Lisp.PACKAGE_SYS
/* 3201 */     .addInternalSymbol("INITFUNCTION");
/* 3202 */   public static final Symbol INITIAL_METHODS = Lisp.PACKAGE_SYS
/* 3203 */     .addInternalSymbol("INITIAL-METHODS");
/* 3204 */   public static final Symbol INSTANCE = Lisp.PACKAGE_SYS
/* 3205 */     .addInternalSymbol("INSTANCE");
/* 3206 */   public static final Symbol JAVA_STACK_FRAME = Lisp.PACKAGE_SYS
/* 3207 */     .addInternalSymbol("JAVA-STACK-FRAME");
/* 3208 */   public static final Symbol KEYWORDS = Lisp.PACKAGE_SYS
/* 3209 */     .addInternalSymbol("KEYWORDS");
/* 3210 */   public static final Symbol LAMBDA_LIST = Lisp.PACKAGE_SYS
/* 3211 */     .addInternalSymbol("LAMBDA-LIST");
/* 3212 */   public static final Symbol LISP_STACK_FRAME = Lisp.PACKAGE_SYS
/* 3213 */     .addInternalSymbol("LISP-STACK-FRAME");
/* 3214 */   public static final Symbol LOCATION = Lisp.PACKAGE_SYS
/* 3215 */     .addInternalSymbol("LOCATION");
/* 3216 */   public static final Symbol MACROEXPAND_MACRO = Lisp.PACKAGE_SYS
/* 3217 */     .addInternalSymbol("MACROEXPAND-MACRO");
/* 3218 */   public static final Symbol MAKE_FUNCTION_PRELOADING_CONTEXT = Lisp.PACKAGE_SYS
/* 3219 */     .addInternalSymbol("MAKE-FUNCTION-PRELOADING-CONTEXT");
/* 3220 */   public static final Symbol METHOD_CLASS = Lisp.PACKAGE_SYS
/* 3221 */     .addInternalSymbol("METHOD-CLASS");
/* 3222 */   public static final Symbol _METHOD_COMBINATION = Lisp.PACKAGE_SYS
/* 3223 */     .addInternalSymbol("%METHOD-COMBINATION");
/* 3224 */   public static final Symbol METHODS = Lisp.PACKAGE_SYS.addInternalSymbol("METHODS");
/* 3225 */   public static final Symbol OBJECT = Lisp.PACKAGE_SYS.addInternalSymbol("OBJECT");
/* 3226 */   public static final Symbol OPERANDS = Lisp.PACKAGE_SYS
/* 3227 */     .addInternalSymbol("OPERANDS");
/* 3228 */   public static final Symbol OPERATION = Lisp.PACKAGE_SYS
/* 3229 */     .addInternalSymbol("OPERATION");
/* 3230 */   public static final Symbol OPTIONAL_ARGS = Lisp.PACKAGE_SYS
/* 3231 */     .addInternalSymbol("OPTIONAL-ARGS");
/* 3232 */   public static final Symbol OTHER_KEYWORDS_P = Lisp.PACKAGE_SYS
/* 3233 */     .addInternalSymbol("OTHER-KEYWORDS-P");
/* 3234 */   public static final Symbol PROXY_PRELOADED_FUNCTION = Lisp.PACKAGE_SYS
/* 3235 */     .addInternalSymbol("PROXY-PRELOADED-FUNCTION");
/* 3236 */   public static final Symbol QUALIFIERS = Lisp.PACKAGE_SYS
/* 3237 */     .addInternalSymbol("QUALIFIERS");
/* 3238 */   public static final Symbol READERS = Lisp.PACKAGE_SYS
/* 3239 */     .addInternalSymbol("READERS");
/* 3240 */   public static final Symbol REQUIRED_ARGS = Lisp.PACKAGE_SYS
/* 3241 */     .addInternalSymbol("REQUIRED-ARGS");
/* 3242 */   public static final Symbol READ_RANDOM_STATE = Lisp.PACKAGE_SYS
/* 3243 */     .addInternalSymbol("READ-RANDOM-STATE");
/*      */   
/* 3245 */   public static final Symbol _SOURCE = Lisp.PACKAGE_SYS
/* 3246 */     .addInternalSymbol("%SOURCE");
/* 3247 */   public static final Symbol SOCKET_STREAM = Lisp.PACKAGE_SYS
/* 3248 */     .addInternalSymbol("SOCKET-STREAM");
/* 3249 */   public static final Symbol SPECIALIZERS = Lisp.PACKAGE_SYS
/* 3250 */     .addInternalSymbol("SPECIALIZERS");
/* 3251 */   public static final Symbol STRING_INPUT_STREAM = Lisp.PACKAGE_SYS
/* 3252 */     .addInternalSymbol("STRING-INPUT-STREAM");
/* 3253 */   public static final Symbol STRING_OUTPUT_STREAM = Lisp.PACKAGE_SYS
/* 3254 */     .addInternalSymbol("STRING-OUTPUT-STREAM");
/* 3255 */   public static final Symbol SYSTEM_STREAM = Lisp.PACKAGE_SYS
/* 3256 */     .addInternalSymbol("SYSTEM-STREAM");
/* 3257 */   public static final Symbol STACK_FRAME = Lisp.PACKAGE_SYS
/* 3258 */     .addInternalSymbol("STACK-FRAME");
/* 3259 */   public static final Symbol _TYPE = Lisp.PACKAGE_SYS
/* 3260 */     .addInternalSymbol("%TYPE");
/* 3261 */   public static final Symbol WRITERS = Lisp.PACKAGE_SYS
/* 3262 */     .addInternalSymbol("WRITERS");
/*      */ 
/*      */   
/* 3265 */   public static final Symbol _INSPECTOR_HOOK_ = Lisp.PACKAGE_EXT
/* 3266 */     .addExternalSymbol("*INSPECTOR-HOOK*");
/*      */   
/* 3268 */   public static final Symbol COMPILER_LET = Lisp.PACKAGE_LISP
/* 3269 */     .addExternalSymbol("COMPILER-LET");
/*      */ 
/*      */   
/* 3272 */   public static final Symbol THREAD = Lisp.PACKAGE_THREADS
/* 3273 */     .addExternalSymbol("THREAD");
/* 3274 */   public static final Symbol _THREADING_MODEL = Lisp.PACKAGE_THREADS
/* 3275 */     .addExternalSymbol("*THREADING-MODEL*");
/*      */ 
/*      */ 
/*      */   
/* 3279 */   public static final Symbol _RESIGNAL_COMPILER_WARINGS_ = Lisp.PACKAGE_JVM
/* 3280 */     .addExternalSymbol("*RESIGNAL-COMPILER-WARNINGS*");
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Symbol.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */