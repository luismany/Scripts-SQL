if object_id('medicamentos') is not null
  drop table medicamentos;


 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
 );

 insert into medicamentos
  values('Sertal','Roche',5.2,100);
 insert into medicamentos
  values('Buscapina','Roche',4.10,200);
 insert into medicamentos
  values('Amoxidal 500','Bayer',15.60,100);
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,200);
 insert into medicamentos
  values('Bayaspirina','Bayer',2.10,150); 
 insert into medicamentos
  values('Amoxidal jarabe','Bayer',5.10,250); 


  select * from medicamentos
  --uso de operadores and/or/not
  select * from medicamentos
  where (laboratorio='bayer') and (precio<=5)

  select * from medicamentos 
  where (laboratorio='roche')or(precio>5)

  select * from medicamentos
  where not laboratorio='bayer'

  select codigo,nombre from medicamentos
  where(laboratorio='roche')and(precio<5)

    select * from medicamentos
  where(laboratorio='roche') or (precio<5)

  select * from medicamentos
  where not(laboratorio='bayer') and (cantidad=100)
  
  select * from medicamentos
  where (laboratorio='bayer') and not (cantidad=100)

  delete from medicamentos
  where (laboratorio='bayer') and (precio>10)

  update medicamentos set cantidad=200 
  where (laboratorio='roche')and(precio>5)

  delete from medicamentos
  where (laboratorio='bayer') or (precio<3)
---------------------------------------------------------------------------------------------------------------

if object_id('visitas') is not null
  drop table visitas;

 create table visitas (
  numero int identity,
  nombre varchar(30) default 'Anonimo',
  mail varchar(50),
  pais varchar (20),
  fechayhora datetime,
  primary key(numero)
);

 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Gustavo Gonzalez','GustavoGGonzalez@gotmail.com','Chile','2006-10-10 21:30');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Juancito','JuanJosePerez@gmail.com','Argentina','2006-09-12 16:20');
 insert into visitas (nombre,mail,pais,fechayhora)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');
 insert into visitas (nombre,mail,pais)
  values ('Federico1','federicogarcia@xaxamail.com','Argentina');

 select * from visitas
  where fechayhora between '2006-09-12' and '2006-10-11';

 select * from visitas
  where numero between 2 and 5;

  --------------------------------------------------------------------------------------------

  /*Trabaje con la tabla llamada "medicamentos" de una farmacia.
1- Elimine la tabla, si existe:*/
 if object_id('medicamentos') is not null
  drop table medicamentos;

/*2- Cree la tabla con la siguiente estructura:*/
 create table medicamentos(
  codigo int identity,
  nombre varchar(20),
  laboratorio varchar(20),
  precio decimal(6,2),
  cantidad tinyint,
  fechavencimiento datetime not null,
  primary key(codigo)
 );

/*3- Ingrese algunos registros:*/
 insert into medicamentos
  values('Sertal','Roche',5.2,1,'2015-02-01');
 insert into medicamentos 
  values('Buscapina','Roche',4.10,3,'2016-03-01');
 insert into medicamentos 
  values('Amoxidal 500','Bayer',15.60,100,'2017-05-01');
 insert into medicamentos
  values('Paracetamol 500','Bago',1.90,20,'2018-02-01');
 insert into medicamentos 
  values('Bayaspirina','Bayer',2.10,150,'2019-12-01'); 
 insert into medicamentos 
  values('Amoxidal jarabe','Bayer',5.10,250,'2020-10-01'); 

/*4- Recupere los nombres y precios de los medicamentos cuyo laboratorio sea "Bayer" o "Bago" 
empleando el operador "in" (4 registros)*/

select * from medicamentos

select nombre,precio, laboratorio from medicamentos where laboratorio in('bayer','bago')

/*5- Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 empleando el operador "between" y 
luego el operador "in" (2 registros):

Note que es más conveniente emplear, en este caso, el operador ""between".*/


select * from medicamentos where cantidad between 1 and 5 

select * from medicamentos where cantidad in (1,2,3,4,5);

-------------------------------------------------------------------------------------------
-- uso de like y not like
if object_id('empleados') is not null
  drop table empleados;

 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  fechaingreso datetime,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
 );

 insert into empleados
  values('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50);
 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30);
 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790);
 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550);
 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70);
 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400);
 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

 select * from empleados
  where nombre like '%Perez%';

 select * from empleados
  where domicilio like 'Co%8%';

 select * from empleados
  where documento like '%[02468]';

 select * from empleados
  where documento like '[^13]%' and
  nombre like '%ez';

 select nombre from empleados
  where nombre like '%[yj]%';

 select nombre,seccion from empleados
  where seccion like '[SG]_______';

 select nombre,seccion from empleados
  where seccion not like '[SG]%';

 select nombre,sueldo from empleados
  where sueldo not like '%.00';

 select * from empleados
  where fechaingreso like '%1990%';