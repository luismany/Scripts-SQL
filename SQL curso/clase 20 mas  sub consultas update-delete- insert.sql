--Subconsulta en lugar de una tabla
if object_id('detalles') is not null
  drop table detalles;
if object_id('facturas') is not null
  drop table facturas;
if object_id('clientes') is not null
  drop table clientes;

create table clientes(
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(codigo)
);

create table facturas(
  numero int not null,
  fecha datetime,
  codigocliente int not null,
  primary key(numero),
  constraint FK_facturas_cliente
   foreign key (codigocliente)
   references clientes(codigo)
   on update cascade
);

create table detalles(
  numerofactura int not null,
  numeroitem int not null, 
  articulo varchar(30),
  precio decimal(5,2),
  cantidad int,
  primary key(numerofactura,numeroitem),
   constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on update cascade
   on delete cascade,
);

go

insert into clientes values('Juan Lopez','Colon 123');
insert into clientes values('Luis Torres','Sucre 987');
insert into clientes values('Ana Garcia','Sarmiento 576');

set dateformat ymd;

insert into facturas values(1200,'2018-01-15',1);
insert into facturas values(1201,'2018-01-15',2);
insert into facturas values(1202,'2018-01-15',3);
insert into facturas values(1300,'2018-01-20',1);

insert into detalles values(1200,1,'lapiz',1,100);
insert into detalles values(1200,2,'goma',0.5,150);
insert into detalles values(1201,1,'regla',1.5,80);
insert into detalles values(1201,2,'goma',0.5,200);
insert into detalles values(1201,3,'cuaderno',4,90);
insert into detalles values(1202,1,'lapiz',1,200);
insert into detalles values(1202,2,'escuadra',2,100);
insert into detalles values(1300,1,'lapiz',1,300);

select * from facturas
select * from clientes
select *from detalles
-- Recuperar el número de factura, el código de cliente, 
-- la fecha y la suma total de todas las facturas:
 select f.*,
  (select sum(d.precio*cantidad)
    from detalles as d
    where f.numero=d.numerofactura) as total
 from facturas as f;

-- Ahora utilizaremos el resultado de la consulta anterior como una tabla 
-- derivada que emplearemos en lugar de una tabla para realizar un "join" 
-- y recuperar el número de factura, el nombre del cliente y
-- el monto total por factura:
 select td.numero,c.nombre,td.total
  from clientes as c
  join (select f.*,
   (select sum(d.precio*cantidad)
    from detalles as d
    where f.numero=d.numerofactura) as total
  from facturas as f) as td
  on td.codigocliente=c.codigo;
  --------------------------------------------------------------------------------
 /* Un club dicta clases de distintos deportes. En una tabla llamada "socios" guarda los datos de los 
socios, en una tabla llamada "deportes" la información referente a los diferentes deportes que se 
dictan y en una tabla denominada "inscriptos", las inscripciones de los socios a los distintos 
deportes.
Un socio puede inscribirse en varios deportes el mismo año. Un socio no puede inscribirse en el 
mismo deporte el mismo año. Distintos socios se inscriben en un mismo deporte en el mismo año.

1- Elimine las tablas si existen:*/
 if object_id('inscriptos') is not null
  drop table inscriptos;
 if object_id('socios') is not null
  drop table socios;
 if object_id('deportes') is not null
  drop table deportes;

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
  año char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,año),
  constraint FK_inscriptos_socio
   foreign key (documento)
   references socios(documento)
   on update cascade
   on delete cascade
 );

--3- Ingrese algunos registros en las 3 tablas:
 insert into socios values('22222222','Ana Acosta','Avellaneda 111');
 insert into socios values('23333333','Betina Bustos','Bulnes 222');
 insert into socios values('24444444','Carlos Castro','Caseros 333');
 insert into socios values('25555555','Daniel Duarte','Dinamarca 44');

 insert into deportes values('basquet','Juan Juarez');
 insert into deportes values('futbol','Pedro Perez');
 insert into deportes values('natacion','Marina Morales');
 insert into deportes values('tenis','Marina Morales');

 insert into inscriptos values ('22222222',3,'2006','s');
 insert into inscriptos values ('23333333',3,'2006','s');
 insert into inscriptos values ('24444444',3,'2006','n');
 insert into inscriptos values ('22222222',3,'2005','s');
 insert into inscriptos values ('22222222',3,'2007','n');
 insert into inscriptos values ('24444444',1,'2006','s');
 insert into inscriptos values ('24444444',2,'2006','s');

 select * from socios
 select *from deportes
 select *from inscriptos

/*4- Realice una consulta en la cual muestre todos los datos de las inscripciones, incluyendo el 
nombre del deporte y del profesor.
Esta consulta es un join.*/

select i.documento, d.nombre as deporte, d.profesor,i.matricula, i.año from inscriptos as i
join deportes as d
on d.codigo=i.codigodeporte


/*5- Utilice el resultado de la consulta anterior como una tabla derivada para emplear en lugar de una 
tabla para realizar un "join" y recuperar el nombre del socio, el deporte en el cual está inscripto, 
el año, el nombre del profesor y la matrícula.*/
 select * from socios
 select *from deportes
 select *from inscriptos

select s.nombre, td.deporte, td.año, td.profesor,td.matricula from socios as s
join(
select i.documento, d.nombre as deporte, d.profesor,i.matricula, i.año from inscriptos as i
join deportes as d
on d.codigo=i.codigodeporte) as td
on s.documento=td.documento
--------------------------------------------------------------------------
--Subconsulta (update - delete)

/*Un club dicta clases de distintos deportes a sus socios. El club tiene una tabla llamada 
"inscriptos" en la cual almacena el número de "socio", el código del deporte en el cual se inscribe 
y si la matricula está o no paga, y una tabla denominada "socios" en la que guarda los datos 
personales de cada socio.
1- Elimine las tablas si existen:*/
 if object_id('inscriptos') is not null
  drop table inscriptos;
 if object_id('socios') is not null
  drop table socios;

--2- Cree las tablas:
 create table socios(
  numero int identity,
  documento char(8),
  nombre varchar(30),
  domicilio varchar(30),
  primary key (numero)
 );
 
 create table inscriptos (
  numerosocio int not null,
  deporte varchar(20) not null,
  matricula char(1),-- 'n' o 's'
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
 );

--3- Ingrese algunos registros:
 insert into socios values('23333333','Alberto Paredes','Colon 111');
 insert into socios values('24444444','Carlos Conte','Sarmiento 755');
 insert into socios values('25555555','Fabian Fuentes','Caseros 987');
 insert into socios values('26666666','Hector Lopez','Sucre 344');

 insert into inscriptos values(1,'tenis','s');
 insert into inscriptos values(1,'basquet','s');
 insert into inscriptos values(1,'natacion','s');
 insert into inscriptos values(2,'tenis','s');
 insert into inscriptos values(2,'natacion','s');
 insert into inscriptos values(2,'basquet','n');
 insert into inscriptos values(2,'futbol','n');
 insert into inscriptos values(3,'tenis','s');
 insert into inscriptos values(3,'basquet','s');
 insert into inscriptos values(3,'natacion','n');
 insert into inscriptos values(4,'basquet','n');

/*4- Actualizamos la cuota ('s') de todas las inscripciones de un socio determinado (por documento) 
empleando subconsulta.*/
select *  from socios
select * from inscriptos
update inscriptos set matricula='s' 
where numerosocio =
(select numero from socios
where nombre='Carlos Conte'
)
select *  from socios
select * from inscriptos

--5- Elimine todas las inscripciones de los socios que deben alguna matrícula (5 registros eliminados)
select *  from socios
select * from inscriptos

delete from inscriptos
where numerosocio in
(select s.numero from socios as s
 join inscriptos as i
 on s.numero= i.numerosocio
 where i.matricula= 'n')

 select *  from socios
select * from inscriptos
-------------------------------------------------------------------------------------
 --Subconsulta (insert)
 /*Un comercio que vende artículos de librería y papelería almacena la información de sus ventas en una 
tabla llamada "facturas" y otra "clientes".
1- Elimine las tablas si existen:*/
 if object_id('factura') is not null
  drop table factura;
 if object_id('clientes') is not null
  drop table clientes;

--2-Créelas:
 create table clientes(
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(codigo)
 );

 create table factura(
  numero int not null,
  fecha datetime,
  codigocliente int not null,
  total decimal(6,2),
  primary key(numero),
  constraint FK_factura_cliente
   foreign key (codigocliente)
   references clientes(codigo)
   on update cascade
 );

--3-Ingrese algunos registros:
 insert into clientes values('Juan Lopez','Colon 123');
 insert into clientes values('Luis Torres','Sucre 987');
 insert into clientes values('Ana Garcia','Sarmiento 576');
 insert into clientes values('Susana Molina','San Martin 555');

 set dateformat ymd;

 insert into factura values(1200,'2007-01-15',1,300);
 insert into factura values(1201,'2007-01-15',2,550);
 insert into factura values(1202,'2007-01-15',3,150);
 insert into factura values(1300,'2007-01-20',1,350);
 insert into factura values(1310,'2007-01-22',3,100);

/*4- El comercio necesita una tabla llamada "clientespref" en la cual quiere almacenar el nombre y 
domicilio de aquellos clientes que han comprado hasta el momento más de 500 pesos en mercaderías. 
Elimine la tabla si existe y créela con esos 2 campos:*/
 if object_id ('clientespref') is not null
  drop table clientespref;
 create table clientespref(
  nombre varchar(30),
  domicilio varchar(30) );

/*5- Ingrese los registros en la tabla "clientespref" seleccionando registros de la tabla "clientes" y 
"facturas".*/
select * from clientes
select *from factura
select * from clientespref

insert into clientespref(nombre, domicilio)
(select nombre, domicilio from clientes as c
 join factura as f
 on f.codigocliente=c.codigo
 where f.total >500)  

--6- Vea los registros de "clientespref":
 select * from clientespref;

