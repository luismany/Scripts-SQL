--subconsultas

if object_id('detalles') is not null
  drop table detalles;
if object_id('facturas') is not null
  drop table facturas;

create table facturas(
  numero int not null,
  fecha datetime,
  cliente varchar(30),
  primary key(numero)
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
-- Seteamos el formato de la fecha: año, mes y día:
set dateformat ymd;

insert into facturas values(1200,'2018-01-15','Juan Lopez');
insert into facturas values(1201,'2018-01-15','Luis Torres');
insert into facturas values(1202,'2018-01-15','Ana Garcia');
insert into facturas values(1300,'2018-01-20','Juan Lopez');

insert into detalles values(1200,1,'lapiz',1,100);
insert into detalles values(1200,2,'goma',0.5,150);
insert into detalles values(1201,1,'regla',1.5,80);
insert into detalles values(1201,2,'goma',0.5,200);
insert into detalles values(1201,3,'cuaderno',4,90);
insert into detalles values(1202,1,'lapiz',1,200);
insert into detalles values(1202,2,'escuadra',2,100);
insert into detalles values(1300,1,'lapiz',1,300);

--  Listado de todas las facturas que incluya el número, la fecha, 
-- el cliente, la cantidad de artículos comprados y el total:
select f.*,
  (select count(d.numeroitem)
    from detalles as d
    where f.numero=d.numerofactura) as cantidad,
  (select sum(d.precio*cantidad)
    from detalles as d
    where f.numero=d.numerofactura) as total
 from facturas as f;

 -------------------------------------------------------------------------------
/* Un club dicta clases de distintos deportes a sus socios. El club tiene una tabla llamada 
"inscriptos" en la cual almacena el número de "socio", el código del deporte en el cual se inscribe 
y la cantidad de cuotas pagas (desde 0 hasta 10 que es el total por todo el año), y una tabla 
denominada "socios" en la que guarda los datos personales de cada socio.
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
  cuotas tinyint
  constraint CK_inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10)
  constraint DF_inscriptos_cuotas default 0,
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
   on update cascade
   on delete cascade,
 );

--3- Ingrese algunos registros:
 insert into socios values('23333333','Alberto Paredes','Colon 111');
 insert into socios values('24444444','Carlos Conte','Sarmiento 755');
 insert into socios values('25555555','Fabian Fuentes','Caseros 987');
 insert into socios values('26666666','Hector Lopez','Sucre 344');

 insert into inscriptos values(1,'tenis',1);
 insert into inscriptos values(1,'basquet',2);
 insert into inscriptos values(1,'natacion',1);
 insert into inscriptos values(2,'tenis',9);
 insert into inscriptos values(2,'natacion',1);
 insert into inscriptos values(2,'basquet',default);
 insert into inscriptos values(2,'futbol',2);
 insert into inscriptos values(3,'tenis',8);
 insert into inscriptos values(3,'basquet',9);
 insert into inscriptos values(3,'natacion',0);
 insert into inscriptos values(4,'basquet',10);

/*4- Se necesita un listado de todos los socios que incluya nombre y domicilio, la cantidad de 
deportes a los cuales se ha inscripto, empleando subconsulta.
4 registros.*/
select * from socios
select * from inscriptos

select s.nombre, s.domicilio,
(select count(i.numerosocio) 
from inscriptos as i 
where s.numero=i.numerosocio)as 'deportes inscritos'
from socios as s
/*5- Se necesita el nombre de todos los socios, el total de cuotas que debe pagar (10 por cada 
deporte) y el total de cuotas pagas, empleando subconsulta.
4 registros.*/
select * from socios
select * from inscriptos

select s.nombre,
(select count(cuotas)*10 from inscriptos as i
where s.numero= i.numerosocio) as 'Total a pagar',
(select sum(cuotas) from inscriptos as i
where s.numero=i.numerosocio )as 'cuotas pagadas'
from socios as s

--6- Obtenga la misma salida anterior empleando join.
select s.nombre,
count(i.cuotas)*10 as 'Total a pagar', sum(i.cuotas)as 'Cuotas Pagadas' from socios as s
join inscriptos as i
on s.numero=i.numerosocio
group by s.nombre
-------------------------------------------------------------------
--Subconsulta - Exists y Not Exists

/*Un club dicta clases de distintos deportes a sus socios. El club tiene una tabla llamada 
"inscriptos" en la cual almacena el número de "socio", el código del deporte en el cual se inscribe 
y la cantidad de cuotas pagas (desde 0 hasta 10 que es el total por todo el año), y una tabla 
denominada "socios" en la que guarda los datos personales de cada socio.
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
  cuotas tinyint
  constraint CK_inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10)
  constraint DF_inscriptos_cuotas default 0,
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
   on update cascade
   on delete cascade,
 );

--3- Ingrese algunos registros:
 insert into socios values('23333333','Alberto Paredes','Colon 111');
 insert into socios values('24444444','Carlos Conte','Sarmiento 755');
 insert into socios values('25555555','Fabian Fuentes','Caseros 987');
 insert into socios values('26666666','Hector Lopez','Sucre 344');

 insert into inscriptos values(1,'tenis',1);
 insert into inscriptos values(1,'basquet',2);
 insert into inscriptos values(1,'natacion',1);
 insert into inscriptos values(2,'tenis',9);
 insert into inscriptos values(2,'natacion',1);
 insert into inscriptos values(2,'basquet',default);
 insert into inscriptos values(2,'futbol',2);
 insert into inscriptos values(3,'tenis',8);
 insert into inscriptos values(3,'basquet',9);
 insert into inscriptos values(3,'natacion',0);
 insert into inscriptos values(4,'basquet',10);

/*4- Emplee una subconsulta con el operador "exists" para devolver la lista de socios que se 
inscribieron en un determinado deporte.
3 registros.*/
select * from socios
select * from inscriptos

select * from socios as s
where exists
(select * from inscriptos as i
where s.numero=i.numerosocio
and i.deporte='natacion')


/*5- Busque los socios que NO se han inscripto en un deporte determinado empleando "not exists".
1 registro.*/
select * from socios as s
where not exists
(select * from inscriptos as i
where s.numero= i.numerosocio
and i.deporte='natacion')

/*6- Muestre todos los datos de los socios que han pagado todas las cuotas.
1 registro.*/
select * from socios
select * from inscriptos
select *from socios as s
where exists
(select * from inscriptos as i
where s.numero=i.numerosocio
and i.cuotas>=10)