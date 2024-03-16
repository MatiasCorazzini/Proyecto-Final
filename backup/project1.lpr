{
1 - Pasar leer y Guardar a Unit
2 - Rehacer unit de arbol
3 - Ampliar menu (listado - estadistica)
4 - Verificar si el conductor existe antes de una infraccion
5 - Modificar tipos de infracciones
     op1
     op2
     op3
6 - a su vez los puntos a descontar se vuelven automatico
7 - eliminar modificacion
8 - modiciar menu de conductores con clave
     si no existe -> alta
     si existe -> menu de opciones
}

program project1;

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Menu;

{ Constantes principales del sistema de scoring }

begin
  MainMenu();
end.

