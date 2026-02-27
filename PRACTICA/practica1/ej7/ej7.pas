program ejercicio7;

type
    novela = record
        codigo: integer;
        nombre: string;
        genero: string;
        precio: real;
    end;

    archivoNovelas = file of novela;
    
procedure crearBinario(var arcBin: archivoNovelas);
var
    arcTxt: Text;
    n: novela;
begin
    assign(arcTxt, 'novelas.txt');
    reset(arcTxt); 
    
    rewrite(arcBin); 
    
    while not eof(arcTxt) do begin
        readln(arcTxt, n.codigo, n.precio, n.genero);
        readln(arcTxt, n.nombre);
        
        write(arcBin, n);
    end;
    
    close(arcBin);
    close(arcTxt);
    writeln('Archivo binario creado exitosamente.');
end;

procedure leerNovela(var n: novela);
begin
    write('Ingrese codigo de novela (0 para terminar): '); readln(n.codigo);
    if (n.codigo <> 0) then begin
        write('Nombre: '); readln(n.nombre);
        write('Genero: '); readln(n.genero);
        write('Precio: '); readln(n.precio);
    end;
end;

procedure actualizarNovelas(var arcBin: archivoNovelas);
var
    n, nLeida: novela;
    opc, codBus: integer;
    encontre: boolean;
begin
    reset(arcBin);
    writeln('1. Agregar novela | 2. Modificar novela existente');
    readln(opc);
    
    if (opc = 1) then begin
        leerNovela(n);
        seek(arcBin, fileSize(arcBin)); 
        write(arcBin, n);
    end
    else if (opc = 2) then begin
        write('Codigo de novela a modificar: '); readln(codBus);
        encontre := false;
        while (not eof(arcBin)) and (not encontre) do begin
            read(arcBin, nLeida);
            if (nLeida.codigo = codBus) then begin
                encontre := true;
                write('Ingrese nuevo precio: '); 
                readln(nLeida.precio);
                seek(arcBin, filePos(arcBin) - 1); 
                write(arcBin, nLeida);
            end;
        end;
        if not encontre then 
         writeln('Novela no encontrada.');
    end;
    close(arcBin);
end;

var
    arcNovelas: archivoNovelas;
    nomBin: string;
begin
    write('Nombre para el archivo binario: '); 
    readln(nomBin);
    assign(arcNovelas, nomBin);
    
    crearBinario(arcNovelas);
    actualizarNovelas(arcNovelas);
end.
