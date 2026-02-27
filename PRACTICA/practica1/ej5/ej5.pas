program ej5;
type
	celulares = record
		cod : integer;
		nombre : string;
		descripcion : string;
		marca : string;
		precio : real;
		stockMin : integer;
		stockDisp : integer;
	end;
	
	archivoCelulares = file of celulares;

procedure crearArchivo(var a : archivoCelulares);
var
 arcTexto : Text;
 c : celulares;
 nombre : string;
begin
 writeln('Ingrese un nombre para el archivo');
 readln(nombre);
 
 assign(arcTexto, nombre);
 reset(arcTexto); {abro el archivo viejo}
 rewrite(a); {creo el nuevo archivo}
 
 while not eof(arcTexto) do begin
  readln(arcTexto, c.cod, c.precio, c.marca);
  
  readln(arcTexto, c.stockMin, c.stockDisp, c.descripcion);
  
  readln(arcTexto, c.nombre);
  
  write(a, c);
 end;	
 
 close(a);
 close(arcTexto);
end;

procedure imprimirProducto(c : celulares);
begin
 writeln('codigo: ', c.cod);
 writeln('nombre: ', c.nombre);
 writeln('descripcion: ', c.descripcion);
 writeln('marca: ', c.marca);
 writeln('precio: ', c.precio);
 writeln('stock minimo: ', c.stockMin);
 writeln('stock disponible: ', c.stockDisp);
end;

procedure listarPorStock(var arcCelulares : archivoCelulares);
var
 c : celulares;
begin
 reset(arcCelulares);
 while not eof(arcCelulares) do begin
  read(arcCelulares, c);
  if(c.stockDisp < stockMin) then
  begin
   imprimirProducto(c);
  end;
 end;
 
 close(arcCelulares);
end;

procedure listarPorDescripcion(var arcCelulares : archivoCelulares);
var
 texto : String;
 c : celulares;
begin
 reset(arcCelulares);
 
 writeln('Ingrese una cadena de texto');
 readln(texto);
 
 texto := '' + texto + '';
 
 while not eof(arcCelulares) do begin
  read(arcCelulares, c);
  
  if(Pos(texto, c.descripcion) > 0) then
  begin
   imprimirProducto(c);
  end;
 end;
 
 close(arcCelulares);
end;

procedure exportar(var arcCelulares : archivoCelulares);
var
 arcTexto : Text;
 c : celulares;
begin
 assign(arcTexto, 'celulares.txt');
 rewrite(arcTexto);
 reset(arcCelulares);
 
 while not eof(arcCelulares) do begin
  read(arcCelulares, c);
  writeln(arcTexto, c.cod, ' ', c.precio:0:2, ' ', c.marca);
  writeln(arcTexto, c.stockDisp, ' ', c.stockMin, ' ', c.descripcion);
  writeln(arcTexto, c.nombre);
 end;
 
 close(arcCelulares);
 close(arcTexto);
end;

var
 arcCelulares : archivoCelulares;
 opcion : integer;
begin
 writeln('Bienvenido al menu, selecciona una opcion');
 repeat
  writeln('O: Salir');
  writeln('1: Crear archivo');
  writeln('2: Listar celulares por stock minimo');
  writeln('3: Listar celulares por descripcion');
  writeln('4: Exportar archivo');
  readln(opcion);
  case opcion of
	0: writeln('finalizacion del programa');
	1: crearArchivo(arcCelulares);
	2: listarPorStock(arcCelulares);
	3: listarPorDescripcion(arcCelulares);
	4: exportar(arcCelulares);
  else
	writeln('opcion invalida');
 until(opcion = 0);
end.
