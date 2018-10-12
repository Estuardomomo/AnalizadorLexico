import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java_cup.runtime.Symbol;
import java_cup.runtime.*;
class Yytoken {
    Yytoken (int numToken,String token, String tipo, int linea, int columna){
        //Contador para el número de tokens reconocidos
        this.numToken = numToken;
        //String del token reconocido
        this.token = new String(token);
        //Tipo de componente léxico encontrado
        this.tipo = tipo;
        //Número de linea
        this.linea = linea;
        //Columna donde empieza el primer carácter del token
        this.columna = columna;
    }
    //Métodos de los atributos de la clase
    public int numToken;
    public String token;
    public String tipo;
    public int linea;
    public int columna;
    //Metodo que devuelve los datos necesarios que escribiremos en un archivo de salida
    public String toString() {
        return "Token #"+numToken+": "+token+" C.Lexico: "+tipo+" ["+linea
        + "," +columna + "]";
    }
}
%%
%{
//Agregados propios a la clase Yylex
public File archivoSalida;
private RandomAccessFile raf;
public void Abrir() throws FileNotFoundException{
    raf = new RandomAccessFile(archivoSalida,"rw");
}

public void Cerrar() throws IOException{
    raf.close();
}

%}
%function nextToken
%line
%column
%ignorecase
//Abecedario
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
//Palabras reservadas & constantes en tiempo de compilación
vvoid = void
iint = int
ddouble = double
bbool = bool
sstring = string
cclass = class
iinterface = interface
nnull = null
tthis = this
eextends = extends
iimplements = implements
ffor = for
wwhile = while
iif = if
eelse = else
rreturn = return
bbreak = break
NNew = New
NNewArray = NewArray
//Nuevas palabras reservadas
PPrint = Print
RReadInteger = ReadInteger
RReadLine = ReadLine
MMalloc = Malloc

//Identificador
Identificador = [a-zA-Z_][a-zA-Z0-9_\x7f-\xff]{0,30}
//Espacios en blanco
EXP_ESPACIO = \n|\r\n|" "|\r|\t|\s
//Comentarios
ComentarioSimple = ("//")(.)*
ComentarioMultiple = "/*"~"*/"
//constantes
boolean = "true"|"false"
decimal	= [0-9][0-9]*|0
hexadecimal = 0[xX][0-9a-fA-F]+
integer = decimal| hexadecimal
LNUM = [0-9]+
DNUM = ({LNUM}[\.][0-9]*)
EXPONENT_DNUM = [+-]?({DNUM} [eE][+-]? {LNUM})
double = {DNUM}|{EXPONENT_DNUM}
string = ('([^'\\]|\\.)*')|(\"([^\"\\]|\\.)*\")|"/*"~"*/"
//Operadores y caracteres de puntuación
operadoreslogicos = "&&"|"||"|"!"
operadoresAritmeticos = "+"|"-"|"/"|"*"|"%"
operadoresComparativo = "=="|"!="|"<"|">"|"<="|">="
operadoresAsignacion = "=" 
Punto = "."
Coma = ","
PuntoyComa =";"
ParentesisA = "("
ParentesisC = ")"
LlavesA = "{"
LlavesC = "}"
CorchetesA = "["
CorchetesC = "]"
//Agrupaciones - Entidades que devolverán un texto
Comentario = {ComentarioSimple}|{ComentarioMultiple}
ErrorEspecial = "/*"("*"[^/]|[^*/]|[^*]"/")*
%%
{vvoid} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tvvoid, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{iint} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tiint, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{ddouble} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tddouble, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{bbool} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tbbool, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{sstring} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tsstring, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{cclass} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tcclass, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{iinterface} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tiinterface, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{nnull} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tnnull, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{tthis} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.ttthis, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{eextends} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.teextends, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{iimplements} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tiimplements, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{ffor} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tffor, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{wwhile} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.twwhile, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{iif} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tiif, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{eelse} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.teelse, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{rreturn} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.trreturn, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{bbreak} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tbbreak, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{NNew} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tNNew, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{NNewArray} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tNNewArray, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{PPrint} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tPPrint, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{RReadInteger} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tRReadInteger, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{RReadLine} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tRReadLine, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{MMalloc} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PalabraReservada \r\n");
        return new Symbol(sym.tMMalloc, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{string} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Tipo String \r\n");
        return new Symbol(sym.tstring, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{operadoreslogicos} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" OperadorL \r\n");
        return new Symbol(sym.toperadoreslogicos, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{operadoresAritmeticos} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" OperadorAr \r\n");
        return new Symbol(sym.toperadoresAritmeticos, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{operadoresComparativo} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" OperadorC \r\n");
        return new Symbol(sym.toperadoresComparativo, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{operadoresAsignacion} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" OperadorAs \r\n");
        return new Symbol(sym.toperadoresAsignacion, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{Comentario} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Comentario \r\n");
        return new Symbol(sym.tComentario, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{Punto} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Punto \r\n");
        return new Symbol(sym.tPunto, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{Coma} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Coma \r\n");
        return new Symbol(sym.tComa, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{PuntoyComa} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" PuntoyComa \r\n");
        return new Symbol(sym.tPuntoyComa, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{ParentesisA} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Parentesis \r\n");
        return new Symbol(sym.tParentesisA, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{ParentesisC} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Parentesis \r\n");
        return new Symbol(sym.tParentesisC, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{LlavesA} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Llaves \r\n");
        return new Symbol(sym.tLlavesA, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{LlavesC} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Llaves \r\n");
        return new Symbol(sym.tLlavesC, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{CorchetesA} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Corchetes \r\n");
        return new Symbol(sym.tCorchetesA, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{CorchetesC} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+" Corchetes \r\n");
        return new Symbol(sym.tCorchetesC, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{integer} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+"Entero \r\n");
        return new Symbol(sym.tinteger, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{double} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+"Double \r\n");
        return new Symbol(sym.tdouble, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{boolean} {
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+"Boolean \r\n");
        return new Symbol(sym.tboolean, yycolumn, yyline, yytext());
        } catch(IOException ex){}}
{Identificador} { 
    try{
        raf.writeBytes("Simbolo: " + yytext() + " Fila: " + Integer.toString(yyline) + " Columna: "+ Integer.toString(yycolumn)+"Identificador \r\n");
        return new Symbol(sym.tIdentificador, yycolumn, yyline, yytext());
        } catch(IOException ex){} }
{EXP_ESPACIO} {
    try{ } catch(IOException ex){}}

    //ERRORES
. {
    try{raf.writeBytes("*** Error linea " + Integer.toString(yyline) + ". *** Caracter no reconocido: " + yytext() + " \n");} catch(IOException ex){}
}

