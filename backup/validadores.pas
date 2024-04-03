unit Validadores;

interface
 uses crt,SysUtils,Classes;

 function valDni(dni:string):boolean;
 function valFecha(fecha:string): boolean;
 {
 procedure validar_valor(var a:string; minimo:longint; maximo:longint; var retorno:longint; msg:string);
 procedure LongIntToString(numero:LongInt; var cadena:String);
 procedure validar_caracter(a:char; valido1:char; valido2:char;var retorno:char; msg:string);
 procedure validar_string_caracter(a:string; var retorno:string; msg:string);
 procedure validar_convertir(var a:string; minimo:longint; maximo:longint; var retorno:string; msg:string);
 procedure validar_string_numerico(var a:string; var retorno:string; msg:string);
 procedure validar_cadena(str:string; caracter:Char; var retorno:string; msg:string);
 }
implementation

function EsNumero(valor:string): boolean;
var
  i: integer;
begin
  EsNumero := False;
  for i := 1 to Length(valor) do
  begin
    if not (valor[i] in ['0'..'9']) then
    begin
      Exit;
    end;
  end;
  EsNumero:=True;
end;

function valDni(dni:string):boolean;
begin
  valDni := ((Length(dni) = 7) or (Length(dni) = 8)) and EsNumero(dni);
end;

function valFecha(fecha:string): boolean;
var
  dia, mes, anio: integer;
begin
  valFecha:=False;

  if Length(fecha) <> 10 then
    Exit;

  if (fecha[3] <> '/') or (fecha[6] <> '/') then
    Exit;

  Delete(fecha, 3, 1);
  Delete(fecha, 5, 1);

  if not EsNumero(fecha) then
    Exit;

  dia := StrToInt(Copy(fecha, 1, 2));
  mes := StrToInt(Copy(fecha, 3, 2));
  anio := StrToInt(Copy(fecha, 5, 4));

  if (dia < 1) or (dia > 31) then
    Exit;

  if (mes < 1) or (mes > 12) then
    Exit;

  // Comprobar febrero dependiendo si es bisiesto o no
  if (mes = 2) and ((anio mod 4 = 0) and ((anio mod 100 <> 0) or (anio mod 400 = 0))) then
  begin
    if (dia > 29) then
      Exit;
  end
  else if (mes = 2) and (dia > 28) then
    Exit;

  // Comprobar meses de 30 días
  if (mes = 4) or (mes = 6) or (mes = 9) or (mes = 11) then
  begin
    if (dia > 30) then
      Exit;
  end;

  valFecha:=True;
end;

function valCaracter(valor:string): boolean;
begin
  // Verificar si la longitud de la cadena es exactamente 1
  if Length(valor) <> 1 then
  begin
    valCaracter := False;
    Exit;
  end;
end;

{
procedure validar_valor(var a:string; minimo:longint; maximo:longint; var retorno:longint; msg:string);
var aux,i:integer; r:longint;
begin
  repeat
  clrscr;
  //MENSAJE PARA EL USUARIO
  write(msg);
  readln(a);
  //VALIDA SI EL DATO ES UN NUMERO
  val(a,r,i);
  //SI EL DATO ES UN NUMERO ENTONCES VALIDA SI ESTA DENTRO DEL RANGO
  clrscr;
  if i=0 then
  begin
   if (r>=minimo) and (r<=maximo) then
     begin
       retorno:=r ;
       aux:=-1;
     end
  end
  else
    begin
       aux:=0;
    end;

   clrscr;
   write(msg);

   until(aux=-1);
   clrscr;
  end;

procedure LongIntToString(numero:LongInt; var cadena: String);
begin
  Str(numero, cadena);
end;

procedure validar_caracter(a:char; valido1:char; valido2:char; var retorno:char;msg:string);
var
r:real;
i:integer;
aux:integer;
begin
  aux:=0;

  repeat
  a:=readkey;
  //VALIDA SI EL DATO ES UN CARACTER
  val(a,r,i);
  if(i<>0) then
  begin
  //SI EL DATO ES UN CARACTER ENTONCES COMPARA EL DATO CON LOS VALIDOS INGRESADOS
  if (upcase(a)=valido1) or (upcase(a)=valido2) then
  begin
  //writeln('uno');
  retorno:=a;
  aux:=-1;
  end;
  clrscr;
  writeln('seleccione "',valido1,'" o "',valido2,'" ');
  writeln(msg);
  end
  else
  begin
  //writeln('dos');
  clrscr;
  writeln('seleccione "',valido1,'" o "',valido2,'" ');
  writeln(msg);
  aux:=0;
  end;
  until(aux=-1);
  //writeln('tres');
  //readkey;
  clrscr;
end;

procedure validar_string_caracter(a:string;var retorno:string;msg:string);
var r:real; i:integer; aux:integer;

begin
  aux:=0;

  repeat
  clrscr;
  write(msg);
  readln(a);
  //VALIDA SI EL DATO NO POSEE NUMEROS
  val(a,r,i);
  if(i<>0) then
  begin
  retorno:=a;
  aux:=-1;
  end

  else
  begin
  clrscr;
  write(msg);
  aux:=0;

  end;

  until(aux=-1);
  //readkey;
  clrscr;
end;

procedure validar_convertir(var a:string;minimo:longint;maximo:longint;var retorno:string;msg:string);
var ret:longint;
begin
  //VALIDA SI ES UN NUMERO Y SI ESTA DENTRO DEL RANGO
  validar_valor(a,minimo,maximo,ret,msg);
  //CONVIERTE EL NUMERO EN STRING
  LongIntToString(ret,a);
  retorno:=a;

end;

procedure validar_string_numerico(var a:string;var retorno:string;msg:string);
var r:real; i:integer; aux:integer;

begin
  aux:=0;

  repeat
  write(msg);
  readln(a);
  //VALIDA SI EL STRING ES UN NUMERO
  val(a,r,i);
  if(i=0) then
  begin
  retorno:=a;
  aux:=-1;
  end

  else
  begin
  clrscr;
  write(msg);
  aux:=0;
  end;

  until(aux=-1);
  //readkey;
  clrscr;
end;

procedure validar_cadena(str: string; caracter: Char;var retorno:string; msg:string);
var
  i: Integer;
  encontrado: Boolean;
begin
  repeat
  clrscr;
  write(msg);
  readln(str);
  encontrado := False;

  // RECORRE EL STRING
  for i := 1 to Length(str) do
  begin
    // VERIFICAR SI EL CARACTER ACTUAL ES IGUAL AL BUSCADO
    if str[i] = caracter then
    begin
      encontrado := True;
      retorno:=str;
    end;
  end;
  until encontrado=true;
   clrscr;
end;
}
end.

