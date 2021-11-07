// Generated from /home/palaiologos/Desktop/kamilalisp/src/kamilalisp/reader/Grammar.g4 by ANTLR 4.9.1
package kamilalisp.reader;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class GrammarLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.1", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, STRING=9, 
		FLOAT=10, HEX=11, BIN=12, LONG=13, NIL=14, NAME=15, TRASH=16;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "STRING", 
			"FLOAT", "FLOAT_TAIL", "FLOAT_DECIMAL", "FLOAT_EXP", "HEXD", "HEX", "BIN", 
			"LONG", "NIL", "NOTID", "NOTID_START", "NAME", "WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'@'", "'('", "')'", "'['", "']'", "'''", "'#'", "'$'", null, null, 
			null, null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, "STRING", "FLOAT", 
			"HEX", "BIN", "LONG", "NIL", "NAME", "TRASH"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


	public GrammarLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Grammar.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\22\u00b6\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t"+
		"\3\n\3\n\3\n\3\n\7\nH\n\n\f\n\16\nK\13\n\3\n\3\n\3\13\5\13P\n\13\3\13"+
		"\6\13S\n\13\r\13\16\13T\3\13\3\13\5\13Y\n\13\3\13\3\13\3\13\3\13\3\13"+
		"\3\13\3\13\3\13\3\13\5\13d\n\13\3\13\3\13\3\13\5\13i\n\13\3\f\3\f\3\f"+
		"\3\f\3\f\5\fp\n\f\3\r\3\r\6\rt\n\r\r\r\16\ru\3\16\3\16\5\16z\n\16\3\16"+
		"\6\16}\n\16\r\16\16\16~\3\17\3\17\3\20\3\20\3\20\6\20\u0086\n\20\r\20"+
		"\16\20\u0087\3\21\3\21\3\21\6\21\u008d\n\21\r\21\16\21\u008e\3\22\5\22"+
		"\u0092\n\22\3\22\6\22\u0095\n\22\r\22\16\22\u0096\3\23\3\23\3\23\3\23"+
		"\3\24\3\24\3\25\3\25\3\26\3\26\7\26\u00a3\n\26\f\26\16\26\u00a6\13\26"+
		"\3\27\3\27\3\30\3\30\7\30\u00ac\n\30\f\30\16\30\u00af\13\30\3\31\3\31"+
		"\5\31\u00b3\n\31\3\31\3\31\2\2\32\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23"+
		"\13\25\f\27\2\31\2\33\2\35\2\37\r!\16#\17%\20\'\2)\2+\21-\2/\2\61\22\3"+
		"\2\r\3\2$$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2ZZzz\4\2DDdd\3\2\62\63\n\2\f"+
		"\f\17\17\"\"*+==BB]]__\13\2\f\f\17\17\"\"%&)+==BB]]__\6\2\13\f\17\17\""+
		"\"..\4\2\f\f\17\17\2\u00c1\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2"+
		"\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2"+
		"\25\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2+\3\2\2\2\2"+
		"\61\3\2\2\2\3\63\3\2\2\2\5\65\3\2\2\2\7\67\3\2\2\2\t9\3\2\2\2\13;\3\2"+
		"\2\2\r=\3\2\2\2\17?\3\2\2\2\21A\3\2\2\2\23C\3\2\2\2\25h\3\2\2\2\27o\3"+
		"\2\2\2\31q\3\2\2\2\33w\3\2\2\2\35\u0080\3\2\2\2\37\u0082\3\2\2\2!\u0089"+
		"\3\2\2\2#\u0091\3\2\2\2%\u0098\3\2\2\2\'\u009c\3\2\2\2)\u009e\3\2\2\2"+
		"+\u00a0\3\2\2\2-\u00a7\3\2\2\2/\u00a9\3\2\2\2\61\u00b2\3\2\2\2\63\64\7"+
		"B\2\2\64\4\3\2\2\2\65\66\7*\2\2\66\6\3\2\2\2\678\7+\2\28\b\3\2\2\29:\7"+
		"]\2\2:\n\3\2\2\2;<\7_\2\2<\f\3\2\2\2=>\7)\2\2>\16\3\2\2\2?@\7%\2\2@\20"+
		"\3\2\2\2AB\7&\2\2B\22\3\2\2\2CI\7$\2\2DH\n\2\2\2EF\7^\2\2FH\7$\2\2GD\3"+
		"\2\2\2GE\3\2\2\2HK\3\2\2\2IG\3\2\2\2IJ\3\2\2\2JL\3\2\2\2KI\3\2\2\2LM\7"+
		"$\2\2M\24\3\2\2\2NP\7/\2\2ON\3\2\2\2OP\3\2\2\2PR\3\2\2\2QS\t\3\2\2RQ\3"+
		"\2\2\2ST\3\2\2\2TR\3\2\2\2TU\3\2\2\2UV\3\2\2\2Vi\5\27\f\2WY\7/\2\2XW\3"+
		"\2\2\2XY\3\2\2\2YZ\3\2\2\2Z[\7K\2\2[\\\7p\2\2\\]\7h\2\2]^\7k\2\2^_\7p"+
		"\2\2_`\7k\2\2`a\7v\2\2ai\7{\2\2bd\7/\2\2cb\3\2\2\2cd\3\2\2\2de\3\2\2\2"+
		"ef\7P\2\2fg\7c\2\2gi\7P\2\2hO\3\2\2\2hX\3\2\2\2hc\3\2\2\2i\26\3\2\2\2"+
		"jk\5\31\r\2kl\5\33\16\2lp\3\2\2\2mp\5\31\r\2np\5\33\16\2oj\3\2\2\2om\3"+
		"\2\2\2on\3\2\2\2p\30\3\2\2\2qs\7\60\2\2rt\t\3\2\2sr\3\2\2\2tu\3\2\2\2"+
		"us\3\2\2\2uv\3\2\2\2v\32\3\2\2\2wy\t\4\2\2xz\7/\2\2yx\3\2\2\2yz\3\2\2"+
		"\2z|\3\2\2\2{}\t\3\2\2|{\3\2\2\2}~\3\2\2\2~|\3\2\2\2~\177\3\2\2\2\177"+
		"\34\3\2\2\2\u0080\u0081\t\5\2\2\u0081\36\3\2\2\2\u0082\u0083\7\62\2\2"+
		"\u0083\u0085\t\6\2\2\u0084\u0086\5\35\17\2\u0085\u0084\3\2\2\2\u0086\u0087"+
		"\3\2\2\2\u0087\u0085\3\2\2\2\u0087\u0088\3\2\2\2\u0088 \3\2\2\2\u0089"+
		"\u008a\7\62\2\2\u008a\u008c\t\7\2\2\u008b\u008d\t\b\2\2\u008c\u008b\3"+
		"\2\2\2\u008d\u008e\3\2\2\2\u008e\u008c\3\2\2\2\u008e\u008f\3\2\2\2\u008f"+
		"\"\3\2\2\2\u0090\u0092\7/\2\2\u0091\u0090\3\2\2\2\u0091\u0092\3\2\2\2"+
		"\u0092\u0094\3\2\2\2\u0093\u0095\t\3\2\2\u0094\u0093\3\2\2\2\u0095\u0096"+
		"\3\2\2\2\u0096\u0094\3\2\2\2\u0096\u0097\3\2\2\2\u0097$\3\2\2\2\u0098"+
		"\u0099\7p\2\2\u0099\u009a\7k\2\2\u009a\u009b\7n\2\2\u009b&\3\2\2\2\u009c"+
		"\u009d\n\t\2\2\u009d(\3\2\2\2\u009e\u009f\n\n\2\2\u009f*\3\2\2\2\u00a0"+
		"\u00a4\5)\25\2\u00a1\u00a3\5\'\24\2\u00a2\u00a1\3\2\2\2\u00a3\u00a6\3"+
		"\2\2\2\u00a4\u00a2\3\2\2\2\u00a4\u00a5\3\2\2\2\u00a5,\3\2\2\2\u00a6\u00a4"+
		"\3\2\2\2\u00a7\u00a8\t\13\2\2\u00a8.\3\2\2\2\u00a9\u00ad\7=\2\2\u00aa"+
		"\u00ac\n\f\2\2\u00ab\u00aa\3\2\2\2\u00ac\u00af\3\2\2\2\u00ad\u00ab\3\2"+
		"\2\2\u00ad\u00ae\3\2\2\2\u00ae\60\3\2\2\2\u00af\u00ad\3\2\2\2\u00b0\u00b3"+
		"\5-\27\2\u00b1\u00b3\5/\30\2\u00b2\u00b0\3\2\2\2\u00b2\u00b1\3\2\2\2\u00b3"+
		"\u00b4\3\2\2\2\u00b4\u00b5\b\31\2\2\u00b5\62\3\2\2\2\25\2GIOTXchouy~\u0087"+
		"\u008e\u0091\u0096\u00a4\u00ad\u00b2\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}