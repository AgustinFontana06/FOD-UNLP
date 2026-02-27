program ej6;
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

procedure exportar1(var arcCelulares : archivoCelulares);
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

procedure agregarCelular(var arcCelulares : archivoCelulares);
 
 procedure leerCelulares(var c : celulares; var seguir : boolean);
 begin
  writeln('ingrese el codigo');
  readln(c.cod);
  writeln('ingrese el nombre');
  readln(c.nombre);
  writeln('ingrese la descripcion');
  readln(c.descripcion)
  writeln('ingrese la marca');
  readln(c.marca)
  writeln('ingrese el precio');
  readln(c.precio)
  writeln('ingrese el stock minimo');
  readln(c.stockMin);
  writeln('ingrese el stock disponible');
  readln(c.stockDisp);
  writeln('desea agregar mas celulares?');
  readln(seguir);
 end;

var
 c, c2 : celulares;
 seguir, existe : boolean;
begin
 reset(arcCelulares);
 seguir := true;
 writeln('ingrese los datos de los celulares a agregar');

 while(seguir) do begin
  leerCelulares(c, seguir);
  existe := false;
  seek(arcCelulares, 0); {nos posicionamos al principio}
  while(not eof (arcCelulares)) and (not existe) do begin
   read(arcCelulares, c2);
   if(c2.nombre = c.nombre) then
    existe := true;
  end;a
  
  if(not existe) then begin
   seek(arcCelulares, fileSize(arcCelulares)); {nos posicionamos al final}
   write(arcCelulares, c);
   writeln('celular agregado');
  end;
  else
   writeln('el celular ya se encuentra registrado');
 end;
 
 close(arcCelulares);
end;

procedure modificarStock(var arcCelulares : archivoCelulares);
var
 cod, stock : integer;
 encontre : boolean;
 c : celulares;
begin
 reset(arcCelulares);
 writeln('ingrese el codigo del celular para cambiarle el stock');
 readln(cod);
 writeln('ingrese el stock nuevo');
 readln(stock);
 
 encontre := false;
 
 while(not eof(arcCelulares)) and (not encontre) do begin
  read(arcCelulares, c);
  if(c.cod = cod) then
   encontre := true;
 end;
 
 if(not encontre) then
  writeln('no se encontro el celular')
 else begin
  c.stockDisp := stock;
  seek(arcCelulares, filePos(arcCelulares)-1);
  write(arcCelulares, c);
  writeln('stock agregado con exito');
 end;
 close(arcCelulares);
end;

procedure exportar2(var arcCelulares : archivoCelulares);
var
 arcTexto : Text;
 c : celulares;
begin
 assign(arcTexto, 'SinStock.txt');
 rewrite(arcTexto);
 reset(arcCelulares);
 
 while not eof(arcCelulares) do begin
  read(arcCelulares, c);
  if(c.stockDisp = 0) then begin
   writeln(arcTexto, c.cod, ' ', c.precio:0:2, ' ', c.marca);
   writeln(arcTexto, c.stockDisp, ' ', c.stockMin, ' ', c.descripcion);
   writeln(arcTexto, c.nombre);
  end;
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
	4: exportar1(arcCelulares);
	5: agregarCelular(arcCelulares);
	6: modificarStock(arcCelulares);
	7: exportar2(arcCelulares);
  else	
	writeln('opcion invalida');
 until(opcion = 0);
end.
