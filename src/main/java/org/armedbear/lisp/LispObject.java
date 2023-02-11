/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.util.WeakHashMap;
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
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ public class LispObject
/*      */ {
/*      */   public LispObject resolve() {
/*   48 */     return this;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typeOf() {
/*   53 */     return Lisp.T;
/*      */   }
/*      */   
/*      */   public static LispObject getInstance(boolean b) {
/*   57 */     return b ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject classOf() {
/*   62 */     return BuiltInClass.CLASS_T;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getDescription() {
/*   67 */     StringBuilder sb = new StringBuilder("An object of type ");
/*   68 */     sb.append(typeOf().princToString());
/*   69 */     sb.append(" at #x");
/*   70 */     sb.append(Integer.toHexString(System.identityHashCode(this)).toUpperCase());
/*   71 */     return new SimpleString(sb);
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
/*      */   public LispObject getParts() {
/*   85 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean getBooleanValue() {
/*   90 */     return true;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject typep(LispObject typeSpecifier) {
/*   95 */     if (typeSpecifier == Lisp.T)
/*   96 */       return Lisp.T; 
/*   97 */     if (typeSpecifier == BuiltInClass.CLASS_T)
/*   98 */       return Lisp.T; 
/*   99 */     if (typeSpecifier == Symbol.ATOM)
/*  100 */       return Lisp.T; 
/*  101 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean constantp() {
/*  106 */     return true;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject CONSTANTP() {
/*  111 */     return constantp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject ATOM() {
/*  116 */     return atom() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean atom() {
/*  121 */     return true;
/*      */   }
/*      */ 
/*      */   
/*      */   public Object javaInstance() {
/*  126 */     return this;
/*      */   }
/*      */ 
/*      */   
/*      */   public Object javaInstance(Class<?> c) {
/*  131 */     if (c.isAssignableFrom(getClass())) {
/*  132 */       return this;
/*      */     }
/*      */     
/*  135 */     if (c == Boolean.class || c == boolean.class) {
/*  136 */       return Boolean.TRUE;
/*      */     }
/*  138 */     return Lisp.error(new LispError("The value " + princToString() + " is not of class " + c
/*  139 */           .getName()));
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public Object lockableInstance() {
/*  150 */     return this;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final LispObject car() {
/*  156 */     if (this instanceof Cons)
/*  157 */       return ((Cons)this).car; 
/*  158 */     if (this instanceof Nil) {
/*  159 */       return Lisp.NIL;
/*      */     }
/*  161 */     return Lisp.type_error(this, Symbol.LIST);
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setCar(LispObject obj) {
/*  166 */     if (this instanceof Cons) {
/*  167 */       ((Cons)this).car = obj;
/*      */       return;
/*      */     } 
/*  170 */     Lisp.type_error(this, Symbol.CONS);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject RPLACA(LispObject obj) {
/*  175 */     return Lisp.type_error(this, Symbol.CONS);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject cdr() {
/*  180 */     if (this instanceof Cons)
/*  181 */       return ((Cons)this).cdr; 
/*  182 */     if (this instanceof Nil) {
/*  183 */       return Lisp.NIL;
/*      */     }
/*  185 */     return Lisp.type_error(this, Symbol.LIST);
/*      */   }
/*      */ 
/*      */   
/*      */   public final void setCdr(LispObject obj) {
/*  190 */     if (this instanceof Cons) {
/*  191 */       ((Cons)this).cdr = obj;
/*      */       
/*      */       return;
/*      */     } 
/*  195 */     Lisp.type_error(this, Symbol.CONS);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject RPLACD(LispObject obj) {
/*  200 */     return Lisp.type_error(this, Symbol.CONS);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject cadr() {
/*  205 */     LispObject tail = cdr();
/*  206 */     if (!(tail instanceof Nil)) {
/*  207 */       return tail.car();
/*      */     }
/*  209 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject cddr() {
/*  214 */     LispObject tail = cdr();
/*  215 */     if (!(tail instanceof Nil)) {
/*  216 */       return tail.cdr();
/*      */     }
/*  218 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject caddr() {
/*  223 */     LispObject tail = cddr();
/*  224 */     if (!(tail instanceof Nil)) {
/*  225 */       return tail.car();
/*      */     }
/*  227 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject nthcdr(int n) {
/*  232 */     if (n < 0)
/*  233 */       return Lisp.type_error(Fixnum.getInstance(n), 
/*  234 */           Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.ZERO })); 
/*  235 */     if (this instanceof Cons) {
/*  236 */       LispObject result = this;
/*  237 */       for (int i = n; i-- > 0; ) {
/*  238 */         result = result.cdr();
/*  239 */         if (result == Lisp.NIL)
/*      */           break; 
/*      */       } 
/*  242 */       return result;
/*  243 */     }  if (this instanceof Nil) {
/*  244 */       return Lisp.NIL;
/*      */     }
/*  246 */     return Lisp.type_error(this, Symbol.LIST);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject push(LispObject obj) {
/*  251 */     if (this instanceof Cons)
/*  252 */       return new Cons(obj, this); 
/*  253 */     if (this instanceof Nil) {
/*  254 */       return new Cons(obj);
/*      */     }
/*  256 */     return Lisp.type_error(this, Symbol.LIST);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject EQ(LispObject obj) {
/*  261 */     return (this == obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean eql(char c) {
/*  266 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean eql(int n) {
/*  271 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean eql(LispObject obj) {
/*  276 */     return (this == obj);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject EQL(LispObject obj) {
/*  281 */     return eql(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject EQUAL(LispObject obj) {
/*  286 */     return equal(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean equal(int n) {
/*  291 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean equal(LispObject obj) {
/*  296 */     return (this == obj);
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean equalp(int n) {
/*  301 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean equalp(LispObject obj) {
/*  306 */     return (this == obj);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject ABS() {
/*  311 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject NUMERATOR() {
/*  316 */     return Lisp.type_error(this, Symbol.RATIONAL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject DENOMINATOR() {
/*  321 */     return Lisp.type_error(this, Symbol.RATIONAL);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject EVENP() {
/*  326 */     return evenp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean evenp() {
/*  331 */     Lisp.type_error(this, Symbol.INTEGER);
/*      */     
/*  333 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject ODDP() {
/*  338 */     return oddp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean oddp() {
/*  343 */     Lisp.type_error(this, Symbol.INTEGER);
/*      */     
/*  345 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject PLUSP() {
/*  350 */     return plusp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean plusp() {
/*  355 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/*  357 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject MINUSP() {
/*  362 */     return minusp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean minusp() {
/*  367 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/*  369 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject NUMBERP() {
/*  374 */     return numberp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean numberp() {
/*  379 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject ZEROP() {
/*  384 */     return zerop() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean zerop() {
/*  389 */     Lisp.type_error(this, Symbol.NUMBER);
/*      */     
/*  391 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject COMPLEXP() {
/*  396 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject FLOATP() {
/*  401 */     return floatp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean floatp() {
/*  406 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject INTEGERP() {
/*  411 */     return integerp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean integerp() {
/*  416 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject RATIONALP() {
/*  421 */     return rationalp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean rationalp() {
/*  426 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject REALP() {
/*  431 */     return realp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean realp() {
/*  436 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject STRINGP() {
/*  441 */     return stringp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean stringp() {
/*  446 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject SIMPLE_STRING_P() {
/*  451 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject VECTORP() {
/*  456 */     return vectorp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean vectorp() {
/*  461 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject CHARACTERP() {
/*  466 */     return characterp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean characterp() {
/*  471 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public int length() {
/*  476 */     Lisp.type_error(this, Symbol.SEQUENCE);
/*      */     
/*  478 */     return 0;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject LENGTH() {
/*  483 */     return Fixnum.getInstance(length());
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject CHAR(int index) {
/*  488 */     return Lisp.type_error(this, Symbol.STRING);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject SCHAR(int index) {
/*  493 */     return Lisp.type_error(this, Symbol.SIMPLE_STRING);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject NTH(int index) {
/*  498 */     return Lisp.type_error(this, Symbol.LIST);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject NTH(LispObject arg) {
/*  503 */     return NTH(Fixnum.getValue(arg));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject elt(int index) {
/*  508 */     return Lisp.type_error(this, Symbol.SEQUENCE);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject reverse() {
/*  513 */     return Lisp.type_error(this, Symbol.SEQUENCE);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject nreverse() {
/*  518 */     return Lisp.type_error(this, Symbol.SEQUENCE);
/*      */   }
/*      */ 
/*      */   
/*      */   public long aref_long(int index) {
/*  523 */     return AREF(index).longValue();
/*      */   }
/*      */ 
/*      */   
/*      */   public int aref(int index) {
/*  528 */     return AREF(index).intValue();
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject AREF(int index) {
/*  533 */     return Lisp.type_error(this, Symbol.ARRAY);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject AREF(LispObject index) {
/*  538 */     return AREF(Fixnum.getValue(index));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void aset(int index, int n) {
/*  544 */     aset(index, Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void aset(int index, LispObject newValue) {
/*  550 */     Lisp.type_error(this, Symbol.ARRAY);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public final void aset(LispObject index, LispObject newValue) {
/*  556 */     aset(Fixnum.getValue(index), newValue);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject SVREF(int index) {
/*  561 */     return Lisp.type_error(this, Symbol.SIMPLE_VECTOR);
/*      */   }
/*      */ 
/*      */   
/*      */   public void svset(int index, LispObject newValue) {
/*  566 */     Lisp.type_error(this, Symbol.SIMPLE_VECTOR);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void vectorPushExtend(LispObject element) {
/*  572 */     noFillPointer();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject VECTOR_PUSH_EXTEND(LispObject element) {
/*  578 */     return noFillPointer();
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject VECTOR_PUSH_EXTEND(LispObject element, LispObject extension) {
/*  584 */     return noFillPointer();
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject noFillPointer() {
/*  589 */     return Lisp.type_error(this, Lisp.list(Symbol.AND, new LispObject[] { Symbol.VECTOR, 
/*  590 */             Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.ARRAY_HAS_FILL_POINTER_P }) }));
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject[] copyToArray() {
/*  596 */     Lisp.type_error(this, Symbol.LIST);
/*      */     
/*  598 */     return null;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject SYMBOLP() {
/*  603 */     return (this instanceof Symbol) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final boolean listp() {
/*  608 */     return (this instanceof Cons || this instanceof Nil);
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject LISTP() {
/*  613 */     return listp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public final boolean endp() {
/*  618 */     if (this instanceof Cons)
/*  619 */       return false; 
/*  620 */     if (this instanceof Nil)
/*  621 */       return true; 
/*  622 */     Lisp.type_error(this, Symbol.LIST);
/*      */     
/*  624 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject ENDP() {
/*  629 */     return endp() ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject NOT() {
/*  634 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isSpecialOperator() {
/*  639 */     Lisp.type_error(this, Symbol.SYMBOL);
/*      */     
/*  641 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isSpecialVariable() {
/*  646 */     return false;
/*      */   }
/*      */ 
/*      */   
/*  650 */   private static final WeakHashMap<LispObject, LispObject> documentationHashTable = new WeakHashMap<>();
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject getDocumentation(LispObject docType) {
/*      */     LispObject alist;
/*  656 */     synchronized (documentationHashTable) {
/*  657 */       alist = documentationHashTable.get(this);
/*      */     } 
/*  659 */     if (alist != null) {
/*      */       
/*  661 */       LispObject entry = Lisp.assq(docType, alist);
/*  662 */       if (entry instanceof Cons)
/*  663 */         return ((Cons)entry).cdr; 
/*      */     } 
/*  665 */     if (docType == Symbol.FUNCTION && this instanceof Symbol) {
/*  666 */       LispObject fn = ((Symbol)this).getSymbolFunction();
/*  667 */       if (fn instanceof Function) {
/*  668 */         DocString ds = fn.getClass().<DocString>getAnnotation(DocString.class);
/*  669 */         if (ds != null) {
/*  670 */           String arglist = ds.args();
/*  671 */           String docstring = ds.doc();
/*  672 */           if (arglist.length() != 0)
/*  673 */             ((Function)fn).setLambdaList(new SimpleString(arglist)); 
/*  674 */           if (docstring.length() != 0) {
/*  675 */             SimpleString doc = new SimpleString(docstring);
/*  676 */             ((Symbol)this).setDocumentation(Symbol.FUNCTION, doc);
/*  677 */             return doc;
/*  678 */           }  if (fn.typep(Symbol.STANDARD_GENERIC_FUNCTION) != Lisp.NIL) {
/*  679 */             return Symbol.SLOT_VALUE.execute(fn, Symbol._DOCUMENTATION);
/*      */           }
/*      */         } 
/*      */       } 
/*      */     } 
/*  684 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setDocumentation(LispObject docType, LispObject documentation) {
/*  690 */     synchronized (documentationHashTable) {
/*  691 */       LispObject alist = documentationHashTable.get(this);
/*  692 */       if (alist == null)
/*  693 */         alist = Lisp.NIL; 
/*  694 */       LispObject entry = Lisp.assq(docType, alist);
/*  695 */       if (entry instanceof Cons) {
/*      */         
/*  697 */         ((Cons)entry).cdr = documentation;
/*      */       }
/*      */       else {
/*      */         
/*  701 */         alist = alist.push(new Cons(docType, documentation));
/*  702 */         documentationHashTable.put(this, alist);
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getPropertyList() {
/*  709 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setPropertyList(LispObject obj) {}
/*      */ 
/*      */   
/*      */   public LispObject getSymbolValue() {
/*  718 */     return Lisp.type_error(this, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSymbolFunction() {
/*  723 */     return Lisp.type_error(this, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSymbolFunctionOrDie() {
/*  728 */     return Lisp.type_error(this, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSymbolSetfFunction() {
/*  733 */     return Lisp.type_error(this, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSymbolSetfFunctionOrDie() {
/*  738 */     return Lisp.type_error(this, Symbol.SYMBOL);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public String princToString() {
/*  747 */     LispThread thread = LispThread.currentThread();
/*  748 */     SpecialBindingsMark mark = thread.markSpecialBindings();
/*      */     try {
/*  750 */       thread.bindSpecial(Symbol.PRINT_READABLY, Lisp.NIL);
/*  751 */       thread.bindSpecial(Symbol.PRINT_ESCAPE, Lisp.NIL);
/*  752 */       return printObject();
/*      */     } finally {
/*      */       
/*  755 */       thread.resetSpecialBindings(mark);
/*      */     } 
/*      */   }
/*      */ 
/*      */   
/*      */   public String printObject() {
/*  761 */     return unreadableString(toString(), false);
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
/*      */   public final String unreadableString(String s) {
/*  773 */     return unreadableString(s, true);
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
/*      */ 
/*      */   
/*      */   public final String unreadableString(String s, boolean identity) {
/*  791 */     if (Symbol.PRINT_READABLY.symbolValue() != Lisp.NIL) {
/*  792 */       Lisp.error(new PrintNotReadable(Lisp.list(Keyword.OBJECT, new LispObject[] { this })));
/*  793 */       return null;
/*      */     } 
/*  795 */     StringBuilder sb = new StringBuilder("#<");
/*  796 */     sb.append(s);
/*  797 */     if (identity) {
/*  798 */       sb.append(" {");
/*  799 */       sb.append(Integer.toHexString(System.identityHashCode(this)).toUpperCase());
/*  800 */       sb.append("}");
/*      */     } 
/*  802 */     sb.append(">");
/*  803 */     return sb.toString();
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject args, Environment env) {
/*  810 */     return Lisp.error(new LispError());
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject execute() {
/*  815 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject arg) {
/*  820 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second) {
/*  826 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*  833 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*  840 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/*  848 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/*  856 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/*  865 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eighth) {
/*  874 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject execute(LispObject[] args) {
/*  879 */     return Lisp.type_error(this, Symbol.FUNCTION);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public LispObject dispatch(LispObject[] args) {
/*  885 */     switch (args.length) {
/*      */       
/*      */       case 0:
/*  888 */         return execute();
/*      */       case 1:
/*  890 */         return execute(args[0]);
/*      */       case 2:
/*  892 */         return execute(args[0], args[1]);
/*      */       case 3:
/*  894 */         return execute(args[0], args[1], args[2]);
/*      */       case 4:
/*  896 */         return execute(args[0], args[1], args[2], args[3]);
/*      */       case 5:
/*  898 */         return execute(args[0], args[1], args[2], args[3], args[4]);
/*      */       case 6:
/*  900 */         return execute(args[0], args[1], args[2], args[3], args[4], args[5]);
/*      */       
/*      */       case 7:
/*  903 */         return execute(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
/*      */       
/*      */       case 8:
/*  906 */         return execute(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
/*      */     } 
/*      */     
/*  909 */     return execute(args);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public int intValue() {
/*  915 */     Lisp.type_error(this, Symbol.INTEGER);
/*      */     
/*  917 */     return 0;
/*      */   }
/*      */ 
/*      */   
/*      */   public long longValue() {
/*  922 */     Lisp.type_error(this, Symbol.INTEGER);
/*      */     
/*  924 */     return 0L;
/*      */   }
/*      */ 
/*      */   
/*      */   public float floatValue() {
/*  929 */     Lisp.type_error(this, Symbol.SINGLE_FLOAT);
/*      */     
/*  931 */     return 0.0F;
/*      */   }
/*      */ 
/*      */   
/*      */   public double doubleValue() {
/*  936 */     Lisp.type_error(this, Symbol.DOUBLE_FLOAT);
/*      */     
/*  938 */     return 0.0D;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject incr() {
/*  943 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject decr() {
/*  948 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject negate() {
/*  953 */     return Fixnum.ZERO.subtract(this);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject add(int n) {
/*  958 */     return add(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject add(LispObject obj) {
/*  963 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject subtract(int n) {
/*  968 */     return subtract(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject subtract(LispObject obj) {
/*  973 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject multiplyBy(int n) {
/*  978 */     return multiplyBy(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject multiplyBy(LispObject obj) {
/*  983 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject divideBy(LispObject obj) {
/*  988 */     return Lisp.type_error(this, Symbol.NUMBER);
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isEqualTo(int n) {
/*  993 */     return isEqualTo(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isEqualTo(LispObject obj) {
/*  998 */     Lisp.type_error(this, Symbol.NUMBER);
/*      */     
/* 1000 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_E(LispObject obj) {
/* 1005 */     return isEqualTo(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isNotEqualTo(int n) {
/* 1010 */     return isNotEqualTo(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isNotEqualTo(LispObject obj) {
/* 1015 */     Lisp.type_error(this, Symbol.NUMBER);
/*      */     
/* 1017 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_NE(LispObject obj) {
/* 1022 */     return isNotEqualTo(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isLessThan(int n) {
/* 1027 */     return isLessThan(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isLessThan(LispObject obj) {
/* 1032 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/* 1034 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_LT(LispObject obj) {
/* 1039 */     return isLessThan(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isGreaterThan(int n) {
/* 1044 */     return isGreaterThan(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isGreaterThan(LispObject obj) {
/* 1049 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/* 1051 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_GT(LispObject obj) {
/* 1056 */     return isGreaterThan(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isLessThanOrEqualTo(int n) {
/* 1061 */     return isLessThanOrEqualTo(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isLessThanOrEqualTo(LispObject obj) {
/* 1066 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/* 1068 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_LE(LispObject obj) {
/* 1073 */     return isLessThanOrEqualTo(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isGreaterThanOrEqualTo(int n) {
/* 1078 */     return isGreaterThanOrEqualTo(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean isGreaterThanOrEqualTo(LispObject obj) {
/* 1083 */     Lisp.type_error(this, Symbol.REAL);
/*      */     
/* 1085 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   public final LispObject IS_GE(LispObject obj) {
/* 1090 */     return isGreaterThanOrEqualTo(obj) ? Lisp.T : Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject truncate(LispObject obj) {
/* 1095 */     return Lisp.type_error(this, Symbol.REAL);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject MOD(LispObject divisor) {
/* 1100 */     truncate(divisor);
/* 1101 */     LispThread thread = LispThread.currentThread();
/* 1102 */     LispObject remainder = thread._values[1];
/* 1103 */     thread.clearValues();
/* 1104 */     if (!remainder.zerop())
/*      */     {
/* 1106 */       if (divisor.minusp()) {
/*      */         
/* 1108 */         if (plusp()) {
/* 1109 */           return remainder.add(divisor);
/*      */         
/*      */         }
/*      */       }
/* 1113 */       else if (minusp()) {
/* 1114 */         return remainder.add(divisor);
/*      */       } 
/*      */     }
/* 1117 */     return remainder;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject MOD(int divisor) {
/* 1122 */     return MOD(Fixnum.getInstance(divisor));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject ash(int shift) {
/* 1127 */     return ash(Fixnum.getInstance(shift));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject ash(LispObject obj) {
/* 1132 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGNOT() {
/* 1137 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGAND(int n) {
/* 1142 */     return LOGAND(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGAND(LispObject obj) {
/* 1147 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGIOR(int n) {
/* 1152 */     return LOGIOR(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGIOR(LispObject obj) {
/* 1157 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGXOR(int n) {
/* 1162 */     return LOGXOR(Fixnum.getInstance(n));
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LOGXOR(LispObject obj) {
/* 1167 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject LDB(int size, int position) {
/* 1172 */     return Lisp.type_error(this, Symbol.INTEGER);
/*      */   }
/*      */ 
/*      */   
/*      */   public int sxhash() {
/* 1177 */     return hashCode() & Integer.MAX_VALUE;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public int psxhash() {
/* 1183 */     return sxhash();
/*      */   }
/*      */ 
/*      */   
/*      */   public int psxhash(int depth) {
/* 1188 */     return psxhash();
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject STRING() {
/* 1193 */     return Lisp.error(new TypeError(princToString() + " cannot be coerced to a string."));
/*      */   }
/*      */ 
/*      */   
/*      */   public char[] chars() {
/* 1198 */     Lisp.type_error(this, Symbol.STRING);
/*      */     
/* 1200 */     return null;
/*      */   }
/*      */ 
/*      */   
/*      */   public char[] getStringChars() {
/* 1205 */     Lisp.type_error(this, Symbol.STRING);
/*      */     
/* 1207 */     return null;
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   public String getStringValue() {
/* 1217 */     Lisp.type_error(this, Symbol.STRING);
/*      */     
/* 1219 */     return null;
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSlotValue_0() {
/* 1224 */     return Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSlotValue_1() {
/* 1229 */     return Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSlotValue_2() {
/* 1234 */     return Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSlotValue_3() {
/* 1239 */     return Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject getSlotValue(int index) {
/* 1244 */     return Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public int getFixnumSlotValue(int index) {
/* 1249 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */     
/* 1251 */     return 0;
/*      */   }
/*      */ 
/*      */   
/*      */   public boolean getSlotValueAsBoolean(int index) {
/* 1256 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */     
/* 1258 */     return false;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue_0(LispObject value) {
/* 1264 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue_1(LispObject value) {
/* 1270 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue_2(LispObject value) {
/* 1276 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue_3(LispObject value) {
/* 1282 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue(int index, LispObject value) {
/* 1288 */     Lisp.type_error(this, Symbol.STRUCTURE_OBJECT);
/*      */   }
/*      */ 
/*      */   
/*      */   public LispObject SLOT_VALUE(LispObject slotName) {
/* 1293 */     return Lisp.type_error(this, Symbol.STANDARD_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setSlotValue(LispObject slotName, LispObject newValue) {
/* 1299 */     Lisp.type_error(this, Symbol.STANDARD_OBJECT);
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public int getCallCount() {
/* 1305 */     return 0;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   public void setCallCount(int n) {}
/*      */ 
/*      */ 
/*      */   
/*      */   public void incrementCallCount() {}
/*      */ 
/*      */   
/*      */   public int getHotCount() {
/* 1318 */     return 0;
/*      */   }
/*      */   
/*      */   public void setHotCount(int n) {}
/*      */   
/*      */   public void incrementHotCount() {}
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/LispObject.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */