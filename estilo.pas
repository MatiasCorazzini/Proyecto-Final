unit Estilo;

interface

uses
  SysUtils, crt;

Procedure CambiarFondo();
Procedure CambiarTexto();


implementation

Procedure CambiarFondo();
begin
 TextBackground ( DarkGray );
end;

Procedure CambiarTexto();
begin
   TextColor( LightCyan );
end;

end.

