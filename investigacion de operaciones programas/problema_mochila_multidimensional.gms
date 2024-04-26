Sets
    I 'Artículos' /1*100/
    C 'Clases' /Baja, Media, Alta/;

Parameters
    bi(I) 'Beneficio de los artículos'
    wi(I) 'Peso de los artículos'
    W 'Capacidad de la mochila';

Scalar
    numItemsPerClass 'Número de artículos por clase' /25/;

* Generar datos aleatorios para beneficio y peso de los artículos
Set I_baja(I) 'Artículos en clase baja' /1*25/
    I_media(I) 'Artículos en clase media' /26*50/
    I_alta(I) 'Artículos en clase alta' /51*100/;

Parameter
    minBeneficio 'Valor mínimo de beneficio' /10/
    maxBeneficio 'Valor máximo de beneficio' /100/
    minPeso 'Peso mínimo del artículo' /1/
    maxPeso 'Peso máximo del artículo' /20/;

Loop(I_baja,
    bi(I) = uniformInt(minBeneficio, maxBeneficio);
    wi(I) = uniformInt(minPeso, maxPeso);
);

Loop(I_media,
    bi(I) = uniformInt(minBeneficio * 2, maxBeneficio * 2);  
    wi(I) = uniformInt(minPeso * 2, maxPeso * 2);  
);
 

Loop(I_alta,
    bi(I) = uniformInt(minBeneficio * 3, maxBeneficio * 3); 
    wi(I) = uniformInt(minPeso * 3, maxPeso * 3);
);

* Definir capacidad de la mochila
W = 200;

Variables
    x(I) 'Variable binaria que indica si el artículo i se incluye en la mochila';

Free Variable
    pesoTotal 'Peso total de la mochila';

Equations
    objetivo 'Función objetivo'
    capacidad 'Restricción de capacidad';

objetivo..
    pesoTotal =e= sum(I, wi(I)*x(I));

capacidad..
    sum(I, wi(I)*x(I)) =l= W;

* Asignar valores para obtener una solución óptima
x.fx('1') = 1;
x.fx('2') = 1;
x.fx('3') = 1;
x.fx('25') = 1;

* Resolver el modelo
Model knapsack /all/;
Solve knapsack using lp maximizing pesoTotal;



