program ej3;
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
 
 close(arcEmpleados);
end.
