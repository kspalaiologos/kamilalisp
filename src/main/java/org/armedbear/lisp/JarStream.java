/*
 * JarStream.java
 *
 * Copyright (C) 2010 Mark Evenson
 * $Id$
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 * As a special exception, the copyright holders of this library give you
 * permission to link this library with independent modules to produce an
 * executable, regardless of the license terms of these independent
 * modules, and to copy and distribute the resulting executable under
 * terms of your choice, provided that you also meet, for each linked
 * independent module, the terms and conditions of the license of that
 * module.  An independent module is a module which is not derived from
 * or based on this library.  If you modify this library, you may extend
 * this exception to your version of the library, but you are not
 * obligated to do so.  If you do not wish to do so, delete this
 * exception statement from your version.
 */

package org.armedbear.lisp;

import static org.armedbear.lisp.Lisp.*;

import java.io.File;
import java.io.InputStream;
import java.io.Reader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;

/** 
 * Stream interface for an entry in a jar pathname.
 * 
 * This only supports reading from the stream.
 */
public final class JarStream extends Stream
{
    private final Pathname pathname;
    private final InputStream input;
    private final Reader reader;
    private final int bytesPerUnit;

    public JarStream(Pathname pathname, 
                     LispObject elementType, LispObject direction,
                     LispObject ifExists, LispObject format)
        throws IOException
    {
        super(Symbol.JAR_STREAM);
        Debug.assertTrue(direction == Keyword.INPUT);
        Debug.assertTrue(pathname.getName() != NIL);
        isInputStream = true;

        super.setExternalFormat(format);
        
        this.pathname = pathname;
        this.elementType = elementType;

        this.input = pathname.getInputStream();
        if (elementType == Symbol.CHARACTER || elementType == Symbol.BASE_CHAR) {
            isCharacterStream = true;
            bytesPerUnit = 1;
            InputStreamReader isr = new InputStreamReader(input);
            this.reader = (Reader) new BufferedReader(isr);
            reader.mark(10 * 1024 * 1024);
            initAsCharacterInputStream(this.reader);
        } else {
            this.input.mark(10 * 1024 * 1024);
            isBinaryStream = true;
            int width = Fixnum.getValue(elementType.cadr());
            bytesPerUnit = width / 8;
            this.reader = null;
            initAsBinaryInputStream(this.input);
        }
    }

    @Override
    public LispObject typeOf()
    {
        return Symbol.JAR_STREAM;
    }

    @Override
    public LispObject classOf()
    {
        return BuiltInClass.JAR_STREAM;
    }

    @Override
    public LispObject typep(LispObject typeSpecifier)
    {
        if (typeSpecifier == Symbol.JAR_STREAM)
            return T;
        if (typeSpecifier == BuiltInClass.JAR_STREAM)
            return T;
        return super.typep(typeSpecifier);
    }

    @Override
    public void setExternalFormat(LispObject format) {
        super.setExternalFormat(format);
    }

    public Pathname getPathname()
    {
        return pathname;
    }

    @Override
    public void _close()
    {
        try {
            if (input != null) {
                input.close();
            }
            if (reader != null) {
                reader.close();
            }
            setOpen(false);
        }
        catch (IOException e) {
            System.err.println("For file " + pathname.getNamestring());
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    protected boolean _setFilePosition(LispObject arg)
    {
        try {
            if(isBinaryStream) {
                input.reset();
                long pos = 0;
                if (arg == Keyword.START)
                    pos = 0;
                else if (arg instanceof Fixnum)
                    pos = ((Fixnum) arg).value * bytesPerUnit;
                else if (arg instanceof Bignum)
                    pos = ((Bignum) arg).longValue() * bytesPerUnit;
                else
                    type_error(arg, Symbol.INTEGER);
                input.skip(pos);
            } else {
                reader.reset();
                long pos = 0;
                if (arg == Keyword.START)
                    pos = 0;
                else if (arg instanceof Fixnum)
                    pos = ((Fixnum) arg).value * bytesPerUnit;
                else if (arg instanceof Bignum)
                    pos = arg.longValue() * bytesPerUnit;
                else
                    type_error(arg, Symbol.INTEGER);
                reader.skip(pos);
            }
        }
        catch (IOException e) {
            System.err.println("For file " + pathname.getNamestring());
            throw new RuntimeException(e.getMessage());
        }
        return true;
    }

    @Override
    public String printObject()
    {
        StringBuffer sb = new StringBuffer();
        sb.append(Symbol.JAR_STREAM.princToString());
        String namestring = pathname.getNamestring();
        if (namestring != null) {
            sb.append(" ");
            sb.append(namestring);
        }
        return unreadableString(sb.toString());
    }
}
