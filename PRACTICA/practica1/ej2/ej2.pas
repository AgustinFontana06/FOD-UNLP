program ej2;
type
  archivoNumeros = file of integer;

procedure ingresarArchivo(var numeros : archivoNumeros)
var
 num : integer;
begin
 writeln('ingrese un numero');
 readln(num);
 while(num <> 30000) do begin
   write(numeros, num);
   writeln('ingrese un numero');
   readln(num);
 end;
end;

procedure recorrerArchivo(var numeros : archivoNumeros)
var
 num : integer;
 cantInf : integer;
 total : integer;
 promedio : real;
 suma : integer;
begin
  suma := 0;
  cantInf := 0;
  total := 0;
  
  reset(numeros);
  while not eof(numeros) do begin
    read(numeros, num);
    write(num);
    if(num < 1500) then
     cantInf := cantInf + 1;
    total := total + 1;
    suma := suma + num;
  end;
  
  if(total > 0) then
    promedio := suma / total;
  writeln('el promedio de todos los numeros es de: ', promedio:0:2);
  writeln('la cantidad total de numeros inferiores a 1500 es de: ', cantInf);
end;

var
  numeros : archivoNumeros;
  nom : string;
begin
  writeln('ingrese el nombre fisico para el archivo');
  readln(nom);
  assign(numeros, nom);
  rewrite(numeros);
  ingresarArchivo(numeros);
  recorrerArchivo(numeros);
  close(numeros);
end.
