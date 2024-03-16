unit ArbolConductores;

interface

uses
  SysUtils, crt;

type

  T_Elem = record
    key:String[100];
    pos:Integer;
  end;

  T_Arbol = ^T_Nodo;

  T_Nodo = Record
    raiz:T_Elem;
    izq:T_Arbol;
    der:T_Arbol;
  end;

  Procedure Insertar(var arbol:T_Arbol; elem:T_Elem);
  Function BuscarArbol(var arbol:T_Arbol; key:String):Integer;

implementation

  Procedure Insertar(var arbol:T_Arbol; elem:T_Elem);
  begin
    if arbol = Nil then
    begin
      New(arbol);
      arbol^.raiz:= elem;
      arbol^.izq:= Nil;
      arbol^.der:= Nil;
    end
    else
    begin
      if elem.key < arbol^.raiz.key then
        Insertar(arbol^.izq, elem)            // Recursividad, repite hasta que encuentre nil
      else
        Insertar(arbol^.der, elem);           // Recursividad, repite hasta que encuentre nil
    end;
  end;

  Function BuscarArbol(var arbol:T_Arbol; key:String):Integer;
  begin
    if (arbol = Nil) then
      BuscarArbol:= -1

    else if (arbol^.raiz.key = key) then
      BuscarArbol:= arbol^.raiz.pos

    else if (key < arbol^.raiz.key) then
      BuscarArbol:= BuscarArbol(arbol^.izq, key)

    else
      BuscarArbol:= BuscarArbol(arbol^.der, key);
  end;

end.


