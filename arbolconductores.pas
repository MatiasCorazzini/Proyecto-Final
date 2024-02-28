unit ArbolConductores;

interface

uses
  SysUtils, crt, Arch_Conductores;

type

  T_Elem = record
    key:T_Dni;
    pos:Integer;
  end;

  T_Arbol = ^T_Nodo;

  T_Nodo = Record
    raiz:T_Elem;
    izq:T_Arbol;
    der:T_Arbol;
  end;

  Procedure Insertar(var arbol:T_Arbol; elem:T_Elem);
  Procedure CrearArbol(var arbol:T_Arbol; var arch:T_ArchConductores);
  Procedure InsertarConductor(var arbol:T_Arbol; var arch:T_ArchConductores; X:T_Conductores);
  Function BuscarArbol(var arbol:T_Arbol; key:T_Dni):Integer;

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

  Procedure CrearArbol(var arbol:T_Arbol; var arch:T_ArchConductores);
  var
    i:Integer;
    C:T_Conductores;
    elem:T_Elem;
  begin
    arbol := nil; // Inicializar el árbol

    if TamConductores(arch) > 0 then
    begin
      for i:=0 to TamConductores(arch)-1 do
      begin
        C:= LeerConductor(arch, i);
        elem.key:= C.dni;
        elem.pos:= i;

        Insertar(arbol, elem);
      end;
    end;
    Writeln('Arbol creado...');
  end;

  Procedure InsertarConductor(var arbol:T_Arbol; var arch:T_ArchConductores; X:T_Conductores);
  var
    elem:T_Elem;
  begin
      elem.key:= X.dni;
      elem.pos:= TamConductores(arch)-1;

      Insertar(arbol, elem);
  end;

  Function BuscarArbol(var arbol:T_Arbol; key:T_Dni):Integer;
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


