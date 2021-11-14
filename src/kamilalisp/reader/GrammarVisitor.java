// Generated from /home/palaiologos/Desktop/kamilalisp/src/kamilalisp/reader/Grammar.g4 by ANTLR 4.9.1
package kamilalisp.reader;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link GrammarParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface GrammarVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link GrammarParser#file_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFile_(GrammarParser.File_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#form}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForm(GrammarParser.FormContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#form_rem}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForm_rem(GrammarParser.Form_remContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#forms}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForms(GrammarParser.FormsContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#any_list}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAny_list(GrammarParser.Any_listContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#list_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitList_(GrammarParser.List_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#sqlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSqlist(GrammarParser.SqlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#reader_macro}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReader_macro(GrammarParser.Reader_macroContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#quote}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitQuote(GrammarParser.QuoteContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#map}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMap(GrammarParser.MapContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#fork}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFork(GrammarParser.ForkContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#tack}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTack(GrammarParser.TackContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#bind}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBind(GrammarParser.BindContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteral(GrammarParser.LiteralContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#string_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitString_(GrammarParser.String_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#hex_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitHex_(GrammarParser.Hex_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#bin_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBin_(GrammarParser.Bin_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#number}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNumber(GrammarParser.NumberContext ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#nil_}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNil_(GrammarParser.Nil_Context ctx);
	/**
	 * Visit a parse tree produced by {@link GrammarParser#symbol}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSymbol(GrammarParser.SymbolContext ctx);
}