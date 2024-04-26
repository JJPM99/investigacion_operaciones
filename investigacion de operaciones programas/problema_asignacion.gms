Sets
    I 'Tareas' /1*5/
    J 'Trabajadores' /1*3/;

Parameters
    c(I,J) 'Costo de asignar tarea i a trabajador j'
    p(J)   'Presupuesto de tiempo de trabajador j'
    t(I,J) 'Tiempo de hacer tarea i para trabajador j';

Scalar
    bigM 'Gran constante' /1000/;

table c(I,J)
               1  2  3
           1   10 20 30
           2   15 25 35
           3   20 30 40
           4   25 35 45
           5   30 40 50;

parameter p(J)   
          /1 100
           2 120
           3 150/;

table t(I,J) 
            1  2  3
          1 2  3  4
          2 3  4  5
          3 4  5  6
          4 5  6  7
          5 8  9  10;

Variables
    x(I,J) 'Variable binaria que indica si la tarea i se asigna al trabajador j';

free Variable
    z 'Función objetivo: costo total de asignación';

Equations
    Obj
    asignacion_unica(I) 'Cada tarea debe ser asignada a un solo trabajador'
    trabajador_asignado(J) 'Cada trabajador debe estar asignado a al menos una tarea'
    tiempo_presupuesto(J) 'El tiempo asignado por trabajador no debe exceder su presupuesto';

asignacion_unica(I).. 
    sum(J, x(I,J)) =e= 1;

trabajador_asignado(J).. 
    sum(I, x(I,J)) =g= 1;

tiempo_presupuesto(J).. 
    sum(I, t(I,J)*x(I,J)) =l= p(J);

* Función objetivo
Obj.. z =e= sum((I,J), c(I,J)*x(I,J));

* Restricción de asignación binaria
x.up(I,J) = 1;

* Resolver el modelo
Model asignacion_generalizada /all/;
option optcr = 0;
Solve asignacion_generalizada using lp minimizing z;