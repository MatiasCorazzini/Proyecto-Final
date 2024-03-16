unit Lista_ConductoresA;

interface

uses
  SysUtils, crt, ArbolConductores, Arch_Conductores, Conductores, Estilo;

  procedure ImprimirListaConductoresA(L:T_Arbol; conScoring:Boolean; var arch:T_ArchConductores);
  procedure CrearListaConductoresA(var L:T_Arbol; var arch:T_ArchConductores);

implementation

 procedure CrearListaConductoresA(var L:T_Arbol; var arch:T_ArchConductores);
 var
   i:Integer;
   C:T_Conductores;
   elem:T_Elem;
 begin
   L := nil; // Inicializar el árbol

   if TamConductores(arch) > 0 then
   begin
     for i:=0 to TamConductores(arch)-1 do
     begin
       C:= LeerConductor(arch, i);
       elem.key:= C.apynom;
       elem.pos:= i;

       Insertar(L, elem);
     end;
   end;
   Writeln('Lista de "Conductores" creada...');
 end;

  procedure ImprimirCabeceraTabla;
  begin
    writeln(' #  | Apellido y Nombre         | DNI       | Scoring | Habilitado | Activo');
    writeln('---------------------------------------------------------------------------');
  end;

  procedure ImprimirUsuario(X:T_Conductores; counter:Integer);
  begin
     write(counter:3, ' | ', Format('%-25.25s', [X.apynom]), ' | ', Format('%-9.9s', [X.dni]),' | ');

    if X.cantidad_reincidencias > 0 then
    begin
      TextColor( Brown );
      Write(Format('%-7d', [X.scoring]));
    end
    else
    begin
      Write(Format('%-7d', [X.scoring]));
    end;
    CambiarTexto();

    write(' | ');

    if X.habilitado then
    begin
      TextColor( Green );
      Write('SI        ');
    end
    else
    begin
      TextColor( Red);
      Write('NO        ');
    end;
    CambiarTexto();

    write(' | ');

    if X.activo then
    begin
      TextColor( Green );
      Writeln('SI');
    end
    else
    begin
      TextColor( Red);
      Writeln('NO');
    end;
    CambiarTexto();
  end;

  procedure RecorrerLista(L:T_Arbol; conScoring:Boolean; var arch:T_ArchConductores; var conter:Integer);
  var
    X:T_Conductores;

  begin
    if L^.izq <> Nil then
       RecorrerLista(L^.izq, conScoring, arch, conter);

    X:=LeerConductor(arch, L^.raiz.pos);
    if not(conScoring) then
    begin
      Inc(conter);
      ImprimirUsuario(X, conter);
    end
    else
    begin
      if X.scoring <= 0 then
      begin
        ImprimirUsuario(X, conter);
        Inc(conter);
      end;
    end;

    if L^.der <> Nil then
       RecorrerLista(L^.der, conScoring, arch, conter);
  end;

  procedure ImprimirListaConductoresA(L:T_Arbol; conScoring:Boolean; var arch:T_ArchConductores);
  var
    conter:Integer;
  begin
    conter:=0;

    ImprimirCabeceraTabla;
    AbrirConductores(arch);
       RecorrerLista(L, conScoring, arch, conter);
    CerrarConductores(arch);
    readkey;
  end;

end.

