unit conductores;
{$mode ObjFPC}{$H+}
uses
Classes, SysUtils, crt;
//ruta de archivo
const
rutacond = 'C:\Users\oliv\Desktop\TPfinal';
//declaracion de archivo
type
t_dato_cond = record
     DNI:integer;
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
t_arch_cond = file of t_dato_cond;
var
 arch_cond:T_arch_cond;
 x:t_dato_cond;
 pos:integer;

//lista de procedimientos
interface
bajaconduc(arch_cond,pos);
altaconduc(arch_cond,x);
modificarconduc(arch_cond,pos);
consultaconduc(arch_cond,pos);

//procedimientos
implementation
procedure bajaconduc(var arch_cond:t_arch_cond; var pos:integer);
var
x:t_dato_cond;
begin
seek(pos);
read(arch_cond,x);
x.DNI:=0;
x.AYN:='';
x.FN:='';
x.telefono:='';
x.mail:='':
x.scoring:=0;
x.Habilitado:='';
x.FH:='';
x.CR:='';
x.activo:=false;
end;

Procedure altaconduc(var arch_cond:t_arch_cond);
var x:t_dato_cond;
begin
Seek(arch_cond, Filesize(arch_cond));
write(arch_cond,x.DNI);
write(arch_cond,x.AYN);
write(arch_cond,x.FN);
write(arch_cond,x.telefono);
write(arch_cond,x.mail);
write(arch_cond,x.scoring:=0);
write(arch_cond,x.habilitado:='si');
write(arch_cond,x.FH);
write(arch_cond,x.CR);
write(arch_cond,x.activo:=activo);
end;

procedure modificarconduc(var arch_cond:t_arch_cond; var pos:byte);
var
 x:t_dato_cond;
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

//Lee la selección del usuario
readln(opcion);

//Realiza la modificación correspondiente
case opcion of
1: begin
writeln('Ingrese el nuevo DNI: ');
readln(x.DNI);
write(arch_cond,x.DNI);
end;
2: begin
writeln('Ingrese el nuevo apellido y nombre: ');
readln(x.AYN);
write(arch_cond,x.AYN);
end;
3: begin
writeln('Ingrese la nueva fecha de nacimiento: ');
readln(x.FN);
write(arch_cond,x.FN);
end;
4: begin
writeln('Ingrese el nuevo telefono: ');
readln(x.telefono);
write(arch_cond,x.telefono);
end;
5: begin
writeln('Ingrese el nuevo email: ');
readln(x.mail);
write(arch_cond,x.mail);
end;
6: begin
writeln('Ingrese el nuevo estado de habilitacion (si/no): ');
readln(x.habilitado);
write(arch_cond,x.habilitado);
end;
7: begin
writeln('Ingrese la nueva fecha de habilitacion: ');
readln(x.FH);
write(arch_cond,x.FH);
end;
8: begin
writeln('Ingrese la nueva cantidad de reincidencias: ');
readln(x.CR);
write(arch_cond,x.CR);
end;
else
writeln('Opcion invalida');
end;
end;

procedure consultaconduc (var arch_cond:t_arch_cond; var pos:integer);
begin
seek(pos);
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


                     



