unit Lista_Infracciones;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, crt, Arch_Infracciones, Arch_Conductores, ArbolConductores, Validadores, Estilo, Conductores, Infracciones;

type
  T_Dato = T_Infracciones;

  T_Punt = ^T_Nodo;

  T_Nodo = record
    info:T_Dato;
    sig:T_Punt;
  end;

  T_ListaInfracciones = record
    cab, act:T_Punt;
    tam:Byte;
  end;

  procedure CrearListaInfracciones(var L:T_ListaInfracciones; var arch:T_ArchInfracciones);

  procedure ImprimirListaInfracciones(var L:T_ListaInfracciones; desde, hasta:String; dni:String);
  Procedure EliminarListaInfracciones(var L:T_ListaInfracciones);
  Procedure AgregarLista(var L:T_ListaInfracciones; X:T_Dato);

  procedure ImprimirCabeceraTabla;
  procedure ImprimirCabeceraTabla2(nombre:String; activo:Boolean);
  procedure ImprimirInfraccionDef(X:T_Infracciones; counter:Integer);
  procedure ImprimirInfraccionCond(X:T_Infracciones; counter:Integer);

  Procedure ListaInfraccionesPeriodo(var L:T_ListaInfracciones);
  Procedure ListaInfraccionesConductor(var L:T_ListaInfracciones; var archConductores:T_ArchConductores; var arbol:T_Arbol);

implementation

  procedure CrearListaInfracciones(var L:T_ListaInfracciones; var arch:T_ArchInfracciones);
  var
    i:Integer;
    X:T_Infracciones;
  begin
    L.tam:=0;
    L.cab:=nil;

    if TamInfracciones(arch)>0 then
    begin
      for i:=0 to TamInfracciones(arch)-1 do
      begin
           X:=LeerInfraccion(arch, i);
           AgregarLista(L, X);
      end;
    end;

    //writeln('Lista de "infracciones" creada...')
  end;

  procedure AgregarLista(var L:T_ListaInfracciones; X:T_Dato);
  var
     dir,ant,act:T_Punt;
  begin
    new(dir);
    dir^.info:= X;

    if (L.cab = nil) or (StrToDate(L.cab^.info.fecha_infraccion) > StrToDate(X.fecha_infraccion)) then
    begin
      dir^.sig:= L.cab;
      L.cab:= dir;
    end
    else
    begin
      ant:=L.cab;
      act:= L.cab^.sig;

      while (act <> nil) and (StrToDate(act^.info.fecha_infraccion) < StrToDate(X.fecha_infraccion)) do
      begin
        ant:= act;
        act:= act^.sig;
      end;

      ant^.sig:=dir;
      dir^.sig:= act;

    end;
    inc(L.tam);
  end;

  procedure ImprimirListaInfracciones(var L:T_ListaInfracciones; desde, hasta:String; dni:String);
  var
    X:T_Dato;
    act:T_Punt;
    counter:byte;

    fecha1,fecha2, fechaMain:TDate;
  begin

    act:= L.cab;
    counter:= 1;

    //writeln('ShortDateFormat ', ShortDateFormat);

    while (act <> nil) do
    begin
      X:= act^.info;

      if (desde = 'def') and (hasta = 'def') then
      begin

        if dni =  '-1' then
        begin
          ImprimirInfraccionDef(X, counter); // Todas las infracciones.
          inc(counter);
        end
        else
        begin
          if dni = X.dni then
          begin
            ImprimirInfraccionCond(X, counter); // Todas las infracciones de un unico DNI
            inc(counter);
          end;
        end;
        act:=act^.sig;
      end
      else
      begin
        fecha1:= StrToDate(desde);
        fecha2:= StrToDate(hasta);
        fechaMain:= StrToDate(X.fecha_infraccion);

        if (fecha1 <= fechaMain) and (fechaMain <= fecha2) then
        begin
          ImprimirInfraccionDef(X, counter); // Entre 2 fechas dadas.

          act:=act^.sig;

          inc(counter);
        end
        else
        begin
          act:=act^.sig;
        end;
      end;
    end;
  end;

  Procedure EliminarListaInfracciones(var L:T_ListaInfracciones);
  var
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

    //writeln(counter, ' elementos eliminados de la lista.');
  end;

  procedure ImprimirCabeceraTabla;
  begin
    writeln(' #  | Fecha de la infraccion    | DNI       | Tipo ');
    writeln('--------------------------------------------------------------------------------');
  end;

  procedure ImprimirCabeceraTabla2(nombre:String; activo:Boolean);
  begin
    write(nombre, ': ');
    if activo then
    begin
      TextColor( Green );
      Writeln('Activo');
    end
    else
    begin
      TextColor( Red);
      Writeln('Inactivo');
    end;
    CambiarTexto();
    writeln(' #  | Fecha de la infraccion    | Puntos | Tipo ');
    writeln('----------------------------------------------------------------------------');
  end;

  procedure ImprimirInfraccionDef(X:T_Infracciones; counter:Integer);
  begin
    writeln(counter:3, ' | ', Format('%-25.25s', [X.fecha_infraccion]), ' | ',  Format('%-9.9s', [X.dni]),' | ', Format('%-30.30s', [X.tipo_infraccion]),'...');
  end;

  procedure ImprimirInfraccionCond(X:T_Infracciones; counter:Integer);
  begin
    writeln(counter:3, ' | ', Format('%-25.25s', [X.fecha_infraccion]), ' | -',  Format('%-5d', [X.puntos_descontar]),' | ', Format('%-30.30s', [X.tipo_infraccion]),'...');
  end;

  Procedure ListaInfraccionesPeriodo(var L:T_ListaInfracciones);
  var
    desde, hasta:String;
    flag:Boolean;
  begin
    flag:=false;

    repeat
      write('Desde: ');
      readln(desde);

      if not(valFecha(desde)) then writeln('Fecha invalida.');
    until valFecha(desde);

    clrscr();
    Writeln(desde, ' - ...');

    repeat
      write('Hasta: ');
      readln(hasta);

      if valFecha(hasta) then
      begin
         if StrToDate(hasta) >= StrToDate(desde) then
            flag:= True
         else
            Writeln('La fecha debe ser posterior o bien igual a la anterior.');
      end
      else
      begin
        Writeln('Fecha invalida.');
      end;
    until flag;

    clrscr();
    Writeln('[ ',desde, ' - ', hasta, ' ]');

    ImprimirCabeceraTabla;
    ImprimirListaInfracciones(L, desde, hasta, '0');
    readkey;
  end;

  Procedure ListaInfraccionesConductor(var L:T_ListaInfracciones; var archConductores:T_ArchConductores; var arbol:T_Arbol);
  var
    dni:String;
    pos:Integer;
    X:T_Conductores;
  begin
    AbrirConductores(archConductores);
    repeat
       Write('DNI: ');
       readln(dni);
       if not(valDni(dni)) then writeln('DNI no valido.');
     until valDni(dni);

     pos:= BuscarArbol(arbol, dni);
     if pos <> -1 then
     begin
       clrscr();
       X:=LeerConductor(archConductores, pos);
       ImprimirCabeceraTabla2(X.apynom, X.activo);

       ImprimirListaInfracciones(L, 'def','def', dni);
     end
     else
     begin
       Writeln('No se encontro ese conductor.');
     end;
     readkey;
     CerrarConductores(archConductores);
  end;
end.

