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
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, STRING=11, COMPLEX=12, FLOAT=13, HEX=14, BIN=15, LONG=16, NIL=17, 
		NAME=18, TRASH=19;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
			"T__9", "STRING", "COMPLEX", "FLOAT", "FLOAT_TAIL", "FLOAT_DECIMAL", 
			"FLOAT_EXP", "HEXD", "HEX", "BIN", "LONG", "NIL", "NOTID", "NOTID_START", 
			"NAME", "WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'@'", "'('", "')'", "'['", "']'", "'\\'", "'''", "':'", "'#'", 
			"'$'", null, null, null, null, null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, "STRING", 
			"COMPLEX", "FLOAT", "HEX", "BIN", "LONG", "NIL", "NAME", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\25\u00c9\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3"+
		"\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\f\7\fR"+
		"\n\f\f\f\16\fU\13\f\3\f\3\f\3\r\3\r\5\r[\n\r\3\r\3\r\3\r\5\r`\n\r\3\16"+
		"\5\16c\n\16\3\16\6\16f\n\16\r\16\16\16g\3\16\3\16\5\16l\n\16\3\16\3\16"+
		"\3\16\3\16\3\16\3\16\3\16\3\16\3\16\5\16w\n\16\3\16\3\16\3\16\5\16|\n"+
		"\16\3\17\3\17\3\17\3\17\3\17\5\17\u0083\n\17\3\20\3\20\6\20\u0087\n\20"+
		"\r\20\16\20\u0088\3\21\3\21\5\21\u008d\n\21\3\21\6\21\u0090\n\21\r\21"+
		"\16\21\u0091\3\22\3\22\3\23\3\23\3\23\6\23\u0099\n\23\r\23\16\23\u009a"+
		"\3\24\3\24\3\24\6\24\u00a0\n\24\r\24\16\24\u00a1\3\25\5\25\u00a5\n\25"+
		"\3\25\6\25\u00a8\n\25\r\25\16\25\u00a9\3\26\3\26\3\26\3\26\3\27\3\27\3"+
		"\30\3\30\3\31\3\31\7\31\u00b6\n\31\f\31\16\31\u00b9\13\31\3\32\3\32\3"+
		"\33\3\33\7\33\u00bf\n\33\f\33\16\33\u00c2\13\33\3\34\3\34\5\34\u00c6\n"+
		"\34\3\34\3\34\2\2\35\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27"+
		"\r\31\16\33\17\35\2\37\2!\2#\2%\20\'\21)\22+\23-\2/\2\61\24\63\2\65\2"+
		"\67\25\3\2\r\3\2$$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2ZZzz\4\2DDdd\3\2\62"+
		"\63\n\2\f\f\17\17\"\"*+==BB]]__\n\2\f\f\17\17\"\"%&)+<=BB]_\6\2\13\f\17"+
		"\17\"\"..\4\2\f\f\17\17\2\u00d6\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2"+
		"\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2"+
		"\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2%\3\2\2\2\2"+
		"\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2\61\3\2\2\2\2\67\3\2\2\2\39\3\2\2\2"+
		"\5;\3\2\2\2\7=\3\2\2\2\t?\3\2\2\2\13A\3\2\2\2\rC\3\2\2\2\17E\3\2\2\2\21"+
		"G\3\2\2\2\23I\3\2\2\2\25K\3\2\2\2\27M\3\2\2\2\31Z\3\2\2\2\33{\3\2\2\2"+
		"\35\u0082\3\2\2\2\37\u0084\3\2\2\2!\u008a\3\2\2\2#\u0093\3\2\2\2%\u0095"+
		"\3\2\2\2\'\u009c\3\2\2\2)\u00a4\3\2\2\2+\u00ab\3\2\2\2-\u00af\3\2\2\2"+
		"/\u00b1\3\2\2\2\61\u00b3\3\2\2\2\63\u00ba\3\2\2\2\65\u00bc\3\2\2\2\67"+
		"\u00c5\3\2\2\29:\7B\2\2:\4\3\2\2\2;<\7*\2\2<\6\3\2\2\2=>\7+\2\2>\b\3\2"+
		"\2\2?@\7]\2\2@\n\3\2\2\2AB\7_\2\2B\f\3\2\2\2CD\7^\2\2D\16\3\2\2\2EF\7"+
		")\2\2F\20\3\2\2\2GH\7<\2\2H\22\3\2\2\2IJ\7%\2\2J\24\3\2\2\2KL\7&\2\2L"+
		"\26\3\2\2\2MS\7$\2\2NR\n\2\2\2OP\7^\2\2PR\7$\2\2QN\3\2\2\2QO\3\2\2\2R"+
		"U\3\2\2\2SQ\3\2\2\2ST\3\2\2\2TV\3\2\2\2US\3\2\2\2VW\7$\2\2W\30\3\2\2\2"+
		"X[\5\33\16\2Y[\5)\25\2ZX\3\2\2\2ZY\3\2\2\2[\\\3\2\2\2\\_\7L\2\2]`\5\33"+
		"\16\2^`\5)\25\2_]\3\2\2\2_^\3\2\2\2`\32\3\2\2\2ac\7/\2\2ba\3\2\2\2bc\3"+
		"\2\2\2ce\3\2\2\2df\t\3\2\2ed\3\2\2\2fg\3\2\2\2ge\3\2\2\2gh\3\2\2\2hi\3"+
		"\2\2\2i|\5\35\17\2jl\7/\2\2kj\3\2\2\2kl\3\2\2\2lm\3\2\2\2mn\7K\2\2no\7"+
		"p\2\2op\7h\2\2pq\7k\2\2qr\7p\2\2rs\7k\2\2st\7v\2\2t|\7{\2\2uw\7/\2\2v"+
		"u\3\2\2\2vw\3\2\2\2wx\3\2\2\2xy\7P\2\2yz\7c\2\2z|\7P\2\2{b\3\2\2\2{k\3"+
		"\2\2\2{v\3\2\2\2|\34\3\2\2\2}~\5\37\20\2~\177\5!\21\2\177\u0083\3\2\2"+
		"\2\u0080\u0083\5\37\20\2\u0081\u0083\5!\21\2\u0082}\3\2\2\2\u0082\u0080"+
		"\3\2\2\2\u0082\u0081\3\2\2\2\u0083\36\3\2\2\2\u0084\u0086\7\60\2\2\u0085"+
		"\u0087\t\3\2\2\u0086\u0085\3\2\2\2\u0087\u0088\3\2\2\2\u0088\u0086\3\2"+
		"\2\2\u0088\u0089\3\2\2\2\u0089 \3\2\2\2\u008a\u008c\t\4\2\2\u008b\u008d"+
		"\7/\2\2\u008c\u008b\3\2\2\2\u008c\u008d\3\2\2\2\u008d\u008f\3\2\2\2\u008e"+
		"\u0090\t\3\2\2\u008f\u008e\3\2\2\2\u0090\u0091\3\2\2\2\u0091\u008f\3\2"+
		"\2\2\u0091\u0092\3\2\2\2\u0092\"\3\2\2\2\u0093\u0094\t\5\2\2\u0094$\3"+
		"\2\2\2\u0095\u0096\7\62\2\2\u0096\u0098\t\6\2\2\u0097\u0099\5#\22\2\u0098"+
		"\u0097\3\2\2\2\u0099\u009a\3\2\2\2\u009a\u0098\3\2\2\2\u009a\u009b\3\2"+
		"\2\2\u009b&\3\2\2\2\u009c\u009d\7\62\2\2\u009d\u009f\t\7\2\2\u009e\u00a0"+
		"\t\b\2\2\u009f\u009e\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1\u009f\3\2\2\2\u00a1"+
		"\u00a2\3\2\2\2\u00a2(\3\2\2\2\u00a3\u00a5\7/\2\2\u00a4\u00a3\3\2\2\2\u00a4"+
		"\u00a5\3\2\2\2\u00a5\u00a7\3\2\2\2\u00a6\u00a8\t\3\2\2\u00a7\u00a6\3\2"+
		"\2\2\u00a8\u00a9\3\2\2\2\u00a9\u00a7\3\2\2\2\u00a9\u00aa\3\2\2\2\u00aa"+
		"*\3\2\2\2\u00ab\u00ac\7p\2\2\u00ac\u00ad\7k\2\2\u00ad\u00ae\7n\2\2\u00ae"+
		",\3\2\2\2\u00af\u00b0\n\t\2\2\u00b0.\3\2\2\2\u00b1\u00b2\n\n\2\2\u00b2"+
		"\60\3\2\2\2\u00b3\u00b7\5/\30\2\u00b4\u00b6\5-\27\2\u00b5\u00b4\3\2\2"+
		"\2\u00b6\u00b9\3\2\2\2\u00b7\u00b5\3\2\2\2\u00b7\u00b8\3\2\2\2\u00b8\62"+
		"\3\2\2\2\u00b9\u00b7\3\2\2\2\u00ba\u00bb\t\13\2\2\u00bb\64\3\2\2\2\u00bc"+
		"\u00c0\7=\2\2\u00bd\u00bf\n\f\2\2\u00be\u00bd\3\2\2\2\u00bf\u00c2\3\2"+
		"\2\2\u00c0\u00be\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\66\3\2\2\2\u00c2\u00c0"+
		"\3\2\2\2\u00c3\u00c6\5\63\32\2\u00c4\u00c6\5\65\33\2\u00c5\u00c3\3\2\2"+
		"\2\u00c5\u00c4\3\2\2\2\u00c6\u00c7\3\2\2\2\u00c7\u00c8\b\34\2\2\u00c8"+
		"8\3\2\2\2\27\2QSZ_bgkv{\u0082\u0088\u008c\u0091\u009a\u00a1\u00a4\u00a9"+
		"\u00b7\u00c0\u00c5\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}