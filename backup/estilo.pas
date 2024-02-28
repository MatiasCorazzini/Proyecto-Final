unit Estilo;

interface

uses
  Classes, SysUtils, crt;

Procedure CambiarFondo();
Procedure CambiarTexto();


implementation

Procedure CambiarFondo();
begin
 TextBackground ( DarkGray );
end;

Procedure CambiarTexto();
begin
   TextColor( Magenta );
end;

end.

