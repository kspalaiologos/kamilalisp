/*    */ package org.armedbear.lisp;
/*    */ 
/*    */ import java.lang.reflect.Array;
/*    */ import java.util.Arrays;
/*    */ import java.util.HashMap;
/*    */ import java.util.Iterator;
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ 
/*    */ public class CharHashMap<T>
/*    */ {
/*    */   public final T[] constants;
/*    */   public final T NULL;
/*    */   static final int CACHE_SIZE = 256;
/*    */   final HashMap<Character, T> backing;
/*    */   
/*    */   public CharHashMap(Class<?> componentType, T def) {
/* 22 */     this.NULL = def;
/* 23 */     this.constants = (T[])Array.newInstance(componentType, 256);
/* 24 */     Arrays.fill((Object[])this.constants, this.NULL);
/* 25 */     this.backing = new HashMap<>();
/*    */   }
/*    */ 
/*    */   
/*    */   public Object clone() {
/* 30 */     CharHashMap<T> n = new CharHashMap(this.constants.getClass().getComponentType(), this.NULL);
/* 31 */     System.arraycopy(this.constants, 0, n.constants, 0, 256);
/* 32 */     n.backing.putAll(this.backing);
/* 33 */     return n;
/*    */   }
/*    */   
/*    */   public T get(char key) {
/* 37 */     if (key < 'Ā') return this.constants[key]; 
/* 38 */     T value = this.backing.get(Character.valueOf(key));
/* 39 */     return (value == null) ? this.NULL : value;
/*    */   }
/*    */   
/*    */   public void clear() {
/* 43 */     Arrays.fill((Object[])this.constants, this.NULL);
/* 44 */     this.backing.clear();
/*    */   }
/*    */   
/*    */   public T put(char key, T value) {
/* 48 */     if (key < 'Ā') {
/* 49 */       T old = this.constants[key];
/* 50 */       this.constants[key] = value;
/* 51 */       return old;
/*    */     } 
/* 53 */     return this.backing.put(Character.valueOf(key), value);
/*    */   }
/*    */   
/*    */   public Iterator<Character> getCharIterator() {
/* 57 */     return new Iterator<Character>() {
/* 58 */         final Iterator<Character> carIt = CharHashMap.this.backing.keySet().iterator();
/* 59 */         int charNum = -1;
/*    */         public boolean hasNext() {
/* 61 */           if (this.charNum < 256) return true; 
/* 62 */           return this.carIt.hasNext();
/*    */         }
/*    */         public Character next() {
/* 65 */           if (this.charNum < 256) return Character.valueOf((char)++this.charNum); 
/* 66 */           return this.carIt.next();
/*    */         }
/*    */         public void remove() {
/* 69 */           throw new UnsupportedOperationException();
/*    */         }
/*    */       };
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/CharHashMap.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */