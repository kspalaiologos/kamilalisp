/*    */ package org.armedbear.lisp;
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
/*    */ public final class SlotDefinitionClass
/*    */   extends StandardClass
/*    */ {
/*    */   public SlotDefinitionClass(Symbol symbol, LispObject cpl) {
/* 41 */     super(symbol, cpl);
/* 42 */     LispObject[] instanceSlotNames = { Symbol.NAME, Symbol.INITFUNCTION, Symbol.INITFORM, Symbol.INITARGS, Symbol.READERS, Symbol.WRITERS, Symbol.ALLOCATION, Symbol.ALLOCATION_CLASS, Symbol.LOCATION, Symbol._TYPE, Symbol._DOCUMENTATION };
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
/* 55 */     setClassLayout(new Layout(this, instanceSlotNames, Lisp.NIL));
/*    */     
/* 57 */     LispObject slotDefinitions = Lisp.NIL;
/* 58 */     for (int i = instanceSlotNames.length - 1; i >= 0; i--) {
/* 59 */       slotDefinitions = slotDefinitions.push(new SlotDefinition(this, instanceSlotNames[i]));
/*    */     }
/*    */ 
/*    */ 
/*    */ 
/*    */     
/* 65 */     StandardObject locationSlot = checkSlotDefinition(slotDefinitions.nthcdr(8).car());
/* 66 */     locationSlot.setInstanceSlotValue(Symbol.INITFORM, Lisp.NIL);
/* 67 */     locationSlot.setInstanceSlotValue(Symbol.INITFUNCTION, StandardClass.constantlyNil);
/*    */ 
/*    */     
/* 70 */     StandardObject typeSlot = checkSlotDefinition(slotDefinitions.nthcdr(9).car());
/* 71 */     typeSlot.setInstanceSlotValue(Symbol.INITARGS, Lisp.list(Lisp.internKeyword("TYPE"), new LispObject[0]));
/*    */     
/* 73 */     StandardObject documentationSlot = checkSlotDefinition(slotDefinitions.nthcdr(10).car());
/* 74 */     documentationSlot.setInstanceSlotValue(Symbol.INITARGS, Lisp.list(Lisp.internKeyword("DOCUMENTATION"), new LispObject[0]));
/* 75 */     setDirectSlotDefinitions(slotDefinitions);
/* 76 */     setSlotDefinitions(slotDefinitions);
/* 77 */     setFinalized(true);
/*    */   }
/*    */   
/*    */   private static StandardObject checkSlotDefinition(LispObject obj) {
/* 81 */     if (obj instanceof StandardObject) return (StandardObject)obj; 
/* 82 */     return (StandardObject)Lisp.type_error(obj, Symbol.SLOT_DEFINITION);
/*    */   }
/*    */ }


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/SlotDefinitionClass.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */