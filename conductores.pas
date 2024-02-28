unit Conductores;

interface

uses
  SysUtils, crt, Arch_Conductores, ArbolConductores, Validadores;

  Procedure AgregarConductor(var arch:T_ArchConductores; var arbol:T_Arbol; X:T_Conductores);

  Procedure AltaConductor(var arch:T_ArchConductores; var arbol:T_Arbol; dni:T_Dni);
  Procedure ConsultarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  Procedure BajaConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  Procedure ActualizarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);

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
    if not(valDni(dni2)) then writeln('DNI no valido.');
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
    Writeln('¿Decea dar de alta nuevamente?');
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
  if not(valFecha(fecha)) then writeln('Fecha invalida.');
  until valFecha(fecha);
 X.fecha_nacimiento:=fecha;
 write('Tel: ');
 readln(X.telefono);
 write('Mail: ');
 readln(X.mail);
 AgregarConductor(arch, arbol, X);
 Writeln('Se dio de alta exisotamente');
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
      writeln('-----------------------------------');
      writeln('DNI:                 ', X.dni);
      writeln('Nombre y Apellido:   ', X.apynom);
      writeln('Fecha de Nacimiendo: ', X.fecha_nacimiento);
      writeln('Telefono:            ', X.telefono);
      writeln('Mail:                ', X.mail);
      writeln('Scoring:             ', X.scoring);

      if X.Habilitado then
         writeln('Habilitado:          Si')
      else
         writeln('Habilitado:          No');

      writeln('Fecha de habilitado: ', X.fecha_habilitado);
      writeln('Reincidencias:       ', X.cantidad_reincidencias);
      if X.Activo then
         writeln('Activo:              Si')
      else
         writeln('Activo:              No');
      readkey();
    end
   else
   begin
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

      writeln('Tamano de archivo: ', TamConductores(arch));
  end;

  Procedure BajaConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
    pos:Integer;
    X:T_Conductores;
  begin
      pos:= BuscarArbol(arbol, dni);

      if pos <> -1 then
      begin
        X:= LeerConductor(arch, pos);
        X.activo:= false;
        GuardarConductor(arch, pos, X);
        Writeln(X.apynom,', ',X.dni,' fue dado de baja.');
      end
      else
      begin
         Writeln('Conductor no encontrado.');
      end;
      readkey;
  end;

  Procedure ActualizarConductor(var arch:T_ArchConductores; arbol:T_Arbol; dni:T_Dni);
  var
    pos:Integer;
    X:T_Conductores;

    op:Byte;
    aux1:String;
    aux2:String;
  begin
    aux1:='';
    aux2:='';

    op:=255;

    pos:= BuscarArbol(arbol, dni);

    if pos <> -1 then
    begin
      X:= LeerConductor(arch, pos);

      aux1:= X.telefono;
      aux2:= X.mail;

      while op <> 0 do
      begin
         writeln('Actualizar:');
         writeln('1-Tel.');
         writeln('2-Mail.');
         writeln('');
         writeln('0-Listo.');
         readln(op);

         case op of
              1:
                begin
                   writeln('Nuevo tel: ');
                   readln(aux1);
                end;

              2:
                begin
                   writeln('Nuevo mail: ');
                   readln(aux2);
                end;
         end;
      end;
       op:=225;

       Writeln('   ', X.apynom ,':');
       writeln('    Nuevo tel: ', aux1);
       writeln('    Nuevo mail: ', aux2);
       writeln('');
       writeln('¿Decea guardar? 1-SI   0-NO');
       readln(op);

       if op = 1 then
       begin
         X.telefono:=aux1;
         X.mail:=aux2;
         GuardarConductor(arch, pos, X);
         writeln('Guardado...');
       end;
      end
      else
      begin
         writeln('Conductor no encontrado.');
      end;
  end;

  Procedure DarDeAltaInactivo(var arch:T_ArchConductores; pos:Integer);
  var
    X:T_Conductores;
  begin

  end;

  // Procedure de pruba para recorrer el archivo.
  {
    Procedure RecorrerConductores(var arch:T_ArchConductores);
    var
      i:Integer;
      X:T_Conductores;
    begin
        for i:=0 to TamConductores(arch)-1 do
        begin
             X:=LeerConductor(arch, i);
             if X.activo then
                writeln(X.dni);
        end;
    end;
  }
end.
