--desasociar y eliminar reglas
 if object_id('vehiculos') is not null
  drop table vehiculos;

 if object_id ('RG_patente_patron') is not null
   drop rule RG_patente_patron;
 if object_id ('RG_vehiculos_tipo') is not null
   drop rule RG_vehiculos_tipo;
 if object_id ('RG_vehiculos_tipo2') is not null
   drop rule RG_vehiculos_tipo2;

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );

 create rule RG_patente_patron
 as @patente like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';

 exec sp_bindrule RG_patente_patron,'vehiculos.patente';

 insert into vehiculos values ('FGHIJK','a','1990-02-01 18:00',null);

 create rule RG_vehiculos_tipo
 as @tipo in ('a','m');

 exec sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';

 insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);

 create rule RG_vehiculos_tipo2
 as @tipo in ('a','c','m');

 exec sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';

 insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);

 drop rule RG_vehiculos_tipo2;

 drop rule RG_vehiculos_tipo;

 drop rule RG_patente_patron;

 exec sp_unbindrule 'vehiculos.patente';

 exec sp_helpconstraint vehiculos;

 exec sp_help;

 drop rule RG_patente_patron;

 exec sp_help;

 ------------------------------------------------------------------------------

