unit Infracciones;

interface

const
rutaInfracciones = 'c:\infracciones.dat';

type
  T_Infracciones = Record
    dni:integer;
    fecha_infraccion:string[10];
    tipo_infraccion:char;   // a:2p, b:4p, c:5p, d:10p, e:20p
    puntos_descontar:integer;
  end;

  T_ArchInfractores = File Of T_Infracciones;

Procedure CrarArchInfracciones(var ARCH:T_ArchInfractores);
Procedure AbrirArchInfracciones(var ARCH:T_ArchInfractores);
Procedure CerrarArchInfracciones(var ARCH:T_ArchInfractores);

implementation

  Procedure CrarArchInfracciones(var ARCH:T_ArchInfractores);
    begin
      Assign(ARCH, rutaInfracciones);
      Rewrite(ARCH);
    end;

  Procedure AbrirArchInfracciones(var ARCH:T_ArchInfractores);
    begin
      {$I-}
      Reset(ARCH);
      {$I+}
      if IOResult<>0 then
         Rewrite(ARCH); // si el archivo no existe lo crea :)
    end;

  Procedure CerrarArchInfracciones(var ARCH:T_ArchInfractores);
    begin
      Close(ARCH);
    end;

  Function LeerInfraccion(var ARCH:T_ArchInfractores; pos:integer):T_Infracciones; // Devuelve el registo
  begin
    Seek(ARCH, pos);
    Read(ARCH, LeerInfraccion);
  end;

  Procedure AgregarInfraccion(var ARCH:T_ArchInfractores; elem:T_Infracciones);
  begin
    Seek(ARCH, Filesize(ARCH));
    Write(ARCH, elem);
  end;

  function ActualizarInfraccion(elem:T_Infracciones):T_Infracciones; // Devuelve el registro modificado
  begin
    {
     Menu para actualizar los campos de una infraccion
    }
  end;

  Procedure ModificarInfraccion(var ARCH:T_ArchInfractores; pos:integer);
  begin
     Seek(ARCH, pos);
     Write(ARCH, ActualizarInfraccion(LeerInfraccion(ARCH, pos)));
  end;

end.

