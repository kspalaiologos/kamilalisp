package org.armedbear.lisp.protocol;

import org.armedbear.lisp.LispObject;

public interface Hashtable extends LispObject {
  LispObject getEntries();
  
  @Deprecated
  LispObject ENTRIES();
}


/* Location:              /home/palaiologos/Desktop/abcl.jar!/org/armedbear/lisp/protocol/Hashtable.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.1.3
 */