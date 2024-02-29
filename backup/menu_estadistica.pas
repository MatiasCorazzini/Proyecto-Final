unit Menu_Estadistica;
interface

uses
SysUtils, crt, Estadisticas, Arch_Infracciones, Arch_Conductores;

procedure menu_estadisticas(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones);

implementation

procedure menu_estadisticas(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones);
var
op_estadis:integer;
begin
op_estadis:=-1;
  while op_estadis <> 0 do
  begin
  clrscr();
  GotoXY( 26, 8 );
  writeln('--------------------');
  GotoXY( 26, 9 );
  writeln('MENU DE ESTADISTICA');
  GotoXY( 26, 10 );
  writeln('1-Cantidad de infracciones entre dos fechas');
  GotoXY( 26, 11 );
  writeln('2-Porcentaje de conductores con reincidencia');
  GotoXY( 26, 12 );
  writeln('3-Porcentaje de conductores con scoring 0');
  GotoXY( 26, 13 );
  writeln('4-Total de tipos de infracciones.');
  GotoXY( 26, 14 );
  writeln('5-Rango etario con mas infracciones');
  GotoXY( 26, 15 );
  writeln('0-Salir');
  readln(op_estadis);
  clrscr();
   case op_estadis of
   1:infracciones_fechas(archInfracciones);
   2:porcent_reincidencias(archConductores);
   3:porcent_scoring0(archConductores);
   4:TotalInfrac (archInfracciones);
   5:rango_etario(archConductores);
   end;
  end;
end;

end.

