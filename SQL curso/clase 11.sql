--uso de join
if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table libros(
  Id int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  editorialId tinyint not null,
  precio decimal(5,2)
);

create table editoriales(
  Id tinyint identity,
  nombre varchar(20),
  primary key (Id)
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',2,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Java en 10 minutos',default,3,45);

select * from libros

select * from editoriales

-- Realizamos un join para obtener datos de ambas tablas 
-- (titulo, autor y nombre de la editorial):
select titulo, autor, nombre from libros
join editoriales
on editorialId= editoriales.Id

 -- Mostramos el código del libro, título, autor, nombre de la
 -- editorial y el precio realizando un join y empleando alias:
 select l.Id, titulo, autor, nombre, precio from libros as l
 join editoriales as e
 on editorialId= e.Id

 -- Realizamos la misma consulta anterior agregando un "where" 
-- para obtener solamente los libros de la editorial "Siglo XXI":
select l.Id, titulo, autor, nombre, precio from libros as l
join editoriales as e
on editorialId=e.Id
where e.nombre='siglo XXI'

-- Obtenemos título, autor y nombre de la editorial, 
-- esta vez ordenados por título:
select l.titulo, autor, nombre from libros as l
join editoriales as e
on editorialId=e.Id
order by l.titulo

-------------------------------------------------------------------------------------------------------
/*Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"provincias" donde registra los nombres de las provincias.
1- Elimine las tablas "clientes" y "provincias", si existen:*/
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

--2- Créelas con las siguientes estructuras:
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

--3- Ingrese algunos registros para ambas tablas:
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','Ibera',3);

 select * from provincias

 select * from clientes
--4- Obtenga los datos de ambas tablas, usando alias:
select c.nombre, domicilio, ciudad, p.nombre as 'nombre provincia'  from clientes as c
join provincias as p
on codigoprovincia=p.codigo


--5- Obtenga la misma información anterior pero ordenada por nombre de provincia.
select c.nombre, domicilio, ciudad, p.nombre from clientes as c
join provincias as p
on codigoprovincia=p.codigo
order by p.codigo

--6- Recupere los clientes de la provincia "Santa Fe" (2 registros devueltos)

select c.nombre, domicilio, ciudad, p.nombre from clientes as c
join provincias as p
on codigoprovincia=p.codigo
where p.nombre='santa fe'

---------------------------------------------------------------------------------------

/*Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada 
"inscriptos" que incluye el documento, el nombre, el deporte y si la matricula esta paga o no y una 
tabla llamada "inasistencias" que incluye el documento, el deporte y la fecha de la inasistencia.
1- Elimine las tablas si existen y cree las tablas:*/
 if (object_id('inscriptos')) is not null
  drop table inscriptos;
 if (object_id('inasistencias')) is not null
  drop table inasistencias;

 create table inscriptos(
  nombre varchar(30),
  documento char(8),
  deporte varchar(15),
  matricula char(1), --'s'=paga 'n'=impaga
  primary key(documento,deporte)
 );

 create table inasistencias(
  documento char(8),
  deporte varchar(15),
  fecha datetime
 );

--2- Ingrese algunos registros para ambas tablas:
 insert into inscriptos values('Juan Perez','22222222','tenis','s');
 insert into inscriptos values('Maria Lopez','23333333','tenis','s');
 insert into inscriptos values('Agustin Juarez','24444444','tenis','n');
 insert into inscriptos values('Marta Garcia','25555555','natacion','s');
 insert into inscriptos values('Juan Perez','22222222','natacion','s');
 insert into inscriptos values('Maria Lopez','23333333','natacion','n');

 insert into inasistencias values('22222222','tenis','2006-12-01');
 insert into inasistencias values('22222222','tenis','2006-12-08');
 insert into inasistencias values('23333333','tenis','2006-12-01');
 insert into inasistencias values('24444444','tenis','2006-12-08');
 insert into inasistencias values('22222222','natacion','2006-12-02');
 insert into inasistencias values('23333333','natacion','2006-12-02');

 select * from inscriptos

 select * from inasistencias
/*3- Muestre el nombre, el deporte y las fechas de inasistencias, ordenado por nombre y deporte.
Note que la condición es compuesta porque para identificar los registros de la tabla "inasistencias" 
necesitamos ambos campos.*/

 select nombre,insc.deporte,ina.fecha
  from inscriptos as insc
  join inasistencias as ina
  on insc.documento=ina.documento and
  insc.deporte=ina.deporte
  order by nombre, insc.deporte;

/*4- Obtenga el nombre, deporte y las fechas de inasistencias de un determinado inscripto en un 
determinado deporte (3 registros)*/

select nombre,insc.deporte, ina.fecha
  from inscriptos as insc
  join inasistencias as ina
  on insc.documento=ina.documento and
  insc.deporte=ina.deporte
  where insc.documento='22222222';

/*5- Obtenga el nombre, deporte y las fechas de inasistencias de todos los inscriptos que pagaron la 
matrícula(4 registros)*/

select nombre,insc.deporte, ina.fecha
  from inscriptos as insc
  join inasistencias as ina
  on insc.documento=ina.documento and
  insc.deporte=ina.deporte
  where insc.matricula='s';