/*uso de left join
Se emplea una combinación externa izquierda para mostrar todos los registros de la tabla de la izquierda. 
Si no encuentra coincidencia con la tabla de la derecha, el registro muestra los campos de la segunda tabla seteados a "null".
Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"provincias" donde registra los nombres de las provincias.
1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:*/
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

--2- Ingrese algunos registros para ambas tablas:
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

--3- Muestre todos los datos de los clientes, incluido el nombre de la provincia:
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo;

--4- Realice la misma consulta anterior pero alterando el orden de las tablas:
 select c.nombre,domicilio,ciudad, p.nombre
  from provincias as p
  left join clientes as c
  on codigoprovincia = p.codigo;

--5- Muestre solamente los clientes de las provincias que existen en "provincias" (5 registros):
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.codigo is not null;

/*6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
nombre del cliente (2 registros):*/
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.codigo is null
  order by c.nombre;

--7- Obtenga todos los datos de los clientes de "Cordoba" (3 registros):
 select c.nombre,domicilio,ciudad, p.nombre
  from clientes as c
  left join provincias as p
  on codigoprovincia = p.codigo
  where p.nombre='Cordoba';
  -------------------------------------------------------------------------------------------------
  --uso de right join
  /*Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una 
tabla "provincias" donde registra los nombres de las provincias.
1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:*/
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

--2- Ingrese algunos registros para ambas tablas:
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

--3- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right join".

select c.nombre, domicilio, ciudad, p.nombre as 'nombre provincia' from provincias as p
right join clientes as c
on codigoprovincia=p.codigo

--4- Obtenga la misma salida que la consulta anterior pero empleando un "left join".

select c.nombre, domicilio, ciudad, p.nombre as 'nombre provincia' from clientes as c
left join provincias as p
on codigoprovincia=p.codigo

/*5- Empleando un "right join", muestre solamente los clientes de las provincias que existen en 
"provincias" (5 registros)*/


select c.nombre, domicilio, ciudad, p.nombre as 'nombre provincia' from clientes as c
right join provincias as p
on codigoprovincia=p.codigo
where c.nombre is not null 

/*6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
ciudad (2 registros)*/
select * from clientes

select c.nombre, domicilio, ciudad, p.nombre as 'nombre provincia' from provincias as p
right join clientes as c
on codigoprovincia=p.codigo
where p.codigo is null
order by c.ciudad

------------------------------------------------------------------------------------------
/* full join
Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada "deportes" 
en la cual incluye el nombre del deporte y el nombre del profesor y en otra tabla llamada 
"inscriptos" que incluye el documento del socio que se inscribe, el deporte y si la matricula está 
paga o no.
1- Elimine las tablas si existen y cree las tablas:*/
 if (object_id('deportes')) is not null
  drop table deportes;
 if (object_id('inscriptos')) is not null
  drop table inscriptos;

 create table deportes(
  codigo tinyint identity,
  nombre varchar(30),
  profesor varchar(30),
  primary key (codigo)
 );
 create table inscriptos(
  documento char(8),
  codigodeporte tinyint not null,
  matricula char(1) --'s'=paga 'n'=impaga
 );

--2- Ingrese algunos registros para ambas tablas:
 insert into deportes values('tenis','Marcelo Roca');
 insert into deportes values('natacion','Marta Torres');
 insert into deportes values('basquet','Luis Garcia');
 insert into deportes values('futbol','Marcelo Roca');
 
 insert into inscriptos values('22222222',3,'s');
 insert into inscriptos values('23333333',3,'s');
 insert into inscriptos values('24444444',3,'n');
 insert into inscriptos values('22222222',2,'s');
 insert into inscriptos values('23333333',2,'s');
 insert into inscriptos values('22222222',4,'n'); 
 insert into inscriptos values('22222222',5,'n'); 

/*3- Muestre todos la información de la tabla "inscriptos", y consulte la tabla "deportes" para 
obtener el nombre de cada deporte (6 registros)*/
select * from inscriptos

select i.documento, d.nombre, i.matricula from inscriptos as i
join deportes as d
on codigodeporte=d.codigo

--4- Empleando un "left join" con "deportes" obtenga todos los datos de los inscriptos (7 registros)

select i.documento, d.nombre, i.matricula from inscriptos as i
left join deportes as d
on codigodeporte=d.codigo

--5- Obtenga la misma salida anterior empleando un "rigth join".

select i.documento, d.nombre, i.matricula from deportes as d
right join inscriptos as i
on codigodeporte=d.codigo

--6- Muestre los deportes para los cuales no hay inscriptos, empleando un "left join" (1 registro)
select * from inscriptos
select * from deportes

select i.documento, d.nombre, i.matricula from deportes as d
left join inscriptos as i
on codigodeporte=d.codigo
where codigodeporte is null


/*7- Muestre los documentos de los inscriptos a deportes que no existen en la tabla "deportes" (1 
registro)*/

select i.documento from inscriptos as i
left join deportes as d
on codigodeporte=d.codigo
where d.codigo is null

/*8- Emplee un "full join" para obtener todos los datos de ambas tablas, incluyendo las inscripciones 
a deportes inexistentes en "deportes" y los deportes que no tienen inscriptos (8 registros)*/

select documento,nombre,profesor,matricula
  from inscriptos as i
  full join deportes as d
  on codigodeporte=codigo; 