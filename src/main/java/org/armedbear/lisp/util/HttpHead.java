/*     */ package org.armedbear.lisp.util;
/*     */ 
/*     */ import java.io.BufferedReader;
/*     */ import java.io.IOException;
/*     */ import java.io.InputStreamReader;
/*     */ import java.io.OutputStreamWriter;
/*     */ import java.io.PrintWriter;
/*     */ import java.net.MalformedURLException;
/*     */ import java.net.Socket;
/*     */ import java.net.URL;
/*     */ import org.armedbear.lisp.Debug;
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
/*     */ public class HttpHead
/*     */ {
/*     */   public static String get(String urlString, String key) throws IOException {
/*  53 */     URL url = null;
/*     */     try {
/*  55 */       url = new URL(urlString);
/*  56 */     } catch (MalformedURLException e) {
/*  57 */       log("Failed to form url from '" + urlString + "': " + e);
/*     */     } 
/*  59 */     return get(url, key);
/*     */   }
/*     */   
/*     */   public static String get(URL url, String key) throws IOException {
/*  63 */     Socket socket = null;
/*  64 */     String result = null;
/*     */     try {
/*  66 */       String protocol = url.getProtocol();
/*  67 */       if (!protocol.equals("http")) {
/*  68 */         log("The protocol '" + protocol + "' is not http.");
/*  69 */         return result;
/*     */       } 
/*  71 */       String host = url.getHost();
/*  72 */       int port = url.getPort();
/*  73 */       if (port == -1) {
/*  74 */         port = 80;
/*     */       }
/*  76 */       socket = new Socket(host, port);
/*     */       
/*  78 */       PrintWriter out = null;
/*  79 */       BufferedReader in = null;
/*     */       try {
/*  81 */         socket.setSoTimeout(5000);
/*  82 */         out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);
/*  83 */         in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
/*  84 */       } catch (IOException e) {
/*  85 */         log("Failed to establish socket io: " + e);
/*  86 */         return result;
/*     */       } 
/*     */       
/*  89 */       String CRLF = "\r\n";
/*  90 */       String head = "HEAD " + url.getPath() + " HTTP/1.1";
/*  91 */       out.print(head + CRLF);
/*  92 */       out.print("Host: " + url.getAuthority() + CRLF);
/*  93 */       out.print("Connection: close" + CRLF);
/*  94 */       out.print(CRLF);
/*  95 */       out.flush();
/*     */       
/*  97 */       String line = null;
/*     */       try {
/*  99 */         line = in.readLine();
/* 100 */       } catch (IOException e) {
/* 101 */         log("Failed to read HTTP response: " + e);
/*     */       } 
/* 103 */       if (line == null) {
/* 104 */         throw new IOException("Could not access URL to parse headers.");
/*     */       }
/* 106 */       String[] status = line.split("\\s");
/* 107 */       if (status[1].equals("200")) {
/* 108 */         result = findHeader(in, key);
/* 109 */       } else if (status[1].startsWith("3")) {
/*     */         
/* 111 */         String location = findHeader(in, "Location");
/* 112 */         if (location != null) {
/* 113 */           return get(location, key);
/*     */         }
/*     */       } else {
/* 116 */         log("Unexpected response: " + line);
/*     */       } 
/*     */     } finally {
/*     */       try {
/* 120 */         socket.close();
/* 121 */       } catch (IOException iOException) {}
/*     */     } 
/*     */     
/* 124 */     return result;
/*     */   }
/*     */   
/*     */   private static String findHeader(BufferedReader in, String key) {
/* 128 */     String result = null;
/*     */     try {
/*     */       String line;
/* 131 */       while ((line = in.readLine()) != null) {
/* 132 */         int i = line.indexOf(":");
/* 133 */         if (i == -1) {
/*     */           continue;
/*     */         }
/* 136 */         String k = line.substring(0, i);
/* 137 */         String v = line.substring(i + 1).trim();
/* 138 */         if (k.equals(key)) {
/* 139 */           result = v;
/*     */           break;
/*     */         } 
/*     */       } 
/* 143 */     } catch (IOException e) {
/* 144 */       log("Failed to read headers: " + e);
/*     */     } 
/* 146 */     return result;
/*     */   }
/*     */   
/*     */   private static void log(String message) {
/* 150 */     Debug.warn(message);
/*     */   }
/*     */   
/*     */   public static void main(String[] argv) {
/* 154 */     if (argv.length != 1) {
/* 155 */       System.out.println("Usage: <cmd> URL");
/*     */       return;
/*     */     } 
/* 158 */     String modified = null;
/*     */     try {
/* 160 */       modified = get(argv[0], "Last-Modified");
/* 161 */     } catch (IOException ex) {
/* 162 */       System.err.println("Unable to get Last-Modified header: ");
/* 163 */       ex.printStackTrace(System.err);
/*     */     } 
/* 165 */     if (modified != null) {
/* 166 */       System.out.println("Last-Modified: " + modified);
/*     */     } else {
/* 168 */       System.out.println("No result returned.");
/*     */     } 
/*     */   }
/*     */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/util/HttpHead.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */