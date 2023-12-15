unit conductores;

interface

uses crt;

const
rutacond = 'C:\conductores.dat';
//declaracion de archivo
type
  T_Conductores = Record
     DNI:string[10];
     AYN:string[25]; //Apellido y nombre
     FN:string[20]; //Fecha nacimiento
     telefono:string[20];
     mail:string[30];
     scoring:integer;
     Habilitado:string[2];
     FH:string[20]; //Fecha Habilitado
     CR:integer; //cantidad de reincidencias
     activo:boolean; //campo de verificacion
  end;

  T_ArchConductores = File of T_Conductores;

//procedimientos
implementation
procedure bajaconduc(var arch_cond:T_ArchConductores; pos:integer);
var
x:T_Conductores;
begin
Seek(arch_cond,pos);
read(arch_cond,x);
x.activo:=false;
write(arch_cond,x);
end;

Procedure altaconduc(var arch_cond:T_ArchConductores; x:T_Conductores);
var
i:byte;
pos:byte;
begin

pos:=0;

if Filesize(arch_cond) > 0 then
begin
  for i:=0 to Filesize(arch_cond) do
  begin
       read(arch_cond,x);
       if not(x.activo) then
          pos:=1;
  end;
end;

Seek(arch_cond, pos);
Write(arch_cond,x);
end;

procedure modificarconduc(var arch_cond:T_ArchConductores; var pos:byte);
var
   x:T_Conductores;
   opcion:integer;
begin
  Seek(arch_cond,pos);
  read(arch_cond,x);

  //Muestra al usuario los campos disponibles para modificar
  writeln('Seleccione el campo que desea modificar:');
  writeln('1- DNI');
  writeln('2- Apellido y Nombre');
  writeln('3- Fecha de nacimiento');
  writeln('4- Telefono');
  writeln('5- Email');
  writeln('6- Habilitado');
  writeln('7- Fecha de habilitacion');
  writeln('8- Cantidad de reincidencias');


  readln(opcion);  //Lee la selección del usuario


  case opcion of   //Realiza la modificación correspondiente
  1: begin
    writeln('Ingrese el nuevo DNI: ');
    readln(x.DNI);
    write(arch_cond,x);
  end;
  2: begin
    writeln('Ingrese el nuevo apellido y nombre: ');
    readln(x.AYN);
    write(arch_cond,x);
  end;
  3: begin
    writeln('Ingrese la nueva fecha de nacimiento: ');
    readln(x.FN);
    write(arch_cond,x);
  end;
  4: begin
    writeln('Ingrese el nuevo telefono: ');
    readln(x.telefono);
    write(arch_cond,x);
  end;
  5: begin
    writeln('Ingrese el nuevo email: ');
    readln(x.mail);
    write(arch_cond,x);
  end;
  6: begin
    writeln('Ingrese el nuevo estado de habilitacion (si/no): ');
    readln(x.habilitado);
    write(arch_cond,x);
  end;
  7: begin
    writeln('Ingrese la nueva fecha de habilitacion: ');
    readln(x.FH);
    write(arch_cond,x);
  end;
  8: begin
    writeln('Ingrese la nueva cantidad de reincidencias: ');
    readln(x.CR);
    write(arch_cond,x);
  end;
  else
    writeln('Opcion invalida');
  end;
end;

procedure consultaconduc (var arch_cond:T_ArchConductores; var pos:integer);
var
   x:T_Conductores;
begin
  seek(arch_cond, pos);
  read(arch_cond,x);
  writeln('DNI: ',x.DNI);
  writeln('Apellido y Nombre: ',x.AYN);
  writeln('Fecha de naciimiento: ',x.FN);
  writeln('telefono: ',x.telefono);
  writeln('gmail: ',x.mail);
  writeln('habilitado: ',x.habilitado);
  writeln('fecha habilitacion: ',x.FH);
  writeln('cantidad reincidencias: ',x.CR);
end;
end.


                     



