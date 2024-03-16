unit Menu;

interface

uses
SysUtils,crt,Menu_Infracciones,Menu_Conductores, Arch_Conductores, Arch_Infracciones, ArbolConductores, Estilo, Menu_Estadistica, Menu_Listados, Conductores;

Procedure MainMenu();

implementation

  Procedure MainMenu();
  var
  op:String;
  archConductores:T_ArchConductores;
  arbol:T_Arbol;

  archInfraccines:T_ArchInfracciones;

  begin
    CambiarFondo();
    CambiarTexto();

    AbrirConductores(archConductores);
    CrearArbol(arbol, archConductores);
    CerrarConductores(archConductores);

    AbrirInfracciones(archInfraccines);
    CerrarInfracciones(archInfraccines);

    op:=' ';
    while op <> '0' do
    begin
      clrscr();
      GotoXY( 30, 12 );
      writeln('Seleccione con que desea trabajar:');
      GotoXY( 30, 13 );
      writeln('1-Conductores');
      GotoXY( 30, 14 );
      writeln('2-Infracciones');
      GotoXY( 30, 15 );
      writeln('3-Estadisticas');
      GotoXY( 30, 16 );
      writeln('4-Listados');
      GotoXY( 30, 17 );
      writeln('0-Salir');
      readln(op);
      clrscr();

      case op of
        '1':menu_cond(archConductores, arbol);
        '2':menu_inf(archInfraccines, archConductores, arbol);
        '3':menu_estadisticas(archConductores, archInfraccines);
        '4':Menu_list(archConductores, archInfraccines, arbol);
      end;
    end;
  end;

end.
