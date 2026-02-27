program program1;
type
  numeros = file of integer;
var
  archivo : numeros;
  nom : string;
  num: integer;
begin
  writeln('ingrese el nombres del archivo');
  readln(nom);
  assign(archivo, nom);
  rewrite(archivo);
  writeln('ingrese numeros');
  readln(num);
  while(num <> 30000) do begin
    write(archivo, num);	
    readln(num);			
  end;
  close(archivo);
end.
