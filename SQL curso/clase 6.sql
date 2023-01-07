--uso de funcion count()
 if object_id('medicamentos') is not null
  drop table medicamentos;

 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(6,2),
  cantidad tinyint,
  fechavencimiento datetime not null,
  numerolote int default null,
  primary key(codigo)
 );

 insert into medicamentos
  values('Sertal','Roche',5.2,1,'2015-02-01',null);
 insert into medicamentos 
  values('Buscapina','Roche',4.10,3,'2016-03-01',null);
 insert into medicamentos 
  values('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null);
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,20,'2018-02-01',null);
 insert into medicamentos 
  values('Bayaspirina',null,2.10,null,'2019-12-01',null); 
  insert into medicamentos 
  values('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null); 
-- nota: lafuncion count no toma en cuenta los campos con valores null
 select count(*)
  from medicamentos;

 select count(laboratorio)
   from medicamentos;

 select count(precio) as 'Con precio',
  count(cantidad) as 'Con cantidad'
  from medicamentos;

 select count(precio)
  from medicamentos
  where laboratorio like 'B%';

 select count(numerolote) from medicamentos;

 ----------------------------------------------------------------------------------
 --Funciones de agrupamiento (count - sum - min - max - avg)
 /*Una empresa almacena los datos de sus empleados en una tabla "empleados".
1- Elimine la tabla, si existe:*/
 if object_id('empleados') is not null
  drop table empleados;

/*2- Cree la tabla:*/
 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2),
  cantidadhijos tinyint,
  primary key(documento)
 );

/*3- Ingrese algunos registros:*/
 insert into empleados
  values('Juan Perez','22333444','Colon 123','Gerencia',5000,2);
 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0);
 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1);
 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3);
 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0);
 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','Administracion',3200,1);
 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3);
 insert into empleados
  values('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4);
 insert into empleados
  values('Andres Costa','28444555',default,'Secretaria',null,null);

select * from empleados

/*4- Muestre la cantidad de empleados usando "count" (9 empleados)*/

select count(*) from empleados

/*5- Muestre la cantidad de empleados con sueldo no nulo de la sección "Secretaria" (2 empleados)*/

select count(sueldo)from empleados where seccion='secretaria'

/*6- Muestre el sueldo más alto y el más bajo colocando un alias (5000 y 2000)*/

select max(sueldo) as 'sueldo maximo', min(sueldo) as 'sueldo minimo' from empleados

/*7- Muestre el valor mayor de "cantidadhijos" de los empleados "Perez" (3 hijos)*/

select max(cantidadhijos) from empleados where nombre like '%perez%'	

/*8- Muestre el promedio de sueldos de todo los empleados (3400. Note que hay un sueldo nulo y no es 
tenido en cuenta)*/

select avg(sueldo) from empleados

/*9- Muestre el promedio de sueldos de los empleados de la sección "Secretaría" (2100)*/

select avg(sueldo) from empleados where seccion='secretaria'

/*10- Muestre el promedio de hijos de todos los empleados de "Sistemas" (2)*/

select avg(cantidadhijos)from empleados where seccion='sistemas'

-----------------------------------------------------------------------------------------------
--Agrupar registros (group by) + (count - sum - min - max - avg)


/*Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos.
1- Elimine la tabla "visitantes", si existe:*/
 if object_id('visitantes') is not null
  drop table visitantes;

/*2- Cree la tabla con la siguiente estructura:*/
 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1) default 'f',
  domicilio varchar(30),
  ciudad varchar(20) default 'Cordoba',
  telefono varchar(11),
  mail varchar(30) default 'no tiene',
  montocompra decimal (6,2)
 );

/*3- Ingrese algunos registros:*/
 insert into visitantes
  values ('Susana Molina',35,default,'Colon 123',default,null,null,59.80);
 insert into visitantes
  values ('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50);
 insert into visitantes
  values ('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);
 insert into visitantes (nombre, edad,sexo,telefono, mail)
  values ('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');
 insert into visitantes (nombre, ciudad, montocompra)
  values ('Alejandra Gonzalez','La Falda',280.50);
 insert into visitantes (nombre, edad,sexo, ciudad, mail,montocompra)
  values ('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);
 insert into visitantes
  values ('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85);
 insert into visitantes
  values ('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

  select * from visitantes

/*4- Queremos saber la cantidad de visitantes de cada ciudad utilizando la cláusula "group by" (4 filas devueltas)*/

select ciudad, count(*)
from visitantes
group by ciudad
 
/*5- Queremos la cantidad visitantes con teléfono no nulo, de cada ciudad (4 filas devueltas)*/
  select * from visitantes

  select ciudad, count(telefono) as 'con telefono' 
  from visitantes
  group by ciudad


/*6- Necesitamos el total del monto de las compras agrupadas por sexo (3 filas)*/
  select * from visitantes

  select sexo, sum(montocompra) as'Total de la compra'
  from visitantes
  group by sexo

/*7- Se necesita saber el máximo y mínimo valor de compra agrupados por sexo y ciudad (6 filas)*/

  select * from visitantes

  select sexo, ciudad, max(montocompra)as 'compra mas alta', min(montocompra)as 'compra mas baja'
  from visitantes
  group by sexo, ciudad

/*8- Calcule el promedio del valor de compra agrupados por ciudad (4 filas)*/

  select * from visitantes

  select ciudad, avg(montocompra) as 'Promedio de Compra'
  from visitantes
  group by ciudad

/*9- Cuente y agrupe por ciudad sin tener en cuenta los visitantes que no tienen mail (3 filas):*/

  select * from visitantes

  select ciudad, count(mail) as 'con mail'
  from visitantes
  where mail<> 'no tiene'
  group by ciudad

/*10- Realice la misma consulta anterior, pero use la palabra clave "all" para mostrar todos los 
valores de ciudad, incluyendo las que devuelven cero o "null" en la columna de agregado (4 filas)*/



   select ciudad, count(mail) as 'con mail'
  from visitantes
  where mail<> 'no tiene'
  group by all ciudad