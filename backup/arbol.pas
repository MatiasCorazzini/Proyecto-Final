unit ArbolConductores;

interface

uses
  crt, Arch_Conductores;

type
  T_Elem = record
    key:Integer;
    pos:Integer;
  end;

  T_Arbol = ^T_Nodo;

  T_Nodo = Record
    raiz:T_Elem;
    izq:T_Arbol;
    der:T_Arbol;
  end;


implementation

Procedure Insertar(var arbol:T_Arbol; elem:T_Elem);
begin
  if arbol = Nil then
  begin
    New(arbol);
    arbol^.raiz:= elem;
    arbol^.izq:= Nil;
    arbol^.der:= Nil;
  end;

  if elem.dni < arbol^.raiz.key then
    Insertar(arbol^.izq, elem)            // Recursividad, repite hasta que encuentre nil
  else
    Insertar(arbol^.der, elem);           // Recursividad, repite hasta que encuentre nil
end;

Procedure CrearArbol(var arbol:T_Arbol; arch:T_ArchConductores);
var
  i:Integer;
  C:T_Conductores;
  elem:T_Elem;
begin
  for i:=1 to TamConductores(arch) do
  begin
    Read(arch, i, C);
    elem.key:= C.dni;
    elem.pos:= i;

    Insertar(arbol, elem);
  end;
  Writeln('Arbol creado...');
end;

Function BuscarArbol(arbol:T_Arbol, key:Integer):Integer;
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

