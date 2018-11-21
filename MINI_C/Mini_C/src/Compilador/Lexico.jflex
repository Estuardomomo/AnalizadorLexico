package Compilador;
import java_cup.runtime.*;
import javax.swing.JTextArea;

%%

%class ClaseJflex
%char
%line
%column
%cupsym sym
%cup
%cupdebug

%{
    String lexicalError = "";
%}

digits=[0-9]
booleanConstants = ("true"|"false")
doubleConstants = (({digits}+)"."({digits}*)([eE]("+"|"-")?{digits}+)?)
integerConstants = ({digits}?)*[0-9]({digits}*)
hexConstants = 0[xX]((([a-fA-F]?)*({integerConstants}?)*([a-fA-F]?)*)+)
stringConstants = (('([^'\\]|\\.)*')|(\"([^\"\\]|\\.)*\"))
//commentsSymbols=(((\/\/)[^\r\n]*)|(("/*")~("*/")))
commentsSymbols = ((\/\/)(.)*)|("\/\*"~"\*\/")|[0-9]*"pt"|(\/\*)(.)*(\*\/)|"/*"([^\*]|\*[^/])"*/"|"/*"(.)"*/"
commentsMultilineError = (\/\*[^*]*)//)|(("/*")~(\n))
stringError = ((\")~(\n))
whiteSpace=([ \s\t\r] | \r\n | \n | " ")
semicolon = (";")
lParenthesis = ("(")
rParenthesis = (")")
lBrace = ("{")
rBrace = ("}")
lBracket = ("[")
rBracket = ("]")
Comma = (",")
ID=([a-zA-Z]([a-zA-Z_0-9])*)

%{
public String lexeme="";
%}

%%
<YYINITIAL>{
{commentsSymbols} {}
{lBrace} {return new Symbol(sym.lBrace, yycolumn, yyline, yytext());}
{rBrace} {return new Symbol(sym.rBrace, yycolumn, yyline, yytext());}
{lParenthesis} {return new Symbol(sym.lParenthesis, yycolumn, yyline, yytext());}
{rParenthesis} {return new Symbol(sym.rParenthesis, yycolumn, yyline, yytext());}
{lBracket} {return new Symbol(sym.lBracket, yycolumn, yyline, yytext());}
{rBracket} {return new Symbol(sym.rBracket, yycolumn, yyline, yytext());}
"void"     {return new Symbol(sym.VOID, yycolumn, yyline, yytext());}
"class"    {return new Symbol(sym.CLASS, yycolumn, yyline, yytext());}
"extends"   {return new Symbol(sym.EXTENDS, yycolumn, yyline, yytext());}
"implements" {return new Symbol(sym.IMPLEMENTS, yycolumn, yyline, yytext());}
"interface"  {return new Symbol(sym.INTERFACE, yycolumn, yyline, yytext());}
"if"         {return new Symbol(sym.IF, yycolumn, yyline, yytext());}
"else"       {return new Symbol(sym.ELSE, yycolumn, yyline, yytext());}
"for"       {return new Symbol(sym.FOR, yycolumn, yyline, yytext());}
"while"     {return new Symbol(sym.WHILE, yycolumn, yyline, yytext());}
"return"    {return new Symbol(sym.RETURN, yycolumn, yyline, yytext());}
"break"     {return new Symbol(sym.BREAK, yycolumn, yyline, yytext());}
"Print"     {return new Symbol(sym.PRINT, yycolumn, yyline, yytext());}
">="        {return new Symbol(sym.MORETE, yycolumn, yyline, yytext());}
"this"      {return new Symbol(sym.THIS, yycolumn, yyline, yytext());}
"+"         {return new Symbol(sym.PLUS, yycolumn, yyline, yytext());}
"-"         {return new Symbol(sym.MINUS, yycolumn, yyline, yytext());}
"*"         {return new Symbol(sym.TIMES, yycolumn, yyline, yytext());}
"/"         {return new Symbol(sym.DIV, yycolumn, yyline, yytext());}
"%"         {return new Symbol(sym.MOD, yycolumn, yyline, yytext());}
"<"         {return new Symbol(sym.LESST, yycolumn, yyline, yytext());}
"<="        {return new Symbol(sym.LESSTE, yycolumn, yyline, yytext());}
">"         {return new Symbol(sym.MORET, yycolumn, yyline, yytext());}
"=="        {return new Symbol(sym.EQUALTO, yycolumn, yyline, yytext());}
"!="        {return new Symbol(sym.NOEQUAL, yycolumn, yyline, yytext());}
"&&"        {return new Symbol(sym.AND, yycolumn, yyline, yytext());}
"||"        {return new Symbol(sym.OR, yycolumn, yyline, yytext());}
"!"         {return new Symbol(sym.NOT, yycolumn, yyline, yytext());}
"New"       {return new Symbol(sym.NEW_KW, yycolumn, yyline, yytext());}
"NewArray"  {return new Symbol(sym.NEWARRAY_KW, yycolumn, yyline, yytext());}
"ReadInteger"   {return new Symbol(sym.READINT_KW, yycolumn, yyline, yytext());}
"ReadLine"      {return new Symbol(sym.READLINE_KW, yycolumn, yyline, yytext());}
"Malloc"        {return new Symbol(sym.MALLOC_KW, yycolumn, yyline, yytext());}
"."             {return new Symbol(sym.point, yycolumn, yyline, yytext());}
"GetByte"       {return new Symbol(sym.GETBYTE_M, yycolumn, yyline, yytext());}
"SetByte"       {return new Symbol(sym.SETBYTE_M, yycolumn, yyline, yytext());}
"int"       {return new Symbol(sym.intConstantType, yycolumn, yyline, yytext());}
"double"    {return new Symbol(sym.doubleConstantType, yycolumn, yyline, yytext());}
"bool"      {return new Symbol(sym.boolConstantType, yycolumn, yyline, yytext());}
"string"    {return new Symbol(sym.stringConstantType, yycolumn, yyline, yytext());}
"null"      {return new Symbol(sym.NULL, yycolumn, yyline, yytext());}
"[]"        {return new Symbol(sym.BRACKETS, yycolumn, yyline, yytext());}
"="         {return new Symbol(sym.EQUAL, yycolumn, yyline, yytext());}
{booleanConstants}  {return new Symbol(sym.booleanConstants, yycolumn, yyline, yytext());}
{integerConstants} | {hexConstants}   {return new Symbol(sym.integerConstants, yycolumn, yyline, new Integer(yytext()));}
{doubleConstants}  {return new Symbol(sym.doubleConstants, yycolumn, yyline, new Double(yytext()));}
{stringConstants}  {return new Symbol(sym.stringConstants, yycolumn, yyline, yytext());}
{semicolon} {return new Symbol(sym.semicolon, yycolumn, yyline, yytext());}
{Comma}     {{return new Symbol(sym.comma, yycolumn, yyline, yytext());}}
{ID}  {return new Symbol(sym.ident, yycolumn, yyline, yytext());}
[\t\r]      {}
[\r\n]+    {}
{whiteSpace}  {}
[\s\t\r\v\f]   {}
}
. | {commentsMultilineError} {lexicalError +="Linea: " + yyline + " Col: " + yycolumn + "Error léxico. Texto: " + yytext()  +"\r\n";}




