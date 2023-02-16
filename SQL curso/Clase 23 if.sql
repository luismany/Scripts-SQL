-- Lenguaje de control de flujo (ifif object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint,
  primary key (codigo)
);

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('El aleph','Borges','Emece',20,150);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',50,200);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,0);
insert into libros values('Java en 10 minutos','Mario Molina','Emece',40,200);

select * from libros

-- Mostramos los títulos de los cuales no hay libros disponibles (cantidad=0); 
-- en caso que no haya, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
  (select titulo from libros where cantidad=0)
else
  select 'No hay libros sin stock';

-- Hacemos un descuento del 10% a todos los libros de editorial "Emece";
-- si no hay, mostramos un mensaje:
if exists (select * from libros where editorial='Emece')
begin
  update libros set precio=precio-(precio*0.1) where editorial='Emece'
  select 'libros actualizados'
end
else
  select 'no hay registros actualizados';

-- Veamos si se actualizaron:
select * from libros where editorial='Emece';

-- Eliminamos los libros de los cuales no hay stock (cantidad=0); 
-- si no hay, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
  delete from libros where cantidad=0
else
  select 'No hay registros eliminados';

-- Ejecutamos nuevamente la sentencia anterior (Ahora se ejecuta la sentencia
-- del "else" porque no hay registros que cumplieran la condición.):
if exists (select * from libros where cantidad=0)
  delete from libros where cantidad=0
 else
  select 'No hay registros eliminados';

select titulo,costo=iif(precio<38,'barato','caro') from libros;
-----------------------------------------------------------------------

--Una empresa registra los datos de sus empleados en una tabla llamada "empleados".
--1- Elimine la tabla "empleados" si existe:
 if object_id('empleados') is not null
  drop table empleados;

--2- Cree la tabla:
 create table empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  sexo char(1),
  fechanacimiento datetime,
  sueldo decimal(5,2),
  primary key(documento)
);

set dateformat ymd;

--3- Ingrese algunos registros:
 insert into empleados values ('22333111','Juan Perez','m','1970-05-10',550);
 insert into empleados values ('25444444','Susana Morales','f','1975-11-06',650);
 insert into empleados values ('20111222','Hector Pereyra','m','1995-03-25',510);
 insert into empleados values ('30000222','Luis LUque','m','1980-03-29',700);
 insert into empleados values ('20555444','Laura Torres','f','1965-12-22',400);
 insert into empleados values ('30000234','Alberto Soto','m','1989-10-10',420);
 insert into empleados values ('20125478','Ana Gomez','f','1976-09-21',350);
 insert into empleados values ('24154269','Ofelia Garcia','f','1974-05-12',390);
 insert into empleados values ('30415426','Oscar Torres','m','1978-05-02',400);

 select * from empleados

/*4- Es política de la empresa festejar cada fin de mes, los cumpleaños de todos los empleados que 
cumplen ese mes. Si los empleados son de sexo femenino, se les regala un ramo de rosas, si son de 
sexo masculino, una corbata. La secretaria de la Gerencia necesita saber cuántos ramos de rosas y 
cuántas corbatas debe comprar para el mes de mayo.*/

if exists (select * from empleados where DATEPART(MONTH, fechanacimiento)=5) 
begin

	select sexo ,count(*) as cantidad from empleados where  DATEPART(MONTH,fechanacimiento)=5
	group by sexo
	
end
else
select 'no hay cumpleañeros en el mes de mayo'
-----------------------------------------------------------------------------------------------------

/*Un teatro con varias salas guarda la información de las entradas vendidas en una tabla llamada 
"entradas".
1- Elimine la tabla, si existe:*/
 if object_id('entradas') is not null
  drop table entradas;

--2- Cree la tabla:
 create table entradas(
  sala tinyint,
  fechahora datetime,
  capacidad smallint,
  entradasvendidas smallint,
  primary key(sala,fechahora)
 );

--3- Ingrese algunos registros:
 insert into entradas values(1,'2006-05-10 20:00',300,50);
 insert into entradas values(1,'2006-05-10 23:00',300,250);
 insert into entradas values(2,'2006-05-10 20:00',400,350);
 insert into entradas values(2,'2006-05-11 20:00',400,380);
 insert into entradas values(2,'2006-05-11 23:00',400,400);
 insert into entradas values(3,'2006-05-12 20:00',350,350);
 insert into entradas values(3,'2006-05-12 22:30',350,100);
 insert into entradas values(4,'2006-05-12 20:00',250,0);

 select * from entradas

/*4- Muestre, si existen, todas las funciones para la cuales hay entradas disponibles, sino un mensaje 
que indique que están agotadas.*/

if exists (select * from entradas where capacidad > entradasvendidas)
begin
	select sala,fechahora,capacidad-entradasvendidas as'entradas disponibles' from entradas where capacidad>entradasvendidas 
end
else select 'todas las entradas estan agotadas'
