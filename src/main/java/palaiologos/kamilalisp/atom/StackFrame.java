package palaiologos.kamilalisp.atom;

import palaiologos.kamilalisp.runtime.Dfn;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Stack;

public class StackFrame {
    public static class StackFrameEntry {
        public String frameString;
        public long line, col;

        public StackFrameEntry(String frameString, long line, long col) {
            this.frameString = frameString;
            this.line = line;
            this.col = col;
        }
    }

    private static final ThreadLocal<Stack<StackFrameEntry>> stack = ThreadLocal.withInitial(Stack::new);
    private static final ThreadLocal<Stack<Dfn.DfnClass>> lambdaStack = ThreadLocal.withInitial(Stack::new);

    public static boolean isDeBruijnAllowed(int index) {
        return lambdaStack.get().size() > index;
    }

    public static int currentLambdaIdx() {
        return lambdaStack.get().size() - 1;
    }

    public static void pushLambda(Dfn.DfnClass lambda) {
        lambdaStack.get().push(lambda);
    }

    public static void popLambda() {
        lambdaStack.get().pop();
    }

    public static Dfn.DfnClass lambdaDeBruijn(int x) {
        return lambdaStack.get().get(lambdaStack.get().size() - x - 1);
    }

    public static void push(Callable c) {
        if (c.line() < 0 || c.column() < 0) {
            throw new RuntimeException("Cannot push a callable with negative line or column marker.");
        }

        stack.get().push(new StackFrameEntry(c.frameString(), c.line(), c.column()));
    }

    public static void push(CodeAtom c) {
        if (c.getLine() < 0 || c.getCol() < 0) {
            throw new RuntimeException("Cannot push a code atom with negative line or column marker.");
        }

        stack.get().push(new StackFrameEntry("entity " + c.shortString(), c.getLine(), c.getCol()));
    }

    public static void pop() {
        stack.get().pop();
    }

    public static String stackTrace(Throwable t) {
        StringBuilder sb = new StringBuilder();
        String exceptionName = t.getClass().getSimpleName();
        exceptionName = exceptionName.substring(exceptionName.lastIndexOf('.') + 1);
        sb.append(exceptionName).append(" thrown in thread ").append(Long.toHexString(Thread.currentThread().hashCode())).append(": ").append(t.getMessage()).append("\n");
        for (StackFrameEntry e : stack.get()) {
            if (e.col == 0 || e.line == 0) {
                sb.append("    at ").append(e.frameString).append("\n");
            } else {
                sb.append("    at ").append(e.frameString).append("  ").append(e.line).append(":").append(e.col).append("\n");
            }
        }

        String isDebug = System.getenv("DEBUG");
        if (isDebug != null && isDebug.equals("true")) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            sb.append(sw);
            return sb.toString();
        } else {
            return sb.toString();
        }
    }

    public static void wipe() {
        stack.remove();
    }

    public static int depth() {
        return stack.get().size();
    }
}
