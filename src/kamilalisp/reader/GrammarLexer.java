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
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, STRING=8, FLOAT=9, 
		HEX=10, BIN=11, LONG=12, NIL=13, NAME=14, TRASH=15;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "STRING", "FLOAT", 
			"FLOAT_TAIL", "FLOAT_DECIMAL", "FLOAT_EXP", "HEXD", "HEX", "BIN", "LONG", 
			"NIL", "NOTID", "NOTID_START", "NAME", "WS", "COMMENT", "TRASH"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'('", "')'", "'['", "']'", "'''", "'#'", "'$'", null, null, null, 
			null, null, "'nil'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, "STRING", "FLOAT", "HEX", 
			"BIN", "LONG", "NIL", "NAME", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\21\u00b2\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\3\2"+
		"\3\2\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t\3\t\3\t\7"+
		"\tD\n\t\f\t\16\tG\13\t\3\t\3\t\3\n\5\nL\n\n\3\n\6\nO\n\n\r\n\16\nP\3\n"+
		"\3\n\5\nU\n\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\5\n`\n\n\3\n\3\n\3\n"+
		"\5\ne\n\n\3\13\3\13\3\13\3\13\3\13\5\13l\n\13\3\f\3\f\6\fp\n\f\r\f\16"+
		"\fq\3\r\3\r\5\rv\n\r\3\r\6\ry\n\r\r\r\16\rz\3\16\3\16\3\17\3\17\3\17\6"+
		"\17\u0082\n\17\r\17\16\17\u0083\3\20\3\20\3\20\6\20\u0089\n\20\r\20\16"+
		"\20\u008a\3\21\5\21\u008e\n\21\3\21\6\21\u0091\n\21\r\21\16\21\u0092\3"+
		"\22\3\22\3\22\3\22\3\23\3\23\3\24\3\24\3\25\3\25\7\25\u009f\n\25\f\25"+
		"\16\25\u00a2\13\25\3\26\3\26\3\27\3\27\7\27\u00a8\n\27\f\27\16\27\u00ab"+
		"\13\27\3\30\3\30\5\30\u00af\n\30\3\30\3\30\2\2\31\3\3\5\4\7\5\t\6\13\7"+
		"\r\b\17\t\21\n\23\13\25\2\27\2\31\2\33\2\35\f\37\r!\16#\17%\2\'\2)\20"+
		"+\2-\2/\21\3\2\r\3\2$$\3\2\62;\4\2GGgg\5\2\62;CHch\4\2ZZzz\4\2DDdd\3\2"+
		"\62\63\t\2\f\f\17\17\"\"*+==]]__\n\2\f\f\17\17\"\"%&)+==]]__\6\2\13\f"+
		"\17\17\"\"..\4\2\f\f\17\17\2\u00bd\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2"+
		"\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3"+
		"\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2)\3\2\2\2\2/\3"+
		"\2\2\2\3\61\3\2\2\2\5\63\3\2\2\2\7\65\3\2\2\2\t\67\3\2\2\2\139\3\2\2\2"+
		"\r;\3\2\2\2\17=\3\2\2\2\21?\3\2\2\2\23d\3\2\2\2\25k\3\2\2\2\27m\3\2\2"+
		"\2\31s\3\2\2\2\33|\3\2\2\2\35~\3\2\2\2\37\u0085\3\2\2\2!\u008d\3\2\2\2"+
		"#\u0094\3\2\2\2%\u0098\3\2\2\2\'\u009a\3\2\2\2)\u009c\3\2\2\2+\u00a3\3"+
		"\2\2\2-\u00a5\3\2\2\2/\u00ae\3\2\2\2\61\62\7*\2\2\62\4\3\2\2\2\63\64\7"+
		"+\2\2\64\6\3\2\2\2\65\66\7]\2\2\66\b\3\2\2\2\678\7_\2\28\n\3\2\2\29:\7"+
		")\2\2:\f\3\2\2\2;<\7%\2\2<\16\3\2\2\2=>\7&\2\2>\20\3\2\2\2?E\7$\2\2@D"+
		"\n\2\2\2AB\7^\2\2BD\7$\2\2C@\3\2\2\2CA\3\2\2\2DG\3\2\2\2EC\3\2\2\2EF\3"+
		"\2\2\2FH\3\2\2\2GE\3\2\2\2HI\7$\2\2I\22\3\2\2\2JL\7/\2\2KJ\3\2\2\2KL\3"+
		"\2\2\2LN\3\2\2\2MO\t\3\2\2NM\3\2\2\2OP\3\2\2\2PN\3\2\2\2PQ\3\2\2\2QR\3"+
		"\2\2\2Re\5\25\13\2SU\7/\2\2TS\3\2\2\2TU\3\2\2\2UV\3\2\2\2VW\7K\2\2WX\7"+
		"p\2\2XY\7h\2\2YZ\7k\2\2Z[\7p\2\2[\\\7k\2\2\\]\7v\2\2]e\7{\2\2^`\7/\2\2"+
		"_^\3\2\2\2_`\3\2\2\2`a\3\2\2\2ab\7P\2\2bc\7c\2\2ce\7P\2\2dK\3\2\2\2dT"+
		"\3\2\2\2d_\3\2\2\2e\24\3\2\2\2fg\5\27\f\2gh\5\31\r\2hl\3\2\2\2il\5\27"+
		"\f\2jl\5\31\r\2kf\3\2\2\2ki\3\2\2\2kj\3\2\2\2l\26\3\2\2\2mo\7\60\2\2n"+
		"p\t\3\2\2on\3\2\2\2pq\3\2\2\2qo\3\2\2\2qr\3\2\2\2r\30\3\2\2\2su\t\4\2"+
		"\2tv\7/\2\2ut\3\2\2\2uv\3\2\2\2vx\3\2\2\2wy\t\3\2\2xw\3\2\2\2yz\3\2\2"+
		"\2zx\3\2\2\2z{\3\2\2\2{\32\3\2\2\2|}\t\5\2\2}\34\3\2\2\2~\177\7\62\2\2"+
		"\177\u0081\t\6\2\2\u0080\u0082\5\33\16\2\u0081\u0080\3\2\2\2\u0082\u0083"+
		"\3\2\2\2\u0083\u0081\3\2\2\2\u0083\u0084\3\2\2\2\u0084\36\3\2\2\2\u0085"+
		"\u0086\7\62\2\2\u0086\u0088\t\7\2\2\u0087\u0089\t\b\2\2\u0088\u0087\3"+
		"\2\2\2\u0089\u008a\3\2\2\2\u008a\u0088\3\2\2\2\u008a\u008b\3\2\2\2\u008b"+
		" \3\2\2\2\u008c\u008e\7/\2\2\u008d\u008c\3\2\2\2\u008d\u008e\3\2\2\2\u008e"+
		"\u0090\3\2\2\2\u008f\u0091\t\3\2\2\u0090\u008f\3\2\2\2\u0091\u0092\3\2"+
		"\2\2\u0092\u0090\3\2\2\2\u0092\u0093\3\2\2\2\u0093\"\3\2\2\2\u0094\u0095"+
		"\7p\2\2\u0095\u0096\7k\2\2\u0096\u0097\7n\2\2\u0097$\3\2\2\2\u0098\u0099"+
		"\n\t\2\2\u0099&\3\2\2\2\u009a\u009b\n\n\2\2\u009b(\3\2\2\2\u009c\u00a0"+
		"\5\'\24\2\u009d\u009f\5%\23\2\u009e\u009d\3\2\2\2\u009f\u00a2\3\2\2\2"+
		"\u00a0\u009e\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1*\3\2\2\2\u00a2\u00a0\3"+
		"\2\2\2\u00a3\u00a4\t\13\2\2\u00a4,\3\2\2\2\u00a5\u00a9\7=\2\2\u00a6\u00a8"+
		"\n\f\2\2\u00a7\u00a6\3\2\2\2\u00a8\u00ab\3\2\2\2\u00a9\u00a7\3\2\2\2\u00a9"+
		"\u00aa\3\2\2\2\u00aa.\3\2\2\2\u00ab\u00a9\3\2\2\2\u00ac\u00af\5+\26\2"+
		"\u00ad\u00af\5-\27\2\u00ae\u00ac\3\2\2\2\u00ae\u00ad\3\2\2\2\u00af\u00b0"+
		"\3\2\2\2\u00b0\u00b1\b\30\2\2\u00b1\60\3\2\2\2\25\2CEKPT_dkquz\u0083\u008a"+
		"\u008d\u0092\u00a0\u00a9\u00ae\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}