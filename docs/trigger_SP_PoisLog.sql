drop TRIGGER checkearBanco;
DELIMITER //
CREATE TRIGGER checkearBanco
BEFORE UPDATE
   ON banco FOR EACH ROW
BEGIN
 call loguearCambio(old.descripcion, new.descripcion, 'banco', NEW.id);
END; //
DELIMITER ;

drop TRIGGER checkearCGP;
DELIMITER //
CREATE TRIGGER checkearCGP
BEFORE UPDATE
   ON cgp FOR EACH ROW
BEGIN
 call loguearCambio(old.descripcion, new.descripcion, 'cgp', NEW.id);
END; //
DELIMITER ;

drop TRIGGER checkearLocal;
DELIMITER //
CREATE TRIGGER checkearLocal
BEFORE UPDATE
   ON `local` FOR EACH ROW
BEGIN
 call loguearCambio(old.descripcion, new.descripcion, 'local', NEW.id);
END; //
DELIMITER ;

drop TRIGGER checkearColectivo;
DELIMITER //
CREATE TRIGGER checkearColectivo
BEFORE UPDATE
   ON colectivo FOR EACH ROW
BEGIN
 call loguearCambio(old.descripcion, new.descripcion, 'colectivo', NEW.id);
END; //
DELIMITER ;

drop TRIGGER checkearOpinion;
DELIMITER //
CREATE TRIGGER checkearOpinion
before INSERT
   ON opinion FOR EACH ROW
BEGIN
	if not(new.calificacion <= 5 and new.calificacion >= 1) then
		signal sqlstate '45000' set message_text = 'La calificacion debe ser en el rango del 1 al 5';
    end if;
END; //
DELIMITER ;

drop procedure loguearCambio;
DELIMITER //
CREATE PROCEDURE loguearCambio
(IN anterior longtext,
IN actual longtext,
IN tabla varchar(50),
IN poiId bigint(20))
BEGIN
	if(anterior <> actual) then
		insert into PoisLog (TableName,
			IdPoi,
			DescAnterior, 
			DescActual, 
			FechaHoraDeCambio)
		values(tabla, poiId, anterior, actual, now());
	end if;
END //
DELIMITER ;

drop table poislog;
create table PoisLog(
	Id bigint auto_increment not null primary key,
    TableName varchar(50) not null,
    IdPoi bigint(20) not null,
    DescAnterior longtext,
    DescActual longtext,
    FechaHoraDeCambio datetime
)ENGINE=InnoDB;
