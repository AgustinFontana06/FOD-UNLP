program ej2;
type
  alumnos = record
	codigo : integer;
	apellido : string[30];
	nombre : string[30];
	materiasSinFinal : integer;
	materiasConFinal : integer;
  end;
  
  archivo_maestro : file of alumnos;
  
  materias = record
	codigo : integer;
	aproboFinal : boolean;
  end;
  
  archivo_detalle : file of materias;

procedure recorrerArchivos(var m : archivo_maestro; var d : archivo_detalle);
var
  alu : alumnos;
  materia : materias;
  aux_cod : integer;
begin
  reset(m);
  reset(d);
  
  if not eof(d)then
	read(d, materia); {leo una materia}
  
  while not eof(d) do begin
	read(m, alu); {leo un alumno}
    while(alu.codigo <> materia.codigo) do begin
      read(m, alu); {avanzo hasta encontrar el alumno correspondiente}
    end;
    
    aux_cod := materia.codigo; {guardo el codigo}
    
    while (not eof(d)) and (materia.codigo = aux_cod) do begin
      if(materia.aproboFinal) then begin
        alu.materiasSinFinal := alu.materiasSinFinal - 1;
        alu.materiasConFinal := alu.materiasConFinal + 1;
      end
      else
        alu.materiasSinFinal := alu.materiasSinFinal + 1;
      
      if not eof(d) then
        read(d, materia)
      else
        materia.codigo := -1;
    end;
    seek(m, filepos(m)-1);
    write(m, alu);
  end;
  close(m);
  close(d); 
end;

var
  d : archivo_detalle;
  m : archivo_maestro;
  nombre : string;
begin
  writeln('ingrese un nombre para el archivo maestro');
  readln(nombre);
  assign(m, nombre);
  
  writeln('ingrese un nombre para el archivo detalle');
  readln(nombre);
  assign(d, nombre);
  
  recorrerArchivos(m,d);
end.
