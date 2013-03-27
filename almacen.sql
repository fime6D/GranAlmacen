SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `almacen` ;
CREATE SCHEMA IF NOT EXISTS `almacen` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `almacen` ;

-- -----------------------------------------------------
-- Table `almacen`.`entradas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`entradas` (
  `id_entradas` INT NOT NULL ,
  `folio` INT NOT NULL ,
  `concepto` VARCHAR(45) NOT NULL ,
  `fecha` DATETIME NULL ,
  `proveedor` VARCHAR(45) NOT NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`id_entradas`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `almacen`.`destinos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`destinos` (
  `id_destinos` INT NOT NULL AUTO_INCREMENT ,
  `departamento` VARCHAR(45) NOT NULL ,
  `activar` TINYINT(1) NULL ,
  PRIMARY KEY (`id_destinos`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `almacen`.`salidas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`salidas` (
  `id_salidas` INT NOT NULL AUTO_INCREMENT ,
  `folio` INT NOT NULL ,
  `concepto` VARCHAR(45) NOT NULL ,
  `fecha` DATETIME NULL ,
  `departamento` VARCHAR(45) NOT NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  `destinos_id_destinos` INT NOT NULL ,
  PRIMARY KEY (`id_salidas`) ,
  CONSTRAINT `fk_salidas_destinos1`
    FOREIGN KEY (`destinos_id_destinos` )
    REFERENCES `almacen`.`destinos` (`id_destinos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_salidas_destinos1_idx` ON `almacen`.`salidas` (`destinos_id_destinos` ASC) ;


-- -----------------------------------------------------
-- Table `almacen`.`conceptos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`conceptos` (
  `concepto` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  `entradas_id_entradas` INT NOT NULL ,
  `salidas_id_salidas` INT NOT NULL ,
  CONSTRAINT `fk_conceptos_entradas`
    FOREIGN KEY (`entradas_id_entradas` )
    REFERENCES `almacen`.`entradas` (`id_entradas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conceptos_salidas1`
    FOREIGN KEY (`salidas_id_salidas` )
    REFERENCES `almacen`.`salidas` (`id_salidas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_conceptos_entradas_idx` ON `almacen`.`conceptos` (`entradas_id_entradas` ASC) ;

CREATE INDEX `fk_conceptos_salidas1_idx` ON `almacen`.`conceptos` (`salidas_id_salidas` ASC) ;


-- -----------------------------------------------------
-- Table `almacen`.`proveedores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`proveedores` (
  `id_proveedores` INT NOT NULL AUTO_INCREMENT ,
  `proveedor` VARCHAR(45) NOT NULL ,
  `direccion` VARCHAR(45) NULL ,
  `telefono` VARCHAR(45) NULL ,
  `email` VARCHAR(45) NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`id_proveedores`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_proveedores_UNIQUE` ON `almacen`.`proveedores` (`id_proveedores` ASC) ;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `almacen`.`proveedores` (`proveedor` ASC) ;


-- -----------------------------------------------------
-- Table `almacen`.`productos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`productos` (
  `id_productos` INT NOT NULL ,
  `clave` VARCHAR(45) NULL ,
  `nombre` VARCHAR(45) NULL ,
  `precio` FLOAT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `medida` VARCHAR(45) NULL ,
  `cantidad` INT NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`id_productos`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `almacen`.`orden_entrada`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`orden_entrada` (
  `id_orden_entradacol` INT NOT NULL AUTO_INCREMENT ,
  `folio` INT NOT NULL ,
  `clave` VARCHAR(45) NULL ,
  `producto` VARCHAR(45) NULL ,
  `medida` VARCHAR(45) NULL ,
  `precio` FLOAT NULL ,
  `cantidad` INT NULL ,
  `existencias` INT NULL ,
  `sub_total` FLOAT NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`id_orden_entradacol`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `almacen`.`orden_salida`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`orden_salida` (
  `id_orden_salidacol` INT NOT NULL AUTO_INCREMENT ,
  `folio` INT NOT NULL ,
  `clave` VARCHAR(45) NULL ,
  `producto` VARCHAR(45) NULL ,
  `medida` VARCHAR(45) NULL ,
  `precio` FLOAT NULL ,
  `cantidad` INT NULL ,
  `existencias` INT NULL ,
  `sub_total` FLOAT NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`id_orden_salidacol`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `almacen`.`medidas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`medidas` (
  `id_medidas` INT NOT NULL AUTO_INCREMENT ,
  `medida` VARCHAR(45) NULL ,
  `activar` TINYINT(1) NULL DEFAULT 1 ,
  `productos_id_productos` INT NOT NULL ,
  `orden_entrada_id_orden_entradacol` INT NOT NULL ,
  `orden_salida_id_orden_salidacol` INT NOT NULL ,
  PRIMARY KEY (`id_medidas`) ,
  CONSTRAINT `fk_medidas_productos1`
    FOREIGN KEY (`productos_id_productos` )
    REFERENCES `almacen`.`productos` (`id_productos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medidas_orden_entrada1`
    FOREIGN KEY (`orden_entrada_id_orden_entradacol` )
    REFERENCES `almacen`.`orden_entrada` (`id_orden_entradacol` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medidas_orden_salida1`
    FOREIGN KEY (`orden_salida_id_orden_salidacol` )
    REFERENCES `almacen`.`orden_salida` (`id_orden_salidacol` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_medidas_productos1_idx` ON `almacen`.`medidas` (`productos_id_productos` ASC) ;

CREATE INDEX `fk_medidas_orden_entrada1_idx` ON `almacen`.`medidas` (`orden_entrada_id_orden_entradacol` ASC) ;

CREATE INDEX `fk_medidas_orden_salida1_idx` ON `almacen`.`medidas` (`orden_salida_id_orden_salidacol` ASC) ;


-- -----------------------------------------------------
-- Table `almacen`.`movimientos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `almacen`.`movimientos` (
  `clave` INT NOT NULL ,
  `fecha` DATETIME NULL ,
  `entrada` INT NULL ,
  `salida` INT NULL ,
  `precio` FLOAT NULL ,
  `existencia` INT NULL ,
  `total` FLOAT NULL )
ENGINE = InnoDB;

USE `almacen` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
