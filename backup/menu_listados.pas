unit Menu_Listados;

interface

uses
SysUtils,crt,Arch_Conductores,Arch_Infracciones, Lista_Conductores, Lista_Infracciones, ArbolConductores;

procedure Menu_list(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones; arbol:T_Arbol);


implementation

procedure Menu_list(var archConductores:T_ArchConductores; var archInfracciones:T_ArchInfracciones; arbol:T_Arbol);
var
op_list:integer;
listaInfracciones:T_ListaInfracciones;
listaConductores:T_ListaConductores;

begin
  op_list:=-1;
  AbrirConductores(archConductores);
    CrearListaConductores(listaConductores, archConductores);
  CerrarConductores(archConductores);

  AbrirInfracciones(archInfracciones);
    CrearListaInfracciones(listaInfracciones, archInfracciones);
  CerrarInfracciones(archInfracciones);

while op_list <> 0 do
 begin
  clrscr();
  GotoXY( 26, 9 );
  writeln('--------------------');
  GotoXY( 26, 10 );
  writeln('MENU DE LISTAS');
  GotoXY( 26, 11 );
  writeln('1-Listado ordenado por Apellido y Nombres de Conductores');
  GotoXY( 26, 12 );
  writeln('2-Listado ordenado por fecha de todas las infracciones (período determinado)');
  GotoXY( 26, 13 );
  writeln('3-Listado ordenado por fecha de todas las infracciones de un conductor (periodo terminado)');
  GotoXY( 26, 14 );
  writeln('4-Listado de los infractores a los cuales su scoring llegó a 0');
  GotoXY( 26, 15 );
  writeln('0-Salir');
  readln(op_list);
  clrscr();
    case op_list of
     1: ImprimirListaConductores(listaConductores, False);
     2: ListaInfraccionesPeriodo(listaInfracciones);
     3: ListaInfraccionesConductor(listaInfracciones, archConductores, arbol);
     4: ImprimirListaConductores(listaConductores, True);
    end;
  end;

 AbrirConductores(archConductores);
    EliminarListaConductores(listaConductores);
 CerrarConductores(archConductores);

 AbrirInfracciones(archInfracciones);
    EliminarListaInfracciones(listaInfracciones);
 CerrarInfracciones(archInfracciones);
end;
end.


