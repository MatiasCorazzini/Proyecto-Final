unit Scoring;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, DateUtils, crt, ArbolConductores, Arch_Conductores, Arch_Infracciones, Conductores;

  Procedure Reinsidencia(var archConductores:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);

implementation
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
                    Writeln('Pasaron ', dias,' dias.');
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
                Writeln('Pasaron ', dias,' dias.');
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
end.

