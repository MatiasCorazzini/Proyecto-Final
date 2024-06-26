unit Conductores;

interface

uses
  SysUtils, crt, Arch_Conductores, ArbolConductores, Validadores, Estilo;

  Procedure AgregarConductor(var arch:T_ArchConductores; var arbol:T_Arbol; X:T_Conductores);

  Procedure AltaConductor(var arch:T_ArchConductores; var arbol:T_Arbol; dni:T_Dni);
  Procedure ConsultarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  Procedure BajaConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  Procedure ActualizarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  Procedure CrearArbol(var arbol:T_Arbol; var arch:T_ArchConductores);

  Function TamConductores(var arch:T_ArchConductores):Integer;

  Function LeerConductor(var arch:T_ArchConductores; pos:Integer):T_Conductores; //
  Procedure GuardarConductor(var arch:T_ArchConductores; pos:Integer; X:T_Conductores);

  Procedure InsertarConductor(var arbol:T_Arbol; var arch:T_ArchConductores; X:T_Conductores);

const
  maxPunt = 20; // Maximos de scoring que se puede tener.

implementation

Procedure AltaConductor(var arch:T_ArchConductores; var arbol:T_Arbol; dni:T_Dni);
var
X:T_Conductores;
flag:Boolean;
dni2:T_Dni;
fecha:String;
pos:Integer;
op:String;
begin
flag:=True;
op:=' ';
if dni <> '0' then
  begin
    Writeln('DNI: ',dni);
    X.dni:= dni;
  end
else
  begin
    repeat
    Write('DNI: ');
    readln(dni2);
    if not(valDni(dni2)) then
    begin
      clrscr();
      writeln('DNI no valido.');
    end;
    until valDni(dni2);

    X.dni:=dni2;

    if BuscarArbol(arbol, dni2) <> -1 then flag:=False;
  end;
if flag then
begin
pos:=BuscarArbol(arbol, dni);
if pos <> -1 then
 begin
 if not(X.activo) then
   begin
   repeat
      clrscr();
      Writeln('Desea dar de alta nuevamente?');
      Writeln(' 1-SI   0-NO');
      readln(op);
      if op = '1' then
        begin
        X:=LeerConductor(arch, pos);
        X.activo:= True;
        GuardarConductor(arch, pos, X);
        Writeln('Se dio de alta exisotamente');
        end;
   until (op = '1') or (op = '0');
   end;
end
else
 begin
 write('Apellido y Nombre: ');
 readln(X.apynom);
  repeat
  write('Fecha de Nacimiendo: ');
  readln(fecha);
  if not(valFecha(fecha)) then
    begin
       clrscr();
       writeln('Fecha invalida.');
    end;
  until valFecha(fecha);
 X.fecha_nacimiento:=fecha;
 write('Tel: ');
 readln(X.telefono);
 write('Mail: ');
 readln(X.mail);
 AgregarConductor(arch, arbol, X);
 Writeln('Se dio de alta exisotamente.');
 end;
end
 else Writeln('Ese dni ya existe.');
readkey;
end;

  Procedure ConsultarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
   X:T_Conductores;
   pos:Integer;
  begin
   pos:= BuscarArbol(arbol, dni);

   if pos <> -1 then
    begin
      X:=LeerConductor(arch, pos);
      //GotoXY( 30, 10 );
      writeln('-----------------------------------');
      GotoXY( 30, 12 );
      writeln('DNI:                   ', X.dni);
      GotoXY( 30, 13 );
      writeln('Nombre y Apellido:     ', X.apynom);
      GotoXY( 30, 14 );
      writeln('Fecha de Nacimiendo:   ', X.fecha_nacimiento);
      GotoXY( 30, 15 );
      writeln('Telefono:              ', X.telefono);
      GotoXY( 30, 16 );
      writeln('Mail:                  ', X.mail);
      GotoXY( 30, 17 );
      writeln('Scoring:               ', X.scoring);

      GotoXY( 30, 18 );
      if X.Habilitado then
       begin
         write('Habilitado:');
         TextColor( Green );
         writeln('            Si');
       end
      else
      begin
         write('Habilitado:');
         TextColor( Red );
         writeln('            No');
      end;
      CambiarTexto();

      GotoXY( 30, 19 );
      writeln('Reincidencias:         ', X.cantidad_reincidencias);

      GotoXY( 30, 20 );
      if X.Activo then
      begin
         write('Activo:');
         TextColor( Green );
         writeln('                Si');
      end
      else
      begin
         write('Activo:');
         TextColor( Red );
         writeln('                No');
      end;
      CambiarTexto();

      GotoXY( 30, 21 );
      if not(X.Habilitado) then
            writeln('Fecha de inhabilitado: ', X.fecha_habilitado);
      GotoXY( 30, 23 );

    end
   else
   begin
      GotoXY( 30, 12 );
      Writeln('Conductor no encontrado...');
   end;
  end;

  Procedure AgregarConductor(var arch:T_ArchConductores; var arbol:T_Arbol; X:T_Conductores);
  var
    tam:Integer;
  begin
   {
     dni:T_Dni;
     apynom:string[25];
     fecha_nacimiento:string[10];
     telefono:string[20];
     mail:string[30];
     scoring:integer;
     Habilitado:boolean;
     fecha_habilitado:string[20];
     cantidad_reincidencias:integer;
     activo:boolean;
   }
      tam:= TamConductores(arch);

      X.activo:= True;
      X.cantidad_reincidencias:= 0;
      X.fecha_habilitado:= DateToStr(Date);
      X.Habilitado:=True;
      X.scoring:= maxPunt;

      GuardarConductor(arch, tam, X);
      InsertarConductor(arbol, arch, X);

      //writeln('Tamano de archivo: ', TamConductores(arch));
  end;

  Procedure BajaConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
    pos:Integer;
    X:T_Conductores;
    op:String;
  begin
      pos:= BuscarArbol(arbol, dni);
      op:= '-1';
      repeat
        Writeln('Desea dar de baja?');
        Writeln('1-Si    0-No');
        readln(op);

        if op = '1' then
        begin
          if pos <> -1 then
          begin
            X:= LeerConductor(arch, pos);
            X.activo:= false;
            GuardarConductor(arch, pos, X);
            Writeln(X.apynom,', ',X.dni,' fue dado de baja.');
            op:='0';
          end
          else
          begin
             Writeln('Conductor no encontrado.');
             op:='0';
          end;
          readkey;
        end
        else
        begin
          op:='0';
        end;
      until op = '0';
  end;

  Procedure ActualizarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
    pos:Integer;
    X:T_Conductores;
    op,aux1,aux2,aux3,aux4:String;
  begin
    aux1:='';
    aux2:='';
    aux3:='';
    aux4:='';

    op:='-1';
    pos:= BuscarArbol(arbol, dni);

    if pos <> -1 then
    begin
      X:= LeerConductor(arch, pos);

      aux1:= X.apynom;
      aux2:= X.fecha_nacimiento;
      aux3:= X.telefono;
      aux4:= X.mail;

      while op <> '0' do
      begin
         Clrscr();
         Writeln('   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
         Writeln('  | ',aux1);
         Writeln('  | ',aux2);
         Writeln('  | ',aux3);
         Writeln('  | ',aux4);
         writeln('   - - - - - - - - - - - - - - - - - -');
         writeln('');

         writeln('Actualizar:');
         writeln('1-Nombre');
         writeln('2-Fecha de nacimineto.');
         writeln('3-Tel');
         writeln('4-Mail');
         writeln('');
         writeln('0-Listo');
         readln(op);

         case op of
              '1':
                begin
                   write('Apellido y Nombre: ');
                   readln(aux1);
                end;

              '2':
                begin
                   write('Fecha de nacimiento: ');
                   readln(aux2);
                end;

              '3':
                begin
                   write('Telefono: ');
                   readln(aux3);
                end;

              '4':
                begin
                   write('Mail: ');
                   readln(aux4);
                end;
         end;
      end;

      clrscr();
       op:='-1';
       if (aux1 <> X.apynom) or (aux2 <> X.fecha_nacimiento) or (aux3 <> X.telefono) or (aux4 <> X.mail) then
       begin
         writeln('Desea guardar cambios? 1-SI   0-NO');
         readln(op);
       end
       else
       begin
        op:='0';
       end;

       if op = '1' then
       begin
         X.apynom:=aux1;
         X.fecha_nacimiento:=aux2;
         X.telefono:=aux3;
         X.mail:=aux4;
         GuardarConductor(arch, pos, X);
         writeln('Guardado...');
       end;
      end
      else
      begin
         writeln('Conductor no encontrado.');
      end;
  end;

  Procedure CrearArbol(var arbol:T_Arbol; var arch:T_ArchConductores);
  var
    i:Integer;
    C:T_Conductores;
    elem:T_Elem;
  begin
    arbol := nil; // Inicializar el árbol

    if TamConductores(arch) > 0 then
    begin
      for i:=0 to TamConductores(arch)-1 do
      begin
        C:= LeerConductor(arch, i);
        elem.key:= C.dni;
        elem.pos:= i;

        Insertar(arbol, elem);
      end;
    end;
    Writeln('Arbol creado...');
  end;

  Function TamConductores(var arch:T_ArchConductores):Integer;
  begin
    TamConductores:= Filesize(arch);
  end;

  Function LeerConductor(var arch:T_ArchConductores; pos:Integer):T_Conductores; //
  begin
    Seek(arch, pos);
    Read(arch, LeerConductor);
  end;

  Procedure GuardarConductor(var arch:T_ArchConductores; pos:Integer; X:T_Conductores);
  begin
    Seek(arch, pos);
    Write(arch, X);
  end;

  Procedure InsertarConductor(var arbol:T_Arbol; var arch:T_ArchConductores; X:T_Conductores);
  var
    elem:T_Elem;
  begin
      elem.key:= X.dni;
      elem.pos:= TamConductores(arch)-1;

      Insertar(arbol, elem);
  end;
end.
