-- TRIGGER PARA CUANDO SE INGRESAN NUEVAS CATEGORIAS DE USUARIOS FUNCIONA

USE isosceles;
DROP TABLE IF EXISTS isosceles.add_nuevas_categorias_usuario;
CREATE TABLE IF NOT EXISTS add_nuevas_categorias_usuario (id_tr_add_usus INT NOT NULL AUTO_INCREMENT PRIMARY KEY
,	categoria VARCHAR (100)
,   usuario VARCHAR(100)
,   fecha_hora TIMESTAMP
);

DROP TRIGGER IF EXISTS `tr_add_nuevas_categorias_usuario`;
CREATE TRIGGER `tr_add_nuevas_categorias_usuario`
AFTER INSERT ON `tipo_usuario`
FOR EACH ROW
INSERT INTO `add_nuevas_categorias_usuario` (categoria,usuario,fecha_hora)
VALUES ((SELECT categoria FROM tipo_usuario ORDER BY categoria DESC LIMIT 1),SESSION_USER(), CURRENT_TIMESTAMP()); 



-- TRIGGER PARA GUARDAR LAS MIDIFICACIONES DE LAS CONTRASEÑAS DE LOS USUARIOS FUNCIONA

 USE isosceles;
 DROP TABLE IF EXISTS isosceles.modify_contra_nomb_usuario;
 CREATE TABLE isosceles.modify_contra_nomb_usuario (id_modify_pass_nomb_uesr INT NOT NULL AUTO_INCREMENT PRIMARY KEY
,	id_usuario INT
,	nomb_completo VARCHAR (100)
,	viejo_usuario  VARCHAR (100) DEFAULT 'Sin cambios'
,	nuevo_usuario VARCHAR (100)  DEFAULT 'Sin cambios'
,	vieja_contra  VARCHAR (100)  DEFAULT 'Sin cambios'
,	nueva_contra VARCHAR (100)   DEFAULT 'Sin cambios'
,	fecha	DATETIME
 );

DROP TRIGGER IF EXISTS `tr_modify_contra_usuario`;
CREATE TRIGGER `tr_modify_contra_usuario`
AFTER UPDATE ON `usuario`
FOR EACH ROW
INSERT INTO `modify_contra_nomb_usuario` (id_usuario,nomb_completo,vieja_contra,nueva_contra,fecha)
	VALUES ((SELECT id_usuario FROM usuario WHERE id_usuario = @v_id_usuario),
			(SELECT nombre_completo(id_usuario) FROM usuario WHERE id_usuario = @v_id_usuario),
			(SELECT OLD.contrasena FROM usuario WHERE id_usuario = @v_id_usuario),
			(SELECT NEW.contrasena FROM usuario WHERE id_usuario = @v_id_usuario),NOW());
	-- @v_id_usuario traido desde store procedure `modifica_contrasena_usuario`



-- TRIGGER PARA GUARDAR LAS MIDIFICACIONES DE LOS CAMBIOS DE NOMBRE SE USUARIO
 
DROP TRIGGER IF EXISTS `tr_modify_nombre_usuario`;
CREATE TRIGGER `tr_modify_nombre_usuario`
BEFORE UPDATE ON `usuario`
FOR EACH ROW
INSERT INTO `modify_contra_nomb_usuario` (id_usuario,nomb_completo,viejo_usuario,nuevo_usuario,fecha)
VALUES ((SELECT id_usuario FROM usuario WHERE id_usuario = @var_id_usuario),
		(SELECT nombre_completo(id_usuario) FROM usuario WHERE id_usuario = @var_id_usuario),
		(SELECT OLD.usuario FROM usuario WHERE id_usuario = @var_id_usuario),
        (SELECT NEW.usuario FROM usuario WHERE id_usuario = @var_id_usuario),NOW());
	 

-- TRIGGER PARA ALMACER LOS INGRESOS DE NUEVOS USUARIOS

USE isosceles;
DROP TABLE IF EXISTS isosceles.add_nuevos_usuario;
CREATE TABLE IF NOT EXISTS add_nuevos_usuario (id_tr_add_nuevos_usus INT NOT NULL AUTO_INCREMENT PRIMARY KEY
,	id_usuario INT
,   usuario VARCHAR(100)
,	nombre VARCHAR (100)
,	apellido VARCHAR (100)
,   fecha_hora TIMESTAMP
);

DROP TRIGGER IF EXISTS `tr_add_nuevos_usuario`;
CREATE TRIGGER `tr_add_nuevos_usuario`
AFTER INSERT ON `usuario`
FOR EACH ROW
INSERT INTO `add_nuevos_usuario` (id_usuario,usuario,nombre,apellido,fecha_hora)
VALUES ((SELECT id_usuario FROM usuario ORDER BY id_usuario DESC LIMIT 1),(SELECT usuario FROM usuario ORDER BY id_usuario DESC LIMIT 1),
		(SELECT nombre FROM usuario ORDER BY id_usuario DESC LIMIT 1),(SELECT apellido FROM usuario ORDER BY id_usuario DESC LIMIT 1),
        NOW()); 



-- TRIGGER PARA REGISTRAR LOS INGRESOS DE NUEVOS USUARIOS

USE isosceles;
DROP TABLE IF EXISTS isosceles.add_nuevos_usuario;
CREATE TABLE IF NOT EXISTS add_nuevos_usuario (id_tr_add_nuevos_usus INT NOT NULL AUTO_INCREMENT PRIMARY KEY
,	id_usuario INT
,   usuario VARCHAR(100)
,	nombre VARCHAR (100)
,	apellido VARCHAR (100)
,   fecha_hora TIMESTAMP
);

DROP TRIGGER IF EXISTS `tr_add_nuevos_usuario`;
CREATE TRIGGER `tr_add_nuevos_usuario`
AFTER INSERT ON `usuario`
FOR EACH ROW
INSERT INTO `add_nuevos_usuario` (id_usuario,usuario,nombre,apellido,fecha_hora)
VALUES ((SELECT id_usuario FROM usuario ORDER BY id_usuario DESC LIMIT 1),(SELECT usuario FROM usuario ORDER BY id_usuario DESC LIMIT 1),
		(SELECT nombre FROM usuario ORDER BY id_usuario DESC LIMIT 1),(SELECT apellido FROM usuario ORDER BY id_usuario DESC LIMIT 1),
        NOW()); 


-- VISTA PARA REPORTE DE NUEVOS USUARIOS VER EL TEMA DE PODER HACERLO POR MES//AÑO O CUKQUIER OTRA COSA
CREATE OR REPLACE VIEW reporte_nuevos_usuarios AS
(SELECT COUNT(id_tr_add_nuevos_usus) AS Nuevos_usuarios FROM add_nuevos_usuario  
);





































