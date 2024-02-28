unit Arch_Infracciones;

interface

uses
SysUtils, crt;

const
  rutainfracciones = 'C:\archivos_scoring\infracciones.dat';

type
  T_Infracciones = Record
    dni:integer;
    fecha_infraccion:string[10];
    tipo_infraccion:string[200];
    puntos_descontar:Byte;
  end;

  T_ArchInfracciones = File Of T_Infracciones;

  Procedure CrearInfracciones(var arch:T_ArchInfracciones);
  Procedure AbrirInfracciones(var arch:T_ArchInfracciones);
  Procedure CerrarInfracciones(var arch:T_ArchInfracciones);

  Function TamInfracciones(var arch:T_ArchInfracciones):Integer;

  Function LeerInfraccion(var arch:T_ArchInfracciones; pos:Integer):T_Infracciones;
  Procedure GuardarInfraccion(var arch:T_ArchInfracciones; pos:Integer; X:T_Infracciones);


implementation

  Procedure CrearInfracciones(var arch:T_ArchInfracciones);
  begin
    Assign(arch, rutainfracciones);
    rewrite(arch);
    writeln('     Archivo "infracciones" creado');
  end;

  Procedure AbrirInfracciones(var arch:T_ArchInfracciones);
  begin
    Assign(arch, rutainfracciones);
    //Para chequear si el archivo está creado y no de error al utilizar reset
    {$I-}
        Reset(ARCH);
    {$I+}
        if IOResult<>0 then
           CrearInfracciones(arch); // si el archivo no existe lo crea :)
  end;

  Procedure CerrarInfracciones(var arch:T_ArchInfracciones);
  begin
    Close(arch);
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
end.
