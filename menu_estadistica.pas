unit Menu_Estadistica;
interface

uses
SysUtils, crt, Estadisticas, Arch_Infracciones, Arch_Conductores, Estilo, Conductores, Infracciones;

procedure menu_estadisticas(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones);

implementation

procedure menu_estadisticas(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones);
var
op_estadis:String;
tamCond,tamInf:Integer;
porcent1,porcent2:Real;
begin

op_estadis:='-1';

porcent1:= porcent_reincidencias(archConductores);
porcent2:= porcent_scoring0(archConductores);

AbrirConductores(archConductores);
  tamCond:= TamConductores(archConductores);
CerrarConductores(archConductores);

AbrirInfracciones(archInfracciones);
  tamInf:= TamInfracciones(archInfracciones);
CerrarInfracciones(archInfracciones);

while op_estadis <> '0' do
  begin
  clrscr();
  GotoXY( 26, 8 );
  writeln('--------------------');
  GotoXY( 26, 9 );
  writeln('MENU DE ESTADISTICA');
  GotoXY( 26, 11 );
  //write('  Conductores: ', tamCond, '  Infracciones: ', tamInf);

  write('  Conductores: ');

  TextColor( Brown );
    Write(tamCond);
  CambiarTexto();

  write('  Infracciones: ');

  TextColor( Brown );
    Writeln(tamInf);
  CambiarTexto();

  GotoXY( 26, 12 );
  Write('  Reincidencias: ');
  TextColor( Brown );
    Writeln(porcent1:0:2,'%');
  CambiarTexto();

  GotoXY( 26, 13);
  Write('  Inhabilitados: ');
  TextColor( Brown );
    Writeln(porcent2:0:2,'%');
  CambiarTexto();

  GotoXY( 26, 15 );
  writeln('1-Cantidad de infracciones entre dos fechas.');
  GotoXY( 26, 16 );
  writeln('2-Total de tipos de infracciones.');
  GotoXY( 26, 17 );
  writeln('3-Rango etario con mas infracciones.');
  GotoXY( 26, 18 );
  writeln('0-Salir');
  readln(op_estadis);
  clrscr();
   case op_estadis of
   '1':infracciones_fechas(archInfracciones);
   '2':TotalInfrac (archInfracciones);
   '3':rango_etario(archConductores);
   end;
  end;
end;

end.

