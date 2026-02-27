program ej1;
type
	ingresos = record
		codigo : integer;
		nombre : string[30];
		monto : real;
	end;
	
	archivo_ingresos = file of ingresos;

procedure compactarArchivo(var a : archivo_ingresos; var n : archivo_ingresos);
var
  actual : ingresos;
  reg : ingresos;
  codigo : integer;
  montoTotal : real;
begin
  reset(a);
  rewrite(n);
  
  if not eof(a) then begin
    read(a, reg);
    
    while(reg.codigo <> -1) do begin
	  actual := reg;
	  montoTotal := 0;
	  
	  while not eof(a) and (actual.codigo = reg.codigo) do begin
		montoTotal := montoTotal + reg.monto;
		read(a, reg);
	  end;
	  
	  if(actual.codigo = reg.codigo) then
	    montoTotal := montoTotal + reg.monto;
	  
	  actual.monto := montoTotal;
	  write(n, actual)
	  
	  if(eof(a)) then
	    reg.codigo := -1;
    end; 
  end;
  close(a);
  close(n);
end;

var
  a : archivo_ingresos;
  n : archivo_ingresos;
  nombre : string;
begin
  writeln('ingrese un nombre para el archivo');
  readln(nombre);
  assign(a, nombre);
  assign(n, 'comisiones_compactadas.txt');
  
  compactarArchivo(a, n);
end.
