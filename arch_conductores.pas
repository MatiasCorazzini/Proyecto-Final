unit Arch_Conductores;

interface

Uses
SysUtils, crt;

const
  rutaconductores = 'C:\archivos_scoring\conductores.dat';
//declaracion de archivo
type
  T_Dni = String[100];

  T_FechaNacimiento = record
     dia:byte;
     mes:byte;
     ano:integer;
  end;

  T_Conductores = Record
     dni:T_Dni;
     apynom:string[100];
     fecha_nacimiento:string[10];
     telefono:string[20];
     mail:string[30];
     scoring:integer;
     Habilitado:boolean;
     fecha_habilitado:string[20];
     cantidad_reincidencias:integer;
     activo:boolean;
  end;

  T_ArchConductores = File of T_Conductores;

  Procedure CrearConductores(var arch:T_ArchConductores);
  Procedure AbrirConductores(var arch:T_ArchConductores);
  Procedure CerrarConductores(var arch:T_ArchConductores);

  Function TamConductores(var arch:T_ArchConductores):Integer;

  Function LeerConductor(var arch:T_ArchConductores; pos:Integer):T_Conductores; //
  Procedure GuardarConductor(var arch:T_ArchConductores; pos:Integer; X:T_Conductores);


implementation

  Procedure CrearConductores(var arch:T_ArchConductores);
  begin
    Assign(arch, rutaconductores);
    rewrite(arch);
    writeln('     Archivo "conductores" creado');
  end;

  Procedure AbrirConductores(var arch:T_ArchConductores);
  begin
    Assign(arch, rutaconductores);
    //Para chequear si el archivo está creado y no de error al utilizar reset
    {$I-} //orden al compilador que deshabilite el control de IO
         Reset(arch);
    {$I+}
         if IOResult<>0 then
            CrearConductores(arch); // si el archivo no existe lo crea :)
  end;

  Procedure CerrarConductores(var arch:T_ArchConductores);
  begin
    Close(arch);
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
end.

