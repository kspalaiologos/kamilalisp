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
		STRING=10, COMPLEX=11, FLOAT=12, HEX=13, BIN=14, LONG=15, NIL=16, NAME=17, 
		TRASH=18;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
			"STRING", "COMPLEX", "FLOAT", "FLOAT_TAIL", "FLOAT_DECIMAL", "FLOAT_EXP", 
			"HEXD", "HEX", "BIN", "LONG", "NIL", "NOTID", "NOTID_START", "NAME", 
			"WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'@'", "'('", "')'", "'['", "']'", "'''", "':'", "'#'", "'$'", 
			null, null, null, null, null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, "STRING", 
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\24\u00c5\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\3\2\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7"+
		"\3\7\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\13\3\13\7\13N\n\13\f\13\16\13"+
		"Q\13\13\3\13\3\13\3\f\3\f\5\fW\n\f\3\f\3\f\3\f\5\f\\\n\f\3\r\5\r_\n\r"+
		"\3\r\6\rb\n\r\r\r\16\rc\3\r\3\r\5\rh\n\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3"+
		"\r\3\r\5\rs\n\r\3\r\3\r\3\r\5\rx\n\r\3\16\3\16\3\16\3\16\3\16\5\16\177"+
		"\n\16\3\17\3\17\6\17\u0083\n\17\r\17\16\17\u0084\3\20\3\20\5\20\u0089"+
		"\n\20\3\20\6\20\u008c\n\20\r\20\16\20\u008d\3\21\3\21\3\22\3\22\3\22\6"+
		"\22\u0095\n\22\r\22\16\22\u0096\3\23\3\23\3\23\6\23\u009c\n\23\r\23\16"+
		"\23\u009d\3\24\5\24\u00a1\n\24\3\24\6\24\u00a4\n\24\r\24\16\24\u00a5\3"+
		"\25\3\25\3\25\3\25\3\26\3\26\3\27\3\27\3\30\3\30\7\30\u00b2\n\30\f\30"+
		"\16\30\u00b5\13\30\3\31\3\31\3\32\3\32\7\32\u00bb\n\32\f\32\16\32\u00be"+
		"\13\32\3\33\3\33\5\33\u00c2\n\33\3\33\3\33\2\2\34\3\3\5\4\7\5\t\6\13\7"+
		"\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\2\35\2\37\2!\2#\17%\20\'\21)\22"+
		"+\2-\2/\23\61\2\63\2\65\24\3\2\r\3\2$$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2"+
		"ZZzz\4\2DDdd\3\2\62\63\n\2\f\f\17\17\"\"*+==BB]]__\13\2\f\f\17\17\"\""+
		"%&)+<=BB]]__\6\2\13\f\17\17\"\"..\4\2\f\f\17\17\2\u00d2\2\3\3\2\2\2\2"+
		"\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2"+
		"\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2"+
		"#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2/\3\2\2\2\2\65\3\2\2\2\3"+
		"\67\3\2\2\2\59\3\2\2\2\7;\3\2\2\2\t=\3\2\2\2\13?\3\2\2\2\rA\3\2\2\2\17"+
		"C\3\2\2\2\21E\3\2\2\2\23G\3\2\2\2\25I\3\2\2\2\27V\3\2\2\2\31w\3\2\2\2"+
		"\33~\3\2\2\2\35\u0080\3\2\2\2\37\u0086\3\2\2\2!\u008f\3\2\2\2#\u0091\3"+
		"\2\2\2%\u0098\3\2\2\2\'\u00a0\3\2\2\2)\u00a7\3\2\2\2+\u00ab\3\2\2\2-\u00ad"+
		"\3\2\2\2/\u00af\3\2\2\2\61\u00b6\3\2\2\2\63\u00b8\3\2\2\2\65\u00c1\3\2"+
		"\2\2\678\7B\2\28\4\3\2\2\29:\7*\2\2:\6\3\2\2\2;<\7+\2\2<\b\3\2\2\2=>\7"+
		"]\2\2>\n\3\2\2\2?@\7_\2\2@\f\3\2\2\2AB\7)\2\2B\16\3\2\2\2CD\7<\2\2D\20"+
		"\3\2\2\2EF\7%\2\2F\22\3\2\2\2GH\7&\2\2H\24\3\2\2\2IO\7$\2\2JN\n\2\2\2"+
		"KL\7^\2\2LN\7$\2\2MJ\3\2\2\2MK\3\2\2\2NQ\3\2\2\2OM\3\2\2\2OP\3\2\2\2P"+
		"R\3\2\2\2QO\3\2\2\2RS\7$\2\2S\26\3\2\2\2TW\5\31\r\2UW\5\'\24\2VT\3\2\2"+
		"\2VU\3\2\2\2WX\3\2\2\2X[\7L\2\2Y\\\5\31\r\2Z\\\5\'\24\2[Y\3\2\2\2[Z\3"+
		"\2\2\2\\\30\3\2\2\2]_\7/\2\2^]\3\2\2\2^_\3\2\2\2_a\3\2\2\2`b\t\3\2\2a"+
		"`\3\2\2\2bc\3\2\2\2ca\3\2\2\2cd\3\2\2\2de\3\2\2\2ex\5\33\16\2fh\7/\2\2"+
		"gf\3\2\2\2gh\3\2\2\2hi\3\2\2\2ij\7K\2\2jk\7p\2\2kl\7h\2\2lm\7k\2\2mn\7"+
		"p\2\2no\7k\2\2op\7v\2\2px\7{\2\2qs\7/\2\2rq\3\2\2\2rs\3\2\2\2st\3\2\2"+
		"\2tu\7P\2\2uv\7c\2\2vx\7P\2\2w^\3\2\2\2wg\3\2\2\2wr\3\2\2\2x\32\3\2\2"+
		"\2yz\5\35\17\2z{\5\37\20\2{\177\3\2\2\2|\177\5\35\17\2}\177\5\37\20\2"+
		"~y\3\2\2\2~|\3\2\2\2~}\3\2\2\2\177\34\3\2\2\2\u0080\u0082\7\60\2\2\u0081"+
		"\u0083\t\3\2\2\u0082\u0081\3\2\2\2\u0083\u0084\3\2\2\2\u0084\u0082\3\2"+
		"\2\2\u0084\u0085\3\2\2\2\u0085\36\3\2\2\2\u0086\u0088\t\4\2\2\u0087\u0089"+
		"\7/\2\2\u0088\u0087\3\2\2\2\u0088\u0089\3\2\2\2\u0089\u008b\3\2\2\2\u008a"+
		"\u008c\t\3\2\2\u008b\u008a\3\2\2\2\u008c\u008d\3\2\2\2\u008d\u008b\3\2"+
		"\2\2\u008d\u008e\3\2\2\2\u008e \3\2\2\2\u008f\u0090\t\5\2\2\u0090\"\3"+
		"\2\2\2\u0091\u0092\7\62\2\2\u0092\u0094\t\6\2\2\u0093\u0095\5!\21\2\u0094"+
		"\u0093\3\2\2\2\u0095\u0096\3\2\2\2\u0096\u0094\3\2\2\2\u0096\u0097\3\2"+
		"\2\2\u0097$\3\2\2\2\u0098\u0099\7\62\2\2\u0099\u009b\t\7\2\2\u009a\u009c"+
		"\t\b\2\2\u009b\u009a\3\2\2\2\u009c\u009d\3\2\2\2\u009d\u009b\3\2\2\2\u009d"+
		"\u009e\3\2\2\2\u009e&\3\2\2\2\u009f\u00a1\7/\2\2\u00a0\u009f\3\2\2\2\u00a0"+
		"\u00a1\3\2\2\2\u00a1\u00a3\3\2\2\2\u00a2\u00a4\t\3\2\2\u00a3\u00a2\3\2"+
		"\2\2\u00a4\u00a5\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a5\u00a6\3\2\2\2\u00a6"+
		"(\3\2\2\2\u00a7\u00a8\7p\2\2\u00a8\u00a9\7k\2\2\u00a9\u00aa\7n\2\2\u00aa"+
		"*\3\2\2\2\u00ab\u00ac\n\t\2\2\u00ac,\3\2\2\2\u00ad\u00ae\n\n\2\2\u00ae"+
		".\3\2\2\2\u00af\u00b3\5-\27\2\u00b0\u00b2\5+\26\2\u00b1\u00b0\3\2\2\2"+
		"\u00b2\u00b5\3\2\2\2\u00b3\u00b1\3\2\2\2\u00b3\u00b4\3\2\2\2\u00b4\60"+
		"\3\2\2\2\u00b5\u00b3\3\2\2\2\u00b6\u00b7\t\13\2\2\u00b7\62\3\2\2\2\u00b8"+
		"\u00bc\7=\2\2\u00b9\u00bb\n\f\2\2\u00ba\u00b9\3\2\2\2\u00bb\u00be\3\2"+
		"\2\2\u00bc\u00ba\3\2\2\2\u00bc\u00bd\3\2\2\2\u00bd\64\3\2\2\2\u00be\u00bc"+
		"\3\2\2\2\u00bf\u00c2\5\61\31\2\u00c0\u00c2\5\63\32\2\u00c1\u00bf\3\2\2"+
		"\2\u00c1\u00c0\3\2\2\2\u00c2\u00c3\3\2\2\2\u00c3\u00c4\b\33\2\2\u00c4"+
		"\66\3\2\2\2\27\2MOV[^cgrw~\u0084\u0088\u008d\u0096\u009d\u00a0\u00a5\u00b3"+
		"\u00bc\u00c1\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}