/*     */ package org.armedbear.lisp;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStream;
/*     */ import java.io.InputStreamReader;
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
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
/*     */ public final class ShellCommand
/*     */   implements Runnable
/*     */ {
/*     */   private final String command;
/*     */   private final String directory;
/*     */   private final Stream outputStream;
/*     */   private final StringBuffer output;
/*  52 */   private int exitValue = -1;
/*     */ 
/*     */ 
/*     */   
/*     */   public ShellCommand(String command, String directory, Stream outputStream) {
/*  57 */     this.command = command;
/*  58 */     this.directory = directory;
/*  59 */     this.outputStream = outputStream;
/*  60 */     this.output = (outputStream == null) ? new StringBuffer() : null;
/*     */   }
/*     */ 
/*     */   
/*     */   public final String getOutput() {
/*  65 */     return (this.output != null) ? this.output.toString() : "";
/*     */   }
/*     */ 
/*     */   
/*     */   final int exitValue() {
/*  70 */     return this.exitValue;
/*     */   }
/*     */ 
/*     */   
/*     */   void processOutput(String s) {
/*  75 */     if (this.outputStream != null) {
/*  76 */       this.outputStream._writeString(s);
/*     */     } else {
/*  78 */       this.output.append(s);
/*     */     } 
/*     */   }
/*     */   
/*     */   public void run() {
/*  83 */     Process process = null;
/*     */     try {
/*  85 */       if (this.command != null) {
/*  86 */         if (Utilities.isPlatformUnix) {
/*  87 */           if (this.directory != null) {
/*  88 */             StringBuilder sb = new StringBuilder("\\cd \"");
/*  89 */             sb.append(this.directory);
/*  90 */             sb.append("\" && ");
/*  91 */             sb.append(this.command);
/*  92 */             String[] cmdarray = { "/bin/sh", "-c", sb.toString() };
/*  93 */             process = Runtime.getRuntime().exec(cmdarray);
/*     */           } else {
/*  95 */             String[] cmdarray = { "/bin/sh", "-c", this.command };
/*  96 */             process = Runtime.getRuntime().exec(cmdarray);
/*     */           } 
/*  98 */         } else if (Utilities.isPlatformWindows) {
/*  99 */           ArrayList<String> list = new ArrayList<>();
/* 100 */           list.add("cmd.exe");
/* 101 */           list.add("/c");
/* 102 */           if (this.directory != null) {
/* 103 */             StringBuilder sb = new StringBuilder("cd /d \"");
/* 104 */             sb.append(this.directory);
/* 105 */             sb.append("\" && ");
/* 106 */             sb.append(this.command);
/* 107 */             list.addAll(tokenize(sb.toString()));
/*     */           } else {
/* 109 */             list.addAll(tokenize(this.command));
/* 110 */           }  int size = list.size();
/* 111 */           String[] cmdarray = new String[size];
/* 112 */           for (int i = 0; i < size; i++)
/* 113 */             cmdarray[i] = list.get(i); 
/* 114 */           process = Runtime.getRuntime().exec(cmdarray);
/*     */         }
/*     */       
/*     */       }
/* 118 */     } catch (IOException e) {
/* 119 */       Debug.trace(e);
/*     */     } 
/* 121 */     if (process != null) {
/*     */       
/* 123 */       ReaderThread stdoutThread = new ReaderThread(process.getInputStream());
/* 124 */       stdoutThread.start();
/*     */       
/* 126 */       ReaderThread stderrThread = new ReaderThread(process.getErrorStream());
/* 127 */       stderrThread.start();
/*     */       try {
/* 129 */         this.exitValue = process.waitFor();
/*     */       }
/* 131 */       catch (InterruptedException e) {
/* 132 */         Debug.trace(e);
/*     */       } 
/*     */       try {
/* 135 */         stdoutThread.join();
/*     */       }
/* 137 */       catch (InterruptedException e) {
/* 138 */         Debug.trace(e);
/*     */       } 
/*     */       try {
/* 141 */         stderrThread.join();
/*     */       }
/* 143 */       catch (InterruptedException e) {
/* 144 */         Debug.trace(e);
/*     */       } 
/*     */     } 
/*     */   }
/*     */ 
/*     */ 
/*     */   
/*     */   private static List<String> tokenize(String s) {
/* 152 */     ArrayList<String> list = new ArrayList<>();
/* 153 */     StringBuffer sb = new StringBuffer();
/* 154 */     boolean inQuote = false;
/* 155 */     int limit = s.length();
/* 156 */     for (int i = 0; i < limit; i++) {
/* 157 */       char c = s.charAt(i);
/* 158 */       switch (c) {
/*     */         case ' ':
/* 160 */           if (inQuote) {
/* 161 */             sb.append(c); break;
/* 162 */           }  if (sb.length() > 0) {
/* 163 */             list.add(sb.toString());
/* 164 */             sb.setLength(0);
/*     */           } 
/*     */           break;
/*     */         case '"':
/* 168 */           if (inQuote) {
/* 169 */             if (sb.length() > 0) {
/* 170 */               list.add(sb.toString());
/* 171 */               sb.setLength(0);
/*     */             } 
/* 173 */             inQuote = false; break;
/*     */           } 
/* 175 */           inQuote = true;
/*     */           break;
/*     */         default:
/* 178 */           sb.append(c);
/*     */           break;
/*     */       } 
/*     */     } 
/* 182 */     if (sb.length() > 0)
/* 183 */       list.add(sb.toString()); 
/* 184 */     return list;
/*     */   }
/*     */   
/*     */   private class ReaderThread
/*     */     extends Thread {
/* 189 */     private char[] buf = new char[4096];
/*     */     
/*     */     private final InputStream inputStream;
/*     */     private final BufferedReader reader;
/*     */     private boolean done = false;
/*     */     
/*     */     public ReaderThread(InputStream inputStream) {
/* 196 */       this.inputStream = inputStream;
/* 197 */       this.reader = new BufferedReader(new InputStreamReader(inputStream));
/*     */     }
/*     */ 
/*     */ 
/*     */     
/*     */     public void run() {
/* 203 */       while (!this.done) {
/* 204 */         String s = read();
/* 205 */         if (s == null)
/*     */           return; 
/* 207 */         ShellCommand.this.processOutput(s);
/*     */       } 
/*     */     }
/*     */ 
/*     */     
/*     */     private String read() {
/* 213 */       StringBuffer sb = new StringBuffer();
/*     */       try {
/*     */         do {
/* 216 */           int numChars = this.reader.read(this.buf, 0, this.buf.length);
/* 217 */           if (numChars < 0) {
/* 218 */             this.done = true;
/*     */             break;
/*     */           } 
/* 221 */           if (numChars > 0)
/* 222 */             sb.append(this.buf, 0, numChars); 
/* 223 */           Thread.sleep(10L);
/* 224 */         } while (this.reader.ready());
/*     */       }
/* 226 */       catch (IOException e) {
/* 227 */         return null;
/*     */       }
/* 229 */       catch (InterruptedException e) {
/* 230 */         return null;
/*     */       } 
/* 232 */       return sb.toString();
/*     */     }
/*     */   }
/*     */ 
/*     */ 
/*     */   
/* 238 */   private static final Primitive _RUN_SHELL_COMMAND = new pf_run_shell_command();
/*     */   
/*     */   private static class pf_run_shell_command extends Primitive { pf_run_shell_command() {
/* 241 */       super("%run-shell-command", Lisp.PACKAGE_SYS, false, "command directory output => exit-code");
/*     */     }
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */ 
/*     */     
/*     */     public LispObject execute(LispObject first, LispObject second, LispObject third) {
/* 250 */       if (!Utilities.isPlatformUnix && !Utilities.isPlatformWindows) {
/* 251 */         return Lisp.error(new LispError("run-shell-command not implemented for " + 
/* 252 */               System.getProperty("os.name")));
/*     */       }
/*     */       
/* 255 */       String command = first.getStringValue();
/* 256 */       String namestring = null;
/* 257 */       Stream outputStream = null;
/* 258 */       if (second != Lisp.NIL) {
/* 259 */         Pathname pathname = Lisp.coerceToPathname(second);
/* 260 */         namestring = pathname.getNamestring();
/* 261 */         if (namestring == null) {
/* 262 */           return Lisp.error(new FileError("Pathname has no namestring: " + pathname.princToString(), pathname));
/*     */         }
/*     */       } 
/*     */       
/* 266 */       if (third != Lisp.NIL)
/* 267 */         outputStream = Lisp.checkStream(third); 
/* 268 */       ShellCommand shellCommand = new ShellCommand(command, namestring, outputStream);
/*     */       
/* 270 */       shellCommand.run();
/* 271 */       if (outputStream != null)
/* 272 */         outputStream._finishOutput(); 
/* 273 */       return Lisp.number(shellCommand.exitValue());
/*     */     } }
/*     */ 
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/ShellCommand.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */