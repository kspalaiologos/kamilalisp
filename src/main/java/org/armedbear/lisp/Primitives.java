/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.io.Serializable;
/*      */ import java.io.UnsupportedEncodingException;
/*      */ import java.math.BigInteger;
/*      */ import java.util.ArrayList;
/*      */ import org.armedbear.lisp.util.Finalizer;
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
/*      */ public final class Primitives
/*      */ {
/*   46 */   public static final Primitive MULTIPLY = new pf_multiply();
/*      */   
/*      */   private static final class pf_multiply extends Primitive { pf_multiply() {
/*   49 */       super(Symbol.STAR, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*   54 */       return Fixnum.ONE;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*   58 */       if (arg.numberp())
/*   59 */         return arg; 
/*   60 */       return Lisp.type_error(arg, Symbol.NUMBER);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*   66 */       return first.multiplyBy(second);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*   70 */       LispObject result = Fixnum.ONE;
/*   71 */       for (int i = 0; i < args.length; i++)
/*   72 */         result = result.multiplyBy(args[i]); 
/*   73 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*   78 */   public static final Primitive DIVIDE = new pf_divide();
/*      */   
/*      */   private static final class pf_divide extends Primitive { pf_divide() {
/*   81 */       super(Symbol.SLASH, "numerator &rest denominators");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*   86 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*   90 */       return Fixnum.ONE.divideBy(arg);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*   96 */       return first.divideBy(second);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  100 */       LispObject result = args[0];
/*  101 */       for (int i = 1; i < args.length; i++)
/*  102 */         result = result.divideBy(args[i]); 
/*  103 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  108 */   public static final Primitive MIN = new pf_min();
/*      */   
/*      */   private static final class pf_min extends Primitive { pf_min() {
/*  111 */       super(Symbol.MIN, "&rest reals");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*  116 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  120 */       if (arg.realp())
/*  121 */         return arg; 
/*  122 */       return Lisp.type_error(arg, Symbol.REAL);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  128 */       return first.isLessThan(second) ? first : second;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  132 */       LispObject result = args[0];
/*  133 */       if (!result.realp())
/*  134 */         Lisp.type_error(result, Symbol.REAL); 
/*  135 */       for (int i = 1; i < args.length; i++) {
/*  136 */         if (args[i].isLessThan(result))
/*  137 */           result = args[i]; 
/*      */       } 
/*  139 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  144 */   public static final Primitive MAX = new pf_max();
/*      */   
/*      */   private static final class pf_max extends Primitive { pf_max() {
/*  147 */       super(Symbol.MAX, "&rest reals");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*  152 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  156 */       if (arg.realp())
/*  157 */         return arg; 
/*  158 */       return Lisp.type_error(arg, Symbol.REAL);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  164 */       return first.isGreaterThan(second) ? first : second;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  168 */       LispObject result = args[0];
/*  169 */       if (!result.realp())
/*  170 */         Lisp.type_error(result, Symbol.REAL); 
/*  171 */       for (int i = 1; i < args.length; i++) {
/*  172 */         if (args[i].isGreaterThan(result))
/*  173 */           result = args[i]; 
/*      */       } 
/*  175 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  180 */   private static final Primitive IDENTITY = new pf_identity();
/*      */   
/*      */   private static final class pf_identity extends Primitive { pf_identity() {
/*  183 */       super(Symbol.IDENTITY, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  188 */       return arg;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  193 */   private static final Primitive COMPILED_FUNCTION_P = new pf_compiled_function_p();
/*      */   
/*      */   private static final class pf_compiled_function_p extends Primitive { pf_compiled_function_p() {
/*  196 */       super(Symbol.COMPILED_FUNCTION_P, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  201 */       return arg.typep(Symbol.COMPILED_FUNCTION);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  206 */   private static final Primitive COMPILED_LISP_FUNCTION_P = new pf_compiled_lisp_function_p();
/*      */   
/*      */   private static final class pf_compiled_lisp_function_p extends Primitive {
/*      */     pf_compiled_lisp_function_p() {
/*  210 */       super(Symbol.COMPILED_LISP_FUNCTION_P, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  215 */       return (arg instanceof CompiledClosure || arg instanceof CompiledPrimitive) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*  221 */   private static final Primitive CONSP = new pf_consp();
/*      */   
/*      */   private static final class pf_consp extends Primitive { pf_consp() {
/*  224 */       super(Symbol.CONSP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  229 */       return (arg instanceof Cons) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  234 */   private static final Primitive LISTP = new pf_listp();
/*      */   
/*      */   private static final class pf_listp extends Primitive { pf_listp() {
/*  237 */       super(Symbol.LISTP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  242 */       return arg.LISTP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  247 */   private static final Primitive ABS = new pf_abs();
/*      */   
/*      */   private static final class pf_abs extends Primitive { pf_abs() {
/*  250 */       super(Symbol.ABS, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  255 */       return arg.ABS();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  260 */   private static final Primitive ARRAYP = new pf_arrayp();
/*      */   
/*      */   private static final class pf_arrayp extends Primitive { pf_arrayp() {
/*  263 */       super(Symbol.ARRAYP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  268 */       return (arg instanceof AbstractArray) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  273 */   private static final Primitive ARRAY_HAS_FILL_POINTER_P = new pf_array_has_fill_pointer_p();
/*      */   
/*      */   private static final class pf_array_has_fill_pointer_p extends Primitive { pf_array_has_fill_pointer_p() {
/*  276 */       super(Symbol.ARRAY_HAS_FILL_POINTER_P, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  281 */       return Lisp.checkArray(arg).hasFillPointer() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  286 */   private static final Primitive VECTORP = new pf_vectorp();
/*      */   
/*      */   private static final class pf_vectorp extends Primitive { pf_vectorp() {
/*  289 */       super(Symbol.VECTORP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  294 */       return arg.VECTORP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  299 */   private static final Primitive SIMPLE_VECTOR_P = new pf_simple_vector_p();
/*      */   
/*      */   private static final class pf_simple_vector_p extends Primitive { pf_simple_vector_p() {
/*  302 */       super(Symbol.SIMPLE_VECTOR_P, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  307 */       return (arg instanceof SimpleVector) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  312 */   private static final Primitive BIT_VECTOR_P = new pf_bit_vector_p();
/*      */   
/*      */   private static final class pf_bit_vector_p extends Primitive { pf_bit_vector_p() {
/*  315 */       super(Symbol.BIT_VECTOR_P, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  320 */       return (arg instanceof AbstractBitVector) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  325 */   private static final Primitive SIMPLE_BIT_VECTOR_P = new pf_simple_bit_vector_p();
/*      */   
/*      */   private static final class pf_simple_bit_vector_p extends Primitive { pf_simple_bit_vector_p() {
/*  328 */       super(Symbol.SIMPLE_BIT_VECTOR_P, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  333 */       return arg.typep(Symbol.SIMPLE_BIT_VECTOR);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  338 */   private static final Primitive _EVAL = new pf__eval();
/*      */   
/*      */   private static final class pf__eval extends Primitive { pf__eval() {
/*  341 */       super("%eval", Lisp.PACKAGE_SYS, false, "form");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  346 */       return Lisp.eval(arg, new Environment(), LispThread.currentThread());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  351 */   private static final Primitive EQ = new pf_eq();
/*      */   
/*      */   private static final class pf_eq extends Primitive { pf_eq() {
/*  354 */       super(Symbol.EQ, "x y");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  361 */       return (first == second) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  366 */   static final Primitive EQL = new pf_eql();
/*      */   
/*      */   private static final class pf_eql extends Primitive { pf_eql() {
/*  369 */       super(Symbol.EQL, "x y");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  376 */       return first.eql(second) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  381 */   private static final Primitive EQUAL = new pf_equal();
/*      */   
/*      */   private static final class pf_equal extends Primitive { pf_equal() {
/*  384 */       super(Symbol.EQUAL, "x y");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  391 */       return first.equal(second) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  396 */   private static final Primitive EQUALP = new pf_equalp();
/*      */   
/*      */   private static final class pf_equalp extends Primitive { pf_equalp() {
/*  399 */       super(Symbol.EQUALP, "x y");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  406 */       return first.equalp(second) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  411 */   public static final Primitive VALUES = new pf_values();
/*      */   
/*      */   private static final class pf_values extends Primitive { pf_values() {
/*  414 */       super(Symbol.VALUES, "&rest object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*  419 */       return LispThread.currentThread().setValues();
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  423 */       return LispThread.currentThread().setValues(arg);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  427 */       return LispThread.currentThread().setValues(first, second);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*  432 */       return LispThread.currentThread().setValues(first, second, third);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/*  437 */       return LispThread.currentThread().setValues(first, second, third, fourth);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  442 */       return LispThread.currentThread().setValues(args);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  448 */   private static final Primitive VALUES_LIST = new pf_values_list();
/*      */   
/*      */   private static final class pf_values_list extends Primitive { pf_values_list() {
/*  451 */       super(Symbol.VALUES_LIST, "list");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  456 */       if (arg == Lisp.NIL)
/*  457 */         return LispThread.currentThread().setValues(); 
/*  458 */       if (arg.cdr() == Lisp.NIL)
/*  459 */         return arg.car(); 
/*  460 */       return LispThread.currentThread().setValues(arg.copyToArray());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  465 */   private static final Primitive CONS = new pf_cons();
/*      */   
/*      */   private static final class pf_cons extends Primitive { pf_cons() {
/*  468 */       super(Symbol.CONS, "object-1 object-2");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  475 */       return new Cons(first, second);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  480 */   private static final Primitive LENGTH = new pf_length();
/*      */   
/*      */   private static final class pf_length extends Primitive { pf_length() {
/*  483 */       super("%LENGTH", Lisp.PACKAGE_SYS, false, "sequence");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  488 */       return arg.LENGTH();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  493 */   private static final Primitive ELT = new pf_elt();
/*      */   
/*      */   private static final class pf_elt extends Primitive { pf_elt() {
/*  496 */       super("%ELT", Lisp.PACKAGE_SYS, false, "sequence index");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  503 */       return first.elt(Fixnum.getValue(second));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  508 */   private static final Primitive ATOM = new pf_atom();
/*      */   
/*      */   private static final class pf_atom extends Primitive { pf_atom() {
/*  511 */       super(Symbol.ATOM, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  516 */       return (arg instanceof Cons) ? Lisp.NIL : Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  521 */   private static final Primitive CONSTANTP = new pf_constantp();
/*      */   
/*      */   private static final class pf_constantp extends Primitive { pf_constantp() {
/*  524 */       super(Symbol.CONSTANTP, "form &optional environment");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  529 */       return arg.constantp() ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  535 */       return first.constantp() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  540 */   private static final Primitive FUNCTIONP = new pf_functionp();
/*      */   
/*      */   private static final class pf_functionp extends Primitive { pf_functionp() {
/*  543 */       super(Symbol.FUNCTIONP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  548 */       return (arg instanceof Function || arg instanceof FuncallableStandardObject) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  553 */   private static final Primitive SPECIAL_OPERATOR_P = new pf_special_operator_p();
/*      */   
/*      */   private static final class pf_special_operator_p extends Primitive { pf_special_operator_p() {
/*  556 */       super(Symbol.SPECIAL_OPERATOR_P, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  561 */       return arg.isSpecialOperator() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  566 */   private static final Primitive SYMBOLP = new pf_symbolp();
/*      */   
/*      */   private static final class pf_symbolp extends Primitive { pf_symbolp() {
/*  569 */       super(Symbol.SYMBOLP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  574 */       return (arg instanceof Symbol) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  579 */   private static final Primitive ENDP = new pf_endp();
/*      */   
/*      */   private static final class pf_endp extends Primitive { pf_endp() {
/*  582 */       super(Symbol.ENDP, "list");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  587 */       return arg.endp() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  592 */   private static final Primitive NULL = new pf_null();
/*      */   
/*      */   private static final class pf_null extends Primitive { pf_null() {
/*  595 */       super(Symbol.NULL, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  600 */       return (arg == Lisp.NIL) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  605 */   private static final Primitive NOT = new pf_not();
/*      */   
/*      */   private static final class pf_not extends Primitive { pf_not() {
/*  608 */       super(Symbol.NOT, "x");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  613 */       return (arg == Lisp.NIL) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  618 */   private static final Primitive PLUSP = new pf_plusp();
/*      */   
/*      */   private static final class pf_plusp extends Primitive { pf_plusp() {
/*  621 */       super(Symbol.PLUSP, "real");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  626 */       return arg.PLUSP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  631 */   private static final Primitive MINUSP = new pf_minusp();
/*      */   
/*      */   private static final class pf_minusp extends Primitive { pf_minusp() {
/*  634 */       super(Symbol.MINUSP, "real");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  639 */       return arg.MINUSP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  644 */   private static final Primitive ZEROP = new pf_zerop();
/*      */   
/*      */   private static final class pf_zerop extends Primitive { pf_zerop() {
/*  647 */       super(Symbol.ZEROP, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  652 */       return arg.ZEROP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  657 */   private static final Primitive FIXNUMP = new pf_fixnump();
/*      */   
/*      */   private static final class pf_fixnump extends Primitive { pf_fixnump() {
/*  660 */       super("fixnump", Lisp.PACKAGE_EXT, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  665 */       return (arg instanceof Fixnum) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  670 */   private static final Primitive SYMBOL_VALUE = new pf_symbol_value();
/*      */   
/*      */   private static final class pf_symbol_value extends Primitive { pf_symbol_value() {
/*  673 */       super(Symbol.SYMBOL_VALUE, "symbol");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  679 */       LispObject value = Lisp.checkSymbol(arg).symbolValue();
/*  680 */       return value;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  685 */   private static final Primitive SET = new pf_set();
/*      */   
/*      */   private static final class pf_set extends Primitive { pf_set() {
/*  688 */       super(Symbol.SET, "symbol value");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  695 */       return LispThread.currentThread().setSpecialVariable(Lisp.checkSymbol(first), second);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  701 */   private static final Primitive RPLACA = new pf_rplaca();
/*      */   
/*      */   private static final class pf_rplaca extends Primitive { pf_rplaca() {
/*  704 */       super(Symbol.RPLACA, "cons object");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  711 */       first.setCar(second);
/*  712 */       return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  717 */   private static final Primitive RPLACD = new pf_rplacd();
/*      */   
/*      */   private static final class pf_rplacd extends Primitive { pf_rplacd() {
/*  720 */       super(Symbol.RPLACD, "cons object");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  727 */       first.setCdr(second);
/*  728 */       return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  733 */   private static final Primitive ADD = new pf_add();
/*      */   
/*      */   private static final class pf_add extends Primitive { pf_add() {
/*  736 */       super(Symbol.PLUS, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*  741 */       return Fixnum.ZERO;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  745 */       if (arg.numberp())
/*  746 */         return arg; 
/*  747 */       return Lisp.type_error(arg, Symbol.NUMBER);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  753 */       return first.add(second);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/*  760 */       return first.add(second).add(third);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  764 */       LispObject result = Fixnum.ZERO;
/*  765 */       int length = args.length;
/*  766 */       for (int i = 0; i < length; i++)
/*  767 */         result = result.add(args[i]); 
/*  768 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  773 */   private static final Primitive ONE_PLUS = new pf_one_plus();
/*      */   
/*      */   private static final class pf_one_plus extends Primitive { pf_one_plus() {
/*  776 */       super(Symbol.ONE_PLUS, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  781 */       return arg.incr();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  786 */   private static final Primitive SUBTRACT = new pf_subtract();
/*      */   
/*      */   private static final class pf_subtract extends Primitive { pf_subtract() {
/*  789 */       super(Symbol.MINUS, "minuend &rest subtrahends");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/*  794 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  798 */       return arg.negate();
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  804 */       return first.subtract(second);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  808 */       LispObject result = args[0];
/*  809 */       for (int i = 1; i < args.length; i++)
/*  810 */         result = result.subtract(args[i]); 
/*  811 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  816 */   private static final Primitive ONE_MINUS = new pf_one_minus();
/*      */   
/*      */   private static final class pf_one_minus extends Primitive { pf_one_minus() {
/*  819 */       super(Symbol.ONE_MINUS, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  824 */       return arg.decr();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  829 */   private static final SpecialOperator WHEN = new sf_when();
/*      */   
/*      */   private static final class sf_when extends SpecialOperator { sf_when() {
/*  832 */       super(Symbol.WHEN);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/*  839 */       if (args == Lisp.NIL)
/*  840 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/*  841 */       LispThread thread = LispThread.currentThread();
/*  842 */       if (Lisp.eval(args.car(), env, thread) != Lisp.NIL) {
/*  843 */         args = args.cdr();
/*  844 */         thread.clearValues();
/*  845 */         return Lisp.progn(args, env, thread);
/*      */       } 
/*  847 */       return thread.setValues(Lisp.NIL);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  852 */   private static final SpecialOperator UNLESS = new sf_unless();
/*      */   
/*      */   private static final class sf_unless extends SpecialOperator { sf_unless() {
/*  855 */       super(Symbol.UNLESS);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/*  862 */       if (args == Lisp.NIL)
/*  863 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/*  864 */       LispThread thread = LispThread.currentThread();
/*  865 */       if (Lisp.eval(args.car(), env, thread) == Lisp.NIL) {
/*  866 */         args = args.cdr();
/*  867 */         thread.clearValues();
/*  868 */         return Lisp.progn(args, env, thread);
/*      */       } 
/*  870 */       return thread.setValues(Lisp.NIL);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  875 */   private static final Primitive _STREAM_OUTPUT_OBJECT = new pf__stream_output_object();
/*      */   
/*      */   private static final class pf__stream_output_object extends Primitive { pf__stream_output_object() {
/*  878 */       super("%stream-output-object", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*  885 */       Lisp.checkStream(second)._writeString(first.printObject());
/*  886 */       return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  891 */   private static final Primitive _OUTPUT_OBJECT = new pf__output_object();
/*      */   
/*      */   private static final class pf__output_object extends Primitive { pf__output_object() {
/*  894 */       super("%output-object", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       LispObject out;
/*  902 */       if (second == Lisp.T) {
/*  903 */         out = Symbol.TERMINAL_IO.symbolValue();
/*  904 */       } else if (second == Lisp.NIL) {
/*  905 */         out = Symbol.STANDARD_OUTPUT.symbolValue();
/*      */       } else {
/*  907 */         out = second;
/*  908 */       }  String output = first.printObject();
/*  909 */       Lisp.checkStream(out)._writeString(output);
/*  910 */       return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  915 */   private static final Primitive _WRITE_TO_STRING = new pf__write_to_string();
/*      */   
/*      */   private static final class pf__write_to_string extends Primitive { pf__write_to_string() {
/*  918 */       super("%write-to-string", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  923 */       return new SimpleString(arg.printObject());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  928 */   private static final Primitive _STREAM_TERPRI = new pf__stream_terpri();
/*      */   
/*      */   private static final class pf__stream_terpri extends Primitive { pf__stream_terpri() {
/*  931 */       super("%stream-terpri", Lisp.PACKAGE_SYS, true, "output-stream");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  936 */       Lisp.checkStream(arg)._writeChar('\n');
/*  937 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*  942 */   private static final Primitive _TERPRI = new pf__terpri();
/*      */   
/*      */   private static final class pf__terpri extends Primitive { pf__terpri() {
/*  945 */       super("%terpri", Lisp.PACKAGE_SYS, false, "output-stream");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  950 */       if (arg == Lisp.T) {
/*  951 */         arg = Symbol.TERMINAL_IO.symbolValue();
/*  952 */       } else if (arg == Lisp.NIL) {
/*  953 */         arg = Symbol.STANDARD_OUTPUT.symbolValue();
/*      */       } 
/*  955 */       Stream stream = Lisp.checkStream(arg);
/*  956 */       return stream.terpri();
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  962 */   private static final Primitive _FRESH_LINE = new pf__fresh_line();
/*      */   
/*      */   private static final class pf__fresh_line extends Primitive { pf__fresh_line() {
/*  965 */       super("%fresh-line", Lisp.PACKAGE_SYS, false, "output-stream");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  970 */       if (arg == Lisp.T) {
/*  971 */         arg = Symbol.TERMINAL_IO.symbolValue();
/*  972 */       } else if (arg == Lisp.NIL) {
/*  973 */         arg = Symbol.STANDARD_OUTPUT.symbolValue();
/*      */       } 
/*  975 */       Stream stream = Lisp.checkStream(arg);
/*  976 */       return stream.freshLine();
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  983 */   private static final Primitive BOUNDP = new pf_boundp();
/*      */   
/*      */   private static final class pf_boundp extends Primitive { pf_boundp() {
/*  986 */       super(Symbol.BOUNDP, "symbol");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  992 */       Symbol symbol = Lisp.checkSymbol(arg);
/*      */ 
/*      */ 
/*      */ 
/*      */       
/*  997 */       SpecialBinding binding = LispThread.currentThread().getSpecialBinding(symbol);
/*  998 */       if (binding != null) {
/*  999 */         return (binding.value != null) ? Lisp.T : Lisp.NIL;
/*      */       }
/* 1001 */       return (symbol.getSymbolValue() != null) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1006 */   private static final Primitive FBOUNDP = new pf_fboundp();
/*      */   
/*      */   private static final class pf_fboundp extends Primitive { pf_fboundp() {
/* 1009 */       super(Symbol.FBOUNDP, "name");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1014 */       if (arg instanceof Symbol)
/* 1015 */         return (arg.getSymbolFunction() != null) ? Lisp.T : Lisp.NIL; 
/* 1016 */       if (Lisp.isValidSetfFunctionName(arg)) {
/* 1017 */         LispObject f = Lisp.get(arg.cadr(), Symbol.SETF_FUNCTION, null);
/* 1018 */         return (f != null) ? Lisp.T : Lisp.NIL;
/*      */       } 
/* 1020 */       return Lisp.type_error(arg, Lisp.FUNCTION_NAME);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1025 */   private static final Primitive FMAKUNBOUND = new pf_fmakunbound();
/*      */   
/*      */   private static final class pf_fmakunbound extends Primitive { pf_fmakunbound() {
/* 1028 */       super(Symbol.FMAKUNBOUND, "name");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1033 */       if (arg instanceof Symbol) {
/* 1034 */         Lisp.checkSymbol(arg).setSymbolFunction((LispObject)null);
/* 1035 */         return arg;
/*      */       } 
/* 1037 */       if (Lisp.isValidSetfFunctionName(arg)) {
/* 1038 */         Lisp.remprop((Symbol)arg.cadr(), Symbol.SETF_FUNCTION);
/* 1039 */         return arg;
/*      */       } 
/* 1041 */       return Lisp.type_error(arg, Lisp.FUNCTION_NAME);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1046 */   private static final Primitive SETF_FUNCTION_NAME_P = new pf_setf_function_name_p();
/*      */   
/*      */   private static final class pf_setf_function_name_p extends Primitive { pf_setf_function_name_p() {
/* 1049 */       super("setf-function-name-p", Lisp.PACKAGE_SYS, true, "thing");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1054 */       return Lisp.isValidSetfFunctionName(arg) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1059 */   private static final Primitive REMPROP = new pf_remprop();
/*      */   
/*      */   private static final class pf_remprop extends Primitive { pf_remprop() {
/* 1062 */       super(Symbol.REMPROP, "symbol indicator");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1069 */       return Lisp.remprop(Lisp.checkSymbol(first), second);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1074 */   public static final Primitive APPEND = new pf_append();
/*      */   
/*      */   private static final class pf_append extends Primitive { pf_append() {
/* 1077 */       super(Symbol.APPEND, "&rest lists");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1082 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1086 */       return arg;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1092 */       if (first == Lisp.NIL) {
/* 1093 */         return second;
/*      */       }
/* 1095 */       Cons result = new Cons(first.car());
/* 1096 */       Cons splice = result;
/* 1097 */       first = first.cdr();
/* 1098 */       while (first != Lisp.NIL) {
/* 1099 */         Cons temp = new Cons(first.car());
/* 1100 */         splice.cdr = temp;
/* 1101 */         splice = temp;
/* 1102 */         first = first.cdr();
/*      */       } 
/* 1104 */       splice.cdr = second;
/* 1105 */       return result;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1112 */       if (first == Lisp.NIL)
/* 1113 */         return execute(second, third); 
/* 1114 */       Cons result = new Cons(first.car());
/* 1115 */       Cons splice = result;
/* 1116 */       first = first.cdr();
/* 1117 */       while (first != Lisp.NIL) {
/* 1118 */         Cons temp = new Cons(first.car());
/* 1119 */         splice.cdr = temp;
/* 1120 */         splice = temp;
/* 1121 */         first = first.cdr();
/*      */       } 
/* 1123 */       while (second != Lisp.NIL) {
/* 1124 */         Cons temp = new Cons(second.car());
/* 1125 */         splice.cdr = temp;
/* 1126 */         splice = temp;
/* 1127 */         second = second.cdr();
/*      */       } 
/* 1129 */       splice.cdr = third;
/* 1130 */       return result;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1134 */       Cons result = null;
/* 1135 */       Cons splice = null;
/* 1136 */       int limit = args.length - 1;
/*      */       int i;
/* 1138 */       for (i = 0; i < limit; ) {
/* 1139 */         LispObject top = args[i];
/* 1140 */         if (top == Lisp.NIL) {
/*      */           i++; continue;
/* 1142 */         }  result = new Cons(top.car());
/* 1143 */         splice = result;
/* 1144 */         top = top.cdr();
/* 1145 */         while (top != Lisp.NIL) {
/* 1146 */           Cons temp = new Cons(top.car());
/* 1147 */           splice.cdr = temp;
/* 1148 */           splice = temp;
/* 1149 */           top = top.cdr();
/*      */         } 
/*      */       } 
/*      */       
/* 1153 */       if (result == null)
/* 1154 */         return args[i]; 
/* 1155 */       for (; ++i < limit; i++) {
/* 1156 */         LispObject top = args[i];
/* 1157 */         while (top != Lisp.NIL) {
/* 1158 */           Cons temp = new Cons(top.car());
/* 1159 */           splice.cdr = temp;
/* 1160 */           splice = temp;
/* 1161 */           top = top.cdr();
/*      */         } 
/*      */       } 
/* 1164 */       splice.cdr = args[i];
/* 1165 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1170 */   private static final Primitive NCONC = new pf_nconc();
/*      */   
/*      */   private static final class pf_nconc extends Primitive { pf_nconc() {
/* 1173 */       super(Symbol.NCONC, "&rest lists");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1178 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1182 */       return arg;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1188 */       if (first == Lisp.NIL)
/* 1189 */         return second; 
/* 1190 */       if (first instanceof Cons) {
/* 1191 */         LispObject result = first;
/* 1192 */         Cons splice = null;
/* 1193 */         while (first instanceof Cons) {
/* 1194 */           splice = (Cons)first;
/* 1195 */           first = splice.cdr;
/*      */         } 
/* 1197 */         splice.cdr = second;
/* 1198 */         return result;
/*      */       } 
/* 1200 */       return Lisp.type_error(first, Symbol.LIST);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1204 */       LispObject result = null;
/* 1205 */       Cons splice = null;
/* 1206 */       int limit = array.length - 1;
/*      */       int i;
/* 1208 */       for (i = 0; i < limit; i++) {
/* 1209 */         LispObject list = array[i];
/* 1210 */         if (list != Lisp.NIL)
/*      */         {
/* 1212 */           if (list instanceof Cons) {
/* 1213 */             if (splice != null) {
/* 1214 */               splice.cdr = list;
/* 1215 */               splice = (Cons)list;
/*      */             } 
/* 1217 */             while (list instanceof Cons) {
/* 1218 */               if (result == null) {
/* 1219 */                 result = list;
/* 1220 */                 splice = (Cons)result;
/*      */               } else {
/* 1222 */                 splice = (Cons)list;
/* 1223 */               }  list = splice.cdr;
/*      */             } 
/*      */           } else {
/* 1226 */             Lisp.type_error(list, Symbol.LIST);
/*      */           }  } 
/* 1228 */       }  if (result == null)
/* 1229 */         return array[i]; 
/* 1230 */       splice.cdr = array[i];
/* 1231 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1237 */   private static final Primitive EQUALS = new pf_equals();
/*      */   
/*      */   private static final class pf_equals extends Primitive { pf_equals() {
/* 1240 */       super(Symbol.EQUALS, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1245 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1249 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1255 */       return first.isEqualTo(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1262 */       if (first.isEqualTo(second) && second.isEqualTo(third)) {
/* 1263 */         return Lisp.T;
/*      */       }
/* 1265 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1269 */       int length = array.length;
/* 1270 */       LispObject obj = array[0];
/* 1271 */       for (int i = 1; i < length; i++) {
/* 1272 */         if (array[i].isNotEqualTo(obj))
/* 1273 */           return Lisp.NIL; 
/*      */       } 
/* 1275 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1281 */   private static final Primitive NOT_EQUALS = new pf_not_equals();
/*      */   
/*      */   private static final class pf_not_equals extends Primitive { pf_not_equals() {
/* 1284 */       super(Symbol.NOT_EQUALS, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1289 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1293 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1299 */       return first.isNotEqualTo(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1306 */       if (first.isEqualTo(second))
/* 1307 */         return Lisp.NIL; 
/* 1308 */       if (first.isEqualTo(third))
/* 1309 */         return Lisp.NIL; 
/* 1310 */       if (second.isEqualTo(third))
/* 1311 */         return Lisp.NIL; 
/* 1312 */       return Lisp.T;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1316 */       int length = array.length;
/* 1317 */       for (int i = 0; i < length; i++) {
/* 1318 */         LispObject obj = array[i];
/* 1319 */         for (int j = i + 1; j < length; j++) {
/* 1320 */           if (array[j].isEqualTo(obj))
/* 1321 */             return Lisp.NIL; 
/*      */         } 
/*      */       } 
/* 1324 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1330 */   private static final Primitive LT = new pf_lt();
/*      */   
/*      */   private static final class pf_lt extends Primitive { pf_lt() {
/* 1333 */       super(Symbol.LT, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1338 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1342 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1348 */       return first.isLessThan(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1355 */       if (first.isLessThan(second) && second.isLessThan(third)) {
/* 1356 */         return Lisp.T;
/*      */       }
/* 1358 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1362 */       int length = array.length;
/* 1363 */       for (int i = 1; i < length; i++) {
/* 1364 */         if (array[i].isLessThanOrEqualTo(array[i - 1]))
/* 1365 */           return Lisp.NIL; 
/*      */       } 
/* 1367 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1372 */   private static final Primitive LE = new pf_le();
/*      */   
/*      */   private static final class pf_le extends Primitive { pf_le() {
/* 1375 */       super(Symbol.LE, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1380 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1384 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1390 */       return first.isLessThanOrEqualTo(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1397 */       if (first.isLessThanOrEqualTo(second) && second.isLessThanOrEqualTo(third)) {
/* 1398 */         return Lisp.T;
/*      */       }
/* 1400 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1404 */       int length = array.length;
/* 1405 */       for (int i = 1; i < length; i++) {
/* 1406 */         if (array[i].isLessThan(array[i - 1]))
/* 1407 */           return Lisp.NIL; 
/*      */       } 
/* 1409 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1414 */   private static final Primitive GT = new pf_gt();
/*      */   
/*      */   private static final class pf_gt extends Primitive { pf_gt() {
/* 1417 */       super(Symbol.GT, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1422 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1426 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1432 */       return first.isGreaterThan(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1439 */       if (first.isGreaterThan(second) && second.isGreaterThan(third)) {
/* 1440 */         return Lisp.T;
/*      */       }
/* 1442 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1446 */       int length = array.length;
/* 1447 */       for (int i = 1; i < length; i++) {
/* 1448 */         if (array[i].isGreaterThanOrEqualTo(array[i - 1]))
/* 1449 */           return Lisp.NIL; 
/*      */       } 
/* 1451 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1456 */   private static final Primitive GE = new pf_ge();
/*      */   
/*      */   private static final class pf_ge extends Primitive { pf_ge() {
/* 1459 */       super(Symbol.GE, "&rest numbers");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 1464 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1468 */       return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1474 */       return first.isGreaterThanOrEqualTo(second) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1481 */       if (first.isGreaterThanOrEqualTo(second) && second.isGreaterThanOrEqualTo(third)) {
/* 1482 */         return Lisp.T;
/*      */       }
/* 1484 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] array) {
/* 1488 */       int length = array.length;
/* 1489 */       for (int i = 1; i < length; i++) {
/* 1490 */         if (array[i].isGreaterThan(array[i - 1]))
/* 1491 */           return Lisp.NIL; 
/*      */       } 
/* 1493 */       return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1498 */   private static final Primitive NTH = new pf_nth();
/*      */   
/*      */   private static final class pf_nth extends Primitive { pf_nth() {
/* 1501 */       super(Symbol.NTH, "n list");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1508 */       return second.NTH(first);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1513 */   private static final Primitive _SET_NTH = new pf__set_nth();
/*      */   
/*      */   private static final class pf__set_nth extends Primitive { pf__set_nth() {
/* 1516 */       super("%set-nth", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1524 */       int index = Fixnum.getValue(first);
/* 1525 */       if (index < 0)
/* 1526 */         Lisp.error(new TypeError("(SETF NTH): invalid index " + index + ".")); 
/* 1527 */       int i = 0;
/*      */       while (true) {
/* 1529 */         if (i == index) {
/* 1530 */           second.setCar(third);
/* 1531 */           return third;
/*      */         } 
/* 1533 */         second = second.cdr();
/* 1534 */         if (second == Lisp.NIL) {
/* 1535 */           return Lisp.error(new LispError("(SETF NTH): the index " + index + "is too large."));
/*      */         }
/*      */         
/* 1538 */         i++;
/*      */       } 
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1544 */   private static final Primitive NTHCDR = new pf_nthcdr();
/*      */   
/*      */   private static final class pf_nthcdr extends Primitive { pf_nthcdr() {
/* 1547 */       super(Symbol.NTHCDR, "n list");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1554 */       int index = Fixnum.getValue(first);
/* 1555 */       if (index < 0)
/* 1556 */         return Lisp.type_error(first, 
/* 1557 */             Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.ZERO })); 
/* 1558 */       for (int i = 0; i < index; i++) {
/* 1559 */         second = second.cdr();
/* 1560 */         if (second == Lisp.NIL)
/* 1561 */           return Lisp.NIL; 
/*      */       } 
/* 1563 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1569 */   private static final Primitive ERROR = new pf_error();
/*      */   
/*      */   private static final class pf_error extends Primitive { pf_error() {
/* 1572 */       super(Symbol.ERROR, "datum &rest arguments");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1578 */       Error e = new IntegrityError();
/*      */       
/* 1580 */       e.printStackTrace();
/*      */       
/* 1582 */       System.out.println("ERROR placeholder called with arguments:");
/*      */       
/* 1584 */       if (args.length == 1 && args[0] instanceof Condition) {
/* 1585 */         System.out.println(args[0].princToString());
/* 1586 */         System.out.println(((Condition)args[0]).getConditionReport());
/*      */       } else {
/* 1588 */         for (LispObject a : args)
/* 1589 */           System.out.println(a.princToString()); 
/*      */       } 
/* 1591 */       throw e;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1597 */   private static final Primitive AUTOCOMPILE = new pf_autocompile();
/*      */   
/*      */   private static final class pf_autocompile extends Primitive { pf_autocompile() {
/* 1600 */       super(Symbol.AUTOCOMPILE, "function");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject function) {
/* 1605 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1616 */   private static final Primitive SIGNAL = new pf_signal();
/*      */   
/*      */   private static final class pf_signal extends Primitive { pf_signal() {
/* 1619 */       super(Symbol.SIGNAL, "datum &rest arguments");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1624 */       if (args.length < 1)
/* 1625 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 1626 */       if (args[0] instanceof Condition)
/* 1627 */         return Lisp.error(args[0]); 
/* 1628 */       return Lisp.error(new SimpleCondition());
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1634 */   private static final Primitive UNDEFINED_FUNCTION_CALLED = new pf_undefined_function_called();
/*      */   
/*      */   private static final class pf_undefined_function_called extends Primitive { pf_undefined_function_called() {
/* 1637 */       super(Symbol.UNDEFINED_FUNCTION_CALLED, "name arguments");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1644 */       return Lisp.error(new UndefinedFunction(first));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1649 */   private static final Primitive _FORMAT = new pf__format();
/*      */   
/*      */   private static final class pf__format extends Primitive { pf__format() {
/* 1652 */       super("%format", Lisp.PACKAGE_SYS, false, "destination control-string &rest args");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1661 */       LispObject destination = first;
/*      */       
/* 1663 */       LispObject[] _args = new LispObject[2];
/* 1664 */       _args[0] = second;
/* 1665 */       _args[1] = third;
/* 1666 */       String s = _format(_args);
/* 1667 */       return outputFormattedString(s, destination);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 1674 */       LispObject destination = first;
/*      */       
/* 1676 */       LispObject[] _args = new LispObject[3];
/* 1677 */       _args[0] = second;
/* 1678 */       _args[1] = third;
/* 1679 */       _args[2] = fourth;
/* 1680 */       String s = _format(_args);
/* 1681 */       return outputFormattedString(s, destination);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1685 */       if (args.length < 2)
/* 1686 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/* 1687 */       LispObject destination = args[0];
/*      */       
/* 1689 */       LispObject[] _args = new LispObject[args.length - 1];
/* 1690 */       for (int i = 0; i < _args.length; i++)
/* 1691 */         _args[i] = args[i + 1]; 
/* 1692 */       String s = _format(_args);
/* 1693 */       return outputFormattedString(s, destination);
/*      */     }
/*      */ 
/*      */     
/*      */     private final String _format(LispObject[] args) {
/* 1698 */       LispObject formatControl = args[0];
/* 1699 */       LispObject formatArguments = Lisp.NIL;
/* 1700 */       for (int i = 1; i < args.length; i++)
/* 1701 */         formatArguments = new Cons(args[i], formatArguments); 
/* 1702 */       formatArguments = formatArguments.nreverse();
/* 1703 */       return Lisp.format(formatControl, formatArguments);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     private final LispObject outputFormattedString(String s, LispObject destination) {
/* 1709 */       if (destination == Lisp.T) {
/* 1710 */         Lisp.checkCharacterOutputStream(Symbol.STANDARD_OUTPUT.symbolValue())._writeString(s);
/* 1711 */         return Lisp.NIL;
/*      */       } 
/* 1713 */       if (destination == Lisp.NIL)
/* 1714 */         return new SimpleString(s); 
/* 1715 */       if (destination instanceof TwoWayStream) {
/* 1716 */         Stream out = ((TwoWayStream)destination).getOutputStream();
/* 1717 */         if (out instanceof Stream) {
/* 1718 */           out._writeString(s);
/* 1719 */           return Lisp.NIL;
/*      */         } 
/* 1721 */         Lisp.error(new TypeError("The value " + destination
/* 1722 */               .princToString() + " is not a character output stream."));
/*      */       } 
/*      */       
/* 1725 */       if (destination instanceof Stream) {
/* 1726 */         ((Stream)destination)._writeString(s);
/* 1727 */         return Lisp.NIL;
/*      */       } 
/* 1729 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/*      */   static void checkRedefinition(LispObject arg) {
/* 1735 */     LispThread thread = LispThread.currentThread();
/* 1736 */     if (Lisp._WARN_ON_REDEFINITION_.symbolValue(thread) != Lisp.NIL && 
/* 1737 */       arg instanceof Symbol) {
/* 1738 */       LispObject oldDefinition = arg.getSymbolFunction();
/* 1739 */       if (oldDefinition != null && !(oldDefinition instanceof Autoload)) {
/*      */ 
/*      */         
/* 1742 */         LispObject oldSource = Extensions.SOURCE_PATHNAME.execute(arg);
/* 1743 */         LispObject currentSource = Lisp._SOURCE_.symbolValue(thread);
/* 1744 */         if (currentSource == Lisp.NIL)
/* 1745 */           currentSource = Keyword.TOP_LEVEL; 
/* 1746 */         if (oldSource != Lisp.NIL && 
/* 1747 */           currentSource.equal(oldSource)) {
/*      */           return;
/*      */         }
/* 1750 */         if (currentSource == Keyword.TOP_LEVEL) {
/* 1751 */           Symbol.STYLE_WARN.execute(new SimpleString("redefining ~S at top level"), arg);
/*      */         }
/*      */         else {
/*      */           
/* 1755 */           SpecialBindingsMark mark = thread.markSpecialBindings();
/* 1756 */           thread.bindSpecial(Symbol._PACKAGE_, Lisp.PACKAGE_CL);
/*      */           try {
/* 1758 */             Symbol.STYLE_WARN.execute(new SimpleString("redefining ~S in ~S"), arg, currentSource);
/*      */           }
/*      */           finally {
/*      */             
/* 1762 */             thread.resetSpecialBindings(mark);
/*      */           } 
/*      */         } 
/*      */       } 
/*      */     } 
/*      */   }
/*      */ 
/*      */ 
/*      */   
/* 1771 */   private static final Primitive _DEFUN = new pf__defun();
/*      */   
/*      */   private static final class pf__defun extends Primitive { pf__defun() {
/* 1774 */       super("%defun", Lisp.PACKAGE_SYS, true, "name definition");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject name, LispObject definition) {
/* 1781 */       if (name instanceof Symbol) {
/* 1782 */         Symbol symbol = (Symbol)name;
/* 1783 */         if (symbol.getSymbolFunction() instanceof SpecialOperator) {
/* 1784 */           return Lisp.program_error(symbol.getName() + " is a special operator and may not be redefined.");
/*      */         }
/* 1786 */       } else if (!Lisp.isValidSetfFunctionName(name)) {
/* 1787 */         return Lisp.type_error(name, Lisp.FUNCTION_NAME);
/* 1788 */       }  if (definition instanceof Function) {
/* 1789 */         Symbol.FSET.execute(name, definition, Lisp.NIL, ((Function)definition)
/* 1790 */             .getLambdaList());
/* 1791 */         return name;
/*      */       } 
/* 1793 */       return Lisp.type_error(definition, Symbol.FUNCTION);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1798 */   private static final Primitive FDEFINITION_BLOCK_NAME = new pf_fdefinition_block_name();
/*      */   
/*      */   private static final class pf_fdefinition_block_name extends Primitive { pf_fdefinition_block_name() {
/* 1801 */       super("fdefinition-block-name", Lisp.PACKAGE_SYS, true, "function-name");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1806 */       if (arg instanceof Symbol)
/* 1807 */         return arg; 
/* 1808 */       if (Lisp.isValidSetfFunctionName(arg))
/* 1809 */         return arg.cadr(); 
/* 1810 */       return Lisp.type_error(arg, Lisp.FUNCTION_NAME);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1815 */   private static final Primitive MACRO_FUNCTION = new pf_macro_function();
/*      */   
/*      */   private static final class pf_macro_function extends Primitive { pf_macro_function() {
/* 1818 */       super(Symbol.MACRO_FUNCTION, "symbol &optional environment");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1823 */       LispObject obj = arg.getSymbolFunction();
/* 1824 */       if (obj instanceof AutoloadMacro) {
/* 1825 */         ((AutoloadMacro)obj).load();
/* 1826 */         obj = arg.getSymbolFunction();
/*      */       } 
/* 1828 */       if (obj instanceof MacroObject)
/* 1829 */         return ((MacroObject)obj).expander; 
/* 1830 */       if (obj instanceof SpecialOperator) {
/* 1831 */         obj = Lisp.get(arg, Symbol.MACROEXPAND_MACRO, Lisp.NIL);
/* 1832 */         if (obj instanceof AutoloadMacro) {
/* 1833 */           ((AutoloadMacro)obj).load();
/* 1834 */           obj = Lisp.get(arg, Symbol.MACROEXPAND_MACRO, Lisp.NIL);
/*      */         } 
/* 1836 */         if (obj instanceof MacroObject)
/* 1837 */           return ((MacroObject)obj).expander; 
/*      */       } 
/* 1839 */       return Lisp.NIL;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       LispObject obj;
/* 1846 */       if (second != Lisp.NIL) {
/* 1847 */         Environment env = Lisp.checkEnvironment(second);
/* 1848 */         obj = env.lookupFunction(first);
/*      */       } else {
/* 1850 */         obj = first.getSymbolFunction();
/* 1851 */       }  if (obj instanceof AutoloadMacro) {
/* 1852 */         ((AutoloadMacro)obj).load();
/* 1853 */         obj = first.getSymbolFunction();
/*      */       } 
/* 1855 */       if (obj instanceof MacroObject)
/* 1856 */         return ((MacroObject)obj).expander; 
/* 1857 */       if (obj instanceof SpecialOperator) {
/* 1858 */         obj = Lisp.get(first, Symbol.MACROEXPAND_MACRO, Lisp.NIL);
/* 1859 */         if (obj instanceof AutoloadMacro) {
/* 1860 */           ((AutoloadMacro)obj).load();
/* 1861 */           obj = Lisp.get(first, Symbol.MACROEXPAND_MACRO, Lisp.NIL);
/*      */         } 
/* 1863 */         if (obj instanceof MacroObject)
/* 1864 */           return ((MacroObject)obj).expander; 
/*      */       } 
/* 1866 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1871 */   private static final SpecialOperator DEFMACRO = new sf_defmacro();
/*      */   
/*      */   private static final class sf_defmacro extends SpecialOperator { sf_defmacro() {
/* 1874 */       super(Symbol.DEFMACRO);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 1881 */       Symbol symbol = Lisp.checkSymbol(args.car());
/* 1882 */       LispObject expander = Primitives.MAKE_MACRO_EXPANDER.execute(args);
/* 1883 */       Closure expansionFunction = new Closure(expander, env);
/* 1884 */       MacroObject macroObject = new MacroObject(symbol, expansionFunction);
/*      */       
/* 1886 */       if (symbol.getSymbolFunction() instanceof SpecialOperator) {
/* 1887 */         Lisp.put(symbol, Symbol.MACROEXPAND_MACRO, macroObject);
/*      */       } else {
/* 1889 */         symbol.setSymbolFunction(macroObject);
/* 1890 */       }  macroObject.setLambdaList(args.cadr());
/* 1891 */       (LispThread.currentThread())._values = null;
/* 1892 */       return symbol;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1897 */   private static final Primitive MAKE_MACRO = new pf_make_macro();
/*      */   
/*      */   private static final class pf_make_macro extends Primitive { pf_make_macro() {
/* 1900 */       super("make-macro", Lisp.PACKAGE_SYS, true, "name expansion-function");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 1907 */       return new MacroObject(first, second);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1912 */   private static final Primitive MACRO_FUNCTION_P = new pf_macro_function_p();
/*      */   
/*      */   private static final class pf_macro_function_p extends Primitive { pf_macro_function_p() {
/* 1915 */       super("macro-function-p", Lisp.PACKAGE_SYS, true, "value");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1920 */       return (arg instanceof MacroObject) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 1926 */   private static final Primitive MAKE_SYMBOL_MACRO = new pf_make_symbol_macro();
/*      */   
/*      */   private static final class pf_make_symbol_macro extends Primitive { pf_make_symbol_macro() {
/* 1929 */       super("make-symbol-macro", Lisp.PACKAGE_SYS, true, "expansion");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1934 */       return new SymbolMacro(arg);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1939 */   private static final Primitive SET_SYMBOL_MACRO = new pf_set_symbol_macro();
/*      */   
/*      */   private static final class pf_set_symbol_macro extends Primitive { pf_set_symbol_macro() {
/* 1942 */       super("%set-symbol-macro", Lisp.PACKAGE_SYS, false, "symbol symbol-macro");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject sym, LispObject symbolMacro) {
/* 1947 */       Lisp.checkSymbol(sym).setSymbolMacro((SymbolMacro)symbolMacro);
/* 1948 */       return symbolMacro;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1953 */   private static final Primitive SYMBOL_MACRO_P = new pf_symbol_macro_p();
/*      */   
/*      */   private static final class pf_symbol_macro_p extends Primitive { pf_symbol_macro_p() {
/* 1956 */       super("symbol-macro-p", Lisp.PACKAGE_SYS, true, "value");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1961 */       return (arg instanceof SymbolMacro) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1966 */   private static final Primitive _DEFPARAMETER = new pf__defparameter();
/*      */   
/*      */   private static final class pf__defparameter extends Primitive { pf__defparameter() {
/* 1969 */       super("%defparameter", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 1978 */       Symbol symbol = Lisp.checkSymbol(first);
/* 1979 */       if (third instanceof AbstractString) {
/* 1980 */         symbol.setDocumentation(Symbol.VARIABLE, third);
/* 1981 */       } else if (third != Lisp.NIL) {
/* 1982 */         Lisp.type_error(third, Symbol.STRING);
/* 1983 */       }  symbol.initializeSpecial(second);
/* 1984 */       return symbol;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 1989 */   private static final Primitive _DEFVAR = new pf__defvar();
/*      */   
/*      */   private static final class pf__defvar extends Primitive { pf__defvar() {
/* 1992 */       super("%defvar", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1998 */       Symbol symbol = Lisp.checkSymbol(arg);
/* 1999 */       symbol.setSpecial(true);
/* 2000 */       return symbol;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2007 */       Symbol symbol = Lisp.checkSymbol(first);
/* 2008 */       symbol.initializeSpecial(second);
/* 2009 */       return symbol;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2014 */   private static final Primitive _DEFCONSTANT = new pf__defconstant();
/*      */   
/*      */   private static final class pf__defconstant extends Primitive { pf__defconstant() {
/* 2017 */       super("%defconstant", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2026 */       Symbol symbol = Lisp.checkSymbol(first);
/* 2027 */       if (third != Lisp.NIL)
/* 2028 */         if (third instanceof AbstractString) {
/* 2029 */           symbol.setDocumentation(Symbol.VARIABLE, third);
/*      */         } else {
/* 2031 */           return Lisp.type_error(third, Symbol.STRING);
/*      */         }  
/* 2033 */       symbol.initializeConstant(second);
/* 2034 */       return symbol;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2039 */   private static final SpecialOperator COND = new sf_cond();
/*      */   
/*      */   private static final class sf_cond extends SpecialOperator { sf_cond() {
/* 2042 */       super(Symbol.COND, "&rest clauses");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 2048 */       LispThread thread = LispThread.currentThread();
/* 2049 */       LispObject result = Lisp.NIL;
/* 2050 */       while (args != Lisp.NIL) {
/* 2051 */         LispObject clause = args.car();
/* 2052 */         if (!(clause instanceof Cons))
/* 2053 */           return Lisp.error(new ProgramError("COND clause is not a non-empty list: " + clause
/* 2054 */                 .princToString())); 
/* 2055 */         result = Lisp.eval(clause.car(), env, thread);
/* 2056 */         thread._values = null;
/* 2057 */         if (result != Lisp.NIL) {
/* 2058 */           LispObject body = clause.cdr();
/* 2059 */           while (body != Lisp.NIL) {
/* 2060 */             result = Lisp.eval(body.car(), env, thread);
/* 2061 */             body = ((Cons)body).cdr;
/*      */           } 
/* 2063 */           return result;
/*      */         } 
/* 2065 */         args = ((Cons)args).cdr;
/*      */       } 
/* 2067 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2072 */   private static final SpecialOperator CASE = new sf_case();
/*      */   
/*      */   private static final class sf_case extends SpecialOperator { sf_case() {
/* 2075 */       super(Symbol.CASE, "keyform &body cases");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 2082 */       LispThread thread = LispThread.currentThread();
/* 2083 */       LispObject key = Lisp.eval(args.car(), env, thread);
/* 2084 */       args = args.cdr();
/* 2085 */       while (args != Lisp.NIL) {
/* 2086 */         LispObject clause = args.car();
/* 2087 */         LispObject keys = clause.car();
/* 2088 */         boolean match = false;
/* 2089 */         if (keys.listp()) {
/* 2090 */           while (keys != Lisp.NIL) {
/* 2091 */             LispObject candidate = keys.car();
/* 2092 */             if (key.eql(candidate)) {
/* 2093 */               match = true;
/*      */               break;
/*      */             } 
/* 2096 */             keys = keys.cdr();
/*      */           } 
/*      */         } else {
/* 2099 */           LispObject candidate = keys;
/* 2100 */           if (candidate == Lisp.T || candidate == Symbol.OTHERWISE) {
/* 2101 */             match = true;
/* 2102 */           } else if (key.eql(candidate)) {
/* 2103 */             match = true;
/*      */           } 
/* 2105 */         }  if (match) {
/* 2106 */           return Lisp.progn(clause.cdr(), env, thread);
/*      */         }
/* 2108 */         args = args.cdr();
/*      */       } 
/* 2110 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2115 */   private static final SpecialOperator ECASE = new sf_ecase();
/*      */   
/*      */   private static final class sf_ecase extends SpecialOperator { sf_ecase() {
/* 2118 */       super(Symbol.ECASE, "keyform &body cases");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 2125 */       LispThread thread = LispThread.currentThread();
/* 2126 */       LispObject key = Lisp.eval(args.car(), env, thread);
/* 2127 */       LispObject clauses = args.cdr();
/* 2128 */       while (clauses != Lisp.NIL) {
/* 2129 */         LispObject clause = clauses.car();
/* 2130 */         LispObject keys = clause.car();
/* 2131 */         boolean match = false;
/* 2132 */         if (keys.listp()) {
/* 2133 */           while (keys != Lisp.NIL) {
/* 2134 */             LispObject candidate = keys.car();
/* 2135 */             if (key.eql(candidate)) {
/* 2136 */               match = true;
/*      */               break;
/*      */             } 
/* 2139 */             keys = keys.cdr();
/*      */           } 
/*      */         } else {
/* 2142 */           LispObject candidate = keys;
/* 2143 */           if (key.eql(candidate))
/* 2144 */             match = true; 
/*      */         } 
/* 2146 */         if (match) {
/* 2147 */           return Lisp.progn(clause.cdr(), env, thread);
/*      */         }
/* 2149 */         clauses = clauses.cdr();
/*      */       } 
/* 2151 */       LispObject expectedType = Lisp.NIL;
/* 2152 */       clauses = args.cdr();
/* 2153 */       while (clauses != Lisp.NIL) {
/* 2154 */         LispObject clause = clauses.car();
/* 2155 */         LispObject keys = clause.car();
/* 2156 */         if (keys.listp()) {
/* 2157 */           while (keys != Lisp.NIL) {
/* 2158 */             expectedType = expectedType.push(keys.car());
/* 2159 */             keys = keys.cdr();
/*      */           } 
/*      */         } else {
/* 2162 */           expectedType = expectedType.push(keys);
/* 2163 */         }  clauses = clauses.cdr();
/*      */       } 
/* 2165 */       expectedType = expectedType.nreverse();
/* 2166 */       expectedType = expectedType.push(Symbol.MEMBER);
/* 2167 */       return Lisp.type_error(key, expectedType);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2173 */   private static final Primitive UPGRADED_ARRAY_ELEMENT_TYPE = new pf_upgraded_array_element_type();
/*      */   
/*      */   private static final class pf_upgraded_array_element_type extends Primitive { pf_upgraded_array_element_type() {
/* 2176 */       super(Symbol.UPGRADED_ARRAY_ELEMENT_TYPE, "typespec &optional environment");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2182 */       return Lisp.getUpgradedArrayElementType(arg);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2189 */       return Lisp.getUpgradedArrayElementType(first);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2194 */   private static final Primitive ARRAY_RANK = new pf_array_rank();
/*      */   
/*      */   private static final class pf_array_rank extends Primitive { pf_array_rank() {
/* 2197 */       super(Symbol.ARRAY_RANK, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2202 */       return Fixnum.getInstance(Lisp.checkArray(arg).getRank());
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2209 */   private static final Primitive ARRAY_DIMENSIONS = new pf_array_dimensions();
/*      */   
/*      */   private static final class pf_array_dimensions extends Primitive { pf_array_dimensions() {
/* 2212 */       super(Symbol.ARRAY_DIMENSIONS, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2217 */       return Lisp.checkArray(arg).getDimensions();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2222 */   private static final Primitive ARRAY_DIMENSION = new pf_array_dimension();
/*      */   
/*      */   private static final class pf_array_dimension extends Primitive { pf_array_dimension() {
/* 2225 */       super(Symbol.ARRAY_DIMENSION, "array axis-number");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2232 */       AbstractArray array = Lisp.checkArray(first);
/* 2233 */       return Fixnum.getInstance(array.getDimension(Fixnum.getValue(second)));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2238 */   private static final Primitive ARRAY_TOTAL_SIZE = new pf_array_total_size();
/*      */   
/*      */   private static final class pf_array_total_size extends Primitive { pf_array_total_size() {
/* 2241 */       super(Symbol.ARRAY_TOTAL_SIZE, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2246 */       return Fixnum.getInstance(Lisp.checkArray(arg).getTotalSize());
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2253 */   private static final Primitive ARRAY_ELEMENT_TYPE = new pf_array_element_type();
/*      */   
/*      */   private static final class pf_array_element_type extends Primitive { pf_array_element_type() {
/* 2256 */       super(Symbol.ARRAY_ELEMENT_TYPE, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2261 */       return Lisp.checkArray(arg).getElementType();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2266 */   private static final Primitive ADJUSTABLE_ARRAY_P = new pf_adjustable_array_p();
/*      */   
/*      */   private static final class pf_adjustable_array_p extends Primitive { pf_adjustable_array_p() {
/* 2269 */       super(Symbol.ADJUSTABLE_ARRAY_P, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2274 */       return Lisp.checkArray(arg).isAdjustable() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2279 */   private static final Primitive ARRAY_DISPLACEMENT = new pf_array_displacement();
/*      */   
/*      */   private static final class pf_array_displacement extends Primitive { pf_array_displacement() {
/* 2282 */       super(Symbol.ARRAY_DISPLACEMENT, "array");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2287 */       return Lisp.checkArray(arg).arrayDisplacement();
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2293 */   private static final Primitive ARRAY_IN_BOUNDS_P = new pf_array_in_bounds_p();
/*      */   
/*      */   private static final class pf_array_in_bounds_p extends Primitive { pf_array_in_bounds_p() {
/* 2296 */       super(Symbol.ARRAY_IN_BOUNDS_P, "array &rest subscripts");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2301 */       if (args.length < 1) {
/* 2302 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */       }
/* 2304 */       LispObject r = args[0];
/* 2305 */       AbstractArray array = Lisp.checkArray(r);
/* 2306 */       int rank = array.getRank();
/* 2307 */       if (rank != args.length - 1) {
/* 2308 */         StringBuilder sb = new StringBuilder("ARRAY-IN-BOUNDS-P: ");
/*      */         
/* 2310 */         sb.append("wrong number of subscripts (");
/* 2311 */         sb.append(args.length - 1);
/* 2312 */         sb.append(") for array of rank ");
/* 2313 */         sb.append(rank);
/* 2314 */         sb.append(".");
/* 2315 */         Lisp.program_error(sb.toString());
/*      */       } 
/* 2317 */       for (int i = 0; i < rank; i++) {
/* 2318 */         LispObject arg = args[i + 1];
/* 2319 */         if (arg instanceof Fixnum)
/* 2320 */         { int subscript = ((Fixnum)arg).value;
/* 2321 */           if (subscript < 0 || subscript >= array.getDimension(i))
/* 2322 */             return Lisp.NIL;  }
/* 2323 */         else { if (arg instanceof Bignum) {
/* 2324 */             return Lisp.NIL;
/*      */           }
/* 2326 */           Lisp.type_error(arg, Symbol.INTEGER); }
/*      */       
/* 2328 */       }  return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2333 */   private static final Primitive _ARRAY_ROW_MAJOR_INDEX = new pf__array_row_major_index();
/*      */   
/*      */   private static final class pf__array_row_major_index extends Primitive { pf__array_row_major_index() {
/* 2336 */       super("%array-row-major-index", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2344 */       AbstractArray array = Lisp.checkArray(first);
/* 2345 */       LispObject[] subscripts = second.copyToArray();
/* 2346 */       return Lisp.number(array.getRowMajorIndex(subscripts));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2351 */   private static final Primitive AREF = new pf_aref();
/*      */   
/*      */   private static final class pf_aref extends Primitive { pf_aref() {
/* 2354 */       super(Symbol.AREF, "array &rest subscripts");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 2359 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2364 */       AbstractArray array = Lisp.checkArray(arg);
/* 2365 */       if (array.getRank() == 0)
/* 2366 */         return array.AREF(0); 
/* 2367 */       StringBuilder sb = new StringBuilder("Wrong number of subscripts (0) for array of rank ");
/*      */       
/* 2369 */       sb.append(array.getRank());
/* 2370 */       sb.append('.');
/* 2371 */       return Lisp.program_error(sb.toString());
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2377 */       return first.AREF(second);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2384 */       return Lisp.checkArray(first).get(new int[] { Fixnum.getValue(second), Fixnum.getValue(third) });
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2388 */       AbstractArray array = Lisp.checkArray(args[0]);
/* 2389 */       int[] subs = new int[args.length - 1];
/* 2390 */       for (int i = subs.length; i-- > 0;) {
/* 2391 */         subs[i] = Fixnum.getValue(args[i + 1]);
/*      */       }
/* 2393 */       return array.get(subs);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2398 */   private static final Primitive ASET = new pf_aset();
/*      */   
/*      */   private static final class pf_aset extends Primitive { pf_aset() {
/* 2401 */       super("aset", Lisp.PACKAGE_SYS, true, "array subscripts new-element");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       ZeroRankArray array;
/* 2411 */       if (first instanceof ZeroRankArray) {
/* 2412 */         array = (ZeroRankArray)first;
/*      */       } else {
/* 2414 */         return Lisp.error(new TypeError("The value " + first
/* 2415 */               .princToString() + " is not an array of rank 0."));
/*      */       } 
/*      */       
/* 2418 */       array.aset(0, second);
/* 2419 */       return second;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2426 */       first.aset(second, third);
/* 2427 */       return third;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2431 */       AbstractArray array = Lisp.checkArray(args[0]);
/* 2432 */       int nsubs = args.length - 2;
/* 2433 */       int[] subs = new int[nsubs];
/* 2434 */       for (int i = nsubs; i-- > 0;)
/* 2435 */         subs[i] = Fixnum.getValue(args[i + 1]); 
/* 2436 */       LispObject newValue = args[args.length - 1];
/* 2437 */       array.set(subs, newValue);
/* 2438 */       return newValue;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2443 */   private static final Primitive ROW_MAJOR_AREF = new pf_row_major_aref();
/*      */   
/*      */   private static final class pf_row_major_aref extends Primitive { pf_row_major_aref() {
/* 2446 */       super(Symbol.ROW_MAJOR_AREF, "array index");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2453 */       return Lisp.checkArray(first).AREF(Fixnum.getValue(second));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2458 */   private static final Primitive VECTOR = new pf_vector();
/*      */   
/*      */   private static final class pf_vector extends Primitive { pf_vector() {
/* 2461 */       super(Symbol.VECTOR, "&rest objects");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2466 */       return new SimpleVector(args);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2471 */   private static final Primitive FILL_POINTER = new pf_fill_pointer();
/*      */   
/*      */   private static final class pf_fill_pointer extends Primitive { pf_fill_pointer() {
/* 2474 */       super(Symbol.FILL_POINTER, "vector");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2481 */       if (arg instanceof AbstractArray) {
/* 2482 */         AbstractArray aa = (AbstractArray)arg;
/* 2483 */         if (aa.hasFillPointer())
/* 2484 */           return Fixnum.getInstance(aa.getFillPointer()); 
/*      */       } 
/* 2486 */       return Lisp.type_error(arg, Lisp.list(Symbol.AND, new LispObject[] { Symbol.VECTOR, 
/* 2487 */               Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.ARRAY_HAS_FILL_POINTER_P }) }));
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2493 */   private static final Primitive _SET_FILL_POINTER = new pf__set_fill_pointer();
/*      */   
/*      */   private static final class pf__set_fill_pointer extends Primitive { pf__set_fill_pointer() {
/* 2496 */       super("%set-fill-pointer", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2504 */       if (first instanceof AbstractVector) {
/* 2505 */         AbstractVector v = (AbstractVector)first;
/* 2506 */         if (v.hasFillPointer()) {
/* 2507 */           v.setFillPointer(second);
/*      */         } else {
/* 2509 */           v.noFillPointer();
/* 2510 */         }  return second;
/*      */       } 
/*      */       
/* 2513 */       return Lisp.type_error(first, Lisp.list(Symbol.AND, new LispObject[] { Symbol.VECTOR, 
/* 2514 */               Lisp.list(Symbol.SATISFIES, new LispObject[] { Symbol.ARRAY_HAS_FILL_POINTER_P }) }));
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2520 */   private static final Primitive VECTOR_PUSH = new pf_vector_push();
/*      */   
/*      */   private static final class pf_vector_push extends Primitive { pf_vector_push() {
/* 2523 */       super(Symbol.VECTOR_PUSH, "new-element vector");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2530 */       AbstractVector v = Lisp.checkVector(second);
/* 2531 */       int fillPointer = v.getFillPointer();
/* 2532 */       if (fillPointer < 0)
/* 2533 */         v.noFillPointer(); 
/* 2534 */       if (fillPointer >= v.capacity())
/* 2535 */         return Lisp.NIL; 
/* 2536 */       v.aset(fillPointer, first);
/* 2537 */       v.setFillPointer(fillPointer + 1);
/* 2538 */       return Fixnum.getInstance(fillPointer);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2544 */   private static final Primitive VECTOR_PUSH_EXTEND = new pf_vector_push_extend();
/*      */   
/*      */   private static final class pf_vector_push_extend extends Primitive { pf_vector_push_extend() {
/* 2547 */       super(Symbol.VECTOR_PUSH_EXTEND, "new-element vector &optional extension");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2555 */       return second.VECTOR_PUSH_EXTEND(first);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2563 */       return second.VECTOR_PUSH_EXTEND(first, third);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2568 */   private static final Primitive VECTOR_POP = new pf_vector_pop();
/*      */   
/*      */   private static final class pf_vector_pop extends Primitive { pf_vector_pop() {
/* 2571 */       super(Symbol.VECTOR_POP, "vector");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2576 */       AbstractVector v = Lisp.checkVector(arg);
/* 2577 */       int fillPointer = v.getFillPointer();
/* 2578 */       if (fillPointer < 0)
/* 2579 */         v.noFillPointer(); 
/* 2580 */       if (fillPointer == 0)
/* 2581 */         Lisp.error(new LispError("nothing left to pop")); 
/* 2582 */       int newFillPointer = v.checkIndex(fillPointer - 1);
/* 2583 */       LispObject element = v.AREF(newFillPointer);
/* 2584 */       v.setFillPointer(newFillPointer);
/* 2585 */       return element;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2590 */   private static final Primitive TYPE_OF = new pf_type_of();
/*      */   
/*      */   private static final class pf_type_of extends Primitive { pf_type_of() {
/* 2593 */       super(Symbol.TYPE_OF, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2598 */       return arg.typeOf();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2603 */   private static final Primitive CLASS_OF = new pf_class_of();
/*      */   
/*      */   private static final class pf_class_of extends Primitive { pf_class_of() {
/* 2606 */       super(Symbol.CLASS_OF, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2611 */       return arg.classOf();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2616 */   private static final Primitive SIMPLE_TYPEP = new pf_simple_typep();
/*      */   
/*      */   private static final class pf_simple_typep extends Primitive { pf_simple_typep() {
/* 2619 */       super("simple-typep", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2626 */       return first.typep(second);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2632 */   private static final Primitive FUNCTION_LAMBDA_EXPRESSION = new pf_function_lambda_expression();
/*      */   
/*      */   private static final class pf_function_lambda_expression extends Primitive { pf_function_lambda_expression() {
/* 2635 */       super(Symbol.FUNCTION_LAMBDA_EXPRESSION, "function");
/*      */     }
/*      */     public LispObject execute(LispObject arg) {
/*      */       LispObject value1;
/*      */       LispObject value2;
/*      */       LispObject value3;
/* 2641 */       if (arg instanceof CompiledClosure)
/* 2642 */       { value1 = Lisp.NIL;
/* 2643 */         value2 = Lisp.T;
/* 2644 */         LispObject name = ((CompiledClosure)arg).getLambdaName();
/* 2645 */         value3 = (name != null) ? name : Lisp.NIL; }
/* 2646 */       else if (arg instanceof Closure)
/* 2647 */       { Closure closure = (Closure)arg;
/* 2648 */         LispObject expr = closure.getBody();
/* 2649 */         expr = new Cons(closure.getLambdaList(), expr);
/* 2650 */         expr = new Cons(Symbol.LAMBDA, expr);
/* 2651 */         value1 = expr;
/* 2652 */         Environment env = closure.getEnvironment();
/* 2653 */         if (env == null || env.isEmpty()) {
/* 2654 */           value2 = Lisp.NIL;
/*      */         } else {
/* 2656 */           value2 = env;
/* 2657 */         }  LispObject name = ((Closure)arg).getLambdaName();
/* 2658 */         value3 = (name != null) ? name : Lisp.NIL; }
/* 2659 */       else if (arg instanceof Function)
/* 2660 */       { value1 = Lisp.NIL;
/* 2661 */         value2 = Lisp.T;
/* 2662 */         value3 = ((Function)arg).getLambdaName(); }
/* 2663 */       else if (arg.typep(Symbol.GENERIC_FUNCTION) != Lisp.NIL)
/* 2664 */       { value1 = Lisp.NIL;
/* 2665 */         value2 = Lisp.T;
/* 2666 */         value3 = Symbol.GENERIC_FUNCTION_NAME.execute(arg); }
/* 2667 */       else { if (arg instanceof FuncallableStandardObject) {
/* 2668 */           return execute(((FuncallableStandardObject)arg).function);
/*      */         }
/* 2670 */         return Lisp.type_error(arg, Symbol.FUNCTION); }
/*      */       
/* 2672 */       return LispThread.currentThread().setValues(value1, value2, value3);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2678 */   public static final Primitive FUNCALL = new pf_funcall();
/*      */   
/*      */   private static final class pf_funcall extends Primitive { pf_funcall() {
/* 2681 */       super(Symbol.FUNCALL, "function &rest args");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 2686 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2690 */       return LispThread.currentThread().execute(arg);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 2696 */       return LispThread.currentThread().execute(first, second);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2703 */       return LispThread.currentThread().execute(first, second, third);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 2710 */       return LispThread.currentThread().execute(first, second, third, fourth);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 2719 */       return LispThread.currentThread().execute(first, second, third, fourth, fifth);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth) {
/* 2728 */       return LispThread.currentThread().execute(first, second, third, fourth, fifth, sixth);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh) {
/* 2738 */       return LispThread.currentThread().execute(first, second, third, fourth, fifth, sixth, seventh);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth, LispObject sixth, LispObject seventh, LispObject eigth) {
/* 2749 */       return LispThread.currentThread().execute(first, second, third, fourth, fifth, sixth, seventh, eigth);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2755 */       int length = args.length - 1;
/* 2756 */       if (length == 8) {
/* 2757 */         return LispThread.currentThread().execute(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
/*      */       }
/*      */ 
/*      */ 
/*      */ 
/*      */       
/* 2763 */       LispObject[] newArgs = new LispObject[length];
/* 2764 */       System.arraycopy(args, 1, newArgs, 0, length);
/* 2765 */       return LispThread.currentThread().execute(args[0], newArgs);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 2771 */   public static final Primitive APPLY = new pf_apply();
/*      */   
/*      */   private static final class pf_apply extends Primitive { pf_apply() {
/* 2774 */       super(Symbol.APPLY, "function &rest args");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 2779 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 2783 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1));
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject fun, LispObject args) {
/*      */       Cons cons;
/* 2789 */       LispThread thread = LispThread.currentThread();
/* 2790 */       int length = args.length();
/* 2791 */       switch (length) {
/*      */         case 0:
/* 2793 */           return thread.execute(fun);
/*      */         case 1:
/* 2795 */           return thread.execute(fun, ((Cons)args).car);
/*      */         case 2:
/* 2797 */           cons = (Cons)args;
/* 2798 */           return thread.execute(fun, cons.car, ((Cons)cons.cdr).car);
/*      */         
/*      */         case 3:
/* 2801 */           return thread.execute(fun, args.car(), args.cadr(), args
/* 2802 */               .cdr().cdr().car());
/*      */       } 
/* 2804 */       LispObject[] funArgs = new LispObject[length];
/* 2805 */       int j = 0;
/* 2806 */       while (args != Lisp.NIL) {
/* 2807 */         funArgs[j++] = args.car();
/* 2808 */         args = args.cdr();
/*      */       } 
/* 2810 */       return Lisp.funcall(fun, funArgs, thread);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 2819 */       if (third.listp()) {
/* 2820 */         int numFunArgs = 1 + third.length();
/* 2821 */         LispObject[] funArgs = new LispObject[numFunArgs];
/* 2822 */         funArgs[0] = second;
/* 2823 */         int j = 1;
/* 2824 */         while (third != Lisp.NIL) {
/* 2825 */           funArgs[j++] = third.car();
/* 2826 */           third = third.cdr();
/*      */         } 
/* 2828 */         return Lisp.funcall(first, funArgs, LispThread.currentThread());
/*      */       } 
/* 2830 */       return Lisp.type_error(third, Symbol.LIST);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2834 */       int numArgs = args.length;
/* 2835 */       LispObject spread = args[numArgs - 1];
/* 2836 */       if (spread.listp()) {
/* 2837 */         int numFunArgs = numArgs - 2 + spread.length();
/* 2838 */         LispObject[] funArgs = new LispObject[numFunArgs];
/* 2839 */         int j = 0;
/* 2840 */         for (int i = 1; i < numArgs - 1; i++)
/* 2841 */           funArgs[j++] = args[i]; 
/* 2842 */         while (spread != Lisp.NIL) {
/* 2843 */           funArgs[j++] = spread.car();
/* 2844 */           spread = spread.cdr();
/*      */         } 
/* 2846 */         return Lisp.funcall(args[0], funArgs, LispThread.currentThread());
/*      */       } 
/* 2848 */       return Lisp.type_error(spread, Symbol.LIST);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2853 */   private static final Primitive MAPCAR = new pf_mapcar();
/*      */   
/*      */   private static final class pf_mapcar extends Primitive { pf_mapcar() {
/* 2856 */       super(Symbol.MAPCAR, "function &rest lists");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject fun, LispObject list) {
/* 2863 */       LispThread thread = LispThread.currentThread();
/* 2864 */       LispObject result = Lisp.NIL;
/* 2865 */       Cons splice = null;
/* 2866 */       while (list != Lisp.NIL) {
/*      */         Cons cons;
/* 2868 */         if (list instanceof Cons) {
/* 2869 */           cons = (Cons)list;
/*      */         } else {
/* 2871 */           return Lisp.type_error(list, Symbol.LIST);
/* 2872 */         }  LispObject obj = thread.execute(fun, cons.car);
/* 2873 */         if (splice == null) {
/* 2874 */           splice = new Cons(obj, result);
/* 2875 */           result = splice;
/*      */         } else {
/* 2877 */           Cons c = new Cons(obj);
/* 2878 */           splice.cdr = c;
/* 2879 */           splice = c;
/*      */         } 
/* 2881 */         list = cons.cdr;
/*      */       } 
/* 2883 */       thread._values = null;
/* 2884 */       return result;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject fun, LispObject list1, LispObject list2) {
/* 2891 */       LispThread thread = LispThread.currentThread();
/* 2892 */       LispObject result = Lisp.NIL;
/* 2893 */       Cons splice = null;
/* 2894 */       while (list1 != Lisp.NIL && list2 != Lisp.NIL) {
/*      */         
/* 2896 */         LispObject obj = thread.execute(fun, list1.car(), list2.car());
/* 2897 */         if (splice == null) {
/* 2898 */           splice = new Cons(obj, result);
/* 2899 */           result = splice;
/*      */         } else {
/* 2901 */           Cons cons = new Cons(obj);
/* 2902 */           splice.cdr = cons;
/* 2903 */           splice = cons;
/*      */         } 
/* 2905 */         list1 = list1.cdr();
/* 2906 */         list2 = list2.cdr();
/*      */       } 
/* 2908 */       thread._values = null;
/* 2909 */       return result;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2915 */       int numArgs = args.length;
/* 2916 */       if (numArgs < 2)
/* 2917 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/* 2918 */       int commonLength = -1;
/* 2919 */       for (int i = 1; i < numArgs; i++) {
/* 2920 */         if (!args[i].listp())
/* 2921 */           Lisp.type_error(args[i], Symbol.LIST); 
/* 2922 */         int len = args[i].length();
/* 2923 */         if (commonLength < 0) {
/* 2924 */           commonLength = len;
/* 2925 */         } else if (commonLength > len) {
/* 2926 */           commonLength = len;
/*      */         } 
/* 2928 */       }  LispThread thread = LispThread.currentThread();
/* 2929 */       LispObject[] results = new LispObject[commonLength];
/* 2930 */       int numFunArgs = numArgs - 1;
/* 2931 */       LispObject[] funArgs = new LispObject[numFunArgs];
/* 2932 */       for (int j = 0; j < commonLength; j++) {
/* 2933 */         int m; for (m = 0; m < numFunArgs; m++)
/* 2934 */           funArgs[m] = args[m + 1].car(); 
/* 2935 */         results[j] = Lisp.funcall(args[0], funArgs, thread);
/* 2936 */         for (m = 1; m < numArgs; m++)
/* 2937 */           args[m] = args[m].cdr(); 
/*      */       } 
/* 2939 */       thread._values = null;
/* 2940 */       LispObject result = Lisp.NIL;
/* 2941 */       for (int k = commonLength; k-- > 0;)
/* 2942 */         result = new Cons(results[k], result); 
/* 2943 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 2948 */   private static final Primitive MAPC = new pf_mapc();
/*      */   
/*      */   private static final class pf_mapc extends Primitive { pf_mapc() {
/* 2951 */       super(Symbol.MAPC, "function &rest lists");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject fun, LispObject list) {
/* 2958 */       LispThread thread = LispThread.currentThread();
/* 2959 */       LispObject result = list;
/* 2960 */       while (list != Lisp.NIL) {
/*      */         Cons cons;
/* 2962 */         if (list instanceof Cons) {
/* 2963 */           cons = (Cons)list;
/*      */         } else {
/* 2965 */           return Lisp.type_error(list, Symbol.LIST);
/* 2966 */         }  thread.execute(fun, cons.car);
/* 2967 */         list = cons.cdr;
/*      */       } 
/* 2969 */       thread._values = null;
/* 2970 */       return result;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject fun, LispObject list1, LispObject list2) {
/* 2977 */       LispThread thread = LispThread.currentThread();
/* 2978 */       LispObject result = list1;
/* 2979 */       while (list1 != Lisp.NIL && list2 != Lisp.NIL) {
/* 2980 */         thread.execute(fun, list1.car(), list2.car());
/* 2981 */         list1 = ((Cons)list1).cdr;
/* 2982 */         list2 = ((Cons)list2).cdr;
/*      */       } 
/* 2984 */       thread._values = null;
/* 2985 */       return result;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 2991 */       int numArgs = args.length;
/* 2992 */       if (numArgs < 2)
/* 2993 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/* 2994 */       int commonLength = -1;
/* 2995 */       for (int i = 1; i < numArgs; i++) {
/* 2996 */         if (!args[i].listp())
/* 2997 */           Lisp.type_error(args[i], Symbol.LIST); 
/* 2998 */         int len = args[i].length();
/* 2999 */         if (commonLength < 0) {
/* 3000 */           commonLength = len;
/* 3001 */         } else if (commonLength > len) {
/* 3002 */           commonLength = len;
/*      */         } 
/* 3004 */       }  LispThread thread = LispThread.currentThread();
/* 3005 */       LispObject result = args[1];
/* 3006 */       int numFunArgs = numArgs - 1;
/* 3007 */       LispObject[] funArgs = new LispObject[numFunArgs];
/* 3008 */       for (int j = 0; j < commonLength; j++) {
/* 3009 */         int k; for (k = 0; k < numFunArgs; k++)
/* 3010 */           funArgs[k] = args[k + 1].car(); 
/* 3011 */         Lisp.funcall(args[0], funArgs, thread);
/* 3012 */         for (k = 1; k < numArgs; k++)
/* 3013 */           args[k] = args[k].cdr(); 
/*      */       } 
/* 3015 */       thread._values = null;
/* 3016 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3021 */   private static final Primitive MACROEXPAND = new pf_macroexpand();
/*      */   
/*      */   private static final class pf_macroexpand extends Primitive { pf_macroexpand() {
/* 3024 */       super(Symbol.MACROEXPAND, "form &optional env");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject form) {
/* 3029 */       return Lisp.macroexpand(form, new Environment(), 
/*      */           
/* 3031 */           LispThread.currentThread());
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject form, LispObject env) {
/* 3037 */       return Lisp.macroexpand(form, (env != Lisp.NIL) ? 
/* 3038 */           Lisp.checkEnvironment(env) : new Environment(), 
/* 3039 */           LispThread.currentThread());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3044 */   private static final Primitive MACROEXPAND_1 = new pf_macroexpand_1();
/*      */   
/*      */   private static final class pf_macroexpand_1 extends Primitive { pf_macroexpand_1() {
/* 3047 */       super(Symbol.MACROEXPAND_1, "form &optional env");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject form) {
/* 3052 */       return Lisp.macroexpand_1(form, new Environment(), 
/*      */           
/* 3054 */           LispThread.currentThread());
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject form, LispObject env) {
/* 3060 */       return Lisp.macroexpand_1(form, (env != Lisp.NIL) ? 
/* 3061 */           Lisp.checkEnvironment(env) : new Environment(), 
/* 3062 */           LispThread.currentThread());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3067 */   public static final Primitive GENSYM = new pf_gensym();
/*      */   
/*      */   private static final class pf_gensym extends Primitive { pf_gensym() {
/* 3070 */       super(Symbol.GENSYM, "&optional x");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 3075 */       return Lisp.gensym("G", LispThread.currentThread());
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3079 */       if (arg instanceof Fixnum) {
/* 3080 */         int n = ((Fixnum)arg).value;
/* 3081 */         if (n >= 0) {
/* 3082 */           StringBuilder sb = new StringBuilder("G");
/* 3083 */           sb.append(n);
/* 3084 */           return new Symbol(new SimpleString(sb));
/*      */         } 
/* 3086 */       } else if (arg instanceof Bignum) {
/* 3087 */         BigInteger n = ((Bignum)arg).value;
/* 3088 */         if (n.signum() >= 0) {
/* 3089 */           StringBuilder sb = new StringBuilder("G");
/* 3090 */           sb.append(n.toString());
/* 3091 */           return new Symbol(new SimpleString(sb));
/*      */         } 
/* 3093 */       } else if (arg instanceof AbstractString) {
/* 3094 */         return Lisp.gensym(arg.getStringValue(), LispThread.currentThread());
/* 3095 */       }  return Lisp.type_error(arg, 
/* 3096 */           Lisp.list(Symbol.OR, new LispObject[] { Symbol.STRING, Symbol.UNSIGNED_BYTE }));
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3103 */   private static final Primitive STRING = new pf_string();
/*      */   
/*      */   private static final class pf_string extends Primitive { pf_string() {
/* 3106 */       super(Symbol.STRING, "x");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3111 */       return arg.STRING();
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3119 */   private static final Primitive INTERN = new pf_intern();
/*      */   
/*      */   private static final class pf_intern extends Primitive { pf_intern() {
/* 3122 */       super(Symbol.INTERN, "string &optional package");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*      */       SimpleString s;
/* 3128 */       if (arg instanceof SimpleString) {
/* 3129 */         s = (SimpleString)arg;
/*      */       } else {
/* 3131 */         s = new SimpleString(arg.getStringValue());
/* 3132 */       }  LispThread thread = LispThread.currentThread();
/* 3133 */       Package pkg = (Package)Symbol._PACKAGE_.symbolValue(thread);
/* 3134 */       return pkg.intern(s, thread);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       SimpleString s;
/* 3141 */       if (first instanceof SimpleString) {
/* 3142 */         s = (SimpleString)first;
/*      */       } else {
/* 3144 */         s = new SimpleString(first.getStringValue());
/* 3145 */       }  Package pkg = Lisp.coerceToPackage(second);
/* 3146 */       return pkg.intern(s, LispThread.currentThread());
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3152 */   private static final Primitive UNINTERN = new pf_unintern();
/*      */   
/*      */   private static final class pf_unintern extends Primitive { pf_unintern() {
/* 3155 */       super(Symbol.UNINTERN, "symbol &optional package");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*      */       Package pkg;
/* 3160 */       if (args.length == 0 || args.length > 2)
/* 3161 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2)); 
/* 3162 */       Symbol symbol = Lisp.checkSymbol(args[0]);
/*      */       
/* 3164 */       if (args.length == 2) {
/* 3165 */         pkg = Lisp.coerceToPackage(args[1]);
/*      */       } else {
/* 3167 */         pkg = Lisp.getCurrentPackage();
/* 3168 */       }  return pkg.unintern(symbol);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3173 */   private static final Primitive FIND_PACKAGE = new pf_find_package();
/*      */   
/*      */   private static final class pf_find_package extends Primitive { pf_find_package() {
/* 3176 */       super(Symbol.FIND_PACKAGE, "name");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3181 */       if (arg instanceof Package)
/* 3182 */         return arg; 
/* 3183 */       if (arg instanceof AbstractString) {
/*      */         
/* 3185 */         Package pkg = Lisp.getCurrentPackage().findPackage(arg.getStringValue());
/* 3186 */         return (pkg != null) ? pkg : Lisp.NIL;
/*      */       } 
/* 3188 */       if (arg instanceof Symbol) {
/* 3189 */         Package pkg = Lisp.getCurrentPackage().findPackage(Lisp.checkSymbol(arg).getName());
/* 3190 */         return (pkg != null) ? pkg : Lisp.NIL;
/*      */       } 
/* 3192 */       if (arg instanceof LispCharacter) {
/*      */         
/* 3194 */         String packageName = String.valueOf(new char[] { ((LispCharacter)arg).getValue() });
/* 3195 */         Package pkg = Lisp.getCurrentPackage().findPackage(packageName);
/* 3196 */         return (pkg != null) ? pkg : Lisp.NIL;
/*      */       } 
/* 3198 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3204 */   private static final Primitive _MAKE_PACKAGE = new pf__make_package();
/*      */   
/*      */   private static final class pf__make_package extends Primitive { pf__make_package() {
/* 3207 */       super("%make-package", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 3218 */       return new Package();
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 3229 */       String packageName = Lisp.javaString(first);
/* 3230 */       Package currentpkg = Lisp.getCurrentPackage();
/* 3231 */       Package pkg = currentpkg.findPackage(packageName);
/* 3232 */       if (pkg != null) {
/* 3233 */         Lisp.error(new LispError("Package " + packageName + " already exists."));
/*      */       }
/* 3235 */       LispObject nicknames = Lisp.checkList(second);
/* 3236 */       if (nicknames != Lisp.NIL) {
/* 3237 */         LispObject list = nicknames;
/* 3238 */         while (list != Lisp.NIL) {
/* 3239 */           LispObject lispNick = list.car();
/* 3240 */           String nick = Lisp.javaString(lispNick);
/* 3241 */           if (currentpkg.findPackage(nick) != null) {
/* 3242 */             Lisp.error(new PackageError("A package named " + nick + " already exists.", lispNick));
/*      */           }
/*      */           
/* 3245 */           list = list.cdr();
/*      */         } 
/*      */       } 
/* 3248 */       LispObject use = Lisp.checkList(third);
/* 3249 */       if (use != Lisp.NIL) {
/* 3250 */         LispObject list = use;
/* 3251 */         while (list != Lisp.NIL) {
/* 3252 */           LispObject obj = list.car();
/* 3253 */           if (!(obj instanceof Package)) {
/*      */ 
/*      */             
/* 3256 */             String s = Lisp.javaString(obj);
/* 3257 */             Package p = currentpkg.findPackage(s);
/* 3258 */             if (p == null) {
/* 3259 */               Lisp.error(new LispError(obj.princToString() + " is not the name of a package."));
/*      */               
/* 3261 */               return Lisp.NIL;
/*      */             } 
/*      */           } 
/* 3264 */           list = list.cdr();
/*      */         } 
/*      */       } 
/*      */       
/* 3268 */       pkg = Packages.createPackage(packageName);
/*      */       
/* 3270 */       while (nicknames != Lisp.NIL) {
/* 3271 */         String nick = Lisp.javaString(nicknames.car());
/* 3272 */         pkg.addNickname(nick);
/* 3273 */         nicknames = nicknames.cdr();
/*      */       } 
/*      */       
/* 3276 */       while (use != Lisp.NIL) {
/* 3277 */         LispObject obj = use.car();
/* 3278 */         if (obj instanceof Package) {
/* 3279 */           pkg.usePackage((Package)obj);
/*      */         } else {
/* 3281 */           String s = Lisp.javaString(obj);
/* 3282 */           Package p = currentpkg.findPackage(s);
/* 3283 */           if (p == null) {
/* 3284 */             Lisp.error(new LispError(obj.princToString() + " is not the name of a package."));
/*      */             
/* 3286 */             return Lisp.NIL;
/*      */           } 
/* 3288 */           pkg.usePackage(p);
/*      */         } 
/* 3290 */         use = use.cdr();
/*      */       } 
/* 3292 */       return pkg;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3297 */   private static final Primitive _IN_PACKAGE = new pf__in_package();
/*      */   
/*      */   private static final class pf__in_package extends Primitive { pf__in_package() {
/* 3300 */       super("%in-package", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3305 */       String packageName = Lisp.javaString(arg);
/* 3306 */       Package pkg = Lisp.getCurrentPackage().findPackage(packageName);
/* 3307 */       if (pkg == null) {
/* 3308 */         return Lisp.error(new PackageError("The name " + packageName + " does not designate any package.", arg));
/*      */       }
/*      */       
/* 3311 */       SpecialBinding binding = LispThread.currentThread().getSpecialBinding(Symbol._PACKAGE_);
/* 3312 */       if (binding != null) {
/* 3313 */         binding.value = pkg;
/*      */       } else {
/*      */         
/* 3316 */         Symbol._PACKAGE_.setSymbolValue(pkg);
/* 3317 */       }  return pkg;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3322 */   private static final Primitive USE_PACKAGE = new pf_use_package();
/*      */   
/*      */   private static final class pf_use_package extends Primitive { pf_use_package() {
/* 3325 */       super(Symbol.USE_PACKAGE, "packages-to-use &optional package");
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*      */       Package pkg;
/* 3330 */       if (args.length < 1 || args.length > 2) {
/* 3331 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2));
/*      */       }
/* 3333 */       if (args.length == 2) {
/* 3334 */         pkg = Lisp.coerceToPackage(args[1]);
/*      */       } else {
/* 3336 */         pkg = Lisp.getCurrentPackage();
/* 3337 */       }  if (args[0].listp()) {
/* 3338 */         LispObject list = args[0];
/* 3339 */         while (list != Lisp.NIL) {
/* 3340 */           pkg.usePackage(Lisp.coerceToPackage(list.car()));
/* 3341 */           list = list.cdr();
/*      */         } 
/*      */       } else {
/* 3344 */         pkg.usePackage(Lisp.coerceToPackage(args[0]));
/* 3345 */       }  return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3350 */   private static final Primitive PACKAGE_SYMBOLS = new pf_package_symbols();
/*      */   
/*      */   private static final class pf_package_symbols extends Primitive { pf_package_symbols() {
/* 3353 */       super("package-symbols", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3358 */       return Lisp.coerceToPackage(arg).getSymbols();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3363 */   private static final Primitive PACKAGE_INTERNAL_SYMBOLS = new pf_package_internal_symbols();
/*      */   
/*      */   private static final class pf_package_internal_symbols extends Primitive { pf_package_internal_symbols() {
/* 3366 */       super("package-internal-symbols", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3371 */       return Lisp.coerceToPackage(arg).PACKAGE_INTERNAL_SYMBOLS();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3376 */   private static final Primitive PACKAGE_EXTERNAL_SYMBOLS = new pf_package_external_symbols();
/*      */   
/*      */   private static final class pf_package_external_symbols extends Primitive { pf_package_external_symbols() {
/* 3379 */       super("package-external-symbols", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3384 */       return Lisp.coerceToPackage(arg).PACKAGE_EXTERNAL_SYMBOLS();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3389 */   private static final Primitive PACKAGE_INHERITED_SYMBOLS = new pf_package_inherited_symbols();
/*      */   
/*      */   private static final class pf_package_inherited_symbols extends Primitive { pf_package_inherited_symbols() {
/* 3392 */       super("package-inherited-symbols", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3397 */       return Lisp.coerceToPackage(arg).PACKAGE_INHERITED_SYMBOLS();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3402 */   private static final Primitive EXPORT = new pf_export();
/*      */   
/*      */   private static final class pf_export extends Primitive { pf_export() {
/* 3405 */       super(Symbol.EXPORT, "symbols &optional package");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3410 */       Package pkg = (Package)Symbol._PACKAGE_.symbolValue();
/* 3411 */       if (arg instanceof Cons) {
/* 3412 */         for (LispObject list = arg; list != Lisp.NIL; list = list.cdr())
/* 3413 */           pkg.export(Lisp.checkSymbol(list.car())); 
/*      */       } else {
/* 3415 */         pkg.export(Lisp.checkSymbol(arg));
/* 3416 */       }  return Lisp.T;
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 3423 */       if (first instanceof Cons) {
/* 3424 */         Package pkg = Lisp.coerceToPackage(second);
/* 3425 */         for (LispObject list = first; list != Lisp.NIL; list = list.cdr())
/* 3426 */           pkg.export(Lisp.checkSymbol(list.car())); 
/*      */       } else {
/* 3428 */         Lisp.coerceToPackage(second).export(Lisp.checkSymbol(first));
/* 3429 */       }  return Lisp.T;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3434 */   private static final Primitive FIND_SYMBOL = new pf_find_symbol();
/*      */   
/*      */   private static final class pf_find_symbol extends Primitive { pf_find_symbol() {
/* 3437 */       super(Symbol.FIND_SYMBOL, "string &optional package");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 3442 */       return Lisp.getCurrentPackage()
/* 3443 */         .findSymbol(Lisp.checkString(arg).getStringValue());
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 3450 */       return Lisp.coerceToPackage(second)
/* 3451 */         .findSymbol(Lisp.checkString(first).getStringValue());
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3457 */   private static final Primitive FSET = new pf_fset();
/*      */   
/*      */   private static final class pf_fset extends Primitive { pf_fset() {
/* 3460 */       super("fset", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 3467 */       return execute(first, second, Lisp.NIL, Lisp.NIL, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 3474 */       return execute(first, second, third, Lisp.NIL, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 3481 */       return execute(first, second, third, fourth, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth, LispObject fifth) {
/* 3489 */       if (first instanceof Symbol) {
/* 3490 */         Primitives.checkRedefinition(first);
/* 3491 */         Symbol symbol = Lisp.checkSymbol(first);
/* 3492 */         symbol.setSymbolFunction(second);
/* 3493 */         LispThread thread = LispThread.currentThread();
/* 3494 */         LispObject sourcePathname = Lisp._SOURCE_.symbolValue(thread);
/* 3495 */         LispObject sourcePosition = third;
/* 3496 */         if (sourcePathname != Lisp.NIL)
/* 3497 */           sourcePosition = Lisp._SOURCE_POSITION_.symbolValue(thread); 
/* 3498 */         if (sourcePathname == Lisp.NIL)
/* 3499 */           sourcePathname = Keyword.TOP_LEVEL; 
/* 3500 */         if (sourcePathname != Keyword.TOP_LEVEL)
/* 3501 */         { Lisp.put(symbol, Symbol._SOURCE, new Cons(sourcePathname, third)); }
/*      */         else
/* 3503 */         { Lisp.put(symbol, Symbol._SOURCE, sourcePathname); } 
/* 3504 */       } else if (Lisp.isValidSetfFunctionName(first)) {
/*      */         
/* 3506 */         Primitives.checkRedefinition(first);
/* 3507 */         Symbol symbol = Lisp.checkSymbol(first.cadr());
/* 3508 */         Lisp.put(symbol, Symbol.SETF_FUNCTION, second);
/*      */       } else {
/* 3510 */         return Lisp.type_error(first, Lisp.FUNCTION_NAME);
/* 3511 */       }  if (second instanceof Operator) {
/* 3512 */         Operator op = (Operator)second;
/* 3513 */         op.setLambdaName(first);
/* 3514 */         if (fourth != Lisp.NIL)
/* 3515 */           op.setLambdaList(fourth); 
/* 3516 */         if (fifth != Lisp.NIL)
/* 3517 */           op.setDocumentation(Symbol.FUNCTION, fifth); 
/*      */       } 
/* 3519 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3524 */   private static final Primitive _SET_SYMBOL_PLIST = new pf__set_symbol_plist();
/*      */   
/*      */   private static final class pf__set_symbol_plist extends Primitive { pf__set_symbol_plist() {
/* 3527 */       super("%set-symbol-plist", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 3534 */       Lisp.checkSymbol(first).setPropertyList(Lisp.checkList(second));
/* 3535 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3540 */   private static final Primitive GETF = new pf_getf();
/*      */   
/*      */   private static final class pf_getf extends Primitive { pf_getf() {
/* 3543 */       super(Symbol.GETF, "plist indicator &optional default");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject plist, LispObject indicator) {
/* 3550 */       return Lisp.getf(plist, indicator, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject plist, LispObject indicator, LispObject defaultValue) {
/* 3557 */       return Lisp.getf(plist, indicator, defaultValue);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3562 */   private static final Primitive GET = new pf_get();
/*      */   
/*      */   private static final class pf_get extends Primitive { pf_get() {
/* 3565 */       super(Symbol.GET, "symbol indicator &optional default");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject symbol, LispObject indicator) {
/* 3572 */       return Lisp.get(symbol, indicator, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject symbol, LispObject indicator, LispObject defaultValue) {
/* 3579 */       return Lisp.get(symbol, indicator, defaultValue);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3584 */   public static final Primitive PUT = new pf_put();
/*      */   
/*      */   private static final class pf_put extends Primitive { pf_put() {
/* 3587 */       super("put", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject symbol, LispObject indicator, LispObject value) {
/* 3595 */       return Lisp.put(Lisp.checkSymbol(symbol), indicator, value);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject symbol, LispObject indicator, LispObject defaultValue, LispObject value) {
/* 3602 */       return Lisp.put(Lisp.checkSymbol(symbol), indicator, value);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3607 */   private static final SpecialOperator MACROLET = new sf_macrolet();
/*      */   
/*      */   private static final class sf_macrolet extends SpecialOperator { sf_macrolet() {
/* 3610 */       super(Symbol.MACROLET, "definitions &rest body");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3617 */       LispObject defs = Lisp.checkList(args.car());
/* 3618 */       LispThread thread = LispThread.currentThread();
/* 3619 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/*      */       
/* 3621 */       Environment ext = new Environment(env);
/* 3622 */       thread.envStack.push(ext);
/*      */       try {
/* 3624 */         while (defs != Lisp.NIL) {
/* 3625 */           LispObject def = Lisp.checkList(defs.car());
/* 3626 */           Symbol symbol = Lisp.checkSymbol(def.car());
/*      */           
/* 3628 */           Symbol make_expander_for_macrolet = Lisp.PACKAGE_SYS.intern("MAKE-MACRO-EXPANDER");
/*      */           
/* 3630 */           LispObject expander = make_expander_for_macrolet.execute(def);
/* 3631 */           Closure expansionFunction = new Closure(expander, env);
/* 3632 */           MacroObject macroObject = new MacroObject(symbol, expansionFunction);
/*      */           
/* 3634 */           ext.addFunctionBinding(symbol, macroObject);
/* 3635 */           defs = defs.cdr();
/*      */         } 
/* 3637 */         return Lisp.progn(ext.processDeclarations(args.cdr()), ext, thread);
/*      */       } finally {
/*      */         
/* 3640 */         thread.resetSpecialBindings(mark);
/* 3641 */         while (thread.envStack.pop() != ext);
/*      */       } 
/*      */     } }
/*      */ 
/*      */   
/* 3646 */   private static final Primitive MAKE_MACRO_EXPANDER = new pf_make_macro_expander();
/*      */   
/*      */   private static final class pf_make_macro_expander extends Primitive { pf_make_macro_expander() {
/* 3649 */       super("make-macro-expander", Lisp.PACKAGE_SYS, true, "definition");
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
/*      */     public LispObject execute(LispObject definition) {
/* 3662 */       Symbol symbol = Lisp.checkSymbol(definition.car());
/* 3663 */       LispObject lambdaList = definition.cadr();
/* 3664 */       LispObject body = definition.cddr();
/* 3665 */       LispObject block = new Cons(Symbol.BLOCK, new Cons(symbol, body));
/*      */ 
/*      */       
/* 3668 */       LispObject toBeApplied = Lisp.list(Symbol.FUNCTION, new LispObject[] { Lisp.list(Symbol.MACRO_FUNCTION, new LispObject[] { lambdaList, block }) });
/* 3669 */       LispThread thread = LispThread.currentThread();
/* 3670 */       LispObject formArg = Lisp.gensym("WHOLE-", thread);
/* 3671 */       LispObject envArg = Lisp.gensym("ENVIRONMENT-", thread);
/*      */       
/* 3673 */       LispObject expander = Lisp.list(Symbol.LAMBDA, new LispObject[] { Lisp.list(formArg, new LispObject[] { envArg
/* 3674 */               }), Lisp.list(Symbol.APPLY, new LispObject[] {
/* 3675 */                 toBeApplied, Lisp.list(Symbol.CDR, new LispObject[] { formArg }) }) });
/* 3676 */       return expander;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3681 */   private static final SpecialOperator TAGBODY = new sf_tagbody();
/*      */   
/*      */   private static final class sf_tagbody extends SpecialOperator { sf_tagbody() {
/* 3684 */       super(Symbol.TAGBODY, "&rest statements");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3691 */       Environment ext = new Environment(env);
/* 3692 */       LispThread thread = LispThread.currentThread();
/*      */       try {
/* 3694 */         thread.envStack.push(ext);
/* 3695 */         return Lisp.processTagBody(args, Lisp.preprocessTagBody(args, ext), ext);
/*      */       } finally {
/*      */         
/* 3698 */         ext.inactive = true;
/* 3699 */         while (thread.envStack.pop() != ext);
/*      */       } 
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3705 */   private static final SpecialOperator GO = new sf_go();
/*      */   
/*      */   private static final class sf_go extends SpecialOperator { sf_go() {
/* 3708 */       super(Symbol.GO, "tag");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3715 */       if (args.length() != 1)
/* 3716 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1)); 
/* 3717 */       Binding binding = env.getTagBinding(args.car());
/* 3718 */       if (binding == null) {
/* 3719 */         return Lisp.error(new ControlError("No tag named " + args
/* 3720 */               .car().princToString() + " is currently visible."));
/*      */       }
/*      */       
/* 3723 */       return Lisp.nonLocalGo(binding, args.car());
/*      */     } }
/*      */   
/*      */   private static class BlockMarker extends LispObject implements Serializable {
/*      */     private BlockMarker() {}
/*      */   }
/*      */   
/* 3730 */   private static final SpecialOperator BLOCK = new sf_block();
/*      */   
/*      */   private static final class sf_block extends SpecialOperator { sf_block() {
/* 3733 */       super(Symbol.BLOCK, "name &rest forms");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3740 */       if (args == Lisp.NIL) {
/* 3741 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */       }
/* 3743 */       LispObject tag = Lisp.checkSymbol(args.car());
/* 3744 */       LispObject body = ((Cons)args).cdr();
/* 3745 */       Environment ext = new Environment(env);
/* 3746 */       LispObject block = new Primitives.BlockMarker();
/* 3747 */       ext.addBlock(tag, block);
/* 3748 */       LispObject result = Lisp.NIL;
/* 3749 */       LispThread thread = LispThread.currentThread();
/*      */       try {
/* 3751 */         thread.envStack.push(ext);
/* 3752 */         return Lisp.progn(body, ext, thread);
/* 3753 */       } catch (Return ret) {
/* 3754 */         if (ret.getBlock() == block) {
/* 3755 */           return ret.getResult();
/*      */         }
/* 3757 */         throw ret;
/*      */       } finally {
/*      */         
/* 3760 */         while (thread.envStack.pop() != ext);
/* 3761 */         ext.inactive = true;
/*      */       } 
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3767 */   private static final SpecialOperator RETURN_FROM = new sf_return_from();
/*      */   
/*      */   private static final class sf_return_from extends SpecialOperator { sf_return_from() {
/* 3770 */       super(Symbol.RETURN_FROM, "name &optional value");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3777 */       int length = args.length();
/* 3778 */       if (length < 1 || length > 2) {
/* 3779 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, 2));
/*      */       }
/* 3781 */       Symbol symbol = Lisp.checkSymbol(args.car());
/*      */       
/* 3783 */       return Lisp.nonLocalReturn(env.getBlockBinding(symbol), symbol, (length == 2) ? 
/* 3784 */           Lisp.eval(args.cadr(), env, 
/* 3785 */             LispThread.currentThread()) : Lisp.NIL);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3791 */   private static final SpecialOperator CATCH = new sf_catch();
/*      */   
/*      */   private static final class sf_catch extends SpecialOperator { sf_catch() {
/* 3794 */       super(Symbol.CATCH, "tag &body body");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3801 */       if (args.length() < 1)
/* 3802 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 3803 */       LispThread thread = LispThread.currentThread();
/* 3804 */       LispObject tag = Lisp.eval(args.car(), env, thread);
/* 3805 */       thread.pushCatchTag(tag);
/* 3806 */       LispObject body = args.cdr();
/* 3807 */       LispObject result = Lisp.NIL;
/* 3808 */       Environment ext = new Environment(env, Keyword.CATCH, tag);
/*      */       try {
/* 3810 */         thread.envStack.push(ext);
/* 3811 */         return Lisp.progn(body, env, thread);
/* 3812 */       } catch (Throw t) {
/* 3813 */         if (t.tag == tag) {
/* 3814 */           return t.getResult(thread);
/*      */         }
/* 3816 */         throw t;
/* 3817 */       } catch (Return ret) {
/* 3818 */         throw ret;
/*      */       } finally {
/*      */         
/* 3821 */         while (thread.envStack.pop() != ext);
/* 3822 */         thread.popCatchTag();
/*      */       } 
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3828 */   private static final SpecialOperator THROW = new sf_throw();
/*      */   
/*      */   private static final class sf_throw extends SpecialOperator { sf_throw() {
/* 3831 */       super(Symbol.THROW, "tag result");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3838 */       if (args.length() != 2)
/* 3839 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2)); 
/* 3840 */       LispThread thread = LispThread.currentThread();
/* 3841 */       thread.throwToTag(Lisp.eval(args.car(), env, thread), 
/* 3842 */           Lisp.eval(args.cadr(), env, thread));
/*      */       
/* 3844 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3849 */   private static final SpecialOperator UNWIND_PROTECT = new sf_unwind_protect();
/*      */   
/*      */   private static final class sf_unwind_protect extends SpecialOperator { sf_unwind_protect() {
/* 3852 */       super(Symbol.UNWIND_PROTECT, "protected &body cleanup");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/*      */       LispObject result, values[];
/* 3859 */       LispThread thread = LispThread.currentThread();
/*      */ 
/*      */       
/*      */       try {
/* 3863 */         result = Lisp.eval(args.car(), env, thread);
/*      */       } finally {
/*      */         
/* 3866 */         values = thread._values;
/* 3867 */         LispObject body = args.cdr();
/* 3868 */         while (body != Lisp.NIL) {
/* 3869 */           Lisp.eval(body.car(), env, thread);
/* 3870 */           body = ((Cons)body).cdr;
/*      */         } 
/* 3872 */         thread._values = values;
/*      */       } 
/* 3874 */       if (values != null) {
/* 3875 */         thread.setValues(values);
/*      */       } else {
/* 3877 */         thread._values = null;
/* 3878 */       }  return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3883 */   private static final SpecialOperator EVAL_WHEN = new sf_eval_when();
/*      */   
/*      */   private static final class sf_eval_when extends SpecialOperator { sf_eval_when() {
/* 3886 */       super(Symbol.EVAL_WHEN, "situations &rest forms");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3893 */       LispObject situations = args.car();
/* 3894 */       if (situations != Lisp.NIL && (
/* 3895 */         Lisp.memq(Keyword.EXECUTE, situations) || 
/* 3896 */         Lisp.memq(Symbol.EVAL, situations))) {
/* 3897 */         return Lisp.progn(args.cdr(), env, LispThread.currentThread());
/*      */       }
/*      */       
/* 3900 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 3907 */   private static final SpecialOperator MULTIPLE_VALUE_BIND = new sf_multiple_value_bind();
/*      */   
/*      */   private static final class sf_multiple_value_bind extends SpecialOperator { sf_multiple_value_bind() {
/* 3910 */       super(Symbol.MULTIPLE_VALUE_BIND, "vars value-form &body body");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3918 */       LispObject vars = args.car();
/* 3919 */       args = args.cdr();
/* 3920 */       LispObject valuesForm = args.car();
/* 3921 */       LispObject body = args.cdr();
/* 3922 */       LispThread thread = LispThread.currentThread();
/* 3923 */       LispObject value = Lisp.eval(valuesForm, env, thread);
/* 3924 */       LispObject[] values = thread._values;
/* 3925 */       if (values == null) {
/*      */         
/* 3927 */         values = new LispObject[1];
/* 3928 */         values[0] = value;
/*      */       } 
/*      */       
/* 3931 */       LispObject bodyAndDecls = Lisp.parseBody(body, false);
/* 3932 */       LispObject specials = Lisp.parseSpecials(bodyAndDecls.NTH(1));
/* 3933 */       body = bodyAndDecls.car();
/*      */       
/* 3935 */       SpecialBindingsMark mark = thread.markSpecialBindings();
/* 3936 */       Environment ext = new Environment(env);
/* 3937 */       int i = 0;
/* 3938 */       LispObject var = vars.car();
/* 3939 */       while (var != Lisp.NIL) {
/*      */ 
/*      */         
/* 3942 */         Symbol sym = Lisp.checkSymbol(var);
/*      */         
/* 3944 */         LispObject val = (i < values.length) ? values[i] : Lisp.NIL;
/* 3945 */         if (specials != Lisp.NIL && Lisp.memq(sym, specials)) {
/* 3946 */           thread.bindSpecial(sym, val);
/* 3947 */           ext.declareSpecial(sym);
/* 3948 */         } else if (sym.isSpecialVariable()) {
/* 3949 */           thread.bindSpecial(sym, val);
/*      */         } else {
/* 3951 */           ext.bind(sym, val);
/* 3952 */         }  vars = vars.cdr();
/* 3953 */         var = vars.car();
/* 3954 */         i++;
/*      */       } 
/*      */ 
/*      */ 
/*      */ 
/*      */       
/* 3960 */       while (specials != Lisp.NIL) {
/* 3961 */         Symbol symbol = (Symbol)specials.car();
/* 3962 */         ext.declareSpecial(symbol);
/* 3963 */         specials = ((Cons)specials).cdr;
/*      */       } 
/* 3965 */       thread._values = null;
/* 3966 */       LispObject result = Lisp.NIL;
/*      */       try {
/* 3968 */         thread.envStack.push(ext);
/* 3969 */         result = Lisp.progn(body, ext, thread);
/*      */       } finally {
/*      */         
/* 3972 */         thread.resetSpecialBindings(mark);
/* 3973 */         while (thread.envStack.pop() != ext);
/*      */       } 
/* 3975 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 3980 */   private static final SpecialOperator MULTIPLE_VALUE_PROG1 = new sf_multiple_value_prog1();
/*      */   
/*      */   private static final class sf_multiple_value_prog1 extends SpecialOperator { sf_multiple_value_prog1() {
/* 3983 */       super(Symbol.MULTIPLE_VALUE_PROG1, "values-form &rest forms");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 3991 */       if (args.length() == 0)
/* 3992 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 3993 */       LispThread thread = LispThread.currentThread();
/* 3994 */       LispObject result = Lisp.eval(args.car(), env, thread);
/* 3995 */       LispObject[] values = thread._values;
/* 3996 */       while ((args = args.cdr()) != Lisp.NIL)
/* 3997 */         Lisp.eval(args.car(), env, thread); 
/* 3998 */       if (values != null) {
/* 3999 */         thread.setValues(values);
/*      */       } else {
/* 4001 */         thread._values = null;
/* 4002 */       }  return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4007 */   private static final SpecialOperator MULTIPLE_VALUE_CALL = new sf_multiple_value_call();
/*      */   
/*      */   private static final class sf_multiple_value_call extends SpecialOperator { sf_multiple_value_call() {
/* 4010 */       super(Symbol.MULTIPLE_VALUE_CALL, "fun &rest args");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/*      */       LispObject function;
/* 4017 */       if (args.length() == 0)
/* 4018 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 4019 */       LispThread thread = LispThread.currentThread();
/*      */       
/* 4021 */       LispObject obj = Lisp.eval(args.car(), env, thread);
/* 4022 */       args = args.cdr();
/* 4023 */       if (obj instanceof Symbol) {
/* 4024 */         function = obj.getSymbolFunction();
/* 4025 */         if (function == null)
/* 4026 */           Lisp.error(new UndefinedFunction(obj)); 
/* 4027 */       } else if (obj instanceof Function) {
/* 4028 */         function = obj;
/*      */       } else {
/* 4030 */         Lisp.error(new LispError(obj.princToString() + " is not a function name."));
/*      */         
/* 4032 */         return Lisp.NIL;
/*      */       } 
/* 4034 */       ArrayList<LispObject> arrayList = new ArrayList<>();
/* 4035 */       while (args != Lisp.NIL) {
/* 4036 */         LispObject form = args.car();
/* 4037 */         LispObject result = Lisp.eval(form, env, thread);
/* 4038 */         LispObject[] values = thread._values;
/* 4039 */         if (values != null) {
/* 4040 */           for (int i = 0; i < values.length; i++)
/* 4041 */             arrayList.add(values[i]); 
/*      */         } else {
/* 4043 */           arrayList.add(result);
/* 4044 */         }  args = ((Cons)args).cdr;
/*      */       } 
/* 4046 */       LispObject[] argv = new LispObject[arrayList.size()];
/* 4047 */       arrayList.toArray(argv);
/* 4048 */       return Lisp.funcall(function, argv, thread);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4054 */   private static final SpecialOperator AND = new sf_and();
/*      */   
/*      */   private static final class sf_and extends SpecialOperator { sf_and() {
/* 4057 */       super(Symbol.AND, "&rest forms");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 4064 */       LispThread thread = LispThread.currentThread();
/* 4065 */       LispObject result = Lisp.T;
/* 4066 */       while (args != Lisp.NIL) {
/* 4067 */         result = Lisp.eval(args.car(), env, thread);
/* 4068 */         if (result == Lisp.NIL) {
/* 4069 */           if (((Cons)args).cdr != Lisp.NIL)
/*      */           {
/* 4071 */             thread._values = null;
/*      */           }
/*      */           break;
/*      */         } 
/* 4075 */         args = ((Cons)args).cdr;
/*      */       } 
/* 4077 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4083 */   private static final SpecialOperator OR = new sf_or();
/*      */   
/*      */   private static final class sf_or extends SpecialOperator { sf_or() {
/* 4086 */       super(Symbol.OR, "&rest forms");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 4093 */       LispThread thread = LispThread.currentThread();
/* 4094 */       LispObject result = Lisp.NIL;
/* 4095 */       while (args != Lisp.NIL) {
/* 4096 */         result = Lisp.eval(args.car(), env, thread);
/* 4097 */         if (result != Lisp.NIL) {
/* 4098 */           if (((Cons)args).cdr != Lisp.NIL)
/*      */           {
/* 4100 */             thread._values = null;
/*      */           }
/*      */           break;
/*      */         } 
/* 4104 */         args = ((Cons)args).cdr;
/*      */       } 
/* 4106 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4113 */   private static final SpecialOperator MULTIPLE_VALUE_LIST = new sf_multiple_value_list();
/*      */   
/*      */   private static final class sf_multiple_value_list extends SpecialOperator { sf_multiple_value_list() {
/* 4116 */       super(Symbol.MULTIPLE_VALUE_LIST, "value-form");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 4123 */       if (args.length() != 1)
/* 4124 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 1)); 
/* 4125 */       LispThread thread = LispThread.currentThread();
/* 4126 */       LispObject result = Lisp.eval(((Cons)args).car, env, thread);
/* 4127 */       LispObject[] values = thread._values;
/* 4128 */       if (values == null)
/* 4129 */         return new Cons(result); 
/* 4130 */       thread._values = null;
/* 4131 */       LispObject list = Lisp.NIL;
/* 4132 */       for (int i = values.length; i-- > 0;)
/* 4133 */         list = new Cons(values[i], list); 
/* 4134 */       return list;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4142 */   private static final SpecialOperator NTH_VALUE = new sf_nth_value();
/*      */   
/*      */   private static final class sf_nth_value extends SpecialOperator { sf_nth_value() {
/* 4145 */       super(Symbol.NTH_VALUE, "n form");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject args, Environment env) {
/* 4152 */       if (args.length() != 2)
/* 4153 */         return Lisp.error(new WrongNumberOfArgumentsException(this, 2)); 
/* 4154 */       LispThread thread = LispThread.currentThread();
/* 4155 */       int n = Fixnum.getValue(Lisp.eval(args.car(), env, thread));
/* 4156 */       if (n < 0)
/* 4157 */         n = 0; 
/* 4158 */       LispObject result = Lisp.eval(args.cadr(), env, thread);
/* 4159 */       LispObject[] values = thread._values;
/* 4160 */       thread._values = null;
/* 4161 */       if (values == null)
/*      */       {
/* 4163 */         return (n == 0) ? result : Lisp.NIL;
/*      */       }
/* 4165 */       if (n < values.length)
/* 4166 */         return values[n]; 
/* 4167 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4172 */   private static final Primitive CALL_COUNT = new pf_call_count();
/*      */   
/*      */   private static final class pf_call_count extends Primitive { pf_call_count() {
/* 4175 */       super("call-count", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4180 */       return Fixnum.getInstance(arg.getCallCount());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4185 */   private static final Primitive SET_CALL_COUNT = new pf_set_call_count();
/*      */   
/*      */   private static final class pf_set_call_count extends Primitive { pf_set_call_count() {
/* 4188 */       super("set-call-count", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4195 */       first.setCallCount(Fixnum.getValue(second));
/* 4196 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4201 */   private static final Primitive HOT_COUNT = new pf_hot_count();
/*      */   
/*      */   private static final class pf_hot_count extends Primitive { pf_hot_count() {
/* 4204 */       super("hot-count", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4209 */       return Fixnum.getInstance(arg.getHotCount());
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4214 */   private static final Primitive SET_HOT_COUNT = new pf_set_hot_count();
/*      */   
/*      */   private static final class pf_set_hot_count extends Primitive { pf_set_hot_count() {
/* 4217 */       super("set-hot-count", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4224 */       first.setHotCount(Fixnum.getValue(second));
/* 4225 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4230 */   private static final Primitive LAMBDA_NAME = new pf_lambda_name();
/*      */   
/*      */   private static final class pf_lambda_name extends Primitive { pf_lambda_name() {
/* 4233 */       super("lambda-name", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4238 */       if (arg instanceof Operator) {
/* 4239 */         return ((Operator)arg).getLambdaName();
/*      */       }
/* 4241 */       if (arg.typep(Symbol.GENERIC_FUNCTION) != Lisp.NIL) {
/* 4242 */         return Symbol.GENERIC_FUNCTION_NAME.execute(arg);
/*      */       }
/* 4244 */       if (arg instanceof FuncallableStandardObject) {
/* 4245 */         return execute(((FuncallableStandardObject)arg).function);
/*      */       }
/* 4247 */       return Lisp.type_error(arg, Symbol.FUNCTION);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4252 */   private static final Primitive _SET_LAMBDA_NAME = new pf__set_lambda_name();
/*      */   
/*      */   private static final class pf__set_lambda_name extends Primitive { pf__set_lambda_name() {
/* 4255 */       super("%set-lambda-name", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4262 */       if (first instanceof Operator) {
/* 4263 */         ((Operator)first).setLambdaName(second);
/* 4264 */         return second;
/*      */       } 
/*      */ 
/*      */ 
/*      */       
/* 4269 */       if (first.typep(Symbol.STANDARD_GENERIC_FUNCTION) != Lisp.NIL) {
/* 4270 */         ((StandardObject)first).setInstanceSlotValue(Symbol.NAME, second);
/* 4271 */         return second;
/*      */       } 
/* 4273 */       if (first instanceof FuncallableStandardObject) {
/* 4274 */         return execute(((FuncallableStandardObject)first).function, second);
/*      */       }
/* 4276 */       return Lisp.type_error(first, Symbol.FUNCTION);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4284 */   private static final Primitive SHRINK_VECTOR = new pf_shrink_vector();
/*      */   
/*      */   private static final class pf_shrink_vector extends Primitive { pf_shrink_vector() {
/* 4287 */       super("shrink-vector", Lisp.PACKAGE_SYS, true, "vector new-size");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4294 */       Lisp.checkVector(first).shrink(Fixnum.getValue(second));
/* 4295 */       return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4300 */   private static final Primitive SUBSEQ = new pf_subseq();
/*      */   
/*      */   private static final class pf_subseq extends Primitive { pf_subseq() {
/* 4303 */       super(Lisp.PACKAGE_SYS.intern("%SUBSEQ"), "sequence start &optional end");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4310 */       return execute(first, second, Lisp.NIL);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 4318 */       int end, start = Fixnum.getValue(second);
/* 4319 */       if (start < 0) {
/* 4320 */         StringBuilder sb = new StringBuilder("Bad start index (");
/* 4321 */         sb.append(start);
/* 4322 */         sb.append(").");
/* 4323 */         Lisp.error(new TypeError(sb.toString()));
/*      */       } 
/*      */       
/* 4326 */       if (third != Lisp.NIL) {
/* 4327 */         end = Fixnum.getValue(third);
/* 4328 */         if (start > end) {
/* 4329 */           StringBuilder sb = new StringBuilder("Start index (");
/* 4330 */           sb.append(start);
/* 4331 */           sb.append(") is greater than end index (");
/* 4332 */           sb.append(end);
/* 4333 */           sb.append(") for SUBSEQ.");
/* 4334 */           Lisp.error(new TypeError(sb.toString()));
/*      */         } 
/*      */       } else {
/* 4337 */         end = -1;
/* 4338 */       }  if (first.listp())
/* 4339 */         return Primitives.list_subseq(first, start, end); 
/* 4340 */       if (first instanceof AbstractVector) {
/* 4341 */         AbstractVector v = (AbstractVector)first;
/* 4342 */         if (end < 0)
/* 4343 */           end = v.length(); 
/* 4344 */         if (start > end) {
/* 4345 */           StringBuilder sb = new StringBuilder("Start index (");
/* 4346 */           sb.append(start);
/* 4347 */           sb.append(") is greater than length of vector (");
/* 4348 */           sb.append(end);
/* 4349 */           sb.append(") for SUBSEQ.");
/* 4350 */           Lisp.error(new TypeError(sb.toString()));
/*      */         } 
/* 4352 */         return v.subseq(start, end);
/*      */       } 
/* 4354 */       return Lisp.type_error(first, Symbol.SEQUENCE);
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject list_subseq(LispObject list, int start, int end) {
/* 4362 */     int index = 0;
/* 4363 */     LispObject result = Lisp.NIL;
/* 4364 */     while (list != Lisp.NIL) {
/* 4365 */       if (end >= 0 && index == end)
/* 4366 */         return result.nreverse(); 
/* 4367 */       if (index++ >= start)
/* 4368 */         result = new Cons(list.car(), result); 
/* 4369 */       list = list.cdr();
/*      */     } 
/* 4371 */     return result.nreverse();
/*      */   }
/*      */ 
/*      */   
/* 4375 */   private static final Primitive LIST = new pf_list();
/*      */   
/*      */   private static final class pf_list extends Primitive { pf_list() {
/* 4378 */       super(Symbol.LIST, "&rest objects");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 4383 */       return Lisp.NIL;
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4387 */       return new Cons(arg);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4391 */       return new Cons(first, new Cons(second));
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 4396 */       return new Cons(first, new Cons(second, new Cons(third)));
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 4401 */       return new Cons(first, new Cons(second, new Cons(third, new Cons(fourth))));
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 4408 */       LispObject result = Lisp.NIL;
/* 4409 */       for (int i = args.length; i-- > 0;)
/* 4410 */         result = new Cons(args[i], result); 
/* 4411 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4416 */   private static final Primitive LIST_STAR = new pf_list_star();
/*      */   
/*      */   private static final class pf_list_star extends Primitive { pf_list_star() {
/* 4419 */       super(Symbol.LIST_STAR, "&rest objects");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 4424 */       return Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1));
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4428 */       return arg;
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4434 */       return new Cons(first, second);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 4441 */       return new Cons(first, new Cons(second, third));
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third, LispObject fourth) {
/* 4448 */       return new Cons(first, new Cons(second, new Cons(third, fourth)));
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 4454 */       int i = args.length - 1;
/* 4455 */       LispObject result = args[i];
/* 4456 */       while (i-- > 0)
/* 4457 */         result = new Cons(args[i], result); 
/* 4458 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4463 */   public static final Primitive NREVERSE = new pf_nreverse();
/*      */   
/*      */   private static final class pf_nreverse extends Primitive { pf_nreverse() {
/* 4466 */       super("%NREVERSE", Lisp.PACKAGE_SYS, false, "sequence");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4471 */       return arg.nreverse();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4476 */   private static final Primitive NRECONC = new pf_nreconc();
/*      */   
/*      */   private static final class pf_nreconc extends Primitive { pf_nreconc() {
/* 4479 */       super(Symbol.NRECONC, "list tail");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject list, LispObject obj) {
/* 4486 */       if (list instanceof Cons) {
/* 4487 */         LispObject list3 = list.cdr();
/* 4488 */         if (list3 instanceof Cons) {
/* 4489 */           if (list3.cdr() instanceof Cons) {
/* 4490 */             LispObject list1 = list3;
/* 4491 */             LispObject list2 = Lisp.NIL;
/*      */             while (true) {
/* 4493 */               LispObject lispObject = list3.cdr();
/* 4494 */               list3.setCdr(list2);
/* 4495 */               list2 = list3;
/* 4496 */               list3 = lispObject;
/* 4497 */               if (!(list3.cdr() instanceof Cons))
/* 4498 */               { list.setCdr(list2);
/* 4499 */                 list1.setCdr(list3); break; } 
/*      */             } 
/* 4501 */           }  LispObject h = list.car();
/* 4502 */           list.setCar(list3.car());
/* 4503 */           list3.setCar(h);
/* 4504 */           list3.setCdr(obj);
/* 4505 */         } else if (list3 == Lisp.NIL) {
/* 4506 */           list.setCdr(obj);
/*      */         } else {
/* 4508 */           Lisp.type_error(list3, Symbol.LIST);
/* 4509 */         }  return list;
/* 4510 */       }  if (list == Lisp.NIL) {
/* 4511 */         return obj;
/*      */       }
/* 4513 */       return Lisp.type_error(list, Symbol.LIST);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4518 */   private static final Primitive REVERSE = new pf_reverse();
/*      */   
/*      */   private static final class pf_reverse extends Primitive { pf_reverse() {
/* 4521 */       super("%reverse", Lisp.PACKAGE_SYS, false, "sequence");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4526 */       return arg.reverse();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4531 */   private static final Primitive DELETE_EQ = new pf_delete_eq();
/*      */   
/*      */   private static final class pf_delete_eq extends Primitive { pf_delete_eq() {
/* 4534 */       super("delete-eq", Lisp.PACKAGE_SYS, true, "item sequence");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject sequence) {
/* 4541 */       if (sequence instanceof AbstractVector) {
/* 4542 */         return ((AbstractVector)sequence).deleteEq(item);
/*      */       }
/* 4544 */       return Primitives.LIST_DELETE_EQ.execute(item, sequence);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4549 */   private static final Primitive DELETE_EQL = new pf_delete_eql();
/*      */   
/*      */   private static final class pf_delete_eql extends Primitive { pf_delete_eql() {
/* 4552 */       super("delete-eql", Lisp.PACKAGE_SYS, true, "item sequence");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject sequence) {
/* 4559 */       if (sequence instanceof AbstractVector) {
/* 4560 */         return ((AbstractVector)sequence).deleteEql(item);
/*      */       }
/* 4562 */       return Primitives.LIST_DELETE_EQL.execute(item, sequence);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4567 */   static final Primitive LIST_DELETE_EQ = new pf_list_delete_eq();
/*      */   
/*      */   private static final class pf_list_delete_eq extends Primitive { pf_list_delete_eq() {
/* 4570 */       super("list-delete-eq", Lisp.PACKAGE_SYS, true, "item list");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject list) {
/* 4577 */       if (list instanceof Cons) {
/* 4578 */         LispObject tail = list;
/* 4579 */         LispObject splice = list;
/* 4580 */         while (tail instanceof Cons) {
/* 4581 */           LispObject car = tail.car();
/* 4582 */           if (car == item) {
/* 4583 */             if (tail.cdr() != Lisp.NIL) {
/* 4584 */               LispObject temp = tail;
/* 4585 */               tail.setCar(temp.cadr());
/* 4586 */               tail.setCdr(temp.cddr());
/*      */               continue;
/*      */             } 
/* 4589 */             if (tail == list)
/* 4590 */               return Lisp.NIL; 
/* 4591 */             splice.setCdr(Lisp.NIL);
/* 4592 */             return list;
/*      */           } 
/*      */           
/* 4595 */           splice = tail;
/* 4596 */           tail = tail.cdr();
/*      */         } 
/*      */         
/* 4599 */         if (tail == Lisp.NIL) {
/* 4600 */           return list;
/*      */         }
/* 4602 */         return Lisp.type_error(tail, Symbol.LIST);
/* 4603 */       }  if (list == Lisp.NIL) {
/* 4604 */         return list;
/*      */       }
/* 4606 */       return Lisp.type_error(list, Symbol.LIST);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4611 */   static final Primitive LIST_DELETE_EQL = new pf_list_delete_eql();
/*      */   
/*      */   private static final class pf_list_delete_eql extends Primitive { pf_list_delete_eql() {
/* 4614 */       super("list-delete-eql", Lisp.PACKAGE_SYS, true, "item list");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject list) {
/* 4621 */       if (list instanceof Cons) {
/* 4622 */         LispObject tail = list;
/* 4623 */         LispObject splice = list;
/* 4624 */         while (tail instanceof Cons) {
/* 4625 */           LispObject car = tail.car();
/* 4626 */           if (car.eql(item)) {
/* 4627 */             if (tail.cdr() != Lisp.NIL) {
/* 4628 */               LispObject temp = tail;
/* 4629 */               tail.setCar(temp.cadr());
/* 4630 */               tail.setCdr(temp.cddr());
/*      */               continue;
/*      */             } 
/* 4633 */             if (tail == list)
/* 4634 */               return Lisp.NIL; 
/* 4635 */             splice.setCdr(Lisp.NIL);
/* 4636 */             return list;
/*      */           } 
/*      */           
/* 4639 */           splice = tail;
/* 4640 */           tail = tail.cdr();
/*      */         } 
/*      */         
/* 4643 */         if (tail == Lisp.NIL) {
/* 4644 */           return list;
/*      */         }
/* 4646 */         return Lisp.type_error(tail, Symbol.LIST);
/* 4647 */       }  if (list == Lisp.NIL) {
/* 4648 */         return list;
/*      */       }
/* 4650 */       return Lisp.type_error(list, Symbol.LIST);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4655 */   private static final Primitive VECTOR_DELETE_EQ = new pf_vector_delete_eq();
/*      */   
/*      */   private static final class pf_vector_delete_eq extends Primitive { pf_vector_delete_eq() {
/* 4658 */       super("vector-delete-eq", Lisp.PACKAGE_SYS, true, "item vector");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject vector) {
/* 4665 */       Lisp.checkVector(vector).deleteEq(item);
/* 4666 */       return vector;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4671 */   private static final Primitive VECTOR_DELETE_EQL = new pf_vector_delete_eql();
/*      */   
/*      */   private static final class pf_vector_delete_eql extends Primitive { pf_vector_delete_eql() {
/* 4674 */       super("vector-delete-eql", Lisp.PACKAGE_SYS, true, "item vector");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject vector) {
/* 4681 */       Lisp.checkVector(vector).deleteEql(item);
/* 4682 */       return vector;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 4688 */   private static final Primitive _SET_ELT = new pf__set_elt();
/*      */   
/*      */   private static final class pf__set_elt extends Primitive { pf__set_elt() {
/* 4691 */       super("%set-elt", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 4699 */       if (first instanceof AbstractVector) {
/* 4700 */         ((AbstractVector)first).aset(Fixnum.getValue(second), third);
/* 4701 */         return third;
/*      */       } 
/* 4703 */       if (first instanceof Cons) {
/* 4704 */         int index = Fixnum.getValue(second);
/* 4705 */         if (index < 0)
/* 4706 */           Lisp.error(new TypeError()); 
/* 4707 */         LispObject list = first;
/* 4708 */         int i = 0;
/*      */         while (true) {
/* 4710 */           if (i == index) {
/* 4711 */             list.setCar(third);
/* 4712 */             return third;
/*      */           } 
/* 4714 */           list = list.cdr();
/* 4715 */           if (list == Lisp.NIL)
/* 4716 */             Lisp.error(new TypeError()); 
/* 4717 */           i++;
/*      */         } 
/*      */       } 
/* 4720 */       return Lisp.type_error(first, Symbol.SEQUENCE);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4725 */   private static final Primitive _MAKE_LIST = new pf__make_list();
/*      */   
/*      */   private static final class pf__make_list extends Primitive { pf__make_list() {
/* 4728 */       super("%make-list", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4735 */       int size = Fixnum.getValue(first);
/* 4736 */       if (size < 0)
/* 4737 */         return Lisp.type_error(first, Lisp.list(Symbol.INTEGER, new LispObject[] { Fixnum.ZERO, Symbol.MOST_POSITIVE_FIXNUM
/* 4738 */                 .getSymbolValue() })); 
/* 4739 */       LispObject result = Lisp.NIL;
/* 4740 */       for (int i = size; i-- > 0;)
/* 4741 */         result = new Cons(second, result); 
/* 4742 */       return result;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4747 */   private static final Primitive _MEMBER = new pf__member();
/*      */   
/*      */   private static final class pf__member extends Primitive { pf__member() {
/* 4750 */       super("%member", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject item, LispObject list, LispObject key, LispObject test, LispObject testNot) {
/* 4759 */       LispObject tail = Lisp.checkList(list);
/* 4760 */       if (test != Lisp.NIL && testNot != Lisp.NIL)
/* 4761 */         Lisp.error(new LispError("MEMBER: test and test-not both supplied")); 
/* 4762 */       if (testNot == Lisp.NIL && (
/* 4763 */         test == Lisp.NIL || test == Symbol.EQL)) {
/* 4764 */         test = Primitives.EQL;
/*      */       }
/* 4766 */       if (key == Lisp.NIL) {
/* 4767 */         if (test == Primitives.EQL) {
/* 4768 */           while (tail instanceof Cons) {
/* 4769 */             if (item.eql(((Cons)tail).car))
/* 4770 */               return tail; 
/* 4771 */             tail = ((Cons)tail).cdr;
/*      */           } 
/* 4773 */         } else if (test != Lisp.NIL) {
/* 4774 */           while (tail instanceof Cons) {
/* 4775 */             LispObject candidate = ((Cons)tail).car;
/* 4776 */             if (test.execute(item, candidate) != Lisp.NIL)
/* 4777 */               return tail; 
/* 4778 */             tail = ((Cons)tail).cdr;
/*      */           } 
/*      */         } else {
/*      */           
/* 4782 */           while (tail instanceof Cons) {
/* 4783 */             LispObject candidate = ((Cons)tail).car;
/* 4784 */             if (testNot.execute(item, candidate) == Lisp.NIL)
/* 4785 */               return tail; 
/* 4786 */             tail = ((Cons)tail).cdr;
/*      */           } 
/*      */         } 
/*      */       } else {
/*      */         
/* 4791 */         while (tail instanceof Cons) {
/* 4792 */           LispObject candidate = key.execute(((Cons)tail).car);
/* 4793 */           if (test != Lisp.NIL) {
/* 4794 */             if (test.execute(item, candidate) != Lisp.NIL) {
/* 4795 */               return tail;
/*      */             }
/* 4797 */           } else if (testNot.execute(item, candidate) == Lisp.NIL) {
/* 4798 */             return tail;
/*      */           } 
/* 4800 */           tail = ((Cons)tail).cdr;
/*      */         } 
/*      */       } 
/* 4803 */       if (tail != Lisp.NIL)
/* 4804 */         Lisp.type_error(tail, Symbol.LIST); 
/* 4805 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4810 */   private static final Primitive FUNCALL_KEY = new pf_funcall_key();
/*      */   
/*      */   private static final class pf_funcall_key extends Primitive { pf_funcall_key() {
/* 4813 */       super("funcall-key", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4820 */       if (first != Lisp.NIL)
/* 4821 */         return LispThread.currentThread().execute(first, second); 
/* 4822 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4827 */   private static final Primitive COERCE_TO_FUNCTION = new pf_coerce_to_function();
/*      */   
/*      */   private static final class pf_coerce_to_function extends Primitive { pf_coerce_to_function() {
/* 4830 */       super("coerce-to-function", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4835 */       return Lisp.coerceToFunction(arg);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4840 */   private static final Primitive MAKE_CLOSURE = new pf_make_closure();
/*      */   
/*      */   private static final class pf_make_closure extends Primitive { pf_make_closure() {
/* 4843 */       super("make-closure", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4850 */       if (first instanceof Cons && ((Cons)first).car == Symbol.LAMBDA) {
/*      */         Environment env;
/* 4852 */         if (second == Lisp.NIL) {
/* 4853 */           env = new Environment();
/*      */         } else {
/* 4855 */           env = Lisp.checkEnvironment(second);
/* 4856 */         }  return new Closure(first, env);
/*      */       } 
/* 4858 */       return Lisp.error(new TypeError("The argument to MAKE-CLOSURE is not a lambda form."));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4863 */   private static final Primitive STREAMP = new pf_streamp();
/*      */   
/*      */   private static final class pf_streamp extends Primitive { pf_streamp() {
/* 4866 */       super(Symbol.STREAMP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4871 */       return (arg instanceof Stream) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4876 */   private static final Primitive INTEGERP = new pf_integerp();
/*      */   
/*      */   private static final class pf_integerp extends Primitive { pf_integerp() {
/* 4879 */       super(Symbol.INTEGERP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4884 */       return arg.INTEGERP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4889 */   private static final Primitive EVENP = new pf_evenp();
/*      */   
/*      */   private static final class pf_evenp extends Primitive { pf_evenp() {
/* 4892 */       super(Symbol.EVENP, "integer");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4897 */       return arg.EVENP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4902 */   private static final Primitive ODDP = new pf_oddp();
/*      */   
/*      */   private static final class pf_oddp extends Primitive { pf_oddp() {
/* 4905 */       super(Symbol.ODDP, "integer");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4910 */       return arg.ODDP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4915 */   private static final Primitive NUMBERP = new pf_numberp();
/*      */   
/*      */   private static final class pf_numberp extends Primitive { pf_numberp() {
/* 4918 */       super(Symbol.NUMBERP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4923 */       return arg.NUMBERP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4928 */   private static final Primitive REALP = new pf_realp();
/*      */   
/*      */   private static final class pf_realp extends Primitive { pf_realp() {
/* 4931 */       super(Symbol.REALP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4936 */       return arg.REALP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4941 */   private static final Primitive RATIONALP = new pf_rationalp();
/*      */   
/*      */   private static final class pf_rationalp extends Primitive { pf_rationalp() {
/* 4944 */       super(Symbol.RATIONALP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4949 */       return arg.RATIONALP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4954 */   private static final Primitive COMPLEX = new pf_complex();
/*      */   
/*      */   private static final class pf_complex extends Primitive { pf_complex() {
/* 4957 */       super(Symbol.COMPLEX, "realpart &optional imagpart");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4962 */       if (arg instanceof SingleFloat)
/* 4963 */         return Complex.getInstance(arg, SingleFloat.ZERO); 
/* 4964 */       if (arg instanceof DoubleFloat)
/* 4965 */         return Complex.getInstance(arg, DoubleFloat.ZERO); 
/* 4966 */       if (arg.realp())
/* 4967 */         return arg; 
/* 4968 */       return Lisp.type_error(arg, Symbol.REAL);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 4974 */       return Complex.getInstance(first, second);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4979 */   private static final Primitive COMPLEXP = new pf_complexp();
/*      */   
/*      */   private static final class pf_complexp extends Primitive { pf_complexp() {
/* 4982 */       super(Symbol.COMPLEXP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 4987 */       return arg.COMPLEXP();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 4992 */   private static final Primitive NUMERATOR = new pf_numerator();
/*      */   
/*      */   private static final class pf_numerator extends Primitive { pf_numerator() {
/* 4995 */       super(Symbol.NUMERATOR, "rational");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5000 */       return arg.NUMERATOR();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5005 */   private static final Primitive DENOMINATOR = new pf_denominator();
/*      */   
/*      */   private static final class pf_denominator extends Primitive { pf_denominator() {
/* 5008 */       super(Symbol.DENOMINATOR, "rational");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5013 */       return arg.DENOMINATOR();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5018 */   private static final Primitive REALPART = new pf_realpart();
/*      */   
/*      */   private static final class pf_realpart extends Primitive { pf_realpart() {
/* 5021 */       super(Symbol.REALPART, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5026 */       if (arg instanceof Complex)
/* 5027 */         return ((Complex)arg).getRealPart(); 
/* 5028 */       if (arg.numberp())
/* 5029 */         return arg; 
/* 5030 */       return Lisp.type_error(arg, Symbol.NUMBER);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5035 */   private static final Primitive IMAGPART = new pf_imagpart();
/*      */   
/*      */   private static final class pf_imagpart extends Primitive { pf_imagpart() {
/* 5038 */       super(Symbol.IMAGPART, "number");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5043 */       if (arg instanceof Complex)
/* 5044 */         return ((Complex)arg).getImaginaryPart(); 
/* 5045 */       return arg.multiplyBy(Fixnum.ZERO);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5050 */   private static final Primitive INTEGER_LENGTH = new pf_integer_length();
/*      */   
/*      */   private static final class pf_integer_length extends Primitive { pf_integer_length() {
/* 5053 */       super(Symbol.INTEGER_LENGTH, "integer");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5058 */       if (arg instanceof Fixnum) {
/* 5059 */         int n = ((Fixnum)arg).value;
/* 5060 */         if (n < 0)
/* 5061 */           n ^= 0xFFFFFFFF; 
/* 5062 */         int count = 0;
/* 5063 */         while (n > 0) {
/* 5064 */           n >>>= 1;
/* 5065 */           count++;
/*      */         } 
/* 5067 */         return Fixnum.getInstance(count);
/*      */       } 
/* 5069 */       if (arg instanceof Bignum)
/* 5070 */         return Fixnum.getInstance(((Bignum)arg).value.bitLength()); 
/* 5071 */       return Lisp.type_error(arg, Symbol.INTEGER);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5076 */   private static final Primitive GCD_2 = new pf_gcd_2();
/*      */   
/*      */   private static final class pf_gcd_2 extends Primitive { pf_gcd_2() {
/* 5079 */       super("gcd-2", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/*      */       BigInteger n1;
/*      */       BigInteger n2;
/* 5087 */       if (first instanceof Fixnum) {
/* 5088 */         n1 = BigInteger.valueOf(((Fixnum)first).value);
/* 5089 */       } else if (first instanceof Bignum) {
/* 5090 */         n1 = ((Bignum)first).value;
/*      */       } else {
/* 5092 */         return Lisp.type_error(first, Symbol.INTEGER);
/* 5093 */       }  if (second instanceof Fixnum) {
/* 5094 */         n2 = BigInteger.valueOf(((Fixnum)second).value);
/* 5095 */       } else if (second instanceof Bignum) {
/* 5096 */         n2 = ((Bignum)second).value;
/*      */       } else {
/* 5098 */         return Lisp.type_error(second, Symbol.INTEGER);
/* 5099 */       }  return Lisp.number(n1.gcd(n2));
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5104 */   private static final Primitive IDENTITY_HASH_CODE = new pf_identity_hash_code();
/*      */   
/*      */   private static final class pf_identity_hash_code extends Primitive { pf_identity_hash_code() {
/* 5107 */       super("identity-hash-code", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5112 */       return Fixnum.getInstance(System.identityHashCode(arg));
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 5118 */   private static final Primitive SIMPLE_VECTOR_SEARCH = new pf_simple_vector_search();
/*      */   
/*      */   private static final class pf_simple_vector_search extends Primitive { pf_simple_vector_search() {
/* 5121 */       super("simple-vector-search", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5128 */       AbstractVector v = Lisp.checkVector(second);
/* 5129 */       if (first.length() == 0)
/* 5130 */         return Fixnum.ZERO; 
/* 5131 */       int patternLength = first.length();
/* 5132 */       int limit = v.length() - patternLength;
/* 5133 */       if (first instanceof AbstractVector) {
/* 5134 */         AbstractVector pattern = (AbstractVector)first;
/* 5135 */         LispObject element = pattern.AREF(0);
/* 5136 */         for (int i = 0; i <= limit; i++) {
/* 5137 */           if (v.AREF(i).eql(element)) {
/*      */             
/* 5139 */             boolean match = true;
/*      */             
/* 5141 */             int j = i + 1;
/* 5142 */             for (int k = 1; k < patternLength; k++) {
/* 5143 */               if (v.AREF(j).eql(pattern.AREF(k))) {
/* 5144 */                 j++;
/*      */               } else {
/* 5146 */                 match = false;
/*      */                 break;
/*      */               } 
/*      */             } 
/* 5150 */             if (match) {
/* 5151 */               return Fixnum.getInstance(i);
/*      */             }
/*      */           } 
/*      */         } 
/*      */       } else {
/* 5156 */         LispObject element = first.car();
/* 5157 */         for (int i = 0; i <= limit; i++) {
/* 5158 */           if (v.AREF(i).eql(element)) {
/*      */             
/* 5160 */             boolean match = true;
/*      */             
/* 5162 */             int j = i + 1;
/* 5163 */             for (LispObject rest = first.cdr(); rest != Lisp.NIL; rest = rest.cdr()) {
/* 5164 */               if (v.AREF(j).eql(rest.car())) {
/* 5165 */                 j++;
/*      */               } else {
/* 5167 */                 match = false;
/*      */                 break;
/*      */               } 
/*      */             } 
/* 5171 */             if (match)
/* 5172 */               return Fixnum.getInstance(i); 
/*      */           } 
/*      */         } 
/*      */       } 
/* 5176 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5181 */   private static final Primitive UPTIME = new pf_uptime();
/*      */   
/*      */   private static final class pf_uptime extends Primitive { pf_uptime() {
/* 5184 */       super("uptime", Lisp.PACKAGE_EXT, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 5189 */       return Lisp.number(System.currentTimeMillis() - Main.startTimeMillis);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5194 */   private static final Primitive BUILT_IN_FUNCTION_P = new pf_built_in_function_p();
/*      */   
/*      */   private static final class pf_built_in_function_p extends Primitive { pf_built_in_function_p() {
/* 5197 */       super("built-in-function-p", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5202 */       return Lisp.checkSymbol(arg).isBuiltInFunction() ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5207 */   private static final Primitive INSPECTED_PARTS = new pf_inspected_parts();
/*      */   
/*      */   private static final class pf_inspected_parts extends Primitive { pf_inspected_parts() {
/* 5210 */       super("inspected-parts", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5215 */       return arg.getParts();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5220 */   private static final Primitive INSPECTED_DESCRIPTION = new pf_inspected_description();
/*      */   
/*      */   private static final class pf_inspected_description extends Primitive { pf_inspected_description() {
/* 5223 */       super("inspected-description", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5228 */       return arg.getDescription();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5233 */   public static final Primitive SYMBOL_NAME = new pf_symbol_name();
/*      */   
/*      */   private static final class pf_symbol_name extends Primitive { pf_symbol_name() {
/* 5236 */       super(Symbol.SYMBOL_NAME, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5241 */       return (Lisp.checkSymbol(arg)).name;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5246 */   public static final Primitive SYMBOL_PACKAGE = new pf_symbol_package();
/*      */   
/*      */   private static final class pf_symbol_package extends Primitive { pf_symbol_package() {
/* 5249 */       super(Symbol.SYMBOL_PACKAGE, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5254 */       return Lisp.checkSymbol(arg).getPackage();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5259 */   public static final Primitive SYMBOL_FUNCTION = new pf_symbol_function();
/*      */   
/*      */   private static final class pf_symbol_function extends Primitive { pf_symbol_function() {
/* 5262 */       super(Symbol.SYMBOL_FUNCTION, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5267 */       LispObject function = Lisp.checkSymbol(arg).getSymbolFunction();
/* 5268 */       if (function != null)
/* 5269 */         return function; 
/* 5270 */       return Lisp.error(new UndefinedFunction(arg));
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 5276 */   public static final Primitive _SET_SYMBOL_FUNCTION = new pf__set_symbol_function();
/*      */   
/*      */   private static final class pf__set_symbol_function extends Primitive { pf__set_symbol_function() {
/* 5279 */       super("%set-symbol-function", Lisp.PACKAGE_SYS, false, "symbol function");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5286 */       Lisp.checkSymbol(first).setSymbolFunction(second);
/* 5287 */       return second;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5292 */   public static final Primitive SYMBOL_PLIST = new pf_symbol_plist();
/*      */   
/*      */   private static final class pf_symbol_plist extends Primitive { pf_symbol_plist() {
/* 5295 */       super(Symbol.SYMBOL_PLIST, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5300 */       return Lisp.checkSymbol(arg).getPropertyList();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5305 */   public static final Primitive KEYWORDP = new pf_keywordp();
/*      */   
/*      */   private static final class pf_keywordp extends Primitive { pf_keywordp() {
/* 5308 */       super(Symbol.KEYWORDP, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5313 */       if (arg instanceof Symbol && 
/* 5314 */         Lisp.checkSymbol(arg).getPackage() == Lisp.PACKAGE_KEYWORD) {
/* 5315 */         return Lisp.T;
/*      */       }
/* 5317 */       return Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5322 */   public static final Primitive MAKE_SYMBOL = new pf_make_symbol();
/*      */   
/*      */   private static final class pf_make_symbol extends Primitive { pf_make_symbol() {
/* 5325 */       super(Symbol.MAKE_SYMBOL, "name");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5330 */       if (arg instanceof SimpleString) {
/* 5331 */         return new Symbol((SimpleString)arg);
/*      */       }
/* 5333 */       if (arg instanceof AbstractString)
/* 5334 */         return new Symbol(arg.getStringValue()); 
/* 5335 */       return Lisp.type_error(arg, Symbol.STRING);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5340 */   public static final Primitive MAKUNBOUND = new pf_makunbound();
/*      */   
/*      */   private static final class pf_makunbound extends Primitive { pf_makunbound() {
/* 5343 */       super(Symbol.MAKUNBOUND, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5348 */       Lisp.checkSymbol(arg).setSymbolValue((LispObject)null);
/* 5349 */       return arg;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5354 */   private static final Primitive _CLASS_NAME = new pf__class_name();
/*      */   
/*      */   private static final class pf__class_name extends Primitive { pf__class_name() {
/* 5357 */       super("%class-name", Lisp.PACKAGE_SYS, true, "class");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5362 */       if (arg instanceof LispClass) {
/* 5363 */         return ((LispClass)arg).getName();
/*      */       }
/* 5365 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symName);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5370 */   private static final Primitive _SET_CLASS_NAME = new pf__set_class_name();
/*      */   
/*      */   private static final class pf__set_class_name extends Primitive { pf__set_class_name() {
/* 5373 */       super("%set-class-name", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5380 */       if (second instanceof LispClass) {
/* 5381 */         ((LispClass)second).setName(Lisp.checkSymbol(first));
/*      */       } else {
/* 5383 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symName, 
/* 5384 */             Lisp.checkSymbol(first));
/* 5385 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5390 */   private static final Primitive CLASS_LAYOUT = new pf__class_layout();
/*      */   
/*      */   private static final class pf__class_layout extends Primitive { pf__class_layout() {
/* 5393 */       super("%class-layout", Lisp.PACKAGE_SYS, true, "class");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*      */       Layout layout;
/* 5399 */       if (arg instanceof LispClass) {
/* 5400 */         layout = ((LispClass)arg).getClassLayout();
/*      */       } else {
/* 5402 */         layout = (Layout)((StandardObject)arg).getInstanceSlotValue(StandardClass.symLayout);
/*      */       } 
/* 5404 */       return (layout != null) ? layout : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5409 */   private static final Primitive _SET_CLASS_LAYOUT = new pf__set_class_layout();
/*      */   
/*      */   private static final class pf__set_class_layout extends Primitive { pf__set_class_layout() {
/* 5412 */       super("%set-class-layout", Lisp.PACKAGE_SYS, true, "class layout");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5419 */       if (first == Lisp.NIL || first instanceof Layout) {
/* 5420 */         if (second instanceof LispClass) {
/* 5421 */           ((LispClass)second).setClassLayout(first);
/*      */         } else {
/* 5423 */           ((StandardObject)second).setInstanceSlotValue(StandardClass.symLayout, first);
/* 5424 */         }  return first;
/*      */       } 
/* 5426 */       return Lisp.type_error(first, Symbol.LAYOUT);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5431 */   private static final Primitive _CLASS_DIRECT_SUPERCLASSES = new pf__class_direct_superclasses();
/*      */   
/*      */   private static final class pf__class_direct_superclasses extends Primitive { pf__class_direct_superclasses() {
/* 5434 */       super("%class-direct-superclasses", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5439 */       if (arg instanceof LispClass) {
/* 5440 */         return ((LispClass)arg).getDirectSuperclasses();
/*      */       }
/* 5442 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symDirectSuperclasses);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5447 */   private static final Primitive _SET_CLASS_DIRECT_SUPERCLASSES = new pf__set_class_direct_superclasses();
/*      */   
/*      */   private static final class pf__set_class_direct_superclasses extends Primitive { pf__set_class_direct_superclasses() {
/* 5450 */       super("%set-class-direct-superclasses", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5456 */       if (second instanceof LispClass) {
/* 5457 */         ((LispClass)second).setDirectSuperclasses(first);
/*      */       } else {
/* 5459 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symDirectSuperclasses, first);
/* 5460 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5465 */   private static final Primitive _CLASS_DIRECT_SUBCLASSES = new pf__class_direct_subclasses();
/*      */   
/*      */   private static final class pf__class_direct_subclasses extends Primitive { pf__class_direct_subclasses() {
/* 5468 */       super("%class-direct-subclasses", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5473 */       if (arg instanceof LispClass) {
/* 5474 */         return ((LispClass)arg).getDirectSubclasses();
/*      */       }
/* 5476 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symDirectSubclasses);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5481 */   private static final Primitive _SET_CLASS_DIRECT_SUBCLASSES = new pf__set_class_direct_subclasses();
/*      */   
/*      */   private static final class pf__set_class_direct_subclasses extends Primitive { pf__set_class_direct_subclasses() {
/* 5484 */       super("%set-class-direct-subclasses", Lisp.PACKAGE_SYS, true, "class direct-subclasses");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5491 */       if (second instanceof LispClass) {
/* 5492 */         ((LispClass)second).setDirectSubclasses(first);
/*      */       } else {
/* 5494 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symDirectSubclasses, first);
/* 5495 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5500 */   private static final Primitive _CLASS_PRECEDENCE_LIST = new pf__class_precedence_list();
/*      */   
/*      */   private static final class pf__class_precedence_list extends Primitive { pf__class_precedence_list() {
/* 5503 */       super("%class-precedence-list", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5508 */       if (arg instanceof LispClass) {
/* 5509 */         return ((LispClass)arg).getCPL();
/*      */       }
/* 5511 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symPrecedenceList);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5516 */   private static final Primitive _SET_CLASS_PRECEDENCE_LIST = new pf__set_class_precedence_list();
/*      */   
/*      */   private static final class pf__set_class_precedence_list extends Primitive { pf__set_class_precedence_list() {
/* 5519 */       super("%set-class-precedence-list", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5525 */       if (second instanceof LispClass) {
/* 5526 */         ((LispClass)second).setCPL(new LispObject[] { first });
/*      */       } else {
/* 5528 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symPrecedenceList, first);
/* 5529 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5534 */   private static final Primitive _CLASS_DIRECT_METHODS = new pf__class_direct_methods();
/*      */   
/*      */   private static final class pf__class_direct_methods extends Primitive { pf__class_direct_methods() {
/* 5537 */       super("%class-direct-methods", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5543 */       if (arg instanceof LispClass) {
/* 5544 */         return ((LispClass)arg).getDirectMethods();
/*      */       }
/* 5546 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symDirectMethods);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5551 */   private static final Primitive _SET_CLASS_DIRECT_METHODS = new pf__set_class_direct_methods();
/*      */   
/*      */   private static final class pf__set_class_direct_methods extends Primitive { pf__set_class_direct_methods() {
/* 5554 */       super("%set-class-direct-methods", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5560 */       if (second instanceof LispClass) {
/* 5561 */         ((LispClass)second).setDirectMethods(first);
/*      */       } else {
/* 5563 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symDirectMethods, first);
/* 5564 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5569 */   private static final Primitive CLASS_DOCUMENTATION = new pf_class_documentation();
/*      */   
/*      */   private static final class pf_class_documentation extends Primitive {
/*      */     pf_class_documentation() {
/* 5573 */       super("class-documentation", Lisp.PACKAGE_MOP, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5580 */       if (arg instanceof LispClass) {
/* 5581 */         return ((LispClass)arg).getDocumentation();
/*      */       }
/* 5583 */       return ((StandardObject)arg).getInstanceSlotValue(Symbol._DOCUMENTATION);
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 5588 */   private static final Primitive _SET_CLASS_DOCUMENTATION = new pf__set_class_documentation();
/*      */   
/*      */   private static final class pf__set_class_documentation extends Primitive {
/*      */     pf__set_class_documentation() {
/* 5592 */       super("%set-class-documentation", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5598 */       if (first instanceof LispClass) {
/* 5599 */         ((LispClass)first).setDocumentation(second);
/*      */       } else {
/* 5601 */         ((StandardObject)first).setInstanceSlotValue(Symbol._DOCUMENTATION, second);
/* 5602 */       }  return second;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 5607 */   private static final Primitive _CLASS_FINALIZED_P = new pf__class_finalized_p();
/*      */   
/*      */   private static final class pf__class_finalized_p extends Primitive { pf__class_finalized_p() {
/* 5610 */       super("%class-finalized-p", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5615 */       if (arg instanceof LispClass) {
/* 5616 */         return ((LispClass)arg).isFinalized() ? Lisp.T : Lisp.NIL;
/*      */       }
/* 5618 */       return ((StandardObject)arg).getInstanceSlotValue(StandardClass.symFinalizedP);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5623 */   private static final Primitive _SET_CLASS_FINALIZED_P = new pf__set_class_finalized_p();
/*      */   
/*      */   private static final class pf__set_class_finalized_p extends Primitive { pf__set_class_finalized_p() {
/* 5626 */       super("%set-class-finalized-p", Lisp.PACKAGE_SYS, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject first, LispObject second) {
/* 5632 */       if (second instanceof LispClass) {
/* 5633 */         ((LispClass)second).setFinalized((first != Lisp.NIL));
/*      */       } else {
/* 5635 */         ((StandardObject)second).setInstanceSlotValue(StandardClass.symFinalizedP, first);
/* 5636 */       }  return first;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5641 */   private static final Primitive CLASSP = new pf_classp();
/*      */   
/*      */   private static final class pf_classp extends Primitive { pf_classp() {
/* 5644 */       super("classp", Lisp.PACKAGE_EXT, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5649 */       return (arg instanceof LispClass) ? Lisp.T : arg.typep(Symbol.CLASS);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5654 */   private static final Primitive CHAR_TO_UTF8 = new pf_char_to_utf8();
/*      */   
/*      */   private static final class pf_char_to_utf8 extends Primitive { pf_char_to_utf8() {
/* 5657 */       super("char-to-utf8", Lisp.PACKAGE_EXT, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*      */       byte[] bytes;
/* 5663 */       LispCharacter c = Lisp.checkCharacter(arg);
/* 5664 */       char[] chars = new char[1];
/* 5665 */       chars[0] = c.value;
/* 5666 */       String s = new String(chars);
/*      */       
/*      */       try {
/* 5669 */         bytes = s.getBytes("UTF8");
/* 5670 */       } catch (UnsupportedEncodingException e) {
/* 5671 */         return Lisp.error(new LispError("UTF8 is not a supported encoding."));
/*      */       } 
/* 5673 */       LispObject[] objects = new LispObject[bytes.length];
/* 5674 */       for (int i = bytes.length; i-- > 0; ) {
/* 5675 */         int n = bytes[i];
/* 5676 */         if (n < 0)
/* 5677 */           n += 256; 
/* 5678 */         objects[i] = Fixnum.getInstance(n);
/*      */       } 
/* 5680 */       return new SimpleVector(objects);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5685 */   private static final Primitive _DOCUMENTATION = new pf__documentation();
/*      */   
/*      */   private static final class pf__documentation extends Primitive { pf__documentation() {
/* 5688 */       super("%documentation", Lisp.PACKAGE_SYS, true, "object doc-type");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject object, LispObject docType) {
/* 5696 */       LispObject doc = object.getDocumentation(docType);
/* 5697 */       if (doc == Lisp.NIL && 
/* 5698 */         docType == Symbol.FUNCTION && object instanceof Symbol) {
/*      */         
/* 5700 */         LispObject function = object.getSymbolFunction();
/* 5701 */         if (function != null) {
/* 5702 */           doc = function.getDocumentation(docType);
/*      */         }
/*      */       } 
/* 5705 */       return doc;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5710 */   private static final Primitive _SET_DOCUMENTATION = new pf__set_documentation();
/*      */   
/*      */   private static final class pf__set_documentation extends Primitive { pf__set_documentation() {
/* 5713 */       super("%set-documentation", Lisp.PACKAGE_SYS, true, "object doc-type documentation");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject object, LispObject docType, LispObject documentation) {
/* 5723 */       object.setDocumentation(docType, documentation);
/* 5724 */       return documentation;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5729 */   private static final Primitive _PUTF = new pf__putf();
/*      */   
/*      */   private static final class pf__putf extends Primitive { pf__putf() {
/* 5732 */       super("%putf", Lisp.PACKAGE_SYS, true, "plist indicator new-value");
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject plist, LispObject indicator, LispObject newValue) {
/* 5741 */       return Lisp.putf(plist, indicator, newValue);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5746 */   private static final Primitive FUNCTION_PLIST = new pf_function_plist();
/*      */   
/*      */   private static final class pf_function_plist extends Primitive { pf_function_plist() {
/* 5749 */       super("function-plist", Lisp.PACKAGE_SYS, true, "function");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5754 */       return Lisp.checkFunction(arg).getPropertyList();
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5759 */   private static final Primitive MAKE_KEYWORD = new pf_make_keyword();
/*      */   
/*      */   private static final class pf_make_keyword extends Primitive { pf_make_keyword() {
/* 5762 */       super("make-keyword", Lisp.PACKAGE_SYS, true, "symbol");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5767 */       return Lisp.PACKAGE_KEYWORD.intern((Lisp.checkSymbol(arg)).name);
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5772 */   private static final Primitive STANDARD_OBJECT_P = new pf_standard_object_p();
/*      */   
/*      */   private static final class pf_standard_object_p extends Primitive { pf_standard_object_p() {
/* 5775 */       super("standard-object-p", Lisp.PACKAGE_SYS, true, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5780 */       return (arg instanceof StandardObject) ? Lisp.T : Lisp.NIL;
/*      */     } }
/*      */ 
/*      */ 
/*      */   
/* 5785 */   private static final Primitive COPY_TREE = new pf_copy_tree();
/*      */   
/*      */   private static final class pf_copy_tree extends Primitive { pf_copy_tree() {
/* 5788 */       super(Symbol.COPY_TREE, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5793 */       if (arg instanceof Cons) {
/* 5794 */         Cons cons = (Cons)arg;
/* 5795 */         return new Cons(execute(cons.car), execute(cons.cdr));
/*      */       } 
/* 5797 */       return arg;
/*      */     } }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/* 5807 */   private static final Primitive FLOAT_UNDERFLOW_MODE = new pf_float_underflow_mode();
/*      */   
/*      */   private static final class pf_float_underflow_mode extends Primitive {
/*      */     pf_float_underflow_mode() {
/* 5811 */       super(Symbol.FLOAT_UNDERFLOW_MODE, "&optional boolean");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 5816 */       return Lisp.TRAP_UNDERFLOW ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5821 */       Lisp.TRAP_UNDERFLOW = (arg != Lisp.NIL);
/* 5822 */       return arg;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/* 5828 */   private static final Primitive FLOAT_OVERFLOW_MODE = new pf_float_overflow_mode();
/*      */   
/*      */   private static final class pf_float_overflow_mode extends Primitive {
/*      */     pf_float_overflow_mode() {
/* 5832 */       super(Symbol.FLOAT_OVERFLOW_MODE, "&optional boolean");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 5837 */       return Lisp.TRAP_OVERFLOW ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 5842 */       Lisp.TRAP_OVERFLOW = (arg != Lisp.NIL);
/* 5843 */       return arg;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 5848 */   private static final Primitive FINALIZE = new pf_finalize();
/*      */   
/*      */   private static final class pf_finalize extends Primitive {
/*      */     pf_finalize() {
/* 5852 */       super("finalize", Lisp.PACKAGE_EXT, true, "object function");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject obj, final LispObject fun) {
/* 5857 */       Finalizer.addFinalizer(obj, new Runnable()
/*      */           {
/*      */             public void run() {
/* 5860 */               fun.execute();
/*      */             }
/*      */           });
/* 5863 */       return obj;
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 5868 */   private static final Primitive CANCEL_FINALIZATION = new pf_cancel_finalization();
/*      */   
/*      */   private static final class pf_cancel_finalization extends Primitive {
/*      */     pf_cancel_finalization() {
/* 5872 */       super("cancel-finalization", Lisp.PACKAGE_EXT, true, "object");
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject obj) {
/* 5877 */       Finalizer.clearFinalizers(obj);
/* 5878 */       return obj;
/*      */     }
/*      */   }
/*      */   
/* 5882 */   private static final Primitive GET_FASL_READTABLE = new pf_get_fasl_readtable();
/*      */   
/*      */   private static class pf_get_fasl_readtable extends Primitive {
/*      */     pf_get_fasl_readtable() {
/* 5886 */       super("get-fasl-readtable", Lisp.PACKAGE_SYS, false);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute() {
/* 5891 */       return FaslReadtable.getInstance();
/*      */     }
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Primitives.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */