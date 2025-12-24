-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_optica` ;

-- -----------------------------------------------------
-- Schema db_optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_optica` DEFAULT CHARACTER SET utf8 ;
USE `db_optica` ;

-- -----------------------------------------------------
-- Table `db_optica`.`Adreca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Adreca` (
  `id_Adreca` INT NOT NULL,
  `carrer` VARCHAR(90) NOT NULL,
  `numero` VARCHAR(4) NOT NULL,
  `pis` VARCHAR(10) NULL,
  `porta` VARCHAR(10) NULL,
  `ciutat` VARCHAR(60) NOT NULL,
  `CP` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Adreca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_optica`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Proveidor` (
  `id_Proveidor` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(9) NOT NULL,
  `fax` VARCHAR(9) NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_adreca` INT NOT NULL,
  PRIMARY KEY (`id_Proveidor`),
  CONSTRAINT `fk_Proveidor_Adreca`
    FOREIGN KEY (`id_adreca`)
    REFERENCES `db_optica`.`Adreca` (`id_Adreca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `NIE_UNIQUE` ON `db_optica`.`Proveidor` (`NIF` ASC);

CREATE INDEX `fk_Proveidor_Adreca_idx` ON `db_optica`.`Proveidor` (`id_adreca` ASC);


-- -----------------------------------------------------
-- Table `db_optica`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Ulleres` (
  `id_Ulleres` INT NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `grad_vidre_dreta` VARCHAR(5) NOT NULL,
  `grad_vidre_esquerra` VARCHAR(5) NOT NULL,
  `muntura_tipus` ENUM('Flotant', 'Pasta', 'Metalica') NOT NULL,
  `muntura_color` VARCHAR(40) NOT NULL,
  `color_vidre_dreta` VARCHAR(45) NOT NULL,
  `color_vidre_esquerra` VARCHAR(45) NOT NULL,
  `preu` FLOAT NOT NULL,
  `id_Proveidor` INT NOT NULL,
  PRIMARY KEY (`id_Ulleres`),
  CONSTRAINT `fk_Ulleres_Proveidor1`
    FOREIGN KEY (`id_Proveidor`)
    REFERENCES `db_optica`.`Proveidor` (`id_Proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Ulleres_Proveidor1_idx` ON `db_optica`.`Ulleres` (`id_Proveidor` ASC);


-- -----------------------------------------------------
-- Table `db_optica`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Client` (
  `id_Client` INT NOT NULL,
  `nom` VARCHAR(40) NOT NULL,
  `telefon` VARCHAR(9) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `id_Adreca` INT NOT NULL,
  `id_Client_recomanador` INT NULL,
  PRIMARY KEY (`id_Client`),
  CONSTRAINT `fk_Client_Adreca1`
    FOREIGN KEY (`id_Adreca`)
    REFERENCES `db_optica`.`Adreca` (`id_Adreca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Client1`
    FOREIGN KEY (`id_Client_recomanador`)
    REFERENCES `db_optica`.`Client` (`id_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Client_Adreca1_idx` ON `db_optica`.`Client` (`id_Adreca` ASC) ;

CREATE INDEX `fk_Client_Client1_idx` ON `db_optica`.`Client` (`id_Client_recomanador` ASC) ;


-- -----------------------------------------------------
-- Table `db_optica`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Empleat` (
  `id_Empleat` INT NOT NULL,
  PRIMARY KEY (`id_Empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_optica`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_optica`.`Venda` (
  `id_Venda` INT NOT NULL,
  `data_venda` DATE NOT NULL,
  `id_Empleat` INT NOT NULL,
  `id_Client` INT NOT NULL,
  `id_Ulleres` INT NOT NULL,
  PRIMARY KEY (`id_Venda`),
  CONSTRAINT `fk_Venda_Empleat1`
    FOREIGN KEY (`id_Empleat`)
    REFERENCES `db_optica`.`Empleat` (`id_Empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Client1`
    FOREIGN KEY (`id_Client`)
    REFERENCES `db_optica`.`Client` (`id_Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Ulleres1`
    FOREIGN KEY (`id_Ulleres`)
    REFERENCES `db_optica`.`Ulleres` (`id_Ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Venda_Empleat1_idx` ON `db_optica`.`Venda` (`id_Empleat` ASC) ;

CREATE INDEX `fk_Venda_Client1_idx` ON `db_optica`.`Venda` (`id_Client` ASC) ;

CREATE INDEX `fk_Venda_Ulleres1_idx` ON `db_optica`.`Venda` (`id_Ulleres` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
