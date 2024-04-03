unit Infracciones;

interface

uses
  SysUtils, crt, Arch_Infracciones, ArbolConductores, Arch_Conductores, Conductores, Validadores;

  Procedure ConsultarInfraccion(var arch:T_ArchInfracciones);
  Procedure AltaInfracciones(var archInf:T_ArchInfracciones; var archCond:T_ArchConductores; arbol:T_Arbol);

  Procedure MostrarInfraccion(X:T_Infracciones);

  Function TamInfracciones(var arch:T_ArchInfracciones):Integer;

  Function LeerInfraccion(var arch:T_ArchInfracciones; pos:Integer):T_Infracciones;
  Procedure GuardarInfraccion(var arch:T_ArchInfracciones; pos:Integer; X:T_Infracciones);

  Procedure ActualizarScoring(var arch:T_ArchConductores; var arch2:T_ArchInfracciones; var arbol:T_Arbol; x1:T_Infracciones);
  Function UltimaInfraccion(var arch:T_ArchInfracciones; dni:T_Dni):T_Infracciones;

implementation

  Procedure ConsultarInfraccion(var arch:T_ArchInfracciones); //Le pasas dni de conductor y muestra litado de infracciones
  var
    i:Integer;
    X:T_Infracciones;
    count:Integer;
    buscado:T_Dni;
  begin
    write('DNI: ');
    readln(buscado);
    count:=0;

    Writeln('---------------------');
    for i:=0 to TamInfracciones(arch)-1 do
    begin
       X:=LeerInfraccion(arch, i);

       if X.dni = buscado then
       begin
           Inc(count);
           Writeln('Infraccion ', count, ' del: ', X.fecha_infraccion);
       end;
    end;
  end;

  Procedure AltaInfracciones(var archInf:T_ArchInfracciones; var archCond:T_ArchConductores; arbol:T_Arbol);
  var
    op{, fecha}:String;
    tam:Integer;
    puntos:Byte;
    dni:T_Dni;
    tipo:String[200];
    X:T_Infracciones;
  begin
      op:=' ';
      puntos:=0;

      Writeln('Ingrese los datos de la infraccion: ');
      repeat
         write('DNI: ');
         readln(dni);
         if not(valDni(dni))then writeln('DNI no valido.');
      until valDni(dni);

      if BuscarArbol(arbol, dni) = -1 then
      begin
          writeln('No se encotro ese conductor. Agregelo.');
          CerrarInfracciones(archInf);
            AbrirConductores(archCond);

            AltaConductor(archCond, arbol, dni);
          CerrarConductores(archCond);
          AbrirInfracciones(archInf);
      end;

      X.dni:=dni;
      x.fecha_infraccion:= DateToStr(Date);

      clrscr();
      repeat
        writeln('Tipo de infraccion: ');
        writeln('1-Por falta de pago del peaje o contraprestación por tránsito. (1)');
        writeln('2-Por conducir sin tener cumplida la edad reglamentaria. (4)');
        writeln('3-Por utilizar franquicia de tránsito no reglamentaria, o usarla indebidamente. (4)');
        writeln('4-Por no respetar las indicaciones de las luces de los semáforos. (4)');
        writeln('5-Por circular con licencia de conducir vencida. (5)');
        writeln('6-Por circular con maquinaria especial en infracción a las normas reglamentarias. (5)');
        writeln('7-Por circular con vehículo de emergencia en infracción a las normas reglamentarias. (5)');
        writeln('8-Por conducir un vehículo con más de MEDIO gramo por litro de alcohol en sangre. (10)');
        writeln('9-Por participar u organizar competencias no autorizadas con automotores. (20)');
        writeln('10-Por conducir estando inhabilitado o con la habilitación suspendida. (20)');
        readln(op);

        case op of
             '1':begin
                puntos:= 1;
                tipo:= 'Por falta de pago del peaje o contraprestación por tránsito';
               end;
             '2':begin
                puntos:= 4;
                tipo:= 'Por conducir sin tener cumplida la edad reglamentaria';
               end;
             '3':begin
                puntos:= 4;
                tipo:= 'Por utilizar franquicia de tránsito no reglamentaria, o usarla indebidamente';
               end;
             '4':begin
                puntos:= 4;
                tipo:= 'Por no respetar las indicaciones de las luces de los semáforos';
               end;
             '5':begin
                puntos:= 5;
                tipo:= 'Por circular con licencia de conducir vencida';
               end;
             '6':begin
                puntos:= 5;
                tipo:= 'Por circular con maquinaria especial en infracción a las normas reglamentarias';
               end;
             '7':begin
                puntos:= 5;
                tipo:= 'Por circular con vehículo de emergencia en infracción a las normas reglamentarias';
               end;
             '8':begin
                puntos:= 10;
                tipo:= 'Por conducir un vehículo con más de MEDIO gramo por litro de alcohol en sangre';
               end;
             '9':begin
                puntos:= 20;
                tipo:= 'Por participar u organizar competencias no autorizadas con automotores';
               end;
             '10':begin
                puntos:= 20;
                tipo:= 'Por conducir estando inhabilitado o con la habilitación suspendida';
               end;
        end;
      until puntos <> 0;
      {
      repeat
      write('Fecha de infraccion: ');
      readln(fecha);

      if not(valFecha(fecha)) then writeln('Fecha invalida.');
      until valFecha(fecha);
      X.fecha_infraccion:=fecha;
      }

      X.tipo_infraccion:= tipo;
      X.puntos_descontar:=puntos;

        tam:= TamInfracciones(archInf);
        GuardarInfraccion(archInf, tam, X);
        MostrarInfraccion(X);
        writeln('La infraccion se anadio con exito.');
      CerrarInfracciones(archInf);

      AbrirConductores(archCond);
        ActualizarScoring(archCond, archInf, arbol, X);
      CerrarConductores(archCond);

      AbrirInfracciones(archInf);
      //writeln('Tamano de archivo: ', TamInfracciones(archInf));
      readkey;
  end;

  procedure MostrarInfraccion(X:T_Infracciones);
  begin
    Writeln('   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
    Writeln('  | DNI:                  ',X.dni);
    Writeln('  | Fecha de infraccione: ',X.fecha_infraccion);
    Writeln('  | Tipo de infraccion:   ',X.tipo_infraccion);
    Writeln('  | Puntos a descontar:   ',X.puntos_descontar);
    Writeln('');
  end;

  Function TamInfracciones(var arch:T_ArchInfracciones):Integer;
  begin
    TamInfracciones:= Filesize(arch);
  end;

  Function LeerInfraccion(var arch:T_ArchInfracciones; pos:Integer):T_Infracciones; //
  begin
    Seek(arch, pos);
    Read(arch, LeerInfraccion);
  end;

  Procedure GuardarInfraccion(var arch:T_ArchInfracciones; pos:Integer; X:T_Infracciones);
  begin
    Seek(arch, pos);
    Write(arch, X);
  end;

  Procedure ActualizarScoring(var arch:T_ArchConductores; var arch2:T_ArchInfracciones; var arbol:T_Arbol; x1:T_Infracciones);
  var
    x2:T_Conductores;
    pos:Integer;
  begin
    pos:= BuscarArbol(arbol, x1.dni);

    if pos <> -1 then
    begin
      x2:= LeerConductor(arch, pos);

      Dec(x2.scoring, x1.puntos_descontar);
      if x2.scoring <= 0 then
      begin
        CerrarConductores(arch);
        AbrirInfracciones(arch2);

        x2.habilitado:= False;
        x2.fecha_habilitado:= UltimaInfraccion(arch2, x2.dni).fecha_infraccion; // Cuando el scoring llega a 0 habilitado:= False y le pasa la fecha de la ultima infraccion.

        CerrarInfracciones(arch2);
        AbrirConductores(arch);
      end;

      GuardarConductor(arch, pos, x2);
      writeln('Se actualizo el scoring.');
    end
    else
    begin
      Writeln('No se pudo actualizar el scoring.');
    end;
  end;

  Function UltimaInfraccion(var arch:T_ArchInfracciones; dni:T_Dni):T_Infracciones;
  var
    fecha, ultFecha:String[10];
    i:Integer;
    X, ultInfraccion:T_Infracciones;
  begin
    ultFecha:='01/01/0001';

    for i:=0 to TamInfracciones(arch)-1 do
    begin
      X:=LeerInfraccion(arch, i);
      if X.dni = dni then
      begin
        fecha:=X.fecha_infraccion;
        if StrToDate(fecha)>StrToDate(ultFecha) then
        begin
           ultFecha:=fecha;
           ultInfraccion:=X;
        end;
      end;
    end;
    UltimaInfraccion:=ultInfraccion;
  end;
end.
