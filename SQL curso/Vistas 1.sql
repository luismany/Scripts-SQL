--vistas

if object_id('empleados') is not null
  drop table empleados;
if object_id('secciones') is not null
  drop table secciones;

create table secciones(
  codigo tinyint identity,
  nombre varchar(20),
  sueldo decimal(5,2)
   constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo int identity,
  documento char(8)
   constraint CK_empleados_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion tinyint not null,
  cantidadhijos tinyint
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso datetime,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on update cascade,
  constraint UQ_empleados_documento
   unique(documento)
);

go

insert into secciones values('Administracion',300);
insert into secciones values('Contaduría',400);
insert into secciones values('Sistemas',500);

insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
insert into empleados values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
insert into empleados values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');

-- Eliminamos la vista "vista_empleados" si existe:
if object_id('vista_empleados') is not null
  drop view vista_empleados;


select * from secciones
select * from empleados
go

-- Creamos la vista "vista_empleados", que es resultado de una combinación 
-- en la cual se muestran 5 campos:

create view vista_empleados as
  select (apellido+' '+e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados as e
   join secciones as s
   on codigo=seccion;

   go
-- Vemos la información de la vista:
select * from vista_empleados;

-- Realizamos una consulta a la vista como si se tratara de una tabla:
select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;

  ----------------------------------------------------------------------------

  /*Un club dicta cursos de distintos deportes. Almacena la información en varias tablas.
El director no quiere que los empleados de administración conozcan la estructura de las tablas ni 
algunos datos de los profesores y socios, por ello se crean vistas a las cuales tendrán acceso.
1- Elimine las tablas y créelas nuevamente:*/
 if object_id('inscriptos') is not null  
  drop table inscriptos;
 if object_id('socios') is not null  
  drop table socios;
 if object_id('profesores') is not null  
  drop table profesores; 
 if object_id('cursos') is not null  
  drop table cursos;

 create table socios(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  constraint PK_socios_documento
   primary key (documento)
 );

 create table profesores(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  constraint PK_profesores_documento
   primary key (documento)
 );

 create table cursos(
  numero tinyint identity,
  deporte varchar(20),
  dia varchar(15),
   constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  documentoprofesor char(8),
  constraint PK_cursos_numero
   primary key (numero),
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero tinyint not null,
  matricula char(1),
  constraint CK_inscriptos_matricula check (matricula in('s','n')),
  constraint PK_inscriptos_documento_numero
   primary key (documentosocio,numero)
 );

--2- Ingrese algunos registros para todas las tablas:
 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into profesores values('23333333','Carlos Caseres','Colon 245');
 insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into profesores values('25555555','Esteban Lopez','Sucre 1204');

 insert into cursos values('tenis','lunes','22222222');
 insert into cursos values('tenis','martes','22222222');
 insert into cursos values('natacion','miercoles','22222222');
 insert into cursos values('natacion','jueves','23333333');
 insert into cursos values('natacion','viernes','23333333');
 insert into cursos values('futbol','sabado','24444444');
 insert into cursos values('futbol','lunes','24444444');
 insert into cursos values('basquet','martes','24444444');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',8,'s');

--3- Elimine la vista "vista_club" si existe:
 if object_id('vista_club') is not null drop view vista_club;

/*4- Cree una vista en la que aparezca el nombre y documento del socio, el deporte, el día y el nombre 
del profesor.*/
select * from socios
select * from profesores
select * from cursos
select *from inscriptos


go
create view vista_club as
select s.nombre, s.documento, c.deporte,c.dia, p.nombre as profesor,i.matricula from socios as s
full join inscriptos as i
on s.documento=i.documentosocio
full join cursos as c
on c.numero= i.numero
full join profesores as p
on p.documento=c.documentoprofesor

go
--5- Muestre la información contenida en la vista.

select * from vista_club

/*6- Realice una consulta a la vista donde muestre la cantidad de socios inscriptos en cada deporte 
ordenados por cantidad.*/
select deporte, count(*) as cantidad from vista_club
where deporte is not null
group by deporte
order by cantidad

--7- Muestre (consultando la vista) los cursos (deporte y día) para los cuales no hay inscriptos.

select * from vista_club

select deporte, dia from vista_club
where nombre is null and deporte is not null

--8- Muestre los nombres de los socios que no se han inscripto en ningún curso (consultando la vista)
select nombre from vista_club
where deporte is null and nombre is not null

--9- Muestre (consultando la vista) los profesores que no tienen asignado ningún deporte aún.
select profesor from vista_club
where deporte is null and profesor is not null

--10- Muestre (consultando la vista) el nombre y documento de los socios que deben matrículas.

select nombre, documento from vista_club
where matricula='n' and matricula is not null

/*11- Consulte la vista y muestre los nombres de los profesores y los días en que asisten al club para 
dictar sus clases.*/

select distinct profesor,dia from vista_club
where dia is not null

--12- Muestre la misma información anterior pero ordenada por día.
select distinct profesor,dia from vista_club
where dia is not null
order by dia

--13- Muestre todos los socios que son compañeros en tenis los lunes.
select * from vista_club
select nombre as socios from vista_club
where deporte= 'tenis' and dia = 'lunes'

/*14- Elimine la vista "vista_inscriptos" si existe y créela para que muestre la cantidad de 
inscriptos por curso, incluyendo el número del curso, el nombre del deporte y el día.*/
 if object_id('vista_inscriptos') is not null drop view vista_inscriptos;
 select * from socios
select * from profesores
select * from cursos
select *from inscriptos

go
 create view vista_inscriptos as
 select c.numero,count(*) as cantidad,c.deporte,c.dia from cursos as c
 full join inscriptos as i
 on i.numero=c.numero
 group by c.numero,c.deporte,c.dia
 go
--15- Consulte la vista:

 select *from vista_inscriptos;
