--Union
--1- Elimine las tablas si existen:
 if object_id('clientes') is not null
  drop table clientes;
 if object_id('proveedores') is not null
  drop table proveedores;
 if object_id('empleados') is not null
  drop table empleados;

--2- Cree las tablas:
 create table proveedores(
  codigo int identity,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(codigo)
 );
 create table clientes(
  codigo int identity,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(codigo)
 );
 create table empleados(
  documento char(8) not null,
  nombre varchar(20),
  apellido varchar(20),
  domicilio varchar(30),
  primary key(documento)
 );

--3- Ingrese algunos registros:
 insert into proveedores values('Bebida cola','Colon 123');
 insert into proveedores values('Carnes Unica','Caseros 222');
 insert into proveedores values('Lacteos Blanca','San Martin 987');
 insert into clientes values('Supermercado Lopez','Avellaneda 34');
 insert into clientes values('Almacen Anita','Colon 987');
 insert into clientes values('Garcia Juan','Sucre 345');
 insert into empleados values('23333333','Federico','Lopez','Colon 987');
 insert into empleados values('28888888','Ana','Marquez','Sucre 333');
 insert into empleados values('30111111','Luis','Perez','Caseros 956');

 select * from proveedores
 select * from clientes
 select * from  empleados

/*4- El supermercado quiere enviar una tarjeta de salutación a todos los proveedores, clientes y 
empleados y necesita el nombre y domicilio de todos ellos. Emplee el operador "union" para obtener 
dicha información de las tres tablas.*/

select nombre, domicilio from proveedores
union
select nombre, domicilio from clientes
union
select nombre, domicilio from empleados


/*5- Agregue una columna con un literal para indicar si es un proveedor, un cliente o un empleado y 
ordene por dicha columna.*/
select nombre, domicilio, 'proveedor' as Categoria from proveedores
union
select nombre,domicilio, 'cliente' from clientes
union
select nombre, domicilio, 'empleado' from  empleados
order by Categoria
------------------------------------------------------------------------------------------------------

 --Agregar y eliminar campos ( alter table - add - drop)

 --1- Elimine la tabla, si existe, créela y cargue un registro:
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados(
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  fechaingreso datetime
 );
 insert into empleados(apellido,nombre) values ('Rodriguez','Pablo');

--2- Agregue el campo "sueldo", de tipo decimal(5,2).

alter table empleados
add sueldo decimal(5,2)

--3- Verifique que la estructura de la tabla ha cambiado.

--4- Agregue un campo "codigo", de tipo int con el atributo "identity".

alter table empleados
add codigo int identity

/*5- Intente agregar un campo "documento" no nulo.
No es posible, porque SQL Server no permite agregar campos "not null" a menos que se especifique un 
valor por defecto.*/


--6- Agregue el campo del punto anterior especificando un valor por defecto:
 alter table empleados
  add documento char(8) not null default '00000000';

--7- Verifique que la estructura de la tabla ha cambiado.

--8- Elimine el campo "sueldo".
alter table empleados
drop column sueldo

--9- Verifique la eliminación:
 exec sp_columns empleados;

/*10- Intente eliminar el campo "documento".
no lo permite.*/

--11- Elimine los campos "codigo" y "fechaingreso" en una sola sentencia.
alter table empleados
drop column codigo, fechaingreso

--12- Verifique la eliminación de los campos:
 exec sp_columns empleados;
 ----------------------------------------------------------------------------------------------
 -- Alterar campos (alter table - alter)
 --1- Elimine la tabla, si existe y créela:
 if object_id('empleados') is not null
  drop table empleados;

 create table empleados(
  legajo int not null,
  documento char(7) not null,
  nombre varchar(10),
  domicilio varchar(30),
  ciudad varchar(20) default 'Buenos Aires',
  sueldo decimal(6,2),
  cantidadhijos tinyint default 0,
  primary key(legajo)
 );

--2- Modifique el campo "nombre" extendiendo su longitud.
alter table empleados
alter column nombre varchar(50)

--3- Controle la modificación:
 sp_columns empleados;

--4- Modifique el campo "sueldo" para que no admita valores nulos.
alter table empleados
alter column sueldo decimal(6,2) not null

--4- Modifique el campo "documento" ampliando su longitud a 8 caracteres.
alter table empleados
alter column documento char(8)

--5- Intente modificar el tipo de datos del campo "legajo" a "tinyint":
 alter table empleados
  alter column legajo tinyint not null;
--No se puede porque tiene una restricción.

--6- Ingrese algunos registros, uno con "nombre" nulo:
 insert into empleados values(1,'22222222','Juan Perez','Colon 123','Cordoba',500,3);
 insert into empleados values(2,'30000000',null,'Sucre 456','Cordoba',600,2);

--7- Intente modificar el campo "nombre" para que no acepte valores nulos:
 alter table empleados
  alter column nombre varchar(30) not null;
--No se puede porque hay registros con ese valor.

--8- Elimine el registro con "nombre" nulo y realice la modificación del punto 7:
 delete from empleados where nombre is null;
 alter table empleados
  alter column nombre varchar(30) not null;

--9- Modifique el campo "ciudad" a 10 caracteres.
alter table empleados
alter column ciudad varchar(10)

--10- Intente agregar un registro con el valor por defecto para "ciudad":
 insert into empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);
--No se puede porque el campo acepta 10 caracteres y  el valor por defecto tiene 12 caracteres.

--11- Modifique el campo "ciudad" sin que afecte la restricción dándole una longitud de 15 caracteres.
alter table empleados
alter column ciudad varchar(15)

--12- Agregue el registro que no pudo ingresar en el punto 10:
 insert into empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

--13- Intente agregar el atributo identity de "legajo".
--No se puede agregar este atributo.
