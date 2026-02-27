program ej4;
type
 empleados = record
	nro : integer;
	apellido : string;
	nombre : string;
	edad : integer;
	dni : integer;
 end;
 
 archivoEmpleados = file of empleados;

 procedure ingresarEmpleados(var arcEmpleados : archivoEmpleados);
  
  procedure leerEmpleados(var e : empleados)
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
 
 var
  e : empleados;
 begin
  rewrite(arcEmpleados);
  leerEmpleados(e);
  while(e.apellido <> 'fin') do begin
   write(arcEmpleados, e);
   leerEmpleados(e);
  end;
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
end;
 
procedure listarEmpleadoPorNombreApellido(var arcEmpleados : archivoEmpleados; nombre,apellido : string);
var
  e : empleados;
begin
  reset(arcEmpleados);
 
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
end;

procedure agregarEmpleados(var arcEmpleados : archivoEmpleados);
 
 procedure leerEmpleados(var e : empleados)
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
   while (not eof arcEmpleados) and (not encontre) do begin
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
   writeln('no se encontro el empleado')
  else
   writeln('edad actualizada');
  end;
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
    if (e.dni = 0) then { Según consigna DNI en 00 } 
      writeln(arcTexto, e.nro, ' ', e.edad, ' ', e.dni, ' ', e.apellido, ' ', e.nombre);
  end;
  
  close(arcTexto);
  writeln('Archivo faltaDNIEmpleado.txt generado con exito.');
end;

var	
 nombre : string;
 apellido : string;
 arcEmpleados : archivoEmpleados;
begin
 writeln('ingrese un nombre para el archivo');
 readln(nombre);
 assign(arcEmpleados, nombre);
 
 rewrite(arcEmpleados);
 
 ingresarEmpleados(arcEmpleados);
 
 writeln('ingrese el nombre de la persona');
 readln(nombre);
 writeln('ingrese el apellido de la persona');
 readln(apellido);
 listarEmpleadoPorNombreApellido(arcEmpleados, nombre, apellido);
 
 listarEmpleados(arcEmpleados);
 
 listarMayores70(arcEmpleados);
 
 agregarEmpleados(arcEmpleados);
 
 modificarEdad(arcEmpleados);
 
 close(arcEmpleados);
end.
