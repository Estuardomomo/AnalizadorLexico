/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Compilador;

/**
 *
 * @author User_Len
 */
public class Element {
    private String Nombre; //Sintetizado
    private String Tipo;    //Heredado - Sintetizado
    private String Valor;   //Sintetizado
    private String Contexto;    //Heredado
    private String Instruccion; //Heredado
    private String Parametro;   //Igual que tipo
    public Element(String MyName, String MyType, String MyValue, String MyContext, String MyInstruction){
        this.Nombre = MyName;
        this.Tipo = MyType;
        this.Valor = MyValue;
        this.Contexto = MyContext;
        this.Instruccion = MyInstruction;
        this.Parametro = "-------";
    }
    public String ObtenerNombre(){
        return this.Nombre ;
    }
    public String ObtenerTipo(){
        return this.Tipo ;
    }
    public String ObtenerValor(){
        return this.Valor ;
    }
    public String ObtenerContexto(){
        return this.Contexto ;
    }
    public String ObtenerInstruccion(){
        return this.Instruccion ;
    }
    public String ObtenerParametro(){
        return this.Parametro;
    }
    public void EstablecerValor(String Dato){
        this.Valor = Dato;
    }
    public void EstablecerParametro(String Dato){
        this.Parametro = Dato;
    }
}
