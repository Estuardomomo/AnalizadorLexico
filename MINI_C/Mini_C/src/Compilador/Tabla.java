/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Compilador;


import java.util.Collection;
import java.util.HashMap;

/**
 *
 * @author User_Len
 */
public class Tabla {
    public static HashMap<String, Element> Tabla;
    public static String TablaErrores = "";
    public Tabla(){
    }
    public void Insertar(Element Simbolo){
        if(!Tabla.containsKey(Simbolo.ObtenerContexto()+ Simbolo.ObtenerNombre())){
            Tabla.put(Simbolo.ObtenerContexto()+ Simbolo.ObtenerNombre(), Simbolo);
        }
        else {
            TablaErrores += "Ya existe un token con este identificador dentro del contexto. \n ";
        }
    }
    public Boolean Consultar(String Llave){
        return Tabla.containsKey(Llave);
    }
    public Element ObtenerElemento(String Llave){
        return Tabla.get(Llave);
    }
    public void ModificarValor(String Llave, String Valor){
        if(Consultar(Llave)){
            Element Auxiliar = Tabla.get(Llave);
            Auxiliar.EstablecerValor(Valor);
            Tabla.put(Llave, Auxiliar);
        }
    }
    public Collection<Element> Elementos(){
        return this.Tabla.values();
    }
    public String RetirarContexto(String Ambiente){
        String Contexto = Ambiente;
        String[] ArregloContextos = Contexto.split(".");
         Contexto = "Global";
         for (int i = 0; i < ArregloContextos.length-2; i++) {
            Contexto += "."+ ArregloContextos[i];
        }
         return Contexto;
    }
}
