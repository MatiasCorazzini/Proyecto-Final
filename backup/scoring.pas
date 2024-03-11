unit Scoring;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, DateUtils, crt, ArbolConductores, Arch_Conductores, Arch_Infracciones;

  Procedure ActualizarScoring(var arch:T_ArchConductores; var arch2:T_ArchInfracciones; var arbol:T_Arbol; x1:T_Infracciones);
  Function UltimaInfraccion(var arch:T_ArchInfracciones; dni:T_Dni):T_Infracciones;

  Procedure Reinsidencia(var archConductores:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);

implementation
  Procedure ActualizarScoring(var arch:T_ArchConductores; var arch2:T_ArchInfracciones; var arbol:T_Arbol; x1:T_Infracciones);
  var
    x2:T_Conductores;
    pos:Integer;
  begin
    pos:= BuscarArbol(arbol, x1.dni);

    if pos <> -1 then
    begin
      x2:= LeerConductor(arch, pos);

      Dec(x2.scoring, x1.puntos_descontar);
      if x2.scoring <= 0 then
      begin
        CerrarConductores(arch);
        AbrirInfracciones(arch2);

        x2.habilitado:= False;
        x2.fecha_habilitado:= UltimaInfraccion(arch2, x2.dni).fecha_infraccion; // Cuando el scoring llega a 0 habilitado:= False y le pasa la fecha de la ultima infraccion.

        CerrarInfracciones(arch2);
        AbrirConductores(arch);
      end;

      GuardarConductor(arch, pos, x2);
      writeln('Se actualizo el scoring.');
    end
    else
    begin
      Writeln('No se pudo actualizar el scoring.');
    end;
  end;

  Procedure Reinsidencia(var archConductores:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
    X:T_Conductores;
    fechaActual:TDate;
    pos,dias:Integer;
  begin
    fechaActual:= Date;
    pos:= BuscarArbol(arbol, dni);

    X:= LeerConductor(archConductores, pos);

    dias:= DaysBetween(fechaActual, StrToDate(X.fecha_habilitado));

    case X.cantidad_reincidencias of
         0:begin
              if dias > 60 then
                begin
                  Clrscr();
                  inc(X.cantidad_reincidencias);
                  X.scoring:= 20;
                  X.Habilitado:=True;
                  GuardarConductor(archConductores, pos, X);

                  Writeln('Reinsidencia Nro ', X.cantidad_reincidencias, '.');
                  Writeln('La fecha de inhavilitacion fue el: ', X.fecha_habilitado);
                  Writeln('Pasaron ', dias,' dias.');
                  Writeln('');

                  Writeln('Se reintegraron los puntos. Scoring actual: ', X.scoring,'.');
                end
              else
                begin
                  Clrscr();
                  Writeln('No pasaron los dias de inhabilitacion. Aun quedan ', 60-dias, ' dias.');
                end;
            end;

         1:begin
                if dias > 120 then
                  begin
                    Clrscr();
                    inc(X.cantidad_reincidencias);
                    X.scoring:= 20;
                    X.Habilitado:=True;
                    GuardarConductor(archConductores, pos, X);

                    Writeln('Reinsidencia N°', X.cantidad_reincidencias, '.');
                    Writeln('La fecha de inhavilitacion fue el: ', X.fecha_habilitado);
                    Writeln('Pasaron ', dias,'.');
                    Writeln('');

                    Writeln('Se reintegraron los puntos. Scoring actual: ', X.scoring,'.');
                  end
                else
                  begin
                    Clrscr();
                    Writeln('No pasaron los dias de inhabilitacion. Aun quedan ', 120-dias, ' dias.');
                  end;
           end;

         2:begin
                if dias > 180 then
                  begin
                    Clrscr();
                    inc(X.cantidad_reincidencias);
                    X.scoring:= 20;
                    X.Habilitado:=True;
                    GuardarConductor(archConductores, pos, X);

                    Writeln('Reinsidencia N°', X.cantidad_reincidencias, '.');
                    Writeln('La fecha de inhavilitacion fue el: ', X.fecha_habilitado);
                    Writeln('Pasaron ', dias,'.');
                    Writeln('');

                    Writeln('Se reintegraron los puntos. Scoring actual: ', X.scoring,'.');
                  end
                else
                  begin
                    Clrscr();
                    Writeln('No pasaron los dias de inhabilitacion. Aun quedan ', 180-dias, ' dias.');
                  end;
           end;

         else // 180 * 2 * (cant_reins - 2)
           begin
             if dias > (180*2*(X.cantidad_reincidencias -2)) then
               begin
                Clrscr();
                inc(X.cantidad_reincidencias);
                X.scoring:= 20;
                X.Habilitado:=True;
                GuardarConductor(archConductores, pos, X);

                Writeln('Reinsidencia N°', X.cantidad_reincidencias, '.');
                Writeln('La fecha de inhavilitacion fue el: ', X.fecha_habilitado);
                Writeln('Pasaron ', dias,'.');
                Writeln('');

                Writeln('Se reintegraron los puntos. Scoring actual: ', X.scoring,'.');
              end
           else
              begin
                Clrscr();
                Writeln('No pasaron los dias de inhabilitacion. Aun quedan ', (180*2*(X.cantidad_reincidencias -2))-dias, ' dias.');
              end;
      end;
    end;
  end;

  Function UltimaInfraccion(var arch:T_ArchInfracciones; dni:T_Dni):T_Infracciones;
  var
    fecha, ultFecha:String[10];
    i:Integer;
    X, ultInfraccion:T_Infracciones;
  begin
    ultFecha:='01/01/0001';

    for i:=0 to TamInfracciones(arch)-1 do
    begin
      X:=LeerInfraccion(arch, i);
      if X.dni = dni then
      begin
        fecha:=X.fecha_infraccion;
        if StrToDate(fecha)>StrToDate(ultFecha) then
        begin
           ultFecha:=fecha;
           ultInfraccion:=X;
        end;
      end;
    end;
    UltimaInfraccion:=ultInfraccion;
  end;

end.

