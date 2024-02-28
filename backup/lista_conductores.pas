unit Lista_Conductores;

{$mode ObjFPC}{$H+}

interface

uses
  crt, SysUtils, Arch_Conductores, Estilo;

type
  T_Dato = T_Conductores;

  T_Punt = ^T_Nodo;

  T_Nodo = record
    info:T_Dato;
    sig:T_Punt;
  end;

  T_ListaConductores = record
    cab, act:T_Punt;
    tam:Byte;
  end;

  procedure CrearListaConductores(var L:T_ListaConductores; var arch:T_ArchConductores);
  procedure ImprimirListaConductores(L:T_ListaConductores; conScoring:Boolean);
  Procedure EliminarListaConductores(var L:T_ListaConductores);
  procedure AgregarLista(var L:T_ListaConductores; X:T_Dato);

  Procedure ImprimirCabeceraTabla;
  Procedure ImprimirUsuario(X:T_Conductores; counter:Integer);

implementation

  procedure CrearListaConductores(var L:T_ListaConductores; var arch:T_ArchConductores);
  var
    i:Integer;
    X:T_Conductores;
  begin
    L.tam:=0;
    L.cab:=nil;

    if TamConductores(arch)>0 then
    begin
      for i:=0 to TamConductores(arch)-1 do
      begin
           X:=LeerConductor(arch, i);
           AgregarLista(L, X);
      end;
    end;

    writeln('Lista de "conductores" creada...')
  end;

  procedure AgregarLista(var L:T_ListaConductores; X:T_Dato);
  var
     dir,ant,act:T_Punt;
  begin
    new(dir);
    dir^.info:= X;

    if (L.cab = nil) or (AnsiUpperCase(L.cab^.info.apynom) > AnsiUpperCase(X.apynom)) then
    begin
      dir^.sig:= L.cab;
      L.cab:= dir;
    end
    else
    begin
      ant:=L.cab;
      act:= L.cab^.sig;

      while (act <> nil) and (AnsiUpperCase(act^.info.apynom) < AnsiUpperCase(X.apynom)) do
      begin
        ant:= act;
        act:= act^.sig;
      end;

      ant^.sig:=dir;
      dir^.sig:= act;

    end;
    inc(L.tam);
  end;

  function TamLista(L:T_ListaConductores):byte;
  begin
    TamLista:= L.tam;
  end;

  function Recuperar(var L:T_ListaConductores):T_Dato; // Recuperar(L, X);
  begin
    Recuperar:= L.act^.info;
  end;

  procedure Eliminar(var L:T_ListaConductores; buscado:T_Dni);
  var
     act,ant:T_Punt;
  begin
    if (L.cab^.info.dni = buscado) then
    begin
      act:=L.cab;
      L.cab:=L.cab^.sig;
      dispose(act);
    end
    else
    begin
      ant:= L.cab;
      act:= L.cab^.sig;

      while(act <> nil) and (act^.info.dni < buscado) do
      begin
        ant:=act;
        act:=act^.sig;
      end;

      ant^.sig:= act^.sig;
      dispose(act);
    end;
    dec(L.tam, 1);
  end;

  procedure ImprimirListaConductores(L:T_ListaConductores; conScoring:Boolean);
  var
    X:T_Dato;
    act:T_Punt;
    counter:byte;
  begin
    act:= L.cab;
    counter:= 1;

    ImprimirCabeceraTabla;

    while (act <> nil) do
    begin
      X:= act^.info;

      if conScoring = True then
      begin
        if X.scoring <= 0 then
           ImprimirUsuario(X, counter);
      end
      else
      begin
        ImprimirUsuario(X, counter);
      end;
      act:=act^.sig;

      inc(counter);
    end;
    readkey;
  end;

  Procedure EliminarListaConductores(var L:T_ListaConductores);
  var
    X:T_Dato;
    act,ant:T_Punt;
    counter:byte;
  begin
    act:= L.cab;
    counter:=0;

    while (act <> nil) do
    begin
      ant:=act;
      act:=ant^.sig;
      Dispose(ant);

      inc(counter);
    end;

    writeln(counter, ' elementos eliminados de la lista.');
  end;

  procedure ImprimirCabeceraTabla;
  begin
    writeln(' #  | Apellido y Nombre         | DNI       | Scoring | Habilitado | Activo');
    writeln('---------------------------------------------------------------------------');
  end;

  procedure ImprimirUsuario(X:T_Conductores; counter:Integer);
  begin
     write(counter:3, ' | ', Format('%-25.25s', [X.apynom]), ' | ', Format('%-9.9s', [X.dni]),' | ', Format('%-7d', [X.scoring]),' | ');

    if X.cantidad_reincidencias > 0 then
    begin
      TextColor( Oragne );
      Write(Format('%-7d', [X.scoring]));
    end
    else
    begin
      TextColor( Red);
      Write('NO        ');
    end;
    CambiarTexto();

    if X.habilitado then
    begin
      TextColor( Green );
      Write('SI        ');
    end
    else
    begin
      TextColor( Red);
      Write('NO        ');
    end;
    CambiarTexto();

    write(' | ');

    if X.activo then
    begin
      TextColor( Green );
      Writeln('SI');
    end
    else
    begin
      TextColor( Red);
      Writeln('NO');
    end;
    CambiarTexto();
  end;
end.

