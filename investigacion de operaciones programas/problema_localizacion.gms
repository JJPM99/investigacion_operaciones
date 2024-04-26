Sets
    i   Localizaciones / 1*5 /
    j   'clientes' / 1*3 /;

Parameters
    fi(i) 'Costo de instalar fabrica de i en I'
    /
    1 2
    2 5
    3 3
    4 7
    5 3/    
    bi(i)   'Capacidad de ubicacion en i en I '
    /
    1 400
    2 200
    3 500
    4 600
    5 300
    /
    dj(j)   'Demanda de cliente j'
    /
    1 30
    2 40 
    3 70
     /;

Scalar
    M 'Número grande suficiente para modelar restricciones de y_i';

Parameter
    M / 1000 /; 

Table costos(i,j) 'Costo de envío de i a j'
            1       2       3
    1      10      15      20
    2      12      17      14
    3      18      22      16
    4      20      24      22
    5      25      20      15;

Free Variable
z;

Variables
    yi(i)       'Variable binaria que indica si se instala la fábrica en i'
    xij(i,j)    'Cantidad de producto que se envía de i a j';

Binary Variable yi;

Positive Variables xij;

Equations
    OBJ Función objetivo
    R1  Restricción de demanda
    R2  Restricción de capacidad;


OBJ..   z =e= sum(i, fi(i)*yi(i) + sum(j, costos(i,j)*xij(i,j)));


R1(j)..    sum(i, xij(i,j)) =e= dj(j);


R2(i)..    sum(j,xij(i,j)) =l= bi(i)*yi(i);

Model facility_location /all/;
Solve facility_location using mip minimizing z;
