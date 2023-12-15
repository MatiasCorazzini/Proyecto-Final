unit Menu;
{$mode ObjFPC}{$H+}
interface
menu();

var
op:integer;
op_conduc:integer;
op_infracc:integer;

uses
  Classes, SysUtils;

implementation
menu()
begin
writeln('seleccione sobre que se desea trabajar');
writeln('1-Conductores');
writeln('2-Infracciones');
readln(op)
case op of
1: begin
   writeln('seleccione una opcion');
   writeln('1-Alta conductores');
   writeln('2-Baja conductores');
   writeln('3-Modificacion conductores');
   writeln('4-Consulta conductores');
   writeln('5-Actualizar scoring');
   writeln('6-Listado alfabetico de conductores');
   writeln('7-Listado de conductores con scoring en 0');
   readln(op_conduc);
   end;






end;




end.

