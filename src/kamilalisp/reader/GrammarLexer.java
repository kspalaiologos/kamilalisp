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
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, STRING=7, FLOAT=8, HEX=9, 
		BIN=10, LONG=11, NIL=12, SYMBOL=13, TRASH=14;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "STRING", "FLOAT", "FLOAT_TAIL", 
			"FLOAT_DECIMAL", "FLOAT_EXP", "HEXD", "HEX", "BIN", "LONG", "NIL", "SYMBOL", 
			"NAME", "WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'('", "')'", "'['", "']'", "'''", "'#'", null, null, null, null, 
			null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, "STRING", "FLOAT", "HEX", "BIN", 
			"LONG", "NIL", "SYMBOL", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\20\u00aa\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\3\2\3\2\3\3\3\3\3\4\3\4"+
		"\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\b\7\b>\n\b\f\b\16\bA\13\b\3\b\3"+
		"\b\3\t\5\tF\n\t\3\t\6\tI\n\t\r\t\16\tJ\3\t\3\t\5\tO\n\t\3\t\3\t\3\t\3"+
		"\t\3\t\3\t\3\t\3\t\3\t\5\tZ\n\t\3\t\3\t\3\t\5\t_\n\t\3\n\3\n\3\n\3\n\3"+
		"\n\5\nf\n\n\3\13\3\13\6\13j\n\13\r\13\16\13k\3\f\3\f\5\fp\n\f\3\f\6\f"+
		"s\n\f\r\f\16\ft\3\r\3\r\3\16\3\16\3\16\6\16|\n\16\r\16\16\16}\3\17\3\17"+
		"\3\17\6\17\u0083\n\17\r\17\16\17\u0084\3\20\5\20\u0088\n\20\3\20\6\20"+
		"\u008b\n\20\r\20\16\20\u008c\3\21\3\21\3\21\3\21\3\22\3\22\5\22\u0095"+
		"\n\22\3\23\6\23\u0098\n\23\r\23\16\23\u0099\3\24\3\24\3\25\3\25\7\25\u00a0"+
		"\n\25\f\25\16\25\u00a3\13\25\3\26\3\26\5\26\u00a7\n\26\3\26\3\26\2\2\27"+
		"\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\2\25\2\27\2\31\2\33\13\35\f\37"+
		"\r!\16#\17%\2\'\2)\2+\20\3\2\f\3\2$$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2Z"+
		"Zzz\4\2DDdd\3\2\62\63\t\2\f\f\17\17\"\"*+==]]__\6\2\13\f\17\17\"\"..\4"+
		"\2\f\f\17\17\2\u00b7\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2"+
		"\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\33\3\2\2\2\2\35\3"+
		"\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2+\3\2\2\2\3-\3\2\2\2\5/\3\2"+
		"\2\2\7\61\3\2\2\2\t\63\3\2\2\2\13\65\3\2\2\2\r\67\3\2\2\2\179\3\2\2\2"+
		"\21^\3\2\2\2\23e\3\2\2\2\25g\3\2\2\2\27m\3\2\2\2\31v\3\2\2\2\33x\3\2\2"+
		"\2\35\177\3\2\2\2\37\u0087\3\2\2\2!\u008e\3\2\2\2#\u0094\3\2\2\2%\u0097"+
		"\3\2\2\2\'\u009b\3\2\2\2)\u009d\3\2\2\2+\u00a6\3\2\2\2-.\7*\2\2.\4\3\2"+
		"\2\2/\60\7+\2\2\60\6\3\2\2\2\61\62\7]\2\2\62\b\3\2\2\2\63\64\7_\2\2\64"+
		"\n\3\2\2\2\65\66\7)\2\2\66\f\3\2\2\2\678\7%\2\28\16\3\2\2\29?\7$\2\2:"+
		">\n\2\2\2;<\7^\2\2<>\7$\2\2=:\3\2\2\2=;\3\2\2\2>A\3\2\2\2?=\3\2\2\2?@"+
		"\3\2\2\2@B\3\2\2\2A?\3\2\2\2BC\7$\2\2C\20\3\2\2\2DF\7/\2\2ED\3\2\2\2E"+
		"F\3\2\2\2FH\3\2\2\2GI\t\3\2\2HG\3\2\2\2IJ\3\2\2\2JH\3\2\2\2JK\3\2\2\2"+
		"KL\3\2\2\2L_\5\23\n\2MO\7/\2\2NM\3\2\2\2NO\3\2\2\2OP\3\2\2\2PQ\7K\2\2"+
		"QR\7p\2\2RS\7h\2\2ST\7k\2\2TU\7p\2\2UV\7k\2\2VW\7v\2\2W_\7{\2\2XZ\7/\2"+
		"\2YX\3\2\2\2YZ\3\2\2\2Z[\3\2\2\2[\\\7P\2\2\\]\7c\2\2]_\7P\2\2^E\3\2\2"+
		"\2^N\3\2\2\2^Y\3\2\2\2_\22\3\2\2\2`a\5\25\13\2ab\5\27\f\2bf\3\2\2\2cf"+
		"\5\25\13\2df\5\27\f\2e`\3\2\2\2ec\3\2\2\2ed\3\2\2\2f\24\3\2\2\2gi\7\60"+
		"\2\2hj\t\3\2\2ih\3\2\2\2jk\3\2\2\2ki\3\2\2\2kl\3\2\2\2l\26\3\2\2\2mo\t"+
		"\4\2\2np\7/\2\2on\3\2\2\2op\3\2\2\2pr\3\2\2\2qs\t\3\2\2rq\3\2\2\2st\3"+
		"\2\2\2tr\3\2\2\2tu\3\2\2\2u\30\3\2\2\2vw\t\5\2\2w\32\3\2\2\2xy\7\62\2"+
		"\2y{\t\6\2\2z|\5\31\r\2{z\3\2\2\2|}\3\2\2\2}{\3\2\2\2}~\3\2\2\2~\34\3"+
		"\2\2\2\177\u0080\7\62\2\2\u0080\u0082\t\7\2\2\u0081\u0083\t\b\2\2\u0082"+
		"\u0081\3\2\2\2\u0083\u0084\3\2\2\2\u0084\u0082\3\2\2\2\u0084\u0085\3\2"+
		"\2\2\u0085\36\3\2\2\2\u0086\u0088\7/\2\2\u0087\u0086\3\2\2\2\u0087\u0088"+
		"\3\2\2\2\u0088\u008a\3\2\2\2\u0089\u008b\t\3\2\2\u008a\u0089\3\2\2\2\u008b"+
		"\u008c\3\2\2\2\u008c\u008a\3\2\2\2\u008c\u008d\3\2\2\2\u008d \3\2\2\2"+
		"\u008e\u008f\7p\2\2\u008f\u0090\7k\2\2\u0090\u0091\7n\2\2\u0091\"\3\2"+
		"\2\2\u0092\u0095\4\60\61\2\u0093\u0095\5%\23\2\u0094\u0092\3\2\2\2\u0094"+
		"\u0093\3\2\2\2\u0095$\3\2\2\2\u0096\u0098\n\t\2\2\u0097\u0096\3\2\2\2"+
		"\u0098\u0099\3\2\2\2\u0099\u0097\3\2\2\2\u0099\u009a\3\2\2\2\u009a&\3"+
		"\2\2\2\u009b\u009c\t\n\2\2\u009c(\3\2\2\2\u009d\u00a1\7=\2\2\u009e\u00a0"+
		"\n\13\2\2\u009f\u009e\3\2\2\2\u00a0\u00a3\3\2\2\2\u00a1\u009f\3\2\2\2"+
		"\u00a1\u00a2\3\2\2\2\u00a2*\3\2\2\2\u00a3\u00a1\3\2\2\2\u00a4\u00a7\5"+
		"\'\24\2\u00a5\u00a7\5)\25\2\u00a6\u00a4\3\2\2\2\u00a6\u00a5\3\2\2\2\u00a7"+
		"\u00a8\3\2\2\2\u00a8\u00a9\b\26\2\2\u00a9,\3\2\2\2\26\2=?EJNY^ekot}\u0084"+
		"\u0087\u008c\u0094\u0099\u00a1\u00a6\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}