Sets
    Products /p1*p2/
    Machines /m1*m2/;

Scalar
    CAP1 /1000/
    CAP2 /1000/
    DEM1 /300/
    DEM2 /250/;



free variables
z;

Table cost(Products, Machines)
          m1    m2
    p1    500   400 
    p2    500   400;
    
table x(products, machines)
            m1    m2
    p1     100  200
    p2     150  100;


Equations
OBJ
R1
R2
R3
R4;

OBJ..
    sum((products, machines), Cost(products, machines) * x(products,machines)) =e=z;

R1..
    x('p1', 'm1') + x('p1', 'm1') =l= CAP1;
R2..
    x('p1', 'm2') + x('p2', 'm2') =l= CAP2;

R3..
    x('p1', 'm1') + x('p1', 'm2') =e= DEM1;

R4..
    x('p2', 'm1') + x('p2', 'm2') =e= DEM2;
    


Model ProductionPlanning /all/;
Solve ProductionPlanning using LP minimizing z;