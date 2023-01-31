--Subconsultas como expresión
/*Un profesor almacena el documento, nombre y la nota final de cada alumno de su clase en una tabla 
llamada "alumnos".
1- Elimine la tabla, si existe:*/
 if object_id('alumnos') is not null
  drop table alumnos;

/*2- Créela con los campos necesarios. Agregue una restricción "primary key" para el campo "documento" 
y una "check" para validar que el campo "nota" se encuentre entre los valores 0 y 10:*/
 create table alumnos(
  documento char(8),
  nombre varchar(30),
  nota decimal(4,2),
  primary key(documento),
  constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10),
 );

--3-Ingrese algunos registros:
 insert into alumnos values('30111111','Ana Algarbe',5.1);
 insert into alumnos values('30222222','Bernardo Bustamante',3.2);
 insert into alumnos values('30333333','Carolina Conte',4.5);
 insert into alumnos values('30444444','Diana Dominguez',9.7);
 insert into alumnos values('30555555','Fabian Fuentes',8.5);
 insert into alumnos values('30666666','Gaston Gonzalez',9.70);

/*4- Obtenga todos los datos de los alumnos con la nota más alta, empleando subconsulta.
2 registros.*/
select * from alumnos
where nota=
(select max(nota) as 'nota mas alta' from alumnos)

/*5- Realice la misma consulta anterior pero intente que la consulta interna retorne, además del 
máximo valor de nota, el nombre. 
Mensaje de error, porque la lista de selección de una subconsulta que va luego de un operador de 
comparación puede incluir sólo un campo o expresión (excepto si se emplea "exists" o "in").*/

/*6- Muestre los alumnos que tienen una nota menor al promedio, su nota, y la diferencia con el 
promedio.
3 registros.*/
select nombre, nota ,
(select avg(nota) from alumnos)- nota as diferencia  from alumnos
where nota <
(select avg(nota) from alumnos) 


/*7- Cambie la nota del alumno que tiene la menor nota por 4.
1 registro modificado.*/
update alumnos set nota=4 
where nota =
(select min(nota)from alumnos)

/*8- Elimine los alumnos cuya nota es menor al promedio.
3 registros eliminados.*/
delete from alumnos
where nota<
(select AVG(nota) from alumnos)
--------------------------------------------------------------------------------------
--Subconsultas con in
/*Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"ciudades" donde registra los nombres de las ciudades.
1- Elimine las tablas "clientes" y "ciudades", si existen:*/
  if (object_id('ciudades')) is not null
   drop table ciudades;
  if (object_id('clientes')) is not null
   drop table clientes;

/*2- Cree la tabla "clientes" (codigo, nombre, domicilio, ciudad, codigociudad) y "ciudades" (codigo, 
nombre). Agregue una restricción "primary key" para el campo "codigo" de ambas tablas y una "foreing 
key" para validar que el campo "codigociudad" exista en "ciudades" con actualización en cascada:*/
 create table ciudades(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  codigociudad tinyint not null,
  primary key(codigo),
  constraint FK_clientes_ciudad
   foreign key (codigociudad)
   references ciudades(codigo)
   on update cascade,
 );

--3- Ingrese algunos registros para ambas tablas:

 insert into ciudades (nombre) values('Cordoba');
 insert into ciudades (nombre) values('Cruz del Eje');
 insert into ciudades (nombre) values('Carlos Paz');
 insert into ciudades (nombre) values('La Falda');
 insert into ciudades (nombre) values('Villa Maria');

 insert into clientes values ('Lopez Marcos','Colon 111',1);
 insert into clientes values ('Lopez Hector','San Martin 222',1);
 insert into clientes values ('Perez Ana','San Martin 333',2);
 insert into clientes values ('Garcia Juan','Rivadavia 444',3);
 insert into clientes values ('Perez Luis','Sarmiento 555',3);
 insert into clientes values ('Gomez Ines','San Martin 666',4);
 insert into clientes values ('Torres Fabiola','Alem 777',5);
 insert into clientes values ('Garcia Luis','Sucre 888',5);

/*4- Necesitamos conocer los nombres de las ciudades de aquellos clientes cuyo domicilio es en calle 
"San Martin", empleando subconsulta.
3 registros.*/
select * from clientes
select * from ciudades	
select nombre from  ciudades
where codigo in
(select codigociudad from clientes where domicilio like 'San Martin%' )

--5- Obtenga la misma salida anterior pero empleando join.
select c.nombre from ciudades as c
join clientes as cli
on codigociudad=c.codigo
where cli.domicilio like 'san martin%'

/*6- Obtenga los nombre de las ciudades de los clientes cuyo apellido no comienza con una letra 
específica, empleando subconsulta.
2 registros.*/

select nombre
  from ciudades
  where codigo not in
   (select codigociudad
     from clientes
     where nombre like 'G%');

/*7- Pruebe la subconsulta del punto 6 separada de la consulta exterior para verificar que retorna una 
lista de valores de un solo campo.*/
select codigociudad
  from clientes
  where nombre like 'G%';