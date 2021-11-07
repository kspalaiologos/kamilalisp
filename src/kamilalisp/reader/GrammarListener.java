// Generated from /home/palaiologos/Desktop/kamilalisp/src/kamilalisp/reader/Grammar.g4 by ANTLR 4.9.1
package kamilalisp.reader;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link GrammarParser}.
 */
public interface GrammarListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link GrammarParser#file_}.
	 * @param ctx the parse tree
	 */
	void enterFile_(GrammarParser.File_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#file_}.
	 * @param ctx the parse tree
	 */
	void exitFile_(GrammarParser.File_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#form}.
	 * @param ctx the parse tree
	 */
	void enterForm(GrammarParser.FormContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#form}.
	 * @param ctx the parse tree
	 */
	void exitForm(GrammarParser.FormContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#forms}.
	 * @param ctx the parse tree
	 */
	void enterForms(GrammarParser.FormsContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#forms}.
	 * @param ctx the parse tree
	 */
	void exitForms(GrammarParser.FormsContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#any_list}.
	 * @param ctx the parse tree
	 */
	void enterAny_list(GrammarParser.Any_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#any_list}.
	 * @param ctx the parse tree
	 */
	void exitAny_list(GrammarParser.Any_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#list_}.
	 * @param ctx the parse tree
	 */
	void enterList_(GrammarParser.List_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#list_}.
	 * @param ctx the parse tree
	 */
	void exitList_(GrammarParser.List_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#sqlist}.
	 * @param ctx the parse tree
	 */
	void enterSqlist(GrammarParser.SqlistContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#sqlist}.
	 * @param ctx the parse tree
	 */
	void exitSqlist(GrammarParser.SqlistContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#reader_macro}.
	 * @param ctx the parse tree
	 */
	void enterReader_macro(GrammarParser.Reader_macroContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#reader_macro}.
	 * @param ctx the parse tree
	 */
	void exitReader_macro(GrammarParser.Reader_macroContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#quote}.
	 * @param ctx the parse tree
	 */
	void enterQuote(GrammarParser.QuoteContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#quote}.
	 * @param ctx the parse tree
	 */
	void exitQuote(GrammarParser.QuoteContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#fork}.
	 * @param ctx the parse tree
	 */
	void enterFork(GrammarParser.ForkContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#fork}.
	 * @param ctx the parse tree
	 */
	void exitFork(GrammarParser.ForkContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#tack}.
	 * @param ctx the parse tree
	 */
	void enterTack(GrammarParser.TackContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#tack}.
	 * @param ctx the parse tree
	 */
	void exitTack(GrammarParser.TackContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#bind}.
	 * @param ctx the parse tree
	 */
	void enterBind(GrammarParser.BindContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#bind}.
	 * @param ctx the parse tree
	 */
	void exitBind(GrammarParser.BindContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#literal}.
	 * @param ctx the parse tree
	 */
	void enterLiteral(GrammarParser.LiteralContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#literal}.
	 * @param ctx the parse tree
	 */
	void exitLiteral(GrammarParser.LiteralContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#string_}.
	 * @param ctx the parse tree
	 */
	void enterString_(GrammarParser.String_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#string_}.
	 * @param ctx the parse tree
	 */
	void exitString_(GrammarParser.String_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#hex_}.
	 * @param ctx the parse tree
	 */
	void enterHex_(GrammarParser.Hex_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#hex_}.
	 * @param ctx the parse tree
	 */
	void exitHex_(GrammarParser.Hex_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#bin_}.
	 * @param ctx the parse tree
	 */
	void enterBin_(GrammarParser.Bin_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#bin_}.
	 * @param ctx the parse tree
	 */
	void exitBin_(GrammarParser.Bin_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#number}.
	 * @param ctx the parse tree
	 */
	void enterNumber(GrammarParser.NumberContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#number}.
	 * @param ctx the parse tree
	 */
	void exitNumber(GrammarParser.NumberContext ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#nil_}.
	 * @param ctx the parse tree
	 */
	void enterNil_(GrammarParser.Nil_Context ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#nil_}.
	 * @param ctx the parse tree
	 */
	void exitNil_(GrammarParser.Nil_Context ctx);
	/**
	 * Enter a parse tree produced by {@link GrammarParser#symbol}.
	 * @param ctx the parse tree
	 */
	void enterSymbol(GrammarParser.SymbolContext ctx);
	/**
	 * Exit a parse tree produced by {@link GrammarParser#symbol}.
	 * @param ctx the parse tree
	 */
	void exitSymbol(GrammarParser.SymbolContext ctx);
}