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
		T__9=10, T__10=11, STRING=12, COMPLEX=13, FLOAT=14, HEX=15, BIN=16, LONG=17, 
		NIL=18, NAME=19, TRASH=20;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
			"T__9", "T__10", "STRING", "COMPLEX", "FLOAT", "FLOAT_TAIL", "FLOAT_DECIMAL", 
			"FLOAT_EXP", "HEXD", "HEX", "BIN", "LONG", "NIL", "NOTID", "NOTID_START", 
			"NAME", "WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'^'", "'@'", "'('", "')'", "'['", "']'", "'\\'", "'''", "':'", 
			"'#'", "'$'", null, null, null, null, null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			"STRING", "COMPLEX", "FLOAT", "HEX", "BIN", "LONG", "NIL", "NAME", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\26\u00cd\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\3\2\3\2\3\3\3\3\3\4\3\4"+
		"\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r"+
		"\3\r\3\r\3\r\7\rV\n\r\f\r\16\rY\13\r\3\r\3\r\3\16\3\16\5\16_\n\16\3\16"+
		"\3\16\3\16\5\16d\n\16\3\17\5\17g\n\17\3\17\6\17j\n\17\r\17\16\17k\3\17"+
		"\3\17\5\17p\n\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17{\n"+
		"\17\3\17\3\17\3\17\5\17\u0080\n\17\3\20\3\20\3\20\3\20\3\20\5\20\u0087"+
		"\n\20\3\21\3\21\6\21\u008b\n\21\r\21\16\21\u008c\3\22\3\22\5\22\u0091"+
		"\n\22\3\22\6\22\u0094\n\22\r\22\16\22\u0095\3\23\3\23\3\24\3\24\3\24\6"+
		"\24\u009d\n\24\r\24\16\24\u009e\3\25\3\25\3\25\6\25\u00a4\n\25\r\25\16"+
		"\25\u00a5\3\26\5\26\u00a9\n\26\3\26\6\26\u00ac\n\26\r\26\16\26\u00ad\3"+
		"\27\3\27\3\27\3\27\3\30\3\30\3\31\3\31\3\32\3\32\7\32\u00ba\n\32\f\32"+
		"\16\32\u00bd\13\32\3\33\3\33\3\34\3\34\7\34\u00c3\n\34\f\34\16\34\u00c6"+
		"\13\34\3\35\3\35\5\35\u00ca\n\35\3\35\3\35\2\2\36\3\3\5\4\7\5\t\6\13\7"+
		"\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\2!\2#\2%\2\'\21)\22"+
		"+\23-\24/\2\61\2\63\25\65\2\67\29\26\3\2\r\3\2$$\3\2\62;\4\2GGgg\5\2\62"+
		";CHch\4\2ZZzz\4\2DDdd\3\2\62\63\n\2\f\f\17\17\"\"*+==BB]]_`\n\2\f\f\17"+
		"\17\"\"%&)+<=BB]`\6\2\13\f\17\17\"\"..\4\2\f\f\17\17\2\u00da\2\3\3\2\2"+
		"\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3"+
		"\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2"+
		"\2\2\33\3\2\2\2\2\35\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2"+
		"\2\2\2\63\3\2\2\2\29\3\2\2\2\3;\3\2\2\2\5=\3\2\2\2\7?\3\2\2\2\tA\3\2\2"+
		"\2\13C\3\2\2\2\rE\3\2\2\2\17G\3\2\2\2\21I\3\2\2\2\23K\3\2\2\2\25M\3\2"+
		"\2\2\27O\3\2\2\2\31Q\3\2\2\2\33^\3\2\2\2\35\177\3\2\2\2\37\u0086\3\2\2"+
		"\2!\u0088\3\2\2\2#\u008e\3\2\2\2%\u0097\3\2\2\2\'\u0099\3\2\2\2)\u00a0"+
		"\3\2\2\2+\u00a8\3\2\2\2-\u00af\3\2\2\2/\u00b3\3\2\2\2\61\u00b5\3\2\2\2"+
		"\63\u00b7\3\2\2\2\65\u00be\3\2\2\2\67\u00c0\3\2\2\29\u00c9\3\2\2\2;<\7"+
		"`\2\2<\4\3\2\2\2=>\7B\2\2>\6\3\2\2\2?@\7*\2\2@\b\3\2\2\2AB\7+\2\2B\n\3"+
		"\2\2\2CD\7]\2\2D\f\3\2\2\2EF\7_\2\2F\16\3\2\2\2GH\7^\2\2H\20\3\2\2\2I"+
		"J\7)\2\2J\22\3\2\2\2KL\7<\2\2L\24\3\2\2\2MN\7%\2\2N\26\3\2\2\2OP\7&\2"+
		"\2P\30\3\2\2\2QW\7$\2\2RV\n\2\2\2ST\7^\2\2TV\7$\2\2UR\3\2\2\2US\3\2\2"+
		"\2VY\3\2\2\2WU\3\2\2\2WX\3\2\2\2XZ\3\2\2\2YW\3\2\2\2Z[\7$\2\2[\32\3\2"+
		"\2\2\\_\5\35\17\2]_\5+\26\2^\\\3\2\2\2^]\3\2\2\2_`\3\2\2\2`c\7L\2\2ad"+
		"\5\35\17\2bd\5+\26\2ca\3\2\2\2cb\3\2\2\2d\34\3\2\2\2eg\7/\2\2fe\3\2\2"+
		"\2fg\3\2\2\2gi\3\2\2\2hj\t\3\2\2ih\3\2\2\2jk\3\2\2\2ki\3\2\2\2kl\3\2\2"+
		"\2lm\3\2\2\2m\u0080\5\37\20\2np\7/\2\2on\3\2\2\2op\3\2\2\2pq\3\2\2\2q"+
		"r\7K\2\2rs\7p\2\2st\7h\2\2tu\7k\2\2uv\7p\2\2vw\7k\2\2wx\7v\2\2x\u0080"+
		"\7{\2\2y{\7/\2\2zy\3\2\2\2z{\3\2\2\2{|\3\2\2\2|}\7P\2\2}~\7c\2\2~\u0080"+
		"\7P\2\2\177f\3\2\2\2\177o\3\2\2\2\177z\3\2\2\2\u0080\36\3\2\2\2\u0081"+
		"\u0082\5!\21\2\u0082\u0083\5#\22\2\u0083\u0087\3\2\2\2\u0084\u0087\5!"+
		"\21\2\u0085\u0087\5#\22\2\u0086\u0081\3\2\2\2\u0086\u0084\3\2\2\2\u0086"+
		"\u0085\3\2\2\2\u0087 \3\2\2\2\u0088\u008a\7\60\2\2\u0089\u008b\t\3\2\2"+
		"\u008a\u0089\3\2\2\2\u008b\u008c\3\2\2\2\u008c\u008a\3\2\2\2\u008c\u008d"+
		"\3\2\2\2\u008d\"\3\2\2\2\u008e\u0090\t\4\2\2\u008f\u0091\7/\2\2\u0090"+
		"\u008f\3\2\2\2\u0090\u0091\3\2\2\2\u0091\u0093\3\2\2\2\u0092\u0094\t\3"+
		"\2\2\u0093\u0092\3\2\2\2\u0094\u0095\3\2\2\2\u0095\u0093\3\2\2\2\u0095"+
		"\u0096\3\2\2\2\u0096$\3\2\2\2\u0097\u0098\t\5\2\2\u0098&\3\2\2\2\u0099"+
		"\u009a\7\62\2\2\u009a\u009c\t\6\2\2\u009b\u009d\5%\23\2\u009c\u009b\3"+
		"\2\2\2\u009d\u009e\3\2\2\2\u009e\u009c\3\2\2\2\u009e\u009f\3\2\2\2\u009f"+
		"(\3\2\2\2\u00a0\u00a1\7\62\2\2\u00a1\u00a3\t\7\2\2\u00a2\u00a4\t\b\2\2"+
		"\u00a3\u00a2\3\2\2\2\u00a4\u00a5\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a5\u00a6"+
		"\3\2\2\2\u00a6*\3\2\2\2\u00a7\u00a9\7/\2\2\u00a8\u00a7\3\2\2\2\u00a8\u00a9"+
		"\3\2\2\2\u00a9\u00ab\3\2\2\2\u00aa\u00ac\t\3\2\2\u00ab\u00aa\3\2\2\2\u00ac"+
		"\u00ad\3\2\2\2\u00ad\u00ab\3\2\2\2\u00ad\u00ae\3\2\2\2\u00ae,\3\2\2\2"+
		"\u00af\u00b0\7p\2\2\u00b0\u00b1\7k\2\2\u00b1\u00b2\7n\2\2\u00b2.\3\2\2"+
		"\2\u00b3\u00b4\n\t\2\2\u00b4\60\3\2\2\2\u00b5\u00b6\n\n\2\2\u00b6\62\3"+
		"\2\2\2\u00b7\u00bb\5\61\31\2\u00b8\u00ba\5/\30\2\u00b9\u00b8\3\2\2\2\u00ba"+
		"\u00bd\3\2\2\2\u00bb\u00b9\3\2\2\2\u00bb\u00bc\3\2\2\2\u00bc\64\3\2\2"+
		"\2\u00bd\u00bb\3\2\2\2\u00be\u00bf\t\13\2\2\u00bf\66\3\2\2\2\u00c0\u00c4"+
		"\7=\2\2\u00c1\u00c3\n\f\2\2\u00c2\u00c1\3\2\2\2\u00c3\u00c6\3\2\2\2\u00c4"+
		"\u00c2\3\2\2\2\u00c4\u00c5\3\2\2\2\u00c58\3\2\2\2\u00c6\u00c4\3\2\2\2"+
		"\u00c7\u00ca\5\65\33\2\u00c8\u00ca\5\67\34\2\u00c9\u00c7\3\2\2\2\u00c9"+
		"\u00c8\3\2\2\2\u00ca\u00cb\3\2\2\2\u00cb\u00cc\b\35\2\2\u00cc:\3\2\2\2"+
		"\27\2UW^cfkoz\177\u0086\u008c\u0090\u0095\u009e\u00a5\u00a8\u00ad\u00bb"+
		"\u00c4\u00c9\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}