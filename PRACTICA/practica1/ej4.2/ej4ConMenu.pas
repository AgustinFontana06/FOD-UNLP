program ej4ConMenu;
type
 str20 = String[20];
 str8 = String[8];
 empleados = record
	nro : integer;
	apellido : str20;
	nombre : str20;
	edad : integer;
	dni : str8;
 end;
 archivoEmpleados = file of empleados;

procedure leerEmpleados(var e : empleados);
begin
   writeln('ingrese el apellido del empleado');
   readln(e.apellido);
   if(e.apellido <> 'fin') then begin
    writeln('ingrese el numero de empleado');
    readln(e.nro);
    writeln('ingrese el nombre del empleado');
    readln(e.nombre);
    writeln('ingrese la edad del empleado');
    readln(e.edad);
    writeln('ingrese el dni del empleado');
    readln(e.dni);
   end;
end;

procedure ingresarEmpleados(var arcEmpleados : archivoEmpleados);
var
 e : empleados;
begin
 rewrite(arcEmpleados);
 leerEmpleados(e);
 while(e.apellido <> 'fin') do begin
  write(arcEmpleados, e);
  leerEmpleados(e);
 end;
 close(arcEmpleados);
end;

procedure listarEmpleados(var arcEmpleados : archivoEmpleados);
var
  e : empleados;
begin
  reset(arcEmpleados);
 
  while not eof(arcEmpleados) do begin
   read(arcEmpleados, e);
   writeln(e.nro);
   writeln(e.apellido);
   writeln(e.nombre);
   writeln(e.dni);
   writeln(e.dni);
  end;
  close(arcEmpleados);
end;
 
procedure listarMayores70(var arcEmpleados : archivoEmpleados);
var
  e : empleados;
begin
  reset(arcEmpleados);
 
  while not eof(arcEmpleados) do begin
   read(arcEmpleados, e);
   if(e.edad > 70) then begin
    writeln(e.nro);
    writeln(e.apellido);
    writeln(e.nombre);
    writeln(e.edad);
    writeln(e.dni);
   end;
  end;
  
  close(arcEmpleados);
end;
 
procedure listarEmpleadoPorNombreApellido(var arcEmpleados : archivoEmpleados);
var
  e : empleados;
  nombre, apellido : string;
begin
  reset(arcEmpleados);
 
  writeln('ingrese el nombre de la persona');
  readln(nombre);
  writeln('ingrese el apellido de la persona');
  readln(apellido);
 
  while not eof(arcEmpleados) do begin
   read(arcEmpleados, e);
   if(e.apellido = apellido) or (e.nombre = nombre) then begin
    writeln(e.nro);
    writeln(e.apellido);
    writeln(e.nombre);
    writeln(e.edad);
    writeln(e.dni);
   end;
  end;
  close(arcEmpleados);
end;

procedure agregarEmpleados(var arcEmpleados : archivoEmpleados); 
var
  e, emp: empleados;
  encontre : boolean;
begin
  reset(arcEmpleados);
  writeln('si desea agregar empleados ingrese sus datos, sino ingrese fin en el apellido para no agregar');
  leerEmpleados(e);
  while(e.apellido <> 'fin') do begin
   encontre := false;
   seek(arcEmpleados, 0);
   while (not eof (arcEmpleados)) and (not encontre) do begin
    read(arcEmpleados, emp);
    if(emp.nro = e.nro) then
     encontre := true;
   end;
   
   if(not encontre) then begin
    seek(arcEmpleados, fileSize(arcEmpleados));
    write(arcEmpleados, e);
   end
   else
    writeln('el numero ya existe');
   leerEmpleados(e);
  end;
  close(arcEmpleados);
end; 

procedure modificarEdad(var arcEmpleados : archivoEmpleados)
 var
  nro, edad : integer;
  emp : Empleados;
  encontre : boolean;
begin
  reset(arcEmpleados);
  writeln('ingrese el numero del empleado a buscar');
  readln(nro);
  writeln('ingrese la edad del empleado a buscar');
  readln(edad);
  encontre := false;
  
  while(not eof arcEmpleados) and (not encontre) do begin
   read(arcEmpleados, emp);
   
   if(emp.nro = nro) then begin
     emp.edad := edad;
     seek(arcEmpleados, filepos(arcEmpleados)-1);
     write(arcEmpleados, emp);
     encontre := true;
   end;
  end;
  
  if(not encontre) then begin
   writeln('no se encontro el empleado');
  end
  else
   writeln('edad actualizada');
  end;
  
  close(arcEmpleados);
end;

procedure exportarATexto(var arcBin: archivoEmpleados);
var
  arcTexto: Text;
  e: empleados;
begin
  assign(arcTexto, 'todos_empleados.txt');
  rewrite(arcTexto); { Crea el archivo de texto } 
  reset(arcBin);     { Abre el binario para leer } 
  
  while not eof(arcBin) do begin
    read(arcBin, e);
    { Escribe los campos en una línea separados por espacios }
    writeln(arcTexto, e.nro, ' ', e.edad, ' ', e.dni, ' ', e.apellido, ' ', e.nombre); 
  end;
  
  close(arcTexto); 
  close(arcBin);
  writeln('Archivo todos_empleados.txt generado con exito.');
end;

procedure exportarSinDNI(var arcBin: archivoEmpleados);
var
  arcTexto: Text;
  e: empleados;
begin
  assign(arcTexto, 'faltaDNIEmpleado.txt');
  rewrite(arcTexto);
  reset(arcBin);
  
  while not eof(arcBin) do begin
    read(arcBin, e);
    if (e.dni = '00') then { Según consigna DNI en 00 } 
      writeln(arcTexto, e.nro, ' ', e.edad, ' ', e.dni, ' ', e.apellido, ' ', e.nombre);
  end;
  
  close(arcTexto);
  close(arcBin);
  writeln('Archivo faltaDNIEmpleado.txt generado con exito.');
end;

var	
 nombre : string;
 arcEmpleados : archivoEmpleados;
 opcion : integer;
begin
 writeln('ingrese un nombre para el archivo');
 readln(nombre);
 assign(arcEmpleados, nombre);


 repeat
	writeln('MENU PRINCIPAL');
	writeln('1. Crear un archivo');
	writeln('2. Abrir un archivo existente');
	writeln('0. Salir');
 
	writeln('opcion:');
	readln(opcion);
 
	if(opcion = 1) then
		ingresarEmpleados(arcEmpleados)
	else if (opcion = 2) then begin
		repeat
			writeln('perfecto, ahora seleccione las opciones deseadas para las siguientes operaciones');
			writeln('Opcion 1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
			writeln('Opcion 2: Listar los empleados de a uno');
			writeln('Opcion 3: Listar los empleados mayores de 70 años');
			writeln('Opcion 4: Agregar empleados sin que sean repetidos');
			writeln('Opcion 5: Modificar laedad de un empleado');
			writeln('Opcion 6: Exportar contenido');
			writeln('Opcion 7: Exportar los empleados que no tengan cargado el dni');
			readln(opcion);
			case opcion of
				0: writeln('finalizacion del programa');
				1: listarEmpleadoPorNombreApellido(arcEmpleados);
				2: ListarEmpleados(arcEmpleados);
				3: ListarMayores70(arcEmpleados);
				4: agregarEmpleados(arcEmpleados);
				5: modificarEdad(arcEmpleados);
				6: exportarATexto(arcEmpleados);
				7: exportarSinDNI(arcEmpleados);
				else: writeln('opcion invalida');
			end;
		until(opcion = 0);
		opcion := -1; //evitar salir del otro repeat 	
	end;
 until(opcion = 0);
end.
