/*     */ package org.armedbear.lisp.scripting;
/*     */ 
/*     */ import java.io.File;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.Reader;
/*     */ import java.io.StringWriter;
/*     */ import java.util.Map;
/*     */ import javax.script.AbstractScriptEngine;
/*     */ import javax.script.Bindings;
/*     */ import javax.script.Compilable;
/*     */ import javax.script.CompiledScript;
/*     */ import javax.script.Invocable;
/*     */ import javax.script.ScriptContext;
/*     */ import javax.script.ScriptEngine;
/*     */ import javax.script.ScriptEngineFactory;
/*     */ import javax.script.ScriptException;
/*     */ import javax.script.SimpleBindings;
/*     */ import org.armedbear.lisp.Cons;
/*     */ import org.armedbear.lisp.Function;
/*     */ import org.armedbear.lisp.Interpreter;
/*     */ import org.armedbear.lisp.JavaObject;
/*     */ import org.armedbear.lisp.Keyword;
/*     */ import org.armedbear.lisp.Lisp;
/*     */ import org.armedbear.lisp.LispObject;
/*     */ import org.armedbear.lisp.LispThread;
/*     */ import org.armedbear.lisp.SimpleString;
/*     */ import org.armedbear.lisp.Stream;
/*     */ import org.armedbear.lisp.Symbol;
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
/*     */ public class AbclScriptEngine
/*     */   extends AbstractScriptEngine
/*     */   implements Invocable, Compilable
/*     */ {
/*  56 */   private Interpreter interpreter = Interpreter.getInstance(); private Function evalScript; private Function evalFunction; protected AbclScriptEngine() {
/*  57 */     if (this.interpreter == null) {
/*  58 */       this.interpreter = Interpreter.createInstance();
/*     */     }
/*  60 */     loadFromClasspath("/org/armedbear/lisp/scripting/lisp/packages.lisp");
/*  61 */     loadFromClasspath("/org/armedbear/lisp/scripting/lisp/abcl-script.lisp");
/*  62 */     loadFromClasspath("/org/armedbear/lisp/scripting/lisp/config.lisp");
/*  63 */     if (getClass().getResource("/abcl-script-config.lisp") != null)
/*     */     {
/*     */       
/*  66 */       loadFromClasspath("/abcl-script-config.lisp");
/*     */     }
/*  68 */     ((Function)this.interpreter.eval("#'abcl-script:configure-abcl")).execute((LispObject)new JavaObject(this));
/*     */     
/*  70 */     this.evalScript = (Function)findSymbol("EVAL-SCRIPT", "ABCL-SCRIPT").getSymbolFunction();
/*  71 */     this.compileScript = (Function)findSymbol("COMPILE-SCRIPT", "ABCL-SCRIPT").getSymbolFunction();
/*  72 */     this.evalCompiledScript = (Function)findSymbol("EVAL-COMPILED-SCRIPT", "ABCL-SCRIPT").getSymbolFunction();
/*  73 */     this.evalFunction = (Function)findSymbol("EVAL-FUNCTION", "ABCL-SCRIPT").getSymbolFunction();
/*     */   }
/*     */   private Function compileScript; Function evalCompiledScript;
/*     */   public Interpreter getInterpreter() {
/*  77 */     return this.interpreter;
/*     */   }
/*     */   
/*     */   public void setStandardInput(InputStream stream, LispThread thread) {
/*  81 */     thread.setSpecialVariable(Symbol.STANDARD_INPUT, (LispObject)new Stream(Symbol.SYSTEM_STREAM, stream, (LispObject)Symbol.CHARACTER, true));
/*     */   }
/*     */   
/*     */   public void setStandardInput(InputStream stream) {
/*  85 */     setStandardInput(stream, LispThread.currentThread());
/*     */   }
/*     */   
/*     */   public void setInterpreter(Interpreter interpreter) {
/*  89 */     this.interpreter = interpreter;
/*     */   }
/*     */   
/*     */   public static String escape(String s) {
/*  93 */     StringBuffer b = new StringBuffer();
/*  94 */     int len = s.length();
/*     */     
/*  96 */     for (int i = 0; i < len; i++) {
/*  97 */       char c = s.charAt(i);
/*  98 */       if (c == '\\' || c == '"') {
/*  99 */         b.append('\\');
/*     */       }
/* 101 */       b.append(c);
/*     */     } 
/* 103 */     return b.toString();
/*     */   }
/*     */   
/*     */   public LispObject loadFromClasspath(String classpathResource) {
/* 107 */     InputStream istream = getClass().getResourceAsStream(classpathResource);
/* 108 */     Stream stream = new Stream(Symbol.SYSTEM_STREAM, istream, (LispObject)Symbol.CHARACTER);
/* 109 */     return load(stream);
/*     */   }
/*     */   
/*     */   public LispObject load(Stream stream) {
/* 113 */     Symbol keyword_verbose = Lisp.internKeyword("VERBOSE");
/* 114 */     Symbol keyword_print = Lisp.internKeyword("PRINT");
/*     */ 
/*     */ 
/*     */ 
/*     */     
/* 119 */     return Symbol.LOAD.getSymbolFunction()
/* 120 */       .execute(new LispObject[] { (LispObject)stream, (LispObject)keyword_verbose, (LispObject)Lisp.NIL, (LispObject)keyword_print, (LispObject)Lisp.NIL, (LispObject)Keyword.IF_DOES_NOT_EXIST, (LispObject)Lisp.T, (LispObject)Keyword.EXTERNAL_FORMAT, (LispObject)Keyword.DEFAULT });
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public LispObject load(String filespec) {
/* 127 */     return load(filespec, true);
/*     */   }
/*     */   
/*     */   public LispObject load(String filespec, boolean compileIfNecessary) {
/* 131 */     if (isCompiled(filespec) || !compileIfNecessary) {
/* 132 */       return this.interpreter.eval("(load \"" + escape(filespec) + "\")");
/*     */     }
/* 134 */     return compileAndLoad(filespec);
/*     */   }
/*     */   
/*     */   public static boolean isCompiled(String filespec) {
/*     */     File source, compiled;
/* 139 */     String compiledExt = "." + Lisp._COMPILE_FILE_TYPE_.symbolValue().getStringValue();
/* 140 */     if (filespec.endsWith(compiledExt)) {
/* 141 */       return true;
/*     */     }
/*     */ 
/*     */     
/* 145 */     if (filespec.endsWith(".lisp")) {
/* 146 */       source = new File(filespec);
/* 147 */       compiled = new File(filespec.substring(0, filespec.length() - 5) + compiledExt);
/*     */     } else {
/*     */       
/* 150 */       source = new File(filespec + ".lisp");
/* 151 */       compiled = new File(filespec + compiledExt);
/*     */     } 
/* 153 */     if (!source.exists()) {
/* 154 */       throw new IllegalArgumentException("The source file " + filespec + " cannot be found");
/*     */     }
/* 156 */     return (compiled.exists() && compiled
/* 157 */       .lastModified() >= source.lastModified());
/*     */   }
/*     */   
/*     */   public LispObject compileFile(String filespec) {
/* 161 */     return this.interpreter.eval("(compile-file \"" + escape(filespec) + "\")");
/*     */   }
/*     */   
/*     */   public LispObject compileAndLoad(String filespec) {
/* 165 */     return this.interpreter.eval("(load (compile-file \"" + escape(filespec) + "\"))");
/*     */   }
/*     */   
/*     */   public static boolean functionp(LispObject obj) {
/* 169 */     return obj instanceof Function;
/*     */   }
/*     */   public JavaObject jsetq(String symbol, Object value) {
/*     */     JavaObject jo;
/* 173 */     Symbol s = findSymbol(symbol);
/*     */     
/* 175 */     if (value instanceof JavaObject) {
/* 176 */       jo = (JavaObject)value;
/*     */     } else {
/* 178 */       jo = new JavaObject(value);
/*     */     } 
/* 180 */     s.setSymbolValue((LispObject)jo);
/* 181 */     return jo;
/*     */   }
/*     */   
/*     */   public Symbol findSymbol(String name, String pkg) {
/* 185 */     Cons values = (Cons)this.interpreter.eval("(cl:multiple-value-list (find-symbol (symbol-name '#:" + 
/* 186 */         escape(name) + ")" + ((pkg == null) ? "" : (" :" + escape(pkg))) + "))");
/*     */     
/* 188 */     if (values.cadr() == Lisp.NIL) {
/* 189 */       return null;
/*     */     }
/* 191 */     return (Symbol)values.car();
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Symbol findSymbol(String name) {
/* 197 */     int i = name.indexOf(':');
/* 198 */     if (i < 0) {
/* 199 */       return findSymbol(name, (String)null);
/*     */     }
/* 201 */     if (i < name.length() - 1 && name.charAt(i + 1) == ':') {
/* 202 */       return findSymbol(name.substring(i + 2), name.substring(0, i));
/*     */     }
/* 204 */     return findSymbol(name.substring(i + 1), name.substring(0, i));
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   public Function findFunction(String name) {
/* 210 */     return (Function)this.interpreter.eval("#'" + name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Bindings createBindings() {
/* 215 */     return new SimpleBindings();
/*     */   }
/*     */   
/*     */   private static LispObject makeBindings(Bindings bindings) {
/* 219 */     if (bindings == null || bindings.size() == 0) {
/* 220 */       return (LispObject)Lisp.NIL;
/*     */     }
/* 222 */     LispObject[] argList = new LispObject[bindings.size()];
/* 223 */     int i = 0;
/* 224 */     for (Map.Entry<String, Object> entry : bindings.entrySet()) {
/* 225 */       argList[i++] = Symbol.CONS.execute((LispObject)new SimpleString(entry.getKey()), 
/* 226 */           JavaObject.getInstance(entry.getValue(), true));
/*     */     }
/* 228 */     return Symbol.LIST.getSymbolFunction().execute(argList);
/*     */   }
/*     */   
/*     */   Object eval(Function evaluator, LispObject code, ScriptContext ctx) throws ScriptException {
/* 232 */     LispObject retVal = null;
/* 233 */     Stream outStream = new Stream(Symbol.SYSTEM_STREAM, ctx.getWriter());
/* 234 */     Stream inStream = new Stream(Symbol.SYSTEM_STREAM, ctx.getReader());
/* 235 */     retVal = evaluator.execute(makeBindings(ctx.getBindings(200)), 
/* 236 */         makeBindings(ctx.getBindings(100)), (LispObject)inStream, (LispObject)outStream, code, (LispObject)new JavaObject(ctx));
/*     */ 
/*     */     
/* 239 */     return retVal.javaInstance();
/*     */   }
/*     */ 
/*     */   
/*     */   public Object eval(String code, ScriptContext ctx) throws ScriptException {
/* 244 */     return eval(this.evalScript, (LispObject)new SimpleString(code), ctx);
/*     */   }
/*     */   
/*     */   private static String toString(Reader reader) throws IOException {
/* 248 */     StringWriter w = new StringWriter();
/*     */     
/* 250 */     int i = reader.read();
/* 251 */     while (i != -1) {
/* 252 */       w.write(i);
/* 253 */       i = reader.read();
/*     */     } 
/* 255 */     return w.toString();
/*     */   }
/*     */ 
/*     */   
/*     */   public Object eval(Reader code, ScriptContext ctx) throws ScriptException {
/*     */     try {
/* 261 */       return eval(toString(code), ctx);
/* 262 */     } catch (IOException e) {
/* 263 */       return new ScriptException(e);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public ScriptEngineFactory getFactory() {
/* 269 */     return new AbclScriptEngineFactory();
/*     */   }
/*     */   
/*     */   public <T> T getInterface(Class<T> clasz) {
/*     */     try {
/* 274 */       return getInterface(eval("(cl:find-package '#:ABCL-SCRIPT-USER)"), clasz);
/* 275 */     } catch (ScriptException e) {
/* 276 */       throw new Error(e);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public <T> T getInterface(Object thiz, Class<T> clasz) {
/* 282 */     Symbol s = findSymbol("jmake-proxy", "JAVA");
/* 283 */     JavaObject iface = new JavaObject(clasz);
/* 284 */     return (T)((JavaObject)s.execute((LispObject)iface, (LispObject)thiz)).javaInstance();
/*     */   }
/*     */   
/*     */   public Object invokeFunction(String name, Object... args) throws ScriptException, NoSuchMethodException {
/*     */     Symbol s;
/* 289 */     if (name.indexOf(':') >= 0) {
/* 290 */       s = findSymbol(name);
/*     */     } else {
/* 292 */       s = findSymbol(name, "ABCL-SCRIPT-USER");
/*     */     } 
/* 294 */     if (s != null) {
/* 295 */       LispObject f = s.getSymbolFunction();
/* 296 */       if (f != null && f instanceof Function) {
/* 297 */         LispObject functionAndArgs = Lisp.NIL.push(f);
/* 298 */         for (int i = 0; i < args.length; i++) {
/* 299 */           functionAndArgs = functionAndArgs.push(JavaObject.getInstance(args[i], true));
/*     */         }
/* 301 */         functionAndArgs = functionAndArgs.reverse();
/* 302 */         return eval(this.evalFunction, functionAndArgs, getContext());
/*     */       } 
/* 304 */       throw new NoSuchMethodException(name);
/*     */     } 
/*     */     
/* 307 */     throw new NoSuchMethodException(name);
/*     */   }
/*     */ 
/*     */   
/*     */   public Object invokeMethod(Object thiz, String name, Object... args) throws ScriptException, NoSuchMethodException {
/* 312 */     throw new UnsupportedOperationException("Common Lisp does not have methods in the Java sense. Use invokeFunction instead.");
/*     */   }
/*     */   
/*     */   public class AbclCompiledScript
/*     */     extends CompiledScript {
/*     */     private LispObject function;
/*     */     
/*     */     public AbclCompiledScript(LispObject function) {
/* 320 */       this.function = function;
/*     */     }
/*     */ 
/*     */     
/*     */     public Object eval(ScriptContext context) throws ScriptException {
/* 325 */       return AbclScriptEngine.this.eval(AbclScriptEngine.this.evalCompiledScript, this.function, context);
/*     */     }
/*     */ 
/*     */     
/*     */     public ScriptEngine getEngine() {
/* 330 */       return AbclScriptEngine.this;
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */ 
/*     */   
/*     */   public CompiledScript compile(String script) throws ScriptException {
/*     */     try {
/* 339 */       Function f = (Function)this.compileScript.execute((LispObject)new SimpleString(script));
/* 340 */       return new AbclCompiledScript((LispObject)f);
/* 341 */     } catch (ClassCastException e) {
/* 342 */       throw new ScriptException(e);
/*     */     } 
/*     */   }
/*     */ 
/*     */   
/*     */   public CompiledScript compile(Reader script) throws ScriptException {
/*     */     try {
/* 349 */       return compile(toString(script));
/* 350 */     } catch (IOException e) {
/* 351 */       throw new ScriptException(e);
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/scripting/AbclScriptEngine.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */