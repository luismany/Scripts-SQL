/*Combinaciones y funciones de agrupamiento
Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos y 
en otra tabla llamada "ciudades" los nombres de las ciudades.
1- Elimine las tablas si existen:*/
 if object_id('visitantes') is not null
  drop table visitantes;
 if object_id('ciudades') is not null
  drop table ciudades;

--2- Cree las tablas:
 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1) default 'f',
  domicilio varchar(30),
  codigociudad tinyint not null,
  mail varchar(30),
  montocompra decimal (6,2)
 );

 create table ciudades(
  codigo tinyint identity,
  nombre varchar(20)
 );
 
--3- Ingrese algunos registros:
 insert into ciudades values('Cordoba');
 insert into ciudades values('Carlos Paz');
 insert into ciudades values('La Falda');
 insert into ciudades values('Cruz del Eje');

 insert into visitantes values 
   ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
 insert into visitantes values 
   ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
 insert into visitantes values 
   ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
 insert into visitantes values 
   ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
 insert into visitantes values 
   ('Alejandra Garcia',28,'f',null,2,null,280.50);
 insert into visitantes values 
   ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
 insert into visitantes values 
   ('Mariana Juarez',33,'f',null,2,null,90);

   select * from ciudades
   select * from visitantes
--4- Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad (3 filas)

	select c.nombre as ciudad, 
	count(*) as 'cantida de visitas'
	from ciudades as c
	join visitantes as v
	on codigociudad= c.codigo
	group by c.nombre

--5- Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo (4 filas)
   select * from ciudades
   select * from visitantes

	select c.nombre as ciudad, v.sexo,
	avg(v.montocompra) as promedio from ciudades as c
	join visitantes as v
	on codigociudad=c.codigo
	group by c.nombre, v.sexo  

--6- Muestre la cantidad de visitantes con mail, agrupados por ciudad (3 filas)
	select * from ciudades
   select * from visitantes

	select c.nombre,
  count(mail) as 'tienen mail'
  from ciudades as c
  join visitantes as v
  on codigociudad=c.codigo
  group by c.nombre;

	

--7- Obtenga el monto de compra más alto de cada ciudad (3 filas)

select * from ciudades
select * from visitantes

select c.nombre as ciudad, max(v.montocompra) as 'Monto maximo de compra' from ciudades as c
join visitantes as v
on codigociudad=c.codigo
group by c.nombre
-------------------------------------------------------------------------------------------------
--combinaciones de mas de 2 tablas
/*Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de los 
socios, en una tabla llamada "deportes" la información referente a los diferentes deportes que se 
dictan y en una tabla denominada "inscriptos", las inscripciones de los socios a los distintos 
deportes.
Un socio puede inscribirse en varios deportes el mismo año. Un socio no puede inscribirse en el 
mismo deporte el mismo año. Distintos socios se inscriben en un mismo deporte en el mismo año.
1- Elimine las tablas si existen:*/
 if object_id('socios') is not null
  drop table socios;
 if object_id('deportes') is not null
  drop table deportes;
 if object_id('inscriptos') is not null
  drop table inscriptos;

--2- Cree las tablas con las siguientes estructuras:
 create table socios(
  documento char(8) not null, 
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento)
 );
 create table deportes(
  codigo tinyint identity,
  nombre varchar(20),
  profesor varchar(15),
  primary key(codigo)
 );
 create table inscriptos(
  documento char(8) not null, 
  codigodeporte tinyint not null,
  anio char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,anio)
 );

--3- Ingrese algunos registros en "socios":
 insert into socios values('22222222','Ana Acosta','Avellaneda 111');
 insert into socios values('23333333','Betina Bustos','Bulnes 222');
 insert into socios values('24444444','Carlos Castro','Caseros 333');
 insert into socios values('25555555','Daniel Duarte','Dinamarca 44');
--4- Ingrese algunos registros en "deportes":
 insert into deportes values('basquet','Juan Juarez');
 insert into deportes values('futbol','Pedro Perez');
 insert into deportes values('natacion','Marina Morales');
 insert into deportes values('tenis','Marina Morales');

--5- Inscriba a varios socios en el mismo deporte en el mismo año:
 insert into inscriptos values ('22222222',3,'2006','s');
 insert into inscriptos values ('23333333',3,'2006','s');
 insert into inscriptos values ('24444444',3,'2006','n');

--6- Inscriba a un mismo socio en el mismo deporte en distintos años:
 insert into inscriptos values ('22222222',3,'2005','s');
 insert into inscriptos values ('22222222',3,'2007','n');

--7- Inscriba a un mismo socio en distintos deportes el mismo año:
 insert into inscriptos values ('24444444',1,'2006','s');
 insert into inscriptos values ('24444444',2,'2006','s');

/*8- Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no 
exista en "socios":*/
 insert into inscriptos values ('26666666',0,'2006','s');

/*9- Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
diferentes tipos de join.*/

select s.nombre,d.nombre,anio
  from deportes as d
  right join inscriptos as i
  on codigodeporte=d.codigo
  left join socios as s
  on i.documento=s.documento;

/*10- Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
inscripciones cuyo código de deporte no existe en "deportes" y cuyo documento de socio no se 
encuentra en "socios".*/

select s.nombre,d.nombre,anio,matricula
  from deportes as d
  full join inscriptos as i
  on codigodeporte=d.codigo
  full join socios as s
  on s.documento=i.documento;

--11- Muestre todas las inscripciones del socio con documento "22222222".

select s.nombre,d.nombre,anio,matricula
  from deportes as d
  join inscriptos as i
  on codigodeporte=d.codigo
  join socios as s
  on s.documento=i.documento
  where s.documento='22222222';
