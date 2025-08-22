--uso de distinct
/*Una empresa tiene registrados sus clientes en una tabla llamada "clientes".
1- Elimine la tabla "clientes", si existe:*/
 if object_id('clientes') is not null
  drop table clientes;

/*2- Créela con la siguiente estructura:*/
 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  provincia varchar (20),
  primary key(codigo)
);

/*3- Ingrese algunos registros:*/
 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');

  select * from clientes

/*4- Obtenga las provincias sin repetir (3 registros)*/

select distinct provincia from clientes

/*5- Cuente las distintas provincias.*/

select count(distinct provincia)as cantidad from clientes

/*6- Se necesitan los nombres de las ciudades sin repetir (6 registros)*/

select distinct ciudad from clientes

--7- Obtenga la cantidad de ciudades distintas.

select count(distinct ciudad)as cantidad from clientes

--8- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba (3 registros)

select distinct ciudad from clientes
where provincia='cordoba'

--9- Contamos las distintas ciudades de cada provincia empleando "group by" (3 registros)
  select * from clientes

select provincia, count(distinct ciudad) as 'cantidad de ciudad' from clientes
group by provincia

----------------------------------------------------------------------
--uso de Top

/*Una empresa tiene registrados sus empleados en una tabla llamada "empleados".
1- Elimine la tabla si existe:*/
 if object_id('empleados') is not null
  drop table empleados;

--2- Créela con la siguiente estructura:
 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20)
 );

--3- Ingrese algunos registros:
 insert into empleados
  values ('22222222','Alberto Lopez','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez','c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres','s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia',null,'Administracion');

  select * from empleados

--4- Muestre los 5 primeros registros (5 registros)
select top 5 * from empleados

--5- Muestre nombre y seccion de los 4 primeros registros ordenados por sección (4 registros)

select top 4 nombre, seccion from empleados
order by seccion 

/*6- Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
"seccion" que el último (8 registros)*/


select top 4 with ties nombre, seccion from empleados
order by seccion 

/*7- Muestre nombre, estado civil y seccion de los primeros 4 empleados ordenados por estado civil y 
sección (4 registros)*/

select top 4 nombre,estadocivil, seccion from empleados
order by estadocivil, seccion

/*8- Realice la misma consulta anterior pero incluya todos los valores iguales al último registro 
retornado (5 registros)*/
select top 4 with ties  nombre,estadocivil, seccion from empleados
order by estadocivil, seccion
