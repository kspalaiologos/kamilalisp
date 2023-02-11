/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.lang.reflect.InvocationHandler;
/*     */ import java.lang.reflect.Method;
/*     */ import java.lang.reflect.Proxy;
/*     */ import java.util.HashMap;
/*     */ import java.util.Map;
/*     */ import java.util.WeakHashMap;
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
/*     */ public final class JProxy
/*     */ {
/*  47 */   static final Map<Object, Entry> table = new WeakHashMap<>();
/*     */ 
/*     */   
/*  50 */   private static final Primitive _JNEW_PROXY = new Primitive("%jnew-proxy", Lisp.PACKAGE_JAVA, false, "interface &rest method-names-and-defs")
/*     */     {
/*     */ 
/*     */ 
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/*  57 */         int length = args.length;
/*  58 */         if (length < 3 || length % 2 != 1)
/*  59 */           return Lisp.error(new WrongNumberOfArgumentsException(this)); 
/*  60 */         Map<String, Function> lispDefinedMethods = new HashMap<>();
/*  61 */         for (int i = 1; i < length; i += 2) {
/*  62 */           lispDefinedMethods.put(args[i].getStringValue(), (Function)args[i + 1]);
/*     */         }
/*  64 */         Class iface = (Class)args[0].javaInstance();
/*  65 */         Object proxy = Proxy.newProxyInstance(iface.getClassLoader(), new Class[] { iface }, new JProxy.LispHandler(JProxy.table));
/*     */ 
/*     */         
/*  68 */         JProxy.table.put(proxy, new JProxy.Entry(iface, lispDefinedMethods));
/*  69 */         return new JavaObject(proxy);
/*     */       }
/*     */     };
/*     */   
/*     */   private static class LispHandler
/*     */     implements InvocationHandler
/*     */   {
/*     */     Map table;
/*     */     
/*     */     LispHandler(Map table) {
/*  79 */       this.table = table;
/*     */     }
/*     */ 
/*     */     
/*     */     public Object invoke(Object proxy, Method method, Object[] args) {
/*  84 */       String methodName = method.getName();
/*     */       
/*  86 */       if (methodName.equals("hashCode"))
/*  87 */         return Integer.valueOf(System.identityHashCode(proxy)); 
/*  88 */       if (methodName.equals("equals"))
/*  89 */         return (proxy == args[0]) ? Boolean.TRUE : Boolean.FALSE; 
/*  90 */       if (methodName.equals("toString")) {
/*  91 */         return proxy.getClass().getName() + '@' + Integer.toHexString(proxy.hashCode());
/*     */       }
/*  93 */       if (this.table.containsKey(proxy)) {
/*     */         
/*  95 */         JProxy.Entry entry = (JProxy.Entry)this.table.get(proxy);
/*  96 */         Function f = entry.getLispMethod(methodName);
/*  97 */         if (f != null) {
/*     */           
/*  99 */           LispObject lispArgs = Lisp.NIL;
/* 100 */           if (args != null)
/*     */           {
/* 102 */             for (int i = args.length - 1; 0 <= i; i--)
/* 103 */               lispArgs = lispArgs.push(new JavaObject(args[i])); 
/*     */           }
/* 105 */           LispObject result = Lisp.evalCall(f, lispArgs, new Environment(), 
/* 106 */               LispThread.currentThread());
/* 107 */           return (method.getReturnType() == void.class) ? null : result.javaInstance();
/*     */         } 
/*     */       } 
/* 110 */       return null;
/*     */     }
/*     */   }
/*     */ 
/*     */   
/*     */   private static class Entry
/*     */   {
/*     */     Class iface;
/*     */     Map lispDefinedMethods;
/*     */     
/*     */     public Entry(Class iface, Map lispDefinedMethods) {
/* 121 */       this.iface = iface;
/* 122 */       this.lispDefinedMethods = lispDefinedMethods;
/*     */     }
/*     */ 
/*     */     
/*     */     public Function getLispMethod(String methodName) {
/* 127 */       if (this.lispDefinedMethods.containsKey(methodName))
/* 128 */         return (Function)this.lispDefinedMethods.get(methodName); 
/* 129 */       return null;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */   
/* 138 */   static final Map<Object, LispObject> proxyMap = new WeakHashMap<>();
/*     */   
/*     */   public static class LispInvocationHandler
/*     */     implements InvocationHandler {
/*     */     private Function function;
/*     */     private static Method hashCodeMethod;
/*     */     private static Method equalsMethod;
/*     */     private static Method toStringMethod;
/*     */     
/*     */     static {
/*     */       try {
/* 149 */         hashCodeMethod = Object.class.getMethod("hashCode", new Class[0]);
/* 150 */         equalsMethod = Object.class.getMethod("equals", new Class[] { Object.class });
/* 151 */         toStringMethod = Object.class.getMethod("toString", new Class[0]);
/* 152 */       } catch (Exception e) {
/* 153 */         throw new Error("Something got horribly wrong - can't get a method from Object.class", e);
/*     */       } 
/*     */     }
/*     */     
/*     */     public LispInvocationHandler(Function function) {
/* 158 */       this.function = function;
/*     */     }
/*     */     
/*     */     public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
/* 162 */       if (hashCodeMethod.equals(method)) {
/* 163 */         return Integer.valueOf(System.identityHashCode(proxy));
/*     */       }
/* 165 */       if (equalsMethod.equals(method)) {
/* 166 */         return Boolean.valueOf((proxy == args[0]));
/*     */       }
/* 168 */       if (toStringMethod.equals(method)) {
/* 169 */         return proxy.getClass().getName() + '@' + Integer.toHexString(proxy.hashCode());
/*     */       }
/*     */       
/* 172 */       if (args == null) {
/* 173 */         args = new Object[0];
/*     */       }
/* 175 */       LispObject lispArgs = Lisp.NIL;
/* 176 */       synchronized (JProxy.proxyMap) {
/* 177 */         lispArgs = lispArgs.push(JProxy.toLispObject(JProxy.proxyMap.get(proxy)));
/*     */       } 
/* 179 */       lispArgs = lispArgs.push(new SimpleString(method.getName()));
/* 180 */       for (int i = 0; i < args.length; i++) {
/* 181 */         lispArgs = lispArgs.push(JProxy.toLispObject(args[i]));
/*     */       }
/*     */ 
/*     */       
/* 185 */       Object retVal = LispThread.currentThread().execute(Symbol.APPLY, this.function, lispArgs.reverse()).javaInstance();
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */       
/* 191 */       return retVal;
/*     */     }
/*     */   }
/*     */   
/* 195 */   private static final Primitive _JMAKE_INVOCATION_HANDLER = new Primitive("%jmake-invocation-handler", Lisp.PACKAGE_JAVA, false, "function")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 200 */         int length = args.length;
/* 201 */         if (length != 1) {
/* 202 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 1));
/*     */         }
/* 204 */         if (!(args[0] instanceof Function)) {
/* 205 */           return Lisp.type_error(args[0], Symbol.FUNCTION);
/*     */         }
/* 207 */         return new JavaObject(new JProxy.LispInvocationHandler((Function)args[0]));
/*     */       }
/*     */     };
/*     */   
/* 211 */   private static final Primitive _JMAKE_PROXY = new Primitive("%jmake-proxy", Lisp.PACKAGE_JAVA, false, "interfaces invocation-handler")
/*     */     {
/*     */       
/*     */       public LispObject execute(LispObject[] args)
/*     */       {
/* 216 */         int length = args.length;
/* 217 */         if (length != 3) {
/* 218 */           return Lisp.error(new WrongNumberOfArgumentsException(this, 3));
/*     */         }
/* 220 */         if (!(args[0] instanceof Cons)) {
/* 221 */           return Lisp.type_error(args[0], Symbol.CONS);
/*     */         }
/* 223 */         Class[] ifaces = new Class[args[0].length()];
/* 224 */         LispObject ifList = args[0];
/* 225 */         for (int i = 0; i < ifaces.length; i++) {
/* 226 */           ifaces[i] = (Class)ifList.car().javaInstance(Class.class);
/* 227 */           ifList = ifList.cdr();
/*     */         } 
/* 229 */         InvocationHandler invocationHandler = (InvocationHandler)((JavaObject)args[1]).javaInstance(InvocationHandler.class);
/* 230 */         Object proxy = Proxy.newProxyInstance(
/* 231 */             JavaClassLoader.getCurrentClassLoader(), ifaces, invocationHandler);
/*     */ 
/*     */         
/* 234 */         synchronized (JProxy.proxyMap) {
/* 235 */           JProxy.proxyMap.put(proxy, args[2]);
/*     */         } 
/* 237 */         return new JavaObject(proxy);
/*     */       }
/*     */     };
/*     */   
/*     */   static LispObject toLispObject(Object obj) {
/* 242 */     return (obj instanceof LispObject) ? (LispObject)obj : new JavaObject(obj);
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/JProxy.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */