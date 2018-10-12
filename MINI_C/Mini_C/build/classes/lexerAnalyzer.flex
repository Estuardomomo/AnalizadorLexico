package lexicalanalyzerphp;

import java_cup.runtime.Symbol;
import java_cup.runtime.*;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;

    
class Yytoken {
    Yytoken (String token, String tipoDeToken, int lineaUbicada, int posicionEnLinea){
        //String del token reconocido
        this.token = new String(token);
        //Tipo de componente léxico encontrado
        this.tipoDeToken = tipoDeToken;
        //Número de linea
        this.lineaUbicada = lineaUbicada;
        //Columna donde empieza el primer carácter del token
        this.posicionEnLinea = posicionEnLinea;
    }
    //Métodos de los atributos de la clase
    public String token;
    public String tipoDeToken;
    public int lineaUbicada;
    public int posicionEnLinea;
    //Yytoken objObjetoYyToken;

}
%%
%public

%line
%column

%implements java_cup.runtime.Scanner
%function next_token
%type java_cup.runtime.Symbol

%char
%full
%unicode

%{
//Variables
    BufferedWriter writer = null;   
    String nombrePathSalida="";
    ArrayList<Yytoken> objListaTokenValidos = new ArrayList<Yytoken>();
    ArrayList<Yytoken> objListaTokenInvalidos = new ArrayList<Yytoken>();
    ArrayList<Yytoken> objListaTokenOriginal = new ArrayList<Yytoken>();
    ArrayList<Yytoken> TokenError = new ArrayList<Yytoken>();
    windowUserForm objForm = new windowUserForm();
    Yytoken objObjetoYyToken;

public void setNombrePath(String ipath){
    nombrePathSalida=ipath+".out";
}

public void agregarTokenValidoALista(Yytoken iobjToken){
    objListaTokenValidos.add(iobjToken);
}   

public void agregarTokenInvalidoALista(Yytoken iobjToken){
    objListaTokenInvalidos.add(iobjToken);
}

public void agregarTokenOriginal(Yytoken iObjToken){
    objListaTokenOriginal.add(iObjToken);
}

public ArrayList getListaOrginal(){
    return objListaTokenOriginal;
}

public ArrayList getListaValidos(){
    return objListaTokenValidos;
}

public ArrayList getListaInvalidos(){
    return objListaTokenInvalidos;
}




public void escribirArchivo(){

    try{
        writer= new BufferedWriter(new FileWriter(nombrePathSalida));

        for(int i=0; i<objListaTokenValidos.size();i++){
            String token = objListaTokenValidos.get(i).token;
            String tipoToken = objListaTokenValidos.get(i).tipoDeToken;
            String lineaUbicada=Integer.toString(objListaTokenValidos.get(i).lineaUbicada+1);
            String posicionEnLinea=Integer.toString(objListaTokenValidos.get(i).posicionEnLinea+1);

            int auxPos=Integer.parseInt(posicionEnLinea);
            int auxPosAPos=auxPos+token.length()-1;

            if(tipoToken.contains("Error")){
                writer.write("*** Error Line "+lineaUbicada+".*** "+"Unrecognized char: "+"'"+token+"'");
            }else if(tipoToken.contains("T_IntType")||tipoToken.contains("T_DoubleType")||tipoToken.contains("T_BoolType")) {
                writer.write(token+"    " + "Line "+lineaUbicada+" cols "+posicionEnLinea+"-"+auxPosAPos+ " is "+tipoToken +" (value = "+token+ ")" );
            }else if(tipoToken.contains("T_Punctuation")||tipoToken.contains("T_Operador")) {
                writer.write(token+"    " + "Line "+lineaUbicada+" cols "+posicionEnLinea+"-"+auxPosAPos+ " is "+"'"+token+"'");
            }else{
                writer.write(token+"    " + "Line "+lineaUbicada+" cols "+posicionEnLinea+"-"+auxPosAPos+ " is "+tipoToken);
            }





            writer.newLine();
        }
        writer.close();

    } catch (Exception e) {
            System.out.println(e);
        }
}

%}

%eof{ 
    escribirArchivo();
%eof}

// Estructura Lexicografica, los siguientes tokens son del lenguaje Mini C#

//~~~~~~~~~~ Alfabeto Permitido ~~~~~~~~~~
a = [aA]
b = [bB]
c = [cC]
d = [dD]
e = [eE]
f = [fF]
g = [gG]
h = [hH]
i = [iI]
j = [jJ]
k = [kK]
l = [lL]
m = [mM]
n = [nN]
o = [oO]
p = [pP]
q = [qQ]
r = [rR]
s = [sS]
t = [tT]
u = [uU]
v = [vV]
w = [wW]
x = [xX]
y = [yY]
z = [zZ]

//escaped = \\n|\\r|\\t|\\v|\\e|\\f|\\\\|\\"$"|\\[0-7]{1,3}|\\xu0-9A-Fa-f]+|\\.
decimal	= [0-9][0-9]*|0
hexadecimal = 0[xX][0-9a-fA-F]+
label = [a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*
label_Error = [a-zA-Z_\x7f-\xff] ([a-zA-Z0-9_\x7f-\xff])*
space= [ \t\r]+


//~~~~~~~~~~ PALABRAS RESERVADAS ~~~~~~~~~~

reserved_words = void|int|double|bool|string|class|interface|null|this|extends|implements|for|while|if|else|return|break|NewArray|New|Array|new|array

//Nuevas para Cup
int = int
extends = extends
class = class
implements = implements
interface = interface
if = if
Print = Print
this = this
malloc = Malloc
readInteger = ReadInteger
readLine = ReadLine
null = null
newArr = NewArray
getByte = GetByte
setByte = SetByte
new = new

blank = [\n]|[\n\r]|[ ]

//~~~~~~~~~~ Identificadores ~~~~~~~~~~

identifier = {label}
identifier_Error = {label_Error}

//~~~~~~~~~~ Comentarios ~~~~~~~~~~

single_line_comment = ("//")(.)*
multiline_comment = (("/*")~("*/"))
commentSingleLineOrMultiline = {single_line_comment}|{multiline_comment}
multiline_error = "/*"("*"[^/]|[^*/]|[^*]"/")*



//~~~~~~~~~~ Structuras de Control ~~~~~~~~~~

if = if
else = else
elseif = elseif
endif =	endif
while =	while
do = do
for = for
break =	break
switch = switch
case = case
include = include
continue = continue
return = return
control_struct = ({if}|{else}|{elseif}|{endif}|{while}|{do}|{for}|{break}|{switch}|{case}|{continue}|{return}|{include})

//~~~~~~~~~~ Operadores Logicos ~~~~~~~~~~

aritmetic_operators = "+"|"-"|"*"|"/"|"%"
comparation_operators = "<"|">"|"<="|">="|"=="|"!="
logic_operators = "&&"|"||"
logic_operators_neg = "!"

assignment_operators = "="|"+="|"-="|"*="|"/="|"%="
increment_falling_operators = "++"|"--"

parenthesis_2 = "()"
parenthesis_1 = "("
parenthesis_3 = ")"

curly_2 = "{}"
curly_1 = "{"
curly_3 = "}"

bracket_2 = "[]"
bracket_1 = "["
bracket_3 = "]"

semicolon = ";"
comma = ","|"."

//~~~~~~~~~~ Tipo de Dato ~~~~~~~~~~

bool_type = true|false
int_type = ({decimal}|{hexadecimal})
double_type = [0-9]+\.[0-9]*([eE]{int_type}.?[0-9]*)?
string_type = (\"([^\"\\\n]|\\.)*\")

puntation = \.
newLine=\n
error = .|{multiline_error}|"=!="



%%
//TOKENS QUE DEVUELVE

"-" {
    objObjetoYyToken = new Yytoken(yytext(),"T_Minus",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.minus, yycolumn, yyline, yytext());
}

{semicolon} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.pyc, yycolumn, yyline, yytext());
}

{new} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_new, yycolumn, yyline, yytext());
}

{class} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.clase, yycolumn, yyline, yytext());
}

{implements} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_implements, yycolumn, yyline, yytext());
}

{interface} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_interface, yycolumn, yyline, yytext());
}

{if} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_if, yycolumn, yyline, yytext());  
}

{else} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_else, yycolumn, yyline, yytext());
}

{for} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_for, yycolumn, yyline, yytext());
}

{while} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_while, yycolumn, yyline, yytext());
}

{return} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_return, yycolumn, yyline, yytext());
}

{break} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_break, yycolumn, yyline, yytext());
}

{Print} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.print, yycolumn, yyline, yytext());
}

{this} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_this, yycolumn, yyline, yytext());
}

{malloc} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.malloc, yycolumn, yyline, yytext());
}

{readInteger} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.readInteger, yycolumn, yyline, yytext());
}

{readLine} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.ReadLine, yycolumn, yyline, yytext());
}

{null} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_null, yycolumn, yyline, yytext());
    
}

{newArr} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_newArr, yycolumn, yyline, yytext());
}
{getByte} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.getByte, yycolumn, yyline, yytext());
}

{setByte} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.setByte, yycolumn, yyline, yytext());
}

{extends} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.extend, yycolumn, yyline, yytext());
}

 int {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_int, yycolumn, yyline, yytext());
}

 double {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_double, yycolumn, yyline, yytext());
}

 bool {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_bool, yycolumn, yyline, yytext());
}

 string {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_string, yycolumn, yyline, yytext());
}

 void {
    objObjetoYyToken = new Yytoken(yytext(),"T_ReserverdWords",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.t_void, yycolumn, yyline, yytext());
}

{commentSingleLineOrMultiline} {
    objObjetoYyToken = new Yytoken(yytext(),"Comment",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);
}

{identifier} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Identifier",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.ident, yycolumn, yyline, yytext());
}

{identifier_Error} {
    objObjetoYyToken = new Yytoken(yytext().substring(0, 30),"Trunc_Identifier",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.identTrunc, yycolumn, yyline, yytext());
}

{string_type} {
    objObjetoYyToken = new Yytoken(yytext(),"T_StringType",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.strConst, yycolumn, yyline, yytext());
}

{control_struct} {
    objObjetoYyToken = new Yytoken(yytext(),"T_ControlStruct",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
}

{puntation} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.dot, yycolumn, yyline, yytext());
}

 [\n]|[\r\n]|[\n\r]} {
    objObjetoYyToken = new Yytoken(yytext(),"New Line",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);
}

 {blank}{blank}+ {
    objObjetoYyToken = new Yytoken(yytext(),"\n",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);    
}

{assignment_operators} {
    objObjetoYyToken = new Yytoken(yytext(),"T_AssigmentOperators",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.equals, yycolumn, yyline, yytext());
}

{increment_falling_operators} {
    objObjetoYyToken = new Yytoken(yytext(),"T_IncrementOrFallingOperators",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.equals, yycolumn, yyline, yytext());
}

{aritmetic_operators} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Operador",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.arop, yycolumn, yyline, yytext());
}

{comparation_operators} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Operador",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.cmpop, yycolumn, yyline, yytext());
}

{logic_operators} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Operador",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.logop, yycolumn, yyline, yytext());
}

{parenthesis_1} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.prnthss_1, yycolumn, yyline, yytext());
}

{parenthesis_2} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    //return new Symbol(sym.prnthss_2, yycolumn, yyline, yytext());
}

{parenthesis_3} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.prnthss_3, yycolumn, yyline, yytext());
}

{curly_1} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.curly_1, yycolumn, yyline, yytext());
}

{bracket_2} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.brackets_2, yycolumn, yyline, yytext());
}

{bracket_3} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.brackets_3, yycolumn, yyline, yytext());
}

{bracket_1} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.brackets_1, yycolumn, yyline, yytext());
}

{logic_operators_neg} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Operador",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.neg, yycolumn, yyline, yytext());
}

{curly_2} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    //return new Symbol(sym.curly_2, yycolumn, yyline, yytext());
}

{curly_3} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Punctuation",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.curly_3, yycolumn, yyline, yytext());
}

{bool_type} {
    objObjetoYyToken = new Yytoken(yytext(),"T_BoolType",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.bolCnst, yycolumn, yyline, yytext());
}

{int_type} {
    objObjetoYyToken = new Yytoken(yytext(),"T_IntType",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.intCnst, yycolumn, yyline, yytext());
}

{double_type} {
    objObjetoYyToken = new Yytoken(yytext(),"T_DoubleType",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.dblConst, yycolumn, yyline, yytext());
}

[ \t\r]+ {
    objObjetoYyToken = new Yytoken(yytext(),"Space",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);
}


{comma} {
    objObjetoYyToken = new Yytoken(yytext(),"T_Comma",yyline,yycolumn);
    agregarTokenValidoALista(objObjetoYyToken);
    agregarTokenOriginal(objObjetoYyToken);
    return new Symbol(sym.comma, yycolumn, yyline, yytext());

}

{multiline_error} {
    objObjetoYyToken = new Yytoken(yytext(),"Error Comentario Multilinea",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);
    agregarTokenInvalidoALista(objObjetoYyToken);
    
}

.|"=!=" {
    objObjetoYyToken = new Yytoken(yytext(),"Error Varios",yyline,yycolumn);
    agregarTokenOriginal(objObjetoYyToken);
    agregarTokenInvalidoALista(objObjetoYyToken);
} 