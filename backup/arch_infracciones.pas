unit Arch_Infracciones;

interface

uses
SysUtils, crt;

const
  rutainfracciones = 'C:\Users\nahue\OneDrive\Escritorio\archivos_scoring\infracciones.dat';

type
  T_Infracciones = Record
    dni:String[8];
    fecha_infraccion:string[10];
    tipo_infraccion:string[200];
    puntos_descontar:Byte;
  end;

  T_ArchInfracciones = File Of T_Infracciones;

  Procedure CrearInfracciones(var arch:T_ArchInfracciones);
  Procedure AbrirInfracciones(var arch:T_ArchInfracciones);
  Procedure CerrarInfracciones(var arch:T_ArchInfracciones);

implementation

  Procedure CrearInfracciones(var arch:T_ArchInfracciones);
  begin
    Assign(arch, rutainfracciones);
    rewrite(arch);
    //writeln('     Archivo "infracciones" creado');
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
end.

