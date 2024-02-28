unit Menu_Infracciones;
interface
uses
SysUtils, crt, Arch_Infracciones, Arch_Conductores,Infracciones, ArbolConductores, Estilo;

Procedure menu_inf(var archInfracciones:T_ArchInfracciones; var archConductores:T_ArchConductores; var arbol:T_Arbol);

implementation

  //ingresa Clave, en base a eso se selecciona lo que se quiere hacer
  //selecciona que va a hacer sobre infracciones

  Procedure menu_inf(var archInfracciones:T_ArchInfracciones; var archConductores:T_ArchConductores; var arbol:T_Arbol);
  var
    op:String;
  begin
    AbrirInfracciones(archInfracciones);
    op:=' ';
     while op <> '0' do
      begin
        clrscr();
        GotoXY( 26, 8 );
        writeln('--------------------');
        GotoXY( 26, 9 );
        writeln('MENU DE INFRACCIONES');
        GotoXY( 26, 10 );
        writeln('1-Alta');
        GotoXY( 26, 11 );
        //writeln('2-Consulta');
        //GotoXY( 26, 12 );
        writeln('0-Salir');
        GotoXY( 26, 12 );
        readln(op);
        clrscr();
        case op of
          '1':AltaInfracciones(archInfracciones, archConductores, arbol);
          '2':ConsultarInfraccion(archInfracciones);
        end;
     end;;
     CerrarInfracciones(archInfracciones);
    end;
end.
