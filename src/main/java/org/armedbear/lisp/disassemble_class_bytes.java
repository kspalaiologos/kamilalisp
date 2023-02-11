/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.FileOutputStream;
/*    */ import java.io.IOException;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public final class disassemble_class_bytes
/*    */   extends Primitive
/*    */ {
/*    */   private disassemble_class_bytes() {
/* 47 */     super("disassemble-class-bytes", Lisp.PACKAGE_SYS, true, "java-object");
/*    */   }
/*    */ 
/*    */ 
/*    */   
/*    */   public LispObject execute(LispObject arg) {
/* 53 */     if (arg instanceof JavaObject) {
/* 54 */       byte[] bytes = (byte[])((JavaObject)arg).getObject();
/*    */       try {
/* 56 */         File file = File.createTempFile("abcl", ".class", null);
/* 57 */         FileOutputStream out = new FileOutputStream(file);
/* 58 */         out.write(bytes);
/* 59 */         out.close();
/* 60 */         LispObject disassembler = Lisp._DISASSEMBLER_.symbolValue();
/* 61 */         StringBuffer command = new StringBuffer();
/* 62 */         if (disassembler instanceof AbstractString) {
/* 63 */           command.append(disassembler.getStringValue());
/* 64 */           command.append(" ");
/* 65 */           command.append(file.getPath());
/* 66 */         } else if (disassembler instanceof Operator) {
/* 67 */           Pathname p = Pathname.makePathname(file);
/* 68 */           LispObject commandResult = disassembler.execute(p);
/* 69 */           command.append(commandResult.getStringValue());
/*    */         } else {
/* 71 */           return new SimpleString("No disassembler is available.");
/*    */         } 
/* 73 */         ShellCommand sc = new ShellCommand(command.toString(), null, null);
/* 74 */         sc.run();
/* 75 */         file.delete();
/* 76 */         return new SimpleString(sc.getOutput());
/* 77 */       } catch (IOException e) {
/* 78 */         Debug.trace(e);
/*    */       } 
/*    */     } 
/* 81 */     return Lisp.NIL;
/*    */   }
/*    */   
/* 84 */   private static final Primitive DISASSEMBLE_CLASS_BYTES = new disassemble_class_bytes();
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/disassemble_class_bytes.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */