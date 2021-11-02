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
		BIN=10, LONG=11, NIL=12, NAME=13, TRASH=14;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "STRING", "FLOAT", "FLOAT_TAIL", 
			"FLOAT_DECIMAL", "FLOAT_EXP", "HEXD", "HEX", "BIN", "LONG", "NIL", "NOTID", 
			"NOTID_START", "NAME", "WS", "COMMENT", "TRASH"
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
			"LONG", "NIL", "NAME", "TRASH"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\20\u00ae\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\3\2\3\2\3\3\3"+
		"\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\b\7\b@\n\b\f\b\16\bC"+
		"\13\b\3\b\3\b\3\t\5\tH\n\t\3\t\6\tK\n\t\r\t\16\tL\3\t\3\t\5\tQ\n\t\3\t"+
		"\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\5\t\\\n\t\3\t\3\t\3\t\5\ta\n\t\3\n\3"+
		"\n\3\n\3\n\3\n\5\nh\n\n\3\13\3\13\6\13l\n\13\r\13\16\13m\3\f\3\f\5\fr"+
		"\n\f\3\f\6\fu\n\f\r\f\16\fv\3\r\3\r\3\16\3\16\3\16\6\16~\n\16\r\16\16"+
		"\16\177\3\17\3\17\3\17\6\17\u0085\n\17\r\17\16\17\u0086\3\20\5\20\u008a"+
		"\n\20\3\20\6\20\u008d\n\20\r\20\16\20\u008e\3\21\3\21\3\21\3\21\3\22\3"+
		"\22\3\23\3\23\3\24\3\24\7\24\u009b\n\24\f\24\16\24\u009e\13\24\3\25\3"+
		"\25\3\26\3\26\7\26\u00a4\n\26\f\26\16\26\u00a7\13\26\3\27\3\27\5\27\u00ab"+
		"\n\27\3\27\3\27\2\2\30\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\2\25\2\27"+
		"\2\31\2\33\13\35\f\37\r!\16#\2%\2\'\17)\2+\2-\20\3\2\r\3\2$$\3\2\62;\4"+
		"\2GGgg\5\2\62;CHch\4\2ZZzz\4\2DDdd\3\2\62\63\t\2\f\f\17\17\"\"*+==]]_"+
		"_\n\2\f\f\17\17\"\"%%)+==]]__\6\2\13\f\17\17\"\"..\4\2\f\f\17\17\2\u00b9"+
		"\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2"+
		"\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2"+
		"\2!\3\2\2\2\2\'\3\2\2\2\2-\3\2\2\2\3/\3\2\2\2\5\61\3\2\2\2\7\63\3\2\2"+
		"\2\t\65\3\2\2\2\13\67\3\2\2\2\r9\3\2\2\2\17;\3\2\2\2\21`\3\2\2\2\23g\3"+
		"\2\2\2\25i\3\2\2\2\27o\3\2\2\2\31x\3\2\2\2\33z\3\2\2\2\35\u0081\3\2\2"+
		"\2\37\u0089\3\2\2\2!\u0090\3\2\2\2#\u0094\3\2\2\2%\u0096\3\2\2\2\'\u0098"+
		"\3\2\2\2)\u009f\3\2\2\2+\u00a1\3\2\2\2-\u00aa\3\2\2\2/\60\7*\2\2\60\4"+
		"\3\2\2\2\61\62\7+\2\2\62\6\3\2\2\2\63\64\7]\2\2\64\b\3\2\2\2\65\66\7_"+
		"\2\2\66\n\3\2\2\2\678\7)\2\28\f\3\2\2\29:\7%\2\2:\16\3\2\2\2;A\7$\2\2"+
		"<@\n\2\2\2=>\7^\2\2>@\7$\2\2?<\3\2\2\2?=\3\2\2\2@C\3\2\2\2A?\3\2\2\2A"+
		"B\3\2\2\2BD\3\2\2\2CA\3\2\2\2DE\7$\2\2E\20\3\2\2\2FH\7/\2\2GF\3\2\2\2"+
		"GH\3\2\2\2HJ\3\2\2\2IK\t\3\2\2JI\3\2\2\2KL\3\2\2\2LJ\3\2\2\2LM\3\2\2\2"+
		"MN\3\2\2\2Na\5\23\n\2OQ\7/\2\2PO\3\2\2\2PQ\3\2\2\2QR\3\2\2\2RS\7K\2\2"+
		"ST\7p\2\2TU\7h\2\2UV\7k\2\2VW\7p\2\2WX\7k\2\2XY\7v\2\2Ya\7{\2\2Z\\\7/"+
		"\2\2[Z\3\2\2\2[\\\3\2\2\2\\]\3\2\2\2]^\7P\2\2^_\7c\2\2_a\7P\2\2`G\3\2"+
		"\2\2`P\3\2\2\2`[\3\2\2\2a\22\3\2\2\2bc\5\25\13\2cd\5\27\f\2dh\3\2\2\2"+
		"eh\5\25\13\2fh\5\27\f\2gb\3\2\2\2ge\3\2\2\2gf\3\2\2\2h\24\3\2\2\2ik\7"+
		"\60\2\2jl\t\3\2\2kj\3\2\2\2lm\3\2\2\2mk\3\2\2\2mn\3\2\2\2n\26\3\2\2\2"+
		"oq\t\4\2\2pr\7/\2\2qp\3\2\2\2qr\3\2\2\2rt\3\2\2\2su\t\3\2\2ts\3\2\2\2"+
		"uv\3\2\2\2vt\3\2\2\2vw\3\2\2\2w\30\3\2\2\2xy\t\5\2\2y\32\3\2\2\2z{\7\62"+
		"\2\2{}\t\6\2\2|~\5\31\r\2}|\3\2\2\2~\177\3\2\2\2\177}\3\2\2\2\177\u0080"+
		"\3\2\2\2\u0080\34\3\2\2\2\u0081\u0082\7\62\2\2\u0082\u0084\t\7\2\2\u0083"+
		"\u0085\t\b\2\2\u0084\u0083\3\2\2\2\u0085\u0086\3\2\2\2\u0086\u0084\3\2"+
		"\2\2\u0086\u0087\3\2\2\2\u0087\36\3\2\2\2\u0088\u008a\7/\2\2\u0089\u0088"+
		"\3\2\2\2\u0089\u008a\3\2\2\2\u008a\u008c\3\2\2\2\u008b\u008d\t\3\2\2\u008c"+
		"\u008b\3\2\2\2\u008d\u008e\3\2\2\2\u008e\u008c\3\2\2\2\u008e\u008f\3\2"+
		"\2\2\u008f \3\2\2\2\u0090\u0091\7p\2\2\u0091\u0092\7k\2\2\u0092\u0093"+
		"\7n\2\2\u0093\"\3\2\2\2\u0094\u0095\n\t\2\2\u0095$\3\2\2\2\u0096\u0097"+
		"\n\n\2\2\u0097&\3\2\2\2\u0098\u009c\5%\23\2\u0099\u009b\5#\22\2\u009a"+
		"\u0099\3\2\2\2\u009b\u009e\3\2\2\2\u009c\u009a\3\2\2\2\u009c\u009d\3\2"+
		"\2\2\u009d(\3\2\2\2\u009e\u009c\3\2\2\2\u009f\u00a0\t\13\2\2\u00a0*\3"+
		"\2\2\2\u00a1\u00a5\7=\2\2\u00a2\u00a4\n\f\2\2\u00a3\u00a2\3\2\2\2\u00a4"+
		"\u00a7\3\2\2\2\u00a5\u00a3\3\2\2\2\u00a5\u00a6\3\2\2\2\u00a6,\3\2\2\2"+
		"\u00a7\u00a5\3\2\2\2\u00a8\u00ab\5)\25\2\u00a9\u00ab\5+\26\2\u00aa\u00a8"+
		"\3\2\2\2\u00aa\u00a9\3\2\2\2\u00ab\u00ac\3\2\2\2\u00ac\u00ad\b\27\2\2"+
		"\u00ad.\3\2\2\2\25\2?AGLP[`gmqv\177\u0086\u0089\u008e\u009c\u00a5\u00aa"+
		"\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}