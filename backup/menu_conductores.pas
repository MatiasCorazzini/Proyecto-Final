unit Menu_Conductores;
interface

uses
SysUtils,crt, Arch_Conductores, Conductores,ArbolConductores, Validadores, Scoring, Estilo;

Procedure menu_cond(var archConductores:T_ArchConductores; var arbol:T_Arbol);

implementation
Procedure menu_cond(var archConductores:T_ArchConductores; var arbol:T_Arbol);
var
  curso:String;
  op:String;
  DNI:T_Dni;
  pos:integer;
  X:T_Conductores;
begin
 op:='';
 AbrirConductores(archConductores);

 repeat
   write('Ingrese un DNI: ');
   readln(DNI);
   if not(valDni(DNI)) then writeln('DNI no valido.');
 until valDni(DNI);

 pos:= BuscarArbol(arbol, DNI);

 // if pos <> -1 then X:= LeerConductor(archConductores, pos);

 while op <> '0' do
 begin
    if pos <> -1 then X:= LeerConductor(archConductores, pos);
    clrscr();
    GotoXY( 30, 8 );
    writeln('--------------------');
    GotoXY( 30, 9 );
    writeln('MENU DE CONDUCTORES: ');
    GotoXY( 30, 10 );
    if (pos = -1) or not(X.activo) then
      begin
        writeln(DNI, ' no existe o esta inactivo:');
        GotoXY( 30, 11 );
        writeln('1-Alta');
        GotoXY( 30, 12 );
        writeln('0-Salir');
        GotoXY( 30, 13 );
      end
    else
    begin
      write(X.apynom, ': ');
      if X.habilitado then
      begin
        TextColor( Green );
        Write('Habilitado');
      end
      else
      begin
        TextColor( Red );
        Write('Inhabilitado');
      end;

      CambiarTexto();

      GotoXY(30, 11);
      writeln('1-Modificacion');
      GotoXY( 30, 12);
      writeln('2-Consulta');
      GotoXY( 30, 13 );
      writeln('3-Baja');
      if X.Habilitado = false then
      begin
        GotoXY( 30, 14 );
        writeln('4-Habilitar');
        GotoXY(30,15);
      end
      else
      begin
        GotoXY(30,14);
      end;
      writeln('0-Salir');
    end;
    readln(op);
    clrscr();
    case op of
      '1':begin
           if (pos = -1) or not(X.activo) then
           begin
             AltaConductor(archConductores, arbol, DNI);
             op:='0';
           end
           else
           begin
             ActualizarConductor(archConductores, arbol, DNI);
           end;
          end;

      '2':if pos <> -1 then ConsultarConductor(archConductores, arbol, DNI);

      '3':begin
          if pos <> -1 then BajaConductor(archConductores, arbol, DNI); // anda :D
          op:='0';
          end;

      '4':begin
            if pos <> -1 then
            begin
              curso:= '-1';
               repeat
                 clrscr();
                 writeln('¿Realizo el curso de reavilitacion?');
                 writeln('1-Si  0-No');
                 readln(curso);

                 case curso of
                  '1': Reinsidencia(archConductores, arbol, DNI);

                  '0':begin
                       writeln('Sin el curso no se puede continuar.');
                      end;
                 end;
               until (curso = '1') or (curso = '0');
               readkey();
            end;
          end;
      end;
    end;
 CerrarConductores(archConductores);
end;

end.
