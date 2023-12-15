unit Menu;
{$mode ObjFPC}{$H+}
interface
menu();



uses
 Classes, SysUtils;

implementation
procedure menu()
var
op:integer;
op_conduc:integer;
op_infracc:integer;
begin
op:=10
while op <> 0 do
begin
  writeln('seleccione sobre que se desea trabajar');
  writeln('1-Conductores');
  writeln('2-Infracciones');
  writeln('0-salir');
  op := readln();
//Efecto de fondo
  if op = 1 then
  begin
    // Fondo azul
    SetColor(238532);
    // Borde negro
    SetTextColor(0);

case op of
  1: begin
  op_conduc:=10;
  while op_conduc <> 0 do
  begin
  writeln('seleccione una opcion');
  writeln('1-Alta conductores');
  writeln('2-Baja conductores');
  writeln('3-Modificacion conductores');
  writeln('4-Consulta conductores');
  writeln('5-Actualizar scoring');
  writeln('6-Listado alfabetico de conductores');
  writeln('7-Listado de conductores con scoring en 0');
  writeln('0-salir');
  readln(op_conduc);
  case op_conduc of
  1:altaconduc(arch_cond,x)
  2:bajaconduc(arch_cond,pos);
  3:modificarconduc(arch_cond,pos);
  4:consultaconduc(arch_cond,pos);
  end;
  end;
 end;

  2: //begin
  //op_infracc:=10;
  //while op_infracc<>0 do
  //begin
  //writeln('seleccione una opcion');
  //writeln('1-Alta infracciones');
  //writeln('2-Modificacion infrraciones');
  //writeln('3-Consulta infrracionees');
  //writeln('4-Listado ordenado de infracciones'); //periodo determinado
  //writeln('0-Salir');
  //readln(op_infracc);
  //case op_infracc of
  //end;
 //end;
 //end:
end;



end.
