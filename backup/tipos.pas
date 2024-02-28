unit Tipos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  T_Conductores = RECORD
    dni:integer;
    apynom:string;
    nacimiento:string[8];
    telefono:integer;
    email:string;
    scoring:word;
    enabled:boolean;
    fecha_habilitacion:string[10];
    cant_reincidencias:integer;
  end;

  T_Infracciones = RECORD
    dni:integer;
    fecha_infraccion:string[10];
    tipo_infraccion:string;
    puntos_descontar:word;
  end;

  T_ArchConductores = FILE OF T_Conductores;
  T_ArchInfractores = FILE OF T_Infracciones

implementation



end.

