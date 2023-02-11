/*      */ package org.armedbear.lisp;
/*      */ 
/*      */ import java.lang.reflect.Array;
/*      */ import java.lang.reflect.Constructor;
/*      */ import java.lang.reflect.Field;
/*      */ import java.lang.reflect.Method;
/*      */ import java.lang.reflect.Modifier;
/*      */ import java.math.BigInteger;
/*      */ import java.text.MessageFormat;
/*      */ import java.util.ArrayList;
/*      */ import java.util.HashMap;
/*      */ import java.util.List;
/*      */ import java.util.Map;
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
/*      */ public final class Java
/*      */ {
/*   50 */   static final Map<Class, Symbol> registeredExceptions = (Map)new HashMap<>();
/*      */ 
/*      */   
/*   53 */   private static final LispClass java_exception = LispClass.findClass(Symbol.JAVA_EXCEPTION);
/*      */ 
/*      */   
/*      */   static boolean isJavaException(LispClass lc) {
/*   57 */     return lc.subclassp(java_exception);
/*      */   }
/*      */   
/*   60 */   private static final Primitive ENSURE_JAVA_OBJECT = new pf_ensure_java_object();
/*      */   
/*      */   @DocString(name = "ensure-java-object", args = "obj", doc = "Ensures OBJ is wrapped in a JAVA-OBJECT, wrapping it if necessary.")
/*      */   private static final class pf_ensure_java_object
/*      */     extends Primitive
/*      */   {
/*      */     pf_ensure_java_object() {
/*   67 */       super("ensure-java-object", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject obj) {
/*   72 */       return (obj instanceof JavaObject) ? obj : new JavaObject(obj);
/*      */     }
/*      */   }
/*      */   
/*   76 */   private static final Primitive REGISTER_JAVA_EXCEPTION = new pf_register_java_exception();
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "register-java-exception", args = "exception-name condition-symbol", doc = "Registers the Java Throwable named by the symbol EXCEPTION-NAME as the condition designated by CONDITION-SYMBOL.  Returns T if successful, NIL if not.")
/*      */   private static final class pf_register_java_exception
/*      */     extends Primitive
/*      */   {
/*      */     pf_register_java_exception() {
/*   85 */       super("register-java-exception", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject className, LispObject symbol) {
/*   92 */       LispClass lispClass = (LispClass)LispClass.findClass(symbol, true);
/*      */       
/*   94 */       if (Java.isJavaException(lispClass)) {
/*   95 */         Java.registeredExceptions.put(Java.classForName(className.getStringValue()), (Symbol)symbol);
/*      */         
/*   97 */         return Lisp.T;
/*      */       } 
/*   99 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/*  103 */   private static final Primitive UNREGISTER_JAVA_EXCEPTION = new pf_unregister_java_exception();
/*      */ 
/*      */   
/*      */   @DocString(name = "unregister-java-exception", args = "exception-name", doc = "Unregisters the Java Throwable EXCEPTION-NAME previously registered by REGISTER-JAVA-EXCEPTION.")
/*      */   private static final class pf_unregister_java_exception
/*      */     extends Primitive
/*      */   {
/*      */     pf_unregister_java_exception() {
/*  111 */       super("unregister-java-exception", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject className) {
/*  119 */       return (Java.registeredExceptions.remove(Java.classForName(className.getStringValue())) == null) ? Lisp.NIL : Lisp.T;
/*      */     }
/*      */   }
/*      */   
/*      */   static Symbol getCondition(Class cl) {
/*  124 */     Class o = classForName("java.lang.Object");
/*  125 */     for (Class c = cl; c != o; c = c.getSuperclass()) {
/*  126 */       Object object = registeredExceptions.get(c);
/*  127 */       if (object instanceof Symbol) {
/*  128 */         LispClass lispClass = (LispClass)LispClass.findClass((Symbol)object, true);
/*  129 */         if (isJavaException(lispClass)) {
/*  130 */           return (Symbol)object;
/*      */         }
/*      */       } 
/*      */     } 
/*  134 */     return null;
/*      */   }
/*      */   
/*  137 */   private static final Primitive JCLASS = new pf_jclass();
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "jclass", args = "name-or-class-ref &optional class-loader", doc = "Returns a reference to the Java class designated by NAME-OR-CLASS-REF. If the CLASS-LOADER parameter is passed, the class is resolved with respect to the given ClassLoader.")
/*      */   private static final class pf_jclass
/*      */     extends Primitive
/*      */   {
/*      */     pf_jclass() {
/*  147 */       super(Symbol.JCLASS);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/*  153 */       return JavaObject.getInstance(Java.javaClass(arg, JavaClassLoader.getCurrentClassLoader()));
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject className, LispObject classLoader) {
/*  159 */       ClassLoader loader = (ClassLoader)classLoader.javaInstance(ClassLoader.class);
/*  160 */       return JavaObject.getInstance(Java.javaClass(className, loader));
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject jfield(Primitive fun, LispObject[] args, boolean translate) {
/*  167 */     if (args.length < 2 || args.length > 4)
/*  168 */       Lisp.error(new WrongNumberOfArgumentsException(fun, 2, 4)); 
/*  169 */     String fieldName = null;
/*      */ 
/*      */ 
/*      */     
/*  173 */     Object instance = null; try {
/*      */       Class<?> c;
/*  175 */       if (args[1] instanceof AbstractString) {
/*      */         
/*  177 */         fieldName = args[1].getStringValue();
/*  178 */         c = javaClass(args[0]);
/*      */       } else {
/*      */         
/*  181 */         fieldName = args[0].getStringValue();
/*  182 */         instance = JavaObject.getObject(args[1]);
/*  183 */         c = instance.getClass();
/*      */       } 
/*  185 */       Field f = c.getField(fieldName);
/*  186 */       Class<?> fieldType = f.getType();
/*  187 */       switch (args.length) {
/*      */ 
/*      */ 
/*      */ 
/*      */         
/*      */         case 3:
/*  193 */           if (instance == null) {
/*      */             
/*  195 */             if (args[2] instanceof JavaObject) {
/*      */               
/*  197 */               instance = JavaObject.getObject(args[2]);
/*      */               
/*      */               break;
/*      */             } 
/*  201 */             f.set(null, args[2].javaInstance(fieldType));
/*  202 */             return args[2];
/*      */           } 
/*      */ 
/*      */           
/*  206 */           f.set(instance, args[2].javaInstance(fieldType));
/*  207 */           return args[2];
/*      */ 
/*      */         
/*      */         case 4:
/*  211 */           if (args[2] != Lisp.NIL)
/*      */           {
/*  213 */             instance = JavaObject.getObject(args[2]);
/*      */           }
/*  215 */           f.set(instance, args[3].javaInstance(fieldType));
/*  216 */           return args[3];
/*      */       } 
/*  218 */       return JavaObject.getInstance(f.get(instance), translate, f.getType());
/*      */     }
/*  220 */     catch (NoSuchFieldException e) {
/*  221 */       Lisp.error(new LispError("no such field"));
/*      */     }
/*  223 */     catch (SecurityException e) {
/*  224 */       Lisp.error(new LispError("inaccessible field"));
/*      */     }
/*  226 */     catch (IllegalAccessException e) {
/*  227 */       Lisp.error(new LispError("illegal access"));
/*      */     }
/*  229 */     catch (IllegalArgumentException e) {
/*  230 */       Lisp.error(new LispError("illegal argument"));
/*      */     } 
/*      */     
/*  233 */     return Lisp.NIL;
/*      */   }
/*      */ 
/*      */   
/*  237 */   private static final Primitive JFIELD = new pf_jfield();
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
/*      */   @DocString(name = "jfield", args = "class-ref-or-field field-or-instance &optional instance value", doc = "Retrieves or modifies a field in a Java class or instance.\n\nSupported argument patterns:\n\n   Case 1: class-ref  field-name:\n      Retrieves the value of a static field.\n\n   Case 2: class-ref  field-name  instance-ref:\n      Retrieves the value of a class field of the instance.\n\n   Case 3: class-ref  field-name  primitive-value:\n      Stores a primitive-value in a static field.\n\n   Case 4: class-ref  field-name  instance-ref  value:\n      Stores value in a class field of the instance.\n\n   Case 5: class-ref  field-name  nil  value:\n      Stores value in a static field (when value may be\n      confused with an instance-ref).\n\n   Case 6: field-name  instance:\n      Retrieves the value of a field of the instance. The\n      class is derived from the instance.\n\n   Case 7: field-name  instance  value:\n      Stores value in a field of the instance. The class is\n      derived from the instance.\n\n")
/*      */   private static final class pf_jfield
/*      */     extends Primitive
/*      */   {
/*      */     pf_jfield() {
/*  264 */       super("jfield", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  270 */       return Java.jfield(this, args, true);
/*      */     }
/*      */   }
/*      */   
/*  274 */   private static final Primitive JFIELD_RAW = new pf_jfield_raw();
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
/*      */   @DocString(name = "jfield", args = "class-ref-or-field field-or-instance &optional instance value", doc = "Retrieves or modifies a field in a Java class or instance. Does not\nattempt to coerce its value or the result into a Lisp object.\n\nSupported argument patterns:\n\n   Case 1: class-ref  field-name:\n      Retrieves the value of a static field.\n\n   Case 2: class-ref  field-name  instance-ref:\n      Retrieves the value of a class field of the instance.\n\n   Case 3: class-ref  field-name  primitive-value:\n      Stores a primitive-value in a static field.\n\n   Case 4: class-ref  field-name  instance-ref  value:\n      Stores value in a class field of the instance.\n\n   Case 5: class-ref  field-name  nil  value:\n      Stores value in a static field (when value may be\n      confused with an instance-ref).\n\n   Case 6: field-name  instance:\n      Retrieves the value of a field of the instance. The\n      class is derived from the instance.\n\n   Case 7: field-name  instance  value:\n      Stores value in a field of the instance. The class is\n      derived from the instance.\n\n")
/*      */   private static final class pf_jfield_raw
/*      */     extends Primitive
/*      */   {
/*      */     pf_jfield_raw() {
/*  302 */       super("jfield-raw", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  308 */       return Java.jfield(this, args, false);
/*      */     }
/*      */   }
/*      */   
/*  312 */   private static final Primitive JCONSTRUCTOR = new pf_jconstructor();
/*      */ 
/*      */   
/*      */   @DocString(name = "jconstructor", args = "class-ref &rest parameter-class-refs", doc = "Returns a reference to the Java constructor of CLASS-REF with the given PARAMETER-CLASS-REFS.")
/*      */   private static final class pf_jconstructor
/*      */     extends Primitive
/*      */   {
/*      */     pf_jconstructor() {
/*  320 */       super("jconstructor", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  326 */       if (args.length < 1)
/*  327 */         Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/*      */       try {
/*  329 */         Class<?> c = Java.javaClass(args[0]);
/*  330 */         int argCount = 0;
/*  331 */         if (args.length == 2 && args[1] instanceof Fixnum) {
/*  332 */           argCount = Fixnum.getValue(args[1]);
/*      */         } else {
/*  334 */           Class<?>[] parameterTypes = new Class[args.length - 1];
/*  335 */           for (int j = 1; j < args.length; j++) {
/*  336 */             parameterTypes[j - 1] = Java.javaClass(args[j]);
/*      */           }
/*  338 */           return JavaObject.getInstance(c.getConstructor(parameterTypes));
/*      */         } 
/*      */         
/*  341 */         Constructor[] constructors = (Constructor[])c.getConstructors();
/*  342 */         for (int i = 0; i < constructors.length; i++) {
/*  343 */           Constructor constructor = constructors[i];
/*  344 */           if ((constructor.getParameterTypes()).length == argCount)
/*  345 */             return JavaObject.getInstance(constructor); 
/*      */         } 
/*  347 */         throw new NoSuchMethodException();
/*      */       }
/*  349 */       catch (NoSuchMethodException e) {
/*  350 */         Lisp.error(new LispError("no such constructor"));
/*      */       }
/*  352 */       catch (ControlTransfer e) {
/*  353 */         throw e;
/*      */       }
/*  355 */       catch (Throwable t) {
/*  356 */         Lisp.error(new LispError(Java.getMessage(t)));
/*      */       } 
/*      */       
/*  359 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/*  363 */   private static final Primitive JMETHOD = new pf_jmethod();
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "jmethod", args = "class-ref method-name &rest parameter-class-refs", doc = "Returns a reference to the Java method METHOD-NAME of CLASS-REF with the given PARAMETER-CLASS-REFS.")
/*      */   private static final class pf_jmethod
/*      */     extends Primitive
/*      */   {
/*      */     pf_jmethod() {
/*  372 */       super("jmethod", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  378 */       if (args.length < 2)
/*  379 */         Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/*  380 */       Class<?> c = Java.javaClass(args[0]);
/*  381 */       String methodName = args[1].getStringValue();
/*      */       try {
/*  383 */         int argCount = 0;
/*  384 */         if (args.length == 3 && args[2] instanceof Fixnum) {
/*  385 */           argCount = ((Fixnum)args[2]).value;
/*      */         } else {
/*  387 */           Class<?>[] parameterTypes = new Class[args.length - 2];
/*  388 */           for (int j = 2; j < args.length; j++)
/*  389 */             parameterTypes[j - 2] = Java.javaClass(args[j]); 
/*  390 */           return JavaObject.getInstance(c.getMethod(methodName, parameterTypes));
/*      */         } 
/*      */ 
/*      */         
/*  394 */         Method[] methods = c.getMethods();
/*  395 */         for (int i = 0; i < methods.length; i++) {
/*  396 */           Method method = methods[i];
/*  397 */           if (method.getName().equals(methodName) && (method
/*  398 */             .getParameterTypes()).length == argCount)
/*  399 */             return JavaObject.getInstance(method); 
/*      */         } 
/*  401 */         throw new NoSuchMethodException();
/*      */       }
/*  403 */       catch (NoSuchMethodException e) {
/*  404 */         StringBuilder sb = new StringBuilder("No such method: ");
/*  405 */         sb.append(c.getName());
/*  406 */         sb.append('.');
/*  407 */         sb.append(methodName);
/*  408 */         sb.append('(');
/*  409 */         for (int i = 2; i < args.length; i++) {
/*  410 */           sb.append(args[i].princToString());
/*  411 */           if (i < args.length - 1)
/*  412 */             sb.append(','); 
/*      */         } 
/*  414 */         sb.append(')');
/*  415 */         Lisp.error(new LispError(sb.toString()));
/*      */       }
/*  417 */       catch (ControlTransfer e) {
/*  418 */         throw e;
/*      */       }
/*  420 */       catch (Throwable t) {
/*  421 */         Lisp.error(new LispError(Java.getMessage(t)));
/*      */       } 
/*      */       
/*  424 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */   
/*      */   static final LispObject jstatic(Primitive fun, LispObject[] args, boolean translate) {
/*  431 */     if (args.length < 2) {
/*  432 */       Lisp.error(new WrongNumberOfArgumentsException(fun, 2, -1));
/*      */     }
/*      */     try {
/*  435 */       Method m = null;
/*  436 */       Class c = null;
/*  437 */       LispObject methodRef = args[0];
/*  438 */       List<Method> staticMethods = new ArrayList<>();
/*  439 */       String methodName = null;
/*      */       
/*  441 */       if (methodRef instanceof JavaObject) {
/*  442 */         Object obj = ((JavaObject)methodRef).getObject();
/*  443 */         if (obj instanceof Method) {
/*  444 */           staticMethods.add((Method)obj);
/*  445 */           methodName = ((Method)obj).getName();
/*      */         } else {
/*  447 */           Lisp.error(new LispError(methodRef + "is not a valid reference to a Method"));
/*      */         } 
/*  449 */       } else if (methodRef instanceof AbstractString) {
/*  450 */         c = javaClass(args[1]);
/*  451 */         if (c != null) {
/*  452 */           methodName = methodRef.getStringValue();
/*  453 */           Method[] methods = c.getMethods();
/*  454 */           int argCount = args.length - 2;
/*  455 */           for (Method m1 : methods) {
/*  456 */             if (Modifier.isStatic(m1.getModifiers())) {
/*  457 */               staticMethods.add(m1);
/*      */             }
/*      */           } 
/*      */         } 
/*      */       } else {
/*  462 */         Lisp.type_error(methodRef, Symbol.STRING);
/*      */       } 
/*      */       
/*  465 */       if (staticMethods.size() > 0) {
/*  466 */         m = findMethod(staticMethods.<Method>toArray(new Method[staticMethods.size()]), methodName, args, 2);
/*      */       }
/*      */       
/*  469 */       if (m == null) {
/*  470 */         StringBuilder sb = new StringBuilder("No such static method: ");
/*  471 */         String className = "<unknown>";
/*  472 */         if (c != null) {
/*  473 */           className = c.getName();
/*      */         }
/*  475 */         sb.append(className);
/*  476 */         sb.append('.');
/*  477 */         sb.append(methodName);
/*  478 */         sb.append('(');
/*  479 */         for (int j = 2; j < args.length; j++) {
/*  480 */           LispObject argClass = Symbol.JCLASS_OF.execute(args[j]);
/*  481 */           sb.append(argClass.princToString());
/*  482 */           if (j < args.length - 1)
/*  483 */             sb.append(','); 
/*      */         } 
/*  485 */         sb.append(')');
/*  486 */         Lisp.error(new LispError(sb.toString()));
/*      */       } 
/*      */       
/*  489 */       Object[] methodArgs = new Object[args.length - 2];
/*  490 */       Class[] argTypes = m.getParameterTypes();
/*  491 */       for (int i = 2; i < args.length; i++) {
/*  492 */         LispObject arg = args[i];
/*  493 */         if (arg.equals(Lisp.NIL)) {
/*  494 */           methodArgs[i - 2] = Boolean.valueOf(false);
/*  495 */         } else if (arg.equals(Lisp.T)) {
/*  496 */           methodArgs[i - 2] = Boolean.valueOf(true);
/*      */         } else {
/*  498 */           methodArgs[i - 2] = arg.javaInstance(argTypes[i - 2]);
/*      */         } 
/*      */       } 
/*  501 */       m.setAccessible(true);
/*  502 */       Object result = null;
/*  503 */       if (!m.isVarArgs()) {
/*  504 */         result = m.invoke((Object)null, methodArgs);
/*  505 */       } else if (argTypes.length == 1) {
/*  506 */         result = m.invoke((Object)null, new Object[] { methodArgs });
/*      */       } else {
/*  508 */         Object[] objectArgs = new Object[methodArgs.length];
/*  509 */         for (int j = 0; j < methodArgs.length; j++) {
/*  510 */           objectArgs[j] = methodArgs[j];
/*      */         }
/*  512 */         result = m.invoke((Object)null, objectArgs);
/*      */       } 
/*  514 */       return JavaObject.getInstance(result, translate, m.getReturnType());
/*      */     }
/*  516 */     catch (ControlTransfer c) {
/*  517 */       throw c;
/*      */     }
/*  519 */     catch (Throwable t) {
/*  520 */       if (t instanceof java.lang.reflect.InvocationTargetException)
/*  521 */         t = t.getCause(); 
/*  522 */       Symbol condition = getCondition(t.getClass());
/*  523 */       if (condition == null) {
/*  524 */         Lisp.error(new JavaException(t));
/*      */       } else {
/*  526 */         Symbol.SIGNAL.execute(condition, Keyword.CAUSE, 
/*      */ 
/*      */             
/*  529 */             JavaObject.getInstance(t), Keyword.FORMAT_CONTROL, new SimpleString(
/*      */               
/*  531 */               getMessage(t)));
/*      */       } 
/*      */       
/*  534 */       return Lisp.NIL;
/*      */     } 
/*      */   }
/*  537 */   private static final Primitive JSTATIC = new pf_jstatic();
/*      */   
/*      */   @DocString(name = "jstatic", args = "method class &rest args", doc = "Invokes the static method METHOD on class CLASS with ARGS.")
/*      */   private static final class pf_jstatic
/*      */     extends Primitive
/*      */   {
/*      */     pf_jstatic() {
/*  544 */       super("jstatic", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  550 */       return Java.jstatic(this, args, true);
/*      */     }
/*      */   }
/*      */   
/*  554 */   private static final Primitive JSTATIC_RAW = new pf_jstatic_raw();
/*      */ 
/*      */   
/*      */   @DocString(name = "jstatic-raw", args = "method class &rest args", doc = "Invokes the static method METHOD on class CLASS with ARGS. Does not attempt to coerce the arguments or result into a Lisp object.")
/*      */   private static final class pf_jstatic_raw
/*      */     extends Primitive
/*      */   {
/*      */     pf_jstatic_raw() {
/*  562 */       super("jstatic-raw", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  568 */       return Java.jstatic(this, args, false);
/*      */     }
/*      */   }
/*      */   
/*  572 */   private static final Primitive JNEW = new pf_jnew();
/*      */   
/*      */   @DocString(name = "jnew", args = "constructor &rest args", doc = "Invokes the Java constructor CONSTRUCTOR with the arguments ARGS.")
/*      */   private static final class pf_jnew
/*      */     extends Primitive
/*      */   {
/*      */     pf_jnew() {
/*  579 */       super("jnew", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  585 */       if (args.length < 1)
/*  586 */         Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/*  587 */       LispObject classRef = args[0];
/*      */       try {
/*      */         Constructor constructor;
/*  590 */         if (classRef instanceof AbstractString) {
/*  591 */           constructor = Java.findConstructor(Java.javaClass(classRef), args);
/*      */         } else {
/*  593 */           Object object = JavaObject.getObject(classRef);
/*  594 */           if (object instanceof Constructor) {
/*  595 */             constructor = (Constructor)object;
/*  596 */           } else if (object instanceof Class) {
/*  597 */             constructor = Java.findConstructor((Class)object, args);
/*      */           } else {
/*  599 */             return Lisp.error(new LispError(classRef.princToString() + " is neither a Constructor nor a Class"));
/*      */           } 
/*      */         } 
/*  602 */         Class[] argTypes = constructor.getParameterTypes();
/*  603 */         Object[] initargs = new Object[args.length - 1];
/*  604 */         for (int i = 1; i < args.length; i++) {
/*  605 */           LispObject arg = args[i];
/*  606 */           if (arg.equals(Lisp.NIL)) {
/*  607 */             initargs[i - 1] = Boolean.valueOf(false);
/*  608 */           } else if (arg.equals(Lisp.T)) {
/*  609 */             initargs[i - 1] = Boolean.valueOf(true);
/*      */           } else {
/*  611 */             initargs[i - 1] = arg.javaInstance(argTypes[i - 1]);
/*      */           } 
/*      */         } 
/*  614 */         return JavaObject.getInstance(constructor.newInstance(initargs));
/*      */       }
/*  616 */       catch (ControlTransfer c) {
/*  617 */         Constructor constructor; throw constructor;
/*      */       }
/*  619 */       catch (Throwable t) {
/*  620 */         if (t instanceof java.lang.reflect.InvocationTargetException)
/*  621 */           t = t.getCause(); 
/*  622 */         Symbol condition = Java.getCondition(t.getClass());
/*  623 */         if (condition == null) {
/*  624 */           Lisp.error(new JavaException(t));
/*      */         } else {
/*  626 */           Symbol.SIGNAL.execute(condition, Keyword.CAUSE, 
/*      */ 
/*      */               
/*  629 */               JavaObject.getInstance(t), Keyword.FORMAT_CONTROL, new SimpleString(
/*      */                 
/*  631 */                 Java.getMessage(t)));
/*      */         } 
/*      */         
/*  634 */         return Lisp.NIL;
/*      */       } 
/*      */     } }
/*      */   
/*  638 */   private static final Primitive JNEW_ARRAY = new pf_jnew_array();
/*      */ 
/*      */   
/*      */   @DocString(name = "jnew-array", args = "element-type &rest dimensions", doc = "Creates a new Java array of type ELEMENT-TYPE, with the given DIMENSIONS.")
/*      */   private static final class pf_jnew_array
/*      */     extends Primitive
/*      */   {
/*      */     pf_jnew_array() {
/*  646 */       super("jnew-array", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  652 */       if (args.length < 2)
/*  653 */         Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1)); 
/*      */       try {
/*  655 */         Class<?> c = Java.javaClass(args[0]);
/*  656 */         int[] dimensions = new int[args.length - 1];
/*  657 */         for (int i = 1; i < args.length; i++)
/*  658 */           dimensions[i - 1] = ((Integer)args[i].javaInstance()).intValue(); 
/*  659 */         return JavaObject.getInstance(Array.newInstance(c, dimensions));
/*      */       }
/*  661 */       catch (Throwable t) {
/*  662 */         Lisp.error(new JavaException(t));
/*      */ 
/*      */         
/*  665 */         return Lisp.NIL;
/*      */       } 
/*      */     }
/*      */   }
/*      */ 
/*      */   
/*      */   static final LispObject jarray_ref(Primitive fun, LispObject[] args, boolean translate) {
/*  672 */     if (args.length < 2)
/*  673 */       Lisp.error(new WrongNumberOfArgumentsException(fun, 2, -1)); 
/*      */     try {
/*  675 */       Object a = args[0].javaInstance();
/*  676 */       for (int i = 1; i < args.length - 1; i++)
/*  677 */         a = Array.get(a, ((Integer)args[i].javaInstance()).intValue()); 
/*  678 */       return JavaObject.getInstance(Array.get(a, ((Integer)args[args.length - 1]
/*  679 */             .javaInstance()).intValue()), translate);
/*      */     }
/*  681 */     catch (Throwable t) {
/*  682 */       Symbol condition = getCondition(t.getClass());
/*  683 */       if (condition == null) {
/*  684 */         Lisp.error(new JavaException(t));
/*      */       } else {
/*  686 */         Symbol.SIGNAL.execute(condition, Keyword.CAUSE, 
/*      */ 
/*      */             
/*  689 */             JavaObject.getInstance(t), Keyword.FORMAT_CONTROL, new SimpleString(
/*      */               
/*  691 */               getMessage(t)));
/*      */       } 
/*      */       
/*  694 */       return Lisp.NIL;
/*      */     } 
/*      */   }
/*  697 */   private static final Primitive JARRAY_REF = new pf_jarray_ref();
/*      */ 
/*      */   
/*      */   @DocString(name = "jarray-ref", args = "java-array &rest indices", doc = "Dereferences the Java array JAVA-ARRAY using the given INDICES, coercing the result into a Lisp object, if possible.")
/*      */   private static final class pf_jarray_ref
/*      */     extends Primitive
/*      */   {
/*      */     pf_jarray_ref() {
/*  705 */       super("jarray-ref", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  711 */       return Java.jarray_ref(this, args, true);
/*      */     }
/*      */   }
/*      */   
/*  715 */   private static final Primitive JARRAY_REF_RAW = new pf_jarray_ref_raw();
/*      */ 
/*      */   
/*      */   @DocString(name = "jarray-ref-raw", args = "java-array &rest indices", doc = "Dereference the Java array JAVA-ARRAY using the given INDICES. Does not attempt to coerce the result into a Lisp object.")
/*      */   private static final class pf_jarray_ref_raw
/*      */     extends Primitive
/*      */   {
/*      */     pf_jarray_ref_raw() {
/*  723 */       super("jarray-ref-raw", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  729 */       return Java.jarray_ref(this, args, false);
/*      */     }
/*      */   }
/*      */   
/*  733 */   private static final Primitive JARRAY_SET = new pf_jarray_set();
/*      */   
/*      */   @DocString(name = "jarray-set", args = "java-array new-value &rest indices", doc = "Stores NEW-VALUE at the given INDICES in JAVA-ARRAY.")
/*      */   private static final class pf_jarray_set
/*      */     extends Primitive
/*      */   {
/*      */     pf_jarray_set() {
/*  740 */       super("jarray-set", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  746 */       if (args.length < 3)
/*  747 */         Lisp.error(new WrongNumberOfArgumentsException(this, 3, -1)); 
/*      */       try {
/*  749 */         Object a = args[0].javaInstance();
/*  750 */         LispObject v = args[1];
/*  751 */         for (int i = 2; i < args.length - 1; i++)
/*  752 */           a = Array.get(a, ((Integer)args[i].javaInstance()).intValue()); 
/*  753 */         Object value = v.javaInstance();
/*  754 */         int index = ((Integer)args[args.length - 1].javaInstance()).intValue();
/*  755 */         if (value instanceof Number) {
/*  756 */           Class<?> type = a.getClass().getComponentType();
/*  757 */           Number number = (Number)value;
/*  758 */           if (type.equals(byte.class)) {
/*  759 */             Array.setByte(a, index, number.byteValue());
/*  760 */           } else if (type.equals(short.class)) {
/*  761 */             Array.setShort(a, index, number.shortValue());
/*  762 */           } else if (type.equals(char.class)) {
/*  763 */             Array.setChar(a, index, (char)number.intValue());
/*  764 */           } else if (type.equals(int.class)) {
/*  765 */             Array.setInt(a, index, number.intValue());
/*  766 */           } else if (type.equals(long.class)) {
/*  767 */             Array.setLong(a, index, number.longValue());
/*  768 */           } else if (type.equals(float.class)) {
/*  769 */             Array.setFloat(a, index, number.floatValue());
/*  770 */           } else if (type.equals(double.class)) {
/*  771 */             Array.setDouble(a, index, number.doubleValue());
/*  772 */           } else if (type.equals(boolean.class)) {
/*  773 */             Array.setBoolean(a, index, !number.equals(Integer.valueOf(0)));
/*      */           } else {
/*  775 */             Array.set(a, index, value);
/*      */           } 
/*      */         } else {
/*  778 */           Array.set(a, index, value);
/*      */         } 
/*  780 */         return v;
/*      */       }
/*  782 */       catch (Throwable t) {
/*  783 */         Symbol condition = Java.getCondition(t.getClass());
/*  784 */         if (condition == null) {
/*  785 */           Lisp.error(new JavaException(t));
/*      */         } else {
/*  787 */           Symbol.SIGNAL.execute(condition, Keyword.CAUSE, 
/*      */ 
/*      */               
/*  790 */               JavaObject.getInstance(t), Keyword.FORMAT_CONTROL, new SimpleString(
/*      */                 
/*  792 */                 Java.getMessage(t)));
/*      */         } 
/*      */         
/*  795 */         return Lisp.NIL;
/*      */       } 
/*      */     }
/*      */   }
/*      */   
/*  800 */   private static final Primitive JCALL = new pf_jcall();
/*      */ 
/*      */   
/*      */   @DocString(name = "jcall", args = "method-ref instance &rest args", doc = "Invokes the Java method METHOD-REF on INSTANCE with arguments ARGS, coercing the result into a Lisp object, if possible.")
/*      */   private static final class pf_jcall
/*      */     extends Primitive
/*      */   {
/*      */     pf_jcall() {
/*  808 */       super(Symbol.JCALL);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  814 */       return Java.jcall(this, args, true);
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*  822 */   private static final Primitive JCALL_RAW = new pf_jcall_raw();
/*      */ 
/*      */   
/*      */   @DocString(name = "jcall-raw", args = "method-ref instance &rest args", doc = "Invokes the Java method METHOD-REF on INSTANCE with arguments ARGS. Does not attempt to coerce the result into a Lisp object.")
/*      */   private static final class pf_jcall_raw
/*      */     extends Primitive
/*      */   {
/*      */     pf_jcall_raw() {
/*  830 */       super(Symbol.JCALL_RAW);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*  836 */       return Java.jcall(this, args, false);
/*      */     }
/*      */   }
/*      */   
/*  840 */   private static final Primitive JRESOLVE_METHOD = new pf_jresolve_method();
/*      */ 
/*      */   
/*      */   @DocString(name = "jresolve-method", args = "method-name instance &rest args", doc = "Finds the most specific Java method METHOD-NAME on INSTANCE applicable to arguments ARGS. Returns NIL if no suitable method is found. The algorithm used for resolution is the same used by JCALL when it is called with a string as the first parameter (METHOD-REF).")
/*      */   private static final class pf_jresolve_method
/*      */     extends Primitive
/*      */   {
/*      */     pf_jresolve_method() {
/*  848 */       super(Symbol.JRESOLVE_METHOD);
/*      */     }
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/*      */       Object instance;
/*  853 */       if (args.length < 2) {
/*  854 */         Lisp.error(new WrongNumberOfArgumentsException(this, 2, -1));
/*      */       }
/*  856 */       LispObject methodArg = args[0];
/*  857 */       LispObject instanceArg = args[1];
/*      */       
/*  859 */       Class<?> intendedClass = null;
/*  860 */       if (instanceArg instanceof AbstractString) {
/*  861 */         instance = instanceArg.getStringValue();
/*  862 */       } else if (instanceArg instanceof JavaObject) {
/*  863 */         JavaObject jobj = (JavaObject)instanceArg;
/*  864 */         instance = jobj.getObject();
/*  865 */         intendedClass = jobj.getIntendedClass();
/*      */       } else {
/*  867 */         instance = instanceArg.javaInstance();
/*      */       } 
/*  869 */       if (instance == null) {
/*  870 */         return Lisp.program_error("JRESOLVE-METHOD: instance must not be null.");
/*      */       }
/*  872 */       String methodName = methodArg.getStringValue();
/*  873 */       Object[] methodArgs = Java.translateMethodArguments(args, 2);
/*  874 */       Method method = Java.findMethod(instance, intendedClass, methodName, methodArgs);
/*  875 */       if (method != null)
/*  876 */         return JavaObject.getInstance(method); 
/*  877 */       if (instanceArg instanceof JavaObject) {
/*      */ 
/*      */ 
/*      */ 
/*      */         
/*  882 */         intendedClass = ((JavaObject)instanceArg).getObject().getClass();
/*  883 */         method = Java.findMethod(instance, intendedClass, methodName, methodArgs);
/*      */       } else {
/*  885 */         return Lisp.NIL;
/*      */       } 
/*  887 */       if (method != null) {
/*  888 */         return JavaObject.getInstance(method);
/*      */       }
/*  890 */       return Lisp.NIL;
/*      */     }
/*      */   }
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   static LispObject jcall(Primitive fun, LispObject[] args, boolean translate) {
/*  898 */     if (args.length < 2)
/*  899 */       Lisp.error(new WrongNumberOfArgumentsException(fun, 2, -1));  try {
/*      */       Object instance; Method method;
/*  901 */       LispObject methodArg = args[0];
/*  902 */       LispObject instanceArg = args[1];
/*      */ 
/*      */ 
/*      */       
/*  906 */       Class<?> intendedClass = null;
/*  907 */       if (instanceArg instanceof AbstractString) {
/*  908 */         instance = instanceArg.getStringValue();
/*  909 */       } else if (instanceArg instanceof JavaObject) {
/*  910 */         JavaObject jobj = (JavaObject)instanceArg;
/*  911 */         instance = jobj.getObject();
/*  912 */         intendedClass = jobj.getIntendedClass();
/*      */       } else {
/*  914 */         instance = instanceArg.javaInstance();
/*      */       } 
/*  916 */       if (instance == null) {
/*  917 */         throw new NullPointerException();
/*      */       }
/*  919 */       if (methodArg instanceof AbstractString) {
/*  920 */         String methodName = methodArg.getStringValue();
/*  921 */         Object[] arrayOfObject = translateMethodArguments(args, 2);
/*  922 */         method = findMethod(instance, intendedClass, methodName, arrayOfObject);
/*  923 */         if (method == null) {
/*  924 */           if (intendedClass == null) {
/*  925 */             String msg = MessageFormat.format("No instance method named {0} found for type {1}", new Object[] { methodName, instance.getClass().getName() });
/*  926 */             throw new NoSuchMethodException(msg);
/*      */           } 
/*  928 */           String classes = intendedClass.getName();
/*  929 */           Class<?> actualClass = instance.getClass();
/*  930 */           if (actualClass != intendedClass) {
/*  931 */             classes = classes + " or " + actualClass.getName();
/*      */           }
/*  933 */           throw new NoSuchMethodException("No applicable method named " + methodName + " found in " + classes);
/*      */         } 
/*      */       } else {
/*  936 */         method = (Method)JavaObject.getObject(methodArg);
/*  937 */       }  Class<?>[] argTypes = method.getParameterTypes();
/*  938 */       if (argTypes.length != args.length - 2) {
/*  939 */         return Lisp.error(new WrongNumberOfArgumentsException("Wrong number of arguments for " + method + ": expected " + argTypes.length + ", got " + (args.length - 2)));
/*      */       }
/*  941 */       Object[] methodArgs = new Object[argTypes.length];
/*  942 */       for (int i = 2; i < args.length; i++) {
/*  943 */         LispObject arg = args[i];
/*  944 */         if (arg.equals(Lisp.NIL)) {
/*  945 */           methodArgs[i - 2] = Boolean.valueOf(false);
/*  946 */         } else if (arg.equals(Lisp.T)) {
/*  947 */           methodArgs[i - 2] = Boolean.valueOf(true);
/*      */         } else {
/*  949 */           methodArgs[i - 2] = arg.javaInstance(argTypes[i - 2]);
/*      */         } 
/*      */       } 
/*  952 */       if (!method.isAccessible())
/*      */       {
/*  954 */         if (Modifier.isPublic(method.getModifiers())) {
/*  955 */           method.setAccessible(true);
/*      */         }
/*      */       }
/*  958 */       return JavaObject.getInstance(method.invoke(instance, methodArgs), translate, method
/*      */           
/*  960 */           .getReturnType());
/*      */     }
/*  962 */     catch (ControlTransfer t) {
/*  963 */       throw t;
/*      */     }
/*  965 */     catch (Throwable t) {
/*  966 */       if (t instanceof java.lang.reflect.InvocationTargetException)
/*  967 */         t = t.getCause(); 
/*  968 */       Symbol condition = getCondition(t.getClass());
/*  969 */       if (condition == null) {
/*  970 */         Lisp.error(new JavaException(t));
/*      */       } else {
/*  972 */         Symbol.SIGNAL.execute(condition, Keyword.CAUSE, 
/*      */ 
/*      */             
/*  975 */             JavaObject.getInstance(t), Keyword.FORMAT_CONTROL, new SimpleString(
/*      */               
/*  977 */               getMessage(t)));
/*      */       } 
/*      */       
/*  980 */       return null;
/*      */     } 
/*      */   }
/*      */   private static Object[] translateMethodArguments(LispObject[] args) {
/*  984 */     return translateMethodArguments(args, 0);
/*      */   }
/*      */   
/*      */   private static Object[] translateMethodArguments(LispObject[] args, int offs) {
/*  988 */     int argCount = args.length - offs;
/*  989 */     Object[] javaArgs = new Object[argCount];
/*  990 */     for (int i = 0; i < argCount; i++) {
/*  991 */       Object x = args[i + offs];
/*  992 */       if (x.equals(Lisp.NIL)) {
/*  993 */         javaArgs[i] = Boolean.valueOf(false);
/*  994 */       } else if (x.equals(Lisp.T)) {
/*  995 */         javaArgs[i] = Boolean.valueOf(true);
/*      */       } else {
/*  997 */         javaArgs[i] = ((LispObject)x).javaInstance();
/*      */       } 
/*      */     } 
/* 1000 */     return javaArgs;
/*      */   }
/*      */   
/*      */   private static Method findMethod(Method[] methods, String methodName, Object[] javaArgs) {
/* 1004 */     int argCount = javaArgs.length;
/* 1005 */     Method result = null;
/* 1006 */     for (int i = methods.length; i-- > 0; ) {
/* 1007 */       Method method = methods[i];
/* 1008 */       if (!method.getName().equals(methodName)) {
/*      */         continue;
/*      */       }
/* 1011 */       if ((method.getParameterTypes()).length != argCount) {
/*      */         continue;
/*      */       }
/* 1014 */       Class<?>[] methodTypes = method.getParameterTypes();
/* 1015 */       if (!isApplicableMethod(methodTypes, javaArgs)) {
/*      */         continue;
/*      */       }
/* 1018 */       if (result == null || isMoreSpecialized(methodTypes, result.getParameterTypes())) {
/* 1019 */         result = method;
/*      */       }
/*      */     } 
/* 1022 */     return result;
/*      */   }
/*      */   
/*      */   private static Method findMethod(Object instance, Class<?> intendedClass, String methodName, Object[] methodArgs) {
/* 1026 */     if (intendedClass == null) {
/* 1027 */       intendedClass = instance.getClass();
/*      */     }
/* 1029 */     Method method = findMethod(intendedClass, methodName, methodArgs);
/* 1030 */     Class<?> actualClass = null;
/* 1031 */     if (method == null) {
/* 1032 */       actualClass = instance.getClass();
/* 1033 */       if (intendedClass != actualClass) {
/* 1034 */         method = findMethod(actualClass, methodName, methodArgs);
/* 1035 */         if (method != null && 
/* 1036 */           isMethodCallableOnInstance(actualClass, method)) {
/* 1037 */           return method;
/*      */         }
/*      */       } 
/*      */     } 
/*      */     
/* 1042 */     return method;
/*      */   }
/*      */   
/*      */   private static boolean isMethodCallableOnInstance(Class instance, Method method) {
/* 1046 */     if (Modifier.isPublic(method.getModifiers())) {
/* 1047 */       return true;
/*      */     }
/* 1049 */     if (instance.isMemberClass()) {
/* 1050 */       return isMethodCallableOnInstance(instance.getEnclosingClass(), method);
/*      */     }
/* 1052 */     return false;
/*      */   }
/*      */   
/*      */   private static Method findMethod(Class<?> c, String methodName, Object[] javaArgs) {
/* 1056 */     Method[] methods = c.getMethods();
/* 1057 */     return findMethod(methods, methodName, javaArgs);
/*      */   }
/*      */   
/*      */   private static Method findMethod(Class<?> c, String methodName, LispObject[] args, int offset) {
/* 1061 */     Object[] javaArgs = translateMethodArguments(args, offset);
/* 1062 */     return findMethod(c, methodName, javaArgs);
/*      */   }
/*      */   
/*      */   private static Method findMethod(Method[] methods, String methodName, LispObject[] args, int offset) {
/* 1066 */     Object[] javaArgs = translateMethodArguments(args, offset);
/* 1067 */     return findMethod(methods, methodName, javaArgs);
/*      */   }
/*      */   
/*      */   static Constructor findConstructor(Class<?> c, LispObject[] args) throws NoSuchMethodException {
/* 1071 */     int argCount = args.length - 1;
/* 1072 */     Object[] javaArgs = translateMethodArguments(args, 1);
/* 1073 */     Constructor[] ctors = (Constructor[])c.getConstructors();
/* 1074 */     Constructor result = null;
/* 1075 */     for (int i = ctors.length; i-- > 0; ) {
/* 1076 */       Constructor ctor = ctors[i];
/* 1077 */       if ((ctor.getParameterTypes()).length != argCount) {
/*      */         continue;
/*      */       }
/* 1080 */       Class<?>[] methodTypes = ctor.getParameterTypes();
/* 1081 */       if (!isApplicableMethod(methodTypes, javaArgs)) {
/*      */         continue;
/*      */       }
/* 1084 */       if (result == null || isMoreSpecialized(methodTypes, result.getParameterTypes())) {
/* 1085 */         result = ctor;
/*      */       }
/*      */     } 
/* 1088 */     if (result == null) {
/* 1089 */       StringBuilder sb = new StringBuilder(c.getSimpleName());
/* 1090 */       sb.append('(');
/* 1091 */       boolean first = true;
/* 1092 */       for (Object o : javaArgs) {
/* 1093 */         if (first) {
/* 1094 */           first = false;
/*      */         } else {
/* 1096 */           sb.append(", ");
/*      */         } 
/* 1098 */         if (o != null) {
/* 1099 */           sb.append(o.getClass().getName());
/*      */         } else {
/* 1101 */           sb.append("<null>");
/*      */         } 
/*      */       } 
/* 1104 */       sb.append(')');
/* 1105 */       throw new NoSuchMethodException(sb.toString());
/*      */     } 
/* 1107 */     return result;
/*      */   }
/*      */   
/*      */   private static boolean isAssignable(Class<?> from, Class<?> to) {
/* 1111 */     from = maybeBoxClass(from);
/* 1112 */     to = maybeBoxClass(to);
/* 1113 */     if (to.isAssignableFrom(from)) {
/* 1114 */       return true;
/*      */     }
/* 1116 */     if (Byte.class.equals(from))
/* 1117 */       return (Short.class.equals(to) || Integer.class.equals(to) || Long.class.equals(to) || Float.class.equals(to) || Double.class.equals(to)); 
/* 1118 */     if (Short.class.equals(from) || Character.class.equals(from))
/* 1119 */       return (Integer.class.equals(to) || Long.class.equals(to) || Float.class.equals(to) || Double.class.equals(to)); 
/* 1120 */     if (Integer.class.equals(from))
/* 1121 */       return (Long.class.equals(to) || Float.class.equals(to) || Double.class.equals(to)); 
/* 1122 */     if (Long.class.equals(from))
/* 1123 */       return (Float.class.equals(to) || Double.class.equals(to)); 
/* 1124 */     if (Float.class.equals(from))
/* 1125 */       return Double.class.equals(to); 
/* 1126 */     if (from.isArray() && to.isArray())
/*      */     {
/*      */       
/* 1129 */       if (to.getComponentType().equals(Object.class)) {
/* 1130 */         return true;
/*      */       }
/*      */     }
/* 1133 */     return false;
/*      */   }
/*      */ 
/*      */   
/*      */   private static boolean isApplicableMethod(Class<?>[] methodTypes, Object[] args) {
/* 1138 */     for (int i = 0; i < methodTypes.length; i++) {
/* 1139 */       Class<?> methodType = methodTypes[i];
/* 1140 */       Object arg = args[i];
/* 1141 */       if (arg == null)
/* 1142 */         return !methodType.isPrimitive(); 
/* 1143 */       if (!isAssignableWithValue(arg.getClass(), methodType, arg)) {
/* 1144 */         return false;
/*      */       }
/*      */     } 
/* 1147 */     return true;
/*      */   }
/*      */   
/*      */   private static boolean isAssignableWithValue(Class<?> from, Class<?> to, Object value) {
/* 1151 */     if (isAssignable(from, to)) {
/* 1152 */       return true;
/*      */     }
/* 1154 */     if (!(value instanceof Number)) {
/* 1155 */       return false;
/*      */     }
/* 1157 */     from = maybeBoxClass(from);
/* 1158 */     to = maybeBoxClass(to);
/* 1159 */     if (Integer.class.equals(from)) {
/* 1160 */       int v = ((Number)value).intValue();
/*      */       
/* 1162 */       if (Short.class.equals(to) && 32767 >= v && v >= -32768)
/*      */       {
/*      */         
/* 1165 */         return true;
/*      */       }
/* 1167 */       if (Byte.class.equals(to) && 255 >= v && v >= 0)
/*      */       {
/*      */         
/* 1170 */         return true;
/*      */       }
/*      */     }
/* 1173 */     else if (BigInteger.class.equals(from)) {
/*      */       
/* 1175 */       BigInteger v = (BigInteger)value;
/* 1176 */       BigInteger maxLong = BigInteger.valueOf(Long.MAX_VALUE);
/* 1177 */       BigInteger minLong = BigInteger.valueOf(Long.MIN_VALUE);
/* 1178 */       if (Long.class.equals(to) && (v
/* 1179 */         .compareTo(maxLong) == -1 || v
/* 1180 */         .compareTo(maxLong) == 0) && (v
/* 1181 */         .compareTo(minLong) == 1 || v
/* 1182 */         .compareTo(minLong) == 0)) {
/* 1183 */         return true;
/*      */       }
/*      */     } 
/*      */     
/* 1187 */     return false;
/*      */   }
/*      */   
/*      */   private static boolean isMoreSpecialized(Class<?>[] xtypes, Class<?>[] ytypes) {
/* 1191 */     for (int i = 0; i < xtypes.length; i++) {
/* 1192 */       Class<?> xtype = maybeBoxClass(xtypes[i]);
/* 1193 */       Class<?> ytype = maybeBoxClass(ytypes[i]);
/* 1194 */       if (!xtype.equals(ytype))
/*      */       {
/*      */         
/* 1197 */         if (isAssignable(xtype, ytype))
/* 1198 */           return true; 
/*      */       }
/*      */     } 
/* 1201 */     return false;
/*      */   }
/*      */   
/*      */   public static Class<?> maybeBoxClass(Class<?> clazz) {
/* 1205 */     if (clazz.isPrimitive()) {
/* 1206 */       return getBoxedClass(clazz);
/*      */     }
/* 1208 */     return clazz;
/*      */   }
/*      */ 
/*      */   
/*      */   private static Class<?> getBoxedClass(Class<?> clazz) {
/* 1213 */     if (clazz.equals(int.class))
/* 1214 */       return Integer.class; 
/* 1215 */     if (clazz.equals(boolean.class))
/* 1216 */       return Boolean.class; 
/* 1217 */     if (clazz.equals(byte.class))
/* 1218 */       return Byte.class; 
/* 1219 */     if (clazz.equals(char.class))
/* 1220 */       return Character.class; 
/* 1221 */     if (clazz.equals(long.class))
/* 1222 */       return Long.class; 
/* 1223 */     if (clazz.equals(float.class))
/* 1224 */       return Float.class; 
/* 1225 */     if (clazz.equals(double.class))
/* 1226 */       return Double.class; 
/* 1227 */     if (clazz.equals(short.class)) {
/* 1228 */       return Short.class;
/*      */     }
/* 1230 */     return Void.class;
/*      */   }
/*      */ 
/*      */ 
/*      */   
/* 1235 */   private static final Primitive MAKE_IMMEDIATE_OBJECT = new pf_make_immediate_object();
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "make-immediate-object", args = "object &optional type", doc = "Attempts to coerce a given Lisp object into a java-object of the\ngiven type.  If type is not provided, works as jobject-lisp-value.\nCurrently, type may be :BOOLEAN, treating the object as a truth value,\nor :REF, which returns Java null if NIL is provided.\n\nDeprecated.  Please use JAVA:+NULL+, JAVA:+TRUE+, and JAVA:+FALSE+ for\nconstructing wrapped primitive types, JAVA:JOBJECT-LISP-VALUE for converting a\nJAVA:JAVA-OBJECT to a Lisp value, or JAVA:JNULL-REF-P to distinguish a wrapped\nnull JAVA-OBJECT from NIL.")
/*      */   private static final class pf_make_immediate_object
/*      */     extends Primitive
/*      */   {
/*      */     pf_make_immediate_object() {
/* 1250 */       super("make-immediate-object", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject[] args) {
/* 1256 */       Symbol.WARN.getSymbolFunction()
/* 1257 */         .execute(new SimpleString("JAVA:MAKE-IMMEDIATE-OBJECT is deprecated."));
/* 1258 */       if (args.length < 1)
/* 1259 */         Lisp.error(new WrongNumberOfArgumentsException(this, 1, -1)); 
/* 1260 */       LispObject object = args[0];
/* 1261 */       if (args.length > 1) {
/* 1262 */         LispObject type = args[1];
/* 1263 */         if (type == Keyword.BOOLEAN) {
/* 1264 */           if (object == Lisp.NIL) {
/* 1265 */             return JavaObject.getInstance(Boolean.FALSE);
/*      */           }
/* 1267 */           return JavaObject.getInstance(Boolean.TRUE);
/*      */         } 
/* 1269 */         if (type == Keyword.REF) {
/* 1270 */           if (object == Lisp.NIL) {
/* 1271 */             return JavaObject.getInstance(null);
/*      */           }
/* 1273 */           Lisp.error(new LispError("MAKE-IMMEDIATE-OBJECT: not implemented"));
/*      */         } 
/*      */       } 
/*      */       
/* 1277 */       return JavaObject.getInstance(object.javaInstance());
/*      */     }
/*      */   }
/*      */   
/* 1281 */   private static final Primitive JNULL_REF_P = new pf_jnull_ref_p();
/*      */ 
/*      */ 
/*      */   
/*      */   @DocString(name = "jnull-ref-p", args = "object", doc = "Returns a non-NIL value when the JAVA-OBJECT `object` is `null`,\nor signals a TYPE-ERROR condition if the object isn't of\nthe right type.")
/*      */   private static final class pf_jnull_ref_p
/*      */     extends Primitive
/*      */   {
/*      */     pf_jnull_ref_p() {
/* 1290 */       super("jnull-ref-p", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject ref) {
/* 1296 */       if (ref instanceof JavaObject) {
/*      */         
/* 1298 */         JavaObject jref = (JavaObject)ref;
/* 1299 */         return (jref.javaInstance() == null) ? Lisp.T : Lisp.NIL;
/*      */       } 
/* 1301 */       return Lisp.type_error(ref, Symbol.JAVA_OBJECT);
/*      */     }
/*      */   }
/*      */ 
/*      */   
/* 1306 */   private static final Primitive JAVA_OBJECT_P = new pf_java_object_p();
/*      */   
/*      */   @DocString(name = "java-object-p", args = "object", doc = "Returns T if OBJECT is a JAVA-OBJECT.")
/*      */   private static final class pf_java_object_p
/*      */     extends Primitive
/*      */   {
/*      */     pf_java_object_p() {
/* 1313 */       super("java-object-p", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1319 */       return (arg instanceof JavaObject) ? Lisp.T : Lisp.NIL;
/*      */     }
/*      */   }
/*      */   
/* 1323 */   private static final Primitive JOBJECT_LISP_VALUE = new pf_jobject_lisp_value();
/*      */   
/*      */   @DocString(name = "jobject-lisp-value", args = "java-object", doc = "Attempts to coerce JAVA-OBJECT into a Lisp object.")
/*      */   private static final class pf_jobject_lisp_value
/*      */     extends Primitive
/*      */   {
/*      */     pf_jobject_lisp_value() {
/* 1330 */       super("jobject-lisp-value", Lisp.PACKAGE_JAVA, true, "java-object");
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject arg) {
/* 1336 */       return JavaObject.getInstance(arg.javaInstance(), true);
/*      */     }
/*      */   }
/*      */   
/* 1340 */   private static final Primitive JCOERCE = new pf_jcoerce();
/*      */ 
/*      */   
/*      */   @DocString(name = "jcoerce", args = "object intended-class", doc = "Attempts to coerce OBJECT into a JavaObject of class INTENDED-CLASS.  Raises a TYPE-ERROR if no conversion is possible.")
/*      */   private static final class pf_jcoerce
/*      */     extends Primitive
/*      */   {
/*      */     pf_jcoerce() {
/* 1348 */       super("jcoerce", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject javaObject, LispObject intendedClass) {
/* 1354 */       Object o = javaObject.javaInstance();
/* 1355 */       Class<?> c = Java.javaClass(intendedClass);
/*      */       try {
/* 1357 */         return JavaObject.getInstance(o, c);
/* 1358 */       } catch (ClassCastException e) {
/* 1359 */         return Lisp.type_error(javaObject, new SimpleString(c.getName()));
/*      */       } 
/*      */     }
/*      */   }
/*      */   
/* 1364 */   private static final Primitive JRUN_EXCEPTION_PROTECTED = new pf_jrun_exception_protected();
/*      */ 
/*      */   
/*      */   @DocString(name = "jrun-exception-protected", args = "closure", doc = "Invokes the function CLOSURE and returns the result.  Signals an error if stack or heap exhaustion occurs.")
/*      */   private static final class pf_jrun_exception_protected
/*      */     extends Primitive
/*      */   {
/*      */     pf_jrun_exception_protected() {
/* 1372 */       super("jrun-exception-protected", Lisp.PACKAGE_JAVA, true);
/*      */     }
/*      */ 
/*      */     
/*      */     public LispObject execute(LispObject closure) {
/* 1377 */       Function fun = Lisp.checkFunction(closure);
/*      */       
/*      */       try {
/* 1380 */         return LispThread.currentThread().execute(closure);
/*      */       }
/* 1382 */       catch (OutOfMemoryError oom) {
/* 1383 */         return Lisp.error(new StorageCondition("Out of memory " + oom.getMessage()));
/*      */       }
/* 1385 */       catch (StackOverflowError oos) {
/* 1386 */         oos.printStackTrace();
/* 1387 */         return Lisp.error(new StorageCondition("Stack overflow."));
/*      */       } 
/*      */     }
/*      */   }
/*      */   
/*      */   private static Class classForName(String className) {
/* 1393 */     return classForName(className, JavaClassLoader.getPersistentInstance());
/*      */   }
/*      */ 
/*      */   
/*      */   private static Class classForName(String className, ClassLoader classLoader) {
/*      */     try {
/* 1399 */       if (!className.endsWith("[]")) {
/* 1400 */         return Class.forName(className, true, classLoader);
/*      */       }
/*      */       
/* 1403 */       if (className.startsWith("byte"))
/* 1404 */         return Class.forName("[B"); 
/* 1405 */       if (className.startsWith("char"))
/* 1406 */         return Class.forName("[C"); 
/* 1407 */       if (className.startsWith("double"))
/* 1408 */         return Class.forName("[D"); 
/* 1409 */       if (className.startsWith("float"))
/* 1410 */         return Class.forName("[F"); 
/* 1411 */       if (className.startsWith("int"))
/* 1412 */         return Class.forName("[I"); 
/* 1413 */       if (className.startsWith("long"))
/* 1414 */         return Class.forName("[J"); 
/* 1415 */       if (className.startsWith("short"))
/* 1416 */         return Class.forName("[S"); 
/* 1417 */       if (className.startsWith("boolean")) {
/* 1418 */         return Class.forName("[Z");
/*      */       }
/*      */       
/* 1421 */       String arrayTypeName = "[L" + className.substring(0, className.length() - 2) + ";";
/* 1422 */       return Class.forName(arrayTypeName);
/*      */     
/*      */     }
/* 1425 */     catch (ClassNotFoundException e) {
/* 1426 */       Lisp.error(new LispError("Class not found: " + className));
/*      */       
/* 1428 */       return null;
/*      */     } 
/*      */   }
/*      */   
/*      */   private static Class javaClass(LispObject obj) {
/* 1433 */     return javaClass(obj, JavaClassLoader.getCurrentClassLoader());
/*      */   }
/*      */ 
/*      */   
/*      */   static Class javaClass(LispObject obj, ClassLoader classLoader) {
/*      */     JavaObject javaObject;
/* 1439 */     if (obj instanceof AbstractString || obj instanceof Symbol) {
/* 1440 */       String s = Lisp.javaString(obj);
/* 1441 */       if (s.equals("boolean"))
/* 1442 */         return boolean.class; 
/* 1443 */       if (s.equals("byte"))
/* 1444 */         return byte.class; 
/* 1445 */       if (s.equals("char"))
/* 1446 */         return char.class; 
/* 1447 */       if (s.equals("short"))
/* 1448 */         return short.class; 
/* 1449 */       if (s.equals("int"))
/* 1450 */         return int.class; 
/* 1451 */       if (s.equals("long"))
/* 1452 */         return long.class; 
/* 1453 */       if (s.equals("float"))
/* 1454 */         return float.class; 
/* 1455 */       if (s.equals("double")) {
/* 1456 */         return double.class;
/*      */       }
/*      */       
/* 1459 */       Class c = classForName(s, classLoader);
/* 1460 */       if (c == null) {
/* 1461 */         Lisp.error(new LispError(s + " does not designate a Java class."));
/*      */       }
/* 1463 */       return c;
/*      */     } 
/*      */ 
/*      */     
/* 1467 */     if (obj instanceof JavaObject) {
/* 1468 */       javaObject = (JavaObject)obj;
/*      */     } else {
/*      */       
/* 1471 */       Lisp.type_error(obj, Lisp.list(Symbol.OR, new LispObject[] { Symbol.STRING, Symbol.JAVA_OBJECT }));
/*      */ 
/*      */       
/* 1474 */       return null;
/*      */     } 
/* 1476 */     Object javaObjectgetObject = javaObject.getObject();
/* 1477 */     if (javaObjectgetObject instanceof Class) {
/* 1478 */       return (Class)javaObjectgetObject;
/*      */     }
/* 1480 */     Lisp.error(new LispError(obj.princToString() + " does not designate a Java class."));
/* 1481 */     return null;
/*      */   }
/*      */ 
/*      */   
/*      */   static final String getMessage(Throwable t) {
/* 1486 */     String message = t.getMessage();
/* 1487 */     if (message == null || message.length() == 0)
/* 1488 */       message = t.getClass().getName(); 
/* 1489 */     return message;
/*      */   }
/*      */   
/*      */   public static class Buffers
/*      */   {
/*      */     public enum AllocationPolicy {
/* 1495 */       PRIMITIVE_ARRAY, NIO; }
/* 1496 */     public static AllocationPolicy active = AllocationPolicy.NIO;
/*      */   }
/*      */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/Java.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */