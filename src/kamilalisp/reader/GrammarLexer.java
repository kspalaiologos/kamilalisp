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
		COMPLEX=10, FLOAT=11, HEX=12, BIN=13, LONG=14, NIL=15, NAME=16, TRASH=17;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "STRING", 
			"COMPLEX", "FLOAT", "FLOAT_TAIL", "FLOAT_DECIMAL", "FLOAT_EXP", "HEXD", 
			"HEX", "BIN", "LONG", "NIL", "NOTID", "NOTID_START", "NAME", "WS", "COMMENT", 
			"TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'@'", "'('", "')'", "'['", "']'", "'''", "'#'", "'$'", null, null, 
			null, null, null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, "STRING", "COMPLEX", 
			"FLOAT", "HEX", "BIN", "LONG", "NIL", "NAME", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\23\u00c1\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3"+
		"\b\3\t\3\t\3\n\3\n\3\n\3\n\7\nJ\n\n\f\n\16\nM\13\n\3\n\3\n\3\13\3\13\5"+
		"\13S\n\13\3\13\3\13\3\13\5\13X\n\13\3\f\5\f[\n\f\3\f\6\f^\n\f\r\f\16\f"+
		"_\3\f\3\f\5\fd\n\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\5\fo\n\f\3\f\3"+
		"\f\3\f\5\ft\n\f\3\r\3\r\3\r\3\r\3\r\5\r{\n\r\3\16\3\16\6\16\177\n\16\r"+
		"\16\16\16\u0080\3\17\3\17\5\17\u0085\n\17\3\17\6\17\u0088\n\17\r\17\16"+
		"\17\u0089\3\20\3\20\3\21\3\21\3\21\6\21\u0091\n\21\r\21\16\21\u0092\3"+
		"\22\3\22\3\22\6\22\u0098\n\22\r\22\16\22\u0099\3\23\5\23\u009d\n\23\3"+
		"\23\6\23\u00a0\n\23\r\23\16\23\u00a1\3\24\3\24\3\24\3\24\3\25\3\25\3\26"+
		"\3\26\3\27\3\27\7\27\u00ae\n\27\f\27\16\27\u00b1\13\27\3\30\3\30\3\31"+
		"\3\31\7\31\u00b7\n\31\f\31\16\31\u00ba\13\31\3\32\3\32\5\32\u00be\n\32"+
		"\3\32\3\32\2\2\33\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31"+
		"\2\33\2\35\2\37\2!\16#\17%\20\'\21)\2+\2-\22/\2\61\2\63\23\3\2\r\3\2$"+
		"$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2ZZzz\4\2DDdd\3\2\62\63\n\2\f\f\17\17"+
		"\"\"*+==BB]]__\13\2\f\f\17\17\"\"%&)+==BB]]__\6\2\13\f\17\17\"\"..\4\2"+
		"\f\f\17\17\2\u00ce\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13"+
		"\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2"+
		"\2\2\27\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2-\3\2\2"+
		"\2\2\63\3\2\2\2\3\65\3\2\2\2\5\67\3\2\2\2\79\3\2\2\2\t;\3\2\2\2\13=\3"+
		"\2\2\2\r?\3\2\2\2\17A\3\2\2\2\21C\3\2\2\2\23E\3\2\2\2\25R\3\2\2\2\27s"+
		"\3\2\2\2\31z\3\2\2\2\33|\3\2\2\2\35\u0082\3\2\2\2\37\u008b\3\2\2\2!\u008d"+
		"\3\2\2\2#\u0094\3\2\2\2%\u009c\3\2\2\2\'\u00a3\3\2\2\2)\u00a7\3\2\2\2"+
		"+\u00a9\3\2\2\2-\u00ab\3\2\2\2/\u00b2\3\2\2\2\61\u00b4\3\2\2\2\63\u00bd"+
		"\3\2\2\2\65\66\7B\2\2\66\4\3\2\2\2\678\7*\2\28\6\3\2\2\29:\7+\2\2:\b\3"+
		"\2\2\2;<\7]\2\2<\n\3\2\2\2=>\7_\2\2>\f\3\2\2\2?@\7)\2\2@\16\3\2\2\2AB"+
		"\7%\2\2B\20\3\2\2\2CD\7&\2\2D\22\3\2\2\2EK\7$\2\2FJ\n\2\2\2GH\7^\2\2H"+
		"J\7$\2\2IF\3\2\2\2IG\3\2\2\2JM\3\2\2\2KI\3\2\2\2KL\3\2\2\2LN\3\2\2\2M"+
		"K\3\2\2\2NO\7$\2\2O\24\3\2\2\2PS\5\27\f\2QS\5%\23\2RP\3\2\2\2RQ\3\2\2"+
		"\2ST\3\2\2\2TW\7L\2\2UX\5\27\f\2VX\5%\23\2WU\3\2\2\2WV\3\2\2\2X\26\3\2"+
		"\2\2Y[\7/\2\2ZY\3\2\2\2Z[\3\2\2\2[]\3\2\2\2\\^\t\3\2\2]\\\3\2\2\2^_\3"+
		"\2\2\2_]\3\2\2\2_`\3\2\2\2`a\3\2\2\2at\5\31\r\2bd\7/\2\2cb\3\2\2\2cd\3"+
		"\2\2\2de\3\2\2\2ef\7K\2\2fg\7p\2\2gh\7h\2\2hi\7k\2\2ij\7p\2\2jk\7k\2\2"+
		"kl\7v\2\2lt\7{\2\2mo\7/\2\2nm\3\2\2\2no\3\2\2\2op\3\2\2\2pq\7P\2\2qr\7"+
		"c\2\2rt\7P\2\2sZ\3\2\2\2sc\3\2\2\2sn\3\2\2\2t\30\3\2\2\2uv\5\33\16\2v"+
		"w\5\35\17\2w{\3\2\2\2x{\5\33\16\2y{\5\35\17\2zu\3\2\2\2zx\3\2\2\2zy\3"+
		"\2\2\2{\32\3\2\2\2|~\7\60\2\2}\177\t\3\2\2~}\3\2\2\2\177\u0080\3\2\2\2"+
		"\u0080~\3\2\2\2\u0080\u0081\3\2\2\2\u0081\34\3\2\2\2\u0082\u0084\t\4\2"+
		"\2\u0083\u0085\7/\2\2\u0084\u0083\3\2\2\2\u0084\u0085\3\2\2\2\u0085\u0087"+
		"\3\2\2\2\u0086\u0088\t\3\2\2\u0087\u0086\3\2\2\2\u0088\u0089\3\2\2\2\u0089"+
		"\u0087\3\2\2\2\u0089\u008a\3\2\2\2\u008a\36\3\2\2\2\u008b\u008c\t\5\2"+
		"\2\u008c \3\2\2\2\u008d\u008e\7\62\2\2\u008e\u0090\t\6\2\2\u008f\u0091"+
		"\5\37\20\2\u0090\u008f\3\2\2\2\u0091\u0092\3\2\2\2\u0092\u0090\3\2\2\2"+
		"\u0092\u0093\3\2\2\2\u0093\"\3\2\2\2\u0094\u0095\7\62\2\2\u0095\u0097"+
		"\t\7\2\2\u0096\u0098\t\b\2\2\u0097\u0096\3\2\2\2\u0098\u0099\3\2\2\2\u0099"+
		"\u0097\3\2\2\2\u0099\u009a\3\2\2\2\u009a$\3\2\2\2\u009b\u009d\7/\2\2\u009c"+
		"\u009b\3\2\2\2\u009c\u009d\3\2\2\2\u009d\u009f\3\2\2\2\u009e\u00a0\t\3"+
		"\2\2\u009f\u009e\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1\u009f\3\2\2\2\u00a1"+
		"\u00a2\3\2\2\2\u00a2&\3\2\2\2\u00a3\u00a4\7p\2\2\u00a4\u00a5\7k\2\2\u00a5"+
		"\u00a6\7n\2\2\u00a6(\3\2\2\2\u00a7\u00a8\n\t\2\2\u00a8*\3\2\2\2\u00a9"+
		"\u00aa\n\n\2\2\u00aa,\3\2\2\2\u00ab\u00af\5+\26\2\u00ac\u00ae\5)\25\2"+
		"\u00ad\u00ac\3\2\2\2\u00ae\u00b1\3\2\2\2\u00af\u00ad\3\2\2\2\u00af\u00b0"+
		"\3\2\2\2\u00b0.\3\2\2\2\u00b1\u00af\3\2\2\2\u00b2\u00b3\t\13\2\2\u00b3"+
		"\60\3\2\2\2\u00b4\u00b8\7=\2\2\u00b5\u00b7\n\f\2\2\u00b6\u00b5\3\2\2\2"+
		"\u00b7\u00ba\3\2\2\2\u00b8\u00b6\3\2\2\2\u00b8\u00b9\3\2\2\2\u00b9\62"+
		"\3\2\2\2\u00ba\u00b8\3\2\2\2\u00bb\u00be\5/\30\2\u00bc\u00be\5\61\31\2"+
		"\u00bd\u00bb\3\2\2\2\u00bd\u00bc\3\2\2\2\u00be\u00bf\3\2\2\2\u00bf\u00c0"+
		"\b\32\2\2\u00c0\64\3\2\2\2\27\2IKRWZ_cnsz\u0080\u0084\u0089\u0092\u0099"+
		"\u009c\u00a1\u00af\u00b8\u00bd\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}