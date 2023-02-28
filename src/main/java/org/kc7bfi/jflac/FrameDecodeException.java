/*
 * Created on Jun 30, 2004
 *
 * To change the template for this generated file go to
 * Window - Preferences - Java - Code Generation - Code and Comments
 */
package org.kc7bfi.jflac;


/**
 * @author kc7bfi
 *
 * To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Generation - Code and Comments
 */
public class FrameDecodeException extends Exception {

    /**
     * Constructor.
     */
    public FrameDecodeException() {
        super();
    }

    /**
     * Constructor.
     * @param msg Error message
     */
    public FrameDecodeException(String msg) {
        super(msg);
    }

    /**
     * Constructor.
     * @param err The causing error
     */
    public FrameDecodeException(Throwable err) {
        super(err);
    }

    /**
     * Constructor.
     * @param msg The error message
     * @param err The causing error
     */
    public FrameDecodeException(String msg, Throwable err) {
        super(msg, err);
    }

}
