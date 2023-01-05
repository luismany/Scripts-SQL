exec sp_columns libro

--columna calculada con alias
select Titulo,Precio,Cantidad , (Precio*Cantidad)as Total from  Libro 

---concatenacion de 2 columnas cson asliass
select titulo+autor as Descripcion from libro

--ordey by por cantidad 
select * from Libro order by Cantidad 
--lo mismo pero referenciamos por la posicion de la columna
select * from Libro order by 6

/*en esta consulta selecciona las columnas titulo, autor y editorial y calcula una nueva columna
con la columna precio, luego  la ordena segun ala posicion de la columna calculada
que en este caso se llama precio con descuento yesta en la posicion de columna 4  */
select titulo,autor,editorial, precio-(precio*0.1) as 'precio con descuento' from Libro
order by 4

-----------------------------------------------------------------------------------------------------

if object_id('visitas') is not null
  drop table visitas;

 create table visitas (
  numero int identity,
  nombre varchar(30) default 'Anonimo',
  mail varchar(50),
  pais varchar (20),
  fecha datetime,
  primary key(numero)
);

 insert into visitas (nombre,mail,pais,fecha)
  values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20');
 insert into visitas (nombre,mail,pais,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:25');
 /*muestra todos los registros de la tabla visitas y los ordena de forma descendente
  por fecha*/
 select * from visitas
  order by fecha desc;

  /*selecciona el nombre, pais, y calcula el mes dela columna fechha 
  de la tabla visitas y los ordena de manera descendente por feecha*/
 select nombre,pais,datename(month,fecha) as Mes
  from visitas
  order by pais,datename(month,fecha) desc;

  /*selecciona nombre y mail y utiliza la funcion datename para sacar el 
  mes, sia, hora y año de la columna fecha de la tabla visitas y las ordena 
  por las columnas calculadas*/
 select nombre,mail,
  datename(month,fecha) mes,
  datename(day,fecha) dia,
  datename(hour,fecha) hora,
  datename(year, fecha)Anio
  from visitas
  order by 3,4,5,6;

  /*selecciona el mail y pais de la tabla visitas mientras la fecha sea igual a octubre*/

 select mail, pais
  from visitas
  where datename(month,fecha)='Octubre'
  order by 2;


  select * from visitas

  select nombre, pais,fecha from visitas
  where datename(day, fecha)= 09

  select nombre, pais,fecha from visitas
  where datename(year, fecha)= 2006
