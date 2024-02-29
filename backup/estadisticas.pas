unit Estadisticas;
interface
uses
SysUtils, crt, Arch_Infracciones, Arch_Conductores, Validadores;

procedure infracciones_fechas(var arch_infracciones:T_ArchInfracciones);
procedure porcent_reincidencias(var arch_conductores:T_ArchConductores);
procedure porcent_scoring0(var arch_conductores:T_ArchConductores);
procedure rango_etario(var arch_conductores:T_ArchConductores);


implementation

//Cantidad de infracciones entre dos fechas
  procedure infracciones_fechas(var arch_infracciones:T_ArchInfracciones);
  var
    desde:string[10];
    hasta:string[10];
    i,cont:integer;
    x1:T_infracciones;
    flag:Boolean;
  begin
    AbrirInfracciones(arch_infracciones);
    cont:=0;
    flag:=false;
    repeat
      write('Desde: ');
      readln(desde);

      if not(valFecha(desde)) then writeln('Fecha invalida.');
    until valFecha(desde);

    clrscr();
    Writeln(desde, ' - ...');

    repeat
      write('Hasta: ');
      readln(hasta);

      if valFecha(hasta) then
      begin
         if StrToDate(hasta) >= StrToDate(desde) then
            flag:= True
         else
            Writeln('La fecha debe ser posterior o bien igual a la anterior.');
      end
      else
      begin
        Writeln('Fecha invalida.');
      end;
    until flag;

    for i:=0 to TamInfracciones(arch_infracciones)-1 do
    begin
     x1:=LeerInfraccion(Arch_infracciones,i);   //leerinfraccion(archivo, posicion);
     if (StrToDate(desde) < StrToDate(x1.fecha_infraccion)) and (StrToDate(x1.fecha_infraccion) < StrToDate(hasta)) then inc(cont);
    end;

    writeln('La cantidad de infracciones entre [ ', desde, ' - ', hasta, ' ] ha sido de ' ,cont);

    CerrarInfracciones(arch_infracciones);
    readkey;
  end;

  //Porcentaje de conductores con reincidencia
  procedure porcent_reincidencias(var arch_conductores:T_ArchConductores);
  var
    i,cont:integer;
    x1:T_conductores;
    porcent:real;
  begin
    AbrirConductores(arch_conductores);
    cont:=0;

    for i:=0 to TamConductores(arch_conductores)-1 do
    begin
     x1:=LeerConductor(arch_conductores, i);
     if x1.cantidad_reincidencias > 0 then Inc(cont);
    end;

    porcent:=cont/TamConductores(arch_conductores)*100;
    writeln('El porcentaje de conductores con reincidencia es ',porcent:0:2, '%');
    CerrarConductores(arch_conductores);
    readkey;
  end;

  //Porcentaje de conductores con scoring 0
  procedure porcent_scoring0(var arch_conductores:T_ArchConductores);
  var
    cont:integer;
    x1:T_conductores;
    i:integer;
    porcent:real;

  begin
    AbrirConductores(arch_conductores);
    cont:=0;
    for i:=0 to TamConductores(arch_conductores)-1 do
     begin
     x1:=LeerConductor(arch_conductores,i);
     if x1.scoring = 0 then cont:=cont+1;
     end;
    porcent:=cont/TamConductores(arch_conductores)*100;
    writeln('El porcentaje de conductores con scoring 0 es ',porcent:0:2, '%');
    CerrarConductores(arch_conductores);
    readkey;
  end;

  function CalculateAge(Birthday: TDate): Integer;
  var
    CurrentDate: TDate;
    Month, Day, Year, CurrentYear, CurrentMonth, CurrentDay: Word;
  begin
    DecodeDate(Birthday, Year, Month, Day);
    CurrentDate := TDateTime(now());
    DecodeDate(CurrentDate, CurrentYear, CurrentMonth, CurrentDay);
    if (Year = CurrentYear) and (Month = CurrentMonth) and (Day = CurrentDay) then
    begin
      Result := 0;
    end
    else
    begin
      Result := CurrentYear - Year;
      if (Month > CurrentMonth) then
        Dec(Result)
      else
      begin
        if Month = CurrentMonth then
          if (Day > CurrentDay) then
            Dec(Result);
      end;
    end;
  end;

  //Rango etario con más infracciones (menores de 30, entre 31 y 50, mayores a 50)
  procedure rango_etario(var arch_conductores:T_ArchConductores);
  var
    i:integer;
    x1:T_Conductores;
    c1,c2,c3,age:integer;
    rango:String[20];
    maxCont:Integer;
  begin
    AbrirConductores(arch_conductores);

    c1:=0;
    c2:=0;
    c3:=0;
    age:=0;

    for i := 0 to TamConductores(arch_conductores)-1 do
    begin
      x1 := LeerConductor(arch_conductores, i);
      age := CalculateAge(StrToDate(x1.fecha_nacimiento));

      if (x1.scoring < 20) or (x1.cantidad_reincidencias > 0) then
      begin
        if age < 30 then
          Inc(c1)
        else if (age >= 30) and (age <= 50) then
          Inc(c2)
        else
          Inc(c3);
      end;
    end;

    writeln('Rango etario con mas infracciones:');
    writeln('Menores de 30 anios: ', c1);
    writeln('Entre 31 y 50 anios: ', c2);
    writeln('Mayores a 50 anios: ', c3);

    if (c1 >= c2) and (c1 >= c3) then
    begin
      maxCont := c1;
      rango := 'Menores de 30 años';
    end
    else if (c2 >= c1) and (c2 >= c3) then
    begin
      maxCont := c2;
      rango := 'Entre 31 y 50 anios';
    end
    else
    begin
      maxCont := c3;
      rango := 'Mayores a 50 anios';
    end;

    // Imprime el rango etario con el mayor número de infracciones
    writeln('Rango etario con mas infracciones:', rango, ' con ', maxCont, ' infracciones.');

    CerrarConductores(arch_conductores);
    readkey();
  end;

  //Procedimiento TOTAL a definir...
procedure TotalInfrac (var arch_infracciones:T_ArchInfracciones);
var
X:T_Infracciones;
i:integer;
c1:integer;
c2:integer;
c3:integer;
c4:integer;
c5:integer;
c6:integer;
c7:integer;
c8:integer;
c9:integer;
c10:integer;
begin
AbrirInfracciones(arch_infracciones);
//incializar contadores
c1:=0;
c2:=0;
c3:=0;
c4:=0;
c5:=0;
c6:=0;
c7:=0;
c8:=0;
c9:=0;
c10:=0;
//sumar contadores
for i:=0 to TamInfracciones(arch_infracciones)-1 do
begin
x:=LeerInfraccion(arch_infracciones,i);
case X.tipo_infraccion of
'Por falta de pago del peaje o contraprestación por tránsito':inc(c1);
'Por conducir sin tener cumplida la edad reglamentaria':inc(c2);
'Por utilizar franquicia de tránsito no reglamentaria, o usarla indebidamente':inc(c3);
'Por no respetar las indicaciones de las luces de los semáforos':inc(c4);
'Por circular con licencia de conducir vencida':inc(c5);
'Por circular con maquinaria especial en infracción a las normas reglamentarias':inc(c6);
'Por circular con vehículo de emergencia en infracción a las normas reglamentarias':inc(c7);
'Por conducir un vehículo con más de MEDIO gramo por litro de alcohol en sangre':inc(c8);
'Por participar u organizar competencias no autorizadas con automotores':inc(c9);
'Por conducir estando inhabilitado o con la habilitación suspendida':inc(c10);
end;
end;
//mostrar total
writeln('Total por tipo de infraccion: ');
writeln('Falta de pago del peaje o contraprestacion por transito: ',c1);
writeln('Conducir sin tener cumplida la edad reglamentaria: ',c2);
writeln('Utilizar franquicia de transito no reglamentaria, o usarla indebidamente: ',c3);
writeln('No respetar las indicaciones de las luces de los semaforos: ',c4);
writeln('Circular con licencia de conducir vencida: ',c5);
writeln('Circular con maquinaria especial en infraccion a las normas reglamentarias: ',c6);
writeln('Circular con vehículo de emergencia en infracción a las normas reglamentarias: ',c7);
writeln('Conducir un vehículo con más de MEDIO gramo por litro de alcohol en sangre: ',c8);
writeln('Participar u organizar competencias no autorizadas con automotores: ',c9 );
writeln('Conducir estando inhabilitado o con la habilitación suspendida: ',c10);
readkey();
CerrarInfracciones(arch_infracciones);
end;
end.

